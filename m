Return-Path: <linux-wireless+bounces-25884-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F545B0E58D
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 23:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFCF87B5E7D
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 21:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0499828C5A0;
	Tue, 22 Jul 2025 21:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZuWQ4Lz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE0F28B4F9;
	Tue, 22 Jul 2025 21:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753219750; cv=none; b=ml/frTnbQTtfQVl+X+I7VA5c5Cx5IX7dfAKAqZyeMbpazUyI1yICvy8CUfJB3W9xzrABimWPciHI0wB5m79ZAzBju3V55z3he5rjiQY3jJrUkkvmRUg4sh9tMOB3Dy53vg80U6XxrUvxy2Iazk4PBK9KFG8fhWqexdtVUx2UBgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753219750; c=relaxed/simple;
	bh=WlASZmzxpzAYoKS6z6rmk+EebRMMXhqLWuJ12i3hyCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PO06lo7XicMAwXWPrOOa0Qi7b+RZb3aNF/ZnvTbEOnhWXZgY2DEu920PeENkBLYXrGslBXha8Eg+2EepuwO+yiuxVMc2ouL/a+45i/Eik6PUI4VCk/y1+U8THXwzbd4ew3kvQh8Ui37lNUWM/s6PaIlJTHMGrCcFwHYCq6eSZ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZuWQ4Lz; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b26f5f47ba1so4827393a12.1;
        Tue, 22 Jul 2025 14:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753219748; x=1753824548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67QEz9S+95ZQDu3rHCjWe+DFBCPwq22amqFwl+XgLLI=;
        b=NZuWQ4LztHDavN2mwgNpq0wwW34A0ururLf3VC67tdo9IZ1QoEacDicbOE2d09BweI
         WahELTqLIJcEJuyc4z3uLe4kmZH2472KIJZxXU1rywVqchWALJkJuhoA3IQjcNulLiB0
         tF2y9Tx8h0EifOO7IX+fxRAbK4JeX0+VJHiwZBNDL3IIldXdBHiyy2v7lJtr6M85SjC+
         yGgJKGYv8TtFzucVOqmuIB2WZyd5otBaeK+NKBtL4eCoyYhdf/Nc3gelPQH6q06MqGD6
         nya68ED3uzRbCRHNR+Fa+a4P+U9vcfl5YzrpSXLFIt0HKokByrL241W5+tSP4u1XlnL0
         BpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753219748; x=1753824548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67QEz9S+95ZQDu3rHCjWe+DFBCPwq22amqFwl+XgLLI=;
        b=Q85UYg8tHeZEu5p4q8KQ4lKseJS4/Nau1h+SIiZUjNxgy1Xta6DDAahh08F9+uOhhi
         +t+WvNhYEm80gSnPdPSWfk2iPCANW/S/dsztXMjPqyMT786f2kLq1c2HM+1sImND5vs3
         0I3aHjFOVM2478wztB3BAHt+DK02KD2n+ZszpGQBFzbwI2+7j719MGv8WM6DkTIhB43k
         hP3hB5WK+zxhEFcySIGTP93n9OX0zFWrnz8FX8tQQCpbKj9VVtJ/4ICJvtdP1RpD2e/l
         MBnaubE9hQJ62mwc1zJmDQgiD/EsUtWcisoIvswkaBTpdtHZjxOSvdPqdjQAcSCHJVmB
         JtkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMiKHtzMM2rZJDcU4eMlBINVW6OZ9uPBTeSRmLhs9qQpdvdoUb/gQ8BTdRqPrbY9KSWJQF1mKQxTeevYeM@vger.kernel.org, AJvYcCXUvzxAWj0XLKRzc92KWOvtZVASIJd1yHd3Q28yhYgNhKOBS9GB3wZxU2efVc4zSiqlee36rFVrrlszcA==@vger.kernel.org, AJvYcCXyWtVLfoIIC8Zef8lvPEpDDbqq7rzE66e/Jol73Pcvbr8OcdtPE2YU5bokffc7j1VeR5WMCmihleZv@vger.kernel.org
X-Gm-Message-State: AOJu0YxUh26Itd1cM2SI/6XPDYCCqwBsvqIhlGQVNdo74MIVi2byLyhA
	xq0E7mOhQX8i44Is4HtCedmmbuyEZT8LT2nwnRjnXFFq3ZjrizQLA9ZZQgDfMyx7
X-Gm-Gg: ASbGnctFQQSrqGDYX2jIOGMXR+HkLfZeXuWvWZIPLL/WAZGF1r2OfzhzDFXVwTiNaKo
	djY9GDJ1nGRsrMOAg9zoVmKPs6w+pRDO67xXMPnAMGx1wPUNJl9mICKAZik5R6oSAu8PkLqTXU+
	bgHlFGso7WimUxAHRlNf43Cm5mGEI08DpFz2deoZ25osT2Vv7RL8rk637Lifpzz6sPDj3aqCTBO
	PF6eKJ0Kb+k8UId5kJ81qzFI/d9IIUSdsoeLPtSLVvIdmIac2oF6sqyVcbTn1vZSpTuvlGqMh0V
	adLbiPaP2u6I4hlxuSGYFU550WSe2uN3QNl+TFoN2c2agk6FZiPNY8kwAMAlts3S/d3aqvph5EI
	ySls=
X-Google-Smtp-Source: AGHT+IHAVxGiZOrlaAUSxgUbUh6FKWopOqgmAMQnmnuTA3s27a7MO8YmCyqzn+U2fdYiR74X38P2ww==
X-Received: by 2002:a17:90b:5844:b0:31c:3651:2d18 with SMTP id 98e67ed59e1d1-31e507b41d4mr1284874a91.16.1753219748471;
        Tue, 22 Jul 2025 14:29:08 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e519ce384sm94942a91.2.2025.07.22.14.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 14:29:08 -0700 (PDT)
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
Subject: [PATCHv5 wireless-next 7/7] dt-bindings: net: wireless: rt2800: add SOC Wifi
Date: Tue, 22 Jul 2025 14:28:56 -0700
Message-ID: <20250722212856.11343-8-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250722212856.11343-1-rosenp@gmail.com>
References: <20250722212856.11343-1-rosenp@gmail.com>
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
 .../bindings/net/wireless/ralink,rt2880.yaml  | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/ralink,rt2880.yaml

diff --git a/Documentation/devicetree/bindings/net/wireless/ralink,rt2880.yaml b/Documentation/devicetree/bindings/net/wireless/ralink,rt2880.yaml
new file mode 100644
index 000000000000..04dc5bb2edcc
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/ralink,rt2880.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wireless/ralink,rt2880.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ralink RT2880 wireless device
+
+maintainers:
+  - Stanislaw Gruszka <stf_xl@wp.pl>
+
+description: |
+  This node provides properties for configuring RT2880 SOC wifi devices.
+  The node is expected to be specified as a root node of the device.
+
+allOf:
+  - $ref: ieee80211.yaml#
+
+properties:
+  compatible:
+    enum:
+      - ralink,rt2880-wifi
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
+  - clocks
+  - interrupts
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


