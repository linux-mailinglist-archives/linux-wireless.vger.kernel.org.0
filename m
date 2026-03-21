Return-Path: <linux-wireless+bounces-33627-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDSGEZLVvmlwewMAu9opvQ
	(envelope-from <linux-wireless+bounces-33627-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 18:29:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C962E687D
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 18:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35610300A8E0
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 17:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3827F33ADBA;
	Sat, 21 Mar 2026 17:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eB38XMsY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFC533B6D4
	for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 17:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774114176; cv=none; b=TBE0IlqiSE7uvHrSH11s3D1SuyLxvCJwu2nEabMkAxPAThNPw1r9zTs3JyWGJlTxeErcaAsQ59n7YRl99KbCrCjLleEEK0TSAn/AKObW0dLOXh4NtCIbb6R9oW/KwWcK/lEmfjJ5r8OYthZX2zgr6Nt5VHTXi1ShwQSTl3Fy28c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774114176; c=relaxed/simple;
	bh=k+fR5HHCeehMVnKVoK8/mF2O70s/d/Dzct3gi0UH16w=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Qk00J4j7wfM3W0PDGUFbKzWgLR75YP/eOtv5UQAzuHvheHGni31Wi4Lbkr8+285wVjBUszs55XiO5/TDAHuRS+PhrJ1r60HEgcQcP1JxYgI/aUwIyAJ8g2tbFPmrXhVXs1nHnUt6Xp4KQxIDO7FprwJjmeumTr2NfVfI7oClu1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eB38XMsY; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774114174; x=1805650174;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k+fR5HHCeehMVnKVoK8/mF2O70s/d/Dzct3gi0UH16w=;
  b=eB38XMsYqV9fZUq7wFeIPp70PjUWl8wriW4Im6Xr/GC3Dn51PqbguXgt
   IG3gjX0MD3EQX+WkrDrii1e/SXzGR+fhcm4dY0OQD4n83vvO4FeQx0HV2
   s1N1DzfyCeAWDXhWt7upvL4ioBC6fR0xfJqkEK4rMUIokoT4WAza54iBI
   FSRIhWIIw+1ogyVK9okTYCyINqFkUBVgrD4iPn3XKLG+9Ev+bs+55w0gx
   c6/krAkvM0pS573DWk92OxQaeNQaFT+L2GpO/bRTGJpCO1PJg84+Yxxp2
   pvxx0Sqw6kslkcoKYnGKGwOD6gB9YQouIsAALOM8GS5OjGS2QcSturd6O
   A==;
X-CSE-ConnectionGUID: OE0X8okHQjKYLbN4MGxhSQ==
X-CSE-MsgGUID: aPcGwgstR0661d73mcGf6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="75244584"
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="75244584"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 10:29:33 -0700
X-CSE-ConnectionGUID: kM0d1VX+S8qr3hbB9U05OA==
X-CSE-MsgGUID: ayBGyO15QxOGXx4tnDJDmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="223813559"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 10:29:32 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 00/15] wifi: iwlwifi: updates - 2026-03-21
Date: Sat, 21 Mar 2026 19:29:07 +0200
Message-Id: <20260321172922.3938740-1-miriam.rachel.korenblit@intel.com>
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
	TAGGED_FROM(0.00)[bounces-33627-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: C3C962E687D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

features and cleanups from our internal tree.

Thanks,
Miri
---

Avinash Bhatt (2):
  wifi: iwlwifi: handle NULL/ERR returns from ptp_clock_register()
  wifi: iwlwifi: mld: block EMLSR during TDLS connections

Emmanuel Grumbach (4):
  wifi: iwlwifi: mld: update the TLC when we deactivate a link
  wifi: iwlwifi: TLC_MNG_CONFIG_CMD can use several structures
  wifi: iwlwifi: fix the description of SESSION_PROTECTION_CMD
  wifi: iwlwifi: reduce the number of prints upon firmware crash

Johannes Berg (5):
  wifi: iwlwifi: mld: rename iwl_mld_phy_from_mac80211() argument
  wifi: iwlwifi: mld: make alloc functions not forced static
  wifi: iwlwifi: mld: add double-include guards to nan.h
  wifi: iwlwifi: add MAC context command version 4
  wifi: iwlwifi: mld: set RX_FLAG_RADIOTAP_TLV_AT_END generically

Miri Korenblit (4):
  wifi: iwlwifi: mld: use the dedicated helper to extract a link
  wifi: iwlwifi: mld: always assign a fw id to a vif
  wifi: iwlwifi: add a macro for max FW links
  wifi: iwlwifi: mld: introduce iwl_mld_vif_fw_id_valid

 .../wireless/intel/iwlwifi/fw/api/datapath.h  |  3 +-
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 69 +++++++++++++++++--
 .../net/wireless/intel/iwlwifi/fw/api/mac.h   |  6 +-
 .../net/wireless/intel/iwlwifi/fw/api/stats.h |  5 +-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c  | 69 +------------------
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  2 +-
 .../net/wireless/intel/iwlwifi/mld/iface.c    | 20 ++++--
 .../net/wireless/intel/iwlwifi/mld/iface.h    | 13 +++-
 drivers/net/wireless/intel/iwlwifi/mld/link.c |  2 +-
 .../wireless/intel/iwlwifi/mld/low_latency.c  | 13 ++--
 .../net/wireless/intel/iwlwifi/mld/mac80211.c | 25 ++++++-
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |  6 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  |  3 +-
 drivers/net/wireless/intel/iwlwifi/mld/nan.h  |  5 +-
 drivers/net/wireless/intel/iwlwifi/mld/phy.h  |  4 +-
 drivers/net/wireless/intel/iwlwifi/mld/ptp.c  |  4 +-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c   | 13 ++--
 drivers/net/wireless/intel/iwlwifi/mld/scan.c |  4 +-
 drivers/net/wireless/intel/iwlwifi/mld/sta.c  |  4 +-
 drivers/net/wireless/intel/iwlwifi/mld/sta.h  |  2 +-
 .../net/wireless/intel/iwlwifi/mld/stats.c    |  5 +-
 .../wireless/intel/iwlwifi/mld/tests/utils.c  |  8 +--
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c  | 50 +++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mld/tlc.h  |  3 +
 .../net/wireless/intel/iwlwifi/mvm/mld-mac.c  | 18 ++---
 drivers/net/wireless/intel/iwlwifi/mvm/ptp.c  |  4 +-
 26 files changed, 223 insertions(+), 137 deletions(-)

-- 
2.34.1


