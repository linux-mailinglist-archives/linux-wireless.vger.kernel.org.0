Return-Path: <linux-wireless+bounces-36241-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JNwOL8aAmocoAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36241-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 20:06:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 771BA514121
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 20:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 813F430305CB
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 17:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A933B4E9A;
	Mon, 11 May 2026 17:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g+EogzMA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4465E3D16FD
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 17:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521008; cv=none; b=g1enFTwNsADdzV+T9u/MR4QzUOQIDu3jS3WXg3eubdJsrxIEBt9dNKfqeH1lMiDo/4/WavEM+csN2GFK9Eke8wy8RInw5Jaxaj3hD6L/FywIV0q0L9aIB7RGfg9NOShd4A7fL/NyiWqsoyxfNveSeVOtNmFJn/tggpXEJiQhsbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521008; c=relaxed/simple;
	bh=fJpA7FefBWdq1nhb31eLuuLHzR1QKDq9Z3y+lxUtKpg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=YpOEuK26syuO1QVwXt7cbRnZVqIsC7cPK0W1H2YSNqVcOyffFPzt2+/D9XVqcltIzvP5MbiiTI2G2GZEmASmM9n4rB6D3KWJ6ZJC4tMXxIPHmOoG6Y/hXovhNYWPDciQJzQHWSoEPZ+uOOGkTNtXrSzQ/EabdzwXiNK/fSczkVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g+EogzMA; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778521008; x=1810057008;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fJpA7FefBWdq1nhb31eLuuLHzR1QKDq9Z3y+lxUtKpg=;
  b=g+EogzMAI5dklVqphl8bkusj2zq3DGhrKVbQ6UI79OejOZp+ivB7Zh1P
   nlqRAu2F5CAgx9zxlosCzRzQRX1aFvLA/fEk6Iu/nFNTxfU0Ai6LqqO5A
   45bgi0R7kfTwT4Xj3qpAKussURk+2sPvBWUDLCEGWnlkO8qPE0RtjoR0P
   gnJbTmO+92R86RbUFOyrzEFlxjncA9kUF4qmSkM61eJpumRRIomIXsLpD
   YexesJnNC/HM+F7ohQsfj0/xDEAU8SE+Bfk4NFn4rgn5txnjUbgAoKedk
   T2YHbBUkkvBTay9CVsgTfCI6wXbg3/kOfpLZxuX3jP88vnLyWJyZsOEft
   w==;
X-CSE-ConnectionGUID: sCgu3wmrRZOVmf/2wunxgg==
X-CSE-MsgGUID: WVOcXdqxSui5yPz+BGpjRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79314757"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="79314757"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:36:47 -0700
X-CSE-ConnectionGUID: 9bx+lMifSCWPtzdPzCV9Xg==
X-CSE-MsgGUID: EsaN0u6XQ3+kClmi8Zf6eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="261004350"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:36:44 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 00/15] wifi: iwlwifi: updates - 2026-05-11
Date: Mon, 11 May 2026 20:36:16 +0300
Message-Id: <20260511173631.1067831-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 771BA514121
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
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-36241-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi,

Features, cleanups and fixes from our internal tree.
A few more NAN commits.

Thanks,
Miri
---

Avinash Bhatt (1):
  wifi: iwlwifi: fix buffer overflow when firmware reports no channels

Emmanuel Grumbach (3):
  wifi: iwlwifi: fix the access to CNVR TOP registers
  wifi: iwlwifi: mld: honor BSS_CHANGED_BEACON_ENABLED
  wifi: iwlwifi: mld: move iwl_mld_link_info_changed_ap_ibss to ap.c

Johannes Berg (7):
  wifi: iwlwifi: mld: clean up station handling in key APIs
  wifi: iwlwifi: mld: add TLC support for NAN stations
  wifi: iwlwifi: mld: track TX/RX IGTKs separately
  wifi: iwlwifi: mld: don't report bad STA ID in EHT TB sniffer
  wifi: iwlwifi: api: RX: define UHR RX PHY flags
  wifi: iwlwifi: fw: api: fix UHR U-SIG whitespace
  wifi: iwlwifi: fw: api: add/fix some UHR sniffer definitions

Miri Korenblit (2):
  wifi: iwlwifi: bump core version for BZ/SC/DR to 103
  wifi: iwlwifi: mld: allow NAN data

Pagadala Yesu Anjaneyulu (2):
  wifi: iwlwifi: add RF name handling for PE chip type for debugfs
  wifi: iwlwifi: add XIAOMI to PPAG approved list

 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |   2 +-
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    |  38 +++-
 .../wireless/intel/iwlwifi/fw/regulatory.c    |   7 +-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |   3 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   |  18 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.h   |   4 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  21 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |   7 +-
 drivers/net/wireless/intel/iwlwifi/mld/ap.c   |  58 +++++-
 drivers/net/wireless/intel/iwlwifi/mld/ap.h   |   8 +-
 drivers/net/wireless/intel/iwlwifi/mld/d3.c   |  20 +-
 .../net/wireless/intel/iwlwifi/mld/iface.h    |  15 ++
 drivers/net/wireless/intel/iwlwifi/mld/key.c  | 110 +++++-----
 drivers/net/wireless/intel/iwlwifi/mld/link.h |   9 +-
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  51 ++---
 drivers/net/wireless/intel/iwlwifi/mld/nan.c  |  41 +++-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c   |  15 +-
 drivers/net/wireless/intel/iwlwifi/mld/sta.h  |   4 +
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c  | 189 +++++++++++++++---
 .../intel/iwlwifi/pcie/gen1_2/trans-gen2.c    |   9 +-
 .../intel/iwlwifi/pcie/gen1_2/trans.c         |  26 ++-
 23 files changed, 486 insertions(+), 173 deletions(-)

-- 
2.34.1


