import os

os.system(
    "flutter drive "
    "--driver=test_driver/integration_test_driver.dart "
    "--target integration_test\end_to_end_test\end_to_end_test.dart "
    "-d 063e908a0411"
)