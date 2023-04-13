Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9432A6E1442
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 20:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjDMSla (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 14:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDMSl3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 14:41:29 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817BA40C4
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 11:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681411288; x=1712947288;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6CaObgZy+FeYPJwoO8Bv/MdeG8U8wJMm5PjLGwfGGXQ=;
  b=SKDZGDhoJflB/BXdkgfGhrfzem9SVJzpnLmp3BsUef+f2IYL/AMT26yY
   OPxe1CXg3t+onyCCV8yPCn7yS2eAAqSj8tx/if7VjR76vR8AeuFFs0gNa
   prJ/zBxAYPlAUIVEVKStFZbKkJP6kTZ4j+VWkIE5ehs5aArenkeORvpgY
   qwEMTmOA8h5zZ5AtHub+WQIOAo+N/bRsqKqGl2XRXpCEak5c4bvowGUCU
   zDLrxymoo7zg531f9niohCXjsNB4aerMTSVKqK+ETXsM0FOOPoDM9pyYL
   OLk0RjSfF79l3AQJ2fkC7UtNmSHS0Mdptdb0Gh4Hfeg0Yn/Py19dNUEDT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="372126926"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="372126926"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 11:40:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="719984312"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="719984312"
Received: from apeled2-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.184.75])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 11:40:47 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/15] wifi: iwlwifi: updates intended for v6.4 2023-04-13 - set 2 
Date:   Thu, 13 Apr 2023 21:40:20 +0300
Message-Id: <20230413184035.1140892-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Hi,

Here's one more set of iwlwifi patches for v6.4.
It's the ususal developement, small improvements,
cleanups and bugfixes.

Thanks,
Gregory

Alon Giladi (1):
  wifi: iwlwifi: acpi: support modules with high antenna gain

Avraham Stern (2):
  wifi: iwlwifi: mvm: fix shift-out-of-bounds
  wifi: iwlwifi: mvm: make HLTK configuration for PASN station optional

Ayala Beker (2):
  wifi: iwlwifi: mvm: don't drop unencrypted MCAST frames
  wifi: iwlwifi: mvm: scan legacy bands and UHB channels with same
    antenna

Daniel Gabay (3):
  wifi: iwlwifi: pcie: fix possible NULL pointer dereference
  wifi: iwlwifi: yoyo: skip dump correctly on hw error
  wifi: iwlwifi: yoyo: Fix possible division by zero

Haim Dreyfuss (1):
  wifi: iwlwifi: mvm: support wowlan info notification version 2

Johannes Berg (3):
  wifi: iwlwifi: mvm: request limiting to 8 MSDUs per A-MSDU
  wifi: iwlwifi: mvm: add DSM_FUNC_ENABLE_6E value to debugfs
  wifi: iwlwifi: pcie: work around ROM bug on AX210 integrated

Miri Korenblit (1):
  wifi: iwlwifi: mvm: cleanup beacon_inject_active during hw restart

Mukesh Sisodiya (2):
  wifi: iwlwifi: dbg: print pc register data once fw dump occurred
  wifi: iwlwifi: Fix the duplicate dump name

 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 41 +++++++----
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    | 37 +++++++++-
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  |  3 +
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  6 +-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c  | 11 +++
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  2 +
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  1 +
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |  2 +
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |  6 ++
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  9 +++
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 16 +++++
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 35 ++++++++-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 22 ++++++
 .../intel/iwlwifi/mvm/ftm-initiator.c         | 25 ++++++-
 .../intel/iwlwifi/mvm/ftm-responder.c         | 19 +++--
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 10 +++
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 11 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |  5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |  5 ++
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  3 +
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  | 72 +++++++++++++++++--
 22 files changed, 309 insertions(+), 36 deletions(-)

-- 
2.38.1

