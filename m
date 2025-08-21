Return-Path: <linux-wireless+bounces-26495-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 887F3B2F8D6
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 14:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C39621CE2F3C
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 12:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D917E31E105;
	Thu, 21 Aug 2025 12:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YQiZBLZQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402F7320399
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 12:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780301; cv=none; b=pGdllrDKPhD5Rpd/i42YG5WHyWVgkMfGgu0iTYU8FyLat/IFwtPlasv4Xr92YVypACLUB43Oo6wugmHGKKT7GV9+63ow4AHtzfmP7Hc5sEtRpc8ra+fvVzwnxlXbJvVuP9I5ZhBXDgvHpFabSBg/vPBzlXO1OwT1J6+IYDRa4Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780301; c=relaxed/simple;
	bh=98GnZLFXMeVpOERzDdNxqtbZvU8alxp8DYu3h4T4wQ4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=D6vhsRFJs0CdbThGZIpXeTntHa2N+rLeLe1obWQHrwWzWrsBEzFRYyeyjPNDXwA/88dSMziZ8oUGjQ2aqui2U+wmnFRWoYg43TE7hRQy6VsS/bROZMt71O/F9zR+IG7iVAqvDi0/w7XmDdWiT2zkab/7lUTlSKJ76HFIchyaJAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YQiZBLZQ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755780300; x=1787316300;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=98GnZLFXMeVpOERzDdNxqtbZvU8alxp8DYu3h4T4wQ4=;
  b=YQiZBLZQOZbR1poktwbod+8SmH2yNw0Fi0TTcNbX61y91/tR733STiwb
   fVTLBc0Wslh4fw534GmEvbpmrmMpzgolHfDwWkpdoHNEVBHCsg8ToR+sW
   5IISX0x/UAX7n6+0i9Vg5n8oqOc7iMyZglDIzBW4O7F52o7EwMherTZzL
   FP1Om41epEf6OAayRXvgk4jSOpJWU8XnDuaKtbITg3J00JLPzxYdfTYcQ
   IxYErMfTRRm2gZnSIIMIrMUxmL6Qi8L0zbPtugLJPmRnx7YRJ9wDkgzCO
   CVxyTYR5+vXwuKPu9pcBFRWQwiwkLeoCVm5Aeq6W7jHJt/yGXq6NXSDtT
   A==;
X-CSE-ConnectionGUID: 6BiKo373QzGqAJj5ZWVxhw==
X-CSE-MsgGUID: r98cXxxuQva8Jr/sQ8Aspg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="61895723"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="61895723"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 05:44:59 -0700
X-CSE-ConnectionGUID: DljJRyweSK+kqE+6Mhv8YA==
X-CSE-MsgGUID: PK+PkIO0QkKT78I9iUa7Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="172622095"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 05:44:59 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 00/15] wifi: iwlwifi: updates - 2025-08-21
Date: Thu, 21 Aug 2025 15:44:18 +0300
Message-Id: <20250821124433.2234183-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Hi,

A few features, cleanups and fixes from our internal tree.

Thanks,
Miri
---

Miri Korenblit (14):
  wifi: iwlwifi: mld: cleanup cipher lookup in resume
  wifi: iwlwifi: mvm: cleanup cipher lookup in resume
  wifi: iwlwifi: mld: support MLO rekey on resume
  wifi: iwlwifi: mld: track BIGTK per link
  wifi: iwlwifi: mvm/mld: correctly retrieve the keyidx from the beacon
  wifi: iwlwifi: mld/mvm: set beacon protection capability in wowlan
    config
  wifi: iwlwifi: mvm: remove a function declaration
  wifi: iwlwifi: bump MIN API in HR/GF/BZ/SC/DR
  Reapply "wifi: iwlwifi: remove support of several iwl_ppag_table_cmd
    versions"
  wifi: iwlwifi: make ppag versioning clear
  wifi: iwlwifi: mld: don't consider old versions of PPAG
  wifi: iwlwifi: mld: refactor iwl_mld_add_all_rekeys
  wifi: iwlwifi: mld: rename iwl_mld_set_key_rx_seq
  wifi: iwlwifi: mld: don't validate keys state on resume

Pagadala Yesu Anjaneyulu (1):
  wifi: iwlwifi: mvm: remove MLO code

 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c   |   2 +-
 .../net/wireless/intel/iwlwifi/cfg/rf-gf.c    |   2 +-
 .../net/wireless/intel/iwlwifi/cfg/rf-hr.c    |   2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |   2 +-
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    |   1 +
 .../net/wireless/intel/iwlwifi/fw/api/power.h |  34 +-
 .../wireless/intel/iwlwifi/fw/regulatory.c    |  39 +-
 drivers/net/wireless/intel/iwlwifi/mld/d3.c   | 271 +++---
 .../net/wireless/intel/iwlwifi/mld/iface.h    |   3 -
 drivers/net/wireless/intel/iwlwifi/mld/key.c  |  38 +
 drivers/net/wireless/intel/iwlwifi/mld/key.h  |   7 +
 drivers/net/wireless/intel/iwlwifi/mld/link.h |   2 +
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  10 +-
 .../wireless/intel/iwlwifi/mld/regulatory.c   |  28 +-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c   |  26 +-
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c | 131 ---
 .../wireless/intel/iwlwifi/mvm/constants.h    |  20 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 175 +---
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  |  94 --
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 809 ------------------
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  34 -
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 124 +--
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 138 +--
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  |   2 -
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 133 +--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  53 --
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   | 133 ---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  23 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 101 ---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  89 --
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  24 -
 .../wireless/intel/iwlwifi/mvm/tests/Makefile |   2 +-
 .../wireless/intel/iwlwifi/mvm/tests/links.c  | 433 ----------
 .../wireless/intel/iwlwifi/mvm/time-event.c   |   3 -
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |   8 +-
 36 files changed, 314 insertions(+), 2684 deletions(-)
 delete mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c

-- 
2.34.1


