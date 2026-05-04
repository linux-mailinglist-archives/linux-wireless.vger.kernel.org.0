Return-Path: <linux-wireless+bounces-35826-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFP9BVpt+GnPuQIAu9opvQ
	(envelope-from <linux-wireless+bounces-35826-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 11:56:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDF54BB4D7
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 11:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D0D8301C58D
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 09:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01FB388E4A;
	Mon,  4 May 2026 09:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GFLWzOap"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC997388371;
	Mon,  4 May 2026 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777888413; cv=none; b=peb8H1+uQ15Lh+BpWNi8ekibJcJ7EFZbN6n9WlaYGmUys+xwdzIBJIrSfqfW8wBJ4NSEq7wClgi+VP4iL11gnnxh8SMYEvfHkgV6gNbVsBHyxvqvCgV1VqI2b4bZZ1GcyhRACBjk2JvTxgJ+IgpPleS5/KqRi8y17JVHzqevTRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777888413; c=relaxed/simple;
	bh=fJ5pGZN3tsjlK+iyEeIkxZfF7Yjz4GADR/R2AYCotqY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lMd2IEQwuebETJyAQpxysepnpe0DGeBdKdQzRj6lVpUM/F8k0Y3ZmenvFX5czxOB86gX+Qhsmzim9lqwKOTfb2G2sqq0JCf/o8e/W5Q+iUDIi69t194QMLQgRV26Kdflv7PFUhgmOKqVjIFlSUWs+kUvwyT5R2ppyqT1RHD/HPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GFLWzOap; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777888412; x=1809424412;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fJ5pGZN3tsjlK+iyEeIkxZfF7Yjz4GADR/R2AYCotqY=;
  b=GFLWzOapQOY90h/E5920Jgm5eH29dcIff+I021nKCvFL7Qdci6vCgnCU
   tkPA8U0nENAUaR3+UwxqTGJH7/ya0ZO3Q1/cn5ndFIUBp+eFQfzwLYPlC
   Q4XS7jqjQs1/GpnCCDcy/UeiztAeEzc5JtoLwUNDxscGGOytymzI+0Yum
   XPXY0Cf9UbhKJC7slhVE7gbAyWdOYVD9YGWuPR7y1GOFNwjzi3ZiP0a2p
   6HJsDfg7SQgOyCvGTpfF1wRJLAi7ddvwkKBlpXBobiSwWbNUMzaApqW0M
   ccC9GMk3iUVz8puJOqsSCPIy1W41Oor+dSs0p1axYHeYqAvw+afWntwus
   A==;
X-CSE-ConnectionGUID: G07Ohw/dRya44ylonsqEVg==
X-CSE-MsgGUID: ndcYgT8ZSb+x6l69v1iU1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="89434315"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="89434315"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 02:53:31 -0700
X-CSE-ConnectionGUID: O4tROrNFQtWR9mk2+M/W7g==
X-CSE-MsgGUID: 8gD+Oy6DSNG5BLxEAOcCnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="231116709"
Received: from iapp347.iil.intel.com (HELO localhost) ([10.167.28.6])
  by fmviesa010.fm.intel.com with ESMTP; 04 May 2026 02:53:28 -0700
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
	emmanuel.grumbach@intel.com,
	avinash.bhatt@intel.com
Subject: [PATCH v2 0/3] wifi: iwlwifi: add Device Tree hardware integration information
Date: Mon,  4 May 2026 12:53:24 +0300
Message-Id: <20260504095327.30892-1-avinash.bhatt@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3CDF54BB4D7
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-35826-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid]

Add Device Tree support for Intel Wi-Fi hardware integration information
on platforms that do not provide UEFI variables or ACPI methods.

Patch 1/3 adds the DT binding schema for the Intel iwlwifi compatible
node. Patches 2/3 and 3/3 add the driver infrastructure and integrate DT
as the lowest-priority fallback after UEFI and ACPI.

Changes in v2:
- Drop mailing list from maintainers in YAML binding
- Drop binding-purpose sentence from description
- Fix dtschema 2026.4 validation errors (items/minItems enforcement)
- Fix yamllint line length violations
- Add driver companion patches (2/3 and 3/3) for reference, showing how
  the binding is consumed by the driver; these will be merged through the
  regular iwlwifi upstreaming process, not through the DT tree

Link to v1: https://patchwork.kernel.org/project/linux-wireless/patch/20260429081403.46087-2-avinash.bhatt@intel.com/
Link to RFC: https://patchwork.kernel.org/project/devicetree/patch/20260408055709.11579-2-avinash.bhatt@intel.com/

Avinash Bhatt (3):
  dt-bindings: net: wireless: intel,iwlwifi: add binding
  wifi: iwlwifi: dt: add Device Tree BIOS configuration infrastructure
  wifi: iwlwifi: dt: use Device Tree as fallback BIOS configuration source

 drivers/net/wireless/intel/iwlwifi/Makefile   |   1 +
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |   5 +-
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/dt.c    | 321 ++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/dt.h    | 123 +++++++
 .../wireless/intel/iwlwifi/fw/regulatory.c    |   5 +-
 .../wireless/intel/iwlwifi/fw/regulatory.h    |   3 +-
 7 files changed, 455 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/dt.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/dt.h

-- 
2.34.1


