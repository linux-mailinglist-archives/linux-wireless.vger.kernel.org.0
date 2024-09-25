Return-Path: <linux-wireless+bounces-13180-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F168985C91
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 14:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3FD283E34
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 12:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284331D12EF;
	Wed, 25 Sep 2024 11:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cw7kyl25"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B801D0DDE;
	Wed, 25 Sep 2024 11:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265590; cv=none; b=QDp+lVF55z2E/yzhws7DJqg8kE3emrKLHBOYVFOb761GtEqZ+z5wJK40ryrTLfJownRbI0jp9wACcwRmrg1ouP3VayWVioP7Fh/4DuiACenbgtKQDxAfHX7R6zFrZkMSne+6QSDvVtJqKGbvxDieO8E8LewPv7ReGyUmlxoWaCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265590; c=relaxed/simple;
	bh=CzaJvvnSnsZgaVhr1PozU568YUVcDFYZ8sDhgI8YoHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r4c4Aq117+yOV9WpjUP9KWGjiOG4oycxOMjaPE8KPMGr6LPGvVBH2BjLMDIWXC5N+J+RTmRsI1cxiZ8KBvjmXuObDZHAmULRqI/uFNzUu30FsaQuQURk+20WEcq1MlEGJKIQNSuHKn2NXdDTun92rLUhsbE7fXOMWzZiXLQOoq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cw7kyl25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B612C4CEC7;
	Wed, 25 Sep 2024 11:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265589;
	bh=CzaJvvnSnsZgaVhr1PozU568YUVcDFYZ8sDhgI8YoHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cw7kyl255Jhi/IakfKAIeF8dlPZwyOg0KZyVCp/Bdq3u37ZLkM2dyFbPIMs+8aL2K
	 Ja7AAnuO/NyYm/qujYXrLFK2ySWgmqPAv8R4Vqoi6tDhVKjbfL0d/4ZWAzABtMzhpk
	 fan7UFyyeB7izra41f0SKKjVrnq0EFPcQ6QZkMcxu5SjzHNfW5YHvyTTZ1V5ZpPGMJ
	 W9PAVR5HGZxbslrq9LGt3vpgQiZ8CWNiDAW26+NpwnkqwuCnpDW3ymP5WvkE1QgN1+
	 vkpsbpEhxnDtUdQRfNBf9BDvfDbgnXaW9rLGTftbjnb69mKJaX0RGikJmX2QstJpYE
	 ZlXGSdbn81elA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 039/197] wifi: rtw89: correct base HT rate mask for firmware
Date: Wed, 25 Sep 2024 07:50:58 -0400
Message-ID: <20240925115823.1303019-39-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit 45742881f9eee2a4daeb6008e648a460dd3742cd ]

Coverity reported that u8 rx_mask << 24 will become signed 32 bits, which
casting to unsigned 64 bits will do sign extension. For example,
putting 0x80000000 (signed 32 bits) to a u64 variable will become
0xFFFFFFFF_80000000.

The real case we meet is:
  rx_mask[0...3] = ff ff 00 00
  ra_mask = 0xffffffff_ff0ff000

After this fix:
  rx_mask[0...3] = ff ff 00 00
  ra_mask = 0x00000000_ff0ff000

Fortunately driver does bitwise-AND with incorrect ra_mask and supported
rates (1ss and 2ss rate only) afterward, so the final rate mask of
original code is still correct.

Addresses-Coverity-ID: 1504762 ("Unintended sign extension")

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20240809072012.84152-5-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/phy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index a82b4c56a6f45..f7c6b019b5be4 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -352,8 +352,8 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 		csi_mode = RTW89_RA_RPT_MODE_HT;
 		ra_mask |= ((u64)sta->deflink.ht_cap.mcs.rx_mask[3] << 48) |
 			   ((u64)sta->deflink.ht_cap.mcs.rx_mask[2] << 36) |
-			   (sta->deflink.ht_cap.mcs.rx_mask[1] << 24) |
-			   (sta->deflink.ht_cap.mcs.rx_mask[0] << 12);
+			   ((u64)sta->deflink.ht_cap.mcs.rx_mask[1] << 24) |
+			   ((u64)sta->deflink.ht_cap.mcs.rx_mask[0] << 12);
 		high_rate_masks = rtw89_ra_mask_ht_rates;
 		if (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_RX_STBC)
 			stbc_en = 1;
-- 
2.43.0


