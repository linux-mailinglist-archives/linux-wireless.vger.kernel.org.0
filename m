Return-Path: <linux-wireless+bounces-23197-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD119ABE9B5
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 04:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF9074E46D5
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 02:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FB722F77A;
	Wed, 21 May 2025 02:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgG88T2I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC1F22F173;
	Wed, 21 May 2025 02:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747793768; cv=none; b=N5r43M6bd1MD6vBW3FfXF2hkddT8GDjGoehlC4x42BrcBeVmFDLs4QSv2OK/WeE20EgthUEyL4YVRdfMRnBWYe82o+tgLuSPUOHkeFqpWBHzt9nq38BhTHnaXgpL++lyA0CPTbcocXHohFt/9BLKrDHCIyyIprxX64fIjdZ/gvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747793768; c=relaxed/simple;
	bh=gpdmefgU668pK6VStjJQagzuktgRSMx2Yg1xIRvuc/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZ87g1aOjfna4n235eWvyFmV8Qx/BRbwM4oofofUQqEjfl0pkIpqiRYqpPDfKCLuBkj8VNAwtp91PZ3F8HxTSGvXjDWVL+ek6Jxfs6MQw27erUWJDngwP+BzJzMp1sZiIFNVV0Sypr7b93p7pLawpB1CTPaX9xPb2YOLUrFgL3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgG88T2I; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-74267c68c11so5460333b3a.0;
        Tue, 20 May 2025 19:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747793766; x=1748398566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZW5CcwPkMleb80Fmd+SX38Kmt5DxqWa4H4ElhnYX7E=;
        b=HgG88T2ITSWCMqsVMbZyBCVZT/IWdge+Jb6YjTFe8rUv9yrIjZcT0UmkACVObqdt+K
         nTKSLHCQlWscSGN3dFqnD5HXtZiuFug+/jafaacXho9LpUgPz8Y27kU27H4U4mrZOIRU
         nP7+HVOpBKWYt4zFhvN9jUZR6fy/ccfw9jZeQYpDMsqPx6GLaglWKtPH7ADcoWVvmtYk
         ck25QNEhCTmGbbX5+KO1eQXyBuATgeEMV7XNdwYoAuRXafJDz6yMkMPNkAqWCy8sZH+U
         HUyHZqbRUocjVo7BEJ7f9ZJ/i0U24Reedcoztwho503wss2Ag0MbyL54t0nbBL7XoQqx
         p+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747793766; x=1748398566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZW5CcwPkMleb80Fmd+SX38Kmt5DxqWa4H4ElhnYX7E=;
        b=EeCgV1asKCWEPIrMqrf68s+kP4c8kYGoROIUBporctLkIv/GN7WUJLQvLM6+FOOEfw
         NUEPvtbsmkYucZLLyD91sXXLE5s/zJZ6D9QbGDTmjD47zQXn7HdyPbYl9jVmXh/s+NLz
         o3zzWK0JMTe1wN1ltNY13gjW+kkkzLlvY77HkUEiIstLUlRRuKpdbBJNhmMZsxScS7IH
         +4DIFal+saRanLl+JNEYG0bX9aWczRRB5Z5Rqc6uhklIXo+i/fgMRbGZBgAixRdN/Tx3
         +CUiF514ii+hdA4RfEM4k3q0tpcora1j1I2AoUGCe3eibM74eywSYT/9BQ2WPS+310L/
         FaZg==
X-Forwarded-Encrypted: i=1; AJvYcCVtEh0CAmOesdV3Hd6QnX+9FwVjJpzIqLNN4ZUvzPG1nrpAWLydO6P5mCqu3okcMcg8jwODor2Wp7Px5A==@vger.kernel.org, AJvYcCX/PjHPgadduwthlOvzCM/qgthBtEcn6Opx71+Fbo1TBtqriNxoLR5+GVx23JclHh5YbIIMTNgY4BzG@vger.kernel.org, AJvYcCXPQB5vvQAFgUYy7AiKUVWcTzV1ZwB1OvPOwdDbCj//l/ygOUdETHj1IxIjWLMPs/hvPYXZdMtxdeJXGibi@vger.kernel.org
X-Gm-Message-State: AOJu0YzawgQ3WCM2bZzXKoX61Shn1dawFLdww3LiD18++qai074Vnpgk
	2bgCNw2gta72dR5w+DwkPekNlSOAMlLMvNLt6C/Pf3bLnQVABPk/HGed3iXpEw==
X-Gm-Gg: ASbGncvyrwljTAA/snanStCiQHom6Fgwv8oWdYRp9sIrxGH40qf9JY/V3wUONDEN/nC
	JUPA5klVgGGLabsowGL+zzQkHoi1r4GKQz+kFELAwgzn2HhN8fgmD8oKhx7pbjSc0e9yh8ktPyu
	i+LYho7jFfxMC3M2dEOcfL2KrwU9hVDb2dJK0llsOiYei6bpfaQABRSyoi9ZFMgUXaju7cMLwyv
	Q+UvcwB5ZdXaO0THs1BfJ09/mp5fbg/K6RPFKqnPEu5zTexxFsuJ6oDeGzO2NhQK8D7Gmm0VfNZ
	ZQjpf9Xwyj73+otGeEjDRur7LUg=
X-Google-Smtp-Source: AGHT+IGmo9M9l+Htn3g//UzeHH0APFPDedj/h9cUeRvzIihHZspqVATX5aQM/GWiGZyDH+UBp9tA8Q==
X-Received: by 2002:a05:6a21:4606:b0:1f5:9016:3594 with SMTP id adf61e73a8af0-2170cc65e25mr29445068637.18.1747793765653;
        Tue, 20 May 2025 19:16:05 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb0843d1sm8758473a12.49.2025.05.20.19.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 19:16:05 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-mips@vger.kernel.org (open list:MIPS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/4] mips: dts: qca: add wmac support
Date: Tue, 20 May 2025 19:15:57 -0700
Message-ID: <20250521021557.666611-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521021557.666611-1-rosenp@gmail.com>
References: <20250521021557.666611-1-rosenp@gmail.com>
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
index 61dcfa5b6ca7..dc94459aa3e9 100644
--- a/arch/mips/boot/dts/qca/ar9132.dtsi
+++ b/arch/mips/boot/dts/qca/ar9132.dtsi
@@ -156,6 +156,15 @@ spi: spi@1f000000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
+		wmac: wmac@180c0000 {
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
index 768ac0f869b1..4cd55f765e1f 100644
--- a/arch/mips/boot/dts/qca/ar9331.dtsi
+++ b/arch/mips/boot/dts/qca/ar9331.dtsi
@@ -285,6 +285,15 @@ spi: spi@1f000000 {
 
 			status = "disabled";
 		};
+
+		wmac: wmac@18100000 {
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


