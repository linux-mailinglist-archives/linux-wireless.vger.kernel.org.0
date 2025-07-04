Return-Path: <linux-wireless+bounces-24835-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 602C2AF9C10
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 23:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A0166E17F8
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 21:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B632550BB;
	Fri,  4 Jul 2025 21:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E05ijrT/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994F7251792;
	Fri,  4 Jul 2025 21:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751665351; cv=none; b=Y4aYMlw1jc2nIzy5M2DzbRiS60Z6x93VoCrZuIywVgxsYZeI4cUO3dsGbwnsCJSCqfZN4RCGNu/sOPSE0JRIwI34YEX0oSDCdpdbBkKmqyyPNBI79W8iusvuFN2Dd8GIFsufuIDunliHQVBlfB3u+iIf5pdFXs/c6mwvfkVKs1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751665351; c=relaxed/simple;
	bh=dpPbynRkwVHFWQty5pzsyxn9U/wZNXEMsHY5SbsgQyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kbwh300m9h436Hgu4LCKra5yB7WkYvYTOs95tq0ieDR49Z2Tq1T7JDtJn+8ejWuexal6XctOrLV71EgZ2jO4ThRpFiEIxpBfguF0YR5xBNj/c34hCjty5BRpQEr9ZAB2FFhMKOb2LQrlfAQF172MYLQ75f7kab9ggT+mFDiId9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E05ijrT/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2350b1b9129so9324525ad.0;
        Fri, 04 Jul 2025 14:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751665349; x=1752270149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOs2ghS/IR2utEj/ua+XiwfQ9YUUXw0FFwdSSlwOL5U=;
        b=E05ijrT/5V4dcvFWuemEX7fIh+7VLTpBNE0+rEFvGnLabHnRKonVi9TIXxGPFIkmuy
         GZruyALrfQq+878ZQf8hPS3kRYcfTEFTz15inGkHiDqt8JavmuJ1bjtjjaYdhjQnm1wu
         mnR0Mfi4JIAaAEtJlA7LAfGDVAM93IOxnEwOuY/QZtVgSGGjT5yxcxocWkMwJJisVIkr
         nORI/G7VaWQpvXcslr0KjIP9n0HukS/wi9RIBwqw+tadoHuKVoenbseDkQqJm3fmdjwl
         lAkELujbGO65kdbNuc9YNrIuJT/YQEwGLtJeV5+VWcURsoydCqdogKQYSkRySm1sdPDM
         bQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751665349; x=1752270149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FOs2ghS/IR2utEj/ua+XiwfQ9YUUXw0FFwdSSlwOL5U=;
        b=H332zZ/sUDP35dYX4PoRsrhFDJ2lYPfxtViwHqreBN/qgS5ay7wIU8Q/76NKOhQSsv
         jnzk2W/lha9DSr9ty1mZuT31zUIxD/HBzY/VoiveZuSt+UPuuVmFFQv6FY7XxCnDLHqU
         EpypgA/czISL9n4Va7+LdXHKoeNjaVygtaJdcdY4/Tu6OoqhW6IhB2/5UBh1KbsRDwxw
         jr8CiTnXdcbF8Z7rYrYlsqdJcCbs8SmEUixyOnhOAd3Ith8q2P2cqow9fOJUQI7JJrlO
         0ifNTDkvI9CK1Ff+2YmX9wcHOSPw2Yadl6GzUljT7Q6QUNCj+IDcRN76GMRS8gRiLVok
         ER5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJHQXT94dM3rzmvhJb6gilPNBmdC8FACURuqG947/fp2+I8abYqvC8pk4P8pMSeFhLbkfMLPmAr2Dd+Q==@vger.kernel.org, AJvYcCXCSVq70fIacTwilwU11YQO/jmXi0GWLOipz8+Pnc1q7vERR+Z6EtrzDZxuCWVfhZEmHFX5HYkc+dIb6NJj@vger.kernel.org, AJvYcCXvs9y2plEfojwBcT9deQiCt7eN89M/sVpCKKOGOGrmI7z30kTNDE+I6ZC/5Dtj0lOPo10sSF1RpZDH@vger.kernel.org
X-Gm-Message-State: AOJu0YwW2uTgn8Aw+naPmmc6iGXVOVjD3LcANuaTkTP8LYJmK1KA1Wuw
	BmHpKU37qxpFs+JCKXfFaU9d+G1XoJkce8BHYW1UiGX8KOnCDZellGbopDtvUw==
X-Gm-Gg: ASbGncvKgmHhsI6AX6Cio6Fs5NBm6q0fCIwNd0N8cCIMimokkCgBGGXR4SBQ4RY1pLK
	tiaBnNOTJe99o/ixiNhrM6WD4gZkPEbEQZa3KVNRnPykCXdqai8wKkfxPKlJ08Yq+Sfka6PBTny
	An3cE6+NwI3CN4iZo13LuS14lkbja2kvXTBIE5udsPEcSTCFccXmlnt6T2UzRPALHp+8EnprqFB
	lnUTo+emGMO1uRLqA17kLMmOJLPRw93U2gVZNm5THbG81cw0NflYSo0S9Lqtl8/+10cShSwqJ0D
	rKms/9tGJa6Ww8hnBgie2hwuIKdSFaXLDNf7Qg==
X-Google-Smtp-Source: AGHT+IHozcVQz8HxFhPF3KFhVWfz3SG9d4tvnq5bnSuEJZevceJshIlgXxSbPoGx+BOp7Sm+bbZcvg==
X-Received: by 2002:a17:903:acb:b0:234:d7b2:2ac5 with SMTP id d9443c01a7336-23c85dff02bmr70326955ad.21.1751665348846;
        Fri, 04 Jul 2025 14:42:28 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c84597371sm27950315ad.207.2025.07.04.14.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 14:42:28 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	nbd@nbd.name,
	jeff.johnson@oss.qualcomm.com,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS)
Subject: [PATCH 3/3] mips: qca: use led-sources for WMAC LED
Date: Fri,  4 Jul 2025 14:42:19 -0700
Message-ID: <20250704214219.18796-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704214219.18796-1-rosenp@gmail.com>
References: <20250704214219.18796-1-rosenp@gmail.com>
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
index a7901bb040ce..ef4a08e1e35a 100644
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
+		led-sources = <9>;
+		led-active-low;
+	};
 };
diff --git a/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts b/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts
index 37a74aabe4b4..ce04e767cd2b 100644
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
+		led-sources = <0>;
+	};
 };
diff --git a/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts b/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts
index a7108c803eb3..e69a67284f6f 100644
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
+		led-sources = <0>;
+	};
 };
-- 
2.50.0


