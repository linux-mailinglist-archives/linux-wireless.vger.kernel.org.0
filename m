Return-Path: <linux-wireless+bounces-10795-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BB0943ED2
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 03:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52DC4283123
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 01:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24EC1DB456;
	Thu,  1 Aug 2024 00:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1VYPRNT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40931DB450;
	Thu,  1 Aug 2024 00:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472495; cv=none; b=kBjgLlf6jfuYDu6yhl7ocv1J0TbS+HjoEEK8QoQ0Jjw/wCALv+4jj2DQX3n2RsVkkkxnb1tZbSSg1g+gjix1QGkLkEUsykvlpRtuDccTi0gUW2hwQabrHlDE+LLH7y1z+J6+lbx3kan3+Ao0utss5kChse2DHoh8hVa70e6cGnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472495; c=relaxed/simple;
	bh=aQkVDcVAL2fQAuPK42YwSYbrS2HBlDXT4F0BZPUdMVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BkGWkr8BLqjxvwdsA/6AW2nt+/ZQz9yY/I8/1yZJKGvAdj8Kj2XxXuuIYt7hzYpIrkIbOXz5Puek3Pd5UEfAJx4ATqVXiPsTeIGV3q7JHchwRWZSf7U0tWv+vjmiMSwbzrbTVaazUBhD5HcF4kV3bY6VVlkMGJHbni1IOiAE5VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1VYPRNT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B31C32786;
	Thu,  1 Aug 2024 00:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472495;
	bh=aQkVDcVAL2fQAuPK42YwSYbrS2HBlDXT4F0BZPUdMVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A1VYPRNTdEDmpYkLV2qiEVKGTcvsIEMjOfJRnoMfoB/mrvN41m+y8YQ0JndKtwwyX
	 NVKb5km4Nk6PdCn6oKqvRpWaiWtiJZ0y8aDDWexomaCAvB+qq9ozkCpaDI3i3nTeX0
	 sYaiuj0GT++/0YId6iy1SNwzxdSdp2MKRoii/TWQBk/t9jmUR0AHaqHn8c6SxXqqHQ
	 aQkA8C2bs+eWvADk+nBiXP0b8JcUjE6Lk7Rzyqr9jEig7ixJQC5hNeLGRIfuzTgbZM
	 uPzVC3vTRFDz3HpvuukSw+r5ajQ35t2XSMW9tn+zIc1tZ2BQ95Hj/4fTbq7ycYalyZ
	 19Dpxnt0j3rLA==
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
Subject: [PATCH AUTOSEL 5.15 30/47] wifi: cfg80211: make hash table duplicates more survivable
Date: Wed, 31 Jul 2024 20:31:20 -0400
Message-ID: <20240801003256.3937416-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003256.3937416-1-sashal@kernel.org>
References: <20240801003256.3937416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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
index a444eb84d621e..b8e28025710dd 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1517,7 +1517,7 @@ struct cfg80211_bss *cfg80211_get_bss(struct wiphy *wiphy,
 }
 EXPORT_SYMBOL(cfg80211_get_bss);
 
-static void rb_insert_bss(struct cfg80211_registered_device *rdev,
+static bool rb_insert_bss(struct cfg80211_registered_device *rdev,
 			  struct cfg80211_internal_bss *bss)
 {
 	struct rb_node **p = &rdev->bss_tree.rb_node;
@@ -1533,7 +1533,7 @@ static void rb_insert_bss(struct cfg80211_registered_device *rdev,
 
 		if (WARN_ON(!cmp)) {
 			/* will sort of leak this BSS */
-			return;
+			return false;
 		}
 
 		if (cmp < 0)
@@ -1544,6 +1544,7 @@ static void rb_insert_bss(struct cfg80211_registered_device *rdev,
 
 	rb_link_node(&bss->rbn, parent, p);
 	rb_insert_color(&bss->rbn, &rdev->bss_tree);
+	return true;
 }
 
 static struct cfg80211_internal_bss *
@@ -1570,6 +1571,34 @@ rb_find_bss(struct cfg80211_registered_device *rdev,
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
@@ -1845,9 +1874,7 @@ cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 			bss_ref_get(rdev, pbss);
 		}
 
-		list_add_tail(&new->list, &rdev->bss_list);
-		rdev->bss_entries++;
-		rb_insert_bss(rdev, new);
+		cfg80211_insert_bss(rdev, new);
 		found = new;
 	}
 
@@ -2712,10 +2739,7 @@ void cfg80211_update_assoc_bss_entry(struct wireless_dev *wdev,
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
@@ -2723,9 +2747,7 @@ void cfg80211_update_assoc_bss_entry(struct wireless_dev *wdev,
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


