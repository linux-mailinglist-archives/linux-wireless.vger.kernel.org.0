Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC406E42C3
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 10:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjDQImI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 04:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjDQImG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 04:42:06 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488681FEE
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 01:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681720925; x=1713256925;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wZSMjeseZvPRZ4zbRNhx2Such15yqvD96U1fDOjL1W4=;
  b=nFUUspTEKYjSCbeoCJmpIcNGQsDyaVOLWvxppD0hLIhmjq81oLxHg3mT
   ejOyLQlDR5Ly5z2HPuRIIbfMqsmVRbiIRNeXsHgyOgCd+Dty67SdUQLTL
   gp9V9t3U1XksCHmjiNn/DDw4ZPcrZsX8thWWwKODQopMIMQ09A6nrsVVK
   IEP/fLkBUGDw4Mf1xzbnAWc4zhJeaToVEwtEy5mXLgtPirVWFsQAakxQc
   uR4MnC+JRZJS93Vlqv3GHK3A1HtDlL/mS5rSk+VH/TdJ814RIVfdDCA0I
   g90g3EDnlc4yhbh+OhFmiOvB8ATPVEGdQASLa6dLLPl5MfAUqLqdsT8px
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="333634300"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="333634300"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 01:41:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="693173793"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="693173793"
Received: from odotan1x-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.202.32])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 01:41:50 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/15] wifi: iwlwifi: updates intended for v6.4 2023-04-17 
Date:   Mon, 17 Apr 2023 11:41:19 +0300
Message-Id: <20230417084134.1338976-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Hi,

Here's an additional set of iwlwifi patches for v6.4.
Same as few patch sets before, this set contains the
ususal developement, small improvements, cleanups and
bugfixes. It bumps FW API to 78.

Thanks,
Gregory


Emmanuel Grumbach (1):
  wifi: iwlwifi: mvm: adopt the latest firmware API

Gregory Greenman (2):
  wifi: iwlwifi: mvm: update mac id management
  wifi: iwlwifi: bump FW API to 78 for AX devices

Johannes Berg (12):
  wifi: iwlwifi: mvm: use BSSID when building probe requests
  wifi: iwlwifi: mvm: allow NL80211_EXT_FEATURE_SCAN_MIN_PREQ_CONTENT
  wifi: iwlwifi: mvm: remove per-STA MFP setting
  wifi: iwlwifi: mvm: fix iwl_mvm_sta_rc_update for MLO
  wifi: iwlwifi: mvm: only clients can be 20MHz-only
  wifi: iwlwifi: mvm: rs-fw: properly access sband->iftype_data
  wifi: iwlwifi: mvm: initialize per-link STA ratescale data
  wifi: iwlwifi: mvm: remove RS rate init update argument
  wifi: iwlwifi: fix iwl_mvm_max_amsdu_size() for MLO
  wifi: iwlwifi: mvm: configure TLC on link activation
  wifi: iwlwifi: mvm: add MLO support to SF - use sta pointer
  wifi: iwlwifi: mvm: check firmware response size

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  2 +-
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 10 ---
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 10 +++
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 22 ++---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 31 +++----
 .../net/wireless/intel/iwlwifi/mvm/mld-mac.c  |  7 --
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 24 ++++++
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  |  3 +-
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    | 81 +++++++++++--------
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   | 13 +--
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h   | 21 +++--
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |  5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sf.c   | 29 ++-----
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  2 +
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 37 ++++++++-
 15 files changed, 185 insertions(+), 112 deletions(-)

-- 
2.38.1

