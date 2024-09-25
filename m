Return-Path: <linux-wireless+bounces-13159-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9D698590D
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 13:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 688871F207C0
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 11:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D01197A72;
	Wed, 25 Sep 2024 11:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6Jh++YW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6009183CA0;
	Wed, 25 Sep 2024 11:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264300; cv=none; b=dFLusFCGL9CAdEQu0jpe1otZOlzfDB5qNNWypSDs3JwCzH3quBKJTBz4gBNbbHWmAe/LFU8PssV9t/cfiXCM0b7TPRHd/DhFTzIQZL7oI/cstrOPmWApD51QfRyyTYYgBmA/5f6sIKk7JTb1CXo6q8UwdCYp0X0c21agNYDm+nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264300; c=relaxed/simple;
	bh=0YdqiPmqWJ80w4iDGHYKByNoVcDMMLR38yEVGczeIQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pe332kmZdIY4tW/DwDTaHQGPOuUaGaWds+KVmYn5ObtEpjsIT+WNkmTe2XKATHqizK8ovidh1xRcX5rxg5y0eMpwVbQpPysWE1+tLeql56yxOI6E0vRHiRHjaJnmGzmUkX2G4lOpCyE5/FMpWnSq/5knPQpLV2VTeuVjbWkCyWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6Jh++YW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE3FC4CEC3;
	Wed, 25 Sep 2024 11:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264300;
	bh=0YdqiPmqWJ80w4iDGHYKByNoVcDMMLR38yEVGczeIQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i6Jh++YWG3vlVEgedo2LoSr3BDOeBG3dGlA6NWqlPFgGVtgQmf8bMXnKvyFwgwQr4
	 IUctxBArgXYSxEyYh07kgGnkG7NFiO/DwJGe4X7UL9XwkXKq8k2F+f9HjNL2r0KkW+
	 i5DncMKlIzPuGTh29hqN6Rg6+JieZCHEt1Zi4qbhW4EBcLUuawA2lvDm/czy7UZ1Yc
	 NbKXwswwDKp+VTZNMPIKC8x1CdiTPg1rXU91D4ecMXz9fXX22JeGOuqHl4Ncnird0T
	 g18l/j9DgC5HDMBmnAzPx7TORVjVNbKRej329q6sEU5t3DcTZjOfsKeAo/53WJJEgY
	 k+uoyNXWHC29A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 047/244] wifi: rtw89: correct base HT rate mask for firmware
Date: Wed, 25 Sep 2024 07:24:28 -0400
Message-ID: <20240925113641.1297102-47-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
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
index ad11d1414874a..c038e5ca3e45a 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -353,8 +353,8 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
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


