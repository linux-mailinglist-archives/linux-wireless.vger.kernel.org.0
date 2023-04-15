Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FC06E2EDE
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Apr 2023 05:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjDODtn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 23:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjDODtl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 23:49:41 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1961E55B3
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 20:49:38 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33F3n9Mo9021866, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33F3n9Mo9021866
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Sat, 15 Apr 2023 11:49:09 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Sat, 15 Apr 2023 11:49:32 +0800
Received: from localhost (172.16.20.53) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Sat, 15 Apr
 2023 11:49:31 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <gary.chang@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 2/6] wifi: rtw89: refine scan function after chanctx
Date:   Sat, 15 Apr 2023 11:48:56 +0800
Message-ID: <20230415034900.15679-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230415034900.15679-1-pkshih@realtek.com>
References: <20230415034900.15679-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.20.53]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)
X-KSE-ServerInfo: RTEXDAG02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

Since we can get the current channel definition each interface maps to,
remove store_op function that is no longer required to make things simple.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     |  9 ++++
 drivers/net/wireless/realtek/rtw89/core.h     |  7 ++-
 drivers/net/wireless/realtek/rtw89/fw.c       | 47 ++++++-------------
 drivers/net/wireless/realtek/rtw89/fw.h       |  1 -
 drivers/net/wireless/realtek/rtw89/mac.c      | 14 ++++--
 drivers/net/wireless/realtek/rtw89/mac80211.c |  1 -
 6 files changed, 35 insertions(+), 44 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index d144903c60b3d..e213140a6f3a7 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -360,6 +360,15 @@ void rtw89_set_channel(struct rtw89_dev *rtwdev)
 	rtw89_set_entity_state(rtwdev, true);
 }
 
+void rtw89_get_channel(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+		       struct rtw89_chan *chan)
+{
+	const struct cfg80211_chan_def *chandef;
+
+	chandef = rtw89_chandef_get(rtwdev, rtwvif->sub_entity_idx);
+	rtw89_get_channel_params(chandef, chan);
+}
+
 static enum rtw89_core_tx_type
 rtw89_core_get_tx_type(struct rtw89_dev *rtwdev,
 		       struct sk_buff *skb)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index eab0abb9d213c..1f81301ed122b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3933,10 +3933,7 @@ struct rtw89_early_h2c {
 struct rtw89_hw_scan_info {
 	struct ieee80211_vif *scanning_vif;
 	struct list_head pkt_list[NUM_NL80211_BANDS];
-	u8 op_pri_ch;
-	u8 op_chan;
-	u8 op_bw;
-	u8 op_band;
+	struct rtw89_chan op_chan;
 	u32 last_chan_idx;
 };
 
@@ -4978,6 +4975,8 @@ void rtw89_free_ieee80211_hw(struct rtw89_dev *rtwdev);
 void rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev);
 void rtw89_get_default_chandef(struct cfg80211_chan_def *chandef);
 void rtw89_set_channel(struct rtw89_dev *rtwdev);
+void rtw89_get_channel(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+		       struct rtw89_chan *chan);
 u8 rtw89_core_acquire_bit_map(unsigned long *addr, unsigned long size);
 void rtw89_core_release_bit_map(unsigned long *addr, u8 bit);
 void rtw89_core_release_all_bits_map(unsigned long *addr, unsigned int nbits);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index c22e282849ff6..8a8d166ef04fb 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2545,7 +2545,7 @@ int rtw89_fw_h2c_scan_offload(struct rtw89_dev *rtwdev,
 			      struct rtw89_scan_option *option,
 			      struct rtw89_vif *rtwvif)
 {
-	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
+	struct rtw89_chan *op = &rtwdev->scan_info.op_chan;
 	struct sk_buff *skb;
 	u8 *cmd;
 	int ret;
@@ -2567,13 +2567,11 @@ int rtw89_fw_h2c_scan_offload(struct rtw89_dev *rtwdev,
 	RTW89_SET_FWCMD_SCANOFLD_START_MODE(cmd, RTW89_SCAN_IMMEDIATE);
 	RTW89_SET_FWCMD_SCANOFLD_SCAN_TYPE(cmd, RTW89_SCAN_ONCE);
 	if (option->target_ch_mode) {
-		RTW89_SET_FWCMD_SCANOFLD_TARGET_CH_BW(cmd, scan_info->op_bw);
+		RTW89_SET_FWCMD_SCANOFLD_TARGET_CH_BW(cmd, op->band_width);
 		RTW89_SET_FWCMD_SCANOFLD_TARGET_PRI_CH(cmd,
-						       scan_info->op_pri_ch);
-		RTW89_SET_FWCMD_SCANOFLD_TARGET_CENTRAL_CH(cmd,
-							   scan_info->op_chan);
-		RTW89_SET_FWCMD_SCANOFLD_TARGET_CH_BAND(cmd,
-							scan_info->op_band);
+						       op->primary_channel);
+		RTW89_SET_FWCMD_SCANOFLD_TARGET_CENTRAL_CH(cmd, op->channel);
+		RTW89_SET_FWCMD_SCANOFLD_TARGET_CH_BAND(cmd, op->band_type);
 	}
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
@@ -3152,6 +3150,7 @@ static void rtw89_hw_scan_add_chan(struct rtw89_dev *rtwdev, int chan_type,
 	struct ieee80211_vif *vif = rtwdev->scan_info.scanning_vif;
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 	struct cfg80211_scan_request *req = rtwvif->scan_req;
+	struct rtw89_chan *op = &rtwdev->scan_info.op_chan;
 	struct rtw89_pktofld_info *info;
 	u8 band, probe_count = 0;
 	int ret;
@@ -3195,10 +3194,10 @@ static void rtw89_hw_scan_add_chan(struct rtw89_dev *rtwdev, int chan_type,
 
 	switch (chan_type) {
 	case RTW89_CHAN_OPERATE:
-		ch_info->central_ch = scan_info->op_chan;
-		ch_info->pri_ch = scan_info->op_pri_ch;
-		ch_info->ch_band = scan_info->op_band;
-		ch_info->bw = scan_info->op_bw;
+		ch_info->central_ch = op->channel;
+		ch_info->pri_ch = op->primary_channel;
+		ch_info->ch_band = op->band_type;
+		ch_info->bw = op->band_width;
 		ch_info->tx_null = true;
 		ch_info->num_pkt = 0;
 		break;
@@ -3315,6 +3314,7 @@ void rtw89_hw_scan_start(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 	u32 rx_fltr = rtwdev->hal.rx_fltr;
 	u8 mac_addr[ETH_ALEN];
 
+	rtw89_get_channel(rtwdev, rtwvif, &rtwdev->scan_info.op_chan);
 	rtwdev->scan_info.scanning_vif = vif;
 	rtwdev->scan_info.last_chan_idx = 0;
 	rtwvif->scan_ies = &scan_req->ies;
@@ -3340,6 +3340,7 @@ void rtw89_hw_scan_start(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 void rtw89_hw_scan_complete(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 			    bool aborted)
 {
+	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
 	struct cfg80211_scan_info info = {
 		.aborted = aborted,
 	};
@@ -3361,11 +3362,9 @@ void rtw89_hw_scan_complete(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 	rtwvif = (struct rtw89_vif *)vif->drv_priv;
 	rtwvif->scan_req = NULL;
 	rtwvif->scan_ies = NULL;
-	rtwdev->scan_info.last_chan_idx = 0;
-	rtwdev->scan_info.scanning_vif = NULL;
+	scan_info->last_chan_idx = 0;
+	scan_info->scanning_vif = NULL;
 
-	if (rtwvif->net_type != RTW89_NET_TYPE_NO_LINK)
-		rtw89_store_op_chan(rtwdev, false);
 	rtw89_set_channel(rtwdev);
 }
 
@@ -3401,24 +3400,6 @@ int rtw89_hw_scan_offload(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 	return ret;
 }
 
-void rtw89_store_op_chan(struct rtw89_dev *rtwdev, bool backup)
-{
-	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
-	const struct rtw89_chan *cur = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
-	struct rtw89_chan new;
-
-	if (backup) {
-		scan_info->op_pri_ch = cur->primary_channel;
-		scan_info->op_chan = cur->channel;
-		scan_info->op_bw = cur->band_width;
-		scan_info->op_band = cur->band_type;
-	} else {
-		rtw89_chan_create(&new, scan_info->op_chan, scan_info->op_pri_ch,
-				  scan_info->op_band, scan_info->op_bw);
-		rtw89_assign_entity_chan(rtwdev, RTW89_SUB_ENTITY_0, &new);
-	}
-}
-
 #define H2C_FW_CPU_EXCEPTION_LEN 4
 #define H2C_FW_CPU_EXCEPTION_TYPE_DEF 0x5566
 int rtw89_fw_h2c_trigger_cpu_exception(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index a2ff173e55446..5f73b86f54d93 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3754,7 +3754,6 @@ int rtw89_fw_msg_reg(struct rtw89_dev *rtwdev,
 		     struct rtw89_mac_c2h_info *c2h_info);
 int rtw89_fw_h2c_fw_log(struct rtw89_dev *rtwdev, bool enable);
 void rtw89_fw_st_dbg_dump(struct rtw89_dev *rtwdev);
-void rtw89_store_op_chan(struct rtw89_dev *rtwdev, bool backup);
 void rtw89_hw_scan_start(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 			 struct ieee80211_scan_request *req);
 void rtw89_hw_scan_complete(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 385e2a0dfea58..f363a4a02c888 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4192,9 +4192,9 @@ rtw89_mac_c2h_macid_pause(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len
 
 static bool rtw89_is_op_chan(struct rtw89_dev *rtwdev, u8 band, u8 channel)
 {
-	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
+	const struct rtw89_chan *op = &rtwdev->scan_info.op_chan;
 
-	return band == scan_info->op_band && channel == scan_info->op_pri_ch;
+	return band == op->band_type && channel == op->primary_channel;
 }
 
 static void
@@ -4244,11 +4244,15 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
 		}
 		break;
 	case RTW89_SCAN_ENTER_CH_NOTIFY:
-		rtw89_chan_create(&new, chan, chan, band, RTW89_CHANNEL_WIDTH_20);
-		rtw89_assign_entity_chan(rtwdev, RTW89_SUB_ENTITY_0, &new);
 		if (rtw89_is_op_chan(rtwdev, band, chan)) {
-			rtw89_store_op_chan(rtwdev, false);
+			rtw89_assign_entity_chan(rtwdev, rtwvif->sub_entity_idx,
+						 &rtwdev->scan_info.op_chan);
 			ieee80211_wake_queues(rtwdev->hw);
+		} else {
+			rtw89_chan_create(&new, chan, chan, band,
+					  RTW89_CHANNEL_WIDTH_20);
+			rtw89_assign_entity_chan(rtwdev, rtwvif->sub_entity_idx,
+						 &new);
 		}
 		break;
 	default:
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index b5cbfc15ebad8..ee4588b61b8f6 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -418,7 +418,6 @@ static void rtw89_ops_bss_info_changed(struct ieee80211_hw *hw,
 			rtw89_chip_cfg_txpwr_ul_tb_offset(rtwdev, vif);
 			rtw89_mac_port_update(rtwdev, rtwvif);
 			rtw89_mac_set_he_obss_narrow_bw_ru(rtwdev, vif);
-			rtw89_store_op_chan(rtwdev, true);
 		} else {
 			/* Abort ongoing scan if cancel_scan isn't issued
 			 * when disconnected by peer
-- 
2.25.1

