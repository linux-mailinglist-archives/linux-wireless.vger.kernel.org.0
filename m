Return-Path: <linux-wireless+bounces-36291-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OH0LHMu5Amo5wAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36291-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 07:25:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AA457519FDC
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 07:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C6FD3071362
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 05:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCAF221F20;
	Tue, 12 May 2026 05:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ABHDzSLu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AAF245031
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 05:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778563402; cv=none; b=uNSBY3LaC8eq/frWjgYw3i8XLe/wNyNmQFU4KG4iRC/9RL1nnzrU00I+rpZthsyv+VJNv2gbp4skq/HUJa8I+a+LKCgb/Kc/G1HrjO3lX1sSC6eriN9YWvkaC6PudJ2rH/2Af6HZetW6l0jES4EvAkh+l5su3b8mHVNAb3/uvQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778563402; c=relaxed/simple;
	bh=xaKthcSskMUI2LAnZ0jFDLi8asY+Xt3inwCKimLw+EM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=JkDPgQqre//tnnW4NbWF3yDvcOVuV8bve4XHuit8qlW/NYgEBSjdSu+oovVvEXqTy9bViK95xcofNMoi0Sfej6oQLvmcjO5tj414md7PIsMFi9MBdSd2PuFSMBOAOjGiNPB3jXQBPY6gBSTB4irwXfZDCWS5iveL7Uz5jyDu7HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ABHDzSLu; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778563401; x=1810099401;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xaKthcSskMUI2LAnZ0jFDLi8asY+Xt3inwCKimLw+EM=;
  b=ABHDzSLuEWNuh9vLbdYejxlEHFIhAWwfo35BKeRffeuIspZ+aAYxcXQ+
   7zDHGv069X8FT0SfRaeN/Yl48BbgouvgMX2vu3EQtgLtyAmltSEtJz9s+
   mWTYvoYiap/GaJp6eOfEwjL9fmSFRNTf+IQJ7GMrjs86qd00/MRig2tWb
   3mW2a5euC2hxpPQipNKn0aJvK4FSlLJfMBgtIYgmxSAQNBCjYZkUiW+Ui
   gqxp9KnQ3GbfYNmEZ3oRTufuXcLNWHGTqBmjdzY5T6mKxHiQKcBm9o9A1
   FMEttGWA1+g7HYrSwoFWHVY/rLAkC3mvVEFn7oPVxPAWT/TbN5f7gp2vu
   A==;
X-CSE-ConnectionGUID: ifccCyLaSN6NqZROYXApPw==
X-CSE-MsgGUID: L0ZyCHR4Q0uvL/ymMXAjVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="78495084"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="78495084"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 22:23:20 -0700
X-CSE-ConnectionGUID: aQZ9SbIJTs2q+hqDPSbuEw==
X-CSE-MsgGUID: TKn7PWe/RxKSmUkjPwOFjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="233187441"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 22:23:20 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 00/15] wifi: iwlwifi: updates - 2026-05-12
Date: Tue, 12 May 2026 08:22:52 +0300
Message-Id: <20260512052307.1603442-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AA457519FDC
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-36291-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PRECEDENCE_BULK(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

Hi,

Features, cleanups and fixes from our internal tree.

Thanks,
Miri

Emmanuel Grumbach (5):
  wifi: iwlwifi: rename iwl_system_statistics_notif_oper
  wifi: iwlwifi: introduce iwl_system_statistics_notif_oper version 4
  wifi: iwlwifi: mld: support the new statistics APIs
  wifi: iwlwifi: add support for AX231
  wifi: iwlwifi: remove nvm_ver for devices that don't need it

Johannes Berg (3):
  wifi: iwlwifi: pcie: fix ACPI DSM check
  wifi: iwlwifi: advertise UHR capabilities for such devices
  wifi: iwlwifi: print FSEQ sha1 in addition to version

Miri Korenblit (7):
  wifi: iwlwifi: support a TLV indicating num of mgmt mcast keys
  wifi: iwlwifi: mark that we support iwl_rx_mpdu_desc version 7 and 8
  wifi: iwlwifi: stop supporting cores 97 to 100
  wifi: iwlwifi: mld: stop supporting iwl_compressed_ba_notif version 5
    and 6
  wifi: iwlwifi: mld: stop supporting MAC_PM_POWER_TABLE version 1
  wifi: iwlwifi: mld: stop supporting TLC_MNG_UPDATE_NTFY_API_S_VER_3
  wifi: iwlwifi: mld: stop supporting rate_n_flags version 2

 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |  6 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c   |  6 +-
 .../net/wireless/intel/iwlwifi/cfg/rf-fm.c    |  6 +-
 .../net/wireless/intel/iwlwifi/cfg/rf-gf.c    |  7 +-
 .../net/wireless/intel/iwlwifi/cfg/rf-hr.c    |  6 +-
 .../net/wireless/intel/iwlwifi/cfg/rf-pe.c    | 22 ++++-
 .../net/wireless/intel/iwlwifi/cfg/rf-wh.c    |  6 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |  9 +-
 .../wireless/intel/iwlwifi/fw/api/commands.h  |  4 +-
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    |  2 +
 .../net/wireless/intel/iwlwifi/fw/api/sta.h   |  3 +-
 .../net/wireless/intel/iwlwifi/fw/api/stats.h | 88 +++++++++++++++++--
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  3 +-
 drivers/net/wireless/intel/iwlwifi/fw/img.h   |  3 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   | 11 ++-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  | 14 ++-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 77 ++++++++++------
 .../wireless/intel/iwlwifi/iwl-nvm-parse.h    |  2 +
 .../wireless/intel/iwlwifi/iwl-nvm-utils.h    |  1 +
 .../net/wireless/intel/iwlwifi/mld/debugfs.c  |  3 +-
 .../net/wireless/intel/iwlwifi/mld/iface.h    |  2 -
 drivers/net/wireless/intel/iwlwifi/mld/key.c  |  2 +-
 .../net/wireless/intel/iwlwifi/mld/mac80211.c | 44 +---------
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |  3 -
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |  5 +-
 .../net/wireless/intel/iwlwifi/mld/notif.c    |  8 +-
 .../net/wireless/intel/iwlwifi/mld/power.c    | 33 +------
 drivers/net/wireless/intel/iwlwifi/mld/rx.c   |  3 +-
 .../net/wireless/intel/iwlwifi/mld/stats.c    | 57 +++++++++---
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c  |  4 +-
 drivers/net/wireless/intel/iwlwifi/mld/tx.c   | 10 +--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |  9 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  5 +-
 .../intel/iwlwifi/pcie/gen1_2/trans.c         |  2 +-
 35 files changed, 268 insertions(+), 202 deletions(-)

-- 
2.34.1


