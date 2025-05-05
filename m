Return-Path: <linux-wireless+bounces-22601-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C75AAB06A
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 05:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2231BA3473
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 03:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFDC381DE7;
	Mon,  5 May 2025 23:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvlGZcQ3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E16E2FB447;
	Mon,  5 May 2025 23:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487403; cv=none; b=M6MZBh5e//fA+58VXG9BfcCs6rIFj7VyvD1sLsFPhii2IPN35shJYnjI/+NwJmfD7xKPMeQoG/yUGpEhdukwpbeuiu5wS8cTRjsD9AbUp7bs3VAzZruFObHZ4XIbwdEyIOm1qAPBBalgASpiupVJhfAd+4KF77PfoxOOlwv/1Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487403; c=relaxed/simple;
	bh=o/1I4vX9UzgN49XtpELhG9wfJaY8gjxOzBsHERA8xkw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Se2lHV4v8HYtmCozAYzKlH/6loOfVWTTje3eTdBdtiQFX/0YGq0auXpMNvNHeaFk9yhx7+RB+qatkhcASoDxngiCf4YUTLyWTUB8X6ZmeVDZMJvLVhmUC3I7mT6L652AIrzTGuqeEtXkE4eFFanf5wIt4wO+FNdKkxsqd2q8k8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvlGZcQ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B623AC4CEEE;
	Mon,  5 May 2025 23:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487402;
	bh=o/1I4vX9UzgN49XtpELhG9wfJaY8gjxOzBsHERA8xkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jvlGZcQ3dYasN7iiTZbf2yIbDQaDTPgKDPtkjmUE44tKoALmpI564/PjMFvq+xafU
	 YkOdlzFDtBDpc/PiRuFIDDBxISC2KUiG2hDtYYxy7sOBP0u6ccifO7dzF/w+D+Z/rs
	 f/Ng6sYb1Kd2W2Ylzak+6eguVbeVuC27h8a6jYd3P0/Rp8IqFH7ZjnlB5hGBZ4G02/
	 sfIa72FfbgI/baS/5lEHVlDv+p1xqwDViRUH/c+ZakUz5lvOqC3tg67/LmRx2cjdlI
	 1Qk3k2m6SqNJiUPHEJgrBu5/HAWq4aJiy7OM/OdWV+hiBDl4lkb1e482bidkKMGYw0
	 fmSPd1+ayzZhw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 50/79] wifi: rtw88: Fix rtw_init_ht_cap() for RTL8814AU
Date: Mon,  5 May 2025 19:21:22 -0400
Message-Id: <20250505232151.2698893-50-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
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
index 15c7a6fc37b90..e4d487468c4dd 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -766,6 +766,7 @@ static void rtw_init_ht_cap(struct rtw_dev *rtwdev,
 			    struct ieee80211_sta_ht_cap *ht_cap)
 {
 	struct rtw_efuse *efuse = &rtwdev->efuse;
+	int i;
 
 	ht_cap->ht_supported = true;
 	ht_cap->cap = 0;
@@ -780,17 +781,11 @@ static void rtw_init_ht_cap(struct rtw_dev *rtwdev,
 	ht_cap->ampdu_factor = IEEE80211_HT_MAX_AMPDU_64K;
 	ht_cap->ampdu_density = IEEE80211_HT_MPDU_DENSITY_16;
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


