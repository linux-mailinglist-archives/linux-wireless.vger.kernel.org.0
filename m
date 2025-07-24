Return-Path: <linux-wireless+bounces-25964-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497A4B0FE0A
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 02:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70632965EB1
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 00:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4670919D081;
	Thu, 24 Jul 2025 00:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpgA/BXu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB13D188000;
	Thu, 24 Jul 2025 00:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753315965; cv=none; b=CjG5yyoxHChHmInsmPFw9Qmj4QyC3MmeYSEneS4VzGYvpwD3VoBNr3/WkUA/YyR5cALRxYGr64MMb8yCrElW6niGGmdlQZd/RwBRabc6uQhbXqEj0WKciTETgpwtnweRQA7WHvC6ppKny6X3IqP+h4RARt8TxGUHW6ZTSqBgDNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753315965; c=relaxed/simple;
	bh=2SNqP/YVm1qeVbcALVDadvho7XnIdEl8InSdHK7S4jM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFGNmcXC82Nr3f9Icazn3W8Lv8BC2y/lLNyVjYno45s67pJBZyq1yRQ5S1fchlFvSCkSVYJtJ2TlQoF25gw4h/bhAtwTruL9I4Lqx0hG9wx2Jruk8fHtOtK+3UlLrdTiWxfudEVpRNkcMZIuzIhdZ71ZVacfsfnX9dc2zUtBY8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpgA/BXu; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23602481460so3842855ad.0;
        Wed, 23 Jul 2025 17:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753315963; x=1753920763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cb0rNYXXcc2eHZ9hzARKN3xqFUjTVby79Ond82Ur4k=;
        b=TpgA/BXuQqqKaZghuz2mKxbrcrGymV/MbUre6L7L8zwewOWWY95kN7/Kji4qCesTwQ
         gfZ2m1VsYRFUHWWPMqCc2f6fV0gFRIozUv0EgBvBgEtM5NaupD6cyHdw74uhpNPgW+ZS
         Loj1W04QUrs14buyi7rf/KNe+/FjUTC5jfJyh7DUSf+CF4HM47TQpuUgMUrJyXA2aC5v
         FIWmz2JJlcFxo0kcC1uTehR88H1sNp6j0s2G3gvlLbU50vM1t8FlWId/Kvo8IMDLGKXh
         SyFlMbQuBUzqz1UOiPi3ugtY26S7RgXwq/PLfFl6d+3q/icIN5F0QWhB2rsASzIAyWDk
         /Rkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753315963; x=1753920763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/cb0rNYXXcc2eHZ9hzARKN3xqFUjTVby79Ond82Ur4k=;
        b=pGSXww4IB+YzcWBgrXUq1h8xPtsiAV+dcK/fDtNWMxgwdP3cqsRctSxDKKx8gWZ9T+
         OIxVSFTpJXC3/qs5+Tz7EP3ENFPVgfk6nxiPbDisryuoN2HOMl5RKOdmMXolWlNNmAv6
         uc1odKMjNX+E9ioPkYPJ7k5TlTFsT1rF5HbIfkQrlgcTQs7AnuppMLgWBHeofm1s8NVG
         k5gGdwznBqKBU9WsjLLRa7QZV5Jf1AOnaThrGbzas8iVN7v4yFAndiI3GZEk6BLW5xnF
         7ykCzXOXus5EILBIibqRoX/n8abBYAHIakSrXli3Hw/iTNYlP1AEo14rmrWxofigEd/1
         C2NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtoYCg6s71HE0OoUW8E7XdGuqoYFMZAMsb7BlZ/Dw9aGPESg3fCIMwgFkRN2IX+uoViOvtKXeVCf9h@vger.kernel.org, AJvYcCWwKbnx/hqq0yhlRYC5jGWrCQdlDjTmqoOYX74afHqz37VZ3Ihl72Y/n1DKKJd1yBY6LxHu5wBLlW4p51bX@vger.kernel.org, AJvYcCWyPRethCL6xR3e2H+tE1jncQTnUBo2h+GOfeNSEHdLJ6qGpYNaMxGpGjsW920yfLYr6+8kZ/odju4Tgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNp2udeYenkMkEUTwic6BipaBjT+gqc5PuVvCoaBHuLq8NKxK3
	ZMPfkdwVoQIkC3J3BqbDEIgjE6Kkv408wOvrYDZe3ELWnDEAb5LP3bLbFNHb09Rc
X-Gm-Gg: ASbGncufipab8uNJsFywtuu+cEX/51XUl6ycNxC3SgOFVD6bU/0ci8Wi2ljBNv8Amgs
	3OgaQEVqAnH8eloCow6fHAEWyDuXW7JHmWg0i143fJA8LCrhw9oDh9Dq5RSrvPhzMrO3ZlrPDkG
	kg7OtTCemZB+Wyg2YX1+6LWwOfkv/AP8KhvuipX08NXLDs1dlVAqNghtprEl06Yq3p7DWCpTwI6
	HoRRYZ9VzJFCDTocS0OEPQ1bodv1jNH4/Ji2L6qzndw/gcTdJWeqkacKLHYJnBPMAWWhOoUnJ/I
	KK1LTYOa9o4G9+b2PdoCCNUY35nzQ3DCrfBcCQEL6OayrwdunQ/spOjHC85acfHrTE8amqEb/kR
	lPi8=
X-Google-Smtp-Source: AGHT+IHhWQ6WIKyamNhx/uy+Z5hdXGcvTdyE4+cWZb0JiB8Ozp37ZNowpoaP/wDcsnqUdaF9o9X4ZQ==
X-Received: by 2002:a17:902:e54e:b0:225:abd2:5e4b with SMTP id d9443c01a7336-23f98176ad5mr63109095ad.16.1753315962904;
        Wed, 23 Jul 2025 17:12:42 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa476c131sm1872265ad.45.2025.07.23.17.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 17:12:42 -0700 (PDT)
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
Subject: [PATCHv6 wireless-next 7/7] dt-bindings: net: wireless: rt2800: add SOC Wifi
Date: Wed, 23 Jul 2025 17:12:32 -0700
Message-ID: <20250724001232.2275-8-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250724001232.2275-1-rosenp@gmail.com>
References: <20250724001232.2275-1-rosenp@gmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
2.50.1


