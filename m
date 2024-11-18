Return-Path: <linux-wireless+bounces-15438-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4149D0849
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 05:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5127281BB5
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 04:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E135D76048;
	Mon, 18 Nov 2024 04:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="t8d/V9Vh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AAE45025
	for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 04:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731902639; cv=none; b=iG3GZ//Vdrh5N1RS9e1QFKfak/AxUAl3dmxfMI4ib5Z+ngH2z5nMca9813ZEpYMVBAwZZJaX/yHwQEcfCBf8vJtW+TBxNNkwvcNIFf3p/VdP1lYTUsNkI4/7HVZpijrnrOOe+i16gA0GQVk8tyG5Rr+sF3zO4xyf98iQ+xs3SQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731902639; c=relaxed/simple;
	bh=br+9axQ7RrBf4c3wXFySAJ5R+ww0PTHNiQhN5go1RZc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MKom9ch5aV3LMLnaCy43gVkNf42pVGDXZQ+6B8X07vSoH+1NEuBjqnr2Px2sUs30b44UnibOrnGTwxUOGG0M/TYLW7pgCfsIUJpGfRwlfIuNxuNqhirSodPX2ik6ePlOr1VNE9AvJTZ3SF9X0nU72mMS6szv3VIbu7FLu500pi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=t8d/V9Vh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AI43s722100073, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731902634; bh=br+9axQ7RrBf4c3wXFySAJ5R+ww0PTHNiQhN5go1RZc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=t8d/V9VhxocfgyvkWWSb+FLZdPrYs3aroZiI271wApSEddsWyCkqa+0zSaTTYbTzT
	 Cz2gc9kV1TKMPSsw9l0lz6mMt/R7RBYHMsFeGb6+tBGL6G27q8FGUbhNItPSTNQ4Cs
	 y23K5+kEd32xLbouK9Ls39wbYI6SEkVEPljzQTUfoWNEXxdgrFFoik1ctqDZtLYlY/
	 Oi6IIM07+gjcWk7YnrLo9K+peuVoSLQol+IRf5yExdcno4qZLH/fXhFzuismGwxFjA
	 gPRmt74vgNHnPxqqB1L0LkACK7mLX05U6iIuzR+nakmYjJs0nK3R/KeEhwYYZt84BB
	 bwWDntmG4qz2A==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AI43s722100073
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 12:03:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 12:03:55 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 18 Nov
 2024 12:03:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH v2 2/6] wifi: rtw89: register ops of can_activate_links
Date: Mon, 18 Nov 2024 12:02:51 +0800
Message-ID: <20241118040255.40854-3-pkshih@realtek.com>
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

Register mac80211 ops of can_activate_links which is required when
we are ready to enable multiple active links.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  1 +
 drivers/net/wireless/realtek/rtw89/mac80211.c | 25 +++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 3e93b53fd67b..dcd2ccadac96 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -830,6 +830,7 @@ enum rtw89_phy_idx {
 };
 
 #define __RTW89_MLD_MAX_LINK_NUM 2
+#define RTW89_MLD_NON_STA_LINK_NUM 1
 
 enum rtw89_chanctx_idx {
 	RTW89_CHANCTX_0 = 0,
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 8dc475f6fdf7..40ff5aa041fa 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -1484,6 +1484,30 @@ static int rtw89_ops_set_tid_config(struct ieee80211_hw *hw,
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
@@ -1611,6 +1635,7 @@ const struct ieee80211_ops rtw89_ops = {
 	.set_sar_specs		= rtw89_ops_set_sar_specs,
 	.link_sta_rc_update	= rtw89_ops_sta_rc_update,
 	.set_tid_config		= rtw89_ops_set_tid_config,
+	.can_activate_links	= rtw89_ops_can_activate_links,
 #ifdef CONFIG_PM
 	.suspend		= rtw89_ops_suspend,
 	.resume			= rtw89_ops_resume,
-- 
2.25.1


