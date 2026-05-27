Return-Path: <linux-wireless+bounces-37025-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAt2O41OF2qaAggAu9opvQ
	(envelope-from <linux-wireless+bounces-37025-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 22:05:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC095E9E1B
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 22:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DFA4300D9F3
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 20:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372AF3B47D2;
	Wed, 27 May 2026 20:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q25j6MIE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB1E3B4417
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 20:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779912330; cv=none; b=mUTW4KBVAaHhEo7TRis/DsDzfn5VkjUCE8WCZ2Yvz38Tv8jfGzyuBap/7uVYnDdOOy0YrhUgxfx2a0Rvi8mZSYVtCNpxZUecf3kUx7qIChexmhNSNFa4gfTvjrIIkOlspbHWYAFKrxm+NtE+v7uiKmHs4SThl2g2ApZYXZDIsKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779912330; c=relaxed/simple;
	bh=Aa8ClTMbBnLreeSHVv1anlXwMd20m+Qxilix1nbvTAQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=G1s4BZEolbyYzdZtBAYY1mmfxzhBm6cDNYbx/ofs9dfD7PhFsJ8ApklPowau2jwCc75QD2Nj9nrCl3U+p2AimtZLMfu0k2Xh/bWSN2/EDRUfFAgcan9Nru8w36dGt1U7cI46aMk6jWEKuaa/ss4KxuAMKdiXrYfvSwRyFVhUt44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q25j6MIE; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779912329; x=1811448329;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Aa8ClTMbBnLreeSHVv1anlXwMd20m+Qxilix1nbvTAQ=;
  b=Q25j6MIEAXfvPvi5+hb1ss8VzQREpVHdovNuBQrsEM2RJFL4grzQR7Br
   G35/PGZhgM9EBrMXe5V4o/eeFsbtUB1N0bD1BSbu554eBvblRhnll97zF
   UP6lbatDjgNUTUpq7ppT8+YUo8bvxFsHV9Y26DVgcc9i2DDwa9Rmi17vZ
   1CoyUDrTqxaWJNarIqY3cFCvvHRvTB3OWU6LdGSmGss7unCyiP9idQmO6
   SlvypeN/oFfDCV5hlekCjpsXVAYWI5VLQuZynMcp6fUE93ny+cycX7Rbg
   kskwpYlH0feR9yFtFk2JaHW3ZuiHCWZngKO3KMCpyPFsCiG1YKlgWEFbN
   Q==;
X-CSE-ConnectionGUID: cFs6vjhCQOa68j7l6agYRQ==
X-CSE-MsgGUID: dKBLX31fRy63OC7o/QCuTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80940845"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="80940845"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 13:05:28 -0700
X-CSE-ConnectionGUID: HJt8QKWaTbS7Y0aTmTLgwA==
X-CSE-MsgGUID: EQdKl2hWQHeTWc3H7iJWtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="247286944"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 13:05:27 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 00/15] wifi: iwlwifi: updates - 2026-05-27
Date: Wed, 27 May 2026 23:04:57 +0300
Message-Id: <20260527200512.506707-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-37025-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6FC095E9E1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Features, fixes and cleanups from our internal tree.

Miri
---

Avinash Bhatt (1):
  wifi: iwlwifi: mld: add KUnit tests for duplicated beacon RSSI
    adjustment

Ilan Peer (1):
  wifi: iwlwifi: mld: Require HT support for NAN

Israel Kozitz (1):
  wifi: iwlwifi: mld: support FW TLV for NAN max channel switch time

Johannes Berg (5):
  wifi: iwlwifi: fw: cut down NIC wakeups during dump
  wifi: iwlwifi: mvm: rename iwl_mvm_mac80211_idx_to_hwrate()
  wifi: iwlwifi: move iwl_fw_rate_idx_to_plcp() to mvm
  wifi: iwlwifi: mld: don't WARN on WoWLAN suspend w/o netdetect
  wifi: iwlwifi: mvm: fix P2P-Device binding handling

Miri Korenblit (4):
  wifi: iwlwifi: remove stale comment
  wifi: iwlwifi: remove mvm prefix from marker command
  wifi: iwlwifi: mld: fix smatch warning
  wifi: iwlwifi: mld: always allow mimo in NAN

Moriya Itzchaki (1):
  wifi: iwlwifi: fix STEP_URM register address for SC devices

Pagadala Yesu Anjaneyulu (1):
  wifi: iwlwifi: mld: set fast-balance scan for active EMLSR

Shahar Tzarfati (1):
  wifi: iwlwifi: cfg: Revert "wifi: iwlwifi: cfg: move the
    MODULE_FIRMWARE to the per-rf file"

 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |  12 +++
 .../net/wireless/intel/iwlwifi/cfg/rf-fm.c    |  12 ---
 .../wireless/intel/iwlwifi/fw/api/commands.h  |   4 +-
 .../net/wireless/intel/iwlwifi/fw/api/debug.h |  16 +--
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    |   3 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  96 ++++++++---------
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   1 +
 drivers/net/wireless/intel/iwlwifi/fw/img.h   |   1 +
 drivers/net/wireless/intel/iwlwifi/fw/rs.c    |  27 -----
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |   6 ++
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |   3 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |   5 +
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  11 ++
 drivers/net/wireless/intel/iwlwifi/mld/d3.c   |   7 +-
 drivers/net/wireless/intel/iwlwifi/mld/link.c |   3 +-
 drivers/net/wireless/intel/iwlwifi/mld/link.h |   5 +
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |   9 +-
 drivers/net/wireless/intel/iwlwifi/mld/nan.c  |   3 +-
 drivers/net/wireless/intel/iwlwifi/mld/scan.c |   8 +-
 drivers/net/wireless/intel/iwlwifi/mld/sta.c  |   6 ++
 .../wireless/intel/iwlwifi/mld/tests/link.c   | 102 +++++++++++++++++-
 .../wireless/intel/iwlwifi/mld/tests/utils.c  |  60 +++++++++++
 .../wireless/intel/iwlwifi/mld/tests/utils.h  |   7 +-
 drivers/net/wireless/intel/iwlwifi/mld/tx.c   |   3 +-
 .../net/wireless/intel/iwlwifi/mvm/binding.c  |   5 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |   6 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  12 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   6 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  10 +-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  32 +++++-
 .../intel/iwlwifi/pcie/gen1_2/internal.h      |   1 +
 .../intel/iwlwifi/pcie/gen1_2/trans-gen2.c    |  12 ++-
 .../intel/iwlwifi/pcie/gen1_2/trans.c         |   3 +-
 34 files changed, 367 insertions(+), 133 deletions(-)

-- 
2.34.1


