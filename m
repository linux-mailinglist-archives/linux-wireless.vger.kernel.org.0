Return-Path: <linux-wireless+bounces-2892-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC00844363
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 16:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70EA71F252BD
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 15:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A651D129A83;
	Wed, 31 Jan 2024 15:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="HHPuAwo1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DC71272C2
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706716157; cv=none; b=trYwTbaTDDlcWEJdqQce73/y4yWy2TmlXoohwDehEeF7SqmdTW+aShZ1VgicKU4lMA3590l83LZi6dByM07yxEy5Ahe30jKsvgMWqWvthjljWYNx+usT77ir6q049qO1JfV4vPixcL8pYz7HleOAFwnhlGb3A+uvkCtUHB4+N7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706716157; c=relaxed/simple;
	bh=EDJBlGOZIg7sQHe5vVGY0rX1UQL9mV6FOaqCjNWVaKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M36Dot5J3Jsy4mY1zo3XaFJDP1iIfBaZoViaxO0LPXaXlwQba+H/JyYpJS5Hx7UIpEw7zBNR9PC1wiGSPqNo49yoBRfpzffja5GDWEZTrzWJjNmsePYUDQFheKuV2MsfWIFQfimqRX/4leAXkVLadRewacexO2vfnd9hygWn/vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=HHPuAwo1; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=btubioyR2fFfIYDoOan9wS7Qu+T9HRF2ymUqAOR0Izw=; t=1706716155; x=1707925755; 
	b=HHPuAwo1SVi3MyphphNONXSfFCra2WejUrqcm7DjkBtN1dlvtXZLk4xzOxTCqnUIQ5nVsLQ6v43
	Rt7ZaMB+njErWrYSpYf/9Gwfy/8ubt/tSH7dPxaNGZtH08/PC92eIywosy7fWSnipkMX53uN7BbZQ
	FLRRNljiiekjTSWgGgVJwFk7qDkxA7D2mpDaF0vIzqfrRHVYJbQbM1Fn9VJ3T5s7rrXWyWazc5nSi
	HyLNqWFiXaS1N7OV6tPC5lwJFyK2q/17P0D++RajHe7rEZF6ydAL+jgA9ccefmNV4rZpYwp3zo3Ih
	7SxzVfxev2HWrsYJdkVKReQpeptUqZ6JVZHA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rVCps-00000007JCD-21KT;
	Wed, 31 Jan 2024 16:49:12 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/2] wifi: mac80211: reload info pointer in ieee80211_tx_dequeue()
Date: Wed, 31 Jan 2024 16:49:10 +0100
Message-ID: <20240131164910.b54c28d583bc.I29450cec84ea6773cff5d9c16ff92b836c331471@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This pointer can change here since the SKB can change, so we
actually later open-coded IEEE80211_SKB_CB() again. Reload
the pointer where needed, so the monitor-mode case using it
gets fixed, and then use info-> later as well.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/tx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index f57f7963ca37..c2e4ef327377 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  *
  * Transmit and frame generation functions.
  */
@@ -3922,6 +3922,7 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 			goto begin;
 
 		skb = __skb_dequeue(&tx.skbs);
+		info = IEEE80211_SKB_CB(skb);
 
 		if (!skb_queue_empty(&tx.skbs)) {
 			spin_lock_bh(&fq->lock);
@@ -3966,7 +3967,7 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 	}
 
 encap_out:
-	IEEE80211_SKB_CB(skb)->control.vif = vif;
+	info->control.vif = vif;
 
 	if (tx.sta &&
 	    wiphy_ext_feature_isset(local->hw.wiphy, NL80211_EXT_FEATURE_AQL)) {
-- 
2.43.0


