Return-Path: <linux-wireless+bounces-36374-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nqQIN7QUBGq0DQIAu9opvQ
	(envelope-from <linux-wireless+bounces-36374-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 08:05:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CAE52DEA6
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 08:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E0F93046FA4
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 06:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327523D3324;
	Wed, 13 May 2026 06:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dq/PqxOl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD953A75AC;
	Wed, 13 May 2026 06:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778652338; cv=none; b=VkgO6CHq7cYtWypWQCWPhNMrqfvyuXqdLdkM9LoJEIg9LrtqHqhUxhgoFXy3EPffK1ihav2UECIrFxajXejsMTh484rdejCTwsU5aWcrYlsdATWnBfllpmQukMKB+A6mgU/DuVmsN03jTtcXRk9/RMRjFBsrhoWHC5RfBWz3Woo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778652338; c=relaxed/simple;
	bh=Hq08dHgKz14oAgGCv5akH9xnVoHNj3pJYcbEHH4b1c0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SseMxrTT2MZsxpC7nRnvbtb/i4Jf1BJI1/RvrWviqb/QDiw/cW0ypEBV9QB1mPY2q4vPcsUDeRJ6gvqEPRg0svhS+c0Py62Met634HJDsQQnaBPrqW+0tCthNLpDhJcK6gWKc+z9Mk0o8Kmdy2lUnXn/Tr0vf7OYhK0CwN9Z4lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dq/PqxOl; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778652336; x=1810188336;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Hq08dHgKz14oAgGCv5akH9xnVoHNj3pJYcbEHH4b1c0=;
  b=dq/PqxOlC4lL+/lAH3GsF2idZ4D8N3XQzhuKnAy7ngJmqN1c6ZKklC1P
   Hd7ueT7sKYABu71J58G9BKvO4e4RbzcV+Isbp589EczXwk2l7SiJK/1zn
   eGTtFQPmfKvxBf/jP9g1LIXs2JgcN83lK6nD6Jy2FoYfuU8Jro4TTGur7
   RuHtmlIwn+kApSj2WXWq7gatvc0dNRkyXjRl01GfP/3+40byInePYTUwG
   4Agi9Ljjtlcr5WBwdXZ1AA9NSGk0GJpQ9ZwctL/nc3UCojegj0aIcDW7K
   FnrrkMFmH9zbOq1er/QuF/dEQ3nH8q7Bc7DI1pDwHop8yRbiBPWdjixCQ
   A==;
X-CSE-ConnectionGUID: FLDAFvYRT0uiG5HfuPtWuQ==
X-CSE-MsgGUID: O9E8W0QESo25mrvLabmvaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79601633"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="79601633"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 23:05:35 -0700
X-CSE-ConnectionGUID: xMWOV847TOa2ZMYy5G2EUg==
X-CSE-MsgGUID: h1GUWAuXQBqyBc8ftV9N6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="235316978"
Received: from iapp347.iil.intel.com (HELO localhost) ([10.167.28.6])
  by fmviesa008.fm.intel.com with ESMTP; 12 May 2026 23:05:32 -0700
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
Subject: [PATCH v3 0/3] wifi: iwlwifi: add Device Tree hardware integration information
Date: Wed, 13 May 2026 09:05:28 +0300
Message-Id: <20260513060531.8130-1-avinash.bhatt@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 67CAE52DEA6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[avinash.bhatt@intel.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-36374-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add Device Tree support for Intel Wi-Fi hardware integration information
on platforms that do not provide UEFI variables or ACPI methods.

Patch 1/3 adds the DT binding schema for the Intel iwlwifi compatible
node. Patches 2/3 and 3/3 add the driver infrastructure and integrate
DT as the lowest-priority fallback after UEFI and ACPI; they are
included for reference to show how the binding is consumed by the
driver and will be merged through the regular iwlwifi upstreaming
process, not through the DT tree.

Changes since v2:

Binding (patch 1/3):
  - Subject and title updated to describe the BE200 hardware
  - Revision header cell removed from all properties; each property is
    now a scalar uint32 or plain fixed-size array
  - intel,wrds: reduced to 49 cells (mode word + 4x12 SAR values)
  - intel,uats: reduced to 338 bytes (26x13 country nibble matrix)
  - Removed allOf/items const: 0 constraints from all properties
  - intel,srd: changed from integer enum to string enum
    (active-scan/passive-scan/disabled)
  - Removed "reserved, must be 0" annotations; bits with no assigned
    meaning are not documented
  - Added allOf: $ref: /schemas/net/wireless/ieee80211.yaml#

Driver (patch 2/3):
  - Removed dsm_func_to_prop_name() and all IWL_DT_PROP_* defines;
    each property function now calls of_property_read_*() directly with
    the literal property string
  - Driver updated to match binding changes (no revision cells,
    string-based intel,srd, scalar uint32 DSM properties, 338-byte
    intel,uats)
  - Added iwl_dt_init() to validate DT node compatible at probe time;
    all DT reads gated on fwrt->dt_compatible
  - fw/dt.h now includes fw/runtime.h directly, making it self-contained

Fallback integration (patch 3/3):
  - No changes from v2

Link to v2: https://patchwork.kernel.org/project/linux-wireless/patch/20260504095327.30892-1-avinash.bhatt@intel.com/
Link to v1: https://patchwork.kernel.org/project/linux-wireless/patch/20260429081403.46087-2-avinash.bhatt@intel.com/
Link to RFC: https://patchwork.kernel.org/project/devicetree/patch/20260408055709.11579-2-avinash.bhatt@intel.com/

Avinash Bhatt (3):
  dt-bindings: net: wireless: Add Intel Wi-Fi 7 BE200 PCIe adapter
  wifi: iwlwifi: dt: add Device Tree BIOS configuration infrastructure
  wifi: iwlwifi: dt: use Device Tree as fallback BIOS configuration source

 .../bindings/net/wireless/intel,iwlwifi.yaml  | 248 +++++++++++++++++
 MAINTAINERS                                   |   1 +
 drivers/net/wireless/intel/iwlwifi/Makefile   |   1 +
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |   5 +-
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/dt.c    | 332 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/dt.h    | 161 +++++++++
 drivers/net/wireless/intel/iwlwifi/fw/init.c  |   4 +-
 .../wireless/intel/iwlwifi/fw/regulatory.c    |   3 +++
 .../wireless/intel/iwlwifi/fw/regulatory.h    |   3 +-
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h |  6 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.c |   3 +++
 .../intel/iwlwifi/mld/regulatory.c            |   5 ++-
 13 files changed, 772 insertions(+), 11 deletions(-)

-- 
2.34.1

