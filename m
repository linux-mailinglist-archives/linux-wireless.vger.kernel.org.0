Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5352D6C0EED
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 11:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjCTKeH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 06:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjCTKdt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 06:33:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DC915897
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 03:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679308412; x=1710844412;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=R+Nh+sMeSmNMv7WtcxNoILxrN+QEWB94C1Iq1GXlkUk=;
  b=nZ7ykyjm576/hxNZaYErQ+sXLNeXAbHZzb94V71+/LMhW4o2MII4xrtj
   /ptRauul2U/t4CjIn/Rzu5bMKv0pJNXHtB/NvEPKbw3jrr/JB7dONMX5U
   eGCACu8XkFULGX2vN1JTHsTjP2VsAJ01gMXqZrhGX3HmO6h35MtzqbGBs
   Fvjy9/DSRbmfWNHNu/+M120ruHUtlughxEu4sgG7ayNlSUU4uxfoWOBkN
   rAP3DiWW/WmR/NHyINkKHNrVr92LNx4LscoqEsyoGYjePn6UHdClgFNEG
   DSLUzBBoGjGbWFuuRzgB993HMBqaZSovedzvMNbThsuRenj7/kpopffsI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="326997847"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="326997847"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:33:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="713523636"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="713523636"
Received: from ranikhou-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.179.26])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:33:30 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/18] wifi: iwlwifi: updates intended for v6.4 2023-03-24 
Date:   Mon, 20 Mar 2023 12:33:01 +0200
Message-Id: <20230320103319.1309442-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Hi,

Here's a new set of iwlwifi patches.
The changes are:
* add WTSN support
* initial patches for adding MLO support
* a few small features and fixes

Thanks,
Gregory

Abhishek Naik (1):
  iwlwifi: mvm: Add debugfs to get TAS status

Avraham Stern (5):
  wifi: iwlwifi: mvm: read synced time from firmware if supported
  wifi: iwlwifi: mvm: report hardware timestamps in RX/TX status
  wifi: iwlwifi: mvm: implement PHC clock adjustments
  wifi: iwlwifi: mvm: select ptp cross timestamp from multiple reads
  wifi: iwlwifi: mvm: support enabling and disabling HW timestamping

Johannes Berg (1):
  wifi: iwlwifi: mvm: enable TX beacon protection

Krishnanand Prabhu (2):
  wifi: iwlwifi: mvm: add support for PTP HW clock (PHC)
  wifi: iwlwifi: mvm: add support for timing measurement

Miri Korenblit (8):
  wifi: iwlwifi: mvm: add start_ap() and join_ibss() callbacks for MLD mode
  wifi: iwlwifi: mvm: add stop_ap() and leave_ibss() callbacks for MLD mode
  wifi: iwlwifi: mvm: Don't send MAC CTXT cmd after deauthorization
  wifi: iwlwifi: mvm: refactor iwl_mvm_cfg_he_sta()
  wifi: iwlwifi: mvm: refactor iwl_mvm_sta
  wifi: iwlwifi: mvm: refactor iwl_mvm_sta_send_to_fw()
  wifi: iwlwifi: mvm: remove not needed initializations
  wifi: iwlwifi: mvm: refactor iwl_mvm_add_sta(), iwl_mvm_rm_sta()

Mukesh Sisodiya (1):
  wifi: iwlwifi: Update configurations for Bnj device

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  24 +
 .../wireless/intel/iwlwifi/fw/api/commands.h  |  18 +
 .../wireless/intel/iwlwifi/fw/api/datapath.h  | 184 ++++++-
 .../net/wireless/intel/iwlwifi/fw/api/debug.h |  96 ++++
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   3 +
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   2 +
 .../net/wireless/intel/iwlwifi/mvm/Makefile   |   2 +
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 190 ++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  20 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 501 +++++++++++-------
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 108 ++++
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  |  45 ++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  48 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  16 +
 drivers/net/wireless/intel/iwlwifi/mvm/ptp.c  | 326 ++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |   7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 308 ++++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |   4 +-
 .../wireless/intel/iwlwifi/mvm/time-sync.c    | 173 ++++++
 .../wireless/intel/iwlwifi/mvm/time-sync.h    |  30 ++
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |   4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  14 +-
 .../chromeOS/adjustments/024-time-sync.spatch |   6 +
 23 files changed, 1786 insertions(+), 343 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/time-sync.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/time-sync.h
 create mode 100644 intc-scripts/chromeOS/adjustments/024-time-sync.spatch

-- 
2.38.1

