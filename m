Return-Path: <linux-wireless+bounces-22510-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F7FAAA537
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 01:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A10E1889AEB
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 23:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0545E30C1EA;
	Mon,  5 May 2025 22:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="allto3JF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0EB30C1E5;
	Mon,  5 May 2025 22:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484135; cv=none; b=TlVa6hS4aRv1qaUPgzDhKH/9VSzg5h4oEiNYkzwy54sTTIvIemJZkgln8aSqSIlOcbmIVymbqg/lkCQtOT1Rf8glvgiY3CNaU8ZZnqbuTLMZymNEwuuPGnrHx0dGnte7KnCwFLauuEkrOL0X2CZSFWPvj+irAq4BLCg0UeUV3nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484135; c=relaxed/simple;
	bh=BBSWCM9cqdgyZp9nUSlQZd0hy3ZOfkNYfbdYzgDbhiA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jjNmQzodn51ZWgPneqvAIjKn7eOYLTZlyKNo43pttA+dP7kmriMWt6yeTpT4+zN/8732hv9cBabfNikd04pvWayTeNiAA0KHs51iN6pcJZ2NLHg3x+70GWGJZPvZTy4FgLTehhAvL58oMdgxGS0JwzAHyFM7F81v6sv4oN5mlXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=allto3JF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B36C4CEEF;
	Mon,  5 May 2025 22:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484135;
	bh=BBSWCM9cqdgyZp9nUSlQZd0hy3ZOfkNYfbdYzgDbhiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=allto3JFHRA1UC8eC+gaBOVjNYH+3hm6PD+FVUSNMW7Ap8roPB2HwuR04BV0dX+x5
	 oXnh+M4XuyzO6jDe/1EZ77M88zxm7TYArEUTHVURRnn9ti75Rk89MbPLnjs3bh7+F3
	 p54YKJ7TARo84PwcX4KSPPwLbFTYr4fB54KGGwjAWMlpA7PwC7vPl5RsFSZ1P+i+k+
	 5P6jH1ogsgwWgndLf+W+EsQ16THIYe66LjDnamlKR0aYGkI8AvEW+1izXGsc+oph7x
	 CfftoG8hQ9nKxhgOMEWmz6R+yIaRlw7rYEDQZ5EjlirwQNkRUtnL4J2uIsJUG4A8i2
	 XNbmKl7xpAl8g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 365/642] wifi: rtw88: Fix rtw_init_ht_cap() for RTL8814AU
Date: Mon,  5 May 2025 18:09:41 -0400
Message-Id: <20250505221419.2672473-365-sashal@kernel.org>
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

[ Upstream commit c7eea1ba05ca5b0dbf77a27cf2e1e6e2fb3c0043 ]

Set the RX mask and the highest RX rate according to the number of
spatial streams the chip can receive. For RTL8814AU that is 3.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/4e786f50-ed1c-4387-8b28-e6ff00e35e81@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/main.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index d66abb31f091b..f4ee4e922afa7 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1561,6 +1561,7 @@ static void rtw_init_ht_cap(struct rtw_dev *rtwdev,
 {
 	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
+	int i;
 
 	ht_cap->ht_supported = true;
 	ht_cap->cap = 0;
@@ -1580,17 +1581,11 @@ static void rtw_init_ht_cap(struct rtw_dev *rtwdev,
 	ht_cap->ampdu_factor = IEEE80211_HT_MAX_AMPDU_64K;
 	ht_cap->ampdu_density = chip->ampdu_density;
 	ht_cap->mcs.tx_params = IEEE80211_HT_MCS_TX_DEFINED;
-	if (efuse->hw_cap.nss > 1) {
-		ht_cap->mcs.rx_mask[0] = 0xFF;
-		ht_cap->mcs.rx_mask[1] = 0xFF;
-		ht_cap->mcs.rx_mask[4] = 0x01;
-		ht_cap->mcs.rx_highest = cpu_to_le16(300);
-	} else {
-		ht_cap->mcs.rx_mask[0] = 0xFF;
-		ht_cap->mcs.rx_mask[1] = 0x00;
-		ht_cap->mcs.rx_mask[4] = 0x01;
-		ht_cap->mcs.rx_highest = cpu_to_le16(150);
-	}
+
+	for (i = 0; i < efuse->hw_cap.nss; i++)
+		ht_cap->mcs.rx_mask[i] = 0xFF;
+	ht_cap->mcs.rx_mask[4] = 0x01;
+	ht_cap->mcs.rx_highest = cpu_to_le16(150 * efuse->hw_cap.nss);
 }
 
 static void rtw_init_vht_cap(struct rtw_dev *rtwdev,
-- 
2.39.5


