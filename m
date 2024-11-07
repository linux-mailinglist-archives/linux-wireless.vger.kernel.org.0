Return-Path: <linux-wireless+bounces-15042-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 650F19C0038
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 09:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAA371F2352F
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 08:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB8B1DD543;
	Thu,  7 Nov 2024 08:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="b/89nYVV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F951DE2AC
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 08:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730968892; cv=none; b=fak8LSqtbsQrT6G8nssEUKdoPEYFjwDsffwOLR9tmnKOn/ImDi9fWiBVysDAr/6FSk9cioNMp1/AUqq6zvNDb7PF/o3L9srGw+D5vGhrUG76Yir8xRO0Z3sZTH88h620aqPDI7lAfi3DItqvhKIcZ5q2Zdtmw4AKS+3WouHBGAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730968892; c=relaxed/simple;
	bh=Iz7lcyo4meqkW/ZIPLIvdtIaaZ1VzBFNzkq/yU/mwD8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jgkGp+sFLmvpmY3jYASbnX1wqq1PsQaYIcgJGDy0fqo52WgnyptmC2Jx9KLCCYvIW0511kmOeA3ReAEzlIhVarQNrbjhdOwJErfYcCZZx2UyqCS8syFDyHEvGdU1yUxpivNsEW9ZHD1ykvLJ/l8RT0cr6OnI7vT/o9+k8m1Ilrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=b/89nYVV; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4A78fRSg94173701, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730968887; bh=Iz7lcyo4meqkW/ZIPLIvdtIaaZ1VzBFNzkq/yU/mwD8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=b/89nYVVgxtawQ3NIHtVshCL86j7SbOBUlZdDP1ElkVjvSN8wcfvSxkCtbKPICosP
	 1xcp6Vkv/IagcDUg95KU2Nh8pFPn5OHm5IcI58Xjs51o4BRNklVTstUngewNdY82mi
	 D8WbSY/1E655uMS25sDiKmHMOtZaedLhIFNRzond26eRvIhLcPw4CyaHhj/yrIUb3L
	 85wUSMMlrg5MKSx8o5J+Jn8EAKbqldvCQXSqzz6fYCuRfPuo9GkckgWddEBHAfcZY7
	 O+XXyy69aw+r64vnI4ajBmJNtNUmU6mBSv6lGu/N01xt576wx3zjYbcpqi0CBOoCcP
	 fVc9CgxGcVdXw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4A78fRSg94173701
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 7 Nov 2024 16:41:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 16:41:27 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 7 Nov
 2024 16:41:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 2/6] wifi: rtw89: register ops of can_activate_links
Date: Thu, 7 Nov 2024 16:40:37 +0800
Message-ID: <20241107084041.20775-3-pkshih@realtek.com>
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

Register mac80211 ops of can_activate_links which is required when
we are ready to enable multiple active links.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  1 +
 drivers/net/wireless/realtek/rtw89/mac80211.c | 25 +++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index eb84761fcc8e..b441d0491e88 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -830,6 +830,7 @@ enum rtw89_phy_idx {
 };
 
 #define __RTW89_MLD_MAX_LINK_NUM 2
+#define RTW89_MLD_NON_STA_LINK_NUM 1
 
 enum rtw89_chanctx_idx {
 	RTW89_CHANCTX_0 = 0,
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index fe2790fdcae6..ef3eb0fa651d 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -1482,6 +1482,30 @@ static int rtw89_ops_set_tid_config(struct ieee80211_hw *hw,
 	return 0;
 }
 
+static bool rtw89_can_work_on_links(struct rtw89_dev *rtwdev,
+				    struct ieee80211_vif *vif, u16 links)
+{
+	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
+	u8 w = hweight16(links);
+
+	if (vif->type != NL80211_IFTYPE_STATION &&
+	    w > RTW89_MLD_NON_STA_LINK_NUM)
+		return false;
+
+	return w <= rtwvif->links_inst_valid_num;
+}
+
+static bool rtw89_ops_can_activate_links(struct ieee80211_hw *hw,
+					 struct ieee80211_vif *vif,
+					 u16 active_links)
+{
+	struct rtw89_dev *rtwdev = hw->priv;
+
+	guard(mutex)(&rtwdev->mutex);
+
+	return rtw89_can_work_on_links(rtwdev, vif, active_links);
+}
+
 #ifdef CONFIG_PM
 static int rtw89_ops_suspend(struct ieee80211_hw *hw,
 			     struct cfg80211_wowlan *wowlan)
@@ -1609,6 +1633,7 @@ const struct ieee80211_ops rtw89_ops = {
 	.set_sar_specs		= rtw89_ops_set_sar_specs,
 	.sta_rc_update		= rtw89_ops_sta_rc_update,
 	.set_tid_config		= rtw89_ops_set_tid_config,
+	.can_activate_links	= rtw89_ops_can_activate_links,
 #ifdef CONFIG_PM
 	.suspend		= rtw89_ops_suspend,
 	.resume			= rtw89_ops_resume,
-- 
2.25.1


