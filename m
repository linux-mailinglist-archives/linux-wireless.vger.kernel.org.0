Return-Path: <linux-wireless+bounces-37196-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBBkKykTHGraJQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37196-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 12:53:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF56F615A77
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 12:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C76393012EAE
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 10:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A6C376A08;
	Sun, 31 May 2026 10:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GTBStu0j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76E4376A02
	for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 10:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780224806; cv=none; b=OG0uaszc1eDRtikcEVn9fhNBZK5XiCuHdFXUOjRHV7a1CZQsYW5ZjP0duHbjDlHc2T/irrwVhHM5/FWPItha3YNyzsHC+yVDNVCH8bb2IVj1hFnUFacXXimwNrBbqUy4wo81QRq8hiO+Od2TQmsm7hJxuWmnRxNtEfjIWH7PjMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780224806; c=relaxed/simple;
	bh=wXHFbYlTudrXwyHUhgBAVh85Gjfd/vTkYf2ZKmCc4LA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=cQNB05rymEWBIXW3WKLY+5Xq9EeP54vDqvLfGpECZ/HwREl0GvCi47XpLcIsxF0brJSGp82NkKV0p94/MiYnwnmQJ2MYmIVE87DEXyKZwpXBnx1+F99fQ4vc9ed+vr8VIoJJZPtGDvw7Orlx4IxQ8IBZDH9aBuYs5M8K09XPquI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GTBStu0j; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780224805; x=1811760805;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wXHFbYlTudrXwyHUhgBAVh85Gjfd/vTkYf2ZKmCc4LA=;
  b=GTBStu0jXYdsfXYJjHRJ3pkRLo4xiIvenEYWTNBbLQH5zpKMVu0lm1/S
   873XCuZZVi5eOHYfsnsQ35TXZDKPjSsyuHgBqEVTrnShlVN8djmx47Eiy
   cz8zwLPgnpqIcFx+qe/j2W8Ihr2+zCKWcywfli6zdwoARwmuCRxINKkk7
   khAuFHMcVgO9tKW8rgwS8gTM9+wBDtxA9GOZzGpDmifafMumg0N5pzyGg
   bJnETuqN35rryzd0vJ04Xvs3xm+puFxeZbqlzd7p2LfdIsUyjCSeCWwz7
   X886XxfeuQC+hy7jJXvso37TwL4lRvkD1DfDD79yDTR4E1tWvLLmJaDLO
   w==;
X-CSE-ConnectionGUID: KEehtLwsTyW8QlMz4xReNw==
X-CSE-MsgGUID: Qtp23T5gQi6GJz2+2tcJAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11802"; a="80039661"
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="80039661"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 03:53:24 -0700
X-CSE-ConnectionGUID: Ft8UP6HuTBuPQNkSRAnbZg==
X-CSE-MsgGUID: bmPWwpoDRu64V5wkoFHkVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="240295982"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 03:53:23 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 00/10] wifi: iwlwifi: updates - 2026-05-31
Date: Sun, 31 May 2026 13:52:59 +0300
Message-Id: <20260531105309.125363-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
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
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-37196-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PRECEDENCE_BULK(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AF56F615A77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

A few cleanups, features and bugfixes from our internal tree.

Thanks,
Miri
---

Avinash Bhatt (2):
  wifi: iwlwifi: mld: add KUnit tests for PSD/EIRP RSSI adjustment
  wifi: iwlwifi: mld: add KUnit tests for link grading

Emmanuel Grumbach (1):
  wifi: iwlwifi: bump maximum core version for BZ/SC/DR to 106

Johannes Berg (1):
  wifi: iwlwifi: pcie: fix write pointer move detection

Miri Korenblit (3):
  wifi: iwlwifi: fix a typo
  wifi: iwlwifi: trans: export the maximum supported hcmd size
  wifi: iwlwifi: mvm: remove __must_check annotation from command
    sending

Shahar Tzarfati (3):
  wifi: iwlwifi: remove orphaned DC2DC config enum
  wifi: iwlwifi: stop supporting core101
  wifi: iwlwifi: mld: drop TLC config cmd v4/v5 compat code

 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |   4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c   |   4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |   4 +-
 .../wireless/intel/iwlwifi/fw/api/config.h    |  11 +-
 .../wireless/intel/iwlwifi/fw/api/datapath.h  |   2 +-
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    |  31 --
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   2 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   4 +
 drivers/net/wireless/intel/iwlwifi/mld/link.c |  12 +-
 drivers/net/wireless/intel/iwlwifi/mld/link.h |   1 +
 .../intel/iwlwifi/mld/tests/link-selection.c  | 280 +++++++++++--
 .../wireless/intel/iwlwifi/mld/tests/link.c   | 372 ++++++++++++++++++
 .../wireless/intel/iwlwifi/mld/tests/utils.h  |   2 +
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c  |  74 ----
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  20 +-
 .../intel/iwlwifi/pcie/gen1_2/trans.c         |   4 +-
 16 files changed, 657 insertions(+), 170 deletions(-)

-- 
2.34.1


