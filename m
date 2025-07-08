Return-Path: <linux-wireless+bounces-25001-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77076AFD82E
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 22:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B96AE1896145
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 20:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C55824A061;
	Tue,  8 Jul 2025 20:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNWLERcX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E142472B7;
	Tue,  8 Jul 2025 20:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752005879; cv=none; b=tSaY4C0hjRD0KT0p8Al+7E8ML/z+ZRRPTAxinmn90GYyBpwG69y2Txgr/Kkhah8KMl4EX0HqcI2BO2MXKz12jpc3dwAlkCZpR2GJ/5fy2liodXGGl5YLc8XXeFbSLrtkUYxiq5F/kUeOufhM+rTrHNHdHnGRvqr+0U3pd9/tDIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752005879; c=relaxed/simple;
	bh=OrcOWedHmiXMlVDVIjmLJ8ZUrO7ft+siTYG0yQj5GmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A76bCLI9Fuv6rFdE/CxmHBCBrns0URnSqWSZZp7jn1GhZroy5rte2zwyKJqXKo2KGSe0gRLdEsK9R6P4zP5jdkbwn4C5GS+jlGgo4wNdu67YJA2+Y886wTKrtEYD5iSO44jcGHXnQ1dvOJQeMz3sk0wx8aQeuniDA0k1HtEZCRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNWLERcX; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-748d982e97cso4256803b3a.1;
        Tue, 08 Jul 2025 13:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752005877; x=1752610677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H444FZZ26Y/falHC/mRcuhbvMASG2hbu+jZAxqiMw+8=;
        b=QNWLERcXu9EYHWzfGB30IpMBiPUcnT4LzCPgAH2q3I4W1Nh03a2LP+UnVagsdB880N
         NBsXpNcS5u+qPu4pY9anjRtymIthptUHWtZHeD1ZVUlLkPLCxwmgXijFop1bibxMaWbU
         byF/L02XbJ3TFRJJzBOAgeoX9gZzi2pm3WwDp3uk4wXNEzGiqWy8qXEXAacsgSc5Ty3n
         /3MoL7WyTDueK0Im2WWpCMzbwJkLn3xprFsdeCCFINQMrerKx5/ndTXHqDjcklVWDN9f
         1GZigvgPI3WvrTf79udI7DHqTEt0eW/CFnDgn4ih53t9/7RnNsYMxSsRRa06pv+kCTAX
         I20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752005877; x=1752610677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H444FZZ26Y/falHC/mRcuhbvMASG2hbu+jZAxqiMw+8=;
        b=iRM+cp4nYrwIyLM0qXdxAEOU+tDrZvVBAx/xkqnR3UKNcgeUCxSveegV2D8IecGR/5
         k7T1oOqW83e6S5mF1ETzANYjtYxgpFUuV7EIFQw9v/1SP4Y0oGIfBGt3uAC7zaoVotp8
         UgXO9UFXAsS7VOXPRDlZeMcLCI/v8rZupgSEwo2m7It0l/fgp/KqXSXufQNfCYaE91P5
         ieoESuZ97mV9jzt32VikmYZqjGgTYh+UNM5wsNZ87A9BZQ7UBMUFODrkTArwmvhiW6ic
         Mk0j9GnMXsxcM9RjsB/lshXGMfCxpJYHFWbhDtwOXBRTHtZ1GsuQgiOjlh0fnqMx+VzT
         NoGA==
X-Forwarded-Encrypted: i=1; AJvYcCU/mcpoDXVxgOEhUEwX11D3m903Sa79Khh47el101LvMOFF4zdP3cAxkFDRc62qhqYfGEKsce4p7RBtKOgJ@vger.kernel.org, AJvYcCV28P/l42OZFhLvdBpJef1It6qmIIWJG6hopvfzRmubYnEpSDgXwk8JxaQr78eTmJPHI1f97PCCv7sLxQ==@vger.kernel.org, AJvYcCW65SDAfQktqnQPZ9F8WfWoROKQsP2Yjobi0iG9LJbUPydLRdTQS0gzT45FmOKz5egGiVBSlD6Gd+uL@vger.kernel.org
X-Gm-Message-State: AOJu0YwdGnOgQU9OAlV7rtxBHWQuWeHAjfewV+dD89Jqi3diqyhd6d3U
	jJda9ZbTldxFBXbN3B8qKl6/yXYgr7VEpeIrMLaHHnHzpjCL65IXXgdoYhBPmoYfTqM=
X-Gm-Gg: ASbGncs3ICJX609F3+IIQhGZSNy1q/4wzEpcX2pU6D8P9NwdfqKN7vs4OYpA8mZbrXl
	GC8N9cLfAtgCS2MIK9W9ZULViwxx7bJemfM55ltu/aru90f4KC7k6BvEujxNlRU0Bz8VuzNh52z
	oyWHIciAPI9lKIQz58EOGiCnKxhAA9YLQMv69/ZB74G3KWPaOVQ5lDMTfQ7qtpnG0GDCgxADJBD
	guKdJk+zWzWkhBASuex/fyzgajYfHhJqHMxSWyufrR0522lJQjYuhsXZhYx3htNLioyGSe+iis6
	1qMcdjc9uIk/aDsJ50HObGRYE2oYCS23lcy7K6PfEqk=
X-Google-Smtp-Source: AGHT+IEzzxNAAv00TJG8Gk8h+YAcNBRVGpDbVFRbhweDtAvP5Qa6pIVfiWZvjxEP/RXGT1BW/sMzpg==
X-Received: by 2002:a05:6a21:a34a:b0:220:83e1:49a1 with SMTP id adf61e73a8af0-225b9f641b1mr25210715637.19.1752005876682;
        Tue, 08 Jul 2025 13:17:56 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee5f5d8csm12289625a12.39.2025.07.08.13.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 13:17:56 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
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
Subject: [PATCHv2 wireless-next 7/7] dt-bindings: net: wireless: rt2800: add
Date: Tue,  8 Jul 2025 13:17:45 -0700
Message-ID: <20250708201745.5900-8-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708201745.5900-1-rosenp@gmail.com>
References: <20250708201745.5900-1-rosenp@gmail.com>
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
 .../bindings/net/wireless/ralink,rt2800.yaml  | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/ralink,rt2800.yaml

diff --git a/Documentation/devicetree/bindings/net/wireless/ralink,rt2800.yaml b/Documentation/devicetree/bindings/net/wireless/ralink,rt2800.yaml
new file mode 100644
index 000000000000..0c374cd5adb8
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/ralink,rt2800.yaml
@@ -0,0 +1,47 @@
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
+  - |
+    wifi@110180000 {
+      compatible = "ralink,rt2880-wifi";
+      reg = <0x10180000 0x40000>;
+      clocks = <&sysc 16>;
+      interrupt-parent = <&cpuintc>;
+      interrupts = <6>;
+    };
-- 
2.50.0


