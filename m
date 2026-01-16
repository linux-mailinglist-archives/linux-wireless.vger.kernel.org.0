Return-Path: <linux-wireless+bounces-30902-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED86D2DF6A
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 09:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5F9D308BA30
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 08:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5628E6FC5;
	Fri, 16 Jan 2026 08:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="oDGws6i9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24EC2D8773
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 08:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551682; cv=none; b=oZj+82BDDIImC+fyTdXWMNRHwyAY/ZUDGx/CkaqJeW15j9r7OkZax2gOftoO+qTexy2QoFXKzjYBcPHMn58HVjAWIdoeCHBVgHc8KpmF/mQXK2WI3yme25SO5Jl9mJix1zh7zDnfs+rL59qBOfsmxompGN5qYj1t/xK5jXXP+lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551682; c=relaxed/simple;
	bh=91BCqD4x+eX1FFFTHm88FagT6FKjqEJimzH40M02xUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ojqx5DixYLvfSCQDKhQ+G35s2JWAKemTh/xIg+P5RflWPNOMFcMMaFFio1AVwUxuw3noksDlwcJkJJxgu8aX/GiJpIwPr7RD/AdbYoYOG2isss3ShgALKHFug7LcmngNUOBqYheqq+kJeSE+ULtQHx22O/2NPCi6fVoMzON2/lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=oDGws6i9; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=uDioT2nC3vOUGWewLofvG7H8Sn2GOrDR/T+uNuAgkUI=; t=1768551681; x=1769761281; 
	b=oDGws6i9mRnjfBmR5iCQsbA+xioTWKw/kQIn/njYKA5dgWn48RrfxRpAQGYl5DK24GtcqJCQdN4
	Pkr4ATViF7Qhm6+pbhS7g25jL8rUr5rMJYhcfKSSnp+jZDcjf4LhFJmrwAko53x8B4OJRJYN7kuv2
	Yj3B6wvetF/wUta5HDQrxaTUMylLUZKvXTdWQvbpQlcjfEBHTfrzOAXS9vbmjGG8uJEFThQuoYq0q
	/0kWIOhHiWzHVfE+F2Gbr29o8OyIazeH5m3O46j8E60AF5eS4g+cawHKHKxTNmRNneImiBw8e3qE5
	I9eeO8bIXGFSg1kIGZfXOCTaejQExol4swZA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vgf54-0000000DKxR-08Eu;
	Fri, 16 Jan 2026 09:21:18 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: mac80211: mark iface work SKBs as consumed
Date: Fri, 16 Jan 2026 09:21:15 +0100
Message-ID: <20260116092115.1db534bdc12c.Ic0adae06684a6871144398d15cf7700c57620baa@changeid>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Using kfree_skb() here is misleading when looking at
traces, since these frames have been handled. Use
consume_skb() instead.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/iface.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 7b0aa24c1f97..3ce94b95decd 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -8,7 +8,7 @@
  * Copyright 2008, Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (c) 2016        Intel Deutschland GmbH
- * Copyright (C) 2018-2025 Intel Corporation
+ * Copyright (C) 2018-2026 Intel Corporation
  */
 #include <linux/slab.h>
 #include <linux/kernel.h>
@@ -1789,7 +1789,7 @@ static void ieee80211_iface_work(struct wiphy *wiphy, struct wiphy_work *work)
 		else
 			ieee80211_iface_process_skb(local, sdata, skb);
 
-		kfree_skb(skb);
+		consume_skb(skb);
 		kcov_remote_stop();
 	}
 
@@ -1798,7 +1798,7 @@ static void ieee80211_iface_work(struct wiphy *wiphy, struct wiphy_work *work)
 		kcov_remote_start_common(skb_get_kcov_handle(skb));
 
 		ieee80211_iface_process_status(sdata, skb);
-		kfree_skb(skb);
+		consume_skb(skb);
 
 		kcov_remote_stop();
 	}
-- 
2.52.0


