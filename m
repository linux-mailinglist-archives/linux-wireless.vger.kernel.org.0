Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4529B72CAA5
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jun 2023 17:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237803AbjFLPvb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Jun 2023 11:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237320AbjFLPva (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Jun 2023 11:51:30 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F019CA
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jun 2023 08:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686585089; x=1718121089;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o6LMvnFf4pKGk9gEL1db1tEvwjb9aCj2o8rJ5cT3rKM=;
  b=I3AoWyR6EMJBA9bTTyMOS5gvwG2yk/11kf/vVpDFze1FJ0xBkD2JCgBS
   iEOzipDu0CzzcpRnZ9HiT5A1oH033bNr3FPnNT3FfMb4RmRERdiFfjY9l
   rXR/HkRDq0BAaMOAo7gqwot1023K3MEpgUjJkZEm5oywB1SwY5bjT0vee
   O+LOFxCfpbVOEDKLEf8KUkMZbSD4NvCIX+0LntV8clv4iybTixsTVLEiI
   k69o0GSwJxKjURB6w/iJi4Z7AohLAOdELYvf7RwmQ6iGFi7Oa7oqQSIaR
   uVG3I1fOzVM6plkw6EFVAqrttk3aZopdZpbt9H7RxhnsGBmlcYrAYggA+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="421674159"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="421674159"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 08:51:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="885499219"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="885499219"
Received: from azvuluno-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.202.109])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 08:51:27 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/15] wifi: iwlwifi: updates intended for v6.5 2023-06-12 
Date:   Mon, 12 Jun 2023 18:51:01 +0300
Message-Id: <20230612155116.168000-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Hi,

This patch set includes iwlwifi patches intended for v6.5.
It contains a number of fixes and cleanups along with a
continuation of MLO work.

It also advances the firmware API to 79.

Thanks,
Gregory

Abhishek Naik (1):
  wifi: iwlwifi: update response for mcc_update command

Alon Giladi (1):
  wifi: iwlwifi: debugfs: add ppag capa to fw info file

Avraham Stern (3):
  wifi: iwlwifi: mvm: debugfs: add entry for setting maximum TXOP time
  wifi: iwlwifi: mvm: FTM initiator MLO support
  wifi: iwlwifi: mvm: FTM responder MLO support

Benjamin Berg (1):
  wifi: iwlwifi: make debugfs entries link specific

Emmanuel Grumbach (1):
  wifi: iwlwifi: pass ESR parameters to the firmware

Gregory Greenman (1):
  wifi: iwlwifi: bump FW API to 79 for AX devices

Ilan Peer (1):
  wifi: iwlwifi: mvm: Propagate ERP slot changes to FW

Johannes Berg (2):
  wifi: iwlwifi: unify checks for HW error values
  wifi: iwlwifi: mvm: always set MH len in offload_assist

Mukesh Sisodiya (4):
  wifi: iwlwifi: mvm: Handle return value for iwl_mvm_sta_init
  wifi: iwlwifi: mvm: fix getting LDPC/STBC support
  wifi: iwlwifi: mvm: Add NULL check before dereferencing the pointer
  wifi: iwlwifi: fw: print PC register value instead of address

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |   2 +-
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   |   4 +-
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |  35 +++-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |   4 +-
 .../net/wireless/intel/iwlwifi/fw/debugfs.c   |  13 +-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c  |   9 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   |   4 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 117 +++++++----
 .../wireless/intel/iwlwifi/iwl-nvm-parse.h    |   4 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   5 +
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  |  38 ++++
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 198 ++++++++++++++----
 .../intel/iwlwifi/mvm/ftm-initiator.c         |  48 +++--
 .../intel/iwlwifi/mvm/ftm-responder.c         |  23 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  21 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac.c  |  12 ++
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  19 +-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c  |  63 ++++--
 .../net/wireless/intel/iwlwifi/mvm/power.c    |  14 +-
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |   7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |   2 +
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |   9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  10 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |   2 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |   2 +-
 26 files changed, 506 insertions(+), 171 deletions(-)

-- 
2.38.1

