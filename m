Return-Path: <linux-wireless+bounces-22611-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FC5AAB10E
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 05:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E154A29BB
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 03:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDAB33054D;
	Tue,  6 May 2025 00:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPntlto2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A911B2D610F;
	Mon,  5 May 2025 22:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485358; cv=none; b=JdY/6VkQXfHoy2rqU9tlqUTTRLqv8F47LvGfCNw8Fyqb/GMJSVu2bGTOiutExSa0BytKf6h061yth/vehm4ZPFTRdTPDkBcMumr6pMNCczNJGBZ/o5Dm1Xg/+3RWseqzeuVPbGH7bkcJ/iNZhw2CxW38VtrGwlkq8sDiEsXl4Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485358; c=relaxed/simple;
	bh=LLl1aICgBdR4QRjTCYYziShIzCVf+X5RSGgDnZPmOlo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TCZU/KqrwK8n2mr5JedLMqOC4S8UA8U5aJbYi8QdgdmvlZNZ0uP1wy2y6+dLRhCAIsmWA5KeEop6XMN979C/WiM3cIvxuj3SfLo0TKbPQeLyL9NgkQz+m71LKlOaSf+bmnLSOKgIaQ3ZMmis9I0Z3hvPISMDipoyXkuRHyHmIPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPntlto2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21F3C4CEED;
	Mon,  5 May 2025 22:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485358;
	bh=LLl1aICgBdR4QRjTCYYziShIzCVf+X5RSGgDnZPmOlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TPntlto25k18WR4Le616sGGj9y8zoAAozqxsE3T1YpRZ0ve6dSVU56x+nvScIJScE
	 WkKOED/KNQRchFKuD4zhSost2VazP5tA6lK/vKu47TTT3JN9nKQDm6OazSq1IAJ5+4
	 5LsDQCPim64BGCT0oUKDQM50PIog6ufpX+Tm0MohrG+QpBccRSlbyhrNrt6bB1pKoY
	 J3Zfmhsvfv6K4W5UCjhhl7pUJqHZvm1+0Bn8gydKeLoRhtqqHgbQsghjYcvfGzJO8+
	 BuYoaA2qfLvhNUT4opKa7cy1auiyDq5fnJwliMAYpyJp2R8ReaF1uzo9tClvqhHWra
	 QQrPHPpWaBGDg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 286/486] wifi: rtw88: Fix rtw_desc_to_mcsrate() to handle MCS16-31
Date: Mon,  5 May 2025 18:36:02 -0400
Message-Id: <20250505223922.2682012-286-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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


