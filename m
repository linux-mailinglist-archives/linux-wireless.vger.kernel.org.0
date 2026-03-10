Return-Path: <linux-wireless+bounces-32813-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGm5BK/Qr2kfcgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32813-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 09:05:03 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 974E2246EA6
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 09:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3758C308010D
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 08:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BBF3ECBCD;
	Tue, 10 Mar 2026 08:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="sHhzkg4X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B8928640C
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 08:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773129739; cv=none; b=s1GIDFpXrdL/3tft+ryKLi+LYhHRjhE+VAGyCYY7LYu+faEUHioY53OzgnUYdk5E6K88Zs0vkM3HXHK8lr/im6V1EkCqdwrdV+9bwTgzXrr4vBiUKwbtBq/iXw/JELH3S2epTmDm5X4b3HarBKluW02yoh90t0M1Wfz3OLEopuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773129739; c=relaxed/simple;
	bh=ZJMMZGinc1QTXk2bJMx9OZFPNIF0+0y7EA4dpjl5/z4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HwvlFpcXXEXQvaaeeyZN5QVem9NZGn2+yqizPQXx3+FcJ+vO83Si417fK/V8dMed37hQc96kzqcTjirLnGTx4jtCbVL5IoyoMISsJsiKY8FpE7iEVUrfo+i/D4/ZO8PMDBaPeUUBKvX/ji9fL4A4TuKCFygQHh3wVbzIqETdJCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=sHhzkg4X; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62A82GDX02208782, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773129736; bh=gi+8ihZ697LvjRs1ik+Q6iorROQAdKl/X/zIwz1puoU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=sHhzkg4Xh7UWuNioe3npzHEtt1lJE39NZ2hBY7WuOrR35WMcGwwe/Gw7nkE6P06pZ
	 IvEgoTp/LjpPeCmYGy2xNSj+PARrmO1yqpKrxPEGrRmLo+0fowO+053M37pJpU6W7w
	 Ux5CaZKgb1bsU0S5ahU5axfXLoiTUhhWrXfFrolf2JRD5RLkWLHz9kUWZko1VYFEIX
	 RUehtVO0PkxL3/vpYV9ImteURzXNTOUWUj/9LeED6uivhXwWen7QTATopp1pCTTKci
	 1vsv71yWsLu0AXp1AaLGu+NilR9j8nwQ/3fyjHoRiwkgxzTyzTUiBNySfpXV0kdMZr
	 icWU8P219irrA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62A82GDX02208782
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 16:02:16 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 10 Mar 2026 16:02:15 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 10 Mar 2026 16:02:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 04/13] wifi: rtw89: phy: limit AMPDU number for RA try rate
Date: Tue, 10 Mar 2026 16:01:37 +0800
Message-ID: <20260310080146.31113-5-pkshih@realtek.com>
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
X-Rspamd-Queue-Id: 974E2246EA6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32813-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[realtek.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,realtek.com:dkim,realtek.com:email,realtek.com:mid]
X-Rspamd-Action: no action

When RA (Rate Adaptive) does try higher rate, a TRY bit is flagged, and
hardware will reference registers configured by this patch as maximum
number of AMPDU. To prevent aggregate too many MPDU over peer's capability
causing loss in peer side, set the minimum values across all stations and
TID since there is single one register per hardware band. Consider MLD
case, a BA session can run across two hardware bands, so set the same
value as well.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c      |  2 ++
 drivers/net/wireless/realtek/rtw89/mac.h      |  1 +
 drivers/net/wireless/realtek/rtw89/mac80211.c |  3 +++
 drivers/net/wireless/realtek/rtw89/mac_be.c   |  2 ++
 drivers/net/wireless/realtek/rtw89/phy.c      | 27 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.h      |  1 +
 6 files changed, 36 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 234928613ef4..a292a14394b2 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -7319,6 +7319,8 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 	},
 	.wow_ctrl = {.addr = R_AX_WOW_CTRL, .mask = B_AX_WOW_WOWEN,},
 	.agg_limit = {.addr = R_AX_AMPDU_AGG_LIMIT, .mask = B_AX_AMPDU_MAX_TIME_MASK,},
+	.ra_agg_limit = {.addr = R_AX_AMPDU_AGG_LIMIT,
+			 .mask = B_AX_RA_TRY_RATE_AGG_LMT_MASK,},
 	.txcnt_limit = {.addr = R_AX_TXCNT, .mask = B_AX_L_TXCNT_LMT_MASK,},
 
 	.check_mac_en = rtw89_mac_check_mac_en_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index e6b715b95409..9c77bfaa34ee 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1037,6 +1037,7 @@ struct rtw89_mac_gen_def {
 	struct rtw89_reg_def narrow_bw_ru_dis;
 	struct rtw89_reg_def wow_ctrl;
 	struct rtw89_reg_def agg_limit;
+	struct rtw89_reg_def ra_agg_limit;
 	struct rtw89_reg_def txcnt_limit;
 
 	int (*check_mac_en)(struct rtw89_dev *rtwdev, u8 band,
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 1ef73bfc40d1..cd8e2c8de888 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -1005,6 +1005,8 @@ static int rtw89_ops_ampdu_action(struct ieee80211_hw *hw,
 		clear_bit(tid, rtwsta->ampdu_map);
 		rtw89_chip_h2c_ampdu_cmac_tbl(rtwdev, rtwvif, rtwsta);
 		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
+		rtw89_leave_ps_mode(rtwdev);
+		rtw89_phy_ra_recalc_agg_limit(rtwdev);
 		break;
 	case IEEE80211_AMPDU_TX_OPERATIONAL:
 		set_bit(RTW89_TXQ_F_AMPDU, &rtwtxq->flags);
@@ -1013,6 +1015,7 @@ static int rtw89_ops_ampdu_action(struct ieee80211_hw *hw,
 		set_bit(tid, rtwsta->ampdu_map);
 		rtw89_leave_ps_mode(rtwdev);
 		rtw89_chip_h2c_ampdu_cmac_tbl(rtwdev, rtwvif, rtwsta);
+		rtw89_phy_ra_recalc_agg_limit(rtwdev);
 		break;
 	case IEEE80211_AMPDU_RX_START:
 		rtw89_chip_h2c_ba_cam(rtwdev, rtwsta, true, params);
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index ed1ea13bb98d..b9e8f4fa366b 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -3196,6 +3196,8 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 	},
 	.wow_ctrl = {.addr = R_BE_WOW_CTRL, .mask = B_BE_WOW_WOWEN,},
 	.agg_limit = {.addr = R_BE_AMPDU_AGG_LIMIT, .mask = B_BE_AMPDU_MAX_TIME_MASK,},
+	.ra_agg_limit = {.addr = R_BE_AMPDU_AGG_LIMIT,
+			 .mask = B_BE_RA_TRY_RATE_AGG_LMT_MASK,},
 	.txcnt_limit = {.addr = R_BE_TXCNT, .mask = B_BE_L_TXCNT_LMT_MASK,},
 
 	.check_mac_en = rtw89_mac_check_mac_en_be,
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 74f5d5562848..0fa4d8d791f1 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -775,6 +775,33 @@ void rtw89_phy_ra_assoc(struct rtw89_dev *rtwdev, struct rtw89_sta_link *rtwsta_
 	rtw89_fw_h2c_ra(rtwdev, ra, csi);
 }
 
+void rtw89_phy_ra_recalc_agg_limit(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_reg_def *ra_limit = &mac->ra_agg_limit;
+	struct ieee80211_sta *sta;
+	struct rtw89_sta *rtwsta;
+	u16 agg_num = U16_MAX;
+	u8 tid;
+
+	for_each_station(sta, rtwdev->hw) {
+		rtwsta = sta_to_rtwsta(sta);
+
+		for_each_set_bit(tid, rtwsta->ampdu_map, IEEE80211_NUM_TIDS)
+			agg_num = min(agg_num, rtwsta->ampdu_params[tid].agg_num);
+	}
+
+	if (agg_num == U16_MAX)
+		agg_num = 0x3F;
+	else
+		agg_num = clamp(agg_num, 1, 256) - 1;
+
+	rtw89_write32_idx(rtwdev, ra_limit->addr, ra_limit->mask, agg_num, RTW89_MAC_0);
+	if (!rtwdev->dbcc_en)
+		return;
+	rtw89_write32_idx(rtwdev, ra_limit->addr, ra_limit->mask, agg_num, RTW89_MAC_1);
+}
+
 u8 rtw89_phy_get_txsc(struct rtw89_dev *rtwdev,
 		      const struct rtw89_chan *chan,
 		      enum rtw89_bandwidth dbw)
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 094c7e45f254..bde419edf744 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -1006,6 +1006,7 @@ void rtw89_phy_ra_update_sta(struct rtw89_dev *rtwdev, struct ieee80211_sta *sta
 void rtw89_phy_ra_update_sta_link(struct rtw89_dev *rtwdev,
 				  struct rtw89_sta_link *rtwsta_link,
 				  u32 changed);
+void rtw89_phy_ra_recalc_agg_limit(struct rtw89_dev *rtwdev);
 void rtw89_phy_rate_pattern_vif(struct rtw89_dev *rtwdev,
 				struct ieee80211_vif *vif,
 				const struct cfg80211_bitrate_mask *mask);
-- 
2.25.1


