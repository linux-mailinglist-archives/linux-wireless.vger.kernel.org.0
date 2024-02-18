Return-Path: <linux-wireless+bounces-3742-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE11585984F
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Feb 2024 18:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A044B2114A
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Feb 2024 17:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452406BFCA;
	Sun, 18 Feb 2024 17:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F2PzBiDj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403E029CF8
	for <linux-wireless@vger.kernel.org>; Sun, 18 Feb 2024 17:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708278726; cv=none; b=VSgHXV802BkqZ8RhDz87op6490OLTPMqT2zc0t0h4+EEtQZvm8mrdR2qJ3Cn6B4xZ+R+cIZ3ux+2ykic5BIQ0LyODBnVfveohL3OmeJxLu70rJuue8f+LuzZfoDQe0gf7IDPTUpF21CpFATRBwxVforc7Ua0x4nRBFLYU5WnFaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708278726; c=relaxed/simple;
	bh=sTs+/9daEAcpcbCI91ldARgb+Qvc+ZSyJ5b8hVgUjyk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fZgcT1llLt5Wsw2CL5AiAY0vQ3Anp1X5wowe9DViUiXszetA5RzF1cyJxGPv97NYYF9TP6Xv06k8+JWDkQehOInZk407tkNLA5dYvbm08kXhVOBwwfIHs6UfNdw7bWlcFds8BWmC97YiTkrLPhvzmKQoGVeQ6dFsScDnQmPZwHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F2PzBiDj; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708278723; x=1739814723;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sTs+/9daEAcpcbCI91ldARgb+Qvc+ZSyJ5b8hVgUjyk=;
  b=F2PzBiDjjnQIznjevTUEQ78Nv5PRyaNW45CWKQaV63k6uXi2aGreTEUt
   mTk9FEeW+SUjgR1k6JkWhhp1rL3lYHcaAlSmtdrQdwPbfp58ayBmeLpaS
   fSlVD6S6wgPmynXwRukSRfay96XH+NBgXdG6JDGv63IrI3tEcoJttMuA2
   6Y80LNdYvEmayMYidLFYn4MYkRJ111hpqgbYIihqObOra5lA35CoPtYmB
   X6lE2lvK9txSkDZD151QR+h4TwMBV1DczT2tm6BozUbgY9t4Se1we3wN6
   XToipwdEBHswI5XOrEfnc/GdkQfA4njW5kPqz2pTpf1wi572G2ccrdNFV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2464968"
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="2464968"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 09:52:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="27459406"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 09:52:01 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/11] wifi: iwlwifi: updates - 2024-02-18
Date: Sun, 18 Feb 2024 19:51:41 +0200
Message-Id: <20240218175152.3133364-1-miriam.rachel.korenblit@intel.com>
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

This patch set includes iwlwifi patches intended for v6.9. It contains a
few features, bugfixes and cleanups.

Thanks,


Benjamin Berg (2):
  wifi: iwlwifi: mvm: unlock mvm if there is no primary link
  wifi: iwlwifi: mvm: ensure offloading TID queue exists

Emmanuel Grumbach (1):
  wifi: iwlwifi: mvm: fix the TXF mapping for BZ devices

Johannes Berg (5):
  wifi: iwlwifi: mvm: support wider-bandwidth OFDMA
  wifi: iwlwifi: mvm: partially support PHY context version 6
  wifi: iwlwifi: mvm: support PHY context version 6
  wifi: iwlwifi: api: fix kernel-doc reference
  wifi: iwlwifi: iwl-fh.h: fix kernel-doc issues

Miri Korenblit (2):
  wifi: iwlwifi: bump FW API to 90 for BZ/SC devices
  wifi: iwlwifi: handle per-phy statistics from fw

Mukesh Sisodiya (1):
  wifi: iwlwifi: load b0 version of ucode for HR1/HR2

 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |  2 +-
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 10 +++---
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |  4 +--
 .../wireless/intel/iwlwifi/fw/api/phy-ctxt.h  |  9 ++---
 .../net/wireless/intel/iwlwifi/fw/api/txq.h   | 12 ++++++-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  3 +-
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h   | 36 ++++++++++---------
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 20 ++++++++---
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  |  5 +--
 .../intel/iwlwifi/mvm/ftm-responder.c         |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  3 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 11 ++++++
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  9 +++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 11 ++++--
 .../net/wireless/intel/iwlwifi/mvm/phy-ctxt.c | 26 ++++++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   | 17 ++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 28 +++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  3 +-
 19 files changed, 159 insertions(+), 54 deletions(-)

-- 
2.34.1


