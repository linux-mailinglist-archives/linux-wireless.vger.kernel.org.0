Return-Path: <linux-wireless+bounces-34512-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBa3HUnu1Wkv/gcAu9opvQ
	(envelope-from <linux-wireless+bounces-34512-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 07:57:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FD63B763C
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 07:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33A20302EAB6
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2026 05:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2789836214B;
	Wed,  8 Apr 2026 05:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E5H0dCIN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C66D27702D;
	Wed,  8 Apr 2026 05:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775627842; cv=none; b=ELHTGCaJyNARoaTrP4F5jjm1642FuyBURFayqNy5FzcUQIpVi/uWYbURX6WNsllN5QbX494n04c2TZPZZ+SGYA72nSGYoNkmtB3wMMzSOSNb+PdqwtSiXjb5lZbh5oLSuUvP2msy6oLmS1lVW4e7T/3EMh1Ou0yr7n3ljzOy3HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775627842; c=relaxed/simple;
	bh=fY9tRvNU4ffWcLymQ5STSGKQK6zbBYiJUDdd8E4Zqu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uSYGpVOd2ucpGtA8i5gpm6tZC+8UuwZwuQhLscQALr2/U5BQnnc38n0V01u7hGbgQuOY29xljA3Idx16kAWlOMTT6g2+8GDXtGm17jlcKnxCI/9+HcweWKhqN0J5AOr1+nEQwQYIy/44M0hNwk0w01Ulr4zbVxYGFqVsUZJ2Mbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E5H0dCIN; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775627840; x=1807163840;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fY9tRvNU4ffWcLymQ5STSGKQK6zbBYiJUDdd8E4Zqu8=;
  b=E5H0dCINSbYpUhlwn2BvYBNjfpWcL777/8AONPgqubktHRPnBhZWQ9Yb
   mkuhQN49slkXtMDkQD+myVb7WU915YM61kgFMtCnAVnXve9WCt/8NEAEd
   hQfkV+3qkog7D3d4jGzvHAsjKRQhSldrUq/F5VN1ijOtyaFrfoi2ghTqr
   u7bU1v395Ft/oMWCQCkRcDIVWzCTC6Hn5889nIZt70JLBbrDYCKN+8lkH
   ZftGkVly6UrmuvYjLjDqIC52ssmCRgMC6X9Hpep0mQtdq5ZkoEJGoBvqi
   Hc5TJY74jVhYY1wizuBAe3yVCxkoYSKVKZbeqFrVe6Ts7IdMXk1UzOAoe
   w==;
X-CSE-ConnectionGUID: uAg4pmOdTZ+PmyzVyFAPAw==
X-CSE-MsgGUID: jS99/LWPQOiG5cjq+fa9Wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="86893680"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="86893680"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 22:57:20 -0700
X-CSE-ConnectionGUID: 6fsv0vX3QKCt7hWf1VNqTw==
X-CSE-MsgGUID: 1R8Zjvn0RR2w/jOotuQcbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="227355742"
Received: from iapp347.iil.intel.com (HELO localhost) ([10.167.28.6])
  by orviesa006.jf.intel.com with ESMTP; 07 Apr 2026 22:57:17 -0700
From: Avinash Bhatt <avinash.bhatt@intel.com>
To: devicetree@vger.kernel.org
Cc: linux-wireless@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	johannes@sipsolutions.net,
	johannes.berg@intel.com,
	miriam.rachel.korenblit@intel.com,
	kobi.guetta@intel.com,
	emmanuel.grumbach@intel.com,
	Avinash Bhatt <avinash.bhatt@intel.com>
Subject: [RFC PATCH 1/1] dt-bindings: net: wireless: intel,iwlwifi: add binding
Date: Wed,  8 Apr 2026 08:57:09 +0300
Message-Id: <20260408055709.11579-2-avinash.bhatt@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408055709.11579-1-avinash.bhatt@intel.com>
References: <20260408055709.11579-1-avinash.bhatt@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34512-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avinash.bhatt@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid,devicetree.org:url,0.0.0.0:email]
X-Rspamd-Queue-Id: E8FD63B763C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a devicetree schema binding for Intel discrete Wi-Fi 7 BE200 PCIe
adapters.

The binding documents OEM platform configuration properties for
platforms that use Device Tree instead of platform firmware
methods. All properties mirror the existing equivalents in
structure and semantics, covering SAR power limits (intel,wrds),
6 GHz AP type support (intel,uats), static power limit
(intel,splc), channel puncturing (intel,wcpe), 320 MHz per-MCC
enablement (intel,wbem), ETSI SRD channel configuration
(intel,srd), 6-7 GHz UHB country enable bitmask (intel,6e-uhb),
and additional regulatory override properties.

type=feature
ticket=jira:WREQ-381155
ticket=jira:WIFI-849497

Signed-off-by: Avinash Bhatt <avinash.bhatt@intel.com>
Change-Id: Ic24d78a95b428dc2b93b603dcf4ea6f57384eee3
---
 .../bindings/net/wireless/intel,iwlwifi.yaml  | 413 ++++++++++++++++++
 1 file changed, 413 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml

diff --git a/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml b/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml
new file mode 100644
index 000000000000..6f6cec9e5749
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml
@@ -0,0 +1,413 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2026 Intel Corporation
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wireless/intel,iwlwifi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel iwlwifi PCIe Wi-Fi devices
+
+maintainers:
+  - Avinash Bhatt <avinash.bhatt@intel.com>
+  - linux-wireless@vger.kernel.org
+
+description:
+  Intel iwlwifi IEEE 802.11be discrete Wi-Fi adapters connected over PCIe.
+  These bindings provide OEM platform configuration for platforms that use Device Tree.
+
+properties:
+  compatible:
+    enum:
+      - pci8086,272b  # Wi-Fi 7 BE200 (discrete)
+
+  reg:
+    maxItems: 1
+
+  intel,wrds:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      Wi-Fi Regulatory Domain Settings (WRDS). SAR (Specific Absorption Rate)
+      transmit power limits per antenna chain and frequency subband. Values
+      are 8-bit unsigned in units of 0.125 dBm.
+
+      Revision 3 layout: 4 chains x 12 subbands = 50 cells total.
+      Chain A and Chain B are the two physical antenna paths; CDB Chain A
+      and CDB Chain B carry separate limits for simultaneous dual-band
+      operation.
+
+      Header (2 cells):
+        [0] revision - structure revision, must be 0x03
+        [1] mode     - bit 0: 0 = SAR disabled, 1 = SAR enabled; bits [8:1]: set to 0
+
+      Followed by 4 chains in order: chain_a, chain_b, cdb_chain_a,
+      cdb_chain_b, each containing 12 subband values:
+
+      Subband index to frequency range mapping:
+        [0]  2.4 GHz  ch  1-13   (2412-2472 MHz)
+        [1]  5 GHz    ch 36-64   (5180-5320 MHz, UNII-1/2)
+        [2]  5 GHz    ch 68-96   (5340-5480 MHz, UNII-2)
+        [3]  5 GHz    ch 100-144 (5500-5720 MHz, UNII-2e)
+        [4]  5 GHz    ch 149-188 (5745-5940 MHz, UNII-3/4)
+        [5]  6 GHz    ch  1-45   (5955-6175 MHz, UNII-5 lower)
+        [6]  6 GHz    ch 49-93   (6195-6415 MHz, UNII-5 upper)
+        [7]  6 GHz    ch 97-115  (6435-6525 MHz, UNII-6)
+        [8]  6 GHz    ch 117-151 (6535-6705 MHz, UNII-7 lower)
+        [9]  6 GHz    ch 153-183 (6715-6865 MHz, UNII-7 upper)
+        [10] 6 GHz    ch 185-233 (6875-7115 MHz, UNII-8)
+        [11] 6 GHz    ch 237-253 (7135-7215 MHz, UNII-9)
+    minItems: 50
+    maxItems: 50
+
+  intel,uats:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: |
+      UHB (Ultra High Band / 6 GHz) AP Type Support (UATS). Per-country
+      enablement matrix for 6 GHz AP types. Uses byte array format
+      (DTS [ ... ] notation).
+
+      In the 6 GHz band, regulatory rules differ per country and per AP
+      type: AFC (Standard Power), LPI (Low Power Indoor), and VLP (Very
+      Low Power). This matrix encodes which AP types are permitted to
+      operate in each country.
+
+      Revision 1 layout (339 bytes total):
+        [0]   revision    - structure revision, must be 0x01
+        [1+]  country_map - 338-byte matrix encoding AP type allowances
+                            per country.
+
+                            Countries are identified by their ISO 3166-1
+                            alpha-2 code (two letters, A-Z each). The
+                            matrix covers all 26x26 = 676 possible
+                            two-letter combinations (AA..ZZ), most of
+                            which are unused (set to 0x0).
+
+                            Each country entry is 4 bits (a nibble). Two
+                            entries are packed per byte: the low nibble
+                            holds the even-indexed entry, the high nibble
+                            holds the odd-indexed entry. For example,
+                            byte value 0x53 means: entry[even]=0x3,
+                            entry[odd]=0x5.
+
+                            The matrix is stored column-major by first
+                            letter: all 26 second-letter variants for
+                            first letter 'A' occupy bytes [0..12], then
+                            first letter 'B' occupies bytes [13..25],
+                            and so on for all 26 first letters.
+                            26 columns x 13 bytes = 338 bytes total.
+
+                            Each 4-bit nibble encodes AP type allowances
+                            for one country:
+                              bit 0: AFC (Standard Power AP) allowed
+                              bit 1: VLP (Very Low Power AP) allowed
+                              bit 2: LPI (Low Power Indoor AP) allowed
+                              bit 3: reserved, must be 0
+
+                            Note: each bit is only effective when the
+                            corresponding control bit in intel,6e-uhb
+                            is also set (bit 30 for AFC, bit 29
+                            for VLP, bit 31 for LPI country-by-country
+                            mode).
+    minItems: 339
+    maxItems: 339
+
+  intel,srd:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      ETSI 5.8 GHz SRD (Short Range Device) channel configuration.
+      Controls how the driver handles the 5725-5875 MHz (5.8 GHz) SRD
+      channels in ETSI regulatory domains.
+
+      Layout (2 cells):
+        [0] revision - structure revision, must be 0x00
+        [1] value    - channel configuration:
+                       0 = active scan permitted (default behaviour)
+                       1 = passive scan only; device may associate and
+                           transfer data but must not transmit probe
+                           requests on SRD channels
+                       2 = SRD channels fully disabled; the device must
+                           not scan, associate, or operate on any of the
+                           5725-5875 MHz SRD channels
+    minItems: 2
+    maxItems: 2
+
+  intel,6e-uhb:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      6-7 GHz Ultra-High Band (UHB) per-country enable bitmask.
+
+      Layout (2 cells):
+        [0] revision - structure revision, must be 0x00
+        [1] bitmap   - UHB enablement control:
+                       bit 0:     override control; 0 = use device defaults,
+                                  1 = force-disable all countries not
+                                  explicitly enabled in bits 1-25
+                       bits 1-25: per-country/region enable flags:
+                                  bit  1 = USA
+                                  bit  2 = Rest of World (ROW)
+                                  bit  3 = EU
+                                  bit  4 = South Korea
+                                  bit  5 = Brazil
+                                  bit  6 = Chile
+                                  bit  7 = Japan
+                                  bit  8 = Canada
+                                  bit  9 = Morocco
+                                  bit 10 = Mongolia
+                                  bit 11 = Malaysia
+                                  bit 12 = Saudi Arabia
+                                  bit 13 = Mexico
+                                  bit 14 = Nigeria
+                                  bit 15 = Thailand
+                                  bit 16 = Singapore
+                                  bit 17 = Taiwan
+                                  bit 18 = South Africa
+                                  bit 19 = Philippines
+                                  bit 20 = Serbia
+                                  bit 21 = Indonesia
+                                  bit 22 = Azerbaijan
+                                  bit 23 = Paraguay
+                                  bit 24 = Vietnam
+                                  bit 25 = India
+                       bit 26:    reserved, must be 0
+                       bit 27:    enable VLP active scan, SoftAP, and
+                                  P2P-GO operation in Japan
+                       bit 28:    reserved, must be 0
+                       bit 29:    enable VLP (Very Low Power) mode per
+                                  country-by-country table
+                       bit 30:    enable AFC (Standard Power) mode per
+                                  country-by-country table
+                       bit 31:    LPI override mode; 0 = use grouping
+                                  mechanism, 1 = use country-by-country table
+    minItems: 2
+    maxItems: 2
+
+  intel,regulatory-special:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      Regulatory Special Configurations for China and indoor operation.
+
+      Layout (2 cells):
+        [0] revision - structure revision, must be 0x00
+        [1] bitmap   - configuration flags:
+                       bit 0 = enable DRS (Dynamic Regulatory Settings) for
+                               China Mainland; effective only on non-China SKUs
+                               (ignored if WRDD sets China SKU)
+                       bit 1 = enable China Mainland BIOS (CB) profile 5.2 GHz
+                               Active Scan/SoftAP override on indoor confirmation
+                       bit 2 = enable New China Mainland Regulatory Specification
+                               (0 = legacy specification)
+                       bits 3-31: reserved, must be 0
+    minItems: 2
+    maxItems: 2
+
+  intel,activate-channel:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      Indoor channel activation bitmask. Sets specific frequency bands to
+      active (rather than passive or disabled) when the platform is
+      confirmed to be operating indoors.
+
+      Layout (2 cells):
+        [0] revision - structure revision, must be 0x00
+        [1] bitmap   - per-region indoor activation flags:
+                       bit 0 = enable EU U-NII-1 (5.2 GHz) for indoors only
+                       bit 1 = enable Japan U-NII-1 (5.2 GHz) for indoors only
+                       bit 2 = enable China Mainland U-NII-1 (5.2 GHz) for indoors only
+                       bit 3 = enable USA U-NII-4 (5.9 GHz) for indoors only
+                       bit 4 = enable WW U-NII-1 (5.2 GHz) for indoors in any
+                               country where the band is permitted
+                       bit 5 = enable Canada U-NII-4 (5.9 GHz) for indoors only
+                       bit 6 = enable USA + Canada + WW U-NII-4 (5.9 GHz) for
+                               indoors only
+                       bits 7-31: reserved, must be 0
+    minItems: 2
+    maxItems: 2
+
+  intel,force-disable-channels:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      Selective Wi-Fi band force-disable bitmask. Allows the platform to
+      permanently disable specific frequency bands regardless of regulatory
+      domain.
+
+      Layout (2 cells):
+        [0] revision - structure revision, must be 0x00
+        [1] bitmap   - per-band force-disable flags:
+                       bit 0  = force disable 2.4 GHz (channels 1-13)
+                       bit 1  = force disable 5.2 GHz (channels 36-48)
+                       bit 2  = force disable 5.3 GHz (channels 52-64)
+                       bit 3  = force disable 5.5 GHz (channels 100-144)
+                       bit 4  = force disable 5.8 GHz (channels 149-165)
+                       bit 5  = force disable 5.9 GHz (channels 169-177)
+                       bit 6  = force disable 6.2 GHz (channels 1-93)
+                       bit 7  = force disable 6.5 GHz (channels 97-113)
+                       bit 8  = force disable 6.6 GHz (channels 117-153)
+                       bit 9  = force disable 6.8 GHz (channels 157-185)
+                       bit 10 = force disable 7.0 GHz (channels 185-233)
+                       bits 11-31: reserved, must be 0
+    minItems: 2
+    maxItems: 2
+
+  intel,11be:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      802.11be (Wi-Fi 7) per-country enable bitmask. Controls whether
+      802.11be operation is permitted in specific countries.
+
+      Layout (2 cells):
+        [0] revision - structure revision, must be 0x00
+        [1] bitmap   - per-country enable flags:
+                       bit 0 = enable 802.11be in China (CB/CN)
+                       bit 1 = enable 802.11be in South Korea
+                       bits 2-31: reserved, must be 0
+    minItems: 2
+    maxItems: 2
+
+  intel,splc:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      Wi-Fi Static Power Limit Capabilities (SPLC). Sets the platform thermal
+      power limit for the Wi-Fi core in mW. When not applicable, set
+      0xFFFFFFFF and the device uses its certified maximum.
+
+      Layout (2 cells):
+        [0] revision    - structure revision, must be 0x00
+        [1] power_limit - power limit in mW, or 0xFFFFFFFF if not applicable
+                          (device uses its certified maximum)
+    minItems: 2
+    maxItems: 2
+
+  intel,wcpe:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      Wi-Fi Channel Puncturing Enablement (WCPE). Enables 802.11be channel
+      puncturing for specific regulatory domains.
+
+      Layout (2 cells):
+        [0] revision   - structure revision, must be 0x00
+        [1] puncturing - per-country enable bitmask:
+                         bit 0: 1 = channel puncturing enabled for USA
+                         bit 1: 1 = channel puncturing enabled for Canada
+                         bits 2-31: reserved, must be 0
+    minItems: 2
+    maxItems: 2
+
+  intel,wbem:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      Wi-Fi 320 MHz Bandwidth Enablement per MCC (WBEM). Controls whether
+      320 MHz operation is permitted in specific countries.
+
+      Layout (2 cells):
+        [0] revision       - structure revision, must be 0x00
+        [1] wifi320mhz_mcc - per-country enable bitmask:
+                             bit 0: 1 = 320 MHz enabled for Japan
+                             bit 1: 1 = 320 MHz enabled for South Korea
+                             bits 2-31: reserved, must be 0
+
+                             Each bit takes effect only if the installed
+                             module is certified for 320 MHz in that country.
+    minItems: 2
+    maxItems: 2
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    /* ARM64 platform with Intel Wi-Fi 7 BE200 as discrete PCIe device */
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
+                /*
+                 * Wi-Fi Regulatory Domain Settings (SAR power limits).
+                 * Revision 3: 4 chains x 12 subbands = 50 cells total.
+                 * Layout: revision, mode, then 4 x chain[12].
+                 */
+                intel,wrds = <
+                    0x03 0x01
+                    /* Chain A: 12 subbands */
+                    0x38 0x38 0x38 0x38 0x38 0x38 0x38 0x38 0x38 0x38 0x38 0x38
+                    /* Chain B: 12 subbands */
+                    0x38 0x38 0x38 0x38 0x38 0x38 0x38 0x38 0x38 0x38 0x38 0x38
+                    /* CDB Chain A: 12 subbands */
+                    0x3c 0x3c 0x3c 0x3c 0x3c 0x3c 0x3c 0x3c 0x3c 0x3c 0x3c 0x3c
+                    /* CDB Chain B: 12 subbands */
+                    0x3c 0x3c 0x3c 0x3c 0x3c 0x3c 0x3c 0x3c 0x3c 0x3c 0x3c 0x3c
+                >;
+
+                /*
+                 * Static Power Limit: 4500 mW cap on this platform.
+                 * 2 u32 cells: revision, power_limit_mw.
+                 */
+                intel,splc = <0x00 0x1194>;
+
+                /*
+                 * Channel Puncturing: enabled for USA and Canada.
+                 * 2 u32 cells: revision, puncturing bitmask (bits 0+1).
+                 */
+                intel,wcpe = <0x00 0x03>;
+
+                /*
+                 * 320 MHz per MCC: Japan and South Korea enabled.
+                 * 2 u32 cells: revision, wifi320mhz_mcc.
+                 */
+                intel,wbem = <0x00 0x03>;
+
+                /* OEM regulatory configuration properties. */
+                intel,srd = <0x00 1>;            /* revision=0, passive scan only */
+                intel,activate-channel = <0x00 0x01>; /* revision=0, EU 5.2 GHz indoors */
+                intel,force-disable-channels = <0x00 0x00>; /* revision=0, no bands disabled */
+                intel,6e-uhb = <0x00 0x06>;      /* revision=0, USA (bit1) + Rest-of-World (bit2) */
+
+                /*
+                 * UHB AP Type Support (6 GHz country matrix).
+                 * Byte array: revision (0x01), then
+                 * 338 bytes of the 26x13 country enable map (all zeros
+                 * in this example = no countries enabled).
+                 */
+                intel,uats = [01
+                    00 00 00 00 00 00 00 00 00 00 00 00 00
+                    00 00 00 00 00 00 00 00 00 00 00 00 00
+                    00 00 00 00 00 00 00 00 00 00 00 00 00
+                    00 00 00 00 00 00 00 00 00 00 00 00 00
+                    00 00 00 00 00 00 00 00 00 00 00 00 00
+                    00 00 00 00 00 00 00 00 00 00 00 00 00
+                    00 00 00 00 00 00 00 00 00 00 00 00 00
+                    00 00 00 00 00 00 00 00 00 00 00 00 00
+                    00 00 00 00 00 00 00 00 00 00 00 00 00
+                    00 00 00 00 00 00 00 00 00 00 00 00 00
+                    00 00 00 00 00 00 00 00 00 00 00 00 00
+                    00 00 00 00 00 00 00 00 00 00 00 00 00
+                    00 00 00 00 00 00 00 00 00 00 00 00 00
+                    00 00 00 00 00 00 00 00 00 00 00 00 00
+                    00 00 00 00 00 00 00 00 00 00 00 00 00
+                    00 00 00 00 00 00 00 00 00 00 00 00 00
+                    00 00 00 00 00 00 00 00 00 00 00 00 00
+                    00 00 00 00 00 00 00 00 00 00 00 00 00
+                    00 00 00 00 00 00 00 00 00 00 00 00 00
+                    00 00 00 00 00 00 00 00 00 00 00 00 00
+                    00 00 00 00 00 00 00 00 00 00 00 00 00
+                    00 00 00 00 00 00 00 00 00 00 00 00 00
+                    00 00 00 00 00 00 00 00 00 00 00 00 00
+                    00 00 00 00 00 00 00 00 00 00 00 00 00
+                    00 00 00 00 00 00 00 00 00 00 00 00 00
+                    00 00 00 00 00 00 00 00 00 00 00 00 00];
+            };
+        };
+    };
-- 
2.34.1


