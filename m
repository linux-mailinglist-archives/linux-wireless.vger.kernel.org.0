Return-Path: <linux-wireless+bounces-22511-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6C9AAA53B
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 01:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9A2188B2F4
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 23:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1505228BA81;
	Mon,  5 May 2025 22:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7DD7D3N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF12828B51B;
	Mon,  5 May 2025 22:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484137; cv=none; b=sY8hjFawfm5pX+1jYaZwQKzK5aPXP+x6hZhD2BtLXJI3ctYIZltEi6f6IuYcAFWKXffDlQFbwBJdnir9Vmgb0lUO30engn0XD4oJpehUOkYSdtMZS93vanRfBfY31sywYKV+VKsKLqEKsnn98jwkx7Klvfzn3wVHWR2bc3TrgE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484137; c=relaxed/simple;
	bh=LLl1aICgBdR4QRjTCYYziShIzCVf+X5RSGgDnZPmOlo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sKpgyA3AUVN0fPJ4KZ+/Bk5M57iJgLmFrQCc21sHR1caHFX8kEm/hY125jQdfJNv94LEsXIQjmt5TXn27azKOmmi55F45dqMxlQVci9CbbFTQriRrMTo7UGXeGOzhyJP2LzT4pYGItD/qiOOilUy7Vqjt01pcBqFjh1XhOcN9JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7DD7D3N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D72DC4CEEE;
	Mon,  5 May 2025 22:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484136;
	bh=LLl1aICgBdR4QRjTCYYziShIzCVf+X5RSGgDnZPmOlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T7DD7D3Nfns5wSa3wRW/oV/p7/KGwA0gRBeYJ+bMEluDC5OzygnnU3kn121xL4eip
	 v6PJAthqv2jBmLVJgz3BPXLdQhPtHYztwiOTJKC22dxACXAeGUi3opiKY8FmoL5STU
	 5iOxFg3l/YLEi5d7yYXU0WlRfvrP0MZ/WHsAN1pRAfSmYlwC1S2m4t68n2/HUgHJdI
	 YF4/JUjTGTCoNoTWDUjAdMfXcCr0b0rvnEV4HdB8FgGoibx4vs03AcqpgXBo6DZVn2
	 Rtx+/dvCFb4QbIo213U/bN9+CX1gT6hdGzJtv06KyMqn1bo6jB1gOovlhgxRQ96TkF
	 vUHg5kTwIwpkA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 366/642] wifi: rtw88: Fix rtw_desc_to_mcsrate() to handle MCS16-31
Date: Mon,  5 May 2025 18:09:42 -0400
Message-Id: <20250505221419.2672473-366-sashal@kernel.org>
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


