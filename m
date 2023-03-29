Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0685E6CD27F
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 09:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjC2HGI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 03:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjC2HGF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 03:06:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D812D4D
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 00:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680073554; x=1711609554;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mZEoLG+DEe2GoEFW/hykHFHt7SYgarLUVT17EyTlomE=;
  b=aegU6UqDwezeIAD1CO+0CqC+GNGdj33lPwByQO4jNiedU4ZFP3wbJ7Xt
   sE0JGO7XouoJ6I2513RuLpw/tVwUQZtEWmn/HXEtGsvr1Mj5HZKZMgF/6
   S70Kfga/HfvP5RJri/ytXd8jWorgsJpnpalcixKWfQiVJfpxwC2hPyp3b
   enGQC9g2VE7EQ1oP3FPvEvzNrmzVdtBkmfsp+cwjtsGx/fVFIqoVo1/Re
   n8i5d1sSC8OcFf53xMqbvM4Y79OUu8OjUsSC3iSQV9+8V/riyIUwal7Dh
   MqVmIct8EyKt4j30TeghS1ViJc4J9K6+eYqQjGint8iuvGW2CI7rmUgBI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320450670"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="320450670"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:05:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="795111083"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="795111083"
Received: from sfrank1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.228.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:05:50 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/34] wifi: iwlwifi: updates intended for v6.4 2023-03-29 
Date:   Wed, 29 Mar 2023 10:05:06 +0300
Message-Id: <20230329070540.2739372-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Hi,

Here's the next set of iwlwifi patches adding MLO support.
Also, advance FW API version to 75.

Thanks,
Gregory

Avraham Stern (1):
  wifi: iwlwifi: mvm: adjust iwl_mvm_scan_respect_p2p_go_iter() for MLO

Benjamin Berg (2):
  wifi: iwlwifi: mvm: use appropriate link for rate selection
  wifi: iwlwifi: mvm: initialize max_rc_amsdu_len per-link

Gregory Greenman (7):
  wifi: iwlwifi: mvm: adjust iwl_mvm_sec_key_remove_ap to MLO
  wifi: iwlwifi: mvm: adjust radar detection to MLO
  wifi: iwlwifi: mvm: adjust rs init to MLO
  wifi: iwlwifi: mvm: update mac config when assigning chanctx
  wifi: iwlwifi: mvm: rework active links counting
  wifi: iwlwifi: mvm: move max_agg_bufsize into host TLC lq_sta
  wifi: iwlwifi: bump FW API to 75 for AX devices

Johannes Berg (19):
  wifi: iwlwifi: mvm: make some HW flags conditional
  wifi: iwlwifi: mvm: fix narrow RU check for MLO
  wifi: iwlwifi: mvm: skip MEI update for MLO
  wifi: iwlwifi: mvm: use STA link address
  wifi: iwlwifi: mvm: rs-fw: don't crash on missing channel
  wifi: iwlwifi: mvm: coex: start handling multiple links
  wifi: iwlwifi: mvm: make a few warnings only trigger once
  wifi: iwlwifi: mvm: rxmq: report link ID to mac80211
  wifi: iwlwifi: mvm: skip inactive links
  wifi: iwlwifi: mvm: remove only link-specific AP keys
  wifi: iwlwifi: mvm: avoid sending MAC context for idle
  wifi: iwlwifi: mvm: remove chanctx WARN_ON
  wifi: iwlwifi: mvm: use the new lockdep-checking macros
  wifi: iwlwifi: mvm: fix station link data leak
  wifi: iwlwifi: mvm: clean up mac_id vs. link_id in MLD sta
  wifi: iwlwifi: mvm: send full STA during HW restart
  wifi: iwlwifi: mvm: free probe_resp_data later
  wifi: iwlwifi: separate AP link management queues
  wifi: iwlwifi: mvm: correctly use link in iwl_mvm_sta_del()

Shaul Triebitz (5):
  wifi: iwlwifi: mvm: use the link sta address
  wifi: iwlwifi: mvm: implement mac80211 callback change_sta_links
  wifi: iwlwifi: mvm: translate management frame address
  wifi: iwlwifi: mvm: use bcast/mcast link station id
  wifi: iwlwifi: mvm: use the correct link queue

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c |  89 +++--
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  33 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 126 +++++--
 .../net/wireless/intel/iwlwifi/mvm/mld-key.c  |  15 +-
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  48 ++-
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  | 335 ++++++++++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  11 +-
 .../net/wireless/intel/iwlwifi/mvm/power.c    |  21 +-
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    | 146 +++++---
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   |  19 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h   |  16 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  28 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |  22 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  45 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  11 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  29 +-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |   4 +
 19 files changed, 733 insertions(+), 275 deletions(-)

-- 
2.38.1

