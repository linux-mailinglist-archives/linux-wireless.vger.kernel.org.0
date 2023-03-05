Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E436AAF68
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Mar 2023 13:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjCEMR2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Mar 2023 07:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjCEMR1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Mar 2023 07:17:27 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEBE125BD
        for <linux-wireless@vger.kernel.org>; Sun,  5 Mar 2023 04:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678018642; x=1709554642;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dJk+LadQrjouq9PXJNYbYVl4pTFLPDuLr5SHZAfmmqI=;
  b=Ixp3X5OlwA5wmrP7JnRw7jr8T1w+6O/ScvcM4Pn53aESQjmgWS5MhZL8
   qTB9mCahS14UAPzPA+RWM5fm7WfIHmgdmfAnf9fbs6/re7ukZ6d77fNsC
   ZlYH7lC9z4jscmjuHA48/hSeDAdW2nNAFXQyP3GvToZw4stj99aZvQKyp
   wJ0pA8ZQSl4qSu6/dLtJf4yaI6ySimAG5oAMl6GqHY5qhI2NLHUYTrvkD
   PoqyjevP9KTigx+TSBcMXO53YMb6CWehuW7f1dOp96cFenmteDNIa+CyN
   Idwfk7ekP2ixT7h1tq6oHH3o9Rk8xeXoHrxEHXWvagCrxyXfOGoERufS9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="400193237"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="400193237"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:17:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="708355126"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="708355126"
Received: from hsaid-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.80.12])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:17:20 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/21] wifi: iwlwifi: mvm: add primary 80 known for EHT TLV
Date:   Sun,  5 Mar 2023 14:16:26 +0200
Message-Id: <20230305124407.fe9a5b58e241.I291ee480252d098f62d9ec39040284d3e521d88e@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230305121635.301451-1-gregory.greenman@intel.com>
References: <20230305121635.301451-1-gregory.greenman@intel.com>
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

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

We calculate based on chandef the place of the control channel inside
the wide band, this is used for understanding the N value in 11be D.5
table 9-53a for column PHY MU/MRU index.

To avoid the need to calculate every frame the value, do it once
monitor vif is added.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 26 ++++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 ++
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  6 +++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 565522466eba..c9911750d8af 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1362,6 +1362,28 @@ static void iwl_mvm_channel_switch_disconnect_wk(struct work_struct *wk)
 	ieee80211_chswitch_done(vif, false);
 }
 
+static u8
+iwl_mvm_chandef_get_primary_80(struct cfg80211_chan_def *chandef)
+{
+	int data_start;
+	int control_start;
+	int bw;
+
+	if (chandef->width == NL80211_CHAN_WIDTH_320)
+		bw = 320;
+	else if (chandef->width == NL80211_CHAN_WIDTH_160)
+		bw = 160;
+	else
+		return 0;
+
+	/* data is bw wide so the start is half the width */
+	data_start = chandef->center_freq1 - bw / 2;
+	/* control is 20Mhz width */
+	control_start = chandef->chan->center_freq - 10;
+
+	return (control_start - data_start) / 80;
+}
+
 static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 				     struct ieee80211_vif *vif)
 {
@@ -1478,8 +1500,10 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 	INIT_DELAYED_WORK(&mvmvif->csa_work,
 			  iwl_mvm_channel_switch_disconnect_wk);
 
-	if (vif->type == NL80211_IFTYPE_MONITOR)
+	if (vif->type == NL80211_IFTYPE_MONITOR) {
 		mvm->monitor_on = true;
+		mvm->monitor_p80 = iwl_mvm_chandef_get_primary_80(&vif->bss_conf.chandef);
+	}
 
 	iwl_mvm_vif_dbgfs_register(mvm, vif);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index ce6b701f3f4c..6862896c561e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1096,6 +1096,8 @@ struct iwl_mvm {
 
 	/* does a monitor vif exist (only one can exist hence bool) */
 	bool monitor_on;
+	/* primary channel place relative the whole bandwidth in gaps of 80Mhz */
+	u8 monitor_p80;
 
 	/* sniffer data to include in radiotap */
 	__le16 cur_aid;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index c8b4d751f5f0..d866fa534be5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1694,6 +1694,12 @@ static void iwl_mvm_decode_eht_phy_data(struct iwl_mvm *mvm,
 
 	iwl_mvm_decode_eht_ru(mvm, rx_status, eht);
 
+	/* We only get here in case of IWL_RX_MPDU_PHY_TSF_OVERLOAD is set
+	 * which is on only in case of monitor mode so no need to check monitor mode */
+	eht->known |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_KNOWN_PRIMARY_80);
+	eht->data[1] |= le32_encode_bits(mvm->monitor_p80,
+					 IEEE80211_RADIOTAP_EHT_DATA1_PRIMARY_80);
+
 	usig->common |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_USIG_COMMON_TXOP_KNOWN);
 	if (phy_data->with_data)
 		usig->common |= LE32_DEC_ENC(data0, IWL_RX_PHY_DATA0_EHT_TXOP_DUR_MASK,
-- 
2.38.1

