Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8257A7BA7
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 13:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbjITLyN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 07:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbjITLyL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 07:54:11 -0400
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [178.154.239.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DD2F1
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 04:54:01 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:1af:0:640:453c:0])
        by forward101b.mail.yandex.net (Yandex) with ESMTP id 695FA6007F;
        Wed, 20 Sep 2023 14:54:00 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id wrH0PdCDcKo0-8hExjusI;
        Wed, 20 Sep 2023 14:53:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1695210839; bh=HPbI9/Pt8V7Dib3V+d2fNiBsfrfwHHLb9L+A94xhSW0=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=DCByiWk9DYc3FI/qhFdUGz1H1TqnBoaLUuQ6qq9vBlbMsk11PvUr4kWN5XSKAO8d8
         CUa4kJttyjNduY64Xn8sHXcH8FyyDtYa2XGDTXuhRwUzjUtzOvUK4YaUMUMAt5Xfj7
         sEX1LOngNoZbEEkNBDqCywgZI1tynSMwzt4+ovV4=
Authentication-Results: mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: ath10k: consistently use kstrtoX_from_user() functions
Date:   Wed, 20 Sep 2023 14:52:32 +0300
Message-ID: <20230920115249.38296-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use 'kstrtoul_from_user()', 'kstrtobool_from_user()' and
'kstrtoint_from_user()' where appropriate and thus avoid
some code duplication.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
Hopefully this doesn't violate "if it isn't broke, don't fix
it" rule (the same thing was recently accepted for ath9k).
---
 drivers/net/wireless/ath/ath10k/debug.c    | 47 +++++++---------------
 drivers/net/wireless/ath/ath10k/spectral.c | 26 ++++--------
 2 files changed, 22 insertions(+), 51 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/debug.c b/drivers/net/wireless/ath/ath10k/debug.c
index f9518e1c9903..ea6e0d50e933 100644
--- a/drivers/net/wireless/ath/ath10k/debug.c
+++ b/drivers/net/wireless/ath/ath10k/debug.c
@@ -1964,20 +1964,13 @@ static ssize_t ath10k_write_btcoex(struct file *file,
 				   size_t count, loff_t *ppos)
 {
 	struct ath10k *ar = file->private_data;
-	char buf[32];
-	size_t buf_size;
-	int ret;
+	ssize_t ret;
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
@@ -2000,7 +1993,7 @@ static ssize_t ath10k_write_btcoex(struct file *file,
 		     ar->running_fw->fw_file.fw_features)) {
 		ret = ath10k_wmi_pdev_set_param(ar, pdev_param, val);
 		if (ret) {
-			ath10k_warn(ar, "failed to enable btcoex: %d\n", ret);
+			ath10k_warn(ar, "failed to enable btcoex: %ld\n", ret);
 			ret = count;
 			goto exit;
 		}
@@ -2103,19 +2096,12 @@ static ssize_t ath10k_write_peer_stats(struct file *file,
 				       size_t count, loff_t *ppos)
 {
 	struct ath10k *ar = file->private_data;
-	char buf[32];
-	size_t buf_size;
-	int ret;
+	ssize_t ret;
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
+	ssize_t ret;
 	u32 mask;
 
-	len = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, len))
-		return -EFAULT;
-
-	buf[len] = '\0';
-	if (kstrtoint(buf, 0, &mask))
-		return -EINVAL;
+	ret = kstrtoint_from_user(user_buf, count, 0, &mask);
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

