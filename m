Return-Path: <linux-wireless+bounces-24856-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C68AFA7F7
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Jul 2025 23:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 157103BA934
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Jul 2025 21:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BD32BE051;
	Sun,  6 Jul 2025 21:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQbjm2MN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FA22BE03C;
	Sun,  6 Jul 2025 21:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751838082; cv=none; b=ecD5jgXA1ezvH/0CndML06A5XUglh2O5ccGUxo8Hvg7PSyrhYTo1pbJ1XaJroCU7LJHVroWZ/RjO0nzdTQgMdKemT79OF1L11tQVeVpabIQbXY09cUlCCJRVzV56/eH2UEwK/5BYxZsdbmvcAI74JpnPHeaq0sl+EaZ/WWkyzZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751838082; c=relaxed/simple;
	bh=yBJJa2SxaH/20HN8IUkuBJ0osc9IVDpyvHaHFs4BpWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZWop9lNVFH6C58jYUvZdx0488IkSJd14IgfHi/c34TSc4rNTlFHruRLhqOROeB7TZLtqqoKoK0DUT22ZdibZV4xPSjQpsJwUoA0e7uQo0y2oRKx0Q6S0gPa7MiCPCVzScwH1aSYKPmQVKPMEmGll7rDeJM18oPpUzVqWVY7m0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQbjm2MN; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-748feca4a61so1327861b3a.3;
        Sun, 06 Jul 2025 14:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751838080; x=1752442880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjpHESv7Px3oV3ysOGVoWTf3bwmuOKueJ9TXRndyrNg=;
        b=TQbjm2MNux9uTV75q1+k7yqw2PtBp6IpCiwBsgmwQdgnDcGbpj0KwA7V4CoKhQDY7I
         PM5qlyrAi1qsl841yEFVdak7ESNSw7QiQH63eyS5k8rfw6mAwYIVFAhgd0Fpw42T1CJk
         aShCrn29BhpJcD6rtM7RkvkxcIRuRNbR6UIaybFuxGMmKd46Df+6Dk7X/PxWVDtuEzHK
         aSIkjws0Cp0u5Gp2EqCLRzTJPmyvc2hOBFy3ApohgrgQ0jnXAACBtnlM7tWuVyEw7q3K
         PeSaaQQTOZZYJ3hRf9xPHOSaTvBvhr/1cT29MGe6UdOsGUrMLwnVpnapnwnR4vCNbdPn
         ZcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751838080; x=1752442880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjpHESv7Px3oV3ysOGVoWTf3bwmuOKueJ9TXRndyrNg=;
        b=Yj2aYLTAb6LZkhoxS5/wI4zQTNe3y4urIK/o9XFD5NppQyBn9xFjoVuTs340sg3/MF
         oyr4FGti+T8WmN0kblHJICIicnZuMqh5OR6hqDNWvTun13QInnSI2L/KWn7zVg9mHEDD
         iN990LPGLESrWqiPTnDm9VGJUqfC3HqbUcCkIFAy3gseujwR5aBrj9BlaBXlq5x6W8mB
         8GeA5vIUzCTFuFeWErlP5nU/m7eYc8zgVuvkM4UmegWxUheokWS0vW10zq4vkQ7vFxAD
         5DZEzTX836cpxLoNUqJXpJIlzPuKqN49Zi75GtV1u2JPMvLtJBDF12f3bHFFxMjkU24Z
         sg7A==
X-Forwarded-Encrypted: i=1; AJvYcCVFpGmjFNIEg6KvCDOOYqdV0AfF9sCjksFIAQyxPY8fBGrECjc67MyJ/qogccWS6RDRSz9TbpLI3iWn@vger.kernel.org, AJvYcCWKVys50rTcIZScm7F6rVYEeZb4mfrT9SRPCfJ65mjuCDssvtBoEBeJO1Cu9QrMaBV+Kx1GCSxa4oUIKA==@vger.kernel.org, AJvYcCWj+oh6WeEGyrcy1N7WiEuEKp3czzAD/VGsp/A5cZEZYlalYOAMFIADq71pkKMQFcgcweKqmgMMtYw3C6WW@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7mWsFqmPSvUktzo2xasp71Ko9mF89xN/inOC61/EhZk/r8Grd
	G+goOV/VWt1pA77aLQ85FEw+bw235AhJ8UwZZF9og4txfPwv2aof4TeEWSpnysXBgdA=
X-Gm-Gg: ASbGncsK8jZIJnITPFiSLvi/QC+qzHfemYvYQmQxUclIBeZ70uHPmmnNR3vy/634NQv
	Ar92GJTdGupa2J+EkjBU2wBGCJB4tbbWJbVhrR0HWJusczEKMbbehWfqKJOPX3cgRRkQ6iweaSv
	opqcrtBxNMJzmX7w3y8c3XHC1ZKkW4afbHtbJAd0zWFm6Rt5jVAeVgTiMzht+mOVnk+MRpVUuKc
	ybviTSVTWSaI081XblFlYtOpMdtdJT7wolXKXRA8za0VYMyRNvo0IPL/a6xVmeiFvJ57JsOw9+v
	wgZXONsEpw9lvqYYm993Ql+BHOs4eTiktYU6H6ZHpWPCHuFY3uOVEQ==
X-Google-Smtp-Source: AGHT+IHwiZU5cyKcS3pY2lliuwvqMo5NFkP/fRh4U3ufXzqxUy0ex0mXgD2pjjdqIUXlLCc7QhSCgA==
X-Received: by 2002:a05:6a00:194a:b0:742:3cc1:9485 with SMTP id d2e1a72fcca58-74ce8a8ddb0mr12232948b3a.12.1751838080087;
        Sun, 06 Jul 2025 14:41:20 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74cfad75020sm4126416b3a.109.2025.07.06.14.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 14:41:19 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	yangshiji66@qq.com,
	ansuelsmth@gmail.com,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCH 5/6] dt-bindings: net: wireless: rt2800: add
Date: Sun,  6 Jul 2025 14:41:10 -0700
Message-ID: <20250706214111.45687-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250706214111.45687-1-rosenp@gmail.com>
References: <20250706214111.45687-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device-tree bindings for the RT2800 SOC wifi device found in older
Ralink/Mediatek devices.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../bindings/net/wireless/ralink,rt2800.yaml  | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/ralink,rt2800.yaml

diff --git a/Documentation/devicetree/bindings/net/wireless/ralink,rt2800.yaml b/Documentation/devicetree/bindings/net/wireless/ralink,rt2800.yaml
new file mode 100644
index 000000000000..fef14ca20983
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/ralink,rt2800.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wireless/ralink,rt2800.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ralink RT2800 wireless devices
+
+maintainers:
+  - Stanislaw Gruszka <stf_xl@wp.pl>
+
+description: |
+  This node provides properties for configuring RT2800 SOC wifi device.
+  The node is expected to be specified as a root node of the device.
+
+allOf:
+  - $ref: ieee80211.yaml#
+
+properties:
+  compatible:
+    enum:
+      - ralink,rt2800-wifi
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupt-parent:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+    wifi@110180000 {
+      compatible = "ralink,rt2880-wifi";
+      reg = <0x10180000 0x40000>;
+      clocks = <&sysc 16>;
+      interrupt-parent = <&cpuintc>;
+      interrupts = <6>;
+    };
-- 
2.50.0


