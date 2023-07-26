Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C312763F00
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jul 2023 20:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjGZSvp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jul 2023 14:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjGZSvl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jul 2023 14:51:41 -0400
Received: from forward101c.mail.yandex.net (forward101c.mail.yandex.net [178.154.239.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30B72D44
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 11:51:35 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:d315:0:640:bb64:0])
        by forward101c.mail.yandex.net (Yandex) with ESMTP id F27356004C;
        Wed, 26 Jul 2023 21:51:32 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id VpQk7m4WwW20-m87Oaocr;
        Wed, 26 Jul 2023 21:51:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1690397492;
        bh=daf8wVPTJcZpS8IwYRoxic7CIo498ckpzPyCSdO1160=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=avfKizldQ0d0tr5WQLMQxK9xw/kl+jBeGfDzp5xgDHPTwXZBf1zKoWB4/r/StrODu
         1VRjlG6H03kUjWYHzXL2Am150k0WcoOeuHWI9Qv9js/Z6GQ1bvuguJAPzg3M5L4gPB
         bauXKsDpxX0I8oRGJXSHeOUjyiHCYKdoSFNwO9Ng=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: ath9k: consistently use kstrtoX_from_user() functions
Date:   Wed, 26 Jul 2023 21:50:08 +0300
Message-ID: <20230726185046.188225-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use 'kstrtoul_from_user()' and 'kstrtobool_from_user()'
where appropriate and thus avoid some code duplication.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 .../net/wireless/ath/ath9k/common-spectral.c  |  53 +++------
 drivers/net/wireless/ath/ath9k/debug.c        | 106 ++++++------------
 drivers/net/wireless/ath/ath9k/dfs_debug.c    |  14 +--
 .../net/wireless/ath/ath9k/htc_drv_debug.c    |  13 +--
 drivers/net/wireless/ath/ath9k/tx99.c         |  14 +--
 5 files changed, 61 insertions(+), 139 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/common-spectral.c b/drivers/net/wireless/ath/ath9k/common-spectral.c
index e055adfb5361..a5349c72c332 100644
--- a/drivers/net/wireless/ath/ath9k/common-spectral.c
+++ b/drivers/net/wireless/ath/ath9k/common-spectral.c
@@ -855,16 +855,11 @@ static ssize_t write_file_spectral_short_repeat(struct file *file,
 {
 	struct ath_spec_scan_priv *spec_priv = file->private_data;
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
 
 	if (val > 1)
 		return -EINVAL;
@@ -903,17 +898,11 @@ static ssize_t write_file_spectral_count(struct file *file,
 {
 	struct ath_spec_scan_priv *spec_priv = file->private_data;
 	unsigned long val;
-	char buf[32];
-	ssize_t len;
-
-	len = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, len))
-		return -EFAULT;
-
-	buf[len] = '\0';
-	if (kstrtoul(buf, 0, &val))
-		return -EINVAL;
+	ssize_t ret;
 
+	ret = kstrtoul_from_user(user_buf, count, 0, &val);
+	if (ret)
+		return ret;
 	if (val > 255)
 		return -EINVAL;
 
@@ -951,16 +940,11 @@ static ssize_t write_file_spectral_period(struct file *file,
 {
 	struct ath_spec_scan_priv *spec_priv = file->private_data;
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
@@ -999,16 +983,11 @@ static ssize_t write_file_spectral_fft_period(struct file *file,
 {
 	struct ath_spec_scan_priv *spec_priv = file->private_data;
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
 
 	if (val > 15)
 		return -EINVAL;
diff --git a/drivers/net/wireless/ath/ath9k/debug.c b/drivers/net/wireless/ath/ath9k/debug.c
index fb7a2952d0ce..ddf1c3ae0306 100644
--- a/drivers/net/wireless/ath/ath9k/debug.c
+++ b/drivers/net/wireless/ath/ath9k/debug.c
@@ -96,21 +96,16 @@ static ssize_t read_file_debug(struct file *file, char __user *user_buf,
 }
 
 static ssize_t write_file_debug(struct file *file, const char __user *user_buf,
-			     size_t count, loff_t *ppos)
+				size_t count, loff_t *ppos)
 {
 	struct ath_softc *sc = file->private_data;
 	struct ath_common *common = ath9k_hw_common(sc->sc_ah);
 	unsigned long mask;
-	char buf[32];
-	ssize_t len;
+	ssize_t ret;
 
-	len = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, len))
-		return -EFAULT;
-
-	buf[len] = '\0';
-	if (kstrtoul(buf, 0, &mask))
-		return -EINVAL;
+	ret = kstrtoul_from_user(user_buf, count, 0, &mask);
+	if (ret)
+		return ret;
 
 	common->debug_mask = mask;
 	return count;
@@ -191,16 +186,11 @@ static ssize_t write_file_ani(struct file *file,
 	struct ath_softc *sc = file->private_data;
 	struct ath_common *common = ath9k_hw_common(sc->sc_ah);
 	unsigned long ani;
-	char buf[32];
-	ssize_t len;
+	ssize_t ret;
 
-	len = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, len))
-		return -EFAULT;
-
-	buf[len] = '\0';
-	if (kstrtoul(buf, 0, &ani))
-		return -EINVAL;
+	ret = kstrtoul_from_user(user_buf, count, 0, &ani);
+	if (ret)
+		return ret;
 
 	if (ani > 1)
 		return -EINVAL;
@@ -248,20 +238,15 @@ static ssize_t write_file_bt_ant_diversity(struct file *file,
 	struct ath_common *common = ath9k_hw_common(sc->sc_ah);
 	struct ath9k_hw_capabilities *pCap = &sc->sc_ah->caps;
 	unsigned long bt_ant_diversity;
-	char buf[32];
-	ssize_t len;
+	ssize_t ret;
 
-	len = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, len))
-		return -EFAULT;
+	ret = kstrtoul_from_user(user_buf, count, 0, &bt_ant_diversity);
+	if (ret)
+		return ret;
 
 	if (!(pCap->hw_caps & ATH9K_HW_CAP_BT_ANT_DIV))
 		goto exit;
 
-	buf[len] = '\0';
-	if (kstrtoul(buf, 0, &bt_ant_diversity))
-		return -EINVAL;
-
 	common->bt_ant_diversity = !!bt_ant_diversity;
 	ath9k_ps_wakeup(sc);
 	ath9k_hw_set_bt_ant_diversity(sc->sc_ah, common->bt_ant_diversity);
@@ -792,16 +777,11 @@ static ssize_t write_file_reset(struct file *file,
 	struct ath_hw *ah = sc->sc_ah;
 	struct ath_common *common = ath9k_hw_common(ah);
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
 
 	if (val != 1)
 		return -EINVAL;
@@ -886,16 +866,11 @@ static ssize_t write_file_regidx(struct file *file, const char __user *user_buf,
 {
 	struct ath_softc *sc = file->private_data;
 	unsigned long regidx;
-	char buf[32];
-	ssize_t len;
+	ssize_t ret;
 
-	len = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, len))
-		return -EFAULT;
-
-	buf[len] = '\0';
-	if (kstrtoul(buf, 0, &regidx))
-		return -EINVAL;
+	ret = kstrtoul_from_user(user_buf, count, 0, &regidx);
+	if (ret)
+		return ret;
 
 	sc->debug.regidx = regidx;
 	return count;
@@ -931,16 +906,11 @@ static ssize_t write_file_regval(struct file *file, const char __user *user_buf,
 	struct ath_softc *sc = file->private_data;
 	struct ath_hw *ah = sc->sc_ah;
 	unsigned long regval;
-	char buf[32];
-	ssize_t len;
-
-	len = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, len))
-		return -EFAULT;
+	ssize_t ret;
 
-	buf[len] = '\0';
-	if (kstrtoul(buf, 0, &regval))
-		return -EINVAL;
+	ret = kstrtoul_from_user(user_buf, count, 0, &regval);
+	if (ret)
+		return ret;
 
 	ath9k_ps_wakeup(sc);
 	REG_WRITE_D(ah, sc->debug.regidx, regval);
@@ -1128,16 +1098,11 @@ static ssize_t write_file_wow(struct file *file, const char __user *user_buf,
 {
 	struct ath_softc *sc = file->private_data;
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
 
 	if (val != 1)
 		return -EINVAL;
@@ -1191,17 +1156,12 @@ static ssize_t write_file_tpc(struct file *file, const char __user *user_buf,
 	struct ath_softc *sc = file->private_data;
 	struct ath_hw *ah = sc->sc_ah;
 	unsigned long val;
-	char buf[32];
-	ssize_t len;
+	ssize_t ret;
 	bool tpc_enabled;
 
-	len = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, len))
-		return -EFAULT;
-
-	buf[len] = '\0';
-	if (kstrtoul(buf, 0, &val))
-		return -EINVAL;
+	ret = kstrtoul_from_user(user_buf, count, 0, &val);
+	if (ret)
+		return ret;
 
 	if (val > 1)
 		return -EINVAL;
diff --git a/drivers/net/wireless/ath/ath9k/dfs_debug.c b/drivers/net/wireless/ath/ath9k/dfs_debug.c
index 2a79c2fa8415..8e18e9b4ef48 100644
--- a/drivers/net/wireless/ath/ath9k/dfs_debug.c
+++ b/drivers/net/wireless/ath/ath9k/dfs_debug.c
@@ -99,17 +99,11 @@ static ssize_t write_file_dfs(struct file *file, const char __user *user_buf,
 {
 	struct ath_softc *sc = file->private_data;
 	unsigned long val;
-	char buf[32];
-	ssize_t len;
-
-	len = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, len))
-		return -EFAULT;
-
-	buf[len] = '\0';
-	if (kstrtoul(buf, 0, &val))
-		return -EINVAL;
+	ssize_t ret;
 
+	ret = kstrtoul_from_user(user_buf, count, 0, &val);
+	if (ret)
+		return ret;
 	if (val == DFS_STATS_RESET_MAGIC)
 		memset(&sc->debug.stats.dfs_stats, 0,
 		       sizeof(sc->debug.stats.dfs_stats));
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
index b3ed65e5c4da..1ed2b1216bce 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
@@ -375,16 +375,11 @@ static ssize_t write_file_debug(struct file *file, const char __user *user_buf,
 	struct ath9k_htc_priv *priv = file->private_data;
 	struct ath_common *common = ath9k_hw_common(priv->ah);
 	unsigned long mask;
-	char buf[32];
-	ssize_t len;
-
-	len = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, len))
-		return -EFAULT;
+	ssize_t ret;
 
-	buf[len] = '\0';
-	if (kstrtoul(buf, 0, &mask))
-		return -EINVAL;
+	ret = kstrtoul_from_user(user_buf, count, 0, &mask);
+	if (ret)
+		return ret;
 
 	common->debug_mask = mask;
 	return count;
diff --git a/drivers/net/wireless/ath/ath9k/tx99.c b/drivers/net/wireless/ath/ath9k/tx99.c
index 8a996ed9a3be..f2144fd39093 100644
--- a/drivers/net/wireless/ath/ath9k/tx99.c
+++ b/drivers/net/wireless/ath/ath9k/tx99.c
@@ -172,9 +172,8 @@ static ssize_t write_file_tx99(struct file *file, const char __user *user_buf,
 {
 	struct ath_softc *sc = file->private_data;
 	struct ath_common *common = ath9k_hw_common(sc->sc_ah);
-	char buf[32];
 	bool start;
-	ssize_t len;
+	ssize_t ret;
 	int r;
 
 	if (count < 1)
@@ -183,14 +182,9 @@ static ssize_t write_file_tx99(struct file *file, const char __user *user_buf,
 	if (sc->cur_chan->nvifs > 1)
 		return -EOPNOTSUPP;
 
-	len = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, len))
-		return -EFAULT;
-
-	buf[len] = '\0';
-
-	if (kstrtobool(buf, &start))
-		return -EINVAL;
+	ret = kstrtobool_from_user(user_buf, count, &start);
+	if (ret)
+		return ret;
 
 	mutex_lock(&sc->mutex);
 
-- 
2.41.0

