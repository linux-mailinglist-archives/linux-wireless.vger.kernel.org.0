Return-Path: <linux-wireless+bounces-22576-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEADAAAF33
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 05:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C51113B6DF6
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 03:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64267390E1A;
	Mon,  5 May 2025 23:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWrmu+PJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EF037A8BF;
	Mon,  5 May 2025 23:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486152; cv=none; b=O28c7AQqi0ReWqbLIjYJLtw4LDxGpx/sVKPuecud8Z12gQEM1C242GlCt3yBENe/C+SzCST3ypdMvuxEBilIrc2ZvQgQUvlmb5OQSYaAwy2rG0kdKBB1yNN8t5d5oCbRW18qcoECUrCNSuQ2ur6Ve1cxFIEnBzJ5dLiFVq5slXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486152; c=relaxed/simple;
	bh=LLl1aICgBdR4QRjTCYYziShIzCVf+X5RSGgDnZPmOlo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fNqGj/s9P/EaHRPpQPDPVfx4hA/nPVVA+DRZyWICvo63nEOfh8H8snS5sGp6Yb94Fi54fapJcBcB95jA9xuHlxoEratN2IsyCbrcGGZjSDCFTXQd15dNTJ6+MgQ8cBDNNpWZPqZySZJOvisap9DcS2GrAYMDAo/DWpQY4A9kz2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWrmu+PJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217CFC4CEF1;
	Mon,  5 May 2025 23:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486151;
	bh=LLl1aICgBdR4QRjTCYYziShIzCVf+X5RSGgDnZPmOlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZWrmu+PJ2akC1cHB5xvrei+Yu5uQRJlpcW4KN2mn409kjarFxFDlVLOxC0mwWKkaj
	 luQfBtIdSJFMoFfxXLcckkgbDcLt1ub/STzLZN69U3arxnVnUWsphaDMnVPx0wWHZQ
	 Ah36UC7oaDaGYj6Ou3X+TkAjfPkzOzLp606cC7sG+Rj7hhs7dFchl4rRYROwPphm/c
	 /1oIz0yFL639AWutdHTkfUeu0xiLu9mE818ISfU0hAim1ijn9zyxYEk/cY7iJM6xdI
	 JrkM3dZG5g1UCe3dAgmBv3gPi1aakNXMn+UvugEdmkQPCHM6mor8jTOlQdwuC0HBE4
	 jo8+5vUBtMmHA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 179/294] wifi: rtw88: Fix rtw_desc_to_mcsrate() to handle MCS16-31
Date: Mon,  5 May 2025 18:54:39 -0400
Message-Id: <20250505225634.2688578-179-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Bitterblue Smith <rtl8821cerfe2@gmail.com>

[ Upstream commit 86d04f8f991a0509e318fe886d5a1cf795736c7d ]

This function translates the rate number reported by the hardware into
something mac80211 can understand. It was ignoring the 3SS and 4SS HT
rates. Translate them too.

Also set *nss to 0 for the HT rates, just to make sure it's
initialised.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/d0a5a86b-4869-47f6-a5a7-01c0f987cc7f@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/util.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/util.c b/drivers/net/wireless/realtek/rtw88/util.c
index e222d3c01a77e..66819f6944055 100644
--- a/drivers/net/wireless/realtek/rtw88/util.c
+++ b/drivers/net/wireless/realtek/rtw88/util.c
@@ -101,7 +101,8 @@ void rtw_desc_to_mcsrate(u16 rate, u8 *mcs, u8 *nss)
 		*nss = 4;
 		*mcs = rate - DESC_RATEVHT4SS_MCS0;
 	} else if (rate >= DESC_RATEMCS0 &&
-		   rate <= DESC_RATEMCS15) {
+		   rate <= DESC_RATEMCS31) {
+		*nss = 0;
 		*mcs = rate - DESC_RATEMCS0;
 	}
 }
-- 
2.39.5


