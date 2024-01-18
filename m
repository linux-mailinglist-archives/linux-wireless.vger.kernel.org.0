Return-Path: <linux-wireless+bounces-2165-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4E9831855
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 12:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5022B1C214CD
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 11:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B14B2376E;
	Thu, 18 Jan 2024 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ClFexqyi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB03241E8
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 11:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705576794; cv=none; b=S7oVAYIvVr44QYJp2exDtHFW5cNE1/CNACf7r5N4qJRg9UnfEP2Qq74Xv2kgLSiYgfUy1wrLNe9dhr2ounNPBH+a3QCKo321I4pskBRIuFoMukG8hwql0gi3fIYrhFQne6bHVpI9WIt1PbBSjntO5+Z/Z0AYN0IjModctGim7qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705576794; c=relaxed/simple;
	bh=2zbt9gDYk6uG5vLkBxnKxHzhYKf+AL78taVQbBzdNi8=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=YOvyXQjotEsKBYLDIpeVMJjbW83VDR9zuI5UosIhrAqkvGuX3fKHgFtbKS+iJh//k5/NsPd2uul2sdoxJBwuPpjwt6/yxouC7dOP4sq0Q9ZMNDqAe0R211X31Lb206YjzYbREJrYO+E+hCYbrryOZDJl0IJfv/Mrrl2fQuJS4ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ClFexqyi; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9TQqnc9JGM4r2ZnidYySw2XBYgtcupjGm+qAYx+YLzs=;
	t=1705576792; x=1706786392; b=ClFexqyi4jrzF8XGDOMatn53ZD1wKPAEDTxdpRL68Mbm5Fy
	udd9v5V4riaAJkoLkSNOShjNyDf5RqtNnCrItCeefOgUZh/SoVX0PacG+xq3F9TduBtTMJ8rZtINg
	u5RWD4jqfVCwE8ET4vEavYtGwA+4mPbskhMiy8dKUj1nsiNzCzL2jJNwjmFK7qcadeqkbbqg48cog
	uqpOX8X2/VIhA2f8sY1Sq7IntxtEKe0FGJt80HEwrRHhbD4qm2k8qfnjphSoCQ1uvfPY6O0x8cPZ/
	mroHu/OM99yEx7kPcf4qb9Fh8+nQ6JxK8665NINC8s/ts4J3xObjTKNqmUFpGazA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rQQR2-00000007wVW-3LeD;
	Thu, 18 Jan 2024 12:19:49 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: coldolt <andypalmadi@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 1/2] wifi: cfg80211: detect stuck ECSA element in probe resp
Date: Thu, 18 Jan 2024 12:16:27 +0100
Message-ID: <20240118121941.178538d79dbc.Ibf834d7f52f9951a353b6872383da710a7358338@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118111941.549593-4-johannes@sipsolutions.net>
References: <20240118111941.549593-4-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We recently added some validation that we don't try to
connect to an AP that is currently in a channel switch
process, since that might want the channel to be quiet
or we might not be able to connect in time to hear the
switching in a beacon. This was in commit c09c4f31998b
("wifi: mac80211: don't connect to an AP while it's in
a CSA process").

However, we promptly got a report that this caused new
connection failures, and it turns out that the AP that
we now cannot connect to is permanently advertising an
extended channel switch announcement, even with quiet.

As a first step, attempt to detect that we're dealing
with such a situation, so mac80211 can use this later.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h |  4 ++++
 net/wireless/scan.c    | 48 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 4ecfb06c413d..8f2c48761833 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2865,6 +2865,8 @@ struct cfg80211_bss_ies {
  *	own the beacon_ies, but they're just pointers to the ones from the
  *	@hidden_beacon_bss struct)
  * @proberesp_ies: the information elements from the last Probe Response frame
+ * @proberesp_ecsa_stuck: ECSA element is stuck in the Probe Response frame,
+ *	cannot rely on it having valid data
  * @hidden_beacon_bss: in case this BSS struct represents a probe response from
  *	a BSS that hides the SSID in its beacon, this points to the BSS struct
  *	that holds the beacon data. @beacon_ies is still valid, of course, and
@@ -2900,6 +2902,8 @@ struct cfg80211_bss {
 	u8 chains;
 	s8 chain_signal[IEEE80211_MAX_CHAINS];
 
+	u8 proberesp_ecsa_stuck:1;
+
 	u8 bssid_index;
 	u8 max_bssid_indicator;
 
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 9e5ccffd6868..dc018f661f2a 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -5,7 +5,7 @@
  * Copyright 2008 Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright 2016	Intel Deutschland GmbH
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -1725,6 +1725,46 @@ static void cfg80211_update_hidden_bsses(struct cfg80211_internal_bss *known,
 	}
 }
 
+static void cfg80211_check_stuck_ecsa(struct cfg80211_registered_device *rdev,
+				      struct cfg80211_internal_bss *known,
+				      const struct cfg80211_bss_ies *old,
+				      const struct cfg80211_bss_ies *bcn)
+{
+	const struct cfg80211_bss_ies *new;
+	const struct element *elem_new, *elem_old;
+
+	if (!old || known->pub.proberesp_ecsa_stuck)
+		return;
+
+	elem_old = cfg80211_find_elem(WLAN_EID_EXT_CHANSWITCH_ANN,
+				      old->data, old->len);
+	if (!elem_old)
+		return;
+
+	new = rcu_dereference_protected(known->pub.proberesp_ies,
+					lockdep_is_held(&rdev->bss_lock));
+	elem_new = cfg80211_find_elem(WLAN_EID_EXT_CHANSWITCH_ANN,
+				      new->data, new->len);
+	if (!elem_new)
+		return;
+
+	if (!bcn)
+		bcn = rcu_dereference_protected(known->pub.beacon_ies,
+						lockdep_is_held(&rdev->bss_lock));
+	if (bcn &&
+	    cfg80211_find_elem(WLAN_EID_EXT_CHANSWITCH_ANN,
+			       bcn->data, bcn->len))
+		return;
+
+	if (elem_new->datalen != elem_old->datalen)
+		return;
+	if (elem_new->datalen < sizeof(struct ieee80211_ext_chansw_ie))
+		return;
+	if (memcmp(elem_new->data, elem_old->data, elem_new->datalen))
+		return;
+	known->pub.proberesp_ecsa_stuck = 1;
+}
+
 static bool
 cfg80211_update_known_bss(struct cfg80211_registered_device *rdev,
 			  struct cfg80211_internal_bss *known,
@@ -1733,7 +1773,6 @@ cfg80211_update_known_bss(struct cfg80211_registered_device *rdev,
 {
 	lockdep_assert_held(&rdev->bss_lock);
 
-	/* Update IEs */
 	if (rcu_access_pointer(new->pub.proberesp_ies)) {
 		const struct cfg80211_bss_ies *old;
 
@@ -1744,8 +1783,11 @@ cfg80211_update_known_bss(struct cfg80211_registered_device *rdev,
 		/* Override possible earlier Beacon frame IEs */
 		rcu_assign_pointer(known->pub.ies,
 				   new->pub.proberesp_ies);
-		if (old)
+		if (old) {
+			cfg80211_check_stuck_ecsa(rdev, known, old,
+						  rcu_access_pointer(new->pub.beacon_ies));
 			kfree_rcu((struct cfg80211_bss_ies *)old, rcu_head);
+		}
 	} else if (rcu_access_pointer(new->pub.beacon_ies)) {
 		const struct cfg80211_bss_ies *old;
 
-- 
2.43.0


