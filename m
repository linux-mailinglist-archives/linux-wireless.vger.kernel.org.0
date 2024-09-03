Return-Path: <linux-wireless+bounces-12416-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE2E96A8D4
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 22:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72BAF1C23CAB
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 20:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D891DEFF8;
	Tue,  3 Sep 2024 20:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmwUfN1n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A24E1DEFF1;
	Tue,  3 Sep 2024 20:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396180; cv=none; b=jQ/aVoVqfVfVjAsFyqqYuEObr/ukW9jim4k4FJWSJwdIRroRrIdYcSdPzUUr7SdU9eoDH6AvouISnWVQSVPQFpkO6XtUcBeKPqiwD8OkQfPOG69/YcgJhONeEKwaxlNfuYx60KsQ1PdPz0vs8dsaLqKatCOt/pk5gsn19kg2qas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396180; c=relaxed/simple;
	bh=tXAkq7HVw7ZJwdHtvDp4WV9gc9Vg8sJLrSdr6EehPG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dTLz5TomikFgRM+ny5osUFi7USh+ifY4SK0AUNKZ8IcdThTsAA/tA7wqReIb2lLb6Hz0SESb78n5ZauKxJX6qSdCWBcrJEMXTw+LSjRwFDILODQsEhtbn0CYmHr2m34l1mSm0PvB0C9y9A1Aeb1usuNQEoaiew5WRukCTElOLm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmwUfN1n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD184C4CEC4;
	Tue,  3 Sep 2024 20:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396179;
	bh=tXAkq7HVw7ZJwdHtvDp4WV9gc9Vg8sJLrSdr6EehPG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GmwUfN1ntd8YHNyh9AXjTGX1NcI63cTUoHNoSnj/4TxURX68LRLge0p10116U7txM
	 m+qYWyl2ogphuTcwHPoSev5pCYz5m2dX9/7A4qB0oJqA5Jk8TMjuICibbGOBCAhL0E
	 v6H+XujX4bZqhsAvAoizXaRM4Argh9fXJTv4Q9VF2zZg6qFHEqiRIEjc58JFtWDw7x
	 nr39CbsKP71KkloiOS4zTpsidEzC3qlmr9t6VTeiTpYsq7Opw8LVank/SGt6PvGaaB
	 lHYpR0b2jI7vDTSG59bHlivHIBupvI+VA+5kQxWpN0TwvBjuPOwhmd4Sar0kpOKaGR
	 JEUkrLelqczew==
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
Subject: [PATCH AUTOSEL 6.10 21/22] wifi: mac80211: free skb on error path in ieee80211_beacon_get_ap()
Date: Tue,  3 Sep 2024 15:22:08 -0400
Message-ID: <20240903192243.1107016-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192243.1107016-1-sashal@kernel.org>
References: <20240903192243.1107016-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.7
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
index edba4a31844fb..bca7b341dd772 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5348,8 +5348,10 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
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


