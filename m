Return-Path: <linux-wireless+bounces-30797-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E7FD1BF73
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 02:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D6FD300A35C
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 01:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA9C17A303;
	Wed, 14 Jan 2026 01:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="CZM5UZ4R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6308C2EA72A
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 01:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768354851; cv=none; b=Y3ivRagzhTdF7rlkShvEc5sq86GE4Ghuv4geyLQ3hD0YRRJiYwlDaNdfQs6qwI0DZpuz7cpZSFlEEUv9GUespBU1hvMjFZnT4psHw1w/j4Oz0FyC8VK2jS1JUWdw0lgMeAQuq39s1S1B1fJ55htFoJtOnaXhyCo7ZA/WkU0UZDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768354851; c=relaxed/simple;
	bh=AMNU1W80iZN+1xhSG9W2XB9KJArmlvYbyVZQiQFmcUI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fHOIYrfR9+CP1RF2NTuCk1aTy0274mCFlbCIZHfa9mfQFCd9OsQX/REfyzMRIiXLiJOAr+0r1x8rSgGa2mP5UHLg7w1l5kJMOqCbk61B668n7Kqk+X2xppxFYv/4CDMb6XCcYSQOX8H4C9ktOxHQz/KDXtifOmAbrcd4LuVjJ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=CZM5UZ4R; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60E1ejyI74168577, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768354845; bh=0Q37gdQ0YMihtq+p5/86Wf6cnaYpaMtlT2zkfWoNeG0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=CZM5UZ4RzF8UoyryGItnTSWlJnZb9xmfMGuDpLBsz1wEoTXWtfd8Q9RiZy8WGTh9o
	 udGC7Fc6NXzU0qSU52xjbHQebFc8lW5MFhtxB3WSC9QU0xAkZze3J5eE5pjfbDcH5A
	 951QLbaPiyiJAexRI54KpL5qe7qB2ukpFu0vSAw4Poqqyc3l/fMeG9TvzLmT0MDWM3
	 XFA1HzW1mOs7STIL69/bd+4WP58+5bPiQY/CIcC9bPrtzVBinu6pubiUPOxFjxOKv8
	 KYmdy6tUcbLjHMHTAAcDuUPDQ/5GkfilQ5szrzmzGguW4zf6mpjNCaKVxc0LPFzyAx
	 6p33m8sabUvog==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60E1ejyI74168577
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 09:40:45 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 14 Jan 2026 09:40:46 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 14 Jan 2026 09:40:46 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 14 Jan 2026 09:40:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <phhuang@realtek.com>
Subject: [PATCH rtw-next 05/12] wifi: rtw89: phy: extend register to read history 2 of PHY env_monitor
Date: Wed, 14 Jan 2026 09:39:43 +0800
Message-ID: <20260114013950.19704-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260114013950.19704-1-pkshih@realtek.com>
References: <20260114013950.19704-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Eric Huang <echuang@realtek.com>

For old chips, history is 8 bits storing in single one register, and
RTL8922D's one is 16 bits and two registers. Extend to common flow
accordingly.

Signed-off-by: Eric Huang <echuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h   | 2 +-
 drivers/net/wireless/realtek/rtw89/phy.c    | 6 ++++--
 drivers/net/wireless/realtek/rtw89/phy.h    | 1 +
 drivers/net/wireless/realtek/rtw89/phy_be.c | 2 ++
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 8d5655138ded..70c366ec3f32 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5683,7 +5683,7 @@ struct rtw89_env_monitor_info {
 	u16 ifs_clm_cckfa;
 	u16 ifs_clm_cckcca_excl_fa;
 	u16 ifs_clm_total_ifs;
-	u8 ifs_clm_his[RTW89_IFS_CLM_NUM];
+	u16 ifs_clm_his[RTW89_IFS_CLM_NUM];
 	u16 ifs_clm_avg[RTW89_IFS_CLM_NUM];
 	u16 ifs_clm_cca[RTW89_IFS_CLM_NUM];
 	u8 ifs_clm_tx_ratio;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 882a8a26e434..099c0e0ae7b6 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -6132,11 +6132,12 @@ static bool rtw89_phy_ifs_clm_get_result(struct rtw89_dev *rtwdev,
 	env->ifs_clm_his[1] =
 		rtw89_phy_read32_idx(rtwdev, ccx->ifs_his_addr,
 				     ccx->ifs_t2_his_mask, bb->phy_idx);
+
 	env->ifs_clm_his[2] =
-		rtw89_phy_read32_idx(rtwdev, ccx->ifs_his_addr,
+		rtw89_phy_read32_idx(rtwdev, ccx->ifs_his_addr2,
 				     ccx->ifs_t3_his_mask, bb->phy_idx);
 	env->ifs_clm_his[3] =
-		rtw89_phy_read32_idx(rtwdev, ccx->ifs_his_addr,
+		rtw89_phy_read32_idx(rtwdev, ccx->ifs_his_addr2,
 				     ccx->ifs_t4_his_mask, bb->phy_idx);
 
 	env->ifs_clm_avg[0] =
@@ -8177,6 +8178,7 @@ static const struct rtw89_ccx_regs rtw89_ccx_regs_ax = {
 	.ifs_clm_ofdm_fa_mask = B_IFS_CLM_OFDM_FA_MSK,
 	.ifs_clm_cck_fa_mask = B_IFS_CLM_CCK_FA_MSK,
 	.ifs_his_addr = R_IFS_HIS,
+	.ifs_his_addr2 = R_IFS_HIS,
 	.ifs_t4_his_mask = B_IFS_T4_HIS_MSK,
 	.ifs_t3_his_mask = B_IFS_T3_HIS_MSK,
 	.ifs_t2_his_mask = B_IFS_T2_HIS_MSK,
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 8506c607de4d..f28580689626 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -416,6 +416,7 @@ struct rtw89_ccx_regs {
 	u32 ifs_clm_ofdm_fa_mask;
 	u32 ifs_clm_cck_fa_mask;
 	u32 ifs_his_addr;
+	u32 ifs_his_addr2;
 	u32 ifs_t4_his_mask;
 	u32 ifs_t3_his_mask;
 	u32 ifs_t2_his_mask;
diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index a609cd0c5268..33c28a1666d4 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -44,6 +44,7 @@ static const struct rtw89_ccx_regs rtw89_ccx_regs_be = {
 	.ifs_clm_ofdm_fa_mask = B_IFS_CLM_OFDM_FA_MSK,
 	.ifs_clm_cck_fa_mask = B_IFS_CLM_CCK_FA_MSK,
 	.ifs_his_addr = R_IFS_HIS_V1,
+	.ifs_his_addr2 = R_IFS_HIS_V1,
 	.ifs_t4_his_mask = B_IFS_T4_HIS_MSK,
 	.ifs_t3_his_mask = B_IFS_T3_HIS_MSK,
 	.ifs_t2_his_mask = B_IFS_T2_HIS_MSK,
@@ -111,6 +112,7 @@ static const struct rtw89_ccx_regs rtw89_ccx_regs_be_v1 = {
 	.ifs_clm_ofdm_fa_mask = B_IFS_CLM_OFDM_FA_MSK,
 	.ifs_clm_cck_fa_mask = B_IFS_CLM_CCK_FA_MSK,
 	.ifs_his_addr = R_IFS_T1_HIS_BE4,
+	.ifs_his_addr2 = R_IFS_T3_HIS_BE4, /* for 3/4 */
 	.ifs_t4_his_mask = B_IFS_T4_HIS_BE4,
 	.ifs_t3_his_mask = B_IFS_T3_HIS_BE4,
 	.ifs_t2_his_mask = B_IFS_T2_HIS_BE4,
-- 
2.25.1


