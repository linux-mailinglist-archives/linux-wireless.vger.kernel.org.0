Return-Path: <linux-wireless+bounces-12429-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8308696A93A
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 22:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42D99280617
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 20:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96D71DC189;
	Tue,  3 Sep 2024 20:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nz+7cDmk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83E71DC180;
	Tue,  3 Sep 2024 20:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396364; cv=none; b=JkjL/Z/bgO8YEGCSCH45adYZ7rH8lEkvPT0xnDKqYVezVr218e74iUoo7STKvNWWJXbteS//WiZWCl1KNhbrvSAxeKfgw1sNj3YeLNfK5g0cYl9Cupf3Q7tCIXC6lUl1xaF419seJZYdcuNwbcucV9fsTWHrNXiE6RvRmxrGmso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396364; c=relaxed/simple;
	bh=UOAgV6cqqvyA0Re+bKu1FyExngkvUIdeS1svWUweu9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxlx2JQrs1y0OwN4DRaIe95K3reqdvB0sO4ZNgzZniiHGMkeYkeuLP4ihSagpvM/tASj2pvROqqdomY2dhsDM/Yyivnvde0+QGIfTO0k24F7uevmTT/B+TR8mR9rnV0zLuoUDdSCxrtQsB+62Y/FEZOaLekDR/D75uc/GipApwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nz+7cDmk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED53C4CECB;
	Tue,  3 Sep 2024 20:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396364;
	bh=UOAgV6cqqvyA0Re+bKu1FyExngkvUIdeS1svWUweu9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nz+7cDmkBZwL0aczaSYu+sRHQNq9K9Pd9J4jMao2PkurlPRXaBsfzwd4c2HH4Va15
	 bglwI+R76eegZUVZ6Oi1qscvCu5+woTqII3krFSPODsg5lpEyEAvhKB9kVfAHbhxyp
	 apY+xgCu2el3+NIVGcEQXmaPJEbl7INS19dESgc6awtHt47EzE92N86/kj+YFC3BA3
	 B67mXpBUxMjpzTFwSiL2tmOXnJyppVab+SnCpCh0MOWcsmFT0sCE+sQNk1IY1/xlQO
	 12KFcmXzLJYwY2zQp4JH1MtCjSuq1+8E+qMuDKitnAhj5J7ddL6q6rQ1fFJAP/BmCU
	 eFGSuTZeI46aQ==
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
Subject: [PATCH AUTOSEL 6.1 16/17] wifi: mac80211: free skb on error path in ieee80211_beacon_get_ap()
Date: Tue,  3 Sep 2024 15:25:30 -0400
Message-ID: <20240903192600.1108046-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192600.1108046-1-sashal@kernel.org>
References: <20240903192600.1108046-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.107
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
index 419baf8efddea..0685ae2ea64eb 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5196,8 +5196,10 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
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


