Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99C96AAF5D
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Mar 2023 13:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjCEMQx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Mar 2023 07:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjCEMQw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Mar 2023 07:16:52 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC6F1258A
        for <linux-wireless@vger.kernel.org>; Sun,  5 Mar 2023 04:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678018610; x=1709554610;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1ZuFuJ4YuAJTbUFlJqa+CeqGCr1eKxnCAzlUJ2xtYd0=;
  b=ixXB0M2249k+0trZh/WIcK2lptZGo8Ymq+XIUTggUVuyLVwDRb4p3cpT
   mtoNFhA2+OMmtaG3QO/T5zeuY56oqukdm803/TOAGBGd0FkYyi00Cm2J1
   WczDQ2/DkG+En9lWiUqcNg5yYQYKJc7BPZIAfnSPXU5PdYFCmqS+ZTFGx
   NvVBwJzk5Lb6n9nzzgI3HvgG1AV/w9Yyssrk/gfaOohmez1jmxINAytpl
   BoIwQFMAP9uNoo2XyXHQovMlZApSUJKQWEu3pKalxoGR1pDC8WiQM8neN
   vDS9GAtFhLkeynTKAEH9MhHLak9Hod0u0se+t2lyY3Zt/7sp1hppGM2yx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="400193129"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="400193129"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:16:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="708354974"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="708354974"
Received: from hsaid-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.80.12])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:16:48 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/21] wifi: iwlwifi: updates intended for v6.4 2023-03-05 
Date:   Sun,  5 Mar 2023 14:16:14 +0200
Message-Id: <20230305121635.301451-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Hi,

Here's a new set of iwlwifi patches. 
The changes are:
* Mostly EHT sniffer
* Small fixes and cleanups

Thanks,
Gregory

Alon Giladi (1):
  wifi: iwlwifi: mvm: allow new vendor to use TAS

Golan Ben Ami (2):
  wifi: iwlwifi: reduce verbosity of some logging events
  wifi: iwlwifi: Add support for B step of BnJ-Fm4

Ilan Peer (1):
  wifi: iwlwifi: Do not include radiotap EHT user info if not needed

Johannes Berg (3):
  wifi: iwlwifi: mvm: avoid UB shift of snif_queue
  wifi: iwlwifi: mvm: make flush code a bit clearer
  wifi: iwlwifi: mvm: fix EOF bit reporting

Mordechay Goodstein (12):
  wifi: iwlwifi: mvm: add LSIG info to radio tap info in EHT
  wifi: iwlwifi: mvm: mark mac header with no data frames
  wifi: iwlwifi: mvm: add an helper function for adding TLVs
  wifi: iwlwifi: mvm: add EHT radiotap info based on rate_n_flags
  wifi: iwlwifi: mvm: add all EHT based on data0 info from HW
  wifi: iwlwifi: mvm: rename define to generic name
  wifi: iwlwifi: mvm: decode USIG_B1_B7 RU to nl80211 RU width
  wifi: iwlwifi: mvm: parse FW frame metadata for EHT sniffer mode
  wifi: iwlwifi: mvm: add primary 80 known for EHT TLV
  wifi: iwlwifi: rs-fw: break out for unsupported bandwidth
  wifi: iwlwifi: mvm: cleanup duplicated defines
  wifi: iwlwifi: mvm: add EHT - RU allocation to radiotap TLV

Mukesh Sisodiya (2):
  wifi: iwlwifi: Adding the code to get RF name for MsP device
  wifi: iwlwifi: Update logs for yoyo reset sw changes

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  12 +
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    |  27 +-
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    |  86 ++-
 drivers/net/wireless/intel/iwlwifi/fw/rs.c    |   4 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   1 +
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |   1 +
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |  24 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   5 +
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  10 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  29 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   2 +
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   |  17 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 588 +++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |   6 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |   5 +
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |   5 +-
 drivers/net/wireless/mac80211_hwsim.c         |  14 +-
 include/net/ieee80211_radiotap.h              |  20 +-
 20 files changed, 757 insertions(+), 115 deletions(-)

-- 
2.38.1

