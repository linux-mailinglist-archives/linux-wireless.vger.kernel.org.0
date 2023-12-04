Return-Path: <linux-wireless+bounces-348-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A221802C0F
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 08:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C75E1F2106C
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 07:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3076C9449;
	Mon,  4 Dec 2023 07:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8nfxDmR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1019F186C
	for <linux-wireless@vger.kernel.org>; Mon,  4 Dec 2023 07:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFE3C433C7;
	Mon,  4 Dec 2023 07:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701675026;
	bh=UXHIbSEXNeT4NOlOwMLwRYUsh1rg0DBD7QbaAh9KxAU=;
	h=From:To:Cc:Subject:Date:From;
	b=W8nfxDmRpeEwPLmtg/wG9eP4VA9cp8hQ+6hIXWHSf+UPEzlsebyFvHC6QAwvxwJR8
	 9iToyOU65x9LDh4uXJooLpqDAgyga7w/tDHVFE48tYOGJ2f6WsM8oOVICgtbZjTnCI
	 fD3Cr5KQQmyBfype4t5lvNALAWm//Y51o38ID/zyfKev9PkYszdbeY2Z5ahmVRsOLX
	 bdmX+EqMY1ucCVmZdJ+jpf3G10J3BZ33xO2irE9uJKQ2WtO50JekjfTlSFeTFr73gT
	 V0favpOb0zVMtJvazYS7dJYg1v/W2r6HklbCBj3R1pa2Fn25Q3kuapp1ULz3qk2lrJ
	 UXpSDWJolgPoA==
From: Arnd Bergmann <arnd@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Ching-Te Ku <ku920601@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rtw89: avoid stringop-overflow warning
Date: Mon,  4 Dec 2023 08:30:13 +0100
Message-Id: <20231204073020.1105416-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

After -Wstringop-overflow got enabled, the rtw89 driver produced
two odd warnings with gcc-13:

drivers/net/wireless/realtek/rtw89/coex.c: In function 'rtw89_btc_ntfy_scan_start':
drivers/net/wireless/realtek/rtw89/coex.c:5362:50: error: writing 1 byte into a region of size 0 [-Werror=stringop-overflow=]
 5362 |                 wl->dbcc_info.scan_band[phy_idx] = band;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
In file included from drivers/net/wireless/realtek/rtw89/coex.h:8,
                 from drivers/net/wireless/realtek/rtw89/coex.c:5:
drivers/net/wireless/realtek/rtw89/core.h:1441:12: note: at offset [64, 255] into destination object 'scan_band' of size 2
 1441 |         u8 scan_band[RTW89_PHY_MAX]; /* scan band in  each phy */
      |            ^~~~~~~~~
drivers/net/wireless/realtek/rtw89/coex.c: In function 'rtw89_btc_ntfy_switch_band':
drivers/net/wireless/realtek/rtw89/coex.c:5406:50: error: writing 1 byte into a region of size 0 [-Werror=stringop-overflow=]
 5406 |                 wl->dbcc_info.scan_band[phy_idx] = band;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
drivers/net/wireless/realtek/rtw89/core.h:1441:12: note: at offset [64, 255] into destination object 'scan_band' of size 2
 1441 |         u8 scan_band[RTW89_PHY_MAX]; /* scan band in  each phy */
      |            ^~~~~~~~~

I don't know what happened here, but adding an explicit range check
shuts up the output.

Fixes: 89741e7e42f6 ("Makefile: Enable -Wstringop-overflow globally")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index b842cd9a86f8..9c0db35d3e13 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -5352,6 +5352,10 @@ void rtw89_btc_ntfy_scan_start(struct rtw89_dev *rtwdev, u8 phy_idx, u8 band)
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
 		    "[BTC], %s(): phy_idx=%d, band=%d\n",
 		    __func__, phy_idx, band);
+
+	if (phy_idx >= RTW89_PHY_MAX)
+		return;
+
 	btc->dm.cnt_notify[BTC_NCNT_SCAN_START]++;
 	wl->status.map.scan = true;
 	wl->scan_info.band[phy_idx] = band;
@@ -5396,6 +5400,10 @@ void rtw89_btc_ntfy_switch_band(struct rtw89_dev *rtwdev, u8 phy_idx, u8 band)
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
 		    "[BTC], %s(): phy_idx=%d, band=%d\n",
 		    __func__, phy_idx, band);
+
+	if (phy_idx >= RTW89_PHY_MAX)
+		return;
+
 	btc->dm.cnt_notify[BTC_NCNT_SWITCH_BAND]++;
 
 	wl->scan_info.band[phy_idx] = band;
-- 
2.39.2


