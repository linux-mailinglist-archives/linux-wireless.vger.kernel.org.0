Return-Path: <linux-wireless+bounces-3192-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F6D84ACAE
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 04:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D0E4287063
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 03:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6611AB7FC;
	Tue,  6 Feb 2024 03:07:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE6A4BAAA
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 03:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707188856; cv=none; b=n0NIX5oMfbBLH74QrI5HuuQiric2FwHdwtaE69BEClaRmid5rN3z5tX+lR0JW4BHQsqv4HgDgkTOmV4EI5AttMgcdsAFz4ZPOpGm8dyvueIK7E2fNT2JheHEaVHFU340rhcWkJtsrauTkrLYz+TRqEUtLwXISgOoQNXWNxFzFtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707188856; c=relaxed/simple;
	bh=NmLYzYjfurZ7BhgypiS05qM4GHMEw/I+rNZINq4MdoA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ibyvRsU10A/VsluLyQZk4gffvk2o7G2U/Etgg8RIOxXIFMOPsYfqGINtW3Y5RieEAHyMc5W6hkMs3eEKpXngPCSNCHgrMMWIQzRR8Hm4yN8XWV/lKeOz9g7a6rb1f7KqB+dIuCJiu9ZRHeghLFOpP2bUWaXvfvjFkZKXrobC97E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41637TfC43532535, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41637TfC43532535
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Feb 2024 11:07:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Tue, 6 Feb 2024 11:07:29 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 6 Feb
 2024 11:07:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/6] wifi: rtw89: chan: move handling from add/remove to assign/unassign for MLO
Date: Tue, 6 Feb 2024 11:06:23 +0800
Message-ID: <20240206030624.23382-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240206030624.23382-1-pkshih@realtek.com>
References: <20240206030624.23382-1-pkshih@realtek.com>
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

After MLO, we will need to consider not only active chanctx but also active
interfaces (roles) to decide entity things. So in advance, we move handling
from chanctx_ops::add/remove to chanctx_ops::assign_vif/unassign_vif. Then,
we can recalculate and aware active interfaces' changes.

For now, behavior should not be really different, since active chanctx and
active interface are one-to-one mapping before MLO.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 75 +++++++++++++----------
 drivers/net/wireless/realtek/rtw89/core.c |  5 +-
 drivers/net/wireless/realtek/rtw89/core.h |  2 +-
 3 files changed, 47 insertions(+), 35 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 57fabc05dab9..71fe0d3ab3b0 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -1979,7 +1979,6 @@ int rtw89_chanctx_ops_add(struct rtw89_dev *rtwdev,
 		return -ENOENT;
 
 	rtw89_config_entity_chandef(rtwdev, idx, &ctx->def);
-	rtw89_set_channel(rtwdev);
 	cfg->idx = idx;
 	hal->sub[idx].cfg = cfg;
 	return 0;
@@ -1990,37 +1989,8 @@ void rtw89_chanctx_ops_remove(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
 	struct rtw89_chanctx_cfg *cfg = (struct rtw89_chanctx_cfg *)ctx->drv_priv;
-	enum rtw89_entity_mode mode;
-	u8 drop, roll;
-
-	drop = cfg->idx;
-	if (drop != RTW89_SUB_ENTITY_0)
-		goto out;
-
-	roll = find_next_bit(hal->entity_map, NUM_OF_RTW89_SUB_ENTITY, drop + 1);
-
-	/* Follow rtw89_config_default_chandef() when rtw89_entity_recalc(). */
-	if (roll == NUM_OF_RTW89_SUB_ENTITY)
-		goto out;
-
-	/* RTW89_SUB_ENTITY_0 is going to release, and another exists.
-	 * Make another roll down to RTW89_SUB_ENTITY_0 to replace.
-	 */
-	rtw89_swap_sub_entity(rtwdev, RTW89_SUB_ENTITY_0, roll);
-	drop = roll;
 
-out:
-	mode = rtw89_get_entity_mode(rtwdev);
-	switch (mode) {
-	case RTW89_ENTITY_MODE_MCC:
-		rtw89_mcc_stop(rtwdev);
-		break;
-	default:
-		break;
-	}
-
-	clear_bit(drop, hal->entity_map);
-	rtw89_set_channel(rtwdev);
+	clear_bit(cfg->idx, hal->entity_map);
 }
 
 void rtw89_chanctx_ops_change(struct rtw89_dev *rtwdev,
@@ -2045,7 +2015,8 @@ int rtw89_chanctx_ops_assign_vif(struct rtw89_dev *rtwdev,
 	rtwvif->sub_entity_idx = cfg->idx;
 	rtwvif->chanctx_assigned = true;
 	cfg->ref_count++;
-	return 0;
+
+	return rtw89_set_channel(rtwdev);
 }
 
 void rtw89_chanctx_ops_unassign_vif(struct rtw89_dev *rtwdev,
@@ -2053,8 +2024,48 @@ void rtw89_chanctx_ops_unassign_vif(struct rtw89_dev *rtwdev,
 				    struct ieee80211_chanctx_conf *ctx)
 {
 	struct rtw89_chanctx_cfg *cfg = (struct rtw89_chanctx_cfg *)ctx->drv_priv;
+	struct rtw89_hal *hal = &rtwdev->hal;
+	struct rtw89_entity_weight w = {};
+	enum rtw89_sub_entity_idx roll;
+	enum rtw89_entity_mode cur;
 
 	rtwvif->sub_entity_idx = RTW89_SUB_ENTITY_0;
 	rtwvif->chanctx_assigned = false;
 	cfg->ref_count--;
+
+	if (cfg->ref_count != 0)
+		goto out;
+
+	if (cfg->idx != RTW89_SUB_ENTITY_0)
+		goto out;
+
+	roll = find_next_bit(hal->entity_map, NUM_OF_RTW89_SUB_ENTITY,
+			     cfg->idx + 1);
+	/* Follow rtw89_config_default_chandef() when rtw89_entity_recalc(). */
+	if (roll == NUM_OF_RTW89_SUB_ENTITY)
+		goto out;
+
+	/* RTW89_SUB_ENTITY_0 is going to release, and another exists.
+	 * Make another roll down to RTW89_SUB_ENTITY_0 to replace.
+	 */
+	rtw89_swap_sub_entity(rtwdev, cfg->idx, roll);
+
+out:
+	rtw89_entity_calculate_weight(rtwdev, &w);
+
+	cur = rtw89_get_entity_mode(rtwdev);
+	switch (cur) {
+	case RTW89_ENTITY_MODE_MCC:
+		/* If still multi-roles, re-plan MCC for chanctx changes.
+		 * Otherwise, just stop MCC.
+		 */
+		rtw89_mcc_stop(rtwdev);
+		if (w.active_roles == NUM_OF_RTW89_MCC_ROLES)
+			rtw89_mcc_start(rtwdev);
+		break;
+	default:
+		break;
+	}
+
+	rtw89_set_channel(rtwdev);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index de4c37c48f4e..1da01514f171 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -372,7 +372,7 @@ void rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev)
 	chip->ops->set_txpwr(rtwdev, chan, phy_idx);
 }
 
-void rtw89_set_channel(struct rtw89_dev *rtwdev)
+int rtw89_set_channel(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
@@ -399,7 +399,7 @@ void rtw89_set_channel(struct rtw89_dev *rtwdev)
 		break;
 	default:
 		WARN(1, "Invalid ent mode: %d\n", mode);
-		return;
+		return -EINVAL;
 	}
 
 	roc_idx = atomic_read(&hal->roc_entity_idx);
@@ -426,6 +426,7 @@ void rtw89_set_channel(struct rtw89_dev *rtwdev)
 	}
 
 	rtw89_set_entity_state(rtwdev, true);
+	return 0;
 }
 
 void rtw89_get_channel(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index ba2b298c4a9b..c20d21f5b0a6 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5987,7 +5987,7 @@ void rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev);
 void rtw89_get_default_chandef(struct cfg80211_chan_def *chandef);
 void rtw89_get_channel_params(const struct cfg80211_chan_def *chandef,
 			      struct rtw89_chan *chan);
-void rtw89_set_channel(struct rtw89_dev *rtwdev);
+int rtw89_set_channel(struct rtw89_dev *rtwdev);
 void rtw89_get_channel(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 		       struct rtw89_chan *chan);
 u8 rtw89_core_acquire_bit_map(unsigned long *addr, unsigned long size);
-- 
2.25.1


