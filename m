Return-Path: <linux-wireless+bounces-25613-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB069B091F9
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 18:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4781E7BD233
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 16:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01347202F87;
	Thu, 17 Jul 2025 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="F76PVhdn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB9A2FCE29
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 16:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752770118; cv=none; b=ufOgac+iE8ldrtwpy6/b0z2QGGfmbg4EcsSR/Kb+CbrotZWj8LHh3Y+ZXBp6PoXWabdgH+J/ko5prhWvjPLn7bubmjU4wbJ7WMJKhMPMwBZuefRRrOs01lbdTbqHJDXZ/2Ea0JxEPVSHyJLjgQ1wOnZPYLM5XuaxKziBumwldHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752770118; c=relaxed/simple;
	bh=x2oJkiVfU3fih0Feg3fstILCJB1rOdVto8Aad5KcGVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sKK4wGHdkB0h3ZgFXTq4nEMLYl+a14L8QGaTL+hE7uFu+akRcR2lauvJbU1M+EifIlrlBeF8tsT99uzUAPWsXFdXK10ihRG/G+0F+wWvD+3MDvL8MA7H0OPjB4UiMcu9RwP+To2WCAe423kmW946N6GaLJHNb81+ksQSHUuNmv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=F76PVhdn; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1752769689;
	bh=x2oJkiVfU3fih0Feg3fstILCJB1rOdVto8Aad5KcGVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F76PVhdnq3frcQLpWGCGioMOpzaHmhNlr6AtLy1efAeDQK5kwFTwybXHHfr7364WI
	 eVghRCY1L5XD4uNy+3TyyB4ht5SWZpMrtdB5a378ek5ePMZSuzPTHGJodU1p4+mUS8
	 IhgcbradTmuabikZ0H3vAijfPthAgY21iWMdG7w0=
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Alexander Wetzel <Alexander@wetzel-home.de>
Subject: [PATCH wireless] wifi: mac80211: Don't call fq_flow_idx() for management frames
Date: Thu, 17 Jul 2025 18:25:47 +0200
Message-ID: <20250717162547.94582-3-Alexander@wetzel-home.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250717162547.94582-1-Alexander@wetzel-home.de>
References: <20250717162547.94582-1-Alexander@wetzel-home.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

skb_get_hash() can only be used when the skb is linked to a netdev
device.

Signed-off-by: Alexander Wetzel <Alexander@wetzel-home.de>
Fixes: 73bc9e0af594 ("mac80211: don't apply flow control on management frames")
---
 net/mac80211/tx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 4a9b258300fe..04f4d574401f 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1428,7 +1428,7 @@ static void ieee80211_txq_enqueue(struct ieee80211_local *local,
 {
 	struct fq *fq = &local->fq;
 	struct fq_tin *tin = &txqi->tin;
-	u32 flow_idx = fq_flow_idx(fq, skb);
+	u32 flow_idx;
 
 	ieee80211_set_skb_enqueue_time(skb);
 
@@ -1444,6 +1444,7 @@ static void ieee80211_txq_enqueue(struct ieee80211_local *local,
 			IEEE80211_TX_INTCFL_NEED_TXPROCESSING;
 		__skb_queue_tail(&txqi->frags, skb);
 	} else {
+		flow_idx = fq_flow_idx(fq, skb);
 		fq_tin_enqueue(fq, tin, flow_idx, skb,
 			       fq_skb_free_func);
 	}
-- 
2.50.0


