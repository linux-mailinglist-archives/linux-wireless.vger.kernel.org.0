Return-Path: <linux-wireless+bounces-23389-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB41AC3712
	for <lists+linux-wireless@lfdr.de>; Sun, 25 May 2025 23:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F9B118942D4
	for <lists+linux-wireless@lfdr.de>; Sun, 25 May 2025 21:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524BE1E00B4;
	Sun, 25 May 2025 21:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJ18sf8w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F6E1DE88A;
	Sun, 25 May 2025 21:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748209388; cv=none; b=fjXThG53jS9OFHb5ArD3WO08fjHFJCWeJzPQ8DFUTN0bQ87wAlRM8ooNi7MZ4Niyye8SZnFgaKBkXGVk+wnzqNObCQB3hv7K+jR6Vs5rJm7IUjEVGQzKkSXsOaN9dZpfSf1fyqkQTMbQ8OsjurLIsQtd1I0Ygv2oorzfbrks5tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748209388; c=relaxed/simple;
	bh=cdjfEk0TxVg9oDhf1oyxHAvAaDRa1kSzXZ9FYjisPRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbXV5cB9GAE9FVD53E7PrQx4mR7w5PXST1ftMX5Z7ukcW0fpukPdWYvRMcaGHP4inBthky7jjqxQIUm7Zd+vLXQ/W0B3cFEWsgzd9aPh3PN5J2dIoPIZ9Of4lryUDZRIIZxQ8V5xOM03AUJpPVYF8/3wFDpagxzkohpAscpxM88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJ18sf8w; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22e09f57ed4so20109885ad.0;
        Sun, 25 May 2025 14:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748209386; x=1748814186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGHFb7gUP10OAfy6owXqCDHPUOcpBBdWnzOXMHQ1MBU=;
        b=kJ18sf8wXsGsGamLvvqggDxZQ0RJvO5fGsEN5gU3e7MyiRZTtSOTM1nwZhjV18jfXb
         +lYhA/edJfSs+KubPkOgedWieu/B60CiXo9O8Y+aYJHti6yx3RiQTMXZ4xQ4AWnN7iKK
         ehzPv1QgTW0FkreBQ6mY2WbeWPiOoS0S4qF0IC8S4rf34u0gq4oqUjmEGMJHsywh79AV
         OD92wN20R0YKV8paEILvNBgRxOZKzIoplBFMqG4pmQJ+a3FlIs9UC/pP64LaHUwiINOO
         1hi07nooSRwgkHqR9RNwJ9hkH/bqQ+KQuRQpFwXRAptvOaH7eLBP5JCkORomfxbJ2IMq
         1W6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748209386; x=1748814186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGHFb7gUP10OAfy6owXqCDHPUOcpBBdWnzOXMHQ1MBU=;
        b=lZ8FJLKIn0AF6fQv45c4EhfO9xvn/U+phVEbmEm9gE6l6CL0Gl7v3x06dQhth5qD0E
         vduuCVd7GI9xSnk3nqBfYghRUuHRwHdSxVx06GbiE61voeI9puFyDFCknyIv0CnucvRN
         68eHH3yw9e3zLCfg8rtPqfbjj1ZUgAI11/5Kk+B8cfQKIHGU1UO62a5pw/yboQzxD8Cr
         yfjdrVPTb/UD5UKOgfv19ARMcp9PFPEFxqINIlXiTv2wcXmlfTfxhbVVkw2QEoc0Q5bU
         gpZN4+hZ+ZHCuqakQvcloipIAFXFoxrb1yfRr+dDEtf1IPinExLAoKzeoLQ/4xXdoLwO
         nz5g==
X-Forwarded-Encrypted: i=1; AJvYcCVQEnTtyB7faSUfxsyZHmklT2AETRLXqIZcg7iYCLp4a2BLmuVL73NY9gNNBP2IXhoESHTNxBl+ytrDWA==@vger.kernel.org, AJvYcCWC8jaEo7Pqg9ZZHwP3vaSHxM/AdT12jhNFcjFVpdKaf66oFykU8s3KGkAtTxKY+iZPZihpuLMd3B/34QqP@vger.kernel.org, AJvYcCWZwYZy28qLwXVeFJJqv3sXbJb9AB0EqP4XaJ0rfRTlfeDaNrcYZICsJN+kWR2shMGzhe5dwieQkQtW@vger.kernel.org
X-Gm-Message-State: AOJu0YzcMgf1r6xTLnkBc4rWbWht1BPfS/BXyC9MG2FmuMnebHfCLOgA
	XPgTbolnO+M0CTVCPmX91XAHgMFmaGgNrX5+LmsTgKy7mu9UjS+ieoFD/czbUw==
X-Gm-Gg: ASbGncuinSyRDiGDvkv5KxQBAFsIBKGv1sP7wPXj0Rko7V/FHWMXRNPLmXylTeflqvp
	mvSuPiBTE4x333O+wOk08B/cCbXc45lIPAf4/H+XZ8JldMrt0QPbF/e8HY3VMpqf4OfUKoZRHwl
	jyj8/hkJMm2Hwu9hPcxJn3fyBeHTnKAgf9cUq+pxkzxDypMnQ4a1E8oJPAaPM6S8dOOc5bwV6OR
	hzpt8Ioi+mCw2H+T0L89vR5ALy+tgm52bIe3zBpHg9P+H2isJg//A6vgDi97lHi1QAiwJKZX77I
	+SjabqS92AUVX0yhsYUka/TE6MA=
X-Google-Smtp-Source: AGHT+IGG2n4FFxLaod1P2AsWQRwFGmEd2pPt57Kkzhx7ICSNdABPH0DrtVIa7Anz+1Ewj7mFcWANEw==
X-Received: by 2002:a17:903:46ce:b0:233:fd7b:5e0d with SMTP id d9443c01a7336-23414c75f29mr112147665ad.5.1748209385892;
        Sun, 25 May 2025 14:43:05 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2340934d91asm35083115ad.166.2025.05.25.14.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 14:43:05 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	nbd@nbd.name,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS)
Subject: [PATCHv4 5/5] mips: dts: qca: add wmac support
Date: Sun, 25 May 2025 14:42:56 -0700
Message-ID: <20250525214256.8637-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250525214256.8637-1-rosenp@gmail.com>
References: <20250525214256.8637-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that OF ahb support was added to the ath9k driver, we can use it to
enable and use the SoC wireless found in these chipsets.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 arch/mips/boot/dts/qca/ar9132.dtsi                       | 9 +++++++++
 arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts         | 4 ++++
 arch/mips/boot/dts/qca/ar9331.dtsi                       | 9 +++++++++
 arch/mips/boot/dts/qca/ar9331_dpt_module.dts             | 4 ++++
 arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts           | 4 ++++
 arch/mips/boot/dts/qca/ar9331_omega.dts                  | 4 ++++
 .../mips/boot/dts/qca/ar9331_openembed_som9331_board.dts | 4 ++++
 arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts              | 4 ++++
 8 files changed, 42 insertions(+)

diff --git a/arch/mips/boot/dts/qca/ar9132.dtsi b/arch/mips/boot/dts/qca/ar9132.dtsi
index aa148d51ab68..47bddd36cd94 100644
--- a/arch/mips/boot/dts/qca/ar9132.dtsi
+++ b/arch/mips/boot/dts/qca/ar9132.dtsi
@@ -155,6 +155,15 @@ spi: spi@1f000000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
+		wifi: wifi@180c0000 {
+			compatible = "qcom,ar9130-wifi";
+			reg = <0x180c0000 0x230000>;
+
+			interrupts = <2>;
+
+			status = "disabled";
+		};
 	};
 
 	usb_phy: usb-phy {
diff --git a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
index f894fe17816b..a7901bb040ce 100644
--- a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
+++ b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
@@ -108,3 +108,7 @@ partition@2 {
 		};
 	};
 };
+
+&wifi {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/qca/ar9331.dtsi b/arch/mips/boot/dts/qca/ar9331.dtsi
index 768ac0f869b1..9a2590f490bb 100644
--- a/arch/mips/boot/dts/qca/ar9331.dtsi
+++ b/arch/mips/boot/dts/qca/ar9331.dtsi
@@ -285,6 +285,15 @@ spi: spi@1f000000 {
 
 			status = "disabled";
 		};
+
+		wifi: wifi@18100000 {
+			compatible = "qcom,ar9330-wifi";
+			reg = <0x18100000 0x20000>;
+
+			interrupts = <2>;
+
+			status = "disabled";
+		};
 	};
 
 	usb_phy: usb-phy {
diff --git a/arch/mips/boot/dts/qca/ar9331_dpt_module.dts b/arch/mips/boot/dts/qca/ar9331_dpt_module.dts
index c857cd22f7db..08e728b8ced8 100644
--- a/arch/mips/boot/dts/qca/ar9331_dpt_module.dts
+++ b/arch/mips/boot/dts/qca/ar9331_dpt_module.dts
@@ -97,3 +97,7 @@ &phy_port0 {
 &phy_port4 {
 	status = "okay";
 };
+
+&wifi {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts b/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts
index 7affa58d4fa6..37a74aabe4b4 100644
--- a/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts
+++ b/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts
@@ -98,3 +98,7 @@ spiflash: w25q128@0 {
 		reg = <0>;
 	};
 };
+
+&wifi {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/qca/ar9331_omega.dts b/arch/mips/boot/dts/qca/ar9331_omega.dts
index 8904aa917a6e..1450419024cb 100644
--- a/arch/mips/boot/dts/qca/ar9331_omega.dts
+++ b/arch/mips/boot/dts/qca/ar9331_omega.dts
@@ -74,3 +74,7 @@ spiflash: w25q128@0 {
 		reg = <0>;
 	};
 };
+
+&wifi {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/qca/ar9331_openembed_som9331_board.dts b/arch/mips/boot/dts/qca/ar9331_openembed_som9331_board.dts
index dc65ebd60bbc..5786a827c000 100644
--- a/arch/mips/boot/dts/qca/ar9331_openembed_som9331_board.dts
+++ b/arch/mips/boot/dts/qca/ar9331_openembed_som9331_board.dts
@@ -106,3 +106,7 @@ &phy_port2 {
 &phy_port4 {
 	status = "okay";
 };
+
+&wifi {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts b/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts
index 10b9759228b7..a7108c803eb3 100644
--- a/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts
+++ b/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts
@@ -114,3 +114,7 @@ spiflash: s25sl032p@0 {
 		reg = <0>;
 	};
 };
+
+&wifi {
+	status = "okay";
+};
-- 
2.49.0


