Return-Path: <linux-wireless+bounces-12423-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B83F96A90C
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 22:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF721C214D8
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 20:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED791D88D7;
	Tue,  3 Sep 2024 20:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgp1K916"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32E01E2CE3;
	Tue,  3 Sep 2024 20:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396278; cv=none; b=tjq4tH6JF0bmCUgIT8gyKPs7a6J0xKvh6h2t/fjNm+QuThc41JDzx0GboV2JHiu6J8fe+C3vOiFAW4ZlChob+LgHEMocAzwrxqJ5Qj832SSFO3Mxh4skwlc3oTNDSSVn7WMeCI6xLvrBilZNLKZrIgwePjGyG303zoOG3ecVt+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396278; c=relaxed/simple;
	bh=Wj1iXs6w6GGC0ngNMNkpx0MMOmi/Z+zlA8R3U2RRlYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFMJt1jXLYsR3X1GHfm4wpATLrH6V1E/93JH0eSbIXDeJ45BmnCrAtuhcVMvTzsCs8hpeSkxOznBPob3/F0Ed8W0f7m9snonlOZdnIZ18AGPza3mstcrpIepi/utnCoxcya5XrO68XZogoLzezCHendluzZ605SdT+XkuarOZYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgp1K916; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37768C4CEC4;
	Tue,  3 Sep 2024 20:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396278;
	bh=Wj1iXs6w6GGC0ngNMNkpx0MMOmi/Z+zlA8R3U2RRlYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fgp1K916j6mQZcn3TrA+kmOAXSaPGzVmBrIOrXP1KdaqextefUpgN4bAzw/TUkJl9
	 2Zct7AqOMbqucbZJs5f+MO4NWhRNzvPT/yw3kLR7gq1Baii7CthpeK/DXFQlUvQTxs
	 N2WKunyo97+3r1zQ+ykKRZzNnlsccAZGld4S813Cdyr9u2qXHb7W9oMa+BYUjXb1yM
	 i2l7X3JG7BvILjx0dG/LLXxwIg5gS0xWY9bwgFJ2+e/DcM3C/IVFoQZshbqZuuiP98
	 GDt+uzJx4c3VR3OVB9yWO3adt2skXKiBP4TAp9IZFliFwXqqrVT8Bn50265K8Gplx8
	 4/GHX+Qua6Jbg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 19/20] wifi: mac80211: free skb on error path in ieee80211_beacon_get_ap()
Date: Tue,  3 Sep 2024 15:23:51 -0400
Message-ID: <20240903192425.1107562-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192425.1107562-1-sashal@kernel.org>
References: <20240903192425.1107562-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.48
Content-Transfer-Encoding: 8bit

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit 786c5be9ac29a39b6f37f1fdd2ea59d0fe35d525 ]

In 'ieee80211_beacon_get_ap()', free allocated skb in case of error
returned by 'ieee80211_beacon_protect()'. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Link: https://patch.msgid.link/20240805142035.227847-1-dmantipov@yandex.ru
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/tx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 46b02a6ae0a36..415e951e4138a 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5311,8 +5311,10 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 	if (beacon->tail)
 		skb_put_data(skb, beacon->tail, beacon->tail_len);
 
-	if (ieee80211_beacon_protect(skb, local, sdata, link) < 0)
+	if (ieee80211_beacon_protect(skb, local, sdata, link) < 0) {
+		dev_kfree_skb(skb);
 		return NULL;
+	}
 
 	ieee80211_beacon_get_finish(hw, vif, link, offs, beacon, skb,
 				    chanctx_conf, csa_off_base);
-- 
2.43.0


