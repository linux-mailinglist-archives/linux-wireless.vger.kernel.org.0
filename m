Return-Path: <linux-wireless+bounces-23347-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B19AC1D0C
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 08:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84921A41534
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 06:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2222472AF;
	Fri, 23 May 2025 06:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMFVoQV2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B3F22F778;
	Fri, 23 May 2025 06:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747981939; cv=none; b=ejP8OdYoj/RKzgzWt1LPPw0gB6Y0WfTWALDq6PyPRCiDLiRY8iiOHjNQ2tZRJuOfnUKNEpDec0lJmTSipXQUfktpChTvIn2XdzFkEkHLXHiZ88vzZ1KL0gpG3PdT2w0YDc1LOm11LnBSv2oF97/xwDRAJSnYFoVJhq0ukXbz+xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747981939; c=relaxed/simple;
	bh=cdjfEk0TxVg9oDhf1oyxHAvAaDRa1kSzXZ9FYjisPRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHAdNldW9fImx9JXTrLOE2evAWd8tZ1oTYPLrrrl7WiXf7ROS7vltS6ZYP0+x/cnoB0CjsROHuX6K0U4UCLcZuxEDEXOb7RYkbigeZ5t+m00e2tPub4nJttiAD+mAIS+L7zMiu5coUhTrOjPFxMeyqpfXWy7W1D2zTziv2/6oKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMFVoQV2; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7426c44e014so8472997b3a.3;
        Thu, 22 May 2025 23:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747981937; x=1748586737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGHFb7gUP10OAfy6owXqCDHPUOcpBBdWnzOXMHQ1MBU=;
        b=GMFVoQV2Z47Pf7uH2EhQbnk2QUQuYBsAU4l56IfjA4H4dsPMIdtNSCVc/cBSecrVlZ
         oohLQZq9/5kBCMkbpmGHtM2LS+gzHR6pmCBpBRK4JP7PLdpPpMCizaXHy6EmIago/q+X
         jeq/nLOzGkMOHYGzWELNjWDHPTHBwKLoT8ub5VJLt2hOl7D+5ZxIdfWJdZeZMqTtWv96
         D3jvveRYA6h0fYU5N2Nfq0CEkZYAoG4PQgzR7gV6zr1EuDEMoXXhkmvqkT1cXLOULu8v
         ceyBLkWHlEuR48XX4JM5rigrnWtSAkBrM+5DH8xylrilQlyGCQwtyg8yII3C+6mTlwW+
         86Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747981937; x=1748586737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGHFb7gUP10OAfy6owXqCDHPUOcpBBdWnzOXMHQ1MBU=;
        b=ewwpSFBohSDjUhjAFFBVmy1MQKCJj1AKqiSfHDaVtR1o2Ct1pyN24bF0U+7mksRrVm
         rgG/Ze/pOXRbiHPDDucGkvWeWvglKkT7aktyCoJhfii0UxONVOCC8nifpYnCzU4+thO4
         0zOwJbVVqtCFGoqwkH42uEYpvVJWxM35AN3BZPOarnXjKLIfjPmFlr5UGMEi4A7FnJ/O
         6kB8VaZLgu2y4m7XWl+MpcPEopx3lIAw2jG2HRoasBx2oVSLdcKfGFSVGm/n51DvzTgn
         hJeXhLUl+8OOV4move6q7X1f0okt9MwEUo1jpq+W7tpndblZ7HCPTxbU9dhJ/5XAe175
         vPFA==
X-Forwarded-Encrypted: i=1; AJvYcCULSj46GnGxXLUjDtOJ2SQBv925of0Ezur1Ej14REx7ZoARzEOBYJsG0A09vLMedWMT89AcOSubrJ8gJA==@vger.kernel.org, AJvYcCXrNDUodo849Ydcc7JwPECSOvHUNwJUeq0XemjDNJULBdfnD4ggnYgbFncZQPwnfNAXs9DlWGRcADX7@vger.kernel.org, AJvYcCXwhBA2OJR4ktButsrcapPI64mlAanX3ctfeCoBBPgIiiLNPDzLO44wgWo6g4R7PycE/1/uPIpEvOqlwk9P@vger.kernel.org
X-Gm-Message-State: AOJu0YxWDM9isXDV1K5MqBJPvU3wdX5Q90LJ6Ux06Vlz4pT6DEM9/KYe
	i7wRnC1+ExJglCTHVDYUjtWIB+CYjtKtOzQ9HzgYObtJEIO6leq2rxm3uodJ2Q==
X-Gm-Gg: ASbGncsXWEQlmQFeVoiBMjVStgBZz16s60mIqQf0yG0TtcOG++9Db5iBTEHNv5INik8
	8sc7cFf4fB5yirPDz6VHOu3PhfX/wrPnXGVgP4xJcrZVwh7lYjl6pwgiGPmXrEWr4v1IWYeyGLs
	zPY0t5ZrugrVT8y3tM9aiy1bifMcOpMtckr6TLOZTxUDaCe9t9x3rDZ+5w8FMAC0/vmkmtj5rW8
	zkQJXbv8d662R3EhxSL0IyaRIQZ4ZSbMHY7Qw0fAocoeueiNu805NBUKbdn6abrANyAQoxT3FsC
	G5y52yLDWcK0dutYKiHR/xxuYbU=
X-Google-Smtp-Source: AGHT+IG5Sx9XBjRPeqB1iftumrW6VmMG9AF6ESWyPnS+9QbMUtTRF1HDO1GfXmslGPT+1Yfz3gokXg==
X-Received: by 2002:a05:6a00:2da5:b0:740:41e4:e761 with SMTP id d2e1a72fcca58-742a98c144emr36376544b3a.22.1747981937151;
        Thu, 22 May 2025 23:32:17 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a97398f8sm12177783b3a.78.2025.05.22.23.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 23:32:16 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	nbd@ndb.name,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS)
Subject: [PATCHv3 5/5] mips: dts: qca: add wmac support
Date: Thu, 22 May 2025 23:32:07 -0700
Message-ID: <20250523063207.10040-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250523063207.10040-1-rosenp@gmail.com>
References: <20250523063207.10040-1-rosenp@gmail.com>
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


