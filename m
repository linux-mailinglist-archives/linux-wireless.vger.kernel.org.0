Return-Path: <linux-wireless+bounces-20785-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1601BA6E54A
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 22:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F4C4189D394
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 21:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2CE1F1518;
	Mon, 24 Mar 2025 21:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=conclusive.pl header.i=@conclusive.pl header.b="gjQCKM5R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE48F1E2852
	for <linux-wireless@vger.kernel.org>; Mon, 24 Mar 2025 21:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742850666; cv=none; b=JRZEHOFdK6vi+3zNMYSMs5AsT/04SoiPwgyCWnQLimvmxJVN22nEtcnA2PsxwUNZHBLZNDdmtmbkt80ewro48RhNkjUpa0O9kKaQwgnBWjMIPbICFaE4L2xUL1MXvQMnnYenm/LES0aUm09hiMhAKf58VPzbHymT3Bbz+S6CZng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742850666; c=relaxed/simple;
	bh=4RQgTHTB8Ct6Xa+I+6KGuh64DGDd4HkaTwvKvZHrn6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jY1cir4cr3/vMXEe+OYuvqHUVpTc23DeUtxIDRmKsziUrEjibVFPdwfF3FRHPBOxsiYGYNjMxn5zpzfop29O5yD8Ky/9nyRz/KLq1LVv2JhVVe34gyLuebMtevtIuWNr/SquOkGE3sohcqwmqJSSWHow5xjPCcwBouy2p73vQQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl; spf=pass smtp.mailfrom=conclusive.pl; dkim=pass (2048-bit key) header.d=conclusive.pl header.i=@conclusive.pl header.b=gjQCKM5R; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=conclusive.pl
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e8be1c6ff8so8673739a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 24 Mar 2025 14:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conclusive.pl; s=google; t=1742850663; x=1743455463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JyTyzWQzsPLSAvCjZH0qopjCEpB8Oh/jlTrjLbGKY8=;
        b=gjQCKM5RhsXU2FWx+QAPyuLE2aSr0a0JeiIi+vVJDwd4MD8VQkbt/lID5z3nRJQttL
         ggPBddmJKb/27PJTK6ALT+a9M7BneiWBlvgh2poG2Sr7IkFJLXU4ERY4yXrUI1Y4ueF6
         KEsprez5pihAZS4LLthy1dy3DAdm3ZjEAUEfX3KFXrNZXsIaNHd0gDEA/eCyEPnKESH5
         i/rBsKltbv3KJ3hlZwd8TxWedSTV9miXPuUpyrysvdtKuXTSKBB6LvXJLbom44yYbhhn
         uWNo1lwvPZIE+jKcRiXx136UDnG//cCUiPpQpRTYg9IoMzBbgmrQehHrkz2O91U1VQoh
         4byA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742850663; x=1743455463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2JyTyzWQzsPLSAvCjZH0qopjCEpB8Oh/jlTrjLbGKY8=;
        b=ohPkFHsI4kLMtQOn5VhkRivdKzLh1xaiEobhwKt1Bgp0UP+fjdsGkR3fpdau1aX5Sk
         BhQRzxKm3nFdtlJYJccOHXKT85FHls1QTnlBERqLz8kcNCOOw7BOCJYABp6f/Ms5Aoky
         PGQRDr+2cA3oQyzbeQxeyCfMxMrTZ0xjKksuM2xRL4kjUZD4BWBz4SV8OLd1CUqaSaNT
         BuaoxAnfwMiDx6efztyqPBncNt1YYqPIn42876A13JySfxktxjynzx0WaCoY6a3X7Cfr
         ChqgQ74QBU8O/6ND1pLhOBy3nG5iOVg39HUWUaEtDg6eRFLQ/lCClhjelQ2v2tV3dmFW
         JPpw==
X-Gm-Message-State: AOJu0Yyjq7zBctoqMSkpz64bjgT3AeWHtuIzZSM2dHpbKhSA+0cNzYuT
	nzZ/LDPPJjA8cjV6p2GLBBXPZcPF5TqiXloD5PFuQaQqOjSlA7uZgTMG16gS/m0=
X-Gm-Gg: ASbGnctVCtw/BtVuAViKkPAWw8aB+6T+8Rv6EU94mcuvN0pI+AkBTTnbo+Ifx7L47jf
	rNktG35D6gdx3K3TOXZ+Wx2TxKmSH6smclVF/MFbn4qkdMb5mhMgzfkOShIBm54sqhP0X9XGH05
	S1l9lHE+MBUJRpBMbCTLPtK7nSn8jYREP8ahonGYLz4mLaZImcYiapFhfxqTLYuAJWEwQjZapz6
	A2HcSyMVPNlgvIr5l6c/lCdd3HEcABKo7HsbjjZrsf/pkAxGvZevLzxO6FTsusUCm54ailzZYmj
	ChLPYQ74u2hr+VCMdGnFoe9jsQjwwtiRJNzyeLp2oWtzBozY2F+R/Lf6W4kOrqzp2jKl/+3qIBc
	o3nN6D0eBkvUg
X-Google-Smtp-Source: AGHT+IHQu1Ep08TqCw8sMIrAIIK3Br1RIklS9BeCUwXWKUSLGw/dsImCMrXCZ7IuFKP4fu+js5jeqA==
X-Received: by 2002:a05:6402:2708:b0:5ec:fb3d:f51f with SMTP id 4fb4d7f45d1cf-5ecfb3df8bfmr1335127a12.10.1742850663062;
        Mon, 24 Mar 2025 14:11:03 -0700 (PDT)
Received: from wiesia.conclusive.pl (host-89.25.128.123.static.3s.pl. [89.25.128.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcd0e0cb6sm6537097a12.79.2025.03.24.14.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 14:11:02 -0700 (PDT)
From: Artur Rojek <artur@conclusive.pl>
To: Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jakub Klama <jakub@conclusive.pl>,
	Wojciech Kloska <wojciech@conclusive.pl>,
	Ulf Axelsson <ulf.axelsson@nordicsemi.no>,
	Artur Rojek <artur@conclusive.pl>
Subject: [RFC PATCH 2/2] dt-bindings: wireless: Document Nordic nRF70 bindings
Date: Mon, 24 Mar 2025 22:10:45 +0100
Message-ID: <20250324211045.3508952-3-artur@conclusive.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250324211045.3508952-1-artur@conclusive.pl>
References: <20250324211045.3508952-1-artur@conclusive.pl>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a documentation file to describe the Device Tree bindings for the
Nordic Semiconductor nRF70 series wireless companion IC.

Signed-off-by: Artur Rojek <artur@conclusive.pl>
---
 .../bindings/net/wireless/nordic,nrf70.yaml   | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/nordic,nrf70.yaml

diff --git a/Documentation/devicetree/bindings/net/wireless/nordic,nrf70.yaml b/Documentation/devicetree/bindings/net/wireless/nordic,nrf70.yaml
new file mode 100644
index 000000000000..1c61f7bdbf8a
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/nordic,nrf70.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wireless/nordic,nrf70.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nordic Semiconductor nRF70 series wireless companion IC
+
+maintainers:
+  - Artur Rojek <artur@conclusive.tech>
+
+properties:
+  compatible:
+    const: nordic,nrf70
+
+    req:
+      maxItems: 1
+
+  irq-gpios:
+    maxItems: 1
+    description: HOST_IRQ line, used for host processor interrupt requests.
+
+  bucken-gpios:
+    maxItems: 1
+    description: BUCKEN line, used for I/O voltage control.
+
+  iovdd-gpios:
+    maxItems: 1
+    description: External, GPIO-driven switch, found in some nRF70 based board
+      designs, and used together with BUCKEN for I/O voltage control. Optional.
+
+required:
+  - compatible
+  - reg
+  - irq-gpios
+  - bucken-gpios
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        nrf7002@0 {
+            compatible = "nordic,nrf70";
+            reg = <0>;
+            spi-max-frequency = <32000000>;
+            voltage-ranges = <1800 1800>;
+            bucken-gpios = <&gpio2 24 GPIO_ACTIVE_HIGH>;
+            irq-gpios = <&gpio2 13 GPIO_ACTIVE_HIGH>;
+            spi-rx-bus-width = <4>;
+            spi-tx-bus-width = <4>;
+        };
+    };
-- 
2.49.0


