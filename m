Return-Path: <linux-wireless+bounces-15046-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DC39C003E
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 09:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 207711C2121D
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 08:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF3A1DACA9;
	Thu,  7 Nov 2024 08:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="dzY6ypmS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD0D1DB52A
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 08:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730968904; cv=none; b=SY3ATdIdRQYd6PMj9TgZRWbTZfuruxnKvUcRrf0efAeGOQ9DvJp6ghLMO8pDgvRcmc7qz1j0rpmUuBkd/PoUNtdAvCmvIVDIlWXOPMq838MiuAjRv6GDmvc4I4Xu9jojSlTYMutYGj/EeMhaltMU8k5ZTVsstHL9JXK3uYFtnmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730968904; c=relaxed/simple;
	bh=NYL6mJ0hv5+4jn1QObwEcV8mKsymiGSqK0jmrLjUscc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nCycBzPzV0Zl9fgfGNYa/fn1jjGDfSn/trHOZDxlNP5igA2LW+FDmxy+a2TVovAoDsc9cA3cFf0lKFBRB3cyrF69CZ/HR6Cja5nUjadq7mhhr+J28OxORsYA5Nn8vt6sE9NEe0MweK14PZDWibubnxSjxuX/4kGCYtE8ABfSAAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=dzY6ypmS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4A78fe4134173725, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730968900; bh=NYL6mJ0hv5+4jn1QObwEcV8mKsymiGSqK0jmrLjUscc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=dzY6ypmSFKixFSEV3+tVBVPJPH5nMwA3VXHX3ToW+48/zNB09Nj+gJkfM81jbx8QW
	 omlK3NN6dVi9LBJquKkt3hDGlOu9M6qvquftNVhXrILLGJXd2TvJt+NoUMDbnoT5cU
	 gIHQoUJkb01RttYLnqhgadOWWuP+nQCD5ID1U1iTckKCHy/0woDH8vvVSHDzY0NcT5
	 MC37JG5R5WZMDd8gjZSmZEoDigxkoKrmX+k0PEKP15+709sitmYvDqucR1urJKAxYS
	 pfRZexnm0dB/kE9X2f9SvQnyRBYXFvkHBTyLlQlBcavD9+l0Lb6nFA/mrJ9w+u6Oqw
	 YwQAPXFZGrIug==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4A78fe4134173725
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 7 Nov 2024 16:41:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 16:41:40 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 7 Nov
 2024 16:41:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 6/6] wifi: rtw89: pass target link_id to ieee80211_nullfunc_get()
Date: Thu, 7 Nov 2024 16:40:41 +0800
Message-ID: <20241107084041.20775-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241107084041.20775-1-pkshih@realtek.com>
References: <20241107084041.20775-1-pkshih@realtek.com>
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
index 902d546e22d6..04fd58dd9724 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3167,6 +3167,7 @@ static int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev,
 				    struct rtw89_vif_link *rtwvif_link, bool qos, bool ps)
 {
 	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
+	int link_id = ieee80211_vif_is_mld(vif) ? rtwvif_link->link_id : -1;
 	struct ieee80211_sta *sta;
 	struct ieee80211_hdr *hdr;
 	struct sk_buff *skb;
@@ -3182,7 +3183,7 @@ static int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev,
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


