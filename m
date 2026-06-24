Return-Path: <linux-wireless+bounces-38035-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /BYhOOlRO2p9WAgAu9opvQ
	(envelope-from <linux-wireless+bounces-38035-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 05:41:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D827F6BB260
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 05:41:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=Qm8alSAT;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38035-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38035-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AADBB300B80A
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 03:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE26830BB91;
	Wed, 24 Jun 2026 03:40:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C02E30B53A
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 03:40:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782272449; cv=none; b=SQbIsgGEK/a4/HRiE0zEqiLi03c9/45jCVecl8RUcAkxYQzUS0pkhZ4+vjwD2evp9/cyJ1UvPv1nudXiKBPMgpCTj3nn948MQWOjWzO9rRMpHSlq6JklD8ePBkCV6GTLNnE/ndKKoSejABVrmFHFk42JZnqaP5P645AZU6/sR0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782272449; c=relaxed/simple;
	bh=Om69abFlGbQ8sY5OvTPxdTXia3OeYwV7ljZbctO5TQc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S7wnqWP9rqHCuWFcvHkO1uIrbftatjFoOjads1/gfi7aq7ne5eekYZGeSuPXwmLmR4EzN5L7zjbGje+MoLMttb0/Oju4Ndsv8mt61ROASa5B9ZE4ng8+lxVHNuMXcufrE+WAjbitsKZWNz1XaO2JRTIwJn5nVp7+iPsvfh70dOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Qm8alSAT; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65O3ejD333888852, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1782272445; bh=Z4MmMRptfLpIytbV6ijYvhfTVd1Nm69omF8sM/Ql8Cg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Qm8alSATiHNHKVlOuA2RLOTRQfuU1thuLyHVjRZQVcZDAxOjsWpoOEhcYSWFlciTY
	 1feObg5JcDpute/OpXQ37EGrqXa0gZV/0Y9cZhVZkF/xGkIrXDWZ0azPrCVxV8EpLW
	 JVmAqYAOl8n6KjOk0kZznH7aqon6Zcyuq4jCnAKsb3wm0avSpiHDKKWhVjj03mjFs+
	 Dz0IENEjdBrdqf2jg3zSq14l3ENN+hxuRcDT7xNm/u4lOehULDIHoO9BNUWtCySgpc
	 2TfIHQRCIMIZATy2RXhYIT0Mq/NToqH7h7e+tenQoaUWk7SuHzmvlwikE4hBP5HDlF
	 9aqYDJDsX9B+w==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65O3ejD333888852
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 11:40:45 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Jun 2026 11:40:46 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 24 Jun 2026 11:40:45 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 04/10] wifi: rtw89: coex: Extend bt_slot_req for dual MAC wifi
Date: Wed, 24 Jun 2026 11:39:35 +0800
Message-ID: <20260624033941.45918-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260624033941.45918-1-pkshih@realtek.com>
References: <20260624033941.45918-1-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-38035-lists,linux-wireless=lfdr.de];
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
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,realtek.com:dkim,realtek.com:email,realtek.com:mid,realtek.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D827F6BB260

From: Ching-Te Ku <ku920601@realtek.com>

This variable is for asking driver occupied Bluetooth traffic slot while
wifi is running at multi-port mode. Example like station + AP. The time
slot is separated by wifi driver under these wifi modes. And to ensure
Bluetooth performance, Coex will advice the Bluetooth slot length to
driver. And each MAC is able to run multi-port mode, so extend the
variable's index.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 24 +++++++++++------------
 drivers/net/wireless/realtek/rtw89/coex.h |  2 +-
 drivers/net/wireless/realtek/rtw89/core.h |  2 +-
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index e4662e7b74e0..659028edccfa 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -975,8 +975,8 @@ static void _reset_btc_var(struct rtw89_dev *rtwdev, u8 type)
 		}
 
 		btc->policy_len = 0;
-		btc->bt_req_len = 0;
-
+		btc->bt_req_len[RTW89_PHY_0] = 0;
+		btc->bt_req_len[RTW89_PHY_1] = 0;
 		btc->dm.coex_info_map = BTC_COEX_INFO_ALL;
 		btc->dm.wl_tx_limit.tx_time = BTC_MAX_TX_TIME_DEF;
 		btc->dm.wl_tx_limit.tx_retry = BTC_MAX_TX_RETRY_DEF;
@@ -1994,10 +1994,10 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			/* Check diff time between real BT slot and EBT/E5G slot */
 			if (dm->tdma_now.type == CXTDMA_OFF &&
 			    dm->tdma_now.ext_ctrl == CXECTL_EXT &&
-			    btc->bt_req_len != 0) {
+			    btc->bt_req_len[RTW89_PHY_0] != 0) {
 				bt_slot_real = le16_to_cpu(pcysta->v3.cycle_time.tavg[CXT_BT]);
-				if (btc->bt_req_len > bt_slot_real) {
-					diff_t = btc->bt_req_len - bt_slot_real;
+				if (btc->bt_req_len[RTW89_PHY_0] > bt_slot_real) {
+					diff_t = btc->bt_req_len[RTW89_PHY_0] - bt_slot_real;
 					_chk_btc_err(rtwdev, BTC_DCNT_BT_SLOT_DRIFT, diff_t);
 				}
 			}
@@ -2038,11 +2038,11 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			/* Check diff time between real BT slot and EBT/E5G slot */
 			if (dm->tdma_now.type == CXTDMA_OFF &&
 			    dm->tdma_now.ext_ctrl == CXECTL_EXT &&
-			    btc->bt_req_len != 0) {
+			    btc->bt_req_len[RTW89_PHY_0] != 0) {
 				bt_slot_real = le16_to_cpu(pcysta->v4.cycle_time.tavg[CXT_BT]);
 
-				if (btc->bt_req_len > bt_slot_real) {
-					diff_t = btc->bt_req_len - bt_slot_real;
+				if (btc->bt_req_len[RTW89_PHY_0] > bt_slot_real) {
+					diff_t = btc->bt_req_len[RTW89_PHY_0] - bt_slot_real;
 					_chk_btc_err(rtwdev, BTC_DCNT_BT_SLOT_DRIFT, diff_t);
 				}
 			}
@@ -2083,7 +2083,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			_chk_btc_err(rtwdev, BTC_DCNT_WL_SLOT_DRIFT, diff_t);
 
 			/* Check diff time between real BT slot and EBT/E5G slot */
-			bt_slot_set = btc->bt_req_len;
+			bt_slot_set = btc->bt_req_len[RTW89_PHY_0];
 			bt_slot_real = le16_to_cpu(pcysta->v5.cycle_time.tavg[CXT_BT]);
 			diff_t = 0;
 			if (dm->tdma_now.type == CXTDMA_OFF &&
@@ -5861,7 +5861,7 @@ static void _action_wl_2g_scc_v1(struct rtw89_dev *rtwdev)
 				dm->wl_scc.ebt_null = 0;
 				policy_type = BTC_CXP_OFFE_2GISOB;
 			} else if (bt->link_info.a2dp_desc.exist &&
-				   dur < btc->bt_req_len) {
+				   dur < btc->bt_req_len[RTW89_PHY_0]) {
 				dm->wl_scc.ebt_null = 1; /* tx null at EBT */
 				policy_type = BTC_CXP_OFFE_2GBWMIXB2;
 			} else if (bt->link_info.a2dp_desc.exist ||
@@ -5934,7 +5934,7 @@ static void _action_wl_2g_scc_v2(struct rtw89_dev *rtwdev)
 				dm->wl_scc.ebt_null = 0;
 				policy_type = BTC_CXP_OFFE_2GISOB;
 			} else if (bt->link_info.a2dp_desc.exist &&
-				   dur < btc->bt_req_len) {
+				   dur < btc->bt_req_len[RTW89_PHY_0]) {
 				dm->wl_scc.ebt_null = 1; /* tx null at EBT */
 				policy_type = BTC_CXP_OFFE_2GBWMIXB2;
 			} else if (bt->link_info.a2dp_desc.exist ||
@@ -9694,7 +9694,7 @@ static int _show_dm_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 		       " %-15s : wl_tx_limit[en:%d/max_t:%dus/max_retry:%d], bt_slot_reg:%d-TU, bt_scan_rx_low_pri:%d\n",
 		       "[dm_ctrl]", dm->wl_tx_limit.enable,
 		       dm->wl_tx_limit.tx_time,
-		       dm->wl_tx_limit.tx_retry, btc->bt_req_len,
+		       dm->wl_tx_limit.tx_retry, btc->bt_req_len[RTW89_PHY_0],
 		       bt->scan_rx_low_pri);
 
 	return p - buf;
diff --git a/drivers/net/wireless/realtek/rtw89/coex.h b/drivers/net/wireless/realtek/rtw89/coex.h
index ea2c1e5d70f5..6ac14611607c 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.h
+++ b/drivers/net/wireless/realtek/rtw89/coex.h
@@ -329,7 +329,7 @@ static inline u16 rtw89_coex_query_bt_req_len(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 
-	return btc->bt_req_len;
+	return btc->bt_req_len[phy_idx];
 }
 
 static inline u32 rtw89_get_antpath_type(u8 phy_map, u8 type)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 0abbde6a2013..13fa7f574e91 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3390,7 +3390,7 @@ struct rtw89_btc {
 	struct wiphy_work dhcp_notify_work;
 	struct wiphy_work icmp_notify_work;
 
-	u32 bt_req_len;
+	u32 bt_req_len[RTW89_PHY_NUM];
 
 	u8 policy[RTW89_BTC_POLICY_MAXLEN];
 	u8 ant_type;
-- 
2.25.1


