Return-Path: <linux-wireless+bounces-10479-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9664E93B050
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2024 13:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF92D1C2110B
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2024 11:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C11156F46;
	Wed, 24 Jul 2024 11:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xRPLgOlC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A70B156F40
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jul 2024 11:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721820567; cv=none; b=rEq836SBZcnzcd5GeKebyWjzjztkwOrOEGOGu8G1HmRNsGlYqpgT3aY0MLfBOgi5Ctb5+ZHUn/eET06pTBL0WZ2xXGrn9leDYFT6yJdRpXGgNsgxkt5SCylyDWD7IcSYsdFsMgk7xssIrkfNVnuIOw8ue2TzkV+dQbfFnf1a3PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721820567; c=relaxed/simple;
	bh=MUCcRGgdw4zM579VppOt4ZAx5ZLmKVkIEpGrVDn45PY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NXlehKmoJvbOLwky46oEUHEKVGmZvzVRCplsU5idEP26tna+fNQN0FnthI49sgSsl6JZJKv4upOduaWcJfD1RntY/vhu6O0rXlOpASbrFjHnldePtoVkIUwECIaPHMRSvq1Bbpegjl+rnXpX2oe1cZJajBHjNHuz5OVH1WCvXCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xRPLgOlC; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=MGSUy3F/4oieNxo2aOKH0h7dsmxMQW8f2ueTBh8OloQ=; t=1721820565; x=1723030165; 
	b=xRPLgOlC68CdFKpoCJ3duBC+ZTTLeiwRxQioF+6CAb3z9zWjlUxVZmIJyZ5vRw2JpK7r8aFjwgV
	3YPN+QVH/Xl0c07RkKZ9NVk0KxnImnidyfjKe5/z1AbXWrRF5xQ8zEt4JYCbAExj4ABPetpU//Cpi
	QboS4jewC9k3UpnlSXaBU+AdJRo99CFF2ZD4kCKGA6JUDqWguzUqiKSModE7XjMw1Wxr3Op/SCUYx
	uptO5KO9XkUg+2wWvQnqQCQmuKl/fh7jOwM9PwLFg7MUBmNnBNMunycnEI80VsvOhJeHSUP5PUjgk
	JQ4U3wm5LSzjeD7l1c8qaOj8gL0z06atJuzQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sWaBN-0000000DXrm-3rsc;
	Wed, 24 Jul 2024 13:29:22 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	syzbot+0f3afa93b91202f21939@syzkaller.appspotmail.com
Subject: [PATCH wireless] wifi: cfg80211: correct S1G beacon length calculation
Date: Wed, 24 Jul 2024 13:29:12 +0200
Message-ID: <20240724132912.9662972db7c1.I8779675b5bbda4994cc66f876b6b87a2361c3c0b@changeid>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The minimum header length calculation (equivalent to the start
of the elements) for the S1G long beacon erroneously required
only up to the start of u.s1g_beacon rather than the start of
u.s1g_beacon.variable. Fix that, and also shuffle the branches
around a bit to not assign useless values that are overwritten
later.

Reported-by: syzbot+0f3afa93b91202f21939@syzkaller.appspotmail.com
Fixes: 9eaffe5078ca ("cfg80211: convert S1G beacon to scan results")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/scan.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index d99319d82205..64eeed82d43d 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -3178,8 +3178,7 @@ cfg80211_inform_bss_frame_data(struct wiphy *wiphy,
 			       struct ieee80211_mgmt *mgmt, size_t len,
 			       gfp_t gfp)
 {
-	size_t min_hdr_len = offsetof(struct ieee80211_mgmt,
-				      u.probe_resp.variable);
+	size_t min_hdr_len;
 	struct ieee80211_ext *ext = NULL;
 	enum cfg80211_bss_frame_type ftype;
 	u16 beacon_interval;
@@ -3202,10 +3201,16 @@ cfg80211_inform_bss_frame_data(struct wiphy *wiphy,
 
 	if (ieee80211_is_s1g_beacon(mgmt->frame_control)) {
 		ext = (void *) mgmt;
-		min_hdr_len = offsetof(struct ieee80211_ext, u.s1g_beacon);
 		if (ieee80211_is_s1g_short_beacon(mgmt->frame_control))
 			min_hdr_len = offsetof(struct ieee80211_ext,
 					       u.s1g_short_beacon.variable);
+		else
+			min_hdr_len = offsetof(struct ieee80211_ext,
+					       u.s1g_beacon.variable);
+	} else {
+		/* same for beacons */
+		min_hdr_len = offsetof(struct ieee80211_mgmt,
+				       u.probe_resp.variable);
 	}
 
 	if (WARN_ON(len < min_hdr_len))
-- 
2.45.2


