Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD4D7BC9EB
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Oct 2023 23:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344165AbjJGVSC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Oct 2023 17:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344151AbjJGVSB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Oct 2023 17:18:01 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6B593
        for <linux-wireless@vger.kernel.org>; Sat,  7 Oct 2023 14:17:59 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id EF36CB00064
        for <linux-wireless@vger.kernel.org>; Sat,  7 Oct 2023 21:17:57 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 5239B13C2B0;
        Sat,  7 Oct 2023 14:17:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 5239B13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1696713476;
        bh=+Tda8tnbIe3iLGGVM5/rZzKON1EOX1kFfQftoUZkLa8=;
        h=From:To:Cc:Subject:Date:From;
        b=Eg4hYEASQ6Nw1xselOpSMqBGukwJPqr6ZpG2j9M48HObrjCb8kaJBXqqa3gncQBK5
         UYdW6ofiq8lRv55m9Loo5FYNUDR1lHBqM9Fn3Svr8OCU1E/S3LxMQOPkX/UMYe9lp7
         8yYT6K4/2RkV6DvHViA76TyIMfadc23xa1JRR9WI=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [RFC] wifi: iwlwifi:  Add ethtool rx-ampdu-count histogram.
Date:   Sat,  7 Oct 2023 14:17:54 -0700
Message-Id: <20231007211754.2122105-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1696713478-ourn5YCPL_YL
X-MDID-O: us5;ut7;1696713478;ourn5YCPL_YL;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Seems to mostly work, but I am seeing a lot more single ampdu and
2-10 ampdu counts that I'd expect, so maybe there are still bugs.
Perhaps some race if MQ means that ampdu_toggle cannot be used as I
am trying to use it?

Signed-off-by: Ben Greear <greearb@candelatech.com>
---

This patch won't apply upstream, it needs other iwlwifi ethtool patches
I posted previously.

But, I'd appreciate any feedback if someone has time to review it.

 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 19 +++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  5 ++
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   | 49 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 12 ++++-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  1 +
 5 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 2fa609a65749..71b8e774792c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -6592,6 +6592,22 @@ static const char iwl_mvm_gstrings_stats[][ETH_GSTRING_LEN] = {
 	"rx_mcs_12",
 	"rx_mcs_13",
 
+	"rx_ampdu_len:0-1",
+	"rx_ampdu_len:2-10",
+	"rx_ampdu_len:11-19",
+	"rx_ampdu_len:20-28",
+	"rx_ampdu_len:29-37",
+	"rx_ampdu_len:38-46",
+	"rx_ampdu_len:47-55",
+	"rx_ampdu_len:56-79",
+	"rx_ampdu_len:80-103",
+	"rx_ampdu_len:104-127",
+	"rx_ampdu_len:128-151",
+	"rx_ampdu_len:152-175",
+	"rx_ampdu_len:176-199",
+	"rx_ampdu_len:200-223",
+	"rx_ampdu_len:224-247", /* and higher */
+
 	"rx_nss_1",
 	"rx_nss_2",
 };
@@ -6712,6 +6728,9 @@ void iwl_mvm_get_et_stats(struct ieee80211_hw *hw,
 	for (i = 0; i < ARRAY_SIZE(mib->rx_mcs); i++)
 		data[ei++] = mib->rx_mcs[i];
 
+	for (i = 0; i < ARRAY_SIZE(mib->rx_ampdu_len); i++)
+		data[ei++] = mib->rx_ampdu_len[i];
+
 	for (i = 0; i < ARRAY_SIZE(mib->rx_nss); i++)
 		data[ei++] = mib->rx_nss[i];
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index b05eb752824d..1d88732899ea 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -616,6 +616,7 @@ struct iwl_mvm_ethtool_stats {
 	u64 rx_bw[5]; /* 20, 40, 80, 160, 320 */
 	u64 rx_bw_he_ru;
 	u64 rx_mcs[14]; /* mcs 0 to mcs 13 */
+	u64 rx_ampdu_len[15];
 	u64 rx_nss[2]; /* rx nss histogram */
 };
 
@@ -981,6 +982,8 @@ struct iwl_mvm {
 
 	u8 cca_40mhz_workaround;
 
+	/* Accumulate the count for the number of frames in the ampdu */
+	u32 rx_this_ampdu_count;
 	u32 ampdu_ref;
 	bool ampdu_toggle;
 
@@ -1916,6 +1919,8 @@ int iwl_mvm_load_d3_fw(struct iwl_mvm *mvm);
 
 int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm);
 
+void iwl_mvm_count_rx_histogram(struct iwl_mvm *mvm);
+
 /*
  * FW notifications / CMD responses handlers
  * Convention: iwl_mvm_rx_<NAME OF THE CMD>
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index ae9ce43a4461..7e9377b9f7aa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -28,6 +28,9 @@ void iwl_mvm_rx_rx_phy_cmd(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 	memcpy(&mvm->last_phy_info, pkt->data, sizeof(mvm->last_phy_info));
 	mvm->ampdu_ref++;
 
+	/* Add to histogram for last ampdu count */
+	iwl_mvm_count_rx_histogram(mvm);
+
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	if (mvm->last_phy_info.phy_flags & cpu_to_le16(RX_RES_PHY_FLAGS_AGG)) {
 		spin_lock(&mvm->drv_stats_lock);
@@ -198,6 +201,48 @@ static u32 iwl_mvm_set_mac80211_rx_flag(struct iwl_mvm *mvm,
 	return 0;
 }
 
+void iwl_mvm_count_rx_histogram(struct iwl_mvm *mvm)
+{
+	u32 count = mvm->rx_this_ampdu_count;
+
+	if (count == 0)
+		return;
+
+	/* rx-ampdu-len histogram, buckets match what mtk7915 supports. */
+	if (count <= 1)
+		mvm->ethtool_stats.rx_ampdu_len[0]++;
+	else if (count <= 10)
+		mvm->ethtool_stats.rx_ampdu_len[1]++;
+	else if (count <= 19)
+		mvm->ethtool_stats.rx_ampdu_len[2]++;
+	else if (count <= 28)
+		mvm->ethtool_stats.rx_ampdu_len[3]++;
+	else if (count <= 37)
+		mvm->ethtool_stats.rx_ampdu_len[4]++;
+	else if (count <= 46)
+		mvm->ethtool_stats.rx_ampdu_len[5]++;
+	else if (count <= 55)
+		mvm->ethtool_stats.rx_ampdu_len[6]++;
+	else if (count <= 79)
+		mvm->ethtool_stats.rx_ampdu_len[7]++;
+	else if (count <= 103)
+		mvm->ethtool_stats.rx_ampdu_len[8]++;
+	else if (count <= 127)
+		mvm->ethtool_stats.rx_ampdu_len[9]++;
+	else if (count <= 151)
+		mvm->ethtool_stats.rx_ampdu_len[10]++;
+	else if (count <= 175)
+		mvm->ethtool_stats.rx_ampdu_len[11]++;
+	else if (count <= 199)
+		mvm->ethtool_stats.rx_ampdu_len[12]++;
+	else if (count <= 223)
+		mvm->ethtool_stats.rx_ampdu_len[13]++;
+	else
+		mvm->ethtool_stats.rx_ampdu_len[14]++;
+
+	mvm->rx_this_ampdu_count = 0;
+}
+
 static void iwl_mvm_rx_handle_tcm(struct iwl_mvm *mvm,
 				  struct ieee80211_sta *sta,
 				  struct ieee80211_hdr *hdr, u32 len,
@@ -486,6 +531,10 @@ void iwl_mvm_rx_rx_mpdu(struct iwl_mvm *mvm, struct napi_struct *napi,
 		 */
 		rx_status->flag |= RX_FLAG_AMPDU_DETAILS;
 		rx_status->ampdu_reference = mvm->ampdu_ref;
+		mvm->rx_this_ampdu_count++;
+	} else {
+		/* Add to histogram for last ampdu count */
+		iwl_mvm_count_rx_histogram(mvm);
 	}
 
 	/* Set up the HT phy flags */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index a4ce27010dea..27508c504551 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -2525,11 +2525,11 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 	}
 
 	/* update aggregation data for monitor sake on default queue */
-	if (!queue && (phy_data.phy_info & IWL_RX_MPDU_PHY_AMPDU)) {
+	if (phy_data.phy_info & IWL_RX_MPDU_PHY_AMPDU) {
 		bool toggle_bit;
 
 		toggle_bit = phy_data.phy_info & IWL_RX_MPDU_PHY_AMPDU_TOGGLE;
-		rx_status->flag |= RX_FLAG_AMPDU_DETAILS;
+
 		/*
 		 * Toggle is switched whenever new aggregation starts. Make
 		 * sure ampdu_reference is never 0 so we can later use it to
@@ -2541,8 +2541,16 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 				mvm->ampdu_ref++;
 			mvm->ampdu_toggle = toggle_bit;
 			phy_data.first_subframe = true;
+			iwl_mvm_count_rx_histogram(mvm);
+			mvm->rx_this_ampdu_count = 1;
+		} else {
+			mvm->rx_this_ampdu_count++;
 		}
+		if (!queue)
+			rx_status->flag |= RX_FLAG_AMPDU_DETAILS;
 		rx_status->ampdu_reference = mvm->ampdu_ref;
+	} else {
+		iwl_mvm_count_rx_histogram(mvm);
 	}
 
 	rcu_read_lock();
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index b5d3538726b4..8fba19a7fd4f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1849,6 +1849,7 @@ static void iwl_mvm_update_tx_ampdu_histogram(struct iwl_mvm *mvm, int freed)
 		mvm->ethtool_stats.tx_ampdu_len[13]++;
 	else
 		mvm->ethtool_stats.tx_ampdu_len[14]++;
+	// TODO:  Consider higher buckets, quick experiment shows be200 freeing in the 250 range.
 }
 
 static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
-- 
2.40.0

