Return-Path: <linux-wireless+bounces-24194-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D695ADC562
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 10:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26B347A8CB8
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 08:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E9C293B65;
	Tue, 17 Jun 2025 08:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="L902RBc/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1568F28BAAA
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 08:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750150174; cv=none; b=b518x2oo5oPoKeMAKTHIXifC7vwOxF0AtANSHe7OnSUyMk+oMpwCVIP2jd+qCyhYn84pUSic3isS1jcNKt1zcU2mcyHNUvRwIDM1Pl4yJvnDhq0bWihqElkwcRSPjzN6oOK+FB1fRY0rtg2N3eSEWoPqbLdFr79QhaTB9svgWgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750150174; c=relaxed/simple;
	bh=v95sIgr7Zpac4bl2/5F+T+gw8ZFut9cvDppU8lx3XsU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HdZB1S+zLqA7ZSmKt2S1bvacGJe6/WVpqqFZo5t3AE9JX5Q/xRwfhvSkcy1A+qAqpP+hpDkAc9tM1m/2aTQR+cS23SYKunrYPY4iPQTNVgJDf3UaPqXLptkDOHZG+PJkOipLkdgK4DUPcOkPPXfMeZ94QHN4vnvNpLXlVvtycto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=L902RBc/; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=S7lYVJkcz0ajMfwQj4J5+TTw7PH7rr4QrbycmTnX4+U=; t=1750150172; x=1751359772; 
	b=L902RBc/VqRETa1hfryzV9OeLGQYqz1sWW6r6uJJDq1BSrIOADqvQeW6Iy8lFyL+4NJ2+GUyJ3g
	M6Manu/jIvVgJ7SJbyCcUUVg+6a090FJeWEbI0NKLA0PT61zbtDeoeFh8mfXi+tyk/Vh8KxBprQCr
	G7SgWtqDbJ3cgmuTvPphThfvZIKLyXRfWpr92jdZauPCzHSOu7iIQPlYn6zIAiDkLn2s79HNpNfQ7
	IDicxLafJZsBLlMloBv4uRzgesXdGSMMjURpdZfluAdNnjvFqwaPapxFAFv7CHtonHzrXdQ+ZGphv
	gg1SHu4nyn4xXNQv93ZK7UHfDniKBRPItXFw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uRS0J-0000000EAAF-0Wpj;
	Tue, 17 Jun 2025 10:49:15 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	syzbot+468656785707b0e995df@syzkaller.appspotmail.com,
	syzbot+18c783c5cf6a781e3e2c@syzkaller.appspotmail.com,
	syzbot+d5924d5cffddfccab68e@syzkaller.appspotmail.com,
	syzbot+7d73d99525d1ff7752ef@syzkaller.appspotmail.com,
	syzbot+8e6e002c74d1927edaf5@syzkaller.appspotmail.com,
	syzbot+97254a3b10c541879a65@syzkaller.appspotmail.com,
	syzbot+dfd1fd46a1960ad9c6ec@syzkaller.appspotmail.com,
	syzbot+85e0b8d12d9ca877d806@syzkaller.appspotmail.com
Subject: [PATCH wireless] wifi: mac80211: don't WARN for late channel/color switch
Date: Tue, 17 Jun 2025 10:49:01 +0200
Message-ID: <20250617104902.146e10919be1.I85f352ca4a2dce6f556e5ff45ceaa5f3769cb5ce@changeid>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There's really no value in the WARN stack trace etc., the reason
for this happening isn't directly related to the calling function
anyway. Also, syzbot has been observing it constantly, and there's
no way we can resolve it there - those systems are just slow.

Instead print an error message (once) and add a comment about what
really causes this message.

Reported-by: syzbot+468656785707b0e995df@syzkaller.appspotmail.com
Reported-by: syzbot+18c783c5cf6a781e3e2c@syzkaller.appspotmail.com
Reported-by: syzbot+d5924d5cffddfccab68e@syzkaller.appspotmail.com
Reported-by: syzbot+7d73d99525d1ff7752ef@syzkaller.appspotmail.com
Reported-by: syzbot+8e6e002c74d1927edaf5@syzkaller.appspotmail.com
Reported-by: syzbot+97254a3b10c541879a65@syzkaller.appspotmail.com
Reported-by: syzbot+dfd1fd46a1960ad9c6ec@syzkaller.appspotmail.com
Reported-by: syzbot+85e0b8d12d9ca877d806@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
#syz test
---
 net/mac80211/debug.h |  5 ++++-
 net/mac80211/tx.c    | 29 +++++++++++++++++++++--------
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/net/mac80211/debug.h b/net/mac80211/debug.h
index 5b81998cb0c9..ef7c1a68d88d 100644
--- a/net/mac80211/debug.h
+++ b/net/mac80211/debug.h
@@ -1,10 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Portions
- * Copyright (C) 2022 - 2024 Intel Corporation
+ * Copyright (C) 2022 - 2025 Intel Corporation
  */
 #ifndef __MAC80211_DEBUG_H
 #define __MAC80211_DEBUG_H
+#include <linux/once_lite.h>
 #include <net/cfg80211.h>
 
 #ifdef CONFIG_MAC80211_OCB_DEBUG
@@ -152,6 +153,8 @@ do {									\
 		else							\
 			_sdata_err((link)->sdata, fmt, ##__VA_ARGS__);	\
 	} while (0)
+#define link_err_once(link, fmt, ...)					\
+	DO_ONCE_LITE(link_err, link, fmt, ##__VA_ARGS__)
 #define link_id_info(sdata, link_id, fmt, ...)				\
 	do {								\
 		if (ieee80211_vif_is_mld(&sdata->vif))			\
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index d8d4f3d7d7f2..d58b80813bdd 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
- * Copyright (C) 2018-2024 Intel Corporation
+ * Copyright (C) 2018-2025 Intel Corporation
  *
  * Transmit and frame generation functions.
  */
@@ -5016,12 +5016,25 @@ static void ieee80211_set_beacon_cntdwn(struct ieee80211_sub_if_data *sdata,
 	}
 }
 
-static u8 __ieee80211_beacon_update_cntdwn(struct beacon_data *beacon)
+static u8 __ieee80211_beacon_update_cntdwn(struct ieee80211_link_data *link,
+					   struct beacon_data *beacon)
 {
-	beacon->cntdwn_current_counter--;
+	if (beacon->cntdwn_current_counter == 1) {
+		/*
+		 * Channel switch handling is done by a worker thread while
+		 * beacons get pulled from hardware timers. It's therefore
+		 * possible that software threads are slow enough to not be
+		 * able to complete CSA handling in a single beacon interval,
+		 * in which case we get here. There isn't much to do about
+		 * it, other than letting the user know that the AP isn't
+		 * behaving correctly.
+		 */
+		link_err_once(link,
+			      "beacon TX faster than countdown (channel/color switch) completion\n");
+		return 0;
+	}
 
-	/* the counter should never reach 0 */
-	WARN_ON_ONCE(!beacon->cntdwn_current_counter);
+	beacon->cntdwn_current_counter--;
 
 	return beacon->cntdwn_current_counter;
 }
@@ -5052,7 +5065,7 @@ u8 ieee80211_beacon_update_cntdwn(struct ieee80211_vif *vif, unsigned int link_i
 	if (!beacon)
 		goto unlock;
 
-	count = __ieee80211_beacon_update_cntdwn(beacon);
+	count = __ieee80211_beacon_update_cntdwn(link, beacon);
 
 unlock:
 	rcu_read_unlock();
@@ -5450,7 +5463,7 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 
 		if (beacon->cntdwn_counter_offsets[0]) {
 			if (!is_template)
-				__ieee80211_beacon_update_cntdwn(beacon);
+				__ieee80211_beacon_update_cntdwn(link, beacon);
 
 			ieee80211_set_beacon_cntdwn(sdata, beacon, link);
 		}
@@ -5482,7 +5495,7 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 				 * for now we leave it consistent with overall
 				 * mac80211's behavior.
 				 */
-				__ieee80211_beacon_update_cntdwn(beacon);
+				__ieee80211_beacon_update_cntdwn(link, beacon);
 
 			ieee80211_set_beacon_cntdwn(sdata, beacon, link);
 		}
-- 
2.49.0


