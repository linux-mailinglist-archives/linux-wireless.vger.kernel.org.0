Return-Path: <linux-wireless+bounces-10786-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6510943D5C
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 02:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6089B286790
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 00:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685F31C5799;
	Thu,  1 Aug 2024 00:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsTuqunz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF171C5795;
	Thu,  1 Aug 2024 00:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471877; cv=none; b=UXQLl/dd/6ZU67Pbi6rO9nqjv5jOA2krO0MIBGJBrwmYrOjYQ4C53ZMsc8czRJyB+Y4I6UDTA89/EZPSxLlE0E2OJawJV44O+YLMr3LOXCsPBUEY6mSHErYK8fXS+5HwZyXEb5yDIklp8TLWh+ev+BeqJhKDncnRiCiZFi9fifk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471877; c=relaxed/simple;
	bh=lCke2NneBJe6C4+wyrpyK6/0iAmf9yF+EZ/6rfo6XTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mF1Pv57tRdk846+2Ctx7POzlGeeqE5fcZylaX4VfsMHdbXVWKPxfcQL/0IQt2Cm4SxpwhMG+Al7PrBIHOiklE0iR+zEst+Alj2LRW83XYKbr2caCiWbr5TIqbLigLlaOAZWlRK7G9WTybBDfCZq/xz+zeHe5+A1i6OeY0sszvIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsTuqunz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680CEC116B1;
	Thu,  1 Aug 2024 00:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471876;
	bh=lCke2NneBJe6C4+wyrpyK6/0iAmf9yF+EZ/6rfo6XTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PsTuqunz+UyyNuoZJbBR4ZP6B8d2yW6IVTrBf7cwxyASnb/QGKzWb8hO7SoYUqrE1
	 7T6skoxMLkfPHNOTxTwprZ361lxAgJI14un3pTByS6OLxHw8oEUY4PYN8kogvAsLra
	 ZA1LiRFihtI+PVRibuAIp8X5WKEhe9h9kxwGYDGJgPBdvxL6hWci2bc5MOudijB1C7
	 7/hSjAOUibQECIg97w4ViC3mb7HY2JiR9vSsZNl/qOOZN35aKAE7WGK1ik8cW05cXy
	 MT9HVG0l2m+mJzjtiw/zKIowJ36qNuERDXe0R+YrkkCoSueGUt55AP7TqWMd4hcY4K
	 3E0+H/IVbtQIA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 49/83] wifi: cfg80211: make hash table duplicates more survivable
Date: Wed, 31 Jul 2024 20:18:04 -0400
Message-ID: <20240801002107.3934037-49-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 7f12e26a194d0043441f870708093d9c2c3bad7d ]

Jiazi Li reported that they occasionally see hash table duplicates
as evidenced by the WARN_ON() in rb_insert_bss() in this code.  It
isn't clear how that happens, nor have I been able to reproduce it,
but if it does happen, the kernel crashes later, when it tries to
unhash the entry that's now not hashed.

Try to make this situation more survivable by removing the BSS from
the list(s) as well, that way it's fully leaked here (as had been
the intent in the hash insert error path), and no longer reachable
through the list(s) so it shouldn't be unhashed again later.

Link: https://lore.kernel.org/r/20231026013528.GA24122@Jiazi.Li
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Link: https://msgid.link/20240607181726.36835-2-johannes@sipsolutions.net
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/scan.c | 46 +++++++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 74db51348a7ff..4d88e797ae49f 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1562,7 +1562,7 @@ struct cfg80211_bss *cfg80211_get_bss(struct wiphy *wiphy,
 }
 EXPORT_SYMBOL(cfg80211_get_bss);
 
-static void rb_insert_bss(struct cfg80211_registered_device *rdev,
+static bool rb_insert_bss(struct cfg80211_registered_device *rdev,
 			  struct cfg80211_internal_bss *bss)
 {
 	struct rb_node **p = &rdev->bss_tree.rb_node;
@@ -1578,7 +1578,7 @@ static void rb_insert_bss(struct cfg80211_registered_device *rdev,
 
 		if (WARN_ON(!cmp)) {
 			/* will sort of leak this BSS */
-			return;
+			return false;
 		}
 
 		if (cmp < 0)
@@ -1589,6 +1589,7 @@ static void rb_insert_bss(struct cfg80211_registered_device *rdev,
 
 	rb_link_node(&bss->rbn, parent, p);
 	rb_insert_color(&bss->rbn, &rdev->bss_tree);
+	return true;
 }
 
 static struct cfg80211_internal_bss *
@@ -1615,6 +1616,34 @@ rb_find_bss(struct cfg80211_registered_device *rdev,
 	return NULL;
 }
 
+static void cfg80211_insert_bss(struct cfg80211_registered_device *rdev,
+				struct cfg80211_internal_bss *bss)
+{
+	lockdep_assert_held(&rdev->bss_lock);
+
+	if (!rb_insert_bss(rdev, bss))
+		return;
+	list_add_tail(&bss->list, &rdev->bss_list);
+	rdev->bss_entries++;
+}
+
+static void cfg80211_rehash_bss(struct cfg80211_registered_device *rdev,
+                                struct cfg80211_internal_bss *bss)
+{
+	lockdep_assert_held(&rdev->bss_lock);
+
+	rb_erase(&bss->rbn, &rdev->bss_tree);
+	if (!rb_insert_bss(rdev, bss)) {
+		list_del(&bss->list);
+		if (!list_empty(&bss->hidden_list))
+			list_del_init(&bss->hidden_list);
+		if (!list_empty(&bss->pub.nontrans_list))
+			list_del_init(&bss->pub.nontrans_list);
+		rdev->bss_entries--;
+	}
+	rdev->bss_generation++;
+}
+
 static bool cfg80211_combine_bsses(struct cfg80211_registered_device *rdev,
 				   struct cfg80211_internal_bss *new)
 {
@@ -1876,9 +1905,7 @@ __cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 			bss_ref_get(rdev, bss_from_pub(tmp->pub.transmitted_bss));
 		}
 
-		list_add_tail(&new->list, &rdev->bss_list);
-		rdev->bss_entries++;
-		rb_insert_bss(rdev, new);
+		cfg80211_insert_bss(rdev, new);
 		found = new;
 	}
 
@@ -3111,19 +3138,14 @@ void cfg80211_update_assoc_bss_entry(struct wireless_dev *wdev,
 		if (!WARN_ON(!__cfg80211_unlink_bss(rdev, new)))
 			rdev->bss_generation++;
 	}
-
-	rb_erase(&cbss->rbn, &rdev->bss_tree);
-	rb_insert_bss(rdev, cbss);
-	rdev->bss_generation++;
+	cfg80211_rehash_bss(rdev, cbss);
 
 	list_for_each_entry_safe(nontrans_bss, tmp,
 				 &cbss->pub.nontrans_list,
 				 nontrans_list) {
 		bss = bss_from_pub(nontrans_bss);
 		bss->pub.channel = chan;
-		rb_erase(&bss->rbn, &rdev->bss_tree);
-		rb_insert_bss(rdev, bss);
-		rdev->bss_generation++;
+		cfg80211_rehash_bss(rdev, bss);
 	}
 
 done:
-- 
2.43.0


