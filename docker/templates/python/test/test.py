import tensorflow as tf
import numpy as np

inputs = np.array([[1, 2], [2, 3], [3, 4], [4, 5], [5, 6], [6, 7]])
outputs = np.array([3, 5, 7, 9, 11, 13])

model = tf.keras.Sequential([
    tf.keras.layers.Dense(10, activation='relu', input_shape=(2,)),
    tf.keras.layers.Dense(1)
    ])

model.compile(optimizer='adam', loss='mean_squared_error')

model.fit(inputs, outputs, epochs=1000)

predictions = model.predict(np.array([[7, 8]]))
print("Predicat 7+8 = ", predictions[0][0])

