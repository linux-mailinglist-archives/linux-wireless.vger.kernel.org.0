Return-Path: <linux-wireless+bounces-15635-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBFE9D733B
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 15:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 319EA286EBB
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 14:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1370E2194BD;
	Sun, 24 Nov 2024 13:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZpvb+3R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4422194B9;
	Sun, 24 Nov 2024 13:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456012; cv=none; b=bl2VDCQ/k987ENVJQbZupRxeNvmIsyY05CPKM8IzTvVsqDYq9GsH3T4zTXyzBk3soJaCtV9DnLsno7BOzWsVwcyd9lMlw2d7AFv87bmA23RUfKtaDPMWuU7t6CRoW20x29DPdjfTosXe79eGisSJh/kJxQzmLDumuBewl8sSKuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456012; c=relaxed/simple;
	bh=9taZCLpIdYz5+h6uTiJYfTvDsZ+QFPTJo3Ow51TU3qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vCmPNa5T0wJbk8cKJP0ChBTrr0S4t1Gh48ofn+JThbfcameMS9dU5iY/y3AMvLRcQpKOR6lgMQcsP3/HBUe3BnxC/zqUnmhZpLhIuBwMeFNuUcHCN8g9kDL3BUc4mU344uuEkpb+simDerSD4lwu8WJXzlN/84jEoAq91Qb4N/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZpvb+3R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13915C4CECC;
	Sun, 24 Nov 2024 13:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456011;
	bh=9taZCLpIdYz5+h6uTiJYfTvDsZ+QFPTJo3Ow51TU3qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AZpvb+3Rk0uFqZ/AY4MnnnyZFtimWSu3NLCnkm6BaFQ5EM8avjeDndbrP93FLY/He
	 AkuH1Xolyy0Ry4QzPnUASymVZ2X+AiHezeSxl3Wy7fzXeYSzd1A280LCgd73R3zraU
	 vaEnEWk/HprHIIoy5fP1Lx/4Iy4OfZZfvKb12twLxOD86Bws8YTv3zS+D+7EYoCffB
	 LBKwG4VsM0mFtInyOp+cAiUbDtgGNygkrXYMTYgcKCVgArySFa8DNy3VJ+PM2sWlgs
	 QKI0vBaHCWiN5y5eqlHtMFFMFqRCbRn7bj+izw2/RDdAHKSpEV1axGeLzrtdyOHElH
	 DgNJQ667ncrFA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 08/61] wifi: rtw89: check return value of ieee80211_probereq_get() for RNR
Date: Sun, 24 Nov 2024 08:44:43 -0500
Message-ID: <20241124134637.3346391-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134637.3346391-1-sashal@kernel.org>
References: <20241124134637.3346391-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit 630d5d8f2bf6b340202b6bc2c05d794bbd8e4c1c ]

The return value of ieee80211_probereq_get() might be NULL, so check it
before using to avoid NULL pointer access.

Addresses-Coverity-ID: 1529805 ("Dereference null return value")

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20240919081216.28505-2-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 468cfa43ec049..a8e2efae6e526 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -3662,6 +3662,9 @@ static int rtw89_update_6ghz_rnr_chan(struct rtw89_dev *rtwdev,
 
 		skb = ieee80211_probereq_get(rtwdev->hw, rtwvif->mac_addr,
 					     NULL, 0, req->ie_len);
+		if (!skb)
+			return -ENOMEM;
+
 		skb_put_data(skb, ies->ies[NL80211_BAND_6GHZ], ies->len[NL80211_BAND_6GHZ]);
 		skb_put_data(skb, ies->common_ies, ies->common_ie_len);
 		hdr = (struct ieee80211_hdr *)skb->data;
-- 
2.43.0


