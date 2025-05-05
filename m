Return-Path: <linux-wireless+bounces-22436-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D35AA8CFB
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 09:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28467189170E
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 07:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA261C5D53;
	Mon,  5 May 2025 07:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="NBgUzzeJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C011DC9AF
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 07:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746429917; cv=none; b=C0cYdyQbYD4p5SRo18bK22SVyf4mye0Ebg8g/U2vBxufXM853Hh8RQXRElDBtpJ/qyZ4LWa3XRWR5uka8MfMiR5HuV+VFz8URPx4ppx8GQvZ9ID+ka7Xtj81PtPgKkftN4ruRvG5rMm+Ay7XJqBQsci29fO2SYV62Dxrjsc8+x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746429917; c=relaxed/simple;
	bh=NyEvHXQwdDPqKwfOetClIxbn6X/+kGxLR4OeD1u8nI0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z+4iuxyiyEvrH5N/G2D1mo8R5jt5sD+UlfTbS0hw8M7vr4vBAtk+5QmXLMeg4Yaf35OFNRLGx0xvjbGj5/Lkoq+FDFt+os9lHuVihnZf1d8mXOZRh80SzyiZn70sXGoKXv440XbF9LcBCpkUariXs+AHLnVsg9D9UEuFVG2drmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=NBgUzzeJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5457PDoY43831265, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746429913; bh=NyEvHXQwdDPqKwfOetClIxbn6X/+kGxLR4OeD1u8nI0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=NBgUzzeJsyqQUvLzEO+t8do7H8bHUfr+KrrehV0yKxAKqB+Ahw+LQpBf/2eNqUiQb
	 YjPNnBq0MZ9XQ2i1QvOAmqLQ2joK4RZdAbfN4k4J+PZK6afX9hNZSECoL58UnxfAYS
	 4k0/qL2j/BLWw+tGS6PP7bQDoJLh28SoKFTMP7qUxtmI4HWla7aVe1UmQv3BWHxh/i
	 IKmrUArkkx+0VE765Ch5Jmp0rw0PkRcgcjajhuN+GsXwPtDWZa6clJpRpXaplWbzTm
	 Tu+9hPJvKEBngggEmryDNQLrMmWx05a02MeCWbmyJ6HLQ9DRv2G8Y0ncPBI7L6Rwkc
	 2G9/ZHpBE8WNg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5457PDoY43831265
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 5 May 2025 15:25:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 May 2025 15:25:13 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 5 May
 2025 15:25:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 06/11] wifi: rtw89: add MLO track for MLSR switch decision
Date: Mon, 5 May 2025 15:24:35 +0800
Message-ID: <20250505072440.45113-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250505072440.45113-1-pkshih@realtek.com>
References: <20250505072440.45113-1-pkshih@realtek.com>
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

From: Po-Hao Huang <phhuang@realtek.com>

Add MLSR switch mechanism based on tracking RSSI. Switch to a 2 GHz link
(if any) when average RSSI is lower than threshold -53. And, switch out
from a 2 GHz link when average RSSI is larger than threshold -38.

The sequence of MLSR switch handling is like the following.
1. initialize target link and configure to PS mode
2. configure current designated link to PS mode
3. configure target link to non-PS mode
4. deinitialize currently active links except target link

The above flow also implies that target link becomes new designated link.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 159 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h     |  10 ++
 drivers/net/wireless/realtek/rtw89/fw.c       |   4 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |   2 +
 4 files changed, 174 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index b7b2670cbc88..95bdd46376bf 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3638,6 +3638,94 @@ void rtw89_traffic_stats_init(struct rtw89_dev *rtwdev,
 	ewma_tp_init(&stats->rx_ewma_tp);
 }
 
+#define RTW89_MLSR_GOTO_2GHZ_THRESHOLD -53
+#define RTW89_MLSR_EXIT_2GHZ_THRESHOLD -38
+static void rtw89_core_mlsr_link_decision(struct rtw89_dev *rtwdev,
+					  struct rtw89_vif *rtwvif)
+{
+	unsigned int sel_link_id = IEEE80211_MLD_MAX_NUM_LINKS;
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	struct rtw89_vif_link *rtwvif_link;
+	const struct rtw89_chan *chan;
+	unsigned long usable_links;
+	unsigned int link_id;
+	u8 decided_bands;
+	u8 rssi;
+
+	rssi = ewma_rssi_read(&rtwdev->phystat.bcn_rssi);
+	if (unlikely(!rssi))
+		return;
+
+	if (RTW89_RSSI_RAW_TO_DBM(rssi) >= RTW89_MLSR_EXIT_2GHZ_THRESHOLD)
+		decided_bands = BIT(RTW89_BAND_5G) | BIT(RTW89_BAND_6G);
+	else if (RTW89_RSSI_RAW_TO_DBM(rssi) <= RTW89_MLSR_GOTO_2GHZ_THRESHOLD)
+		decided_bands = BIT(RTW89_BAND_2G);
+	else
+		return;
+
+	usable_links = ieee80211_vif_usable_links(vif);
+
+	rtwvif_link = rtw89_get_designated_link(rtwvif);
+	if (unlikely(!rtwvif_link))
+		goto select;
+
+	chan = rtw89_chan_get(rtwdev, rtwvif_link->chanctx_idx);
+	if (decided_bands & BIT(chan->band_type))
+		return;
+
+	usable_links &= ~BIT(rtwvif_link->link_id);
+
+select:
+	rcu_read_lock();
+
+	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct ieee80211_bss_conf *link_conf;
+		struct ieee80211_channel *channel;
+		enum rtw89_band band;
+
+		link_conf = rcu_dereference(vif->link_conf[link_id]);
+		if (unlikely(!link_conf))
+			continue;
+
+		channel = link_conf->chanreq.oper.chan;
+		if (unlikely(!channel))
+			continue;
+
+		band = rtw89_nl80211_to_hw_band(channel->band);
+		if (decided_bands & BIT(band)) {
+			sel_link_id = link_id;
+			break;
+		}
+	}
+
+	rcu_read_unlock();
+
+	if (sel_link_id == IEEE80211_MLD_MAX_NUM_LINKS)
+		return;
+
+	rtw89_core_mlsr_switch(rtwdev, rtwvif, sel_link_id);
+}
+
+static void rtw89_core_mlo_track(struct rtw89_dev *rtwdev)
+{
+	struct ieee80211_vif *vif;
+	struct rtw89_vif *rtwvif;
+
+	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
+		vif = rtwvif_to_vif(rtwvif);
+		if (!vif->cfg.assoc || !ieee80211_vif_is_mld(vif))
+			continue;
+
+		switch (rtwvif->mlo_mode) {
+		case RTW89_MLO_MODE_MLSR:
+			rtw89_core_mlsr_link_decision(rtwdev, rtwvif);
+			break;
+		default:
+			break;
+		}
+	}
+}
+
 static void rtw89_track_work(struct wiphy *wiphy, struct wiphy_work *work)
 {
 	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
@@ -3679,6 +3767,7 @@ static void rtw89_track_work(struct wiphy *wiphy, struct wiphy_work *work)
 	rtw89_sar_track(rtwdev);
 	rtw89_chanctx_track(rtwdev);
 	rtw89_core_rfkill_poll(rtwdev, false);
+	rtw89_core_mlo_track(rtwdev);
 
 	if (rtwdev->lps_enabled && !rtwdev->btc.lps)
 		rtw89_enter_lps_track(rtwdev);
@@ -5125,6 +5214,76 @@ static void rtw89_core_setup_rfe_parms(struct rtw89_dev *rtwdev)
 	rtw89_load_txpwr_table(rtwdev, rtwdev->rfe_parms->byr_tbl);
 }
 
+int rtw89_core_mlsr_switch(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+			   unsigned int link_id)
+{
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	u16 usable_links = ieee80211_vif_usable_links(vif);
+	u16 active_links = vif->active_links;
+	struct rtw89_vif_link *target, *cur;
+	int ret;
+
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
+	if (unlikely(!ieee80211_vif_is_mld(vif)))
+		return -EOPNOTSUPP;
+
+	if (unlikely(!(usable_links & BIT(link_id)))) {
+		rtw89_warn(rtwdev, "%s: link id %u is not usable\n", __func__,
+			   link_id);
+		return -ENOLINK;
+	}
+
+	if (active_links == BIT(link_id))
+		return 0;
+
+	rtw89_debug(rtwdev, RTW89_DBG_STATE, "%s: switch to link id %u MLSR\n",
+		    __func__, link_id);
+
+	rtw89_leave_lps(rtwdev);
+
+	ieee80211_stop_queues(rtwdev->hw);
+	flush_work(&rtwdev->txq_work);
+
+	cur = rtw89_get_designated_link(rtwvif);
+
+	ret = ieee80211_set_active_links(vif, active_links | BIT(link_id));
+	if (ret) {
+		rtw89_err(rtwdev, "%s: failed to activate link id %u\n",
+			  __func__, link_id);
+		goto wake_queue;
+	}
+
+	target = rtwvif->links[link_id];
+	if (unlikely(!target)) {
+		rtw89_err(rtwdev, "%s: failed to confirm link id %u\n",
+			  __func__, link_id);
+
+		ieee80211_set_active_links(vif, active_links);
+		ret = -EFAULT;
+		goto wake_queue;
+	}
+
+	if (likely(cur))
+		rtw89_fw_h2c_mlo_link_cfg(rtwdev, cur, false);
+
+	rtw89_fw_h2c_mlo_link_cfg(rtwdev, target, true);
+
+	ret = ieee80211_set_active_links(vif, BIT(link_id));
+	if (ret)
+		rtw89_err(rtwdev, "%s: failed to inactivate links 0x%x\n",
+			  __func__, active_links);
+
+	rtw89_chip_rfk_channel(rtwdev, target);
+
+	rtwvif->mlo_mode = RTW89_MLO_MODE_MLSR;
+
+wake_queue:
+	ieee80211_wake_queues(rtwdev->hw);
+
+	return ret;
+}
+
 static int rtw89_chip_efuse_info_setup(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 86bbe8cf8cc0..a432dd846a1f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5738,6 +5738,12 @@ struct rtw89_mcc_info {
 	struct rtw89_mcc_config config;
 };
 
+enum rtw89_mlo_mode {
+	RTW89_MLO_MODE_MLSR = 0,
+
+	NUM_OF_RTW89_MLO_MODE,
+};
+
 struct rtw89_mlo_info {
 	struct rtw89_wait_info wait;
 };
@@ -5894,6 +5900,8 @@ struct rtw89_vif {
 	struct rtw89_roc roc;
 	bool offchan;
 
+	enum rtw89_mlo_mode mlo_mode;
+
 	struct list_head dlink_pool;
 	u8 links_inst_valid_num;
 	DECLARE_BITMAP(links_inst_map, __RTW89_MLD_MAX_LINK_NUM);
@@ -7312,5 +7320,7 @@ void rtw89_core_update_p2p_ps(struct rtw89_dev *rtwdev,
 			      struct rtw89_vif_link *rtwvif_link,
 			      struct ieee80211_bss_conf *bss_conf);
 void rtw89_core_ntfy_btc_event(struct rtw89_dev *rtwdev, enum rtw89_btc_hmsg event);
+int rtw89_core_mlsr_switch(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+			   unsigned int link_id);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index aa748fe3f39e..deb4fb21d0e0 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -4043,6 +4043,7 @@ int rtw89_fw_h2c_join_info(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwv
 	bool format_v1 = false;
 	struct sk_buff *skb;
 	u8 main_mac_id;
+	bool init_ps;
 	int ret;
 
 	if (rtwdev->chip->chip_gen == RTW89_CHIP_BE) {
@@ -4084,6 +4085,7 @@ int rtw89_fw_h2c_join_info(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwv
 	h2c_v1 = (struct rtw89_h2c_join_v1 *)skb->data;
 
 	sta_type = rtw89_fw_get_sta_type(rtwdev, rtwvif_link, rtwsta_link);
+	init_ps = rtwvif_link != rtw89_get_designated_link(rtwvif_link->rtwvif);
 
 	if (rtwsta_link)
 		main_mac_id = rtw89_sta_get_main_macid(rtwsta_link->rtwsta);
@@ -4097,7 +4099,7 @@ int rtw89_fw_h2c_join_info(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwv
 				      RTW89_H2C_JOININFO_W1_MLO_MODE) |
 		     le32_encode_bits(0, RTW89_H2C_JOININFO_W1_EMLSR_CAB) |
 		     le32_encode_bits(0, RTW89_H2C_JOININFO_W1_NSTR_EN) |
-		     le32_encode_bits(0, RTW89_H2C_JOININFO_W1_INIT_PWR_STATE) |
+		     le32_encode_bits(init_ps, RTW89_H2C_JOININFO_W1_INIT_PWR_STATE) |
 		     le32_encode_bits(IEEE80211_EML_CAP_EMLSR_PADDING_DELAY_256US,
 				      RTW89_H2C_JOININFO_W1_EMLSR_PADDING) |
 		     le32_encode_bits(IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_256US,
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 182a952127c4..22d13a0d5b8a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -481,6 +481,8 @@ static int __rtw89_ops_sta_add(struct rtw89_dev *rtwdev,
 	int i;
 
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
+		rtwvif->mlo_mode = RTW89_MLO_MODE_MLSR;
+
 		/* for station mode, assign the mac_id from itself */
 		macid = rtw89_vif_get_main_macid(rtwvif);
 	} else {
-- 
2.25.1


