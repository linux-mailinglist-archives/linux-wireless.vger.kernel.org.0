Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB312F0273
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Jan 2021 19:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbhAIR6u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 9 Jan 2021 12:58:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:41958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbhAIR6u (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 9 Jan 2021 12:58:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25E64239FE;
        Sat,  9 Jan 2021 17:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610215089;
        bh=brtHD0NLnmrz6mWYTIuQ2iCN136lnIO0o8MoWQg3S3s=;
        h=From:To:Cc:Subject:Date:From;
        b=UGeY7riIC7pO6FirWENKmsOmPe5ey/DNlevObWEVddwED3oTHdRJhAKUMcr478j6+
         xMfIzdH+Ozrokn/+MgmrHj1F3Fz8o1th7hDL1jupNBPFgfos/E1hFmN/XVKL/EWnvd
         ZtewlQif5FcO18+JE6b2m2t8nggRJd7FVLqeryllVu2dfq93OmDc/hpg9+cvuqjA9p
         yGbzXAMWZQ4ZS2C1Y36JiaqqIHo3IYJ25XaP1ZIm5Jhko3hdpWxRD30dVN+xxqBQ01
         5Yi1Lc8C5LVWQlhgDurRAndwN+xzPUSA1s9ArQsnHJ9Nz4QCgtOhNbPk7Mbtypk90Z
         UjKiVETNsFmlQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, johannes@sipsolutions.net,
        toke@redhat.com
Subject: [PATCH v2 mac80211-next] mac80211: introduce aql_enable node in debugfs
Date:   Sat,  9 Jan 2021 18:57:51 +0100
Message-Id: <e7a934d5d84e4796c4f97ea5de4e66c824296b07.1610214851.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce aql_enable node in debugfs in order to enable/disable aql.
This is useful for debugging purpose.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v1:
- rely on static_key to reduce overhead
---
 net/mac80211/debugfs.c     | 51 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/ieee80211_i.h |  2 ++
 net/mac80211/tx.c          |  5 ++++
 3 files changed, 58 insertions(+)

diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 48f144f107d5..c97443f59063 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -284,6 +284,56 @@ static const struct file_operations aql_txq_limit_ops = {
 	.llseek = default_llseek,
 };
 
+static ssize_t aql_enable_read(struct file *file, char __user *user_buf,
+			       size_t count, loff_t *ppos)
+{
+	char buf[3];
+	int len;
+
+	len = scnprintf(buf, sizeof(buf), "%d\n",
+			!static_key_false(&aql_disable.key));
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static ssize_t aql_enable_write(struct file *file, const char __user *user_buf,
+				size_t count, loff_t *ppos)
+{
+	bool aql_disabled = static_key_false(&aql_disable.key);
+	char buf[3];
+	size_t len;
+
+	if (count > sizeof(buf))
+		return -EINVAL;
+
+	if (copy_from_user(buf, user_buf, count))
+		return -EFAULT;
+
+	buf[sizeof(buf) - 1] = '\0';
+	len = strlen(buf);
+	if (len > 0 && buf[len - 1] == '\n')
+		buf[len - 1] = 0;
+
+	if (buf[0] == '0' && buf[1] == '\0') {
+		if (!aql_disabled)
+			static_branch_inc(&aql_disable);
+	} else if (buf[0] == '1' && buf[1] == '\0') {
+		if (aql_disabled)
+			static_branch_dec(&aql_disable);
+	} else {
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static const struct file_operations aql_enable_ops = {
+	.write = aql_enable_write,
+	.read = aql_enable_read,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+
 static ssize_t force_tx_status_read(struct file *file,
 				    char __user *user_buf,
 				    size_t count,
@@ -572,6 +622,7 @@ void debugfs_hw_add(struct ieee80211_local *local)
 	DEBUGFS_ADD(power);
 	DEBUGFS_ADD(hw_conf);
 	DEBUGFS_ADD_MODE(force_tx_status, 0600);
+	DEBUGFS_ADD_MODE(aql_enable, 0600);
 
 	if (local->ops->wake_tx_queue)
 		DEBUGFS_ADD_MODE(aqm, 0600);
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 8bf9c0e974d6..c7685273570f 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1143,6 +1143,8 @@ enum mac80211_scan_state {
 	SCAN_ABORT,
 };
 
+DECLARE_STATIC_KEY_FALSE(aql_disable);
+
 struct ieee80211_local {
 	/* embed the driver visible part.
 	 * don't cast (use the static inlines below), but we keep
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 6422da6690f7..f00f6e80261b 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3823,6 +3823,8 @@ void __ieee80211_schedule_txq(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL(__ieee80211_schedule_txq);
 
+DEFINE_STATIC_KEY_FALSE(aql_disable);
+
 bool ieee80211_txq_airtime_check(struct ieee80211_hw *hw,
 				 struct ieee80211_txq *txq)
 {
@@ -3832,6 +3834,9 @@ bool ieee80211_txq_airtime_check(struct ieee80211_hw *hw,
 	if (!wiphy_ext_feature_isset(local->hw.wiphy, NL80211_EXT_FEATURE_AQL))
 		return true;
 
+	if (static_branch_unlikely(&aql_disable))
+		return true;
+
 	if (!txq->sta)
 		return true;
 
-- 
2.29.2

