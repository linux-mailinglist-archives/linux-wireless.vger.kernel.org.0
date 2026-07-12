Return-Path: <linux-wireless+bounces-38899-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n5bRKtYEU2pUWAMAu9opvQ
	(envelope-from <linux-wireless+bounces-38899-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 05:07:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 41271743A48
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 05:07:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=I78XDpqK;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38899-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38899-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A734E300559F
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 03:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A747C27A476;
	Sun, 12 Jul 2026 03:07:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0727F2773DE
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 03:06:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783825620; cv=none; b=tPige6PmALQcFr8wLYRlnUil66AcHBvsgJY3jAxDy5Bi5Fq732HnMCcwNRs8CBG6Bi8tplkdzflXqZLx13Do7WnzNTQA69CFp7O8mo5lr2WrM4pdz9H9UKGM3Uk3RC+U1h1umJayqo8KfniXVvDm+zPYZqF2kXZFBb6d0vlwOgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783825620; c=relaxed/simple;
	bh=qSV3upadV4INkZMTHmYRwUrbTOwXZmyDwlNY2TdN4P4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EmOVQgjldCHEJLC5b8PO3QpbErxr7zB3HSIV7L0dsRkhlFgTBFbWyRBj0PbOky4irtBPmpqvnfakb94Ik7HDV3d4uA7RtldXbjkeUCsgWjVElBAmzKHwlFs1nDc58Hy6Ck1429Qb1dDVWbO4Q3qXFq7r33ZazueBlcLjgoUkHmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=I78XDpqK; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66C36uyE6525999, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783825617; bh=N7zYKtBK++c8DMNmkiLjbTkQ5vaiQhSX7tpeuJsiVWM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=I78XDpqKG6VGS1FKp6QZatwfEAO3V7XX8/cC9r+l4c+szT1EOLn8FadMvOU/ptHcj
	 5xY75SfKyVXLPzAPEZKVUsoYyHQP9TL3KVRbYhqEzIXzBnj/6UK+srLHzoLk4Gw/QE
	 KTNTxtJuuoapZaa/PfC5XZRDEsQT+FABlVC/8gXeHwQttHNd6esmu/I3u3bORhuTQk
	 iPYgN4rVUIhBe+SUA71eB63Q2cFfL5DoogxMZs+sAbnzbKYqwnDTv59lGNFXCbcDCQ
	 4EEZqpbvWL9Q39zBJKBSoJ84rYWk7CKCR0AjX4Wa45zIJRwmtnCZ0nRUl7MjP1ITyo
	 WwcOx3oW4a1UA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66C36uyE6525999
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 11:06:57 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 12 Jul 2026 11:06:57 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 12 Jul 2026 11:06:56 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Sun, 12 Jul 2026 11:06:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 10/11] wifi: rtw89: coex: update external control length by case
Date: Sun, 12 Jul 2026 11:05:05 +0800
Message-ID: <20260712030506.43438-11-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260712030506.43438-1-pkshih@realtek.com>
References: <20260712030506.43438-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-38899-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:ku920601@realtek.com,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:from_mime,realtek.com:email,realtek.com:mid,realtek.com:dkim,vger.kernel.org:from_smtp];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 41271743A48

From: Ching-Te Ku <ku920601@realtek.com>

Update recommend external control slot length to driver. Some of the
Wi-Fi feature has its time slot requirement can not be simply controlled
by coexistence firmware TDMA timer. For example: Wi-Fi scan/MCC etc.
In the same time, coexistence need to tell driver the recommend Bluetooth
slot length to make sure Bluetooth can still has enough time slot to
traffic.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 70 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.c | 11 ++--
 drivers/net/wireless/realtek/rtw89/core.h |  4 +-
 3 files changed, 80 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index c2356d6d9811..a6b1aa2cb24e 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -526,6 +526,14 @@ enum btc_cx_poicy_main_type {
 	BTC_CXP_MAIN_MAX
 };
 
+enum btc_bslot_length {
+	BTC_BSLOT_A2DP_HID = 60,
+	BTC_BSLOT_A2DP = 50,
+	BTC_BSLOT_A2DP_2 = 40,
+	BTC_BSLOT_INQ = 30,
+	BTC_BSLOT_IDLE = 20,
+};
+
 enum btc_cx_poicy_type {
 	/* TDMA off + pri: BT > WL */
 	BTC_CXP_OFF_BT = (BTC_CXP_OFF << 8) | 0,
@@ -5989,6 +5997,67 @@ static void _set_wl_tx_limit(struct rtw89_dev *rtwdev)
 					  &data);
 }
 
+static void _set_phl_bt_slot_req(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_cx *cx = &btc->cx;
+	struct rtw89_btc_wl_info *wl = &cx->wl;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	u8 len = 0;
+	u8 i;
+
+	/* don't change bt slot req state during RFK for p2p/mcc case */
+	if (dm->run_reason == BTC_RSN_NTFY_WL_RFK ||
+	    wl->status.map.transacting)
+		return;
+
+	/* enable bt-slot req if ext-slot-control */
+	if (dm->tdma_now.type == CXTDMA_OFF &&
+	    dm->tdma_now.ext_ctrl == CXECTL_EXT &&
+	    dm->tdd_bind.bt_sel != 0) {
+		if (btc->cx.wl.status.val & btc_scanning_map.val)
+			btc->bt_req_en = false;
+		else
+			btc->bt_req_en = true;
+	} else {
+		btc->bt_req_en = false;
+	}
+
+	if (dm->slot_req_more) {
+		len = BTC_BSLOT_A2DP_HID;
+	} else {
+		if (dm->tdd_bind.bt_link_weight >= BTC_BSLOT_A2DP_HID)
+			len = BTC_BSLOT_A2DP_HID;
+		else if (dm->tdd_bind.bt_link_weight <= BTC_BSLOT_IDLE)
+			len = BTC_BSLOT_IDLE;
+		else
+			len = dm->tdd_bind.bt_link_weight;
+	}
+
+	if (dm->tdd_bind.rf_band == BIT(RTW89_BAND_5G))
+		len = 100 - len;
+
+	if (!btc->bt_req_en)
+		len = 0;
+
+	for (i = RTW89_PHY_0; i < RTW89_PHY_NUM; i++) {
+		if (!(dm->tdd_bind.wl_hwb_sel & BIT(i)))
+			continue;
+
+		if (len == btc->bt_req_len[i])
+			continue;
+
+		btc->bt_req_len[i] = len;
+
+		rtw89_core_ntfy_btc_event(rtwdev,
+					  RTW89_BTC_HMSG_SET_BT_REQ_SLOT, i);
+
+		rtw89_debug(rtwdev, RTW89_DBG_BTC,
+			    "[BTC], %s(): HWB%d bt_req_len = %d\n",
+			    __func__, i, btc->bt_req_len[i]);
+	}
+}
+
 static void _set_bt_rx_agc(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
@@ -6148,6 +6217,7 @@ static void _action_common(struct rtw89_dev *rtwdev)
 	_set_btg_ctrl(rtwdev);
 	_set_wl_preagc_ctrl(rtwdev);
 	_set_wl_tx_limit(rtwdev);
+	_set_phl_bt_slot_req(rtwdev);
 	_set_bt_afh_info(rtwdev);
 	_set_bt_rx_agc(rtwdev);
 	_set_rf_trx_para(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 0343cd1a0ee1..30a8e337498e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -6539,15 +6539,18 @@ void rtw89_complete_cond(struct rtw89_wait_info *wait, unsigned int cond,
 	rtw89_complete_cond_resp(resp, data);
 }
 
-void rtw89_core_ntfy_btc_event(struct rtw89_dev *rtwdev, enum rtw89_btc_hmsg event)
+void rtw89_core_ntfy_btc_event(struct rtw89_dev *rtwdev,
+			       enum rtw89_btc_hmsg event,
+			       enum rtw89_phy_idx phy_idx)
 {
-	u16 bt_req_len;
+	u16 bt_slot_req[RTW89_PHY_NUM];
 
 	switch (event) {
 	case RTW89_BTC_HMSG_SET_BT_REQ_SLOT:
-		bt_req_len = rtw89_coex_query_bt_req_len(rtwdev, RTW89_PHY_0);
+		bt_slot_req[phy_idx] = rtw89_coex_query_bt_req_len(rtwdev, phy_idx);
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
-			    "coex updates BT req len to %d TU\n", bt_req_len);
+			    "coex updates PHY-%d BT req len to %d TU\n",
+			    phy_idx, bt_slot_req[phy_idx]);
 		rtw89_queue_chanctx_change(rtwdev, RTW89_CHANCTX_BT_SLOT_CHANGE);
 		break;
 	default:
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index e7e72f742847..c8b5c9ed55be 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -8866,7 +8866,9 @@ int rtw89_reg_6ghz_recalc(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvi
 void rtw89_core_update_p2p_ps(struct rtw89_dev *rtwdev,
 			      struct rtw89_vif_link *rtwvif_link,
 			      struct ieee80211_bss_conf *bss_conf);
-void rtw89_core_ntfy_btc_event(struct rtw89_dev *rtwdev, enum rtw89_btc_hmsg event);
+void rtw89_core_ntfy_btc_event(struct rtw89_dev *rtwdev,
+			       enum rtw89_btc_hmsg event,
+			       enum rtw89_phy_idx phy_idx);
 int rtw89_core_mlsr_switch(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			   unsigned int link_id);
 void rtw89_core_dm_disable_cfg(struct rtw89_dev *rtwdev, u32 new);
-- 
2.25.1


