Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FD16CB8DE
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 09:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjC1H73 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 03:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjC1H71 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 03:59:27 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490C3136
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 00:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679990365; x=1711526365;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=We83VZZx9nG86JUs//nGX3J3ywZ7bSKWCtFXPOIWjNE=;
  b=dq1WA6orlnAVPmh/DcCu96D6Z2HyJi58GMdQulchTTILl3idrwQPqYIq
   suZ7vN+VD0W1cloLierG5om9Fiw8mqbU+nCA8Lbe7jbB0Z8mu9zT5Cyz1
   RSanQ45E2HN2cx58W/SGdiOwEimj2lWfdygEIsPIAx8TAx2f9Cj0d/usq
   ArONRuSXaJ3awoLFvgWSoazY7lffTR4Nz31Qn3CaR6JgwVJb5n4Zn9MOd
   OBJWuLJDx3ETgQv1anHdCwZlnrbHLe+OgYOOaDPadd3O7ge7TWU2CzEiu
   WrSMkyIh7bO8LYAIFgVMa64QqZQWba7lc2TNmdyg8FCG0AaOTdcVPuP3/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328958013"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="328958013"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:59:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="773045096"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="773045096"
Received: from gershonr-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.194.136])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:59:23 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/31] wifi: iwlwifi: updates intended for v6.4 2023-03-28 
Date:   Tue, 28 Mar 2023 10:58:40 +0300
Message-Id: <20230328075911.2370108-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Hi,

Here's a new set of iwlwifi patches.

All the changes are related to adding MLO support.
This patch set will be followed by a few more that focus specifically on
adding MLO support. 

Thanks,
Gregory

Avraham Stern (1):
  wifi: iwlwifi: mvm: add set_hw_timestamp to mld ops

Gregory Greenman (14):
  wifi: iwlwifi: mvm: vif preparation for MLO
  wifi: iwlwifi: mvm: sta preparation for MLO
  wifi: iwlwifi: mvm: adjust smart fifo configuration to MLO
  wifi: iwlwifi: mvm: adjust mld_mac_ctxt_/beacon_changed() for MLO
  wifi: iwlwifi: mvm: adjust some PS and PM methods to MLD
  wifi: iwlwifi: mvm: adjust SMPS for MLO
  wifi: iwlwifi: mvm: add link_conf parameter for add/remove/change link
  wifi: iwlwifi: mvm: replace bss_info_changed() with vif_cfg/link_info_changed()
  wifi: iwlwifi: mvm: adjust internal stations to MLO
  wifi: iwlwifi: mvm: add fw link id allocation
  wifi: iwlwifi: mvm: adjust to MLO assign/unassign/switch_vif_chanctx()
  wifi: iwlwifi: mvm: update iwl_mvm_tx_reclaim() for MLO
  wifi: iwlwifi: mvm: refactor iwl_mvm_mac_sta_state_common()
  wifi: iwlwifi: mvm: adjust some cleanup functions to MLO

Johannes Berg (3):
  wifi: iwlwifi: mvm: add link to firmware earlier
  wifi: iwlwifi: mvm: don't check dtim_period in new API
  wifi: iwlwifi: mvm: implement link change ops

Miri Korenblit (13):
  wifi: iwlwifi: mvm: add an indication that the new MLD API is used
  wifi: iwlwifi: mvm: add sta handling flows for MLD mode
  wifi: iwlwifi: mvm: add some new MLD ops
  wifi: iwlwifi: mvm: refactor iwl_mvm_roc()
  wifi: iwlwifi: mvm: add cancel/remain_on_channel for MLD mode
  wifi: iwlwifi: mvm: unite sta_modify_disable_tx flows
  wifi: iwlwifi: mvm: add support for post_channel_switch in MLD mode
  wifi: iwlwifi: mvm: add all missing ops to iwl_mvm_mld_ops
  wifi: iwlwifi: mvm: fix "modify_mask" value in the link cmd.
  wifi: iwlwifi: mvm: fix crash on queue removal for MLD API too
  wifi: iwlwifi: mvm: modify link instead of removing it during csa
  wifi: iwlwifi: mvm: always use the sta->addr as the peers addr
  wifi: iwlwifi: mvm: align to the LINK cmd update in the FW

 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   |   26 +-
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    |   10 +-
 .../net/wireless/intel/iwlwifi/mvm/binding.c  |   13 +-
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c |   35 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |   39 +-
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  |   14 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   28 +-
 .../intel/iwlwifi/mvm/ftm-initiator.c         |    6 +-
 .../intel/iwlwifi/mvm/ftm-responder.c         |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |    2 +
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  214 ++-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  102 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 1263 +++++++++++------
 .../net/wireless/intel/iwlwifi/mvm/mld-key.c  |   14 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac.c  |   51 +-
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  895 ++++++++++--
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  |  562 +++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  438 +++++-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   26 +-
 .../net/wireless/intel/iwlwifi/mvm/phy-ctxt.c |    4 +-
 .../net/wireless/intel/iwlwifi/mvm/power.c    |   24 +-
 .../net/wireless/intel/iwlwifi/mvm/quota.c    |   11 +-
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |   34 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   |   42 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |   30 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |    5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |   15 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sf.c   |   38 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  357 +++--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  108 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c |    8 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   |   12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c   |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |   53 +-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |   87 +-
 35 files changed, 3417 insertions(+), 1155 deletions(-)

-- 
2.38.1

