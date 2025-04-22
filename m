Return-Path: <linux-wireless+bounces-21851-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FAFA97416
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 19:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8813817F90A
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 17:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3996A297A55;
	Tue, 22 Apr 2025 17:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=conclusive.pl header.i=@conclusive.pl header.b="Jw2SoAzL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0F629617F
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 17:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745344784; cv=none; b=Y1sFk/CNQxkmWGHYibpl6OpG7xez+f3nrwupjCLXLGrsEak9t/uY/IAp/+GkKpttjPjrdQrouHGanDylHPt6c+NpYf4cr8JX4DgfopUDT344CPt7MclVNq3Ltg/RYp2R3UXs3kSqX3Zh9LPbVLfFGLyikMMPracY0Or0bepKHtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745344784; c=relaxed/simple;
	bh=rX4pZAx+Fw4Z9aS7brID/2V6XdrCArIiB7uoJZcdUlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/8US4MIbYoLuWDyr5AGryNtE2pYUICPAj+UxCEQ+qTNLLNp7g1YTaiGo6zfqj4uS4Dv6m327pFSd88kEka+0GDk80vpNoTrFjQWNrDawLbZlrA4rzNoPUZn9XuvGkk4cBasumr9bXZPtqpq+r6rtFP8G7XYKgMkNm/gWOJsQRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl; spf=pass smtp.mailfrom=conclusive.pl; dkim=pass (2048-bit key) header.d=conclusive.pl header.i=@conclusive.pl header.b=Jw2SoAzL; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=conclusive.pl
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-acb2faa9f55so653571466b.3
        for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 10:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conclusive.pl; s=google; t=1745344780; x=1745949580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsoqhQJqReGblLVET6rA99edyyj8MD7IJfz2aWYWya0=;
        b=Jw2SoAzLD0Ux3rSnqVrTEAPE7WXaDzdhOAAOCq/bNU/+JscOL6pMXRYeIXwAbET/h/
         Knn2hxyAVlGe3GsfgR7ObUoihLgzvklcbSME5ETE7cFIsyKktuoYyD9RZat9YrKopSfK
         8tJo/Z5r4dW1y9g8vjZdfvNd/UoNZy9AW/zQUVgt0jziPy/u7lRwAA1RbRdNCMn30+1A
         OCHEuB+tcY8kx9ojykrs7tJgqafO+tgCKhdVZqoJgOhBJ5W67yQ7NvrFwCgC2bo+v8g/
         PMNV18vvFyikDIDDNhKo8NGMH/rIXxcLgn6Pe0ZGwnaOsaymK481O69uu+SJjIxG55P5
         hKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745344780; x=1745949580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EsoqhQJqReGblLVET6rA99edyyj8MD7IJfz2aWYWya0=;
        b=obFoc+G4iH3N/sopKHtNR5KPQA5/wtDEIL4EjuUZvSbPHxquVydAGphBrBtVv9Adjr
         iLIpv5dHkZKJr3bePHU9pJrppCvdTPWz/KVG/p7JDxDys1eVNPpUOw6mZms0AX0zSgk3
         G4ZLtrvamJCn5nQDueFM4kwUiXvweAKM4dZM2KM3C5glEwG1QXKj8kyKndfxm4XGvRK6
         Z7wRRfkFfAnPlxMAchCUIcVlP3p1ZJtvBVtl2l4cHM0mTwTYUqMTXOyipEftryvPsCco
         3PKtrCG96AE+Frd314rYZeziH4NQE0LlV88lOQ6Ww8vPKANTtJAuLV02eVn396ieioB4
         p3tw==
X-Gm-Message-State: AOJu0Yxjz28jVHqjNsHHKj/tvuQfb0FcntxMQeWWHSrFZ3Rux15MCCAI
	tlCTrLFGI78+T8KMYq5GfIKhxPcbTc5hM82NAWFXXID40kAkixD8Xv6V2EC/M0s=
X-Gm-Gg: ASbGncs59xlfKTMWjRFmkFTcttS59S5gZl8UoLGeUZ/4073YtM2p1yRnUVZ8gnpiXT+
	BD13I31Ci4UO2MX9QHoJ/JopWK3nHrJOu2+CuxeGqIaAGggfEU/CZImiOl8GnQ6EQMVslE2PsEb
	REFijegUvbyqWpB4y743vXy+HOazBM1dpYZ5k1VOqiutoPhvkKZNyS0uqjVVKs4jsD7kURr+0E/
	LtSiwZ5SxvkjpAaOB8jHTUvNWQo6JPJqJLWW8VSeAivfN4Uo0jmBLG0VT61VYwcNL1uiqw0Ow7f
	KbXEqFPQXa6ObU8r/J3aG0rkmUCQed3wW4kaVwypYzSWjz65LJVpoz0FD6YRq1Q2I8c3Ukok6Qp
	pWR0v0IeX
X-Google-Smtp-Source: AGHT+IFDevBClHWL43+s8ObNwls2JReJQHbOXyOW76f7cvBTjIZlKeT5m3zNvNHjFdlY+e7U8WVEGA==
X-Received: by 2002:a17:907:da2:b0:ac4:169:3664 with SMTP id a640c23a62f3a-acb74b7b640mr1311993966b.33.1745344780516;
        Tue, 22 Apr 2025 10:59:40 -0700 (PDT)
Received: from wiesia.conclusive.pl (host-89.25.128.123.static.3s.pl. [89.25.128.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ef47733sm690208466b.144.2025.04.22.10.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 10:59:40 -0700 (PDT)
From: Artur Rojek <artur@conclusive.pl>
To: Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jakub Klama <jakub@conclusive.pl>,
	Wojciech Kloska <wojciech@conclusive.pl>,
	Ulf Axelsson <ulf.axelsson@nordicsemi.no>,
	Artur Rojek <artur@conclusive.pl>
Subject: [RFC PATCH v2 1/2] dt-bindings: wifi: Add support for Nordic nRF70
Date: Tue, 22 Apr 2025 19:59:17 +0200
Message-ID: <20250422175918.585022-2-artur@conclusive.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422175918.585022-1-artur@conclusive.pl>
References: <20250422175918.585022-1-artur@conclusive.pl>
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

v2: - rename the patch subject to comply with DT submission rules 
    - fix a typo in reg property name and correct its indentation
    - replace all gpio based properties as follows:
      - irq-gpios with interrupts/interrupt-names
      - bucken-gpios/iovdd-gpios with vpwr-supply/vio-supply
    - clarify usage of said properties in their descriptions
    - add a reference to spi-peripheral-props.yaml#
    - specify unevaluatedProperties
    - drop unused voltage-ranges property
    - update bindings example accordingly w/ above changes

 .../bindings/net/wireless/nordic,nrf70.yaml   | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/nordic,nrf70.yaml

diff --git a/Documentation/devicetree/bindings/net/wireless/nordic,nrf70.yaml b/Documentation/devicetree/bindings/net/wireless/nordic,nrf70.yaml
new file mode 100644
index 000000000000..c9a41b61c624
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/nordic,nrf70.yaml
@@ -0,0 +1,71 @@
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
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description: HOST_IRQ line, used for host processor interrupt requests.
+
+  interrupt-names:
+    description: Name for the HOST_IRQ line. This must be set to "host-irq".
+    const: host-irq
+
+  vpwr-supply:
+    description: BUCKEN line, used for PWR IP state control.
+
+  vio-supply:
+    description: IOVDD line, used for I/O pins voltage control. Optional.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - vpwr-supply
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    reg_nrf70_buck: regulator-nrf70-buck {
+        compatible = "regulator-fixed";
+        regulator-name = "nrf70_buck";
+        gpio = <&gpio2 24 GPIO_ACTIVE_HIGH>;
+        enable-active-high;
+    };
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        nrf7002@0 {
+            compatible = "nordic,nrf70";
+            reg = <0>;
+            spi-max-frequency = <32000000>;
+            interrupt-parent = <&gpio2>;
+            interrupts = <13 GPIO_ACTIVE_HIGH>;
+            interrupt-names = "host-irq";
+            vpwr-supply = <&reg_nrf70_buck>;
+            spi-rx-bus-width = <4>;
+            spi-tx-bus-width = <4>;
+        };
+    };
-- 
2.49.0


