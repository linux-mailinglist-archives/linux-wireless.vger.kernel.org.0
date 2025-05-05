Return-Path: <linux-wireless+bounces-22516-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1C9AAA548
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 01:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E100D18909DC
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 23:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3D828ECF0;
	Mon,  5 May 2025 22:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3p1zymh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6088F28ECEB;
	Mon,  5 May 2025 22:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484142; cv=none; b=pu5QmoI3rPPXf2l3ce5zPxbjBBgIw4tQm4v5huyFFNPueQgbHyhlc93D8Mzvv92/OK0TppwhKoAP6almWUGS6e083Y8wyw3WOHlQ6z3bHZ3PpDbgzBDO9CmGg0G1ox3hoqprlzP3E1DaW0mDgm46ybFOGFxtWqdNGZjtkriyZl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484142; c=relaxed/simple;
	bh=MpnvaMfmUll/cXR7chh9TL1KoPzekCWeN3KWRSj8w0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XVtXPqrZD3rlN1SmF0HI8OI4KK4dr1KAjKV6S7Esb0qtTXjXkxcv6xy8Tb6/sgl9vvJIVR/pPNhL9nUIN4GG2Y5VZBhDlVjOk4fsP6DT0RakDfMeupsu88YFDLsA9SxhT4akbbcc9Cv1dYUcmzuUWPVCnFZr+PfSt1L1ABZHJn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3p1zymh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D44AC4CEEE;
	Mon,  5 May 2025 22:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484141;
	bh=MpnvaMfmUll/cXR7chh9TL1KoPzekCWeN3KWRSj8w0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V3p1zymhy8JOa4eJ0svkDuiGmd6W1btU6L05JbE1su/+k2nFEJgswXyAr8AkAohkJ
	 xp8HK7nheN98j/9fFgVIRsLjOaAjwahjd892gw3OdgZMahtK4AXR27XRAU5lN8D7vr
	 tbcvA4d0uUik498gclZ7LP7rGh9/AuYpEAwcfv7lHQZETSs31v/Ylr0J+Qlvov1uWP
	 3xdhCfiUccwAnhlawbZCv3txrnvkuFlG0E4WGrgyIDl1CFrB9GQkTUt8EFUhb74BY6
	 0qvk05i4WXJNL+6+wGKlZ8cpE0hId7zEgLfPDxvl0YkfaOHZa5WakDO5s7YlXlENW/
	 +/fPx/woOZqEA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuan-Chung Chen <damon.chen@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 371/642] wifi: rtw89: 8922a: fix incorrect STA-ID in EHT MU PPDU
Date: Mon,  5 May 2025 18:09:47 -0400
Message-Id: <20250505221419.2672473-371-sashal@kernel.org>
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

From: Kuan-Chung Chen <damon.chen@realtek.com>

[ Upstream commit bdce0574243b43b3bb2064f609c0c326df44c4c6 ]

EHT MU PPDU contains user field of EHT-SIG field with STA-ID that
must match AID subfield in the Associate Response. Add a necessary
setting to prevent these from being inconsistent.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250217061235.32031-1-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 92e6bc05cbf66..f4b3438615541 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -3329,9 +3329,10 @@ int rtw89_fw_h2c_assoc_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 			      CCTLINFO_G7_W5_NOMINAL_PKT_PADDING3 |
 			      CCTLINFO_G7_W5_NOMINAL_PKT_PADDING4);
 
-	h2c->w6 = le32_encode_bits(vif->type == NL80211_IFTYPE_STATION ? 1 : 0,
+	h2c->w6 = le32_encode_bits(vif->cfg.aid, CCTLINFO_G7_W6_AID12_PAID) |
+		  le32_encode_bits(vif->type == NL80211_IFTYPE_STATION ? 1 : 0,
 				   CCTLINFO_G7_W6_ULDL);
-	h2c->m6 = cpu_to_le32(CCTLINFO_G7_W6_ULDL);
+	h2c->m6 = cpu_to_le32(CCTLINFO_G7_W6_AID12_PAID | CCTLINFO_G7_W6_ULDL);
 
 	if (rtwsta_link) {
 		h2c->w8 = le32_encode_bits(link_sta->he_cap.has_he,
-- 
2.39.5


