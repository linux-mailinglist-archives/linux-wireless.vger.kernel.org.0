Return-Path: <linux-wireless+bounces-2675-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4E8840910
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 15:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15B31C21714
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 14:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B481152E0F;
	Mon, 29 Jan 2024 14:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="C8q/pmMZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6342E152DFE
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 14:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706540050; cv=none; b=TUBTnU8hJvVdyFgmhtbliBEz6Dmr+7hNcjaEEFACmPjFdjeo//6g54W/+EcajRqmR9ZdewVBhyloFLGLmfwit4O0lhLpjfOKMuEIxYrtiwgfywut/9UxLnS4aricEuL7Ka1YrkHXK+SYVfh4L7UoNSQ/ItRvQz4n1Bw+pkw+htU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706540050; c=relaxed/simple;
	bh=TCOjIhCZ+EKfpk8ywioP7Uho+Pf8OFvys0J8lXO9xhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AjrwJYFfu9nv43vbccYyFqsn2ps5V4YTZ1QqUobFiWIWHPZjCFxzftkshxdZZ4B/a0et+YLnuSvddG4ydfltC9+ClQyfyrydS0UAgWI42X3f8MhAKl9oPzUtjNMF/XO17s2OgtbmqzHoajqQ2qUgpddudT19ODJ95ZKpP8OWSRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=C8q/pmMZ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=8XL8jkUO+vnlYnABb9sAmsqhoLg/QQh+QfwYGm1J6NI=; t=1706540047; x=1707749647; 
	b=C8q/pmMZJppNcgu0qk1LJeA0AVL5yN7NULkIZ/pkPKxi3X9KnDBsAKbqF8s0HDM008lPjAsblYl
	0vU/g2h2dtKSaSRvqwyhlgJwOWMW5Uyf3oUADaRbUP1Y+bO8SseOlM0xWQyQjkJ9ygLBDTFwFnCbE
	eCEw7rRcCtNmtXDTzu5N9QxEdB5uxuM20jlrxaMULqNTFo4uuRJi0TL/qFWmpiP2THgLeawbRaBkX
	uZFG+ypcYDoaKXGDgAS3Xv2zNt++F8gImCAzb6VMD4GFsLVufs65OqoLqiZcUGB84LS2x5IpdAe7z
	hjjNlP8pcgUNS3gQhXZ1WHdNhdy7fj7elZVw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUT1Q-00000004tMO-0gZL;
	Mon, 29 Jan 2024 15:54:04 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: mac80211: fix driver debugfs for vif type change
Date: Mon, 29 Jan 2024 15:54:02 +0100
Message-ID: <20240129155402.7311a36ffeeb.I18df02bbeb685d4250911de5ffbaf090f60c3803@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If a driver implements the change_interface() method, we switch
interface type without taking the interface down, but still will
recreate the debugfs for it since it's a new type. As such, we
should use the ieee80211_debugfs_recreate_netdev() function here
to also recreate the driver's files, if it is indeed from a type
change while up.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/debugfs_netdev.c | 4 ++--
 net/mac80211/debugfs_netdev.h | 5 -----
 net/mac80211/iface.c          | 2 +-
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index dce5606ed66d..68596ef78b15 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -997,8 +997,8 @@ static void add_link_files(struct ieee80211_link_data *link,
 	}
 }
 
-void ieee80211_debugfs_add_netdev(struct ieee80211_sub_if_data *sdata,
-				  bool mld_vif)
+static void ieee80211_debugfs_add_netdev(struct ieee80211_sub_if_data *sdata,
+					 bool mld_vif)
 {
 	char buf[10+IFNAMSIZ];
 
diff --git a/net/mac80211/debugfs_netdev.h b/net/mac80211/debugfs_netdev.h
index b226b1aae88a..a02ec0a413f6 100644
--- a/net/mac80211/debugfs_netdev.h
+++ b/net/mac80211/debugfs_netdev.h
@@ -11,8 +11,6 @@
 #include "ieee80211_i.h"
 
 #ifdef CONFIG_MAC80211_DEBUGFS
-void ieee80211_debugfs_add_netdev(struct ieee80211_sub_if_data *sdata,
-				  bool mld_vif);
 void ieee80211_debugfs_remove_netdev(struct ieee80211_sub_if_data *sdata);
 void ieee80211_debugfs_rename_netdev(struct ieee80211_sub_if_data *sdata);
 void ieee80211_debugfs_recreate_netdev(struct ieee80211_sub_if_data *sdata,
@@ -24,9 +22,6 @@ void ieee80211_link_debugfs_remove(struct ieee80211_link_data *link);
 void ieee80211_link_debugfs_drv_add(struct ieee80211_link_data *link);
 void ieee80211_link_debugfs_drv_remove(struct ieee80211_link_data *link);
 #else
-static inline void ieee80211_debugfs_add_netdev(
-	struct ieee80211_sub_if_data *sdata, bool mld_vif)
-{}
 static inline void ieee80211_debugfs_remove_netdev(
 	struct ieee80211_sub_if_data *sdata)
 {}
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index e4e7c0b38cb6..11c4caa4748e 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1783,7 +1783,7 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 	/* need to do this after the switch so vif.type is correct */
 	ieee80211_link_setup(&sdata->deflink);
 
-	ieee80211_debugfs_add_netdev(sdata, false);
+	ieee80211_debugfs_recreate_netdev(sdata, false);
 }
 
 static int ieee80211_runtime_change_iftype(struct ieee80211_sub_if_data *sdata,
-- 
2.43.0


