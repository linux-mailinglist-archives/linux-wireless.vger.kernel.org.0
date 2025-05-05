Return-Path: <linux-wireless+bounces-22624-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0536DAAB231
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 06:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DBE93AF9B4
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 04:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E255336EEC;
	Tue,  6 May 2025 00:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNhhd0vj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6E02D47DC;
	Mon,  5 May 2025 22:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485651; cv=none; b=d9HaBTozRow+c2p0FdUOYBWA91Oz0FYQ0BCs2eNhzAgM4dZgwDTa3r8kf21jM5G2GwiQJpPbxe0gHWVRbKrYnWluv5Ewg/qC8xmq80VJTg3qTlPJm2x706/H+7rXQ9DKa3wEUEf2WCY7vZwAAxq1Qk/n+2NXRNGmB0a0KkItYPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485651; c=relaxed/simple;
	bh=+OVEmWAUrjVR74nytPnTi+1Xo0NceBN43J6bocpMQbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jh22L99g/MBEfC/hauDG6EAzGKxP9oftXVv5gEzXfOSOE6iypKPZGUMczii2LuGPEPv41ryxXhJBIX/RpSMCyitcyw9SnNI+obpbf0JJgmNkskYhGlY8I7eMxOIN2x+suuz9NXsWKoHSudo44f0ebTuQjM2bxDcGpVAp/Sp4tv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNhhd0vj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9851C4CEED;
	Mon,  5 May 2025 22:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485651;
	bh=+OVEmWAUrjVR74nytPnTi+1Xo0NceBN43J6bocpMQbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YNhhd0vjjhRI9jaTFcSMAJaq3hwUbzkngalchXTDbXlG81IWzk7xzlqLXxgVn9s3D
	 vajXCV3YCYeD1AW+Nowl7/srA+gPdP1tc8gqsGlvx5DmJKGPtZwU6V5K0RMmJ1WdKD
	 uzJ/VnLKVswhqkFcOllphX7kgarJGc0IraTTn9eJ3GV06IkzWWbYQ7W6JejYwL7vFJ
	 L6/kyRrte9orO3/U9iXWsiVaeRMWR7O7wkN+V0Uve834FGzJFzwI2v/BV3F8bkXIMI
	 28xXAHLOx4klszFOP0KAE2fq6YHLe47wlk1pHUAbB8jkQYw5I850JGGQ3VQj0aHtX8
	 sXi6Pf+eKR3AA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ching-Te Ku <ku920601@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 407/486] wifi: rtw89: coex: Assign value over than 0 to avoid firmware timer hang
Date: Mon,  5 May 2025 18:38:03 -0400
Message-Id: <20250505223922.2682012-407-sashal@kernel.org>
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

From: Ching-Te Ku <ku920601@realtek.com>

[ Upstream commit 2e4c4717b3f6f019c71af984564b6e4d0ae8d0bd ]

If the slot duration is 0, the firmware timer will trigger timer hang at
the timer initializing state in a low rate due to hardware algorithm.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250205013233.10945-2-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 8d54d71fcf539..5f878f086f7cf 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -89,10 +89,10 @@ static const struct rtw89_btc_fbtc_slot s_def[] = {
 	[CXST_B4]	= __DEF_FBTC_SLOT(50,  0xe5555555, SLOT_MIX),
 	[CXST_LK]	= __DEF_FBTC_SLOT(20,  0xea5a5a5a, SLOT_ISO),
 	[CXST_BLK]	= __DEF_FBTC_SLOT(500, 0x55555555, SLOT_MIX),
-	[CXST_E2G]	= __DEF_FBTC_SLOT(0,   0xea5a5a5a, SLOT_MIX),
-	[CXST_E5G]	= __DEF_FBTC_SLOT(0,   0xffffffff, SLOT_ISO),
+	[CXST_E2G]	= __DEF_FBTC_SLOT(5,   0xea5a5a5a, SLOT_MIX),
+	[CXST_E5G]	= __DEF_FBTC_SLOT(5,   0xffffffff, SLOT_ISO),
 	[CXST_EBT]	= __DEF_FBTC_SLOT(5,   0xe5555555, SLOT_MIX),
-	[CXST_ENULL]	= __DEF_FBTC_SLOT(0,   0xaaaaaaaa, SLOT_ISO),
+	[CXST_ENULL]	= __DEF_FBTC_SLOT(5,   0xaaaaaaaa, SLOT_ISO),
 	[CXST_WLK]	= __DEF_FBTC_SLOT(250, 0xea5a5a5a, SLOT_MIX),
 	[CXST_W1FDD]	= __DEF_FBTC_SLOT(50,  0xffffffff, SLOT_ISO),
 	[CXST_B1FDD]	= __DEF_FBTC_SLOT(50,  0xffffdfff, SLOT_ISO),
-- 
2.39.5


