Return-Path: <linux-wireless+bounces-15526-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679829D32BE
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2024 04:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D046128493C
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2024 03:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB923A1B6;
	Wed, 20 Nov 2024 03:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="SZK1BraA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73703156C62
	for <linux-wireless@vger.kernel.org>; Wed, 20 Nov 2024 03:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732074118; cv=none; b=uJCigc4y4vNuJ3L6n7+6mCri+InX6T/VPwVrlPXVafH7V2Goq17OZQIBL9ntzwgpmPX9GKd9jEbMPI/o9i9bH6WCk3C79Hvdh5zoecLjxY3YUR3UAGmsaVFrh9aubwdhjs3mlsq33anPwqbkQO4kICJj1G4QSgSlghns9tQUAVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732074118; c=relaxed/simple;
	bh=PzKfgpup4DnMnB1dnzX3YQj5ytD+ouhtcLIloTx4gs8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kXTYrpMht5Byl2vTlDjmJ4YpFgAaVwYK8fwgVmS6kqvUBKdxAG+IXeIbyU3pUrs4RRYO1pJOHk1SYNl6l5UVo7ZMqCtgcyMT9MusqSj3rZ0reQ9sVzmn4HtgKPdoHi6C1usZsT08FGJvxlzEi4GtV8tyGc/zeceu3WT9zItF9GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=SZK1BraA; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AK3fs5M33465189, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732074114; bh=PzKfgpup4DnMnB1dnzX3YQj5ytD+ouhtcLIloTx4gs8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=SZK1BraAxZZOuAkYx6Lst56jMKHdmTRkUzN765ez9KaFQVK+U6fjDuox8iEpzAyVc
	 rTFL0t/EVydh6or7oJB75UqvKxueTyGp7FpigvQQkxvU4zOW7r38R32UsxiwvC2vQq
	 rWP/CBykvq+R3Zg33JUrT8uEvEWhqVLHL2Ui+zzDC0pRuLAO32EykFw8tBgnf8AsTP
	 htkTadBE2TDHJvyZonQSo8OlCpZuebvoTnjPP2qkBat151vvGNtlgMoNWQOMAiPgZX
	 +ez8w7uBq+IUCI/EU1Gib4U2SgmcyLMCQCq8xIUSQoG4Gps9HRNhaArsz5jlo+cL3z
	 cS9qUiWqfRdfg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AK3fs5M33465189
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 20 Nov 2024 11:41:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 11:41:54 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 20 Nov
 2024 11:41:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH v3 6/6] wifi: rtw89: pass target link_id to ieee80211_nullfunc_get()
Date: Wed, 20 Nov 2024 11:40:54 +0800
Message-ID: <20241120034054.13575-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241120034054.13575-1-pkshih@realtek.com>
References: <20241120034054.13575-1-pkshih@realtek.com>
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

When calling ieee80211_nullfunc_get(), pass the target link_id
instead of always -1.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 3 ++-
 drivers/net/wireless/realtek/rtw89/fw.c   | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index c99111df90a7..6f9b4f0b2748 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3216,6 +3216,7 @@ static int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev,
 				    struct rtw89_vif_link *rtwvif_link, bool qos, bool ps)
 {
 	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
+	int link_id = ieee80211_vif_is_mld(vif) ? rtwvif_link->link_id : -1;
 	struct ieee80211_sta *sta;
 	struct ieee80211_hdr *hdr;
 	struct sk_buff *skb;
@@ -3231,7 +3232,7 @@ static int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev,
 		goto out;
 	}
 
-	skb = ieee80211_nullfunc_get(rtwdev->hw, vif, -1, qos);
+	skb = ieee80211_nullfunc_get(rtwdev->hw, vif, link_id, qos);
 	if (!skb) {
 		ret = -ENOMEM;
 		goto out;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 7bda9aab382c..cbd759c844e5 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2415,6 +2415,7 @@ static int rtw89_fw_h2c_add_general_pkt(struct rtw89_dev *rtwdev,
 					u8 *id)
 {
 	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
+	int link_id = ieee80211_vif_is_mld(vif) ? rtwvif_link->link_id : -1;
 	struct rtw89_pktofld_info *info;
 	struct sk_buff *skb;
 	int ret;
@@ -2431,10 +2432,10 @@ static int rtw89_fw_h2c_add_general_pkt(struct rtw89_dev *rtwdev,
 		skb = ieee80211_proberesp_get(rtwdev->hw, vif);
 		break;
 	case RTW89_PKT_OFLD_TYPE_NULL_DATA:
-		skb = ieee80211_nullfunc_get(rtwdev->hw, vif, -1, false);
+		skb = ieee80211_nullfunc_get(rtwdev->hw, vif, link_id, false);
 		break;
 	case RTW89_PKT_OFLD_TYPE_QOS_NULL:
-		skb = ieee80211_nullfunc_get(rtwdev->hw, vif, -1, true);
+		skb = ieee80211_nullfunc_get(rtwdev->hw, vif, link_id, true);
 		break;
 	case RTW89_PKT_OFLD_TYPE_EAPOL_KEY:
 		skb = rtw89_eapol_get(rtwdev, rtwvif_link);
-- 
2.25.1


