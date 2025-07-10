Return-Path: <linux-wireless+bounces-25228-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF07B00CCE
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 22:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AB303A75CB
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 20:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EBF327A4F;
	Thu, 10 Jul 2025 20:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxK09xGI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833C23271B4;
	Thu, 10 Jul 2025 20:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752178113; cv=none; b=WBTO8Nt6WIoOKEY65yvQYQ4KqHC2WmRV2F8a3TQ/0eURO0kXZ7f4dGim9h3ZQARRoUi8GRaRRlAA6Mewv9pLD3P1uYJBxgZf/cClkJ7kV4c8ARAKsH11t2+AkNXZDu22F7u20j6XapQseex+TWYtBLDyCccwyibdfBuGtWQNiko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752178113; c=relaxed/simple;
	bh=NbfRKihmupU+XyTDsF3IC34iSNou31BZMB5KpJYPJFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XvyAR3NQk0tP6ZivBqsjSwWDfllVdN0wpbH/Eq0Qeb/Yn7Xvd2XGCaQ3m6fLIrK3mKITNoXMCQozuTNZGZPtxLXb3DeCDXGuSo+AsUgJYGYH8e3Erq45XxDD0vfjQn6zrwVI7Y9BfN0sYz8XoslTZwp6JA+80zEEngjnlMExYtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxK09xGI; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-74b52bf417cso1038738b3a.0;
        Thu, 10 Jul 2025 13:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752178111; x=1752782911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LINvhFocgr5lRpN7zPL/hoUtBtdS8dAdR0UzAxBMMSk=;
        b=AxK09xGIhFkIkFrRMfhUBsL4jiWRezFmy5pCCMiDbEbQn3UKxSfjZIdMYcciX9bl9l
         4aFIarPUM8DfzK/o+5XRmphqaIJp9e6oTpxv8y3KX9wgnM8UCi55mSHTPk/jluWFrFa7
         5m/Fl1adYHNKfTaXCQ8S2UnfYE5RAjWc92zO33pCBbCkQIjC5Tptm2lB9AgISIIAb9k0
         k/TjeKx4wnSIq+nlWpAxbNR45V1nF9s2e7oF+PREf/f13aUd4OfEDg5hZV4aXOeFdVUb
         zUNONMc1VEdcuanEwHa8/bXFPkbCXd0vhm+vChfvg3631ek9EZZ9tXKEpNrAbpihWiw4
         lQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752178111; x=1752782911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LINvhFocgr5lRpN7zPL/hoUtBtdS8dAdR0UzAxBMMSk=;
        b=BjoYfd3L2GGRNLf/U2aH4BdnXvtsZbIkwK9XD+gxj9tAo4oVKka4kqGFXoJc74Namv
         e9FF4nNdM9QRegY9j+wThDSb0ZEJqrrh6jr/0J4AkMjAXn440EYQ4zoGwZrVrJ4xmbtP
         6Jh8Qyejck70vZfgHznxaH10z73WWEpuDbMR3ws8mP09JpkPyKAbJEgYQf0VOJE7PO28
         g4j+ivrixXw8gnAYAGZqww3QLLRNOj4c6BNwxv1kYfWCx13N5v1z9XPMQdunq7KfWjrs
         YokaU/eaGw2I6X1FxKCo/Yqu49l0YIeOIHtc7LHjglGnQLEJDul2rbV/K9UD/JI/nR/B
         FCCg==
X-Forwarded-Encrypted: i=1; AJvYcCUhcUR+w2dzIjfsVMQHfdGOeU7iQHhMxYuBmDw3T44YnC4DlXl46NZqAB4yCWwE2Wls2VJRI0mJofmeFA==@vger.kernel.org, AJvYcCVWCTfiW29GbXzhg0f6OsVi5ynYDoCsJcKIFzGXtyDBHkPNBeNYiLbJW0UCAnh71myCxgjjxhyIEpZYLO4e@vger.kernel.org, AJvYcCVaM0TSJqE4vCvPt5eWxNEVA3n7Ihk/VMkqYsaEhaYNyEqQr9gnN3AREKOgTS+vc7MJfvIsvAywc4Kq@vger.kernel.org
X-Gm-Message-State: AOJu0YzA6Vd7XomGl6ifl+2pB45SZhshoV3vVuUrEvaC00kgbPag/9CS
	03vslT7bN/ZGF70yqSJ64Z2LJ95Pwx2TD13lYBOcxNNCFjiQATnCDyf5hZOCcPUU
X-Gm-Gg: ASbGncvdXOMsWt7izkbXMw2JFkw4Fgpea3vugX06mMEBNCprqU5XTMOYOPGfsDnG6Ac
	oAZcTu7CRQ9utN8+foDsDtC3h2Rn2iRamEf2hnk01qzbiRtfZbidtcngWEu1QzQq1PqGihF4OL0
	y00JnxGpXkCUGkZQyrc9dIbiBw5dagqXTvY0JygHBjyFgamSNnHWyh/+vbxuDy/CZDJyxjFvBEU
	SwPX4aVe+SgZwDX4GWiu2gncPyxf1K9+AzxDdGeqnbVGTjqS7gXbf7ZFPQJMIiLQyZsxnhBvZUX
	dwUnta+Trl8gPADS7AJ+NSMuWF+c2rUOzk9mXq4tTNU=
X-Google-Smtp-Source: AGHT+IEXno8suPMIMXytYz8ChGbVNsFci21RBtRSQCE+mON6qbu35E5Mu2Owh4P2zQEHpWvQFLXmsg==
X-Received: by 2002:a05:6a00:ace:b0:748:2eb7:8cc7 with SMTP id d2e1a72fcca58-74ee3629862mr469552b3a.21.1752178110664;
        Thu, 10 Jul 2025 13:08:30 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1b29asm2729453b3a.87.2025.07.10.13.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 13:08:30 -0700 (PDT)
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
Subject: [PATCHv3 wireless-next 7/7] dt-bindings: net: wireless: rt2800: add
Date: Thu, 10 Jul 2025 13:08:20 -0700
Message-ID: <20250710200820.262295-8-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250710200820.262295-1-rosenp@gmail.com>
References: <20250710200820.262295-1-rosenp@gmail.com>
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
index 000000000000..8c13b25bd8b4
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


