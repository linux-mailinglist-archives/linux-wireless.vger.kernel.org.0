Return-Path: <linux-wireless+bounces-22533-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B96AAAA6EA
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 02:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FEAB18867F3
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2798B330528;
	Mon,  5 May 2025 22:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctxzQqdt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F254C27BF9B;
	Mon,  5 May 2025 22:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484544; cv=none; b=ofckN6jQ8fG4rlsk4RQVDd0Pu8oqf4dkEWXAuMwdFaPgzSoX7fvIKkrPfLTbhhhlEccswRacRyP641vudV7R0w0mcg/nfiW2V6kLNXxTpeRvlgIcqh1ZfNsB3RYYGS5F6EhcGvqBVEjwalQ+YyZs1/eD8GTRjPmzfo8mqeHlDCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484544; c=relaxed/simple;
	bh=SXzfBkPzTlsUYBqOKVEAba0Zcf2JkGjWUbI4rmLDc/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LbWWT/3iXALEuSXwHl1Yn4lrFhzuiD9UGeda4xJd6e+aGwMjKdAsMUxuJO+bKzvh4rsP6fAxejNRDUPdBJD5tnGcZsQv65yPx+nfUv+JPkgC4VxSiWxK0XuK+ZoLqnc0lf3OIw9p15sAwM5Zj8ql3Nb21EWtIJTN3Z0CKmqP5r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctxzQqdt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C88C4CEEF;
	Mon,  5 May 2025 22:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484543;
	bh=SXzfBkPzTlsUYBqOKVEAba0Zcf2JkGjWUbI4rmLDc/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ctxzQqdteLWzPWgTAZVFIwuj3Ilwfha8W3g56gJEW7TOuFehYKYsK7GLxbfkt+t2a
	 luqF1Ry/71D/1Vq+ELevtHKlsirTc3/0D0IdrHS1xE00Hx9UfF1iho1K88MufIQhE4
	 hF2uta6D0Ud0ViUHEVdTe1PNxVJASP/tPK4+eBm6dda0VYAlh+J4Gr7wOv+Bcdc6np
	 iHUufJBwq48swDKd763xdxNU/A6dKNwNWt13Yt9jpXFrCwdAjtxWGJTcMtmkttX5NR
	 0GG2i85+DZBYjcKO17nHUyF0dY/KuklN4cHlkuOL3Js1FFK/MDEARxPT3TqKkoviq1
	 Qwe63Jcy9KQvA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ching-Te Ku <ku920601@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 526/642] wifi: rtw89: coex: Assign value over than 0 to avoid firmware timer hang
Date: Mon,  5 May 2025 18:12:22 -0400
Message-Id: <20250505221419.2672473-526-sashal@kernel.org>
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
index 9e06cc36a75e2..d94a028555e20 100644
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


