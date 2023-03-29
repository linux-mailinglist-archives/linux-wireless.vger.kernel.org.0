Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB3F6CD282
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 09:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjC2HGe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 03:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjC2HGc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 03:06:32 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485D326BA
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 00:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680073565; x=1711609565;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=seXxOB7EUKqd3T5L4CqZXbXCuRQvSL2K/8Vu7CyrZEY=;
  b=T6FeYGgiUje7HRzmgZ6C9Uu74Bst5WDtapW+iDDKSHD9PZFbFT7+L0M8
   hxuc3shYXTGyks8NxGQYRb5r6HiGSqw2CzjBLE7/2HtzKjqMxEsXpgyM6
   4gtY7JS0Hh7n9PQGn5cGHFx3uSeDJE3MS4oKlGXfdebfjEVQrbj71ZnGB
   bHlROo40X2nSGbAa53YB3EWkDw5hyR7ywl5ZiP8vCt1FCTTXyoHjX4QpO
   T4OGet02feIIlqg4l7tzHiLsBMHUW6vETevbGRqwBw2Is+JojU4nys6cU
   M7Ilu9eHTQqTKNOMUiYAm+yi1WvTIxgDX3WgGE42AEI3KodFhqz/BZ9E9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320450704"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="320450704"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:05:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="795111148"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="795111148"
Received: from sfrank1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.228.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:05:58 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/34] wifi: iwlwifi: mvm: skip MEI update for MLO
Date:   Wed, 29 Mar 2023 10:05:09 +0300
Message-Id: <20230329100039.aeaa746b14e7.I42b084f3cdc20bb52cf867700a3c2e1f5e7b4ecb@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230329070540.2739372-1-gregory.greenman@intel.com>
References: <20230329070540.2739372-1-gregory.greenman@intel.com>
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

From: Johannes Berg <johannes.berg@intel.com>

For now, if using MLO, skip the MEI update. It probably
needs new API for multiple channels.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 9eb95ed48d02..294e1c1de6b6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3464,7 +3464,6 @@ static void iwl_mvm_mei_host_associated(struct iwl_mvm *mvm,
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mei_conn_info conn_info = {
 		.ssid_len = vif->cfg.ssid_len,
-		.channel = vif->bss_conf.chandef.chan->hw_value,
 	};
 
 	if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
@@ -3473,6 +3472,12 @@ static void iwl_mvm_mei_host_associated(struct iwl_mvm *mvm,
 	if (!mvm->mei_registered)
 		return;
 
+	/* FIXME: MEI needs to be updated for MLO */
+	if (!vif->bss_conf.chandef.chan)
+		return;
+
+	conn_info.channel = vif->bss_conf.chandef.chan->hw_value;
+
 	switch (mvm_sta->pairwise_cipher) {
 	case WLAN_CIPHER_SUITE_TKIP:
 		conn_info.pairwise_cipher = IWL_MEI_CIPHER_TKIP;
-- 
2.38.1

