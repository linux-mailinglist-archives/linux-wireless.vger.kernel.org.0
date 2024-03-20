Return-Path: <linux-wireless+bounces-5043-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE00881908
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 22:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C66B1F21BF1
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 21:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9788594E;
	Wed, 20 Mar 2024 21:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OptFCFlB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA441DFC6
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 21:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710970014; cv=none; b=aIfP+sd8UQP5vHmRgrB7nBEngNaJ0kbIM+kqYcNLvpf5avOOqe1kjuQYaky1MnhK8ZO6m68A0+jiRv9oaIfUoW7/agxBBtZyy9shYuRpaUNwRnOHGfl9uJPe3ibeHbNSCHLOlGOf7naw/A7ReLREUZb5M8zEGoQeerusAul24OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710970014; c=relaxed/simple;
	bh=ulU7/zX4KxZG8bfYO99M8HVzEc0o4HODYAYfAkQoie8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e1so8VSpxvdfgJUTQg5X5sxrnrKJdOXm8azbsUrnuomGOwKyuXIuE1rhcprdBp/ZWZkHHJCIFQB83+5sj7rtTU8iD6wCgJgwSqPJq3p7fdprYqyM85zc6D89qfXgTBwIRIlO7FykGiDq6gcNw5lnUCoPK0Mu7hxxB7X0wpBClSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OptFCFlB; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710970012; x=1742506012;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ulU7/zX4KxZG8bfYO99M8HVzEc0o4HODYAYfAkQoie8=;
  b=OptFCFlBMghHqGt3KcRcU1UIe4AJW6SoS2V+m4HIigCzkJb0059xwVtG
   Dz+XMlLJrX7gZoehr9y+RMxbuDVTXfkrKtdaQSXTl25rXB0HWJE3wScRk
   0gMEm/5FP01bt+ApAxycR7DTt74D2DWGEXbHqBp/7yQdtQSCiI/r6Ak0B
   xqcm0aagqr2p9RLWZLVcUvvg+BNXyMz4POGacTtKdQr1cAzzcIxYfjLUj
   Nq2vSek50nzd0D3DlQPcQX+QRPjNXXc6Iw3OVEWBcqDlAzKtyIUxrkQI8
   W/RMll26KanWCY6gDeQQIfZTbFxKyygea0ZIV2HI8XOqnKhgf4jA/LbVy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="9698032"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="9698032"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:26:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="14184080"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:26:46 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/17] wifi: iwlwifi: updates - 2024-03-20
Date: Wed, 20 Mar 2024 23:26:21 +0200
Message-Id: <20240320212638.1446082-1-miriam.rachel.korenblit@intel.com>
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

This patch set includes iwlwifi patches intended for v6.10. It contains
a few features, bugfixes and cleanups.

Thanks,
Miri

Anjaneyulu (1):
  wifi: iwlwifi: Add support for LARI_CONFIG_CHANGE_CMD cmd v9

Benjamin Berg (5):
  wifi: iwlwifi: mvm: include link ID when releasing frames
  wifi: iwlwifi: mvm: guard against invalid STA ID on removal
  wifi: iwlwifi: mvm: assign link STA ID lookups during restart
  wifi: iwlwifi: mvm: fix active link counting during recovery
  wifi: iwlwifi: mvm: mark EMLSR disabled in cleanup iterator

Daniel Amosi (1):
  wifi: iwlwifi: Print a specific device name.

Emmanuel Grumbach (3):
  wifi: iwlwifi: remove devices that never came out
  wifi: iwlwifi: remove wrong CRF_IDs
  wifi: iwlwifi: add support for BZ_W

Ilan Peer (1):
  wifi: iwlwifi: mvm: Declare HE/EHT capabilities support for P2P
    interfaces

Johannes Berg (5):
  wifi: iwlwifi: mvm: handle debugfs names more carefully
  wifi: iwlwifi: mvm: set wider BW OFDMA ignore correctly
  wifi: iwlwifi: mvm: select STA mask only for active links
  wifi: iwlwifi: mvm: don't change BA sessions during restart
  wifi: iwlwifi: reconfigure TLC during HW restart

Miri Korenblit (1):
  wifi: iwlwifi: mvm: Remove outdated comment

 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |  2 +
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |  5 +-
 .../wireless/intel/iwlwifi/fw/regulatory.h    | 19 ++++++-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  5 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  6 ---
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 11 +++--
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  9 ++--
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  | 11 +++--
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  9 +++-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  6 +--
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 30 +++++-------
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  | 38 ++++++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 20 +++-----
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 49 +++++++------------
 14 files changed, 122 insertions(+), 98 deletions(-)

-- 
2.34.1


