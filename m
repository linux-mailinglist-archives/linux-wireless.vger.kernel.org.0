Return-Path: <linux-wireless+bounces-15437-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7CD9D0848
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 05:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E57C1F215BF
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 04:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5211013B5B7;
	Mon, 18 Nov 2024 04:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="mRTNKvp6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9586E5A79B
	for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 04:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731902637; cv=none; b=LDPKr0wlNXD3vbxjqdkBGoxyZoLcbAwfaObsTgVz/XFk1DEWNrJLGpST4a5PXG7arM8t/oQdOVfFBqk9HZhCBmPIMJhumMs1myKs72uaicsQXaqh8sSx3VoTUotjKM1VV3lJER9bhPSXeSBtDG50YSeYia3VEXyChHR68LqcArM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731902637; c=relaxed/simple;
	bh=12RIwnWCWQe+PQBU7wj4R+HqxK7IhR0+zKCfpFU80qg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SfgyWRWyDkEuQC2msz7QZcickr/1f+8LgOduVBGTlPfzL7hEJCZrvIIbZ9SyF0BjVG52WTz+o8etVStl8G8sQ14XG0waxqEDTJ/Aw4pNIqRXKqdrIcOOHA7DU0Z/Tz1HmW2TAAv0DnxO2hMgOtr0iqbyutVOsknSpoOjEyRQpJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=mRTNKvp6; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AI43oC42099619, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731902630; bh=12RIwnWCWQe+PQBU7wj4R+HqxK7IhR0+zKCfpFU80qg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=mRTNKvp6s7hLZB+UI47Kyknhff46nDEPd+rUW42t9kMdu3Dq8iStlIzvFXv61OiDC
	 jj2owv/GqYu12XN9Mo2xhSp6Y4lftLLWHTB17jj/7RzQZBOqc5WWPiwbSBO1z/GTyJ
	 XRPix6rmrZdfpRfx9YIhx0TVJC1X1C6OP75g7Zw+lVWmdFPXcYKVtE4CrPnHJGuni8
	 j7uICUJBLtr6SneH//2BKZaojIR07zU21TmHu49Ria7aQdelVrsSQqG5VKt0Qp1Sy7
	 1QBMQJ53FqjPLNb2xp8q53ngtjjty/wxWeQRI0YRstyDiNhpwmJCV/eNtD6WFemQyV
	 KoYMImcfUVG8Q==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AI43oC42099619
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 12:03:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 12:03:51 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 18 Nov
 2024 12:03:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH v2 1/6] wifi: rtw89: 8922a: configure AP_LINK_PS if FW supports
Date: Mon, 18 Nov 2024 12:02:50 +0800
Message-ID: <20241118040255.40854-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241118040255.40854-1-pkshih@realtek.com>
References: <20241118040255.40854-1-pkshih@realtek.com>
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

After FW v0.35.46.0, for AP mode, RTL8922A FW supports a new FW feature,
called NOTIFY_AP_INFO, to notify driver information related to AP mode.
And, one function of it is to monitor PS states of remote stations. Once
one of them changes, FW will send a C2H event to tell driver. With this
FW feature, we can declare AP_LINK_PS.

For now, driver still needs to determine if a frame is ps-poll or U-APSD
trigger. So, add the corresponding RX handling in driver, which activates
only when at least one AP is running.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 42 ++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h     | 37 +++++++++++
 drivers/net/wireless/realtek/rtw89/fw.c       | 66 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h       | 19 ++++++
 drivers/net/wireless/realtek/rtw89/mac.c      | 50 ++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h      |  7 ++
 drivers/net/wireless/realtek/rtw89/mac80211.c | 13 +++-
 drivers/net/wireless/realtek/rtw89/ser.c      |  1 +
 8 files changed, 234 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 34034f44c050..c99111df90a7 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2749,6 +2749,41 @@ static void rtw89_core_flush_ppdu_rx_queue(struct rtw89_dev *rtwdev,
 	}
 }
 
+static
+void rtw89_core_rx_pkt_hdl(struct rtw89_dev *rtwdev, const struct sk_buff *skb,
+			   const struct rtw89_rx_desc_info *desc)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct rtw89_sta_link *rtwsta_link;
+	struct ieee80211_sta *sta;
+	struct rtw89_sta *rtwsta;
+	u8 macid = desc->mac_id;
+
+	if (!refcount_read(&rtwdev->refcount_ap_info))
+		return;
+
+	rcu_read_lock();
+
+	rtwsta_link = rtw89_assoc_link_rcu_dereference(rtwdev, macid);
+	if (!rtwsta_link)
+		goto out;
+
+	rtwsta = rtwsta_link->rtwsta;
+	if (!test_bit(RTW89_REMOTE_STA_IN_PS, rtwsta->flags))
+		goto out;
+
+	sta = rtwsta_to_sta(rtwsta);
+	if (ieee80211_is_pspoll(hdr->frame_control))
+		ieee80211_sta_pspoll(sta);
+	else if (ieee80211_has_pm(hdr->frame_control) &&
+		 (ieee80211_is_data_qos(hdr->frame_control) ||
+		  ieee80211_is_qos_nullfunc(hdr->frame_control)))
+		ieee80211_sta_uapsd_trigger(sta, ieee80211_get_tid(hdr));
+
+out:
+	rcu_read_unlock();
+}
+
 void rtw89_core_rx(struct rtw89_dev *rtwdev,
 		   struct rtw89_rx_desc_info *desc_info,
 		   struct sk_buff *skb)
@@ -2771,6 +2806,7 @@ void rtw89_core_rx(struct rtw89_dev *rtwdev,
 	rx_status = IEEE80211_SKB_RXCB(skb);
 	memset(rx_status, 0, sizeof(*rx_status));
 	rtw89_core_update_rx_status(rtwdev, desc_info, rx_status);
+	rtw89_core_rx_pkt_hdl(rtwdev, skb, desc_info);
 	if (desc_info->long_rxdesc &&
 	    BIT(desc_info->frame_type) & PPDU_FILTER_BITMAP)
 		skb_queue_tail(&ppdu_sts->rx_queue[band], skb);
@@ -3748,6 +3784,8 @@ int rtw89_core_sta_link_disassoc(struct rtw89_dev *rtwdev,
 {
 	const struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
 
+	rtw89_assoc_link_clr(rtwsta_link);
+
 	if (vif->type == NL80211_IFTYPE_STATION)
 		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, rtwvif_link, false);
 
@@ -3883,6 +3921,7 @@ int rtw89_core_sta_link_assoc(struct rtw89_dev *rtwdev,
 		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, rtwvif_link, true);
 	}
 
+	rtw89_assoc_link_set(rtwsta_link);
 	return ret;
 }
 
@@ -5150,6 +5189,9 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 	if (RTW89_CHK_FW_FEATURE(BEACON_FILTER, &rtwdev->fw))
 		ieee80211_hw_set(hw, CONNECTION_MONITOR);
 
+	if (RTW89_CHK_FW_FEATURE(NOTIFY_AP_INFO, &rtwdev->fw))
+		ieee80211_hw_set(hw, AP_LINK_PS);
+
 	hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
 				     BIT(NL80211_IFTYPE_AP) |
 				     BIT(NL80211_IFTYPE_P2P_CLIENT) |
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index ecccb51184be..3e93b53fd67b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4452,6 +4452,7 @@ enum rtw89_fw_feature {
 	RTW89_FW_FEATURE_RFK_PRE_NOTIFY_V0,
 	RTW89_FW_FEATURE_RFK_RXDCK_V0,
 	RTW89_FW_FEATURE_NO_WOW_CPU_IO_RX,
+	RTW89_FW_FEATURE_NOTIFY_AP_INFO,
 };
 
 struct rtw89_fw_suit {
@@ -5596,6 +5597,9 @@ struct rtw89_dev {
 	struct rtw89_rfe_data *rfe_data;
 	enum rtw89_custid custid;
 
+	struct rtw89_sta_link __rcu *assoc_link_on_macid[RTW89_MAX_MAC_ID_NUM];
+	refcount_t refcount_ap_info;
+
 	/* ensures exclusive access from mac80211 callbacks */
 	struct mutex mutex;
 	struct list_head rtwvifs_list;
@@ -5730,10 +5734,18 @@ static inline bool rtw89_vif_assign_link_is_valid(struct rtw89_vif_link **rtwvif
 	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) \
 		if (rtw89_vif_assign_link_is_valid(&(rtwvif_link), rtwvif, link_id))
 
+enum rtw89_sta_flags {
+	RTW89_REMOTE_STA_IN_PS,
+
+	NUM_OF_RTW89_STA_FLAGS,
+};
+
 struct rtw89_sta {
 	struct rtw89_dev *rtwdev;
 	struct rtw89_vif *rtwvif;
 
+	DECLARE_BITMAP(flags, NUM_OF_RTW89_STA_FLAGS);
+
 	bool disassoc;
 
 	struct sk_buff_head roc_queue;
@@ -5811,6 +5823,31 @@ u8 rtw89_sta_link_inst_get_index(struct rtw89_sta_link *rtwsta_link)
 	return rtwsta_link - rtwsta->links_inst;
 }
 
+static inline void rtw89_assoc_link_set(struct rtw89_sta_link *rtwsta_link)
+{
+	struct rtw89_sta *rtwsta = rtwsta_link->rtwsta;
+	struct rtw89_dev *rtwdev = rtwsta->rtwdev;
+
+	rcu_assign_pointer(rtwdev->assoc_link_on_macid[rtwsta_link->mac_id],
+			   rtwsta_link);
+}
+
+static inline void rtw89_assoc_link_clr(struct rtw89_sta_link *rtwsta_link)
+{
+	struct rtw89_sta *rtwsta = rtwsta_link->rtwsta;
+	struct rtw89_dev *rtwdev = rtwsta->rtwdev;
+
+	rcu_assign_pointer(rtwdev->assoc_link_on_macid[rtwsta_link->mac_id],
+			   NULL);
+	synchronize_rcu();
+}
+
+static inline struct rtw89_sta_link *
+rtw89_assoc_link_rcu_dereference(struct rtw89_dev *rtwdev, u8 macid)
+{
+	return rcu_dereference(rtwdev->assoc_link_on_macid[macid]);
+}
+
 static inline int rtw89_hci_tx_write(struct rtw89_dev *rtwdev,
 				     struct rtw89_core_tx_request *tx_req)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 2191c037d72e..7bda9aab382c 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -728,6 +728,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 22, 0, WOW_REASON_V1),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 31, 0, RFK_PRE_NOTIFY_V0),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 42, 0, RFK_RXDCK_V0),
+	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 46, 0, NOTIFY_AP_INFO),
 };
 
 static void rtw89_fw_iterate_feature_cfg(struct rtw89_fw_info *fw,
@@ -8164,6 +8165,71 @@ int rtw89_fw_h2c_mrc_upd_duration(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+static int rtw89_fw_h2c_ap_info(struct rtw89_dev *rtwdev, bool en)
+{
+	struct rtw89_h2c_ap_info *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for ap info\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_ap_info *)skb->data;
+
+	h2c->w0 = le32_encode_bits(en, RTW89_H2C_AP_INFO_W0_PWR_INT_EN);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_AP,
+			      H2C_FUNC_AP_INFO, 0, 0,
+			      len);
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		dev_kfree_skb_any(skb);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+int rtw89_fw_h2c_ap_info_refcount(struct rtw89_dev *rtwdev, bool en)
+{
+	int ret;
+
+	if (en) {
+		if (refcount_inc_not_zero(&rtwdev->refcount_ap_info))
+			return 0;
+	} else {
+		if (!refcount_dec_and_test(&rtwdev->refcount_ap_info))
+			return 0;
+	}
+
+	ret = rtw89_fw_h2c_ap_info(rtwdev, en);
+	if (ret) {
+		if (!test_bit(RTW89_FLAG_SER_HANDLING, rtwdev->flags))
+			return ret;
+
+		/* During recovery, neither driver nor stack has full error
+		 * handling, so show a warning, but return 0 with refcount
+		 * increased normally. It can avoid underflow when calling
+		 * with @en == false later.
+		 */
+		rtw89_warn(rtwdev, "h2c ap_info failed during SER\n");
+	}
+
+	if (en)
+		refcount_set(&rtwdev->refcount_ap_info, 1);
+
+	return 0;
+}
+
 static bool __fw_txpwr_entry_zero_ext(const void *ext_ptr, u8 ext_len)
 {
 	static const u8 zeros[U8_MAX] = {};
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index efa63d444821..a8e9e3e0b19b 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3466,6 +3466,12 @@ struct rtw89_h2c_wow_aoac {
 	__le32 w0;
 } __packed;
 
+struct rtw89_h2c_ap_info {
+	__le32 w0;
+} __packed;
+
+#define RTW89_H2C_AP_INFO_W0_PWR_INT_EN BIT(0)
+
 #define RTW89_C2H_HEADER_LEN 8
 
 struct rtw89_c2h_hdr {
@@ -3725,6 +3731,14 @@ struct rtw89_c2h_wow_aoac_report {
 
 #define RTW89_C2H_WOW_AOAC_RPT_REKEY_IDX BIT(0)
 
+struct rtw89_c2h_pwr_int_notify {
+	struct rtw89_c2h_hdr hdr;
+	__le32 w2;
+} __packed;
+
+#define RTW89_C2H_PWR_INT_NOTIFY_W2_MACID GENMASK(15, 0)
+#define RTW89_C2H_PWR_INT_NOTIFY_W2_PWR_STATUS BIT(16)
+
 struct rtw89_h2c_tx_duty {
 	__le32 w0;
 	__le32 w1;
@@ -4168,6 +4182,10 @@ enum rtw89_mrc_h2c_func {
 #define RTW89_MRC_WAIT_COND_REQ_TSF \
 	RTW89_MRC_WAIT_COND(0 /* don't care */, H2C_FUNC_MRC_REQ_TSF)
 
+// CLASS 36 - SoftAP
+#define H2C_CL_AP			0x24
+#define H2C_FUNC_AP_INFO 0x0
+
 #define H2C_CAT_OUTSRC			0x2
 
 #define H2C_CL_OUTSRC_RA		0x1
@@ -4697,6 +4715,7 @@ int rtw89_fw_h2c_mrc_sync(struct rtw89_dev *rtwdev,
 			  const struct rtw89_fw_mrc_sync_arg *arg);
 int rtw89_fw_h2c_mrc_upd_duration(struct rtw89_dev *rtwdev,
 				  const struct rtw89_fw_mrc_upd_duration_arg *arg);
+int rtw89_fw_h2c_ap_info_refcount(struct rtw89_dev *rtwdev, bool en);
 
 static inline void rtw89_fw_h2c_init_ba_cam(struct rtw89_dev *rtwdev)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 7907b84d204b..03fc21440271 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5364,6 +5364,39 @@ rtw89_mac_c2h_mrc_status_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32
 	rtw89_complete_cond(wait, cond, &data);
 }
 
+static void
+rtw89_mac_c2h_pwr_int_notify(struct rtw89_dev *rtwdev, struct sk_buff *skb, u32 len)
+{
+	const struct rtw89_c2h_pwr_int_notify *c2h;
+	struct rtw89_sta_link *rtwsta_link;
+	struct ieee80211_sta *sta;
+	struct rtw89_sta *rtwsta;
+	u16 macid;
+	bool ps;
+
+	c2h = (const struct rtw89_c2h_pwr_int_notify *)skb->data;
+	macid = le32_get_bits(c2h->w2, RTW89_C2H_PWR_INT_NOTIFY_W2_MACID);
+	ps = le32_get_bits(c2h->w2, RTW89_C2H_PWR_INT_NOTIFY_W2_PWR_STATUS);
+
+	rcu_read_lock();
+
+	rtwsta_link = rtw89_assoc_link_rcu_dereference(rtwdev, macid);
+	if (unlikely(!rtwsta_link))
+		goto out;
+
+	rtwsta = rtwsta_link->rtwsta;
+	if (ps)
+		set_bit(RTW89_REMOTE_STA_IN_PS, rtwsta->flags);
+	else
+		clear_bit(RTW89_REMOTE_STA_IN_PS, rtwsta->flags);
+
+	sta = rtwsta_to_sta(rtwsta);
+	ieee80211_sta_ps_transition(sta, ps);
+
+out:
+	rcu_read_unlock();
+}
+
 static
 void (* const rtw89_mac_c2h_ofld_handler[])(struct rtw89_dev *rtwdev,
 					    struct sk_buff *c2h, u32 len) = {
@@ -5409,6 +5442,12 @@ void (* const rtw89_mac_c2h_wow_handler[])(struct rtw89_dev *rtwdev,
 	[RTW89_MAC_C2H_FUNC_AOAC_REPORT] = rtw89_mac_c2h_wow_aoac_rpt,
 };
 
+static
+void (* const rtw89_mac_c2h_ap_handler[])(struct rtw89_dev *rtwdev,
+					  struct sk_buff *c2h, u32 len) = {
+	[RTW89_MAC_C2H_FUNC_PWR_INT_NOTIFY] = rtw89_mac_c2h_pwr_int_notify,
+};
+
 static void rtw89_mac_c2h_scanofld_rsp_atomic(struct rtw89_dev *rtwdev,
 					      struct sk_buff *skb)
 {
@@ -5463,6 +5502,13 @@ bool rtw89_mac_c2h_chk_atomic(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
 		return true;
 	case RTW89_MAC_C2H_CLASS_WOW:
 		return true;
+	case RTW89_MAC_C2H_CLASS_AP:
+		switch (func) {
+		default:
+			return false;
+		case RTW89_MAC_C2H_FUNC_PWR_INT_NOTIFY:
+			return true;
+		}
 	}
 }
 
@@ -5493,6 +5539,10 @@ void rtw89_mac_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 		if (func < NUM_OF_RTW89_MAC_C2H_FUNC_WOW)
 			handler = rtw89_mac_c2h_wow_handler[func];
 		break;
+	case RTW89_MAC_C2H_CLASS_AP:
+		if (func < NUM_OF_RTW89_MAC_C2H_FUNC_AP)
+			handler = rtw89_mac_c2h_ap_handler[func];
+		break;
 	case RTW89_MAC_C2H_CLASS_FWDBG:
 		return;
 	default:
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 18579c020548..81507274a97e 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -426,6 +426,12 @@ enum rtw89_mac_c2h_wow_func {
 	NUM_OF_RTW89_MAC_C2H_FUNC_WOW,
 };
 
+enum rtw89_mac_c2h_ap_func {
+	RTW89_MAC_C2H_FUNC_PWR_INT_NOTIFY = 0,
+
+	NUM_OF_RTW89_MAC_C2H_FUNC_AP,
+};
+
 enum rtw89_mac_c2h_class {
 	RTW89_MAC_C2H_CLASS_INFO = 0x0,
 	RTW89_MAC_C2H_CLASS_OFLD = 0x1,
@@ -434,6 +440,7 @@ enum rtw89_mac_c2h_class {
 	RTW89_MAC_C2H_CLASS_MCC = 0x4,
 	RTW89_MAC_C2H_CLASS_FWDBG = 0x5,
 	RTW89_MAC_C2H_CLASS_MRC = 0xe,
+	RTW89_MAC_C2H_CLASS_AP = 0x18,
 	RTW89_MAC_C2H_CLASS_MAX,
 };
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 619d2d3771d5..8dc475f6fdf7 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -775,6 +775,7 @@ static int rtw89_ops_start_ap(struct ieee80211_hw *hw,
 	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
 	struct rtw89_vif_link *rtwvif_link;
 	const struct rtw89_chan *chan;
+	int ret = 0;
 
 	mutex_lock(&rtwdev->mutex);
 
@@ -783,6 +784,7 @@ static int rtw89_ops_start_ap(struct ieee80211_hw *hw,
 		rtw89_err(rtwdev,
 			  "%s: rtwvif link (link_id %u) is not active\n",
 			  __func__, link_conf->link_id);
+		ret = -ENOLINK;
 		goto out;
 	}
 
@@ -804,12 +806,18 @@ static int rtw89_ops_start_ap(struct ieee80211_hw *hw,
 	rtw89_fw_h2c_cam(rtwdev, rtwvif_link, NULL, NULL);
 	rtw89_chip_rfk_channel(rtwdev, rtwvif_link);
 
+	if (RTW89_CHK_FW_FEATURE(NOTIFY_AP_INFO, &rtwdev->fw)) {
+		ret = rtw89_fw_h2c_ap_info_refcount(rtwdev, true);
+		if (ret)
+			goto out;
+	}
+
 	rtw89_queue_chanctx_work(rtwdev);
 
 out:
 	mutex_unlock(&rtwdev->mutex);
 
-	return 0;
+	return ret;
 }
 
 static
@@ -830,6 +838,9 @@ void rtw89_ops_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		goto out;
 	}
 
+	if (RTW89_CHK_FW_FEATURE(NOTIFY_AP_INFO, &rtwdev->fw))
+		rtw89_fw_h2c_ap_info_refcount(rtwdev, false);
+
 	rtw89_mac_stop_ap(rtwdev, rtwvif_link);
 	rtw89_chip_h2c_assoc_cmac_tbl(rtwdev, rtwvif_link, NULL);
 	rtw89_fw_h2c_join_info(rtwdev, rtwvif_link, NULL, true);
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index 7b203bb7f151..26a944d3b672 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -365,6 +365,7 @@ static void ser_reset_mac_binding(struct rtw89_dev *rtwdev)
 		ser_reset_vif(rtwdev, rtwvif);
 
 	rtwdev->total_sta_assoc = 0;
+	refcount_set(&rtwdev->refcount_ap_info, 0);
 }
 
 /* hal function */
-- 
2.25.1


