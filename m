Return-Path: <linux-wireless+bounces-15442-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6843E9D084D
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 05:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F5D21F214F5
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 04:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF44113B297;
	Mon, 18 Nov 2024 04:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Ip5tXn38"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FAF13B293
	for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 04:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731902652; cv=none; b=oj6bHncfOBIQuDlIBnys7e6VKJE86wfEdAUvzbmyBSlC8gmPXLYw5WpUghb8At3B/pXww/WBMSpMBjvATwIHCC8z+TpwRA9xy3UPE9YNZudv336zPAmwwG/yeTGeVuq9m9PB6cV/WW3JwAOG6ByrwRZYIfoEd5FS50Zi/Gyu2BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731902652; c=relaxed/simple;
	bh=PzKfgpup4DnMnB1dnzX3YQj5ytD+ouhtcLIloTx4gs8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oICMYFiPK6v9dRaMESEdcrh6sGQUzrzlHU5MhGsZo676enYAn4aiGhOML8Rf3j7O8aKW5PlTxEYc7eR4ziKttp8OHtJ3ACW942OiAfOBh3ojOPIMD4grHbX2+ItDMxb/UJyvuz97JKpMPJQe8fPo9xJDBNlsieyZ49/dsU319uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Ip5tXn38; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AI448IX0100407, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731902648; bh=PzKfgpup4DnMnB1dnzX3YQj5ytD+ouhtcLIloTx4gs8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Ip5tXn387f1eCNv/29d6iy0opAcnnUYTsXXF55vlEgzfBCIynwWBRmHBI5UHfCvGH
	 DQzS51Toz1iRvRXLHs5EVvduQcTwgf6o/X22KFOvBQAyPL4t8Lai2OPLZQDbiTn14N
	 zHNVEcejhZAsh4vPVVYEb3/H/FuyzVEhHvVU9MZ6hdMtGho3/e1Q7jGsXA2m4IZLt4
	 EPbBvYBAoc9Ksl6qtSnsENCjLVAf33jW8xrTumT/ZN9RIo19X/Z8kkzZ+k9eXua1Ee
	 CY07Ut7tflTEPdosW5P/7B6LqrFa3+PzoJyOWcrCImTva1Yq48ept2PPubNvxMPe+h
	 bBadWLjwc4ESw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AI448IX0100407
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 12:04:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 12:04:09 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 18 Nov
 2024 12:04:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH v2 6/6] wifi: rtw89: pass target link_id to ieee80211_nullfunc_get()
Date: Mon, 18 Nov 2024 12:02:55 +0800
Message-ID: <20241118040255.40854-7-pkshih@realtek.com>
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


