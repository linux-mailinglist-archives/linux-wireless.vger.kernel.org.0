Return-Path: <linux-wireless+bounces-22645-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9C1AAB535
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 07:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E08F17637B
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 05:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84063A8851;
	Tue,  6 May 2025 00:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUa9A7pA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C412F5F84;
	Mon,  5 May 2025 23:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487048; cv=none; b=qYkDx3Ynk+yRrnV0pkivpIKEwoxc9LUlAN79Tx1+axhEkdeiZ6lzwYHIykly0Tq+pWVMZcKip4V0ys5Gp1mtCYH+42A4ysG6Aj65kMpiYwle7kqkqY3GvZdO/6mppgWYvgEsmtjCTp3nL67N9c44RfaygFwbTG8kZBofN488DJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487048; c=relaxed/simple;
	bh=j5hfbKrkbWz+lyH5sXr3XwlAnquxKR9yS27cBjvRvOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VWy4N6b6J5gjaXjnfK7AY522M9mtkXojMvrLIk/tVWepUFez8zof+SqBzR1P3msrwgWEU9e1ULIkoApT6hRdOxyrXOY8veDFGFYBULaVSJYBGp5UziXId1fwpOXOAWlgEZ4bjzt0Ljd74lL4vUIk6Oi4fPwpyzSyOdkvLTmrJW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUa9A7pA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E50C4CEEF;
	Mon,  5 May 2025 23:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487048;
	bh=j5hfbKrkbWz+lyH5sXr3XwlAnquxKR9yS27cBjvRvOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YUa9A7pA8IxE6d0BR5I4MYQLqAORuUfviy4kuxt0waqx4FlH4bZ8/UTLvuq485dOW
	 XUQSj7EeKuqe1EqVG73AUtfeQYcDN5m5NRahX04ZOQ1c3+/xWcP0Z4SJPVqIsgTpEO
	 x9hxgQyw+MiR7ISSPfv2Ny+e6N/h52cmpkWm7YKPIt4OwEyLRA+ryssBQ1jKNDx89D
	 4bP/dx+/xZCE9afClo/tkYI/omBj+eVR4NHr4hjQh8ycCsYfoShvS19qkgtaHFM7Ga
	 +M2rj9ce6dL7GXcqDcceDKxTtuvNGo3qQu/J3rjkhk6h4wzVZ9oACIwN+LdDqLRE+E
	 UIyxtNs7EO7Jg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 126/153] wifi: mac80211: don't unconditionally call drv_mgd_complete_tx()
Date: Mon,  5 May 2025 19:12:53 -0400
Message-Id: <20250505231320.2695319-126-sashal@kernel.org>
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

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 1798271b3604b902d45033ec569f2bf77e94ecc2 ]

We might not have called drv_mgd_prepare_tx(), so only call
drv_mgd_complete_tx() under the same conditions.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250205110958.e091fc39a351.Ie6a3cdca070612a0aa4b3c6914ab9ed602d1f456@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mlme.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index b71d3a03032e8..11d9bce1a4390 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2336,7 +2336,8 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	if (tx)
 		ieee80211_flush_queues(local, sdata, false);
 
-	drv_mgd_complete_tx(sdata->local, sdata, &info);
+	if (tx || frame_buf)
+		drv_mgd_complete_tx(sdata->local, sdata, &info);
 
 	/* clear bssid only after building the needed mgmt frames */
 	eth_zero_addr(ifmgd->bssid);
-- 
2.39.5


