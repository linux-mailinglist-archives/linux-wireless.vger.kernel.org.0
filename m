Return-Path: <linux-wireless+bounces-22597-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9E7AAAFF4
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 05:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDA0D188B66F
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 03:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3008D305748;
	Mon,  5 May 2025 23:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rg6v+y6M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890E63B17C3;
	Mon,  5 May 2025 23:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487239; cv=none; b=hgLOiI4IxZrx8IXcOaItAkRDJ6LGGdgwq1BA2WniTof4Y7JHE8OeF/pebxa8mD4CeiKYyhreDV+/iI4lcnzQ9Ij2t7MMGrSb7wgiyoU/SLv058NRSKXq1cJAxSuMomS+7+BoZTSD9jawRpbDe6x6kM/qmRRnUM2zsAtbAw8I/jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487239; c=relaxed/simple;
	bh=Rm9BFWyFQeDzYlC8j/EQLFYZtUgcUG9L5wnOfDwPJn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jI/Br2Dyd+Qqblz4ZoaRrzjMdp0p7JDKGWhEdgFGdEiiuEBBycgSZUkCulOgZXIUbLIXjhbDEDklYb5gYLJWeEuEkuWWTkho3mohbq3X35a6SPYu/uwGjbLwEZBheqMW9+oi4CWk2bA9WYc8yYztswrNab57P0NVH8xme+/0hjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rg6v+y6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF52C4CEEF;
	Mon,  5 May 2025 23:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487239;
	bh=Rm9BFWyFQeDzYlC8j/EQLFYZtUgcUG9L5wnOfDwPJn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rg6v+y6M6hsGtjTZywkDef9K1sU34dnXXaBwm6M3I6ecyaQWd3O0jAD1iqiWwi/3J
	 NW4d/e6CvZ/EIA5/n+SYYUZwSABV6TfuHQIX7EUOAvNPFVCAIeN7z+MNdRuxoeoLat
	 lnzK+LweMveGAx09FfnYiJGO8sgG3rfj/+dYs8cmIoMJRHzdXC2u2yIOhEdqazOLb7
	 GXmqxwnEaE8AspgNHExkSIJ8l+Ego5F7Vzoqfncx0a9fdYC7Y8by12DXi2Ef2pqxw6
	 EAUjuobfe6q7kq0sGF5uKVlmq6yGzwbeAgYlVYzh8hiAU3mQ7sLHp/cmD2wa7JdprL
	 /xZ6Q7rhw3VpQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 074/114] wifi: rtw88: Fix rtw_desc_to_mcsrate() to handle MCS16-31
Date: Mon,  5 May 2025 19:17:37 -0400
Message-Id: <20250505231817.2697367-74-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
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
index 2c515af214e76..bfd017d53fef8 100644
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


