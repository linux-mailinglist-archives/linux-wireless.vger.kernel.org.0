Return-Path: <linux-wireless+bounces-22584-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F444AAAC04
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 04:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D6EA7AE51A
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 02:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35D72FB2DD;
	Mon,  5 May 2025 23:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXlP7ia4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648192EEBE8;
	Mon,  5 May 2025 23:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486653; cv=none; b=VpxzCwJDe2hiwbeqZq2n2f9x1pUr1bhd3fzHoQ0VB3frda01wvzcNJpCNBXU/JkZSxDeMPjFOZaC02F1Gfuw7rSRTNJ5UoGAhh/X1w+84ybDT0csN/JcV7F8q+ceUPXvjjSxBBZi7tYQUjrig9lO3vypjo1+mQyVwrNIvG74duo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486653; c=relaxed/simple;
	bh=ZPvURcwaSiFBMK3SP2mQmJKFa1Fo/lCFtxMb9GxG5XE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uoOjaff+pU97Ee3fjoH+9GX4+k2ckJVLaFUK5DmH4p4nL8MAYNhE29Fs/HmUJ0zpr0VrT+Ny1GEfa2XCZx4a7CRFlVFyMureMYvb4iLlK1HWOpbI3gol8Y/F0Ur58WUkzUTbVB0h1R0wTajLvqdyNPooJVg5HpbYb0yDFNqNl1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXlP7ia4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876EBC4CEE4;
	Mon,  5 May 2025 23:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486653;
	bh=ZPvURcwaSiFBMK3SP2mQmJKFa1Fo/lCFtxMb9GxG5XE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iXlP7ia4Qbxc3dLwgM7MVdEsFc0Q0LeksJMEdvrhANzUdqQJ+kPcMZwKZzAg9VtLT
	 5/rntfvWLFkxWsJBHdg6ZIrhyDT7vdXBe+jWi/9dz+hdSrTjusoBTrmMdDLD8fxtT0
	 XB3r8JWwlYhwsEMNeziRxnRQw8OBRkQBurJOub93FPq3ngEbY2eODNzKckNkhQrukO
	 tcj5BD5Sbs6eQAXcY5BFgX8uua51RuJblEf7okmC7To7CFER06vL+FEkIOP/NIkyuX
	 /LebWv7y/CQ2Tvs70R/X5Q36QOInzWiPPuePsEiZTcWgCkPfxftd/dL3m8vuVF+21k
	 31Uhjz4hBvHqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 138/212] wifi: rtw88: Fix rtw_desc_to_mcsrate() to handle MCS16-31
Date: Mon,  5 May 2025 19:05:10 -0400
Message-Id: <20250505230624.2692522-138-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index cdfd66a85075a..43cd06aa39b13 100644
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


