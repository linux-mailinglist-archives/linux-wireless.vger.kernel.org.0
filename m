Return-Path: <linux-wireless+bounces-1026-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 443EA819117
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 20:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0109C287250
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 19:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BA139860;
	Tue, 19 Dec 2023 19:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MmW7/0ij"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87823984A
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 19:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703015953; x=1734551953;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0j1PsHHG9EWpgj+lOXdnlSzbv8CzTz08jIIF+jcNzlk=;
  b=MmW7/0ijIpY+zOnESnZWIV2MN1QWt6pHL2o7FhmTxpt4A2UXI+tbv9Ig
   VlupkIDBayDIWE61kvOJ1xWq9Bzig4r32H4ZNHW+LxzXkgp4oK/qKom2A
   XK4KQzmVmQjyWWU3titiOhq+ehasyPHd534pCOXsLNPqx3oK1Tai1yLsl
   WuMNVM5jwYehPPnm5Ps5dyFDTz5+6rsYT0esQKg034rueWH3qgVwFwiKP
   sPXoWgyNXkTOdlBfQwo9RYS6A7KITGM0eB3CmVrEP16j7+qf0aa7mdBx5
   qNGdlpDHolXZFeuOU6eW7t5uB/dIrI+YLjNaQ+CyNDVO9jLRB2ttWe/59
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="380694920"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="380694920"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 11:59:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="779589062"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="779589062"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 11:59:11 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/14] wifi: iwlwifi: updates - 2023-12-06
Date: Tue, 19 Dec 2023 21:58:48 +0200
Message-Id: <20231219195902.3336105-1-miriam.rachel.korenblit@intel.com>
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

This patch set includes iwlwifi patches intended for v6.8
It contains a few features, bugfixes and cleanups.

Thanks,
Miri

Andrei Otcheretianski (3):
  wifi: iwlwifi: mvm: Allow DFS concurrent operation
  wifi: iwlwifi: Don't mark DFS channels as NO-IR
  wifi: iwlwifi: replace ENOTSUPP with EOPNOTSUPP

Anjaneyulu (1):
  wifi: iwlwifi: fix out of bound copy_from_user

Emmanuel Grumbach (1):
  wifi: iwlwifi: mvm: use the new command to clear the internal buffer

Ilan Peer (1):
  wifi: iwlwifi: mvm: Do not warn if valid link pair was not found

Johannes Berg (5):
  iwlwifi: mvm: set siso/mimo chains to 1 in FW SMPS request
  wifi: iwlwifi: mvm: send TX path flush in rfkill
  wifi: iwlwifi: mvm: d3: avoid intermediate/early mutex unlock
  wifi: iwlwifi: mvm: add US/Canada MCC to API
  wifi: iwlwifi: mvm: disallow puncturing in US/Canada

Miri Korenblit (2):
  wifi: iwlwifi: assign phy_ctxt before eSR activation
  wifi: iwlwifi: cleanup BT Shared Single Antenna code

Mukesh Sisodiya (1):
  wifi: iwlwifi: Add rf_mapping of new wifi7 devices

 .../net/wireless/intel/iwlwifi/fw/api/debug.h |  6 +++++
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |  3 +++
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  9 ++++++++
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  4 ++++
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  1 -
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |  2 ++
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 15 +++++++++----
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  8 +++----
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c | 22 ++++---------------
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 17 ++------------
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |  4 ++--
 .../intel/iwlwifi/mvm/ftm-responder.c         |  8 +++----
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  7 ++----
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 16 +++++++++++++-
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  8 +++----
 .../net/wireless/intel/iwlwifi/mvm/phy-ctxt.c | 11 ----------
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  2 +-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  | 10 +++++++++
 19 files changed, 85 insertions(+), 72 deletions(-)

-- 
2.34.1


