import os
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3'

import tensorflow as tf
import numpy as np
import time

num_points = 10_000_000

current_time_ns = time.time_ns()
seed = current_time_ns % (2**32 - 1)
np.random.seed(seed)

points = np.random.uniform(-1, 1, (num_points, 2))

labels = (points[:, 0]**2 + points[:, 1]**2) <= 1
labels = labels.astype(int)

split_index = int(0.8 * num_points)
train_points = points[:split_index]
train_labels = labels[:split_index]
test_points = points[split_index:]
test_labels = labels[split_index:]



model = tf.keras.Sequential([
    tf.keras.layers.Input(shape=(2,)),  
    tf.keras.layers.Dense(10, activation='relu'),
    tf.keras.layers.Dense(1, activation='sigmoid')
])

model.compile(optimizer='adam',
              loss='binary_crossentropy',
              metrics=['accuracy'])

model.fit(train_points, train_labels, epochs=10, batch_size=32)

loss, accuracy = model.evaluate(test_points, test_labels)
print(f"Test accuracy: {accuracy * 100:.2f}%")

model.save('circle_model.keras')

