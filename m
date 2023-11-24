Return-Path: <linux-wireless+bounces-59-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 702DB7F791A
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 17:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 938EC1C20A60
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 16:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF12381AE;
	Fri, 24 Nov 2023 16:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="rVyZeHaC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4255C19A9;
	Fri, 24 Nov 2023 08:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=MUXidifnbmrT+lPICjftrAHoNPFMVQW1b1Sa6v/Ia/k=;
	t=1700843722; x=1702053322; b=rVyZeHaCbEZbZ/qU3M0JI/yJBcit7AjwfmuBpVQ/QywYqBU
	7pdJrYkha5hv1CKNwS35NhFbYRdXInHXjyT5jF/hbcpyrm8LsWSXWArZc87cMW/BuKUcDRZX0GJoz
	jU1BymzxgmpUjJDLjKSfSoRCE4xlG7hVRrhXWDbUGiR5N+rf/YLvnSvEhyD02Tb0eW1w5OS5d3qf3
	VBEo5vicYBFgAPZGkS9BRWP5AGToNPotZZPLnNV5rJPOCfpGwa+ECmJUgppDTqLXXuZ6VGUw9G8q6
	ycvXPpCN8jPrYTtM52HXY+9stPrpWBiVxFojmTuRQZha78XJzzGRNu3Fl4k2d6Yw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r6Z9D-00000002fA8-3DhM;
	Fri, 24 Nov 2023 17:35:20 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 6/6] wifi: mac80211: use wiphy locked debugfs for sdata/link
Date: Fri, 24 Nov 2023 17:25:29 +0100
Message-ID: <20231124172522.98baff0ebc5e.I99a21601e124f5ac4e161ad32b19949e7896e390@changeid>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231124162522.16344-7-johannes@sipsolutions.net>
References: <20231124162522.16344-7-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The debugfs files for netdevs (sdata) and links are removed
with the wiphy mutex held, which may deadlock. Use the new
wiphy locked debugfs to avoid that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/debugfs_netdev.c | 150 ++++++++++++++++++++++++----------
 1 file changed, 105 insertions(+), 45 deletions(-)

diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index ec91e131b29e..80aeb25f1b68 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -22,88 +22,148 @@
 #include "debugfs_netdev.h"
 #include "driver-ops.h"
 
+struct ieee80211_if_read_sdata_data {
+	ssize_t (*format)(const struct ieee80211_sub_if_data *, char *, int);
+	struct ieee80211_sub_if_data *sdata;
+};
+
+static ssize_t ieee80211_if_read_sdata_handler(struct wiphy *wiphy,
+					       struct file *file,
+					       char *buf,
+					       size_t bufsize,
+					       void *data)
+{
+	struct ieee80211_if_read_sdata_data *d = data;
+
+	return d->format(d->sdata, buf, bufsize);
+}
+
 static ssize_t ieee80211_if_read_sdata(
-	struct ieee80211_sub_if_data *sdata,
+	struct file *file,
 	char __user *userbuf,
 	size_t count, loff_t *ppos,
 	ssize_t (*format)(const struct ieee80211_sub_if_data *sdata, char *, int))
 {
+	struct ieee80211_sub_if_data *sdata = file->private_data;
+	struct ieee80211_if_read_sdata_data data = {
+		.format = format,
+		.sdata = sdata,
+	};
 	char buf[200];
-	ssize_t ret = -EINVAL;
 
-	wiphy_lock(sdata->local->hw.wiphy);
-	ret = (*format)(sdata, buf, sizeof(buf));
-	wiphy_unlock(sdata->local->hw.wiphy);
+	return wiphy_locked_debugfs_read(sdata->local->hw.wiphy,
+					 file, buf, sizeof(buf),
+					 userbuf, count, ppos,
+					 ieee80211_if_read_sdata_handler,
+					 &data);
+}
 
-	if (ret >= 0)
-		ret = simple_read_from_buffer(userbuf, count, ppos, buf, ret);
+struct ieee80211_if_write_sdata_data {
+	ssize_t (*write)(struct ieee80211_sub_if_data *, const char *, int);
+	struct ieee80211_sub_if_data *sdata;
+};
 
-	return ret;
+static ssize_t ieee80211_if_write_sdata_handler(struct wiphy *wiphy,
+						struct file *file,
+						char *buf,
+						size_t count,
+						void *data)
+{
+	struct ieee80211_if_write_sdata_data *d = data;
+
+	return d->write(d->sdata, buf, count);
 }
 
 static ssize_t ieee80211_if_write_sdata(
-	struct ieee80211_sub_if_data *sdata,
+	struct file *file,
 	const char __user *userbuf,
 	size_t count, loff_t *ppos,
 	ssize_t (*write)(struct ieee80211_sub_if_data *sdata, const char *, int))
 {
+	struct ieee80211_sub_if_data *sdata = file->private_data;
+	struct ieee80211_if_write_sdata_data data = {
+		.write = write,
+		.sdata = sdata,
+	};
 	char buf[64];
-	ssize_t ret;
 
-	if (count >= sizeof(buf))
-		return -E2BIG;
+	return wiphy_locked_debugfs_write(sdata->local->hw.wiphy,
+					  file, buf, sizeof(buf),
+					  userbuf, count,
+					  ieee80211_if_write_sdata_handler,
+					  &data);
+}
 
-	if (copy_from_user(buf, userbuf, count))
-		return -EFAULT;
-	buf[count] = '\0';
+struct ieee80211_if_read_link_data {
+	ssize_t (*format)(const struct ieee80211_link_data *, char *, int);
+	struct ieee80211_link_data *link;
+};
 
-	wiphy_lock(sdata->local->hw.wiphy);
-	ret = (*write)(sdata, buf, count);
-	wiphy_unlock(sdata->local->hw.wiphy);
+static ssize_t ieee80211_if_read_link_handler(struct wiphy *wiphy,
+					      struct file *file,
+					      char *buf,
+					      size_t bufsize,
+					      void *data)
+{
+	struct ieee80211_if_read_link_data *d = data;
 
-	return ret;
+	return d->format(d->link, buf, bufsize);
 }
 
 static ssize_t ieee80211_if_read_link(
-	struct ieee80211_link_data *link,
+	struct file *file,
 	char __user *userbuf,
 	size_t count, loff_t *ppos,
 	ssize_t (*format)(const struct ieee80211_link_data *link, char *, int))
 {
+	struct ieee80211_link_data *link = file->private_data;
+	struct ieee80211_if_read_link_data data = {
+		.format = format,
+		.link = link,
+	};
 	char buf[200];
-	ssize_t ret = -EINVAL;
 
-	wiphy_lock(link->sdata->local->hw.wiphy);
-	ret = (*format)(link, buf, sizeof(buf));
-	wiphy_unlock(link->sdata->local->hw.wiphy);
+	return wiphy_locked_debugfs_read(link->sdata->local->hw.wiphy,
+					 file, buf, sizeof(buf),
+					 userbuf, count, ppos,
+					 ieee80211_if_read_link_handler,
+					 &data);
+}
 
-	if (ret >= 0)
-		ret = simple_read_from_buffer(userbuf, count, ppos, buf, ret);
+struct ieee80211_if_write_link_data {
+	ssize_t (*write)(struct ieee80211_link_data *, const char *, int);
+	struct ieee80211_link_data *link;
+};
 
-	return ret;
+static ssize_t ieee80211_if_write_link_handler(struct wiphy *wiphy,
+					       struct file *file,
+					       char *buf,
+					       size_t count,
+					       void *data)
+{
+	struct ieee80211_if_write_sdata_data *d = data;
+
+	return d->write(d->sdata, buf, count);
 }
 
 static ssize_t ieee80211_if_write_link(
-	struct ieee80211_link_data *link,
+	struct file *file,
 	const char __user *userbuf,
 	size_t count, loff_t *ppos,
 	ssize_t (*write)(struct ieee80211_link_data *link, const char *, int))
 {
+	struct ieee80211_link_data *link = file->private_data;
+	struct ieee80211_if_write_link_data data = {
+		.write = write,
+		.link = link,
+	};
 	char buf[64];
-	ssize_t ret;
 
-	if (count >= sizeof(buf))
-		return -E2BIG;
-
-	if (copy_from_user(buf, userbuf, count))
-		return -EFAULT;
-	buf[count] = '\0';
-
-	wiphy_lock(link->sdata->local->hw.wiphy);
-	ret = (*write)(link, buf, count);
-	wiphy_unlock(link->sdata->local->hw.wiphy);
-
-	return ret;
+	return wiphy_locked_debugfs_write(link->sdata->local->hw.wiphy,
+					  file, buf, sizeof(buf),
+					  userbuf, count,
+					  ieee80211_if_write_link_handler,
+					  &data);
 }
 
 #define IEEE80211_IF_FMT(name, type, field, format_string)		\
@@ -173,7 +233,7 @@ static ssize_t ieee80211_if_read_##name(struct file *file,		\
 					char __user *userbuf,		\
 					size_t count, loff_t *ppos)	\
 {									\
-	return ieee80211_if_read_sdata(file->private_data,		\
+	return ieee80211_if_read_sdata(file,				\
 				       userbuf, count, ppos,		\
 				       ieee80211_if_fmt_##name);	\
 }
@@ -183,7 +243,7 @@ static ssize_t ieee80211_if_write_##name(struct file *file,		\
 					 const char __user *userbuf,	\
 					 size_t count, loff_t *ppos)	\
 {									\
-	return ieee80211_if_write_sdata(file->private_data, userbuf,	\
+	return ieee80211_if_write_sdata(file, userbuf,			\
 					count, ppos,			\
 					ieee80211_if_parse_##name);	\
 }
@@ -211,7 +271,7 @@ static ssize_t ieee80211_if_read_##name(struct file *file,		\
 					char __user *userbuf,		\
 					size_t count, loff_t *ppos)	\
 {									\
-	return ieee80211_if_read_link(file->private_data,		\
+	return ieee80211_if_read_link(file,				\
 				      userbuf, count, ppos,		\
 				      ieee80211_if_fmt_##name);	\
 }
@@ -221,7 +281,7 @@ static ssize_t ieee80211_if_write_##name(struct file *file,		\
 					 const char __user *userbuf,	\
 					 size_t count, loff_t *ppos)	\
 {									\
-	return ieee80211_if_write_link(file->private_data, userbuf,	\
+	return ieee80211_if_write_link(file, userbuf,			\
 				       count, ppos,			\
 				       ieee80211_if_parse_##name);	\
 }
-- 
2.42.0


