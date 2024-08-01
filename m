Return-Path: <linux-wireless+bounces-10797-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F41E1943F49
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 03:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3338283265
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 01:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14891E2870;
	Thu,  1 Aug 2024 00:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLu5Qzl3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756271E286C;
	Thu,  1 Aug 2024 00:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472693; cv=none; b=ozQjvGUMPfeZabXrAwAtB5bIvJf+5ZYMfJfAt0KJfblSHE3Vxji+KLDS1bMj8+llvOU73Foq6y9sQYDwi6p5WegRwXat9hZ/XHvyRl7z8/sKUibmzZtpH8dOFtSdEMK1bk4ctK0GwE00XEoGt/dYTYSCMh5CGYu3QEO+dub804I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472693; c=relaxed/simple;
	bh=0gp7rOlZePoJ4UoagGIGzzZNnmMI7XlwpB28othjJVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CrjljB/wevO4IF+j8jfa9IznbJoIPHV64wslohIIXEay5zIoHhNH01CpP83YNJ361LfV1Pf2nM73atgV/imnt30OvFYCvHcc4Rno6tRf7EpMma9t7goYPeltHnILwo71xp0JX3xbTnxx4lYvcnBuUAObhFcDpFhJarQEY2VWwKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLu5Qzl3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADFB2C4AF0E;
	Thu,  1 Aug 2024 00:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472693;
	bh=0gp7rOlZePoJ4UoagGIGzzZNnmMI7XlwpB28othjJVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hLu5Qzl3ZkkEI/0RmfAMrXl/Bt88D7UOWS/yFYLF+skzbTIOIiFKQ8m+kdU3QYwqn
	 yrSNdsyOQpMp7cnnui/zIySZ4A5wN0AaYcpTudv4pxfIqYLqcFjXVWJyO9xLUZJlSu
	 BJinEfZmqwLJZDGGUmVnhYqM64AJfZdSZ2GgN+VDGf+iK6Eb30kMweeJ9TY53soWle
	 pJDLDzHORpbt0XXj/PNFnvmg9SLuTMLszMjBuE0p/lm5hdgOozXKWs6tCnRpea4bRI
	 a5D9xa0983ZUZBqGMuO6cP8t7/NNtob1u/OtZaRK6RsiDzYhr8YKi+rcWM6EcvaivF
	 liEelQFClw6jA==
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
Subject: [PATCH AUTOSEL 5.10 23/38] wifi: cfg80211: make hash table duplicates more survivable
Date: Wed, 31 Jul 2024 20:35:29 -0400
Message-ID: <20240801003643.3938534-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003643.3938534-1-sashal@kernel.org>
References: <20240801003643.3938534-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
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
index 76a27b6d45d28..e8a9ce0392957 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1510,7 +1510,7 @@ struct cfg80211_bss *cfg80211_get_bss(struct wiphy *wiphy,
 }
 EXPORT_SYMBOL(cfg80211_get_bss);
 
-static void rb_insert_bss(struct cfg80211_registered_device *rdev,
+static bool rb_insert_bss(struct cfg80211_registered_device *rdev,
 			  struct cfg80211_internal_bss *bss)
 {
 	struct rb_node **p = &rdev->bss_tree.rb_node;
@@ -1526,7 +1526,7 @@ static void rb_insert_bss(struct cfg80211_registered_device *rdev,
 
 		if (WARN_ON(!cmp)) {
 			/* will sort of leak this BSS */
-			return;
+			return false;
 		}
 
 		if (cmp < 0)
@@ -1537,6 +1537,7 @@ static void rb_insert_bss(struct cfg80211_registered_device *rdev,
 
 	rb_link_node(&bss->rbn, parent, p);
 	rb_insert_color(&bss->rbn, &rdev->bss_tree);
+	return true;
 }
 
 static struct cfg80211_internal_bss *
@@ -1563,6 +1564,34 @@ rb_find_bss(struct cfg80211_registered_device *rdev,
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
@@ -1838,9 +1867,7 @@ cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 			bss_ref_get(rdev, pbss);
 		}
 
-		list_add_tail(&new->list, &rdev->bss_list);
-		rdev->bss_entries++;
-		rb_insert_bss(rdev, new);
+		cfg80211_insert_bss(rdev, new);
 		found = new;
 	}
 
@@ -2702,10 +2729,7 @@ void cfg80211_update_assoc_bss_entry(struct wireless_dev *wdev,
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
@@ -2713,9 +2737,7 @@ void cfg80211_update_assoc_bss_entry(struct wireless_dev *wdev,
 		bss = container_of(nontrans_bss,
 				   struct cfg80211_internal_bss, pub);
 		bss->pub.channel = chan;
-		rb_erase(&bss->rbn, &rdev->bss_tree);
-		rb_insert_bss(rdev, bss);
-		rdev->bss_generation++;
+		cfg80211_rehash_bss(rdev, bss);
 	}
 
 done:
-- 
2.43.0


