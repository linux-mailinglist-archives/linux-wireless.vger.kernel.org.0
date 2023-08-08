Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310B6773C27
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Aug 2023 18:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjHHQA6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Aug 2023 12:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjHHP7Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Aug 2023 11:59:16 -0400
Received: from forward201a.mail.yandex.net (forward201a.mail.yandex.net [178.154.239.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AA1619B
        for <linux-wireless@vger.kernel.org>; Tue,  8 Aug 2023 08:44:27 -0700 (PDT)
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
        by forward201a.mail.yandex.net (Yandex) with ESMTP id C080C6260D
        for <linux-wireless@vger.kernel.org>; Tue,  8 Aug 2023 18:26:53 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net [IPv6:2a02:6b8:c18:3c99:0:640:7c39:0])
        by forward103a.mail.yandex.net (Yandex) with ESMTP id 5B5C346CCB;
        Tue,  8 Aug 2023 18:26:49 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id jQaGdD4DR0U0-1itXzdJu;
        Tue, 08 Aug 2023 18:26:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1691508409;
        bh=vKyyIskcvzvxtICJ9oZ6sSURx4x8riR5qbMK/afw8go=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=DOrdk8HaRar6806WDYWR1gKpce5lUVpkkzg81JIa/2vWZ8ML2zzwnsdvtQxY0VVI7
         KFA1yJu9MzBb/FeO8Ox3KQqG/EU6uZGH7tzEKAEhtUiYCqz3uGtPm3lcdDmjhOsfdg
         9e/IRBJT//gxfyKwBB+ZjydoujV+UIqtw993uayE=
Authentication-Results: mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/2] wifi: ath10k: consistently use kstrtoX_from_user() functions
Date:   Tue,  8 Aug 2023 18:25:36 +0300
Message-ID: <20230808152542.91117-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808152542.91117-1-dmantipov@yandex.ru>
References: <20230808152542.91117-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use 'kstrtoul_from_user()', 'kstrtouint_from_user()', and
'kstrtobool_from_user()' where appropriate and thus avoid
some code duplication.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath10k/debug.c    | 41 ++++++----------------
 drivers/net/wireless/ath/ath10k/spectral.c | 26 +++++---------
 2 files changed, 19 insertions(+), 48 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/debug.c b/drivers/net/wireless/ath/ath10k/debug.c
index f9518e1c9903..07a92f5296b6 100644
--- a/drivers/net/wireless/ath/ath10k/debug.c
+++ b/drivers/net/wireless/ath/ath10k/debug.c
@@ -1964,20 +1964,13 @@ static ssize_t ath10k_write_btcoex(struct file *file,
 				   size_t count, loff_t *ppos)
 {
 	struct ath10k *ar = file->private_data;
-	char buf[32];
-	size_t buf_size;
 	int ret;
 	bool val;
 	u32 pdev_param;
 
-	buf_size = min(count, (sizeof(buf) - 1));
-	if (copy_from_user(buf, ubuf, buf_size))
-		return -EFAULT;
-
-	buf[buf_size] = '\0';
-
-	if (kstrtobool(buf, &val) != 0)
-		return -EINVAL;
+	ret = kstrtobool_from_user(ubuf, count, &val);
+	if (ret)
+		return ret;
 
 	if (!ar->coex_support)
 		return -EOPNOTSUPP;
@@ -2103,19 +2096,12 @@ static ssize_t ath10k_write_peer_stats(struct file *file,
 				       size_t count, loff_t *ppos)
 {
 	struct ath10k *ar = file->private_data;
-	char buf[32];
-	size_t buf_size;
 	int ret;
 	bool val;
 
-	buf_size = min(count, (sizeof(buf) - 1));
-	if (copy_from_user(buf, ubuf, buf_size))
-		return -EFAULT;
-
-	buf[buf_size] = '\0';
-
-	if (kstrtobool(buf, &val) != 0)
-		return -EINVAL;
+	ret = kstrtobool_from_user(ubuf, count, &val);
+	if (ret)
+		return ret;
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -2239,21 +2225,16 @@ static ssize_t ath10k_sta_tid_stats_mask_write(struct file *file,
 					       size_t count, loff_t *ppos)
 {
 	struct ath10k *ar = file->private_data;
-	char buf[32];
-	ssize_t len;
 	u32 mask;
+	int ret;
 
-	len = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, len))
-		return -EFAULT;
-
-	buf[len] = '\0';
-	if (kstrtoint(buf, 0, &mask))
-		return -EINVAL;
+	ret = kstrtouint_from_user(user_buf, count, 0, &mask);
+	if (ret)
+		return ret;
 
 	ar->sta_tid_stats_mask = mask;
 
-	return len;
+	return count;
 }
 
 static const struct file_operations fops_sta_tid_stats_mask = {
diff --git a/drivers/net/wireless/ath/ath10k/spectral.c b/drivers/net/wireless/ath/ath10k/spectral.c
index 68254a967ccb..2240994390ed 100644
--- a/drivers/net/wireless/ath/ath10k/spectral.c
+++ b/drivers/net/wireless/ath/ath10k/spectral.c
@@ -384,16 +384,11 @@ static ssize_t write_file_spectral_count(struct file *file,
 {
 	struct ath10k *ar = file->private_data;
 	unsigned long val;
-	char buf[32];
-	ssize_t len;
-
-	len = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, len))
-		return -EFAULT;
+	ssize_t ret;
 
-	buf[len] = '\0';
-	if (kstrtoul(buf, 0, &val))
-		return -EINVAL;
+	ret = kstrtoul_from_user(user_buf, count, 0, &val);
+	if (ret)
+		return ret;
 
 	if (val > 255)
 		return -EINVAL;
@@ -440,16 +435,11 @@ static ssize_t write_file_spectral_bins(struct file *file,
 {
 	struct ath10k *ar = file->private_data;
 	unsigned long val;
-	char buf[32];
-	ssize_t len;
-
-	len = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, len))
-		return -EFAULT;
+	ssize_t ret;
 
-	buf[len] = '\0';
-	if (kstrtoul(buf, 0, &val))
-		return -EINVAL;
+	ret = kstrtoul_from_user(user_buf, count, 0, &val);
+	if (ret)
+		return ret;
 
 	if (val < 64 || val > SPECTRAL_ATH10K_MAX_NUM_BINS)
 		return -EINVAL;
-- 
2.41.0

