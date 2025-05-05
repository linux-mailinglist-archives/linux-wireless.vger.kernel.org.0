Return-Path: <linux-wireless+bounces-22529-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E367AAA70F
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 02:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5943B6037
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A6D29117B;
	Mon,  5 May 2025 22:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYHPKXaV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C537932F6F7;
	Mon,  5 May 2025 22:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484538; cv=none; b=Y+48qilSGWzQkC3cL7aL6jvsPAIHynq+ehoMOCF8fduh+EK0v99KGfKXOddP9+6RwCedCgdEJPJ3d9+99FHLxCny1Gr2EZ1U0l86wlaz1w/eYV0VthUOpbVwLb8Dj4imokjO5ceepRpMFkF3CublIAzZTVE2syy2QeWxsWTXWiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484538; c=relaxed/simple;
	bh=+sQsGDO+W+FlN9vNxlSsb+JID5vYDs0PjzuBaRNv7mg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ufw+UTJA8OWLFt99Abzu64vn85PlZWt3nKODJjOXMtzrQ81xH0AKqYZ92h0AyWE+55dnLV/lnsA2JILU5Rr1yMnr/4HYfmUKUcdfSNpiZgW7Xf+92Zhgg+jAcveXSMtAqbw9Z9Tk4n9h1OKVH55gKIE2yQY9mIPM5J3kXdv2i/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYHPKXaV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FAEC4CEE4;
	Mon,  5 May 2025 22:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484538;
	bh=+sQsGDO+W+FlN9vNxlSsb+JID5vYDs0PjzuBaRNv7mg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KYHPKXaVt2J6HlFmfYRdlVWd54kelEI86RVh1NQ2wBMlXutn4j3WVyDH+wgLVT2mP
	 XWdl6wmj4syD+3/PRXaqGjsTseDGwnWOEMtBLfVUsKu46qQoy7qmsnoPOgy9MIUl29
	 LDtaZBy7RGsmFkdUdbc93398rXxqRGc/LOogwd0WDMuxnRBWDXWQKMQCm0dtvYtK0B
	 Ekr2Srdej++gUmv3dNriOiOdL9bD8vsCOVsqXYePCjietvDp+Kc/7Yub6cMys9Qj4H
	 3657xvZsn0P4Lg1STMfyEDDodTJJDmGQOIqq6jna7LDm/bdr25CPncIhDrQKj6IH+1
	 jj2nRBCseCAqg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 522/642] wifi: rtw88: Fix rtw_update_sta_info() for RTL8814AU
Date: Mon,  5 May 2025 18:12:18 -0400
Message-Id: <20250505221419.2672473-522-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Bitterblue Smith <rtl8821cerfe2@gmail.com>

[ Upstream commit 9f00e2218e15a2ea3c284567424a100c10b6fb85 ]

This function tells the firmware what rates it can use.

Put the 3SS and 4SS HT rates supported by the other station into the
rate mask.

Remove the 3SS and 4SS rates from the rate mask if the hardware only has
2 spatial streams.

And finally, select the right rate ID (a parameter for the firmware)
when the hardware has 3 spatial streams.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/48d1d90f-2aeb-4ec5-9a24-0980e10eae1e@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/main.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index f4ee4e922afa7..9b9e76eebce95 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1234,7 +1234,9 @@ void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si,
 		if (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC)
 			ldpc_en = VHT_LDPC_EN;
 	} else if (sta->deflink.ht_cap.ht_supported) {
-		ra_mask |= (sta->deflink.ht_cap.mcs.rx_mask[1] << 20) |
+		ra_mask |= ((u64)sta->deflink.ht_cap.mcs.rx_mask[3] << 36) |
+			   ((u64)sta->deflink.ht_cap.mcs.rx_mask[2] << 28) |
+			   (sta->deflink.ht_cap.mcs.rx_mask[1] << 20) |
 			   (sta->deflink.ht_cap.mcs.rx_mask[0] << 12);
 		if (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_RX_STBC)
 			stbc_en = HT_STBC_EN;
@@ -1244,6 +1246,9 @@ void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si,
 
 	if (efuse->hw_cap.nss == 1 || rtwdev->hal.txrx_1ss)
 		ra_mask &= RA_MASK_VHT_RATES_1SS | RA_MASK_HT_RATES_1SS;
+	else if (efuse->hw_cap.nss == 2)
+		ra_mask &= RA_MASK_VHT_RATES_2SS | RA_MASK_HT_RATES_2SS |
+			   RA_MASK_VHT_RATES_1SS | RA_MASK_HT_RATES_1SS;
 
 	if (hal->current_band_type == RTW_BAND_5G) {
 		ra_mask |= (u64)sta->deflink.supp_rates[NL80211_BAND_5GHZ] << 4;
@@ -1302,10 +1307,9 @@ void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si,
 		break;
 	}
 
-	if (sta->deflink.vht_cap.vht_supported && ra_mask & 0xffc00000)
-		tx_num = 2;
-	else if (sta->deflink.ht_cap.ht_supported && ra_mask & 0xfff00000)
-		tx_num = 2;
+	if (sta->deflink.vht_cap.vht_supported ||
+	    sta->deflink.ht_cap.ht_supported)
+		tx_num = efuse->hw_cap.nss;
 
 	rate_id = get_rate_id(wireless_set, bw_mode, tx_num);
 
-- 
2.39.5


