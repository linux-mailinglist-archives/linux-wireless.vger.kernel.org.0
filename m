Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0160D78AF84
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjH1MFp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjH1MFX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:23 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A8611A
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=bMD2pwxE7pCJvq60eOkiegmTX5zAWg2Zm3oYJd6ua0U=;
        t=1693224321; x=1694433921; b=xjtIX6lPavWaLazYSKIJ6g/FqUfUMTPWCn6LwypOEq0BCiv
        GUwbJd4JX8A1o+OEB/OuahOXnbt1KzzWdrKplDShVMOuwYxV2sylh4wAa2ISA1xA8YqX+bQn7OVzy
        26Vdq/LhpY/mRdUXZC3N6tZR/STxThukID9KSDeS1xe3PDOpTHc75VeS5jV7uybMEdfdhUmmwPKSJ
        26eEO8xXY20rMoLvgEtVHtNcbxUywkOtfJWuSR63Y5wGKxkBOhbO7w4+a6k4MG/cUgwSCki5DfF1E
        kfAxMbUU/p3r6iefEH0SjGYa4Q2O6NAxu7KAJn8f84qLdr8j/fWdu182n8e6ArHQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qaazf-00Gjgt-0F;
        Mon, 28 Aug 2023 14:05:19 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 02/40] wifi: mac80211: hold wiphy lock in netdev/link debugfs
Date:   Mon, 28 Aug 2023 13:59:30 +0200
Message-ID: <20230828135927.e3c99daad33e.Ic09414bfe7e6b523aca469e402877b3a85bc12af@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828115927.116700-41-johannes@sipsolutions.net>
References: <20230828115927.116700-41-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

It's no longer really needed to ensure that the debugfs
file isn't going away, debugfs handles that. So there's
no point in holding dev_base_lock or RTNL here, but we
should instead hold the wiphy lock since drivers will
be allowed to depend on that. Do that, which requires
splitting the sdata and link macros a bit.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/debugfs_netdev.c | 123 +++++++++++++++++++++++++---------
 1 file changed, 90 insertions(+), 33 deletions(-)

diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index 63250286dc8b..706330fadc97 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -22,18 +22,18 @@
 #include "debugfs_netdev.h"
 #include "driver-ops.h"
 
-static ssize_t ieee80211_if_read(
-	void *data,
+static ssize_t ieee80211_if_read_sdata(
+	struct ieee80211_sub_if_data *sdata,
 	char __user *userbuf,
 	size_t count, loff_t *ppos,
-	ssize_t (*format)(const void *, char *, int))
+	ssize_t (*format)(const struct ieee80211_sub_if_data *sdata, char *, int))
 {
 	char buf[200];
 	ssize_t ret = -EINVAL;
 
-	read_lock(&dev_base_lock);
-	ret = (*format)(data, buf, sizeof(buf));
-	read_unlock(&dev_base_lock);
+	wiphy_lock(sdata->local->hw.wiphy);
+	ret = (*format)(sdata, buf, sizeof(buf));
+	wiphy_unlock(sdata->local->hw.wiphy);
 
 	if (ret >= 0)
 		ret = simple_read_from_buffer(userbuf, count, ppos, buf, ret);
@@ -41,11 +41,11 @@ static ssize_t ieee80211_if_read(
 	return ret;
 }
 
-static ssize_t ieee80211_if_write(
-	void *data,
+static ssize_t ieee80211_if_write_sdata(
+	struct ieee80211_sub_if_data *sdata,
 	const char __user *userbuf,
 	size_t count, loff_t *ppos,
-	ssize_t (*write)(void *, const char *, int))
+	ssize_t (*write)(struct ieee80211_sub_if_data *sdata, const char *, int))
 {
 	char buf[64];
 	ssize_t ret;
@@ -57,9 +57,51 @@ static ssize_t ieee80211_if_write(
 		return -EFAULT;
 	buf[count] = '\0';
 
-	rtnl_lock();
-	ret = (*write)(data, buf, count);
-	rtnl_unlock();
+	wiphy_lock(sdata->local->hw.wiphy);
+	ret = (*write)(sdata, buf, count);
+	wiphy_unlock(sdata->local->hw.wiphy);
+
+	return ret;
+}
+
+static ssize_t ieee80211_if_read_link(
+	struct ieee80211_link_data *link,
+	char __user *userbuf,
+	size_t count, loff_t *ppos,
+	ssize_t (*format)(const struct ieee80211_link_data *link, char *, int))
+{
+	char buf[200];
+	ssize_t ret = -EINVAL;
+
+	wiphy_lock(link->sdata->local->hw.wiphy);
+	ret = (*format)(link, buf, sizeof(buf));
+	wiphy_unlock(link->sdata->local->hw.wiphy);
+
+	if (ret >= 0)
+		ret = simple_read_from_buffer(userbuf, count, ppos, buf, ret);
+
+	return ret;
+}
+
+static ssize_t ieee80211_if_write_link(
+	struct ieee80211_link_data *link,
+	const char __user *userbuf,
+	size_t count, loff_t *ppos,
+	ssize_t (*write)(struct ieee80211_link_data *link, const char *, int))
+{
+	char buf[64];
+	ssize_t ret;
+
+	if (count >= sizeof(buf))
+		return -E2BIG;
+
+	if (copy_from_user(buf, userbuf, count))
+		return -EFAULT;
+	buf[count] = '\0';
+
+	wiphy_lock(link->sdata->local->hw.wiphy);
+	ret = (*write)(link, buf, count);
+	wiphy_unlock(link->sdata->local->hw.wiphy);
 
 	return ret;
 }
@@ -126,41 +168,37 @@ static const struct file_operations name##_ops = {			\
 	.llseek = generic_file_llseek,					\
 }
 
-#define _IEEE80211_IF_FILE_R_FN(name, type)				\
+#define _IEEE80211_IF_FILE_R_FN(name)					\
 static ssize_t ieee80211_if_read_##name(struct file *file,		\
 					char __user *userbuf,		\
 					size_t count, loff_t *ppos)	\
 {									\
-	ssize_t (*fn)(const void *, char *, int) = (void *)		\
-		((ssize_t (*)(const type, char *, int))			\
-		 ieee80211_if_fmt_##name);				\
-	return ieee80211_if_read(file->private_data,			\
-				 userbuf, count, ppos, fn);		\
+	return ieee80211_if_read_sdata(file->private_data,		\
+				       userbuf, count, ppos,		\
+				       ieee80211_if_fmt_##name);	\
 }
 
-#define _IEEE80211_IF_FILE_W_FN(name, type)				\
+#define _IEEE80211_IF_FILE_W_FN(name)					\
 static ssize_t ieee80211_if_write_##name(struct file *file,		\
 					 const char __user *userbuf,	\
 					 size_t count, loff_t *ppos)	\
 {									\
-	ssize_t (*fn)(void *, const char *, int) = (void *)		\
-		((ssize_t (*)(type, const char *, int))			\
-		 ieee80211_if_parse_##name);				\
-	return ieee80211_if_write(file->private_data, userbuf, count,	\
-				  ppos, fn);				\
+	return ieee80211_if_write_sdata(file->private_data, userbuf,	\
+					count, ppos,			\
+					ieee80211_if_parse_##name);	\
 }
 
 #define IEEE80211_IF_FILE_R(name)					\
-	_IEEE80211_IF_FILE_R_FN(name, struct ieee80211_sub_if_data *)	\
+	_IEEE80211_IF_FILE_R_FN(name)					\
 	_IEEE80211_IF_FILE_OPS(name, ieee80211_if_read_##name, NULL)
 
 #define IEEE80211_IF_FILE_W(name)					\
-	_IEEE80211_IF_FILE_W_FN(name, struct ieee80211_sub_if_data *)	\
+	_IEEE80211_IF_FILE_W_FN(name)					\
 	_IEEE80211_IF_FILE_OPS(name, NULL, ieee80211_if_write_##name)
 
 #define IEEE80211_IF_FILE_RW(name)					\
-	_IEEE80211_IF_FILE_R_FN(name, struct ieee80211_sub_if_data *)	\
-	_IEEE80211_IF_FILE_W_FN(name, struct ieee80211_sub_if_data *)	\
+	_IEEE80211_IF_FILE_R_FN(name)					\
+	_IEEE80211_IF_FILE_W_FN(name)					\
 	_IEEE80211_IF_FILE_OPS(name, ieee80211_if_read_##name,		\
 			       ieee80211_if_write_##name)
 
@@ -168,18 +206,37 @@ static ssize_t ieee80211_if_write_##name(struct file *file,		\
 	IEEE80211_IF_FMT_##format(name, struct ieee80211_sub_if_data, field) \
 	IEEE80211_IF_FILE_R(name)
 
-/* Same but with a link_ prefix in the ops variable name and different type */
+#define _IEEE80211_IF_LINK_R_FN(name)					\
+static ssize_t ieee80211_if_read_##name(struct file *file,		\
+					char __user *userbuf,		\
+					size_t count, loff_t *ppos)	\
+{									\
+	return ieee80211_if_read_link(file->private_data,		\
+				      userbuf, count, ppos,		\
+				      ieee80211_if_fmt_##name);	\
+}
+
+#define _IEEE80211_IF_LINK_W_FN(name)					\
+static ssize_t ieee80211_if_write_##name(struct file *file,		\
+					 const char __user *userbuf,	\
+					 size_t count, loff_t *ppos)	\
+{									\
+	return ieee80211_if_write_link(file->private_data, userbuf,	\
+				       count, ppos,			\
+				       ieee80211_if_parse_##name);	\
+}
+
 #define IEEE80211_IF_LINK_FILE_R(name)					\
-	_IEEE80211_IF_FILE_R_FN(name, struct ieee80211_link_data *)	\
+	_IEEE80211_IF_LINK_R_FN(name)					\
 	_IEEE80211_IF_FILE_OPS(link_##name, ieee80211_if_read_##name, NULL)
 
 #define IEEE80211_IF_LINK_FILE_W(name)					\
-	_IEEE80211_IF_FILE_W_FN(name)					\
+	_IEEE80211_IF_LINK_W_FN(name)					\
 	_IEEE80211_IF_FILE_OPS(link_##name, NULL, ieee80211_if_write_##name)
 
 #define IEEE80211_IF_LINK_FILE_RW(name)					\
-	_IEEE80211_IF_FILE_R_FN(name, struct ieee80211_link_data *)	\
-	_IEEE80211_IF_FILE_W_FN(name, struct ieee80211_link_data *)	\
+	_IEEE80211_IF_LINK_R_FN(name)					\
+	_IEEE80211_IF_LINK_W_FN(name)					\
 	_IEEE80211_IF_FILE_OPS(link_##name, ieee80211_if_read_##name,	\
 			       ieee80211_if_write_##name)
 
-- 
2.41.0

