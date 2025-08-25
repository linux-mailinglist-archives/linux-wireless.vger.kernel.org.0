Return-Path: <linux-wireless+bounces-26573-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D33DDB335A7
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 06:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADFA2166D7C
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 04:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240F027A455;
	Mon, 25 Aug 2025 04:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+T7JBBE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9886F157A6B;
	Mon, 25 Aug 2025 04:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097302; cv=none; b=u1GMMWOy0veQRDjyRZEvXvgaQhS+rzK7tQlWZSukDDP790RN/58EKKUoB5FhHHodVPgSOYXkPA2mtVxQeaEOwO2QPRTV0ok0APeJiLkXRStLSC4EuNfDX0gjpbPJzr9DSHnuwBi6pQrBO/7fs41cqjeAQANxgmOxV75ZyyAiwK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097302; c=relaxed/simple;
	bh=JU3dr+Crf9Xb9K7UG3kzrtxsMTafuGut+zNbA4vOTaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zyzt1FB4FMWXLk65nu3ZRqfOxmTehFRN8RF7gjwxl8gKs2YEW9EvFHoahxQE39fwPjrjZg24n8VFYCAgKf7Tb4xwvYUpuBLjZwk8RMKkgiSmwkDmqq+azdIUrLJWHuYEGJeUR8FbMMK0zjet9r2M5shhpUbm8t2Xi64vvwvKuZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+T7JBBE; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-770593ba164so483217b3a.3;
        Sun, 24 Aug 2025 21:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756097298; x=1756702098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAMPXkeC97be5vrkWMOP6D7jQs9OWhWX6Txvw9DQCp0=;
        b=K+T7JBBEh9NKUZclytIfMmGBHySN2xVqIhXJ6J8hD2NLh697lGwp2akvo+BNvw/aSR
         PK/kp4LJF/OeeA2LLkBzvgdKQ7CTzZ6sfmy8zriPvKb+c5gHhdflYraRNkoKSpCer4hm
         UraWjQP0NfiAKdxO4NSzBsXj6KNHqXPAWX0J7go5bFXCjTTesPGM4j2ACgl49Qza1ERs
         Gw1jFRnBBgoSALBbvCLpmOYxnJxTGWKLtl60/1ru9eJlseOVv3ejPTEq0SHxoPh08GLB
         TEPkNxQSK4mujRNS6AA8Z5yoCZdiLqP0KU7qOf/HAPqB0AGCq/Xih6C+/QeytgNYLeUY
         QUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756097298; x=1756702098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAMPXkeC97be5vrkWMOP6D7jQs9OWhWX6Txvw9DQCp0=;
        b=TUOW4XYNLDhvwBDv0daBfnXux8ek1UUWb9ZMxCYHi71lyzoyQ6GKKFR2QdICyak1XV
         ENWrBlrjQ8u1YLgOXC36Le0iGteepZwWNOlsjpKbARVU+6rFmVNmFlTaNQBJHN5M4sxA
         fyKkzdyNuUqMHKxchHqEMfzu6C3EtOzlMqj6AqYWeAAPjOO9ymGk+6oO50UU/EABZAtS
         jihgBQBigsOvs7JMHPx9ctvnaUIYdHOGF/XfpaR3kqQCSIRNMccXkQwDC8f9Y+fU6Bbj
         8WSC0tXVl0WgldGvEg+lX89rpZIqWECa40fVSHuNcXbMYUZcAEHdWxkaDVVk++0IMCsb
         jAVA==
X-Forwarded-Encrypted: i=1; AJvYcCUFsJzeszoPtzgSuHUALp0YnLU30mrr1xh8CBkCKyVV0UFRTEg2YT9BoqeMC0ltrObMaHDU4KTS2F7oFvo3@vger.kernel.org, AJvYcCWxDEvEgLYaxCQce/kWy6BQVotHFfkiuwCWnDRsXU8cM9oFJ65m8nWvK/bGy8kJnHqa6CxIWcUZTlICqw==@vger.kernel.org, AJvYcCXKj8Fn/g/etVm2nhJJ0LKyVU28OSwO011BBYzbsom7DuWHARVNxuWwF7TppRv4b0iopKvOAIQIUsNb@vger.kernel.org
X-Gm-Message-State: AOJu0YxWR4gPYa3VA5YGBgZHLCWCayy6Y2Mur+kV+tYjXPm6kKJPUdiX
	e0X6QkJob6Zd1imRm75Ka1q/sHxT4rjJvwlNggEusNmekEIWod8AWzzuyo+h5w==
X-Gm-Gg: ASbGncs5MjBL66uzPOSRfoHd3gI80v5oe+U+LfQKyHoYFuaTRy4wogIw9jYZF/MgwSy
	YRHMo/GYG8wYDILIKRlkE3b+alc6uQ8FtoErXXQ1+rmBn8V0XlXGVF/3p1M9aG20yYsezq6bxGw
	nYNNEIX215cM63PztSDABV3MJLUJMYYeQgAJIspTZIFvNWB+PPwYVOjvwCAy+YXZ1dzDPC7bxkE
	JYnXv+FTnYBHmYVfy6yt2WxrS7os/qyi1q95ue8vl8xp65vfhRRuR+T9mQYtoqG0GiVxCFUHmQW
	QCIACWYjV+UnIftIiVydVwIDCxnriC8uD3lOHto+BnZeNZY5E0BDh74ZmAnr7xiX6asuxGL+53A
	4oXurMvBDGULfpge6FLJ86EPldD82hTtFrEQiQdEd3rIYPaOVs7y7jWZbb4u7bRwpSQ==
X-Google-Smtp-Source: AGHT+IFKZgC1m932btQWv8Gf0WVJ37bnqGo81hNXn7RxLwN8+R9zEHEuyeQdeaOzQGZMRlq2gnkSvA==
X-Received: by 2002:a05:6a21:3383:b0:232:36e3:9a4e with SMTP id adf61e73a8af0-24340d40cd3mr15836463637.40.1756097297648;
        Sun, 24 Aug 2025 21:48:17 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:acc7::1f6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770400010a1sm6170153b3a.43.2025.08.24.21.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 21:48:17 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS)
Subject: [PATCHv3 3/3] mips: qca: specify WMAC LED directly
Date: Sun, 24 Aug 2025 21:48:12 -0700
Message-ID: <20250825044812.1575524-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825044812.1575524-1-rosenp@gmail.com>
References: <20250825044812.1575524-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ath9k driver creates an LED unconditionally being driven with
sometimes the wrong pin. Not only that, the current dts definitions have
LEDs for the WMAC that do not behave in response to it. Fix both issues.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts | 10 +++++-----
 arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts   | 10 ++++------
 arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts      | 10 ++++------
 3 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
index a7901bb040ce..344e1a2ee6ea 100644
--- a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
+++ b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
@@ -56,11 +56,6 @@ led-2 {
 			label = "tp-link:green:qss";
 			gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
 		};
-
-		led-3 {
-			label = "tp-link:green:wlan";
-			gpios = <&gpio 9 GPIO_ACTIVE_LOW>;
-		};
 	};
 };
 
@@ -111,4 +106,9 @@ partition@2 {
 
 &wifi {
 	status = "okay";
+
+	led {
+		reg = <9>;
+		led-active-low;
+	};
 };
diff --git a/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts b/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts
index 37a74aabe4b4..573ca7752698 100644
--- a/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts
+++ b/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts
@@ -22,12 +22,6 @@ memory@0 {
 	leds {
 		compatible = "gpio-leds";
 
-		led-wlan {
-			label = "dragino2:red:wlan";
-			gpios = <&gpio 0 GPIO_ACTIVE_HIGH>;
-			default-state = "off";
-		};
-
 		led-lan {
 			label = "dragino2:red:lan";
 			gpios = <&gpio 13 GPIO_ACTIVE_LOW>;
@@ -101,4 +95,8 @@ spiflash: w25q128@0 {
 
 &wifi {
 	status = "okay";
+
+	led {
+		reg = <0>;
+	};
 };
diff --git a/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts b/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts
index a7108c803eb3..6891d9589b68 100644
--- a/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts
+++ b/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts
@@ -22,12 +22,6 @@ memory@0 {
 	leds {
 		compatible = "gpio-leds";
 
-		led-wlan {
-			label = "tp-link:green:wlan";
-			gpios = <&gpio 0 GPIO_ACTIVE_HIGH>;
-			default-state = "off";
-		};
-
 		led-lan {
 			label = "tp-link:green:lan";
 			gpios = <&gpio 17 GPIO_ACTIVE_LOW>;
@@ -117,4 +111,8 @@ spiflash: s25sl032p@0 {
 
 &wifi {
 	status = "okay";
+
+	led {
+		reg = <0>;
+	};
 };
-- 
2.50.1


