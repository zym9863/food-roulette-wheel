import java.util.Properties
import java.io.FileInputStream

val keyProperties = Properties()
val keyPropertiesFile = rootProject.file("key.properties")
if (keyPropertiesFile.exists()) {
    keyProperties.load(FileInputStream(keyPropertiesFile))
}

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.food_roulette_wheel"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.food_roulette_wheel"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }
        
    signingConfigs {
        create("release") {
        keyAlias = keyProperties.getProperty("keyAlias")
        keyPassword = keyProperties.getProperty("keyPassword")
        storeFile = file(keyProperties.getProperty("storeFile"))
        storePassword = keyProperties.getProperty("storePassword")
        }
    }

    buildTypes {
        release {
        signingConfig = signingConfigs.getByName("release")
        isMinifyEnabled = false
        isShrinkResources = false
        }
        debug {
        signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
