Return-Path: <linux-wireless+bounces-21809-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5B1A95AA3
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 03:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC1F173E43
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 01:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C0D18DB22;
	Tue, 22 Apr 2025 01:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="MmyknsqK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C5D197A7A
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 01:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745286434; cv=none; b=AWwAcrwLvEnXRijeZLHmxYGO2mqYpX4cs26zZVUE+i91695yDEy1SA2PESWDpEOsnbJAoC5JgRbg9huJUnYb/yu1Nj6YyAINWvP13l6QNp8wDMmd/Rsyvlk5JlhOUyOfHoy8f+HAAQfXfuIrdMGYEhaZd30/E/os7MPdkIV4mvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745286434; c=relaxed/simple;
	bh=e+y7HpQHESatc+mY5vz9S13495sjiu7KyriQgXsX+rc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a9UWn8eJUGdDsAO18Ic2QDbAQWi4jbBToFXTI1ThKHQKOs7xNgS+6l6qbtZbn3loYt38HvnkkjRKiYZw4cN3EQEkQf77bAgppMprNhnOPCR0OQkS/x8NZLrAed2UJEIkZR3kvvPUNf2Kbm4CoQpvXgv7LFyAK+ZtRadx0Bch6PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=MmyknsqK; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53M1lAbT53859524, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745286430; bh=e+y7HpQHESatc+mY5vz9S13495sjiu7KyriQgXsX+rc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=MmyknsqKNz/yIzEp5D2rTxAWecowlqwN7P3/8kl9zC9asGhrnsAxoALabD+IDnTkn
	 dr4O4NljVlG1YUnP0fdmik21oNbQ1h6CtRA4hvm0a6aORp/da5JJcvvaLqhFjdmJ6r
	 Hd1/ZtvDN4kizLQJJ/r7oV9mdf2meo3fm6JV25nl18bHb5k8n5SHViUIE9u304hcBR
	 uhCMdOkMumavnV8NEOmKKW+kfau+hiDoWWiY7YtVh7nOGIt+CL229cPPVB4rpHxzML
	 Ubsnn5IjP5C5VOklMoqw+CXA4JC1K+Z49q65F0Md7Bpx+rot3lREumfJthAu67iK+A
	 PyZvZdN2qehgg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53M1lAbT53859524
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 09:47:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Apr 2025 09:47:10 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 22 Apr
 2025 09:47:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 04/12] wifi: rtw89: refactor flow that hw scan handles channel list
Date: Tue, 22 Apr 2025 09:46:12 +0800
Message-ID: <20250422014620.18421-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250422014620.18421-1-pkshih@realtek.com>
References: <20250422014620.18421-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Zong-Zhe Yang <kevin_yang@realtek.com>

FW has a limited amount of channels that can be dealt with by one HW scan
H2C command. Based on the limit, channels in scan request might be parsed
into SW structure piece by piece along with multiple HW scan H2C commands.
But, in order to estimate things of entire HW scan process, it's required
to have the whole parsed channel list when HW scan is going to start. So,
tweak HW scan flow to prepare the whole channel list ahead. Still, each HW
scan H2C command takes allowed amount of channels from the list according
to the limit.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     |   4 +-
 drivers/net/wireless/realtek/rtw89/core.h     |   3 +-
 drivers/net/wireless/realtek/rtw89/fw.c       | 190 ++++++++++++++----
 drivers/net/wireless/realtek/rtw89/fw.h       |  16 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |   6 +-
 drivers/net/wireless/realtek/rtw89/mac.h      |   5 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |  10 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c   |   2 +
 8 files changed, 179 insertions(+), 57 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 869728922def..08ebc5651a16 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4862,6 +4862,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 			continue;
 		INIT_LIST_HEAD(&rtwdev->scan_info.pkt_list[band]);
 	}
+	INIT_LIST_HEAD(&rtwdev->scan_info.chan_list);
 	INIT_WORK(&rtwdev->ba_work, rtw89_core_ba_work);
 	INIT_WORK(&rtwdev->txq_work, rtw89_core_txq_work);
 	INIT_DELAYED_WORK(&rtwdev->txq_reinvoke_work, rtw89_core_txq_reinvoke_work);
@@ -4947,9 +4948,6 @@ void rtw89_core_scan_start(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwv
 	struct rtw89_bb_ctx *bb = rtw89_get_bb_ctx(rtwdev, rtwvif_link->phy_idx);
 
 	rtwdev->scanning = true;
-	rtw89_leave_lps(rtwdev);
-	if (hw_scan)
-		rtw89_leave_ips_by_hwflags(rtwdev);
 
 	ether_addr_copy(rtwvif_link->mac_addr, mac_addr);
 	rtw89_btc_ntfy_scan_start(rtwdev, rtwvif_link->phy_idx, chan->band_type);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 54843f95746c..189b3526ea9b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5422,9 +5422,10 @@ struct rtw89_early_h2c {
 struct rtw89_hw_scan_info {
 	struct rtw89_vif_link *scanning_vif;
 	struct list_head pkt_list[NUM_NL80211_BANDS];
+	struct list_head chan_list;
 	struct rtw89_chan op_chan;
+	bool connected;
 	bool abort;
-	u32 last_chan_idx;
 };
 
 enum rtw89_phy_bb_gain_band {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 5cf4b3cba047..ae402d4c3773 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -15,6 +15,8 @@
 #include "util.h"
 #include "wow.h"
 
+static bool rtw89_is_any_vif_connected_or_connecting(struct rtw89_dev *rtwdev);
+
 struct rtw89_eapol_2_of_2 {
 	u8 gtkbody[14];
 	u8 key_des_ver;
@@ -6535,7 +6537,7 @@ void rtw89_fw_st_dbg_dump(struct rtw89_dev *rtwdev)
 	rtw89_fw_prog_cnt_dump(rtwdev);
 }
 
-static void rtw89_release_pkt_list(struct rtw89_dev *rtwdev)
+static void rtw89_hw_scan_release_pkt_list(struct rtw89_dev *rtwdev)
 {
 	struct list_head *pkt_list = rtwdev->scan_info.pkt_list;
 	struct rtw89_pktofld_info *info, *tmp;
@@ -6554,6 +6556,23 @@ static void rtw89_release_pkt_list(struct rtw89_dev *rtwdev)
 	}
 }
 
+static void rtw89_hw_scan_cleanup(struct rtw89_dev *rtwdev,
+				  struct rtw89_vif_link *rtwvif_link)
+{
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
+	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
+
+	mac->free_chan_list(rtwdev);
+	rtw89_hw_scan_release_pkt_list(rtwdev);
+
+	rtwvif->scan_req = NULL;
+	rtwvif->scan_ies = NULL;
+	scan_info->scanning_vif = NULL;
+	scan_info->abort = false;
+	scan_info->connected = false;
+}
+
 static bool rtw89_is_6ghz_wildcard_probe_req(struct rtw89_dev *rtwdev,
 					     struct cfg80211_scan_request *req,
 					     struct rtw89_pktofld_info *info,
@@ -6622,7 +6641,8 @@ static int rtw89_append_probe_req_ie(struct rtw89_dev *rtwdev,
 }
 
 static int rtw89_hw_scan_update_probe_req(struct rtw89_dev *rtwdev,
-					  struct rtw89_vif_link *rtwvif_link)
+					  struct rtw89_vif_link *rtwvif_link,
+					  const u8 *mac_addr)
 {
 	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
 	struct cfg80211_scan_request *req = rtwvif->scan_req;
@@ -6631,7 +6651,7 @@ static int rtw89_hw_scan_update_probe_req(struct rtw89_dev *rtwdev,
 	int ret;
 
 	for (i = 0; i < num; i++) {
-		skb = ieee80211_probereq_get(rtwdev->hw, rtwvif_link->mac_addr,
+		skb = ieee80211_probereq_get(rtwdev->hw, mac_addr,
 					     req->ssids[i].ssid,
 					     req->ssids[i].ssid_len,
 					     req->ie_len);
@@ -7005,24 +7025,24 @@ int rtw89_pno_scan_add_chan_list_ax(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
-int rtw89_hw_scan_add_chan_list_ax(struct rtw89_dev *rtwdev,
-				   struct rtw89_vif_link *rtwvif_link, bool connected)
+int rtw89_hw_scan_prep_chan_list_ax(struct rtw89_dev *rtwdev,
+				    struct rtw89_vif_link *rtwvif_link)
 {
+	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
 	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
 	struct cfg80211_scan_request *req = rtwvif->scan_req;
 	struct rtw89_mac_chinfo_ax *ch_info, *tmp;
 	struct ieee80211_channel *channel;
 	struct list_head chan_list;
 	bool random_seq = req->flags & NL80211_SCAN_FLAG_RANDOM_SN;
-	int list_len, off_chan_time = 0;
 	enum rtw89_chan_type type;
-	int ret = 0;
+	int off_chan_time = 0;
+	int ret;
 	u32 idx;
 
 	INIT_LIST_HEAD(&chan_list);
-	for (idx = rtwdev->scan_info.last_chan_idx, list_len = 0;
-	     idx < req->n_channels && list_len < RTW89_SCAN_LIST_LIMIT_AX;
-	     idx++, list_len++) {
+
+	for (idx = 0; idx < req->n_channels; idx++) {
 		channel = req->channels[idx];
 		ch_info = kzalloc(sizeof(*ch_info), GFP_KERNEL);
 		if (!ch_info) {
@@ -7051,7 +7071,7 @@ int rtw89_hw_scan_add_chan_list_ax(struct rtw89_dev *rtwdev,
 			type = RTW89_CHAN_ACTIVE;
 		rtw89_hw_scan_add_chan_ax(rtwdev, type, req->n_ssids, ch_info);
 
-		if (connected &&
+		if (scan_info->connected &&
 		    off_chan_time + ch_info->period > RTW89_OFF_CHAN_TIME) {
 			tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);
 			if (!tmp) {
@@ -7066,13 +7086,13 @@ int rtw89_hw_scan_add_chan_list_ax(struct rtw89_dev *rtwdev,
 			rtw89_hw_scan_add_chan_ax(rtwdev, type, 0, tmp);
 			list_add_tail(&tmp->list, &chan_list);
 			off_chan_time = 0;
-			list_len++;
 		}
 		list_add_tail(&ch_info->list, &chan_list);
 		off_chan_time += ch_info->period;
 	}
-	rtwdev->scan_info.last_chan_idx = idx;
-	ret = rtw89_fw_h2c_scan_list_offload_ax(rtwdev, list_len, &chan_list);
+
+	list_splice_tail(&chan_list, &scan_info->chan_list);
+	return 0;
 
 out:
 	list_for_each_entry_safe(ch_info, tmp, &chan_list, list) {
@@ -7083,6 +7103,46 @@ int rtw89_hw_scan_add_chan_list_ax(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
+void rtw89_hw_scan_free_chan_list_ax(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
+	struct rtw89_mac_chinfo_ax *ch_info, *tmp;
+
+	list_for_each_entry_safe(ch_info, tmp, &scan_info->chan_list, list) {
+		list_del(&ch_info->list);
+		kfree(ch_info);
+	}
+}
+
+int rtw89_hw_scan_add_chan_list_ax(struct rtw89_dev *rtwdev,
+				   struct rtw89_vif_link *rtwvif_link)
+{
+	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
+	struct rtw89_mac_chinfo_ax *ch_info, *tmp;
+	unsigned int list_len = 0;
+	struct list_head list;
+	int ret;
+
+	INIT_LIST_HEAD(&list);
+
+	list_for_each_entry_safe(ch_info, tmp, &scan_info->chan_list, list) {
+		list_move_tail(&ch_info->list, &list);
+
+		list_len++;
+		if (list_len == RTW89_SCAN_LIST_LIMIT_AX)
+			break;
+	}
+
+	ret = rtw89_fw_h2c_scan_list_offload_ax(rtwdev, list_len, &list);
+
+	list_for_each_entry_safe(ch_info, tmp, &list, list) {
+		list_del(&ch_info->list);
+		kfree(ch_info);
+	}
+
+	return ret;
+}
+
 int rtw89_pno_scan_add_chan_list_be(struct rtw89_dev *rtwdev,
 				    struct rtw89_vif_link *rtwvif_link)
 {
@@ -7136,25 +7196,24 @@ int rtw89_pno_scan_add_chan_list_be(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
-int rtw89_hw_scan_add_chan_list_be(struct rtw89_dev *rtwdev,
-				   struct rtw89_vif_link *rtwvif_link, bool connected)
+int rtw89_hw_scan_prep_chan_list_be(struct rtw89_dev *rtwdev,
+				    struct rtw89_vif_link *rtwvif_link)
 {
+	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
 	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
 	struct cfg80211_scan_request *req = rtwvif->scan_req;
 	struct rtw89_mac_chinfo_be *ch_info, *tmp;
 	struct ieee80211_channel *channel;
 	struct list_head chan_list;
 	enum rtw89_chan_type type;
-	int list_len, ret;
 	bool random_seq;
+	int ret;
 	u32 idx;
 
 	random_seq = !!(req->flags & NL80211_SCAN_FLAG_RANDOM_SN);
 	INIT_LIST_HEAD(&chan_list);
 
-	for (idx = rtwdev->scan_info.last_chan_idx, list_len = 0;
-	     idx < req->n_channels && list_len < RTW89_SCAN_LIST_LIMIT_BE;
-	     idx++, list_len++) {
+	for (idx = 0; idx < req->n_channels; idx++) {
 		channel = req->channels[idx];
 		ch_info = kzalloc(sizeof(*ch_info), GFP_KERNEL);
 		if (!ch_info) {
@@ -7184,9 +7243,8 @@ int rtw89_hw_scan_add_chan_list_be(struct rtw89_dev *rtwdev,
 		list_add_tail(&ch_info->list, &chan_list);
 	}
 
-	rtwdev->scan_info.last_chan_idx = idx;
-	ret = rtw89_fw_h2c_scan_list_offload_be(rtwdev, list_len, &chan_list,
-						rtwvif_link);
+	list_splice_tail(&chan_list, &scan_info->chan_list);
+	return 0;
 
 out:
 	list_for_each_entry_safe(ch_info, tmp, &chan_list, list) {
@@ -7197,25 +7255,67 @@ int rtw89_hw_scan_add_chan_list_be(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
+void rtw89_hw_scan_free_chan_list_be(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
+	struct rtw89_mac_chinfo_be *ch_info, *tmp;
+
+	list_for_each_entry_safe(ch_info, tmp, &scan_info->chan_list, list) {
+		list_del(&ch_info->list);
+		kfree(ch_info);
+	}
+}
+
+int rtw89_hw_scan_add_chan_list_be(struct rtw89_dev *rtwdev,
+				   struct rtw89_vif_link *rtwvif_link)
+{
+	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
+	struct rtw89_mac_chinfo_be *ch_info, *tmp;
+	unsigned int list_len = 0;
+	struct list_head list;
+	int ret;
+
+	INIT_LIST_HEAD(&list);
+
+	list_for_each_entry_safe(ch_info, tmp, &scan_info->chan_list, list) {
+		list_move_tail(&ch_info->list, &list);
+
+		list_len++;
+		if (list_len == RTW89_SCAN_LIST_LIMIT_BE)
+			break;
+	}
+
+	ret = rtw89_fw_h2c_scan_list_offload_be(rtwdev, list_len, &list,
+						rtwvif_link);
+
+	list_for_each_entry_safe(ch_info, tmp, &list, list) {
+		list_del(&ch_info->list);
+		kfree(ch_info);
+	}
+
+	return ret;
+}
+
 static int rtw89_hw_scan_prehandle(struct rtw89_dev *rtwdev,
-				   struct rtw89_vif_link *rtwvif_link, bool connected)
+				   struct rtw89_vif_link *rtwvif_link,
+				   const u8 *mac_addr)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	int ret;
 
-	ret = rtw89_hw_scan_update_probe_req(rtwdev, rtwvif_link);
+	ret = rtw89_hw_scan_update_probe_req(rtwdev, rtwvif_link, mac_addr);
 	if (ret) {
 		rtw89_err(rtwdev, "Update probe request failed\n");
 		goto out;
 	}
-	ret = mac->add_chan_list(rtwdev, rtwvif_link, connected);
+	ret = mac->prep_chan_list(rtwdev, rtwvif_link);
 out:
 	return ret;
 }
 
-void rtw89_hw_scan_start(struct rtw89_dev *rtwdev,
-			 struct rtw89_vif_link *rtwvif_link,
-			 struct ieee80211_scan_request *scan_req)
+int rtw89_hw_scan_start(struct rtw89_dev *rtwdev,
+			struct rtw89_vif_link *rtwvif_link,
+			struct ieee80211_scan_request *scan_req)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	struct cfg80211_scan_request *req = &scan_req->req;
@@ -7225,23 +7325,32 @@ void rtw89_hw_scan_start(struct rtw89_dev *rtwdev,
 	u32 rx_fltr = rtwdev->hal.rx_fltr;
 	u8 mac_addr[ETH_ALEN];
 	u32 reg;
+	int ret;
 
 	/* clone op and keep it during scan */
 	rtwdev->scan_info.op_chan = *chan;
 
+	rtwdev->scan_info.connected = rtw89_is_any_vif_connected_or_connecting(rtwdev);
 	rtwdev->scan_info.scanning_vif = rtwvif_link;
-	rtwdev->scan_info.last_chan_idx = 0;
 	rtwdev->scan_info.abort = false;
 	rtwvif->scan_ies = &scan_req->ies;
 	rtwvif->scan_req = req;
-	ieee80211_stop_queues(rtwdev->hw);
-	rtw89_mac_port_cfg_rx_sync(rtwdev, rtwvif_link, false);
 
 	if (req->flags & NL80211_SCAN_FLAG_RANDOM_ADDR)
 		get_random_mask_addr(mac_addr, req->mac_addr,
 				     req->mac_addr_mask);
 	else
 		ether_addr_copy(mac_addr, rtwvif_link->mac_addr);
+
+	ret = rtw89_hw_scan_prehandle(rtwdev, rtwvif_link, mac_addr);
+	if (ret) {
+		rtw89_hw_scan_cleanup(rtwdev, rtwvif_link);
+		return ret;
+	}
+
+	ieee80211_stop_queues(rtwdev->hw);
+	rtw89_mac_port_cfg_rx_sync(rtwdev, rtwvif_link, false);
+
 	rtw89_core_scan_start(rtwdev, rtwvif_link, mac_addr, true);
 
 	rx_fltr &= ~B_AX_A_BCN_CHK_EN;
@@ -7252,6 +7361,8 @@ void rtw89_hw_scan_start(struct rtw89_dev *rtwdev,
 	rtw89_write32_mask(rtwdev, reg, B_AX_RX_FLTR_CFG_MASK, rx_fltr);
 
 	rtw89_chanctx_pause(rtwdev, RTW89_CHANCTX_PAUSE_REASON_HW_SCAN);
+
+	return 0;
 }
 
 struct rtw89_hw_scan_complete_cb_data {
@@ -7262,20 +7373,16 @@ struct rtw89_hw_scan_complete_cb_data {
 static int rtw89_hw_scan_complete_cb(struct rtw89_dev *rtwdev, void *data)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
-	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
 	struct rtw89_hw_scan_complete_cb_data *cb_data = data;
 	struct rtw89_vif_link *rtwvif_link = cb_data->rtwvif_link;
 	struct cfg80211_scan_info info = {
 		.aborted = cb_data->aborted,
 	};
-	struct rtw89_vif *rtwvif;
 	u32 reg;
 
 	if (!rtwvif_link)
 		return -EINVAL;
 
-	rtwvif = rtwvif_link->rtwvif;
-
 	reg = rtw89_mac_reg_by_idx(rtwdev, mac->rx_fltr, rtwvif_link->mac_idx);
 	rtw89_write32_mask(rtwdev, reg, B_AX_RX_FLTR_CFG_MASK, rtwdev->hal.rx_fltr);
 
@@ -7285,12 +7392,7 @@ static int rtw89_hw_scan_complete_cb(struct rtw89_dev *rtwdev, void *data)
 	rtw89_mac_port_cfg_rx_sync(rtwdev, rtwvif_link, true);
 	rtw89_mac_enable_beacon_for_ap_vifs(rtwdev, true);
 
-	rtw89_release_pkt_list(rtwdev);
-	rtwvif->scan_req = NULL;
-	rtwvif->scan_ies = NULL;
-	scan_info->last_chan_idx = 0;
-	scan_info->scanning_vif = NULL;
-	scan_info->abort = false;
+	rtw89_hw_scan_cleanup(rtwdev, rtwvif_link);
 
 	return 0;
 }
@@ -7365,11 +7467,11 @@ int rtw89_hw_scan_offload(struct rtw89_dev *rtwdev,
 	if (!rtwvif_link)
 		return -EINVAL;
 
-	connected = rtw89_is_any_vif_connected_or_connecting(rtwdev);
+	connected = rtwdev->scan_info.connected;
 	opt.enable = enable;
 	opt.target_ch_mode = connected;
 	if (enable) {
-		ret = rtw89_hw_scan_prehandle(rtwdev, rtwvif_link, connected);
+		ret = mac->add_chan_list(rtwdev, rtwvif_link);
 		if (ret)
 			goto out;
 	}
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 1395ac9d6b78..0d89083df49a 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4716,9 +4716,9 @@ int rtw89_fw_msg_reg(struct rtw89_dev *rtwdev,
 		     struct rtw89_mac_c2h_info *c2h_info);
 int rtw89_fw_h2c_fw_log(struct rtw89_dev *rtwdev, bool enable);
 void rtw89_fw_st_dbg_dump(struct rtw89_dev *rtwdev);
-void rtw89_hw_scan_start(struct rtw89_dev *rtwdev,
-			 struct rtw89_vif_link *rtwvif_link,
-			 struct ieee80211_scan_request *scan_req);
+int rtw89_hw_scan_start(struct rtw89_dev *rtwdev,
+			struct rtw89_vif_link *rtwvif_link,
+			struct ieee80211_scan_request *scan_req);
 void rtw89_hw_scan_complete(struct rtw89_dev *rtwdev,
 			    struct rtw89_vif_link *rtwvif_link,
 			    bool aborted);
@@ -4727,12 +4727,18 @@ int rtw89_hw_scan_offload(struct rtw89_dev *rtwdev,
 			  bool enable);
 void rtw89_hw_scan_abort(struct rtw89_dev *rtwdev,
 			 struct rtw89_vif_link *rtwvif_link);
+int rtw89_hw_scan_prep_chan_list_ax(struct rtw89_dev *rtwdev,
+				    struct rtw89_vif_link *rtwvif_link);
+void rtw89_hw_scan_free_chan_list_ax(struct rtw89_dev *rtwdev);
 int rtw89_hw_scan_add_chan_list_ax(struct rtw89_dev *rtwdev,
-				   struct rtw89_vif_link *rtwvif_link, bool connected);
+				   struct rtw89_vif_link *rtwvif_link);
 int rtw89_pno_scan_add_chan_list_ax(struct rtw89_dev *rtwdev,
 				    struct rtw89_vif_link *rtwvif_link);
+int rtw89_hw_scan_prep_chan_list_be(struct rtw89_dev *rtwdev,
+				    struct rtw89_vif_link *rtwvif_link);
+void rtw89_hw_scan_free_chan_list_be(struct rtw89_dev *rtwdev);
 int rtw89_hw_scan_add_chan_list_be(struct rtw89_dev *rtwdev,
-				   struct rtw89_vif_link *rtwvif_link, bool connected);
+				   struct rtw89_vif_link *rtwvif_link);
 int rtw89_pno_scan_add_chan_list_be(struct rtw89_dev *rtwdev,
 				    struct rtw89_vif_link *rtwvif_link);
 int rtw89_fw_h2c_trigger_cpu_exception(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index b4841f948ec1..650e25f11fe4 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4899,11 +4899,11 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 	struct rtw89_vif_link *rtwvif_link = rtwdev->scan_info.scanning_vif;
 	struct rtw89_vif *rtwvif;
 	struct rtw89_chan new;
-	u32 last_chan = rtwdev->scan_info.last_chan_idx, report_tsf;
 	u16 actual_period, expect_period;
 	u8 reason, status, tx_fail, band;
 	u8 mac_idx, sw_def, fw_def;
 	u8 ver = U8_MAX;
+	u32 report_tsf;
 	u16 chan;
 	int ret;
 
@@ -4962,7 +4962,7 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 			return;
 
 		if (rtwvif_link && rtwvif->scan_req &&
-		    last_chan < rtwvif->scan_req->n_channels) {
+		    !list_empty(&rtwdev->scan_info.chan_list)) {
 			ret = rtw89_hw_scan_offload(rtwdev, rtwvif_link, true);
 			if (ret) {
 				rtw89_hw_scan_abort(rtwdev, rtwvif_link);
@@ -6889,6 +6889,8 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 
 	.is_txq_empty = mac_is_txq_empty_ax,
 
+	.prep_chan_list = rtw89_hw_scan_prep_chan_list_ax,
+	.free_chan_list = rtw89_hw_scan_free_chan_list_ax,
 	.add_chan_list = rtw89_hw_scan_add_chan_list_ax,
 	.add_chan_list_pno = rtw89_pno_scan_add_chan_list_ax,
 	.scan_offload = rtw89_fw_h2c_scan_offload_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index fd7935d24501..47d655fbf2ca 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1031,8 +1031,11 @@ struct rtw89_mac_gen_def {
 
 	bool (*is_txq_empty)(struct rtw89_dev *rtwdev);
 
+	int (*prep_chan_list)(struct rtw89_dev *rtwdev,
+			      struct rtw89_vif_link *rtwvif_link);
+	void (*free_chan_list)(struct rtw89_dev *rtwdev);
 	int (*add_chan_list)(struct rtw89_dev *rtwdev,
-			     struct rtw89_vif_link *rtwvif_link, bool connected);
+			     struct rtw89_vif_link *rtwvif_link);
 	int (*add_chan_list_pno)(struct rtw89_dev *rtwdev,
 				 struct rtw89_vif_link *rtwvif_link);
 	int (*scan_offload)(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 4fded07d0bee..d51e3267ab6c 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -1159,6 +1159,8 @@ static void rtw89_ops_sw_scan_start(struct ieee80211_hw *hw,
 		return;
 	}
 
+	rtw89_leave_lps(rtwdev);
+
 	rtw89_core_scan_start(rtwdev, rtwvif_link, mac_addr, false);
 }
 
@@ -1211,7 +1213,13 @@ static int rtw89_ops_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		return -ENOLINK;
 	}
 
-	rtw89_hw_scan_start(rtwdev, rtwvif_link, req);
+	rtw89_leave_lps(rtwdev);
+	rtw89_leave_ips_by_hwflags(rtwdev);
+
+	ret = rtw89_hw_scan_start(rtwdev, rtwvif_link, req);
+	if (ret)
+		return ret;
+
 	ret = rtw89_hw_scan_offload(rtwdev, rtwvif_link, true);
 	if (ret) {
 		rtw89_hw_scan_abort(rtwdev, rtwvif_link);
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 99b82dc85ea3..a1ba6ca431d7 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -2636,6 +2636,8 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 
 	.is_txq_empty = mac_is_txq_empty_be,
 
+	.prep_chan_list = rtw89_hw_scan_prep_chan_list_be,
+	.free_chan_list = rtw89_hw_scan_free_chan_list_be,
 	.add_chan_list = rtw89_hw_scan_add_chan_list_be,
 	.add_chan_list_pno = rtw89_pno_scan_add_chan_list_be,
 	.scan_offload = rtw89_fw_h2c_scan_offload_be,
-- 
2.25.1


