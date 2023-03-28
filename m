Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832796CB8FA
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 10:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjC1IAd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 04:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbjC1IAV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 04:00:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844DE449C
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 01:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679990420; x=1711526420;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o31XyDl8SEhvCv/cfMzp1TGdME+U86IwcPX6E9E4A50=;
  b=A4yojCo0A8xKazeRI+DR6jUAmK03CmEJIzrKP485uTK4eM8VllQIoNS7
   4fnosY1jFXWXVd7TDwQRwNczqO4T0HLD1cuZkEuRtAyUvfXWnu8JxsjeY
   tuHxBZVIVEC1MykqeAhDt3zCMzJ6H9algQLPi05rGJblE4vd5mNMTB63Q
   IYr9RD60nm7vXIXIhwJuFzk41wRXpDP/xcTbQcREjROlOkhzXarf/lTuv
   3TV45ijM3WMHv2FOMX+VC1gM031ElqlvR6jVXgqdptbtItz/jauexaiEY
   0BjtA2U65TaPeDeHLJSRABXS0+Ff/8g1UXoOAV1UFvLj7dD0iMnQbprJU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328958220"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="328958220"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 01:00:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="773045266"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="773045266"
Received: from gershonr-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.194.136])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 01:00:04 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 20/31] wifi: iwlwifi: mvm: add set_hw_timestamp to mld ops
Date:   Tue, 28 Mar 2023 10:59:00 +0300
Message-Id: <20230328104949.7b24a582b763.Ieb3139d41f1a01b2b566adecd32450da1bcdd5fa@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230328075911.2370108-1-gregory.greenman@intel.com>
References: <20230328075911.2370108-1-gregory.greenman@intel.com>
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

From: Avraham Stern <avraham.stern@intel.com>

In mld ops, set_hw_timestamp was not set. Fix it.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c     | 6 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c | 1 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h          | 3 +++
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 18e7ba98daa0..4dbc9a57746b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -5896,9 +5896,9 @@ static bool iwl_mvm_mac_can_aggregate(struct ieee80211_hw *hw,
 	return iwl_mvm_can_hw_csum(skb) == iwl_mvm_can_hw_csum(head);
 }
 
-static int iwl_mvm_set_hw_timestamp(struct ieee80211_hw *hw,
-				    struct ieee80211_vif *vif,
-				    struct cfg80211_set_hw_timestamp *hwts)
+int iwl_mvm_set_hw_timestamp(struct ieee80211_hw *hw,
+			     struct ieee80211_vif *vif,
+			     struct cfg80211_set_hw_timestamp *hwts)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	u32 protocols = 0;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 1d2da26408e6..15beed41b305 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -798,4 +798,5 @@ const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	.sta_add_debugfs = iwl_mvm_sta_add_debugfs,
 #endif
+	.set_hw_timestamp = iwl_mvm_set_hw_timestamp,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index af2059155794..9b04ae9c41ff 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2602,4 +2602,7 @@ bool iwl_mvm_have_links_same_channel(struct iwl_mvm_vif *vif1,
 bool iwl_mvm_vif_is_active(struct iwl_mvm_vif *mvmvif);
 int iwl_mvm_set_tx_power(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			 s16 tx_power);
+int iwl_mvm_set_hw_timestamp(struct ieee80211_hw *hw,
+			     struct ieee80211_vif *vif,
+			     struct cfg80211_set_hw_timestamp *hwts);
 #endif /* __IWL_MVM_H__ */
-- 
2.38.1

