Return-Path: <linux-wireless+bounces-22593-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CABAAAFB6
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 05:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C44716B4C3
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 03:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F112A28A729;
	Mon,  5 May 2025 23:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXSZBiV4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0704390E39;
	Mon,  5 May 2025 23:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487001; cv=none; b=qIOt4uAqDnpDIpZU/WpIX+oOnXkV1ec3eAYcCAkXeqT8JH7CDBA9Nj3dUUJ29/UoLLyFxqxx1LXZU/X2nV2+lRC5TpGQJ3aD3xY11oBS7jViBFWqoc0/jIDvd1Bb9A8q7IZCXmTdced8/11LZ7mZUgL8XfGqU+bUbnsIqrBM7Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487001; c=relaxed/simple;
	bh=Rm9BFWyFQeDzYlC8j/EQLFYZtUgcUG9L5wnOfDwPJn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cqTs85pDliVsuYVqgWkPYCSqPF8CMGX90Mfx7haXY4szq9Z2xnLrD/6pdOTouAQk+iauMVTfNU5aoo6ZlUhuwYUgMgkwtXeEKqYWcGvu0MTLJBNy6u3Sj7nVV4nM+e5hbUZ8w8CECrrwQwDXy2rldkfS5KfuQJ7kjN+6Wnaf1Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXSZBiV4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE6EC4CEE4;
	Mon,  5 May 2025 23:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487000;
	bh=Rm9BFWyFQeDzYlC8j/EQLFYZtUgcUG9L5wnOfDwPJn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qXSZBiV4GuOHeve4/rNt9Wi7zWsLHqZ8/Znnrn34LbHDOl6XaGmeDE1zIKngHkuoq
	 QWwkB7Jsehq0H98I+dtw1qv0CxCit90OIwnNTpNLwSTXtnATwSb9/pt+WRPkGVavd+
	 +RCeQYwvSrD9h6L903xDTkizJc7pm5zNJMk0z7VKLeiXfF/aXnCvRz9s5oWrg6M9Jx
	 y4G+jLzgxgDMAbdUyWsoNCRQLU3ovLWNorkeBdMflERuNKNCn+qB5KsnjEbCqGoolN
	 1+xaCUKdGYMwfaIRXqEt6e5RwfSL7AyX7NQ0xUoEIulIxxP6m2a1cUarfXlz+VQW09
	 pnNiwcZeDZlEQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 101/153] wifi: rtw88: Fix rtw_desc_to_mcsrate() to handle MCS16-31
Date: Mon,  5 May 2025 19:12:28 -0400
Message-Id: <20250505231320.2695319-101-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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


