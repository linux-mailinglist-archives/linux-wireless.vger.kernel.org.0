Return-Path: <linux-wireless+bounces-32820-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFVmNS7Rr2kfcgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32820-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 09:07:10 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A13A246F26
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 09:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A76513178C91
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 08:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7634E3ECBFE;
	Tue, 10 Mar 2026 08:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="iaSGLBsV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570973ECBF1
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 08:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773129783; cv=none; b=FlM56iA8m+csEaaokkO5wW/zNPCgVKjurUMDptx3O3XenvIygiM4z4yxSrae/xQMwAbjwTXqwVuzw6DxQjhmfx+Cp5bai8bnT0fEtQDVmCSZ6P41632i2GJ5uEixqDm/oHz4QbrZfWwsOKI6D0hWajtypmYx9+VIuuHedyA4oSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773129783; c=relaxed/simple;
	bh=ZCqS/J+8O04dgygIDurggzfGo2o5vGR30/52JxB8ysg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mL4m6xwdJX+6fUkwSbqMCWbUZ9tOGGnJ9TmlUAiuUuwn64XadU9kEmRDpl6PLNkRegqvb0McfQZx9J+XBHLKm8DV5ZVQtGt9JnBsKJ09i+h2ZJvedAu+8IOauhad8CD5oxApbMd8nxZUNuaY5Cim3s5x+hFQ3CAXoidIZ7nMmyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=iaSGLBsV; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62A82xzM62211400, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773129779; bh=NNBXyvZZn+L2ye8BxWT6JmGu0uLuq9FEe/kPMNdZXVg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=iaSGLBsVn/8j6wJXO4gG11IuwkWJ8Qsagcg0x30C6mK+rNOK/B9gINWSSwKQe1jj5
	 4mXdre5lEeMX2Gie88XaowIcRZqDBxkC8zUfRemPYWT1qrkyl086qkCKDOzKRImhEl
	 SLQqSAAuyBygiVtqhkJdwjsgl38JRTXeqz0n+y98LQ4kQcsTc0Z8WU0rzwRkCRoCdG
	 qtRTGEqHbsZ6eM+rJe2bzRyfiy3IK1TewkEXEYf5f8j4vrk/sLgSzJlac1CpHdCJF3
	 QdjIgL9S4yAH8OsXDZqbvZgYqKUIoOnJgBQKn8DvQq1+mSCvnR/rrddRK7PMFQpRYP
	 r/SqF3nB0qJoA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62A82xzM62211400
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 16:02:59 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 10 Mar 2026 16:02:59 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 10 Mar 2026 16:02:59 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 10 Mar 2026 16:02:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 11/13] wifi: rtw89: Drop malformed AMPDU frames with abnormal PN
Date: Tue, 10 Mar 2026 16:01:44 +0800
Message-ID: <20260310080146.31113-12-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260310080146.31113-1-pkshih@realtek.com>
References: <20260310080146.31113-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 5A13A246F26
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32820-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,realtek.com:dkim,realtek.com:email,realtek.com:mid];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: Po-Hao Huang <phhuang@realtek.com>

Fix connection issue caused by AMPDU frames with abnormal PN patterns
(out-of-order packets with correct MPDU sequence numbers but paired
with abnormal PN values, which is next PN of previous in-order packet).
This is causing packet drops, low throughput and disconnections. It is
observed in fields with some specific AP firmwares. Do this workaround for
better interoperability since some APs could never receive a proper FW
update.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 115 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h     |  11 ++
 drivers/net/wireless/realtek/rtw89/mac80211.c |   3 +
 drivers/net/wireless/realtek/rtw89/util.h     |  17 +++
 drivers/net/wireless/realtek/rtw89/wow.c      |   2 +
 drivers/net/wireless/realtek/rtw89/wow.h      |   7 --
 6 files changed, 148 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 18dbf3664f0a..9d3f651798ff 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3272,6 +3272,114 @@ static void rtw89_core_correct_mcc_chan(struct rtw89_dev *rtwdev,
 	rcu_read_unlock();
 }
 
+static void __rtw89_core_tid_rx_stats_reset(struct rtw89_tid_stats *tid_stats)
+{
+	tid_stats->last_pn = -1LL;
+	tid_stats->last_sn = IEEE80211_SN_MASK;
+}
+
+void rtw89_core_tid_rx_stats_ctrl(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
+				  struct ieee80211_ampdu_params *params, bool enable)
+{
+	struct rtw89_tid_stats *tid_stats;
+	u16 tid = params->tid;
+
+	tid_stats = &rtwsta->tid_rx_stats[tid];
+
+	if (enable) {
+		__rtw89_core_tid_rx_stats_reset(tid_stats);
+		tid_stats->started = true;
+	} else {
+		tid_stats->started = false;
+	}
+}
+
+void rtw89_core_tid_rx_stats_reset(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_tid_stats *tid_stats;
+	struct ieee80211_sta *sta;
+	struct rtw89_sta *rtwsta;
+	u16 tid;
+
+	for_each_station(sta, rtwdev->hw) {
+		rtwsta = sta_to_rtwsta(sta);
+
+		for (tid = 0; tid < IEEE80211_NUM_TIDS; tid++) {
+			tid_stats = &rtwsta->tid_rx_stats[tid];
+
+			if (!tid_stats->started)
+				continue;
+
+			__rtw89_core_tid_rx_stats_reset(tid_stats);
+		}
+	}
+}
+
+static bool rtw89_core_skb_pn_valid(struct rtw89_dev *rtwdev,
+				    struct rtw89_rx_desc_info *desc_info,
+				    struct sk_buff *skb)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_sta_link *rtwsta_link;
+	struct rtw89_tid_stats *tid_stats;
+	struct rtw89_sta *rtwsta;
+	u8 tid, *ccmp_hdr_ptr;
+	s64 pn, last_pn;
+	u16 mpdu_sn;
+	int hdrlen;
+
+	if (chip->chip_gen != RTW89_CHIP_AX)
+		return true;
+
+	if (!ieee80211_is_data_qos(hdr->frame_control))
+		return true;
+
+	if (!desc_info->hw_dec || !desc_info->addr1_match)
+		return true;
+
+	guard(rcu)();
+
+	rtwsta_link = rtw89_assoc_link_rcu_dereference(rtwdev, desc_info->mac_id);
+	if (!rtwsta_link)
+		return true;
+
+	rtwsta = rtwsta_link->rtwsta;
+	tid = ieee80211_get_tid(hdr);
+	tid_stats = &rtwsta->tid_rx_stats[tid];
+
+	if (!tid_stats->started)
+		return true;
+
+	switch (desc_info->sec_type) {
+	case RTW89_SEC_KEY_TYPE_CCMP128:
+	case RTW89_SEC_KEY_TYPE_CCMP256:
+	case RTW89_SEC_KEY_TYPE_GCMP128:
+	case RTW89_SEC_KEY_TYPE_GCMP256:
+		mpdu_sn = ieee80211_get_sn(hdr);
+		hdrlen = ieee80211_hdrlen(hdr->frame_control);
+		ccmp_hdr_ptr = skb->data + hdrlen;
+		ccmp_hdr2pn(&pn, ccmp_hdr_ptr);
+		last_pn = tid_stats->last_pn;
+
+		if (pn > last_pn) {
+			if (ieee80211_sn_less(mpdu_sn, tid_stats->last_sn)) {
+				dev_kfree_skb_any(skb);
+
+				return false;
+			}
+
+			tid_stats->last_sn = mpdu_sn;
+			tid_stats->last_pn = pn;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return true;
+}
+
 static void rtw89_core_rx_to_mac80211(struct rtw89_dev *rtwdev,
 				      struct rtw89_rx_phy_ppdu *phy_ppdu,
 				      struct rtw89_rx_desc_info *desc_info,
@@ -3421,6 +3529,7 @@ void rtw89_core_query_rxdesc(struct rtw89_dev *rtwdev,
 	desc_info->sec_cam_id = le32_get_bits(rxd_l->dword5, AX_RXD_SEC_CAM_IDX_MASK);
 	desc_info->mac_id = le32_get_bits(rxd_l->dword5, AX_RXD_MAC_ID_MASK);
 	desc_info->rx_pl_id = le32_get_bits(rxd_l->dword5, AX_RXD_RX_PL_ID_MASK);
+	desc_info->sec_type = le32_get_bits(rxd_l->dword7, AX_RXD_SEC_TYPE_MASK);
 }
 EXPORT_SYMBOL(rtw89_core_query_rxdesc);
 
@@ -3450,6 +3559,7 @@ void rtw89_core_query_rxdesc_v2(struct rtw89_dev *rtwdev,
 	desc_info->mac_id = le32_get_bits(rxd_s->dword2, BE_RXD_MAC_ID_MASK);
 	desc_info->addr_cam_valid = le32_get_bits(rxd_s->dword2, BE_RXD_ADDR_CAM_VLD);
 
+	desc_info->sec_type = le32_get_bits(rxd_s->dword3, BE_RXD_SEC_TYPE_MASK);
 	desc_info->icv_err = le32_get_bits(rxd_s->dword3, BE_RXD_ICV_ERR);
 	desc_info->crc32_err = le32_get_bits(rxd_s->dword3, BE_RXD_CRC32_ERR);
 	desc_info->hw_dec = le32_get_bits(rxd_s->dword3, BE_RXD_HW_DEC);
@@ -3523,6 +3633,7 @@ void rtw89_core_query_rxdesc_v3(struct rtw89_dev *rtwdev,
 	desc_info->mac_id = le32_get_bits(rxd_s->dword2, BE_RXD_MAC_ID_V1);
 	desc_info->addr_cam_valid = le32_get_bits(rxd_s->dword2, BE_RXD_ADDR_CAM_VLD);
 
+	desc_info->sec_type = le32_get_bits(rxd_s->dword3, BE_RXD_SEC_TYPE_MASK);
 	desc_info->icv_err = le32_get_bits(rxd_s->dword3, BE_RXD_ICV_ERR);
 	desc_info->crc32_err = le32_get_bits(rxd_s->dword3, BE_RXD_CRC32_ERR);
 	desc_info->hw_dec = le32_get_bits(rxd_s->dword3, BE_RXD_HW_DEC);
@@ -3802,6 +3913,10 @@ void rtw89_core_rx(struct rtw89_dev *rtwdev,
 	memset(rx_status, 0, sizeof(*rx_status));
 	rtw89_core_update_rx_status(rtwdev, skb, desc_info, rx_status);
 	rtw89_core_rx_pkt_hdl(rtwdev, skb, desc_info);
+
+	if (!rtw89_core_skb_pn_valid(rtwdev, desc_info, skb))
+		return;
+
 	if (desc_info->long_rxdesc &&
 	    BIT(desc_info->frame_type) & PPDU_FILTER_BITMAP)
 		skb_queue_tail(&ppdu_sts->rx_queue[band], skb);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index ce04ecaa3a5e..94e4faf70e12 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1126,6 +1126,7 @@ struct rtw89_rx_desc_info {
 	bool addr_cam_valid;
 	u8 addr_cam_id;
 	u8 sec_cam_id;
+	u8 sec_type;
 	u8 mac_id;
 	u16 offset;
 	u16 rxd_len;
@@ -6153,6 +6154,12 @@ struct rtw89_beacon_track_info {
 	u32 tbtt_diff_th;
 };
 
+struct rtw89_tid_stats {
+	s64 last_pn;
+	u16 last_sn;
+	bool started;
+};
+
 struct rtw89_dev {
 	struct ieee80211_hw *hw;
 	struct device *dev;
@@ -6359,6 +6366,7 @@ struct rtw89_sta {
 	struct sk_buff_head roc_queue;
 
 	struct rtw89_ampdu_params ampdu_params[IEEE80211_NUM_TIDS];
+	struct rtw89_tid_stats tid_rx_stats[IEEE80211_NUM_TIDS];
 	DECLARE_BITMAP(ampdu_map, IEEE80211_NUM_TIDS);
 
 	DECLARE_BITMAP(pairwise_sec_cam_map, RTW89_MAX_SEC_CAM_NUM);
@@ -7769,6 +7777,9 @@ int rtw89_core_sta_link_remove(struct rtw89_dev *rtwdev,
 void rtw89_core_set_tid_config(struct rtw89_dev *rtwdev,
 			       struct ieee80211_sta *sta,
 			       struct cfg80211_tid_config *tid_config);
+void rtw89_core_tid_rx_stats_ctrl(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
+				  struct ieee80211_ampdu_params *params, bool enable);
+void rtw89_core_tid_rx_stats_reset(struct rtw89_dev *rtwdev);
 void rtw89_core_rfkill_poll(struct rtw89_dev *rtwdev, bool force);
 void rtw89_check_quirks(struct rtw89_dev *rtwdev, const struct dmi_system_id *quirks);
 int rtw89_core_init(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index cd8e2c8de888..501c3af1da01 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -964,6 +964,7 @@ static int rtw89_ops_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 			rtw89_err(rtwdev, "failed to add key to sec cam\n");
 			return ret;
 		}
+		rtw89_core_tid_rx_stats_reset(rtwdev);
 		break;
 	case DISABLE_KEY:
 		flush_work(&rtwdev->txq_work);
@@ -1018,9 +1019,11 @@ static int rtw89_ops_ampdu_action(struct ieee80211_hw *hw,
 		rtw89_phy_ra_recalc_agg_limit(rtwdev);
 		break;
 	case IEEE80211_AMPDU_RX_START:
+		rtw89_core_tid_rx_stats_ctrl(rtwdev, rtwsta, params, true);
 		rtw89_chip_h2c_ba_cam(rtwdev, rtwsta, true, params);
 		break;
 	case IEEE80211_AMPDU_RX_STOP:
+		rtw89_core_tid_rx_stats_ctrl(rtwdev, rtwsta, params, false);
 		rtw89_chip_h2c_ba_cam(rtwdev, rtwsta, false, params);
 		break;
 	default:
diff --git a/drivers/net/wireless/realtek/rtw89/util.h b/drivers/net/wireless/realtek/rtw89/util.h
index bd08495301e4..c16e7a7f8bc9 100644
--- a/drivers/net/wireless/realtek/rtw89/util.h
+++ b/drivers/net/wireless/realtek/rtw89/util.h
@@ -6,6 +6,13 @@
 
 #include "core.h"
 
+#define RTW89_KEY_PN_0 GENMASK_ULL(7, 0)
+#define RTW89_KEY_PN_1 GENMASK_ULL(15, 8)
+#define RTW89_KEY_PN_2 GENMASK_ULL(23, 16)
+#define RTW89_KEY_PN_3 GENMASK_ULL(31, 24)
+#define RTW89_KEY_PN_4 GENMASK_ULL(39, 32)
+#define RTW89_KEY_PN_5 GENMASK_ULL(47, 40)
+
 #define rtw89_iterate_vifs_bh(rtwdev, iterator, data)                          \
 	ieee80211_iterate_active_interfaces_atomic((rtwdev)->hw,               \
 			IEEE80211_IFACE_ITER_NORMAL, iterator, data)
@@ -73,6 +80,16 @@ static inline void ether_addr_copy_mask(u8 *dst, const u8 *src, u8 mask)
 	}
 }
 
+static inline void ccmp_hdr2pn(s64 *pn, const u8 *hdr)
+{
+	*pn = u64_encode_bits(hdr[0], RTW89_KEY_PN_0) |
+	      u64_encode_bits(hdr[1], RTW89_KEY_PN_1) |
+	      u64_encode_bits(hdr[4], RTW89_KEY_PN_2) |
+	      u64_encode_bits(hdr[5], RTW89_KEY_PN_3) |
+	      u64_encode_bits(hdr[6], RTW89_KEY_PN_4) |
+	      u64_encode_bits(hdr[7], RTW89_KEY_PN_5);
+}
+
 s32 rtw89_linear_to_db_quarter(u64 val);
 s32 rtw89_linear_to_db(u64 val);
 u64 rtw89_db_quarter_to_linear(s32 db);
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 368e08826f1e..8dadd8df4fc6 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -1741,6 +1741,8 @@ static int rtw89_wow_disable(struct rtw89_dev *rtwdev)
 
 	rtw89_wow_leave_ps(rtwdev, false);
 
+	rtw89_core_tid_rx_stats_reset(rtwdev);
+
 	ret = rtw89_wow_fw_stop(rtwdev);
 	if (ret) {
 		rtw89_err(rtwdev, "wow: failed to swap to normal fw\n");
diff --git a/drivers/net/wireless/realtek/rtw89/wow.h b/drivers/net/wireless/realtek/rtw89/wow.h
index 71e07f482174..d7e67632efeb 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.h
+++ b/drivers/net/wireless/realtek/rtw89/wow.h
@@ -8,13 +8,6 @@
 #define RTW89_KEY_TKIP_PN_IV16 GENMASK_ULL(15, 0)
 #define RTW89_KEY_TKIP_PN_IV32 GENMASK_ULL(47, 16)
 
-#define RTW89_KEY_PN_0 GENMASK_ULL(7, 0)
-#define RTW89_KEY_PN_1 GENMASK_ULL(15, 8)
-#define RTW89_KEY_PN_2 GENMASK_ULL(23, 16)
-#define RTW89_KEY_PN_3 GENMASK_ULL(31, 24)
-#define RTW89_KEY_PN_4 GENMASK_ULL(39, 32)
-#define RTW89_KEY_PN_5 GENMASK_ULL(47, 40)
-
 #define RTW89_IGTK_IPN_0 GENMASK_ULL(7, 0)
 #define RTW89_IGTK_IPN_1 GENMASK_ULL(15, 8)
 #define RTW89_IGTK_IPN_2 GENMASK_ULL(23, 16)
-- 
2.25.1


