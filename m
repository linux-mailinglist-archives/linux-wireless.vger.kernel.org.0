Return-Path: <linux-wireless+bounces-17952-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B03A1CACE
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 16:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2BDA1696EC
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 15:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9242B209663;
	Sun, 26 Jan 2025 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3Jwgx8g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AEA208995;
	Sun, 26 Jan 2025 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903733; cv=none; b=TvCNFOxS0HbaBwA1/dbsRduz+u7CghcWeG4sotIkQ0G+AePEhe3Ta5BeTeO6yUcLDZGQDuonk05hXnvcK3+zB8yj0WAyFgnwrmasb9U8xz1qcdVsKycqBZDscEiSR4UJXd2vsLm8yuiYX126bYMuIJ8WJ4xe1fG/IegcUGkCDEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903733; c=relaxed/simple;
	bh=CbT2kRZkwVQV7uQSxvmnC7Msj/oYFU2uKge6dOpqOL8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f8bnu1V04J8Frs7TY07h0BSvqomdAq8cTJRjcoTayJAmVTvh1/aFVby9usUHnm1NM4jTfmS5J/AbQb6sK8JuhhRM69hgCeR0AXnNk3cVAc7XlCZHdfii1ITWW7rzffh96NiUHJZjuWXPhmOiBvalB7dNG9VZLUZ5cEnnXvicwdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3Jwgx8g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCDEC4CED3;
	Sun, 26 Jan 2025 15:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903732;
	bh=CbT2kRZkwVQV7uQSxvmnC7Msj/oYFU2uKge6dOpqOL8=;
	h=From:To:Cc:Subject:Date:From;
	b=X3Jwgx8gF58FcVc+mwdhWi9VKEOuCUdsgf3rhFu3FiuJO1TxPfAjDDNK+itcHaMEx
	 TRH2ENmyUr9whWwyUbIxSchkifw//2ymyACH/6m83Kt2oxGwD7QTO5adkyzR95zVw0
	 K6E1SwhtMpLAmuhEjpKY4OG8BqJBx6djhqrGUu9fzpZroSXtakzyZgI7bGLRriVzmr
	 sq8ET+ntZMXAdqBv+z5OS2fGsEGPCGHp7XumwQc1YmXc0yFQ6VJG7fGl+EwFYttB9q
	 gcQQWV6H/k/aga91cSAmkkMZmXsXy6RkkZEcwTrtRVerr+unVlBNbl2LBuAvg4Q+ld
	 MnnFjPQldvMYw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chih-Kang Chang <gary.chang@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 01/29] wifi: rtw89: add crystal_cap check to avoid setting as overflow value
Date: Sun, 26 Jan 2025 10:01:42 -0500
Message-Id: <20250126150210.955385-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
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
index 4b47b45f897cb..5c31639b4cade 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -3892,7 +3892,6 @@ static void rtw89_phy_cfo_set_crystal_cap(struct rtw89_dev *rtwdev,
 
 	if (!force && cfo->crystal_cap == crystal_cap)
 		return;
-	crystal_cap = clamp_t(u8, crystal_cap, 0, 127);
 	if (chip->chip_id == RTL8852A || chip->chip_id == RTL8851B) {
 		rtw89_phy_cfo_set_xcap_reg(rtwdev, true, crystal_cap);
 		rtw89_phy_cfo_set_xcap_reg(rtwdev, false, crystal_cap);
@@ -4015,7 +4014,7 @@ static void rtw89_phy_cfo_crystal_cap_adjust(struct rtw89_dev *rtwdev,
 					     s32 curr_cfo)
 {
 	struct rtw89_cfo_tracking_info *cfo = &rtwdev->cfo_tracking;
-	s8 crystal_cap = cfo->crystal_cap;
+	int crystal_cap = cfo->crystal_cap;
 	s32 cfo_abs = abs(curr_cfo);
 	int sign;
 
@@ -4036,15 +4035,17 @@ static void rtw89_phy_cfo_crystal_cap_adjust(struct rtw89_dev *rtwdev,
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
index 7e335c02ee6fb..9bb9c9c8e7a1b 100644
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


