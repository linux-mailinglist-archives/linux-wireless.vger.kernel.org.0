Return-Path: <linux-wireless+bounces-23325-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A64AC13A4
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 20:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E7E03B7A4E
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 18:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4E01E7C0A;
	Thu, 22 May 2025 18:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HI4aHLJX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957171E51E7;
	Thu, 22 May 2025 18:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747939528; cv=none; b=jxBgAq1ROmbR33pvJMLIhsDzLl+5iFXsqKRw5N+Qzz9azLdYfoX1UjrT1IlRtd9dyVwio1TyJnzQpH1ehoZi9kTm+9lkv5XXX7ihLtSqE353AUa4lY8Le6zl8pYvqBkrtAhkRt0DVBzacMpv2Rft7cwSt3OUv9rZ8g2hqNO9Ojs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747939528; c=relaxed/simple;
	bh=BFRbGoEc5W5rLHmZZkvGIPUXgbuPDlOSs8WMuYfd1aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJjjAn4Bms5Qf2JTL1PmFc5LfX2FozA9LZ3Xme7cN36eHE2Fy7/9iufJ9b8lw7UFeodgRhGyv/qtBxqjXkEONZOe/lCTV0RC12uy7x5wYzN+0F6F/GjAZM/FepYeywgi9LpsXDRQ5/pcYhtFO/zTUXbqDpjA3R1MbyzH6Eq0P8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HI4aHLJX; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-742c035f2afso3746603b3a.2;
        Thu, 22 May 2025 11:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747939526; x=1748544326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyt9uwHd4+RYMzj8npffGoqsAHc2tpibuqss5RIQiwc=;
        b=HI4aHLJXj7qZ/dkoq7Yihzd7fHIHsVQDAYV7q0qSVxTjbj/E4YdqwCCf9Q9bQrp6Gq
         lID26HWFMSbbimeZy/GrapMJiRljEFRJFeehbejsUXfUzjVx8EqhqedfBrRUKVjWN9Dh
         sAOZlwhKNDXs64suRYCR/xV+bqpybz1l02qeb7qZ61HjtDZyqWNYrEQ1i+J5TdgeP9BZ
         dOMDReZCtf9Ca6ZWTDGhOwTw+Rr+rdDVe7+sju4vDp9pSXD9bQRR2h3Ioo1/xu6Ea7Nh
         /Hd8lY9olYLRE5tu1CeL3qwS4Ba9A7nduD7Q0RtPvJ79yJEEI2/gt3GJjo+KFbukMDA0
         Kwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747939526; x=1748544326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyt9uwHd4+RYMzj8npffGoqsAHc2tpibuqss5RIQiwc=;
        b=TryRh9IUnAp4MRSiNdsxo/UJqkTqT6a6JUR20xkiaK/8iZ4ipfcHesYbVBDnFydKJZ
         gf2Q7kkivLKe5T5c4ksQ5I1hFbxCVviHzBEz3iGkLk335ijVuSTi/F7PmNny62UW1Ca8
         BmshO9v3vKxcZY3PmNAN2SbNFc7Zp436o+ox79uErIkPTKYZlWHD5lFZ7RUmlomqq1jk
         FGOZGA0J0h+Zo0zVlXyHQl357HGyP2O8TEy77Ngo9lsSSZNloOcCgK8xvbeV1GwBp6nE
         VPW3RHkaYimTMgUyM+mbsfnvfwTeljQj2XeMDyk+4+Hm9IE6qlSjGbmAuDWcA4AVbMpU
         MzbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOw7nt93fWlmwMhHpQHg2vOW1AsbD+Yn/AY2OkAOd/lQu/8WicBahAiveNDWvZ+KCCtFmWIHWLxPUqi/NA@vger.kernel.org, AJvYcCV1Ud/wRh/9XoyJAHUJ4mZ+q0gfb82P1RUns157S9vReBW7bm96WWWSkgQm4mCq9O94/S+v/4X+fpsnQw==@vger.kernel.org, AJvYcCWbZdtPPpcATD/YyrsDKuCiFhHRCYFYiS7/kz17QyQR5iRYVUQ1MoRt2NQQoObNoV+k7iGAocRUc/xB@vger.kernel.org
X-Gm-Message-State: AOJu0YwhHzQ71lBpghoA91Zt9NoARBphVWDlE1GC/HqWxvYFp9agjo7o
	j1vjlCgt7jcsWheWN02D8/Gg6+mv41PCyOUEA24yzAM9VPOiAMXKWE0FZDzemw==
X-Gm-Gg: ASbGncvDeY5vfMaOd+i29U2h7KRzz9FU0U9Vvp2Sw0+ypcUaRVaFdNdg8mKUs3j/kIz
	g4OkgKR9t/O6XBmgps1vhZsg5g675Klg7XuTdjwNyQeA+Rqz1chBesaanmxxJF1P3IQgXvKCG/X
	GPzsH2NvXswzU1RYCJVxJfTFeZ4TfAgcIJZJTsuC2w6AQPug3NB53aaKlyt21nAvL6LtzoIOT+7
	gjR7U5mMdPATljF5V+D3TBUZzzqpOHoxfwtzMYu9nwOkdLNkYXyh6UxqWuuYuAzFZnFAWK401kR
	HBQzXGf0lFDlAgvnY534RHRRJwWPwCdSfs0ZmQ==
X-Google-Smtp-Source: AGHT+IHlRfUeJFXKT8VPz4SbS6Ht4Q1UlP58AjhLNNeH1/56VeLcQfpbUrSMG0l0fyciuG7qANDqQw==
X-Received: by 2002:a05:6a20:d50c:b0:1f5:8a1d:38f3 with SMTP id adf61e73a8af0-21621873f17mr44054155637.2.1747939525664;
        Thu, 22 May 2025 11:45:25 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf6fd3bsm11502424a12.23.2025.05.22.11.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 11:45:25 -0700 (PDT)
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
Subject: [PATCHv2 5/5] mips: dts: qca: add wmac support
Date: Thu, 22 May 2025 11:45:16 -0700
Message-ID: <20250522184516.13176-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250522184516.13176-1-rosenp@gmail.com>
References: <20250522184516.13176-1-rosenp@gmail.com>
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
index aa148d51ab68..27462dc97fc5 100644
--- a/arch/mips/boot/dts/qca/ar9132.dtsi
+++ b/arch/mips/boot/dts/qca/ar9132.dtsi
@@ -155,6 +155,15 @@ spi: spi@1f000000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
+		wmac: wifi@180c0000 {
+			compatible = "qca,ar9130-wmac";
+			reg = <0x180c0000 0x230000>;
+
+			interrupts = <2>;
+
+			status = "disabled";
+		};
 	};
 
 	usb_phy: usb-phy {
diff --git a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
index f894fe17816b..7df518fdc515 100644
--- a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
+++ b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
@@ -108,3 +108,7 @@ partition@2 {
 		};
 	};
 };
+
+&wmac {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/qca/ar9331.dtsi b/arch/mips/boot/dts/qca/ar9331.dtsi
index 768ac0f869b1..bce4dcac3d54 100644
--- a/arch/mips/boot/dts/qca/ar9331.dtsi
+++ b/arch/mips/boot/dts/qca/ar9331.dtsi
@@ -285,6 +285,15 @@ spi: spi@1f000000 {
 
 			status = "disabled";
 		};
+
+		wmac: wifi@18100000 {
+			compatible = "qca,ar9330-wmac";
+			reg = <0x18100000 0x20000>;
+
+			interrupts = <2>;
+
+			status = "disabled";
+		};
 	};
 
 	usb_phy: usb-phy {
diff --git a/arch/mips/boot/dts/qca/ar9331_dpt_module.dts b/arch/mips/boot/dts/qca/ar9331_dpt_module.dts
index c857cd22f7db..d855dfe118e6 100644
--- a/arch/mips/boot/dts/qca/ar9331_dpt_module.dts
+++ b/arch/mips/boot/dts/qca/ar9331_dpt_module.dts
@@ -97,3 +97,7 @@ &phy_port0 {
 &phy_port4 {
 	status = "okay";
 };
+
+&wmac {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts b/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts
index 7affa58d4fa6..679e793e9f55 100644
--- a/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts
+++ b/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts
@@ -98,3 +98,7 @@ spiflash: w25q128@0 {
 		reg = <0>;
 	};
 };
+
+&wmac {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/qca/ar9331_omega.dts b/arch/mips/boot/dts/qca/ar9331_omega.dts
index 8904aa917a6e..093142bf3ed6 100644
--- a/arch/mips/boot/dts/qca/ar9331_omega.dts
+++ b/arch/mips/boot/dts/qca/ar9331_omega.dts
@@ -74,3 +74,7 @@ spiflash: w25q128@0 {
 		reg = <0>;
 	};
 };
+
+&wmac {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/qca/ar9331_openembed_som9331_board.dts b/arch/mips/boot/dts/qca/ar9331_openembed_som9331_board.dts
index dc65ebd60bbc..22e05d9c283a 100644
--- a/arch/mips/boot/dts/qca/ar9331_openembed_som9331_board.dts
+++ b/arch/mips/boot/dts/qca/ar9331_openembed_som9331_board.dts
@@ -106,3 +106,7 @@ &phy_port2 {
 &phy_port4 {
 	status = "okay";
 };
+
+&wmac {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts b/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts
index 10b9759228b7..b740f1a91162 100644
--- a/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts
+++ b/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts
@@ -114,3 +114,7 @@ spiflash: s25sl032p@0 {
 		reg = <0>;
 	};
 };
+
+&wmac {
+	status = "okay";
+};
-- 
2.49.0


