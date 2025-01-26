Return-Path: <linux-wireless+bounces-17946-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2590A1CA54
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 16:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5521885B43
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 15:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81A9197A76;
	Sun, 26 Jan 2025 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQ7Z9eU0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B72719750B;
	Sun, 26 Jan 2025 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903635; cv=none; b=r1tkIVH8Tnj2ScSxM8qI6We977uGTKyqX1rkFIq3NzjGuSc+Dm8jM0+2O0aGaIgmfAbWo+Y0CDJG6QCr7cHP5JlNcL7wal0EmONZ43RWiBTuoy/d+352Rh6bTDjDp93Fj8agHjU6pokTTnk6qMSdsvjn8dg1hbjhwTOE6YA2u18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903635; c=relaxed/simple;
	bh=9Q0LHsfRnHoGMcVTSsJbci89bsMQEYFZftvvEgqLZn0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jFq0dOG5FelDthu3ytyOgnm7EhVwfaPI/GgvltMHbVMLc+kB5tg9RggtoeiM/9IBw1iHMqU9efKaM5EczJHCDPejcwjeL6so5tWEnwW0kL25Cy+9jXiRPyw7TY1utTw5lTF0cpWC4u+DC9mwvvVOCn62yB+6QYUv2o40VLcs98k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQ7Z9eU0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D50C4CED3;
	Sun, 26 Jan 2025 15:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903635;
	bh=9Q0LHsfRnHoGMcVTSsJbci89bsMQEYFZftvvEgqLZn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JQ7Z9eU0f+vDIrIRkelYFOZ6kT/mmme7wrVJ6F6bP+jRBCTdZJPzcIh3FYI6yf1bA
	 w0EwzMprK3xkfOq24mOBQJKhKRMRZlfBf/u7L+7+Jgskuu1pq9KkmklNZN4k6JSvSw
	 IMztKDJnKzycC0a5fu/84Sr8o1zY+NUxdJTYFgUUiM6dCUl5kJ3t/X4qGDw3MhocMx
	 ah4/lXnNFAbhAVIf6Y9bEdp8HcdbR+Ow6ORwM7ypqpd3EMdLxE/GOpJYrD8HRzC2Gs
	 zZw/SqeCzxxcHOGJL80WrhFZrkTsZI2f1/5H0s1lrtJ540BZMhQwPkcE4aTMpICX+x
	 jSkeF4NsRuEBA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chih-Kang Chang <gary.chang@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 03/35] wifi: rtw89: add crystal_cap check to avoid setting as overflow value
Date: Sun, 26 Jan 2025 09:59:57 -0500
Message-Id: <20250126150029.953021-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150029.953021-1-sashal@kernel.org>
References: <20250126150029.953021-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
Content-Transfer-Encoding: 8bit

From: Chih-Kang Chang <gary.chang@realtek.com>

[ Upstream commit 7b98caea39676561f22db58752551161bb36462b ]

In the original flow, the crystal_cap might be calculated as a negative
value and set as an overflow value. Therefore, we added a check to limit
the calculated crystal_cap value. Additionally, we shrank the crystal_cap
adjustment according to specific CFO.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20241128055433.11851-7-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/phy.c | 11 ++++++-----
 drivers/net/wireless/realtek/rtw89/phy.h |  2 +-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index f24aca663cf00..b9171f6ccae07 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -4058,7 +4058,6 @@ static void rtw89_phy_cfo_set_crystal_cap(struct rtw89_dev *rtwdev,
 
 	if (!force && cfo->crystal_cap == crystal_cap)
 		return;
-	crystal_cap = clamp_t(u8, crystal_cap, 0, 127);
 	if (chip->chip_id == RTL8852A || chip->chip_id == RTL8851B) {
 		rtw89_phy_cfo_set_xcap_reg(rtwdev, true, crystal_cap);
 		rtw89_phy_cfo_set_xcap_reg(rtwdev, false, crystal_cap);
@@ -4181,7 +4180,7 @@ static void rtw89_phy_cfo_crystal_cap_adjust(struct rtw89_dev *rtwdev,
 					     s32 curr_cfo)
 {
 	struct rtw89_cfo_tracking_info *cfo = &rtwdev->cfo_tracking;
-	s8 crystal_cap = cfo->crystal_cap;
+	int crystal_cap = cfo->crystal_cap;
 	s32 cfo_abs = abs(curr_cfo);
 	int sign;
 
@@ -4202,15 +4201,17 @@ static void rtw89_phy_cfo_crystal_cap_adjust(struct rtw89_dev *rtwdev,
 	}
 	sign = curr_cfo > 0 ? 1 : -1;
 	if (cfo_abs > CFO_TRK_STOP_TH_4)
-		crystal_cap += 7 * sign;
+		crystal_cap += 3 * sign;
 	else if (cfo_abs > CFO_TRK_STOP_TH_3)
-		crystal_cap += 5 * sign;
-	else if (cfo_abs > CFO_TRK_STOP_TH_2)
 		crystal_cap += 3 * sign;
+	else if (cfo_abs > CFO_TRK_STOP_TH_2)
+		crystal_cap += 1 * sign;
 	else if (cfo_abs > CFO_TRK_STOP_TH_1)
 		crystal_cap += 1 * sign;
 	else
 		return;
+
+	crystal_cap = clamp(crystal_cap, 0, 127);
 	rtw89_phy_cfo_set_crystal_cap(rtwdev, (u8)crystal_cap, false);
 	rtw89_debug(rtwdev, RTW89_DBG_CFO,
 		    "X_cap{Curr,Default}={0x%x,0x%x}\n",
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index c683f4d7d29b0..bc6912b3a2fba 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -57,7 +57,7 @@
 #define CFO_TRK_STOP_TH_4 (30 << 2)
 #define CFO_TRK_STOP_TH_3 (20 << 2)
 #define CFO_TRK_STOP_TH_2 (10 << 2)
-#define CFO_TRK_STOP_TH_1 (00 << 2)
+#define CFO_TRK_STOP_TH_1 (03 << 2)
 #define CFO_TRK_STOP_TH (2 << 2)
 #define CFO_SW_COMP_FINE_TUNE (2 << 2)
 #define CFO_PERIOD_CNT 15
-- 
2.39.5


