Return-Path: <linux-wireless+bounces-14321-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F9E9AA2E2
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 15:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E9F1281D10
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 13:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11E719D091;
	Tue, 22 Oct 2024 13:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="v9ly9S9y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED7619ABD5;
	Tue, 22 Oct 2024 13:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729603126; cv=none; b=T6pvncHOkFMtdfTxLdrfTHQjw87S63rspEseph5E1ZVC8kTZVB94QTE7cUkcUv927ZKh/g3SZNKsBA+iXl15G78a1VfsHB/69gWTT+3baE4Qhd+n+8l4JipfMU5Nhr9IiKK6KUBxNatJ3hyHeEHTLrSc0guM4Inco8PN/joXRY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729603126; c=relaxed/simple;
	bh=Ebw0s5F3gKfIoGus8fTKW6p5wb7MYNVgWuHs6UkEPnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GdEYqP0dRT1lEGcBXsmf5bf+lA9cGcjngkNbAlMgfwZjwjhrueVXkAyTj9XDwtLT9sRU+WlEqEpBRm1zvSk5PftlHBuMgT5+FdxGlToLyjQVQJi50wNK4YR03k6Xhnj8321Rfqi60jpdfZuTzsH88gXidcxaoVgAM7IqnyuoIo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=v9ly9S9y; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bZi7ISyDcwW1dSQ4MHPv4oMhlZBUooivHxpP/uCSsd0=;
	t=1729603125; x=1730812725; b=v9ly9S9yMl/bVfo3SuqmZUVM8+GczldsbBXlHV96B1sV/qT
	VOWyGoMknmlzQc1yMyN/3v84/emBytgbxbbSzwKQ2M+lFvRBoaYU454WuxcF1IrIaI/LiUH/4cbis
	AdNsUTKeJaFei3yWR+JRLytz1NxyZNCSYR3jZTJv8P4To41up18GL8knFLY32VQ8lZIrYXCTukZVd
	Gh4tReWFWngfLlUBK/q1M3wr1RbA7r+5DBbTMjbBvSBiJCtK0XHyq5ckeeHY3+a6W0T1wwuhaR8Yp
	PKQ6aEgeFOFbxxJzoWDIeZUYIu3MRAhIKHTHPI7UqD7c4KZ/auurSAoebWwWSEGg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t3EmX-00000001kNb-2TpS;
	Tue, 22 Oct 2024 15:18:41 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/2] wifi: mac80211: convert debugfs files to short fops
Date: Tue, 22 Oct 2024 15:18:35 +0200
Message-ID: <20241022151838.2f6de3ea3ecc.I45657e6a8415d796ec95c95becc9efb377ee3be6@changeid>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241022151838.26f9925fb959.Ia80b55e934bbfc45ce0df42a3233d34b35508046@changeid>
References: <20241022151838.26f9925fb959.Ia80b55e934bbfc45ce0df42a3233d34b35508046@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Given the large size of the regular struct file_operations, save
a lot of space with the newly added short fops for debugfs.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/debugfs.c        | 27 +++++++++------------------
 net/mac80211/debugfs_key.c    |  9 +++------
 net/mac80211/debugfs_netdev.c |  3 +--
 net/mac80211/debugfs_sta.c    |  9 +++------
 net/mac80211/rate.c           |  3 +--
 net/mac80211/rate.h           |  2 +-
 6 files changed, 18 insertions(+), 35 deletions(-)

diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 02b5476a4376..c52e85829e71 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -42,9 +42,8 @@ static ssize_t name## _read(struct file *file, char __user *userbuf,	\
 }
 
 #define DEBUGFS_READONLY_FILE_OPS(name)			\
-static const struct file_operations name## _ops = {			\
+static const struct debugfs_short_fops name## _ops = {				\
 	.read = name## _read,						\
-	.open = simple_open,						\
 	.llseek = generic_file_llseek,					\
 };
 
@@ -142,10 +141,9 @@ static ssize_t aqm_write(struct file *file,
 	return -EINVAL;
 }
 
-static const struct file_operations aqm_ops = {
+static const struct debugfs_short_fops aqm_ops = {
 	.write = aqm_write,
 	.read = aqm_read,
-	.open = simple_open,
 	.llseek = default_llseek,
 };
 
@@ -194,10 +192,9 @@ static ssize_t airtime_flags_write(struct file *file,
 	return count;
 }
 
-static const struct file_operations airtime_flags_ops = {
+static const struct debugfs_short_fops airtime_flags_ops = {
 	.write = airtime_flags_write,
 	.read = airtime_flags_read,
-	.open = simple_open,
 	.llseek = default_llseek,
 };
 
@@ -225,9 +222,8 @@ static ssize_t aql_pending_read(struct file *file,
 				       buf, len);
 }
 
-static const struct file_operations aql_pending_ops = {
+static const struct debugfs_short_fops aql_pending_ops = {
 	.read = aql_pending_read,
-	.open = simple_open,
 	.llseek = default_llseek,
 };
 
@@ -305,10 +301,9 @@ static ssize_t aql_txq_limit_write(struct file *file,
 	return count;
 }
 
-static const struct file_operations aql_txq_limit_ops = {
+static const struct debugfs_short_fops aql_txq_limit_ops = {
 	.write = aql_txq_limit_write,
 	.read = aql_txq_limit_read,
-	.open = simple_open,
 	.llseek = default_llseek,
 };
 
@@ -355,10 +350,9 @@ static ssize_t aql_enable_write(struct file *file, const char __user *user_buf,
 	return count;
 }
 
-static const struct file_operations aql_enable_ops = {
+static const struct debugfs_short_fops aql_enable_ops = {
 	.write = aql_enable_write,
 	.read = aql_enable_read,
-	.open = simple_open,
 	.llseek = default_llseek,
 };
 
@@ -406,10 +400,9 @@ static ssize_t force_tx_status_write(struct file *file,
 	return count;
 }
 
-static const struct file_operations force_tx_status_ops = {
+static const struct debugfs_short_fops force_tx_status_ops = {
 	.write = force_tx_status_write,
 	.read = force_tx_status_read,
-	.open = simple_open,
 	.llseek = default_llseek,
 };
 
@@ -434,9 +427,8 @@ static ssize_t reset_write(struct file *file, const char __user *user_buf,
 	return count;
 }
 
-static const struct file_operations reset_ops = {
+static const struct debugfs_short_fops reset_ops = {
 	.write = reset_write,
-	.open = simple_open,
 	.llseek = noop_llseek,
 };
 #endif
@@ -623,9 +615,8 @@ static ssize_t stats_ ##name## _read(struct file *file,			\
 				      print_devstats_##name);		\
 }									\
 									\
-static const struct file_operations stats_ ##name## _ops = {		\
+static const struct debugfs_short_fops stats_ ##name## _ops = {			\
 	.read = stats_ ##name## _read,					\
-	.open = simple_open,						\
 	.llseek = generic_file_llseek,					\
 };
 
diff --git a/net/mac80211/debugfs_key.c b/net/mac80211/debugfs_key.c
index 7e54da508765..b3a64edea0f2 100644
--- a/net/mac80211/debugfs_key.c
+++ b/net/mac80211/debugfs_key.c
@@ -26,17 +26,15 @@ static ssize_t key_##name##_read(struct file *file,			\
 #define KEY_READ_X(name) KEY_READ(name, name, "0x%x\n")
 
 #define KEY_OPS(name)							\
-static const struct file_operations key_ ##name## _ops = {		\
+static const struct debugfs_short_fops key_ ##name## _ops = {		\
 	.read = key_##name##_read,					\
-	.open = simple_open,						\
 	.llseek = generic_file_llseek,					\
 }
 
 #define KEY_OPS_W(name)							\
-static const struct file_operations key_ ##name## _ops = {		\
+static const struct debugfs_short_fops key_ ##name## _ops = {		\
 	.read = key_##name##_read,					\
 	.write = key_##name##_write,					\
-	.open = simple_open,						\
 	.llseek = generic_file_llseek,					\
 }
 
@@ -49,9 +47,8 @@ static const struct file_operations key_ ##name## _ops = {		\
 #define KEY_CONF_READ_D(name) KEY_CONF_READ(name, "%d\n")
 
 #define KEY_CONF_OPS(name)						\
-static const struct file_operations key_ ##name## _ops = {		\
+static const struct debugfs_short_fops key_ ##name## _ops = {		\
 	.read = key_conf_##name##_read,					\
-	.open = simple_open,						\
 	.llseek = generic_file_llseek,					\
 }
 
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index 68596ef78b15..a9bc2fd59f55 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -221,10 +221,9 @@ static ssize_t ieee80211_if_fmt_##name(					\
 }
 
 #define _IEEE80211_IF_FILE_OPS(name, _read, _write)			\
-static const struct file_operations name##_ops = {			\
+static const struct debugfs_short_fops name##_ops = {				\
 	.read = (_read),						\
 	.write = (_write),						\
-	.open = simple_open,						\
 	.llseek = generic_file_llseek,					\
 }
 
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index 1e9389c49a57..a67a9d316008 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -30,17 +30,15 @@ static ssize_t sta_ ##name## _read(struct file *file,			\
 #define STA_READ_D(name, field) STA_READ(name, field, "%d\n")
 
 #define STA_OPS(name)							\
-static const struct file_operations sta_ ##name## _ops = {		\
+static const struct debugfs_short_fops sta_ ##name## _ops = {		\
 	.read = sta_##name##_read,					\
-	.open = simple_open,						\
 	.llseek = generic_file_llseek,					\
 }
 
 #define STA_OPS_RW(name)						\
-static const struct file_operations sta_ ##name## _ops = {		\
+static const struct debugfs_short_fops sta_ ##name## _ops = {		\
 	.read = sta_##name##_read,					\
 	.write = sta_##name##_write,					\
-	.open = simple_open,						\
 	.llseek = generic_file_llseek,					\
 }
 
@@ -450,9 +448,8 @@ STA_OPS_RW(agg_status);
 
 /* link sta attributes */
 #define LINK_STA_OPS(name)						\
-static const struct file_operations link_sta_ ##name## _ops = {		\
+static const struct debugfs_short_fops link_sta_ ##name## _ops = {		\
 	.read = link_sta_##name##_read,					\
-	.open = simple_open,						\
 	.llseek = generic_file_llseek,					\
 }
 
diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index 3dc9752188d5..d1577c88b932 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -229,9 +229,8 @@ static ssize_t rcname_read(struct file *file, char __user *userbuf,
 				       ref->ops->name, len);
 }
 
-const struct file_operations rcname_ops = {
+const struct debugfs_short_fops rcname_ops = {
 	.read = rcname_read,
-	.open = simple_open,
 	.llseek = default_llseek,
 };
 #endif
diff --git a/net/mac80211/rate.h b/net/mac80211/rate.h
index d6190f10fe7c..d3f46e26453c 100644
--- a/net/mac80211/rate.h
+++ b/net/mac80211/rate.h
@@ -62,7 +62,7 @@ static inline void rate_control_add_sta_debugfs(struct sta_info *sta)
 #endif
 }
 
-extern const struct file_operations rcname_ops;
+extern const struct debugfs_short_fops rcname_ops;
 
 static inline void rate_control_add_debugfs(struct ieee80211_local *local)
 {
-- 
2.47.0


