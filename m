Return-Path: <linux-wireless+bounces-15200-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C289C56BD
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 12:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12B521F21470
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 11:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD62230992;
	Tue, 12 Nov 2024 11:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QiWYUpD3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45445230989
	for <linux-wireless@vger.kernel.org>; Tue, 12 Nov 2024 11:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731411458; cv=none; b=iy/gzxnMNSYNOkSeL/v7/XulmiQeYWobilFQ6MbD5UMhdErcOY94p4LGA9jt127bFURZfz/5ZI68nWIEmaKbvvpjZp4ppXy1XATQ77bz4CDMGZ3WENsV72N8hJ8UxivJA8sTR6mYntHBjWiMjje6k6fBDZlJj/hhwFfeSXpUHyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731411458; c=relaxed/simple;
	bh=vKNTB/DHoNh3OgrRZHvvhigHNs1+ixtuKDCFkKWWLMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bLXo4nKkZUfMM57zjVvu0Pnaq9ZPVzf4QV+x1V6OXO76vbvRAy6stW1Or064MmQ/0itomCyz7utmXr8GwWlzIJbwRPR1bLvc1Qt88IUOugi5JpFpjSqFdwp8zFFtyjKQJA8Jzg718hIdL/wGolWi99EWuysS393rDc6P3Z7n9KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QiWYUpD3; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=Zw0ABLG+0Iu+k2ouAWnrUj4k0dL9eT9Rli6FjzwCAJo=; t=1731411456; x=1732621056; 
	b=QiWYUpD3rk+q34BUltSpniW8ZitsepOmDCX6Wfjr5fNHvxV84zQdC9XwJc9+nlieXPglKC205vE
	1y/3Zkl0ccNUkvmi/pu7kFyX7e4KmEeCw4wUhvVA4IGjnkitVkrU8/QC6tAapc1Jdf94WPecA8x30
	eV1TjrK5LOFXVb+z2KhYQ8m2u/zeKjezTM/X8CFNY0OveXR6Rlra2NAIgGG8K4mzflHvcNqm9vfQI
	O4p1AK6Mjy35BjAP6toeWZ5qbu04bDax91grs5DuEaRtdssh2gtierSpFkQe4YROEDwb2Td2BWztU
	i001Ps3V4KJDM0xof7fPQ8yM/BJ3jXtACKbg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tApD4-00000002woT-3H6I;
	Tue, 12 Nov 2024 12:37:27 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH] wifi: cfg80211: allow NULL buf with wiphy-locked debugfs
Date: Tue, 12 Nov 2024 12:37:24 +0100
Message-ID: <20241112123724.5213bdd067b4.Ieb1b56f2bf094b1359f52a8a6ef462424cd11790@changeid>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Allow passing NULL for the buf to allocate the needed size
(bufsize is still passed). In case the needed size is more
than would easily fit on the stack we can handle that here
instead of requiring each user to do it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h |  6 ++++--
 net/wireless/debugfs.c | 28 +++++++++++++++++++++++-----
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 27acf1292a5c..ad9b938aad29 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -9715,7 +9715,8 @@ void cfg80211_schedule_channels_check(struct wireless_dev *wdev);
  * wiphy_locked_debugfs_read - do a locked read in debugfs
  * @wiphy: the wiphy to use
  * @file: the file being read
- * @buf: the buffer to fill and then read from
+ * @buf: the buffer to fill and then read from, can be %NULL
+ *	to allocate a buffer of @bufsize size
  * @bufsize: size of the buffer
  * @userbuf: the user buffer to copy to
  * @count: read count
@@ -9740,7 +9741,8 @@ ssize_t wiphy_locked_debugfs_read(struct wiphy *wiphy, struct file *file,
  * wiphy_locked_debugfs_write - do a locked write in debugfs
  * @wiphy: the wiphy to use
  * @file: the file being written to
- * @buf: the buffer to copy the user data to
+ * @buf: the buffer to copy the user data to, can be %NULL
+ *	to allocate a buffer of @bufsize size
  * @bufsize: size of the buffer
  * @userbuf: the user buffer to copy from
  * @count: read count
diff --git a/net/wireless/debugfs.c b/net/wireless/debugfs.c
index 40e49074e2ee..e78013cbf43a 100644
--- a/net/wireless/debugfs.c
+++ b/net/wireless/debugfs.c
@@ -160,7 +160,6 @@ ssize_t wiphy_locked_debugfs_read(struct wiphy *wiphy, struct file *file,
 		.handler = handler,
 		.wiphy = wiphy,
 		.file = file,
-		.buf = buf,
 		.bufsize = bufsize,
 		.data = data,
 		.ret = -ENODEV,
@@ -170,10 +169,19 @@ ssize_t wiphy_locked_debugfs_read(struct wiphy *wiphy, struct file *file,
 		.cancel = wiphy_locked_debugfs_read_cancel,
 		.cancel_data = &work,
 	};
+	void *tmp __free(kfree) = NULL;
 
-	/* don't leak stack data or whatever */
-	memset(buf, 0, bufsize);
+	if (buf) {
+		/* don't leak stack data or whatever */
+		memset(buf, 0, bufsize);
+	} else {
+		tmp = kzalloc(bufsize, GFP_KERNEL);
+		if (!tmp)
+			return -ENOMEM;
+		buf = tmp;
+	}
 
+	work.buf = buf;
 	wiphy_work_init(&work.work, wiphy_locked_debugfs_read_work);
 	wiphy_work_queue(wiphy, &work.work);
 
@@ -239,7 +247,6 @@ ssize_t wiphy_locked_debugfs_write(struct wiphy *wiphy,
 		.handler = handler,
 		.wiphy = wiphy,
 		.file = file,
-		.buf = buf,
 		.count = count,
 		.data = data,
 		.ret = -ENODEV,
@@ -249,12 +256,23 @@ ssize_t wiphy_locked_debugfs_write(struct wiphy *wiphy,
 		.cancel = wiphy_locked_debugfs_write_cancel,
 		.cancel_data = &work,
 	};
+	void *tmp __free(kfree) = NULL;
 
 	/* mostly used for strings so enforce NUL-termination for safety */
 	if (count >= bufsize)
 		return -EINVAL;
 
-	memset(buf, 0, bufsize);
+	if (buf) {
+		/* don't leak stack data or whatever */
+		memset(buf, 0, bufsize);
+	} else {
+		tmp = kzalloc(bufsize, GFP_KERNEL);
+		if (!tmp)
+			return -ENOMEM;
+		buf = tmp;
+	}
+
+	work.buf = buf;
 
 	if (copy_from_user(buf, userbuf, count))
 		return -EFAULT;
-- 
2.47.0


