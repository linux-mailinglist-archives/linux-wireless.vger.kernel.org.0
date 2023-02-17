Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBADD69AAEF
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Feb 2023 13:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjBQMA5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Feb 2023 07:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjBQMAy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Feb 2023 07:00:54 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F9E644DD
        for <linux-wireless@vger.kernel.org>; Fri, 17 Feb 2023 04:00:52 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 31HC0gNR2021913, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 31HC0gNR2021913
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 17 Feb 2023 20:00:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 17 Feb 2023 20:00:45 +0800
Received: from localhost (172.16.16.9) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 17 Feb
 2023 20:00:44 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2] wifi: rtw89: add RNR support for 6 GHz scan
Date:   Fri, 17 Feb 2023 20:00:07 +0800
Message-ID: <20230217120007.8835-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.9]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

Since 6 GHz band has around 60 channels and more strict rules for
active probing. Reduced neighbor report can be used to reduce the
channels we scan and get specific target BSS info to probe for.

Declare flag WIPHY_FLAG_SPLIT_SCAN_6GHZ so the scan request could be
divided into two portions: legacy bands and 6 GHz bands. So RNR
information from legacy bands could later be used when 6 GHz scan.

When the scan flag NL80211_SCAN_FLAG_COLOCATED_6GHZ is set, cfg80211
will pass down a reduced channel set which contains PSCs and non-PSC
with RNR info received in the 2 GHz/5 GHz band. This reduces the
scan duration by allowing us to only scan for channels in which APs
are currently operating.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: fix an error reported by smatch.
    rtw89_update_6ghz_rnr_chan() error: uninitialized symbol 'ret'
---
 drivers/net/wireless/realtek/rtw89/core.c |  35 +++++-
 drivers/net/wireless/realtek/rtw89/fw.c   | 136 +++++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/fw.h   |   7 ++
 3 files changed, 162 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index f09361bc4a4d1..489fa7a86160d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1400,6 +1400,34 @@ static void rtw89_stats_trigger_frame(struct rtw89_dev *rtwdev,
 	}
 }
 
+static void rtw89_core_cancel_6ghz_probe_tx(struct rtw89_dev *rtwdev,
+					    struct sk_buff *skb)
+{
+	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
+	struct list_head *pkt_list = rtwdev->scan_info.pkt_list;
+	struct rtw89_pktofld_info *info;
+	const u8 *ies = mgmt->u.beacon.variable, *ssid_ie;
+
+	if (rx_status->band != NL80211_BAND_6GHZ)
+		return;
+
+	ssid_ie = cfg80211_find_ie(WLAN_EID_SSID, ies, skb->len);
+
+	list_for_each_entry(info, &pkt_list[NL80211_BAND_6GHZ], list) {
+		if (ether_addr_equal(info->bssid, mgmt->bssid)) {
+			rtw89_fw_h2c_del_pkt_offload(rtwdev, info->id);
+			continue;
+		}
+
+		if (!ssid_ie || ssid_ie[1] != info->ssid_len || info->ssid_len == 0)
+			continue;
+
+		if (memcmp(&ssid_ie[2], info->ssid, info->ssid_len) == 0)
+			rtw89_fw_h2c_del_pkt_offload(rtwdev, info->id);
+	}
+}
+
 static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 				    struct ieee80211_vif *vif)
 {
@@ -1412,6 +1440,11 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	const u8 *bssid = iter_data->bssid;
 
+	if (rtwdev->scanning &&
+	    (ieee80211_is_beacon(hdr->frame_control) ||
+	     ieee80211_is_probe_resp(hdr->frame_control)))
+		rtw89_core_cancel_6ghz_probe_tx(rtwdev, skb);
+
 	if (!vif->bss_conf.bssid)
 		return;
 
@@ -3372,7 +3405,7 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 
 	hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_TDLS |
 			    WIPHY_FLAG_TDLS_EXTERNAL_SETUP |
-			    WIPHY_FLAG_AP_UAPSD;
+			    WIPHY_FLAG_AP_UAPSD | WIPHY_FLAG_SPLIT_SCAN_6GHZ;
 	hw->wiphy->features |= NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
 
 	hw->wiphy->max_scan_ssids = RTW89_SCANOFLD_MAX_SSID;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 0b73dc2e9ad77..a88f7974c1d6b 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2702,9 +2702,29 @@ static void rtw89_release_pkt_list(struct rtw89_dev *rtwdev)
 	}
 }
 
+static bool rtw89_is_6ghz_wildcard_probe_req(struct rtw89_dev *rtwdev,
+					     struct rtw89_vif *rtwvif,
+					     struct rtw89_pktofld_info *info,
+					     enum nl80211_band band, u8 ssid_idx)
+{
+	struct cfg80211_scan_request *req = rtwvif->scan_req;
+
+	if (band != NL80211_BAND_6GHZ)
+		return false;
+
+	if (req->ssids[ssid_idx].ssid_len) {
+		memcpy(info->ssid, req->ssids[ssid_idx].ssid,
+		       req->ssids[ssid_idx].ssid_len);
+		info->ssid_len = req->ssids[ssid_idx].ssid_len;
+		return false;
+	} else {
+		return true;
+	}
+}
+
 static int rtw89_append_probe_req_ie(struct rtw89_dev *rtwdev,
 				     struct rtw89_vif *rtwvif,
-				     struct sk_buff *skb)
+				     struct sk_buff *skb, u8 ssid_idx)
 {
 	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
 	struct ieee80211_scan_ies *ies = rtwvif->scan_ies;
@@ -2732,6 +2752,13 @@ static int rtw89_append_probe_req_ie(struct rtw89_dev *rtwdev,
 			goto out;
 		}
 
+		if (rtw89_is_6ghz_wildcard_probe_req(rtwdev, rtwvif, info, band,
+						     ssid_idx)) {
+			kfree_skb(new);
+			kfree(info);
+			goto out;
+		}
+
 		ret = rtw89_fw_h2c_add_pkt_offload(rtwdev, &info->id, new);
 		if (ret) {
 			kfree_skb(new);
@@ -2762,7 +2789,7 @@ static int rtw89_hw_scan_update_probe_req(struct rtw89_dev *rtwdev,
 		if (!skb)
 			return -ENOMEM;
 
-		ret = rtw89_append_probe_req_ie(rtwdev, rtwvif, skb);
+		ret = rtw89_append_probe_req_ie(rtwdev, rtwvif, skb, i);
 		kfree_skb(skb);
 
 		if (ret)
@@ -2772,6 +2799,77 @@ static int rtw89_hw_scan_update_probe_req(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+static int rtw89_update_6ghz_rnr_chan(struct rtw89_dev *rtwdev,
+				      struct cfg80211_scan_request *req,
+				      struct rtw89_mac_chinfo *ch_info)
+{
+	struct ieee80211_vif *vif = rtwdev->scan_info.scanning_vif;
+	struct list_head *pkt_list = rtwdev->scan_info.pkt_list;
+	struct rtw89_vif *rtwvif = vif_to_rtwvif_safe(vif);
+	struct ieee80211_scan_ies *ies = rtwvif->scan_ies;
+	struct cfg80211_scan_6ghz_params *params;
+	struct rtw89_pktofld_info *info, *tmp;
+	struct ieee80211_hdr *hdr;
+	struct sk_buff *skb;
+	bool found;
+	int ret = 0;
+	u8 i;
+
+	if (!req->n_6ghz_params)
+		return 0;
+
+	for (i = 0; i < req->n_6ghz_params; i++) {
+		params = &req->scan_6ghz_params[i];
+
+		if (req->channels[params->channel_idx]->hw_value !=
+		    ch_info->pri_ch)
+			continue;
+
+		found = false;
+		list_for_each_entry(tmp, &pkt_list[NL80211_BAND_6GHZ], list) {
+			if (ether_addr_equal(tmp->bssid, params->bssid)) {
+				found = true;
+				break;
+			}
+		}
+		if (found)
+			continue;
+
+		skb = ieee80211_probereq_get(rtwdev->hw, rtwvif->mac_addr,
+					     NULL, 0, req->ie_len);
+		skb_put_data(skb, ies->ies[NL80211_BAND_6GHZ], ies->len[NL80211_BAND_6GHZ]);
+		skb_put_data(skb, ies->common_ies, ies->common_ie_len);
+		hdr = (struct ieee80211_hdr *)skb->data;
+		ether_addr_copy(hdr->addr3, params->bssid);
+
+		info = kzalloc(sizeof(*info), GFP_KERNEL);
+		if (!info) {
+			ret = -ENOMEM;
+			kfree_skb(skb);
+			goto out;
+		}
+
+		ret = rtw89_fw_h2c_add_pkt_offload(rtwdev, &info->id, skb);
+		if (ret) {
+			kfree_skb(skb);
+			kfree(info);
+			goto out;
+		}
+
+		ether_addr_copy(info->bssid, params->bssid);
+		info->channel_6ghz = req->channels[params->channel_idx]->hw_value;
+		list_add_tail(&info->list, &rtwdev->scan_info.pkt_list[NL80211_BAND_6GHZ]);
+
+		ch_info->tx_pkt = true;
+		ch_info->period = RTW89_CHANNEL_TIME_6G + RTW89_DWELL_TIME_6G;
+
+		kfree_skb(skb);
+	}
+
+out:
+	return ret;
+}
+
 static void rtw89_hw_scan_add_chan(struct rtw89_dev *rtwdev, int chan_type,
 				   int ssid_num,
 				   struct rtw89_mac_chinfo *ch_info)
@@ -2782,6 +2880,7 @@ static void rtw89_hw_scan_add_chan(struct rtw89_dev *rtwdev, int chan_type,
 	struct cfg80211_scan_request *req = rtwvif->scan_req;
 	struct rtw89_pktofld_info *info;
 	u8 band, probe_count = 0;
+	int ret;
 
 	ch_info->notify_action = RTW89_SCANOFLD_DEBUG_MASK;
 	ch_info->dfs_ch = chan_type == RTW89_CHAN_DFS;
@@ -2793,25 +2892,31 @@ static void rtw89_hw_scan_add_chan(struct rtw89_dev *rtwdev, int chan_type,
 	ch_info->pause_data = false;
 	ch_info->probe_id = RTW89_SCANOFLD_PKT_NONE;
 
+	if (ch_info->ch_band == RTW89_BAND_6G) {
+		if ((ssid_num == 1 && req->ssids[0].ssid_len == 0) ||
+		    !ch_info->is_psc) {
+			ch_info->tx_pkt = false;
+			if (!req->duration_mandatory)
+				ch_info->period -= RTW89_DWELL_TIME_6G;
+		}
+	}
+
+	ret = rtw89_update_6ghz_rnr_chan(rtwdev, req, ch_info);
+	if (ret)
+		rtw89_warn(rtwdev, "RNR fails: %d\n", ret);
+
 	if (ssid_num) {
-		ch_info->num_pkt = ssid_num;
 		band = rtw89_hw_to_nl80211_band(ch_info->ch_band);
 
 		list_for_each_entry(info, &scan_info->pkt_list[band], list) {
-			ch_info->pkt_id[probe_count] = info->id;
-			if (++probe_count >= ssid_num)
+			if (info->channel_6ghz &&
+			    ch_info->pri_ch != info->channel_6ghz)
+				continue;
+			ch_info->pkt_id[probe_count++] = info->id;
+			if (probe_count >= RTW89_SCANOFLD_MAX_SSID)
 				break;
 		}
-		if (probe_count != ssid_num)
-			rtw89_err(rtwdev, "SSID num differs from list len\n");
-	}
-
-	if (ch_info->ch_band == RTW89_BAND_6G) {
-		if (ssid_num == 1 && req->ssids[0].ssid_len == 0) {
-			ch_info->tx_pkt = false;
-			if (!req->duration_mandatory)
-				ch_info->period -= RTW89_DWELL_TIME_6G;
-		}
+		ch_info->num_pkt = probe_count;
 	}
 
 	switch (chan_type) {
@@ -2872,6 +2977,7 @@ static int rtw89_hw_scan_add_chan_list(struct rtw89_dev *rtwdev,
 		ch_info->central_ch = channel->hw_value;
 		ch_info->pri_ch = channel->hw_value;
 		ch_info->rand_seq_num = random_seq;
+		ch_info->is_psc = cfg80211_channel_is_psc(channel);
 
 		if (channel->flags &
 		    (IEEE80211_CHAN_RADAR | IEEE80211_CHAN_NO_IR))
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index cae07e325326d..3f6e0871381df 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -237,6 +237,7 @@ struct rtw89_mac_chinfo {
 	u16 tx_pwr_idx;
 	u8 rsvd1;
 	struct list_head list;
+	bool is_psc;
 };
 
 struct rtw89_scan_option {
@@ -247,6 +248,12 @@ struct rtw89_scan_option {
 struct rtw89_pktofld_info {
 	struct list_head list;
 	u8 id;
+
+	/* Below fields are for 6 GHz RNR use only */
+	u8 ssid[IEEE80211_MAX_SSID_LEN];
+	u8 ssid_len;
+	u8 bssid[ETH_ALEN];
+	u16 channel_6ghz;
 };
 
 static inline void RTW89_SET_FWCMD_RA_IS_DIS(void *cmd, u32 val)
-- 
2.25.1

