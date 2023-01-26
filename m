Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6CA67D884
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jan 2023 23:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbjAZWgh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Jan 2023 17:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjAZWge (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Jan 2023 17:36:34 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017763C07
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jan 2023 14:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674772587; x=1706308587;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5mRifkGlXc6XfDKZS86GYjYFLQ8aLEqQOg0lRpWkuBk=;
  b=LeZdv9pjn2ah5VJ3QnnRcGQSPX+AVp31alp86g23/hnfYcNYfL5vKFU5
   X/ZfsFhL75XxHoDnTZ6S1xN0wiZ5MllNphAYOfARnDt1Tzp53ToKBI3Oy
   p1A8RJeKQIaJ02kCJwxluUsEPyHMAEyMB5Gv3nnAI60QG1JWosuf3sqmo
   8z+mTY/wrIWZw+XvZ0ri8fF2RHTYWd23slR9R2ToTRKeE/uW5380CA3fM
   aQRXzaPtAEDGsyOxdMOOKhxn8dlqbvj24Pj0EdpYJkvMdoDW3u5Wl/gcR
   UiAD4Rya++r45Kb1jO++XOFm13R/PGYdn/vqN9lb9jt6N7AN2kHegzymM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="329098535"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="329098535"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 14:28:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="612986116"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="612986116"
Received: from razgilad-mobl7.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.211.193])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 14:28:48 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/12] iwlwifi: updates intended for v6.3 2023-01-27 
Date:   Fri, 27 Jan 2023 00:28:09 +0200
Message-Id: <20230126222821.305122-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Hi,

Here is the second set of patches intended for v6.3. 
It's the usual development, new features, cleanups and bugfixes.

The changes are:
* WTSN improvement
* Sniffer mode updates for EHT
* Fixes and cleanups
* Advancing FW API version

As usual, I'm pushing this to a pending branch, for kbuild bot,
and will send a pull-request later.

Please review.

Thanks,
Gregory

Avraham Stern (1):
  wifi: iwlwifi: mvm: report hardware timestamps in RX/TX status

Ayala Barazani (1):
  wifi: iwlwifi: mvm: Support STEP equalizer settings from BIOS.

Emmanuel Grumbach (1):
  wifi: iwlwifi: mention the response structure in the kerneldoc

Golan Ben Ami (1):
  wifi: iwlwifi: bump FW API to 74 for AX devices

Gregory Greenman (2):
  wifi: iwlwifi: mvm: always send nullfunc frames on MGMT queue
  wifi: iwlwifi: mei: fix compilation errors in rfkill()

Heiner Kallweit (1):
  wifi: iwlwifi: improve tag handling in iwl_request_firmware

Mordechay Goodstein (3):
  wifi: iwlwifi: rx: add sniffer support for EHT mode
  wifi: iwlwifi: mvm: add sniffer meta data APIs
  wifi: iwlwifi: mvm: simplify by using SKB MAC header pointer

Mukesh Sisodiya (1):
  wifi: iwlwifi: mvm: Reset rate index if rate is wrong

Tom Rix (1):
  wifi: iwlwifi: mvm: remove h from printk format specifier

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |   2 +-
 .../wireless/intel/iwlwifi/fw/api/commands.h  |  19 ++
 .../wireless/intel/iwlwifi/fw/api/datapath.h  | 138 +++++++++++++-
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    | 145 ++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   1 +
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  |  59 +++++-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  |  19 +-
 .../intel/iwlwifi/iwl-context-info-gen3.h     |  21 ++-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  12 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   4 +
 drivers/net/wireless/intel/iwlwifi/mei/main.c |   6 +-
 .../net/wireless/intel/iwlwifi/mvm/Makefile   |   1 +
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   6 +-
 .../intel/iwlwifi/mvm/ftm-initiator.c         |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   8 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  13 ++
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  80 ++++----
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |   8 +
 .../wireless/intel/iwlwifi/mvm/time-sync.c    | 176 ++++++++++++++++++
 .../wireless/intel/iwlwifi/mvm/time-sync.h    |  30 +++
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  12 +-
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |   5 +
 22 files changed, 697 insertions(+), 72 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/time-sync.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/time-sync.h

-- 
2.38.1

