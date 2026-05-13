Return-Path: <linux-wireless+bounces-36375-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEdvD7gUBGq0DQIAu9opvQ
	(envelope-from <linux-wireless+bounces-36375-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 08:05:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA0C52DEB4
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 08:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CB9C73047450
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 06:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4585F3D3334;
	Wed, 13 May 2026 06:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nknJDJuG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DEA3D348F;
	Wed, 13 May 2026 06:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778652341; cv=none; b=GtIt9zgtg/8rf0+1OQvBJLcDbL0HXLpYbDPYi6XjjLJ9Knf3s4Hyee3Tt5bQEc5N79w0EMlIud1juJAfo7mlgqRl93B0+iT08Pt5eG/PiKHUD5Ws4QdgHjs2CHFrLJUpi8iq5Ep1BoYTNKDVCtUxozpdBUlD4jHkuZk/lSGF6EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778652341; c=relaxed/simple;
	bh=Z/MCK6kaDdlIm5kIcWfkbQzDqJchtn0mu7ja5gL+52g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kv9nOAO8Y2uHClk+l0I7gdcbHoyQ6tWaiczdBf+XlE8NUYPnB2EDOIl/MAMFGnMGy8glzWLcwftbYRT8BfAKme5fzYDl1SDFsTyQB3JDhiD3t/9lyrotOr4AFF4m8tKFwJQ1lctAMz/bZPtjBUjCY/YTXPD/CStrq6wMv7Nz1os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nknJDJuG; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778652339; x=1810188339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z/MCK6kaDdlIm5kIcWfkbQzDqJchtn0mu7ja5gL+52g=;
  b=nknJDJuGhJ+oX2aQLUhu2EE5CvaJWAUZzdkkSYkUPlsInBG6QJdBET1p
   Sfe8U4lWr17VPlzB2k9jw6jCHNkfP9jxSkpxNr9one7nlRs7uVZHdxR4A
   oVDTloj5DpBbeBCrongngIeOjUtjuROANGNPEVDebJ59+qqmF1QOY49d4
   sE5U2NdpXUc+QxhGl90m7CL/5auuw5p7yDQ/avMKbfMc3QSDLlktPA0lT
   XKkVooFFLWrdY9WQ/HjHc4jHDGN8XaGAC/EeYRg27mMwnpmcsapw3hiw5
   lAev4M3QPd62YNhJSe9XTbLDYtvXQgRHILWEncfJLv0222HOnBw8bFbyP
   g==;
X-CSE-ConnectionGUID: k0WXJ8YTRaqFan+ClioYyA==
X-CSE-MsgGUID: nCIRceu+Tv+QD6LQio2sWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="90954396"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="90954396"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 23:05:38 -0700
X-CSE-ConnectionGUID: uLFIWRTxTtK7FyPCfEJk1w==
X-CSE-MsgGUID: wmmnPcDeRb2A+DoiMGOocQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="233712387"
Received: from iapp347.iil.intel.com (HELO localhost) ([10.167.28.6])
  by fmviesa010.fm.intel.com with ESMTP; 12 May 2026 23:05:36 -0700
From: Avinash Bhatt <avinash.bhatt@intel.com>
To: devicetree@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	johannes@sipsolutions.net,
	miriam.rachel.korenblit@intel.com,
	linux-kernel@vger.kernel.org,
	kobi.guetta@intel.com,
	emmanuel.grumbach@intel.com
Subject: [PATCH v3 1/3] dt-bindings: net: wireless: Add Intel Wi-Fi 7 BE200 PCIe adapter
Date: Wed, 13 May 2026 09:05:29 +0300
Message-Id: <20260513060531.8130-2-avinash.bhatt@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513060531.8130-1-avinash.bhatt@intel.com>
References: <20260513060531.8130-1-avinash.bhatt@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AFA0C52DEB4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[avinash.bhatt@intel.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-36375-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim,0.0.0.0:email,devicetree.org:url]
X-Rspamd-Action: no action

The Intel Wi-Fi 7 BE200 is a discrete PCIe Wi-Fi adapter supporting
802.11be with tri-band operation including the 6 GHz band.

Signed-off-by: Avinash Bhatt <avinash.bhatt@intel.com>
---
 .../bindings/net/wireless/intel,iwlwifi.yaml  | 248 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 249 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml

diff --git a/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml b/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml
new file mode 100644
index 000000000000..e5ba5e7608e2
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml
@@ -0,0 +1,248 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2026 Intel Corporation
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wireless/intel,iwlwifi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel Wi-Fi 7 BE200 PCIe adapter
+
+maintainers:
+  - Avinash Bhatt <avinash.bhatt@intel.com>
+  - Miri Korenblit <miriam.rachel.korenblit@intel.com>
+
+description:
+  Intel Wi-Fi 7 BE200 (BE200NGW) IEEE 802.11be discrete PCIe adapter.
+
+allOf:
+  - $ref: /schemas/net/wireless/ieee80211.yaml#
+
+properties:
+  compatible:
+    enum:
+      - pci8086,272b
+
+  reg:
+    maxItems: 1
+
+  intel,wrds:
+    description: |
+      SAR (Specific Absorption Rate) transmit power limits per antenna chain
+      and frequency subband, in units of 0.125 dBm.
+
+      First cell is the mode word: bit 0 set enables SAR limiting, bit 0
+      clear disables it (device uses its certified maximum).
+
+      Followed by 48 limit values for four antenna chains in order:
+      chain A, chain B, CDB chain A, CDB chain B. Each chain has 12
+      subband values covering the following frequency ranges:
+
+        [0]  2.4 GHz  ch  1-13   (2412-2472 MHz)
+        [1]  5 GHz    ch 36-64   (5180-5320 MHz)
+        [2]  5 GHz    ch 68-96   (5340-5480 MHz)
+        [3]  5 GHz    ch 100-144 (5500-5720 MHz)
+        [4]  5 GHz    ch 149-177 (5745-5885 MHz)
+        [5]  6 GHz    ch  1-45   (5955-6175 MHz)
+        [6]  6 GHz    ch 49-93   (6195-6415 MHz)
+        [7]  6 GHz    ch 97-115  (6435-6525 MHz)
+        [8]  6 GHz    ch 117-151 (6535-6705 MHz)
+        [9]  6 GHz    ch 153-183 (6715-6865 MHz)
+        [10] 6 GHz    ch 185-233 (6875-7115 MHz)
+        [11] 6 GHz    ch 237-253 (7135-7215 MHz)
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 49
+    maxItems: 49
+
+  intel,uats:
+    description: |
+      Per-country enablement matrix for 6 GHz AP types. 338-byte array
+      encoding which AP types (AFC, VLP, LPI) are permitted per country.
+
+      Countries are identified by ISO 3166-1 alpha-2 code. The matrix
+      covers all 26x26 = 676 two-letter combinations (AA..ZZ), stored
+      column-major (all second-letter variants for first letter A first,
+      then B, and so on). 26 columns x 13 bytes = 338 bytes total.
+
+      Each country occupies 4 bits (a nibble); two countries are packed
+      per byte, low nibble first:
+        bit 0: AFC (Standard Power AP) permitted
+        bit 1: VLP (Very Low Power AP) permitted
+        bit 2: LPI (Low Power Indoor AP) permitted
+
+      A bit is only effective when the corresponding control bit in
+      intel,6e-uhb is also set (bit 30 for AFC, bit 29 for VLP,
+      bit 31 for LPI per-country mode).
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    minItems: 338
+    maxItems: 338
+
+  intel,srd:
+    description: |
+      ETSI 5.8 GHz SRD (Short Range Device) channel behaviour in the
+      5725-5875 MHz band for ETSI regulatory domains.
+
+        active-scan  - active scanning permitted (default)
+        passive-scan - device may associate and transfer data but must
+                       not transmit probe requests on SRD channels
+        disabled     - device must not scan, associate, or operate on
+                       any SRD channel
+    enum:
+      - active-scan
+      - passive-scan
+      - disabled
+
+  intel,6e-uhb:
+    description: |
+      6-7 GHz Ultra-High Band (UHB) per-country enable bitmask.
+
+        bit 0:     override control; 0 = use device defaults,
+                   1 = force-disable all countries not explicitly
+                   enabled in bits 1-25
+        bit  1:    USA
+        bit  2:    Rest of World (ROW)
+        bit  3:    EU
+        bit  4:    South Korea
+        bit  5:    Brazil
+        bit  6:    Chile
+        bit  7:    Japan
+        bit  8:    Canada
+        bit  9:    Morocco
+        bit 10:    Mongolia
+        bit 11:    Malaysia
+        bit 12:    Saudi Arabia
+        bit 13:    Mexico
+        bit 14:    Nigeria
+        bit 15:    Thailand
+        bit 16:    Singapore
+        bit 17:    Taiwan
+        bit 18:    South Africa
+        bit 19:    Philippines
+        bit 20:    Serbia
+        bit 21:    Indonesia
+        bit 22:    Azerbaijan
+        bit 23:    Paraguay
+        bit 24:    Vietnam
+        bit 25:    India
+        bit 27:    enable VLP active scan, SoftAP, and P2P-GO in Japan
+        bit 29:    enable VLP mode per intel,uats country table
+        bit 30:    enable AFC mode per intel,uats country table
+        bit 31:    use intel,uats country table for LPI (0 = group mode)
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  intel,regulatory-special:
+    description: |
+      Special regulatory configuration flags.
+
+        bit 4:    enable Australia UHB band extension
+        bit 5:    Bangladesh 6 GHz UHB enablement
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  intel,activate-channel:
+    description: |
+      Indoor channel activation bitmask. Enables specific frequency bands
+      for active use when the platform is operating indoors.
+
+        bit 0:    EU U-NII-1 (5150-5250 MHz)
+        bit 1:    Japan U-NII-1 (5150-5250 MHz)
+        bit 2:    China Mainland U-NII-1 (5150-5250 MHz)
+        bit 3:    USA U-NII-4 (5850-5925 MHz)
+        bit 4:    Worldwide U-NII-1 (5150-5250 MHz) for any country
+                  where the band is permitted indoors
+        bit 5:    Canada U-NII-4 (5850-5925 MHz)
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  intel,force-disable-channels:
+    description: |
+      Per-band force-disable bitmask. Permanently disables specific
+      frequency bands regardless of regulatory domain.
+
+        bit  0:    2.4 GHz  (ch   1-13,  2412-2472 MHz)
+        bit  1:    5.2 GHz  (ch  36-48,  5180-5240 MHz)
+        bit  2:    5.3 GHz  (ch  52-64,  5260-5320 MHz)
+        bit  3:    5.5 GHz  (ch 100-144, 5500-5720 MHz)
+        bit  4:    5.8 GHz  (ch 149-165, 5745-5825 MHz)
+        bit  5:    5.9 GHz  (ch 169-177, 5845-5885 MHz)
+        bit  6:    6.2 GHz  (ch   1-93,  5955-6415 MHz)
+        bit  7:    6.5 GHz  (ch  97-113, 6435-6525 MHz)
+        bit  8:    6.6 GHz  (ch 117-153, 6535-6705 MHz)
+        bit  9:    6.8 GHz  (ch 157-185, 6715-6885 MHz)
+        bit 10:    7.0 GHz  (ch 185-233, 6875-7115 MHz)
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  intel,11be:
+    description: |
+      802.11be (Wi-Fi 7) per-country enable bitmask.
+
+        bit 0:    China (CN)
+        bit 1:    South Korea
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  intel,splc:
+    description:
+      Platform thermal power limit for the Wi-Fi core in mW. The device
+      will not exceed this limit regardless of regulatory maximums.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+
+  intel,wcpe:
+    description: |
+      802.11be channel puncturing enable bitmask. When set, allows the
+      device to puncture (skip) sub-channels within a wide channel for
+      coexistence with incumbents, subject to country certification.
+
+        bit 0:    USA
+        bit 1:    Canada
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  intel,wbem:
+    description: |
+      320 MHz channel bandwidth enable bitmask per country. Each bit
+      takes effect only if the installed module is certified for 320 MHz
+      in that country.
+
+        bit 0:    Japan
+        bit 1:    South Korea
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    pcie {
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        pcie@0 {
+            device_type = "pci";
+            reg = <0x0 0x0 0x0 0x0 0x0>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            ranges;
+            bus-range = <0x01 0xff>;
+
+            wifi@0 {
+                compatible = "pci8086,272b";
+                reg = <0x10000 0x0 0x0 0x0 0x0>;
+
+                /* SAR power limits: mode + 4 chains x 12 subbands */
+                intel,wrds = <
+                    0x01
+                    0x38 0x38 0x38 0x38 0x38 0x38 0x38 0x38 0x38 0x38 0x38 0x38
+                    0x38 0x38 0x38 0x38 0x38 0x38 0x38 0x38 0x38 0x38 0x38 0x38
+                    0x3c 0x3c 0x3c 0x3c 0x3c 0x3c 0x3c 0x3c 0x3c 0x3c 0x3c 0x3c
+                    0x3c 0x3c 0x3c 0x3c 0x3c 0x3c 0x3c 0x3c 0x3c 0x3c 0x3c 0x3c
+                >;
+
+                intel,splc = <4500>;
+                intel,wcpe = <0x03>;
+                intel,wbem = <0x03>;
+                intel,srd = "passive-scan";
+                intel,activate-channel = <0x01>;
+                intel,6e-uhb = <0x06>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 77fdfcb55f06..674320ef137e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13256,6 +13256,7 @@ L:	linux-wireless@vger.kernel.org
 S:	Supported
 W:	https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git/
+F:	Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml
 F:	drivers/net/wireless/intel/iwlwifi/
 
 INTEL VISION SENSING CONTROLLER DRIVER
-- 
2.34.1


