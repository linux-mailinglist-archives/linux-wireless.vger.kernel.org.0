Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF086E384F
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Apr 2023 14:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjDPMsD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Apr 2023 08:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjDPMr7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Apr 2023 08:47:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0668B2D4C
        for <linux-wireless@vger.kernel.org>; Sun, 16 Apr 2023 05:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681649272; x=1713185272;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+q5n3WxUp70IPOJVQql5pHPDRU9krZ7EI+Y7EOy9144=;
  b=bEzQmJFUEn05FFlnfHe0na18KNhf83UD8CMq0h0p9hncdsg2EUC6o2aF
   /lN7GRwi+7hy90TcPXJQYJVk4JujnSOU1jMp9YeD0HINAJA87cS0VMU1n
   2ejc+ZQJgfxlqvH+sWKXnA8GSajAuORIy+Ni6RxEWSzUW8HbLT3BW1eRB
   ttfLeE0pi+uunbIkNY4XUFgzXobopKrvHBMZAiDq9zaeYyH75rSMbLyit
   Q45UHD5w1coZfNjKXwV9aE0FV1+AVWcoSbawAy5s99ZsnQwymrWVtm6av
   /pPAJQjRc83ZP3KyXBL7pL0WDYNflTX7ws+zM2VWprDTO1Yfskb/87FVZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="333520543"
X-IronPort-AV: E=Sophos;i="5.99,202,1677571200"; 
   d="scan'208";a="333520543"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 05:47:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="640670408"
X-IronPort-AV: E=Sophos;i="5.99,202,1677571200"; 
   d="scan'208";a="640670408"
Received: from lavnon-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.99])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 05:47:50 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/15] wifi: iwlwifi: updates intended for v6.4 2023-04-16 
Date:   Sun, 16 Apr 2023 15:47:24 +0300
Message-Id: <20230416124739.1260800-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Hi,

Here's one more set of iwlwifi patches for v6.4.
Same as few patch sets before, this set contains the
ususal developement, small improvements, cleanups and
bugfixes. It bumps FW API to 77 as well.

Thanks,
Gregory

Avraham Stern (1):
  wifi: iwlwifi: mvm: avoid iterating over an un-initialized list

Emmanuel Grumbach (1):
  wifi: iwlwifi: make the loop for card preparation effective

Golan Ben Ami (1):
  wifi: iwlwifi: move debug buffer allocation failure to info verbosity

Gregory Greenman (2):
  wifi: iwlwifi: call napi_synchronize() before freeing rx/tx queues
  wifi: iwlwifi: bump FW API to 77 for AX devices

Ilan Peer (1):
  wifi: iwlwifi: mvm: Fix _iwl_mvm_get_scan_type()

Johannes Berg (9):
  wifi: iwlwifi: nvm-parse: add full BW UL MU-MIMO support
  wifi: iwlwifi: mvm: fix getting lowest TX rate for MLO
  wifi: iwlwifi: mvm: properly implement HE AP support
  wifi: iwlwifi: mvm: factor out iwl_mvm_sta_fw_id_mask()
  wifi: iwlwifi: mvm: use correct sta mask to remove queue
  wifi: iwlwifi: mvm: track station mask for BAIDs
  wifi: iwlwifi: mvm: implement BAID link switching
  wifi: iwlwifi: mvm: implement key link switching
  wifi: iwlwifi: mvm: allow number of beacons from FW

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |   2 +-
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   1 +
 drivers/net/wireless/intel/iwlwifi/fw/img.h   |   1 +
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |   7 +
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |   4 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   2 -
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  31 +++-
 .../net/wireless/intel/iwlwifi/mvm/mld-key.c  |  86 +++++++----
 .../net/wireless/intel/iwlwifi/mvm/mld-mac.c  |  14 +-
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |   5 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  | 133 ++++++++++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   2 +
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  34 +++--
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  23 +--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |   2 +
 .../wireless/intel/iwlwifi/pcie/internal.h    |   1 +
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  18 ++-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |   1 +
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |   4 +-
 23 files changed, 308 insertions(+), 83 deletions(-)

-- 
2.38.1

