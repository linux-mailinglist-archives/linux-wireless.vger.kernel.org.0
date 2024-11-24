Return-Path: <linux-wireless+bounces-15629-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0195B9D7245
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 15:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB3CC2858F1
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 14:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85DD1F7542;
	Sun, 24 Nov 2024 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LY2jdrCu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06DF1CDFBC;
	Sun, 24 Nov 2024 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455690; cv=none; b=qST3mGrcrlvM7U3MhkyeocKUYWK3/pIcq4U3jdh1zmyezj5C9POPhmwkTde5NVG8/61DrxpfhXEufpzn51/uhc6lVKVir9fYSeAL/ZBi0gkwLLsgieBN3Bw1F11jSPfrO0xuWeIa44YNrqMXtAjBXOx02LT/POKzqWYJG6T8JQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455690; c=relaxed/simple;
	bh=exnPifNKMFL2qwocsopuzvq958r8D/QZRvnmi2RFrYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Of5a3H+6fUa7s3vsEJEE60CNPwmLVyNDtu7j1mcP+BAlEuVtorIv8IUd62+fgDMzjaXrjGjJg+68eEJ+SCXarfhK0BYQiWuxVVaM0M1Wh2JE81uvrgiXJ9yD2FqvtIwUjnKjP2Z79UBq2PcE1/uftw+j7xuOdoopzgxlRczBQW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LY2jdrCu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA07EC4CED1;
	Sun, 24 Nov 2024 13:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455690;
	bh=exnPifNKMFL2qwocsopuzvq958r8D/QZRvnmi2RFrYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LY2jdrCu/Xf3nkuZzIjU0qFdVlVSaENZjWNhUcooFzywyD8fLYieANI9/faraXAvN
	 tUxEXM2XHMjUK/c2RsrG7s08B+Ht6mLFOPE36bRziC0XzihoNJoJ1MDfeErmACSXR5
	 XwlK/fsq+aRIG/KotAoOmXOSMQTqhKQ4IfcKwiiAJICGYO9rLBzB3E4+X0L/DrbaHD
	 xUEurHqwY3L5/qKpEhy45ND1z7CiYUzJm68YL8/LeGKar531KK88uKIO34Wq6goS3n
	 NBe1LuuTqMo7YYLuVhNNDotuAZKjl455byMnlQ1KNnZ3GA+xs79d2JkjV47iwFWAc5
	 Mx8079nQxPtZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 14/87] wifi: rtw89: check return value of ieee80211_probereq_get() for RNR
Date: Sun, 24 Nov 2024 08:37:52 -0500
Message-ID: <20241124134102.3344326-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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
index c322148d6daf5..20b2730a9ac11 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -5893,6 +5893,9 @@ static int rtw89_update_6ghz_rnr_chan(struct rtw89_dev *rtwdev,
 
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


