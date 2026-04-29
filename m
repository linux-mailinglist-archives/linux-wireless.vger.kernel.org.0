Return-Path: <linux-wireless+bounces-35578-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJk5HVfA8WkbkQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35578-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 10:24:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BE0491262
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 10:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E076301D38A
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 08:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915093AA1A8;
	Wed, 29 Apr 2026 08:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d5AJUbSF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50213AB299;
	Wed, 29 Apr 2026 08:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777450459; cv=none; b=LQw6gJR96Ln30XPsYR1Hk1UmefG9nMdrGbA50G01zefH7ASctYAHffT/+ATHJLtEbFXL7nNSMSP9ZzDqkVfgZjVhAdne+zDYtF/R2xm+N4h+/Vgje3CPVMoHEQJD2DEt+jKZaE0B1UUwfiNJuz1MtgpnUO+eoBqJBAYegYFfI/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777450459; c=relaxed/simple;
	bh=SfA/XBD4tb7kl62loThfHCftalLuvIVJ9CHlOEsVGzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rflb7M8nlOi7qUbhP9LV2J7/J2DIH0/sRaZ0/VU3+JoX0q3V8pCh4OJX++5elQ99UCOhb+dpsB8vyyCGp+X4k6xT1vyXTfjFXoFriieMp6pNrHDhcMnNo+RUA0NodspE4Hy9I3JbL0Og62xh1QuosCNNj+fN3a0jtuW2bjqmVr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d5AJUbSF; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777450455; x=1808986455;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SfA/XBD4tb7kl62loThfHCftalLuvIVJ9CHlOEsVGzo=;
  b=d5AJUbSFHL1JZnCpm5WkBqKRMHw9zkXXUyJEZyO6BHmZa6jcZTeSo8gq
   0IfADKfzaKY53rDR8MbH9Acm0GsBJQTofi8w2c2IcIrX+Bd47gdHHVTpp
   CMbVJ4UCfpFKLwegnXGwOrHFWB7BpTVQ7ZK4JWv/TrAU+unexeX3Sj5JI
   K1Npcgs9MxxWh6dwGANZRZkWGeCj0mMex4j51rZX/sYaNTOEdmIJdfwp/
   e7J5A9c7r8jvpmcQUsWWSgVeXtFQmU5L9sTbRkoi25tj7TXOqu+HurgOu
   5eB9fghjIisU7uGjczvALTNRVMx3NtJ1j2Ga9EpvMc+Il6x46tzHrZpDF
   w==;
X-CSE-ConnectionGUID: D1E3y121Ru++sJaGKjWMhQ==
X-CSE-MsgGUID: 5c41+5O1TlWK8eVOf/icOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="89751707"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="89751707"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 01:14:14 -0700
X-CSE-ConnectionGUID: abJWc6CATH66Tckc3Kg91w==
X-CSE-MsgGUID: lkLE7olwQgGcqbKb260IUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="235977986"
Received: from iapp347.iil.intel.com (HELO localhost) ([10.167.28.6])
  by fmviesa004.fm.intel.com with ESMTP; 29 Apr 2026 01:14:11 -0700
From: Avinash Bhatt <avinash.bhatt@intel.com>
To: devicetree@vger.kernel.org
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	johannes@sipsolutions.net,
	miriam.rachel.korenblit@intel.com,
	kobi.guetta@intel.com,
	emmanuel.grumbach@intel.com,
	Avinash Bhatt <avinash.bhatt@intel.com>
Subject: [PATCH 1/1] dt-bindings: net: wireless: intel,iwlwifi: add binding
Date: Wed, 29 Apr 2026 11:14:03 +0300
Message-Id: <20260429081403.46087-2-avinash.bhatt@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260429081403.46087-1-avinash.bhatt@intel.com>
References: <20260429081403.46087-1-avinash.bhatt@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 65BE0491262
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_ALLOW(0.00)[intel.com:s=Intel];
	TAGGED_FROM(0.00)[bounces-35578-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avinash.bhatt@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.978];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c15:e001:75::/64:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,devicetree.org:url]

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

Signed-off-by: Avinash Bhatt <avinash.bhatt@intel.com>
---
 .../bindings/net/wireless/intel,iwlwifi.yaml  | 445 ++++++++++++++++++
 1 file changed, 445 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml

diff --git a/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml b/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml
new file mode 100644
index 000000000000..d97be6cc35d8
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml
@@ -0,0 +1,445 @@
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
+      - pci8086,272b
+
+  reg:
+    maxItems: 1
+
+  intel,wrds:
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
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+      - minItems: 50
+        maxItems: 50
+        items:
+          - const: 3
+
+  intel,uats:
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
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint8-array
+      - minItems: 339
+        maxItems: 339
+        items:
+          - const: 1
+
+  intel,srd:
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
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+      - minItems: 2
+        maxItems: 2
+        items:
+          - const: 0
+          - enum: [0, 1, 2]
+
+  intel,6e-uhb:
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
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+      - minItems: 2
+        maxItems: 2
+        items:
+          - const: 0
+
+  intel,regulatory-special:
+    description: |
+      Regulatory Special Configurations.
+
+      Layout (2 cells):
+        [0] revision - structure revision, must be 0x00
+        [1] bitmap   - configuration flags:
+                       bits 0-3: reserved, must be 0
+                       bit 4 = Australia UHB extension
+                       bits 5-31: reserved, must be 0
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+      - minItems: 2
+        maxItems: 2
+        items:
+          - const: 0
+
+  intel,activate-channel:
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
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+      - minItems: 2
+        maxItems: 2
+        items:
+          - const: 0
+
+  intel,force-disable-channels:
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
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+      - minItems: 2
+        maxItems: 2
+        items:
+          - const: 0
+
+  intel,11be:
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
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+      - minItems: 2
+        maxItems: 2
+        items:
+          - const: 0
+
+  intel,splc:
+    description: |
+      Wi-Fi Static Power Limit Capabilities (SPLC). Sets the platform thermal
+      power limit for the Wi-Fi core in mW. Omit this property entirely if
+      no platform power limit applies; the device will use its certified
+      maximum in that case.
+
+      Layout (2 cells):
+        [0] revision    - structure revision, must be 0x00
+        [1] power_limit - maximum platform power budget in mW, must be
+                          non-zero (a zero value is equivalent to omitting
+                          the property)
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+      - minItems: 2
+        maxItems: 2
+        items:
+          - const: 0
+          - minimum: 1
+
+  intel,wcpe:
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
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+      - minItems: 2
+        maxItems: 2
+        items:
+          - const: 0
+
+  intel,wbem:
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
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+      - minItems: 2
+        maxItems: 2
+        items:
+          - const: 0
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


