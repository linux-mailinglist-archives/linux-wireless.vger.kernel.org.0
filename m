Return-Path: <linux-wireless+bounces-20450-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2E7A6585B
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 17:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4C593B39FB
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 16:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD321ACEDA;
	Mon, 17 Mar 2025 16:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVLseUzA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DF11ACECE;
	Mon, 17 Mar 2025 16:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229458; cv=none; b=W+oi/yCTqQtwTf6lmSWTJlUbzdErolz0ncKWmJHXUxBGF6FYkfzR+FYnJxJzkxxqb/isCYSLPwOAuOnP7TnxRRCeBl5fH4I9MJqwPXeSq+lNkzAI7lC+jWCcuCPRm0Cpk7i8WJAG8bFttFFoxNC022KdEXp+K3WPzpC+RbQ84h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229458; c=relaxed/simple;
	bh=/8meWmzTZbw5wi5wMvYrEgCMGPK9ybmFo2OU+vVu32k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IABTdJxZtq951L2WoGR++KevF1Wia7WP1w/WC4vQVgc2gW9pRvuV2djcaygO6oP2N3Xz8Pauc9PThdthHRxT8sGZvHHYmHSmaGNS6jc/l62EDYXloMyob+mxRntgdgbFCVa0UAU7XBTuY7w6S+wzKFQGwDH7yarhTkmHq8R4UII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVLseUzA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D618C4CEED;
	Mon, 17 Mar 2025 16:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229457;
	bh=/8meWmzTZbw5wi5wMvYrEgCMGPK9ybmFo2OU+vVu32k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OVLseUzA0sIh1Jcb49yga0sfa0b2CGzNJuk2jDW5RdkDqCIbiNMMQGNDT+PMqL5sx
	 i1BszrzVK4XNOGUw9ZKMCDvZn2TaphXoB3Zpa0AH4RdHrdK87func46SZqWswN4j9O
	 uK1+usRZ9LTNXOWPBaK34UJE6D+sXoxYbDZdI1AU4K3x+WpZAOaB9UM94JWwIieAmT
	 mJlAUG0aiQCbyFefpyVPgcHcUScMyY7azU4eTQXiTDPYzi2/nwKbzPtkD4IRXI+gk0
	 6S/EHSBrcURsRzo9XSN+6Y5DQxhULvq9F5PUspLJY6iu2ZyH38uTEa+hi1aJaF2tGx
	 CeU5uDaoUllRw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 05/16] wifi: mac80211: flush the station before moving it to UN-AUTHORIZED state
Date: Mon, 17 Mar 2025 12:37:14 -0400
Message-Id: <20250317163725.1892824-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250317163725.1892824-1-sashal@kernel.org>
References: <20250317163725.1892824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.7
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit 43e04077170799d0e6289f3e928f727e401b3d79 ]

We first want to flush the station to make sure we no longer have any
frames being Tx by the station before the station is moved to
un-authorized state. Failing to do that will lead to races: a frame may
be sent after the station's state has been changed.

Since the API clearly states that the driver can't fail the sta_state()
transition down the list of state, we can easily flush the station
first, and only then call the driver's sta_state().

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250306123626.450bc40e8b04.I636ba96843c77f13309c15c9fd6eb0c5a52a7976@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/sta_info.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index aa22f09e6d145..49095f19a0f22 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -4,7 +4,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 
 #include <linux/module.h>
@@ -1317,9 +1317,13 @@ static int _sta_info_move_state(struct sta_info *sta,
 		sta->sta.addr, new_state);
 
 	/* notify the driver before the actual changes so it can
-	 * fail the transition
+	 * fail the transition if the state is increasing.
+	 * The driver is required not to fail when the transition
+	 * is decreasing the state, so first, do all the preparation
+	 * work and only then, notify the driver.
 	 */
-	if (test_sta_flag(sta, WLAN_STA_INSERTED)) {
+	if (new_state > sta->sta_state &&
+	    test_sta_flag(sta, WLAN_STA_INSERTED)) {
 		int err = drv_sta_state(sta->local, sta->sdata, sta,
 					sta->sta_state, new_state);
 		if (err)
@@ -1395,6 +1399,16 @@ static int _sta_info_move_state(struct sta_info *sta,
 		break;
 	}
 
+	if (new_state < sta->sta_state &&
+	    test_sta_flag(sta, WLAN_STA_INSERTED)) {
+		int err = drv_sta_state(sta->local, sta->sdata, sta,
+					sta->sta_state, new_state);
+
+		WARN_ONCE(err,
+			  "Driver is not allowed to fail if the sta_state is transitioning down the list: %d\n",
+			  err);
+	}
+
 	sta->sta_state = new_state;
 
 	return 0;
-- 
2.39.5


