Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E35F7D3975
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Oct 2023 16:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbjJWOhk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Oct 2023 10:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbjJWOhj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Oct 2023 10:37:39 -0400
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169CDDD
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 07:37:35 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-49.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-49.vla.yp-c.yandex.net [IPv6:2a02:6b8:c18:4601:0:640:7543:0])
        by forward101a.mail.yandex.net (Yandex) with ESMTP id DC3CB60AD7;
        Mon, 23 Oct 2023 17:37:02 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-49.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 1bOkpP6WveA0-Kpm1M8OR;
        Mon, 23 Oct 2023 17:37:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1698071822; bh=buI8vw3MjqLsNjLUIY0tgGDUrxLXnS3cLm/YJLKG2CE=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=HS3b+PgT1nj3TYL6MAnL96RkJo57Co3qW3zA0yR3SO7dw7/7pT9MZLMriwzyPHc+S
         bUdHDWtGYRhCilvqVk01kSkB76EfxaA+dFnXNJYpsHRnByuo1N+pKsYk7Zt7O2zCip
         QDxPPf9rlmEphuzQAz+dvS1Njzm7hfCDHFbQSqiY=
Authentication-Results: mail-nwsmtp-smtp-production-main-49.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Gregory Greenman <gregory.greenman@intel.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: iwlwifi: use kstrtoX_from_user() in debugfs handlers
Date:   Mon, 23 Oct 2023 17:34:55 +0300
Message-ID: <20231023143459.157306-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use 'kstrtobool_from_user()', 'kstrtouint_from_user()' and
'kstrtoint_from_user()' in debugfs write handlers, adjust
style, add comments where appropriate. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 .../net/wireless/intel/iwlwifi/dvm/debugfs.c  | 172 +++++++-----------
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c   |  22 +--
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   |  21 +--
 3 files changed, 75 insertions(+), 140 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c
index b246dbd371b3..c887c251efb4 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c
@@ -408,20 +408,15 @@ static ssize_t iwl_dbgfs_rx_handlers_write(struct file *file,
 					 size_t count, loff_t *ppos)
 {
 	struct iwl_priv *priv = file->private_data;
+	ssize_t ret;
+	bool reset;
 
-	char buf[8];
-	int buf_size;
-	u32 reset_flag;
+	/* note actual value is not used here */
+	ret = kstrtobool_from_user(user_buf, count, &reset);
+	if (ret)
+		return ret;
 
-	memset(buf, 0, sizeof(buf));
-	buf_size = min(count, sizeof(buf) -  1);
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-	if (sscanf(buf, "%x", &reset_flag) != 1)
-		return -EFAULT;
-	if (reset_flag == 0)
-		memset(&priv->rx_handlers_stats[0], 0,
-			sizeof(priv->rx_handlers_stats));
+	memset(priv->rx_handlers_stats, 0, sizeof(priv->rx_handlers_stats));
 
 	return count;
 }
@@ -490,18 +485,15 @@ static ssize_t iwl_dbgfs_disable_ht40_write(struct file *file,
 					 size_t count, loff_t *ppos)
 {
 	struct iwl_priv *priv = file->private_data;
-	char buf[8];
-	int buf_size;
-	int ht40;
+	ssize_t ret;
+	bool ht40;
+
+	ret = kstrtobool_from_user(user_buf, count, &ht40);
+	if (ret)
+		return ret;
 
-	memset(buf, 0, sizeof(buf));
-	buf_size = min(count, sizeof(buf) -  1);
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-	if (sscanf(buf, "%d", &ht40) != 1)
-		return -EFAULT;
 	if (!iwl_is_any_associated(priv))
-		priv->disable_ht40 = ht40 ? true : false;
+		priv->disable_ht40 = ht40;
 	else
 		return -EINVAL;
 
@@ -542,18 +534,12 @@ static ssize_t iwl_dbgfs_sleep_level_override_write(struct file *file,
 						    size_t count, loff_t *ppos)
 {
 	struct iwl_priv *priv = file->private_data;
-	char buf[8];
-	int buf_size;
+	ssize_t ret;
 	int value;
 
-	memset(buf, 0, sizeof(buf));
-	buf_size = min(count, sizeof(buf) -  1);
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-
-	if (sscanf(buf, "%d", &value) != 1)
-		return -EINVAL;
-
+	ret = kstrtoint_from_user(user_buf, count, 0, &value);
+	if (ret)
+		return ret;
 	/*
 	 * Our users expect 0 to be "CAM", but 0 isn't actually
 	 * valid here. However, let's not confuse them and present
@@ -1806,16 +1792,13 @@ static ssize_t iwl_dbgfs_clear_ucode_statistics_write(struct file *file,
 					 size_t count, loff_t *ppos)
 {
 	struct iwl_priv *priv = file->private_data;
-	char buf[8];
-	int buf_size;
-	int clear;
+	ssize_t ret;
+	bool clear;
 
-	memset(buf, 0, sizeof(buf));
-	buf_size = min(count, sizeof(buf) -  1);
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-	if (sscanf(buf, "%d", &clear) != 1)
-		return -EFAULT;
+	/* note actual value is not used here */
+	ret = kstrtobool_from_user(user_buf, count, &clear);
+	if (ret)
+		return ret;
 
 	/* make request to uCode to retrieve statistics information */
 	mutex_lock(&priv->mutex);
@@ -1851,25 +1834,20 @@ static ssize_t iwl_dbgfs_ucode_tracing_write(struct file *file,
 					 size_t count, loff_t *ppos)
 {
 	struct iwl_priv *priv = file->private_data;
-	char buf[8];
-	int buf_size;
-	int trace;
+	ssize_t ret;
+	bool trace;
 
-	memset(buf, 0, sizeof(buf));
-	buf_size = min(count, sizeof(buf) -  1);
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-	if (sscanf(buf, "%d", &trace) != 1)
-		return -EFAULT;
+	ret = kstrtobool_from_user(user_buf, count, &trace);
+	if (ret)
+		return ret;
 
+	priv->event_log.ucode_trace = trace;
 	if (trace) {
-		priv->event_log.ucode_trace = true;
 		if (iwl_is_alive(priv)) {
 			/* start collecting data now */
 			mod_timer(&priv->ucode_trace, jiffies);
 		}
 	} else {
-		priv->event_log.ucode_trace = false;
 		del_timer_sync(&priv->ucode_trace);
 	}
 
@@ -1922,16 +1900,12 @@ static ssize_t iwl_dbgfs_missed_beacon_write(struct file *file,
 					 size_t count, loff_t *ppos)
 {
 	struct iwl_priv *priv = file->private_data;
-	char buf[8];
-	int buf_size;
+	ssize_t ret;
 	int missed;
 
-	memset(buf, 0, sizeof(buf));
-	buf_size = min(count, sizeof(buf) -  1);
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-	if (sscanf(buf, "%d", &missed) != 1)
-		return -EINVAL;
+	ret = kstrtoint_from_user(user_buf, count, 0, &missed);
+	if (ret)
+		return ret;
 
 	if (missed < IWL_MISSED_BEACON_THRESHOLD_MIN ||
 	    missed > IWL_MISSED_BEACON_THRESHOLD_MAX)
@@ -1963,16 +1937,12 @@ static ssize_t iwl_dbgfs_plcp_delta_write(struct file *file,
 					size_t count, loff_t *ppos) {
 
 	struct iwl_priv *priv = file->private_data;
-	char buf[8];
-	int buf_size;
+	ssize_t ret;
 	int plcp;
 
-	memset(buf, 0, sizeof(buf));
-	buf_size = min(count, sizeof(buf) -  1);
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-	if (sscanf(buf, "%d", &plcp) != 1)
-		return -EINVAL;
+	ret = kstrtoint_from_user(user_buf, count, 0, &plcp);
+	if (ret)
+		return ret;
 	if ((plcp < IWL_MAX_PLCP_ERR_THRESHOLD_MIN) ||
 		(plcp > IWL_MAX_PLCP_ERR_THRESHOLD_MAX))
 		priv->plcp_delta_threshold =
@@ -2023,16 +1993,13 @@ static ssize_t iwl_dbgfs_txfifo_flush_write(struct file *file,
 					size_t count, loff_t *ppos) {
 
 	struct iwl_priv *priv = file->private_data;
-	char buf[8];
-	int buf_size;
-	int flush;
+	ssize_t ret;
+	bool flush;
 
-	memset(buf, 0, sizeof(buf));
-	buf_size = min(count, sizeof(buf) -  1);
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-	if (sscanf(buf, "%d", &flush) != 1)
-		return -EINVAL;
+	/* note actual value is not used here */
+	ret = kstrtobool_from_user(user_buf, count, &flush);
+	if (ret)
+		return ret;
 
 	if (iwl_is_rfkill(priv))
 		return -EFAULT;
@@ -2113,23 +2080,17 @@ static ssize_t iwl_dbgfs_protection_mode_write(struct file *file,
 					size_t count, loff_t *ppos) {
 
 	struct iwl_priv *priv = file->private_data;
-	char buf[8];
-	int buf_size;
-	int rts;
+	ssize_t ret;
+	bool rts;
 
 	if (!priv->cfg->ht_params)
 		return -EINVAL;
 
-	memset(buf, 0, sizeof(buf));
-	buf_size = min(count, sizeof(buf) -  1);
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-	if (sscanf(buf, "%d", &rts) != 1)
-		return -EINVAL;
-	if (rts)
-		priv->hw_params.use_rts_for_aggregation = true;
-	else
-		priv->hw_params.use_rts_for_aggregation = false;
+	ret = kstrtobool_from_user(user_buf, count, &rts);
+	if (ret)
+		return ret;
+
+	priv->hw_params.use_rts_for_aggregation = rts;
 	return count;
 }
 
@@ -2187,21 +2148,18 @@ static ssize_t iwl_dbgfs_log_event_write(struct file *file,
 					size_t count, loff_t *ppos)
 {
 	struct iwl_priv *priv = file->private_data;
-	u32 event_log_flag;
-	char buf[8];
-	int buf_size;
+	bool event_log_flag;
+	ssize_t ret;
 
 	/* check that the interface is up */
 	if (!iwl_is_ready(priv))
 		return -EAGAIN;
 
-	memset(buf, 0, sizeof(buf));
-	buf_size = min(count, sizeof(buf) -  1);
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-	if (sscanf(buf, "%u", &event_log_flag) != 1)
-		return -EFAULT;
-	if (event_log_flag == 1)
+	ret = kstrtobool_from_user(user_buf, count, &event_log_flag);
+	if (ret)
+		return ret;
+
+	if (event_log_flag)
 		iwl_dump_nic_event_log(priv, true, NULL);
 
 	return count;
@@ -2241,16 +2199,12 @@ static ssize_t iwl_dbgfs_calib_disabled_write(struct file *file,
 					      size_t count, loff_t *ppos)
 {
 	struct iwl_priv *priv = file->private_data;
-	char buf[8];
-	u32 calib_disabled;
-	int buf_size;
+	bool calib_disabled;
+	ssize_t ret;
 
-	memset(buf, 0, sizeof(buf));
-	buf_size = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-	if (sscanf(buf, "%x", &calib_disabled) != 1)
-		return -EFAULT;
+	ret = kstrtobool_from_user(user_buf, count, &calib_disabled);
+	if (ret)
+		return ret;
 
 	priv->calib_disabled = calib_disabled;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
index f4a6f76cf193..047f88bc82f4 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
@@ -3041,26 +3041,16 @@ static ssize_t rs_sta_dbgfs_scale_table_write(struct file *file,
 			const char __user *user_buf, size_t count, loff_t *ppos)
 {
 	struct iwl_lq_sta *lq_sta = file->private_data;
-	struct iwl_priv *priv;
-	char buf[64];
-	size_t buf_size;
-	u32 parsed_rate;
-
-
-	priv = lq_sta->drv;
-	memset(buf, 0, sizeof(buf));
-	buf_size = min(count, sizeof(buf) -  1);
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
+	struct iwl_priv *priv = lq_sta->drv;
+	ssize_t ret;
+	u32 rate;
 
-	if (sscanf(buf, "%x", &parsed_rate) == 1)
-		lq_sta->dbg_fixed_rate = parsed_rate;
-	else
-		lq_sta->dbg_fixed_rate = 0;
+	ret = kstrtouint_from_user(user_buf, count, 0, &rate);
+	lq_sta->dbg_fixed_rate = ret ? 0 : rate;
 
 	rs_program_fix_rate(priv, lq_sta);
 
-	return count;
+	return ret ? ret : count;
 }
 
 static ssize_t rs_sta_dbgfs_scale_table_read(struct file *file,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index 481d68cbbbd8..539874101d78 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -3724,25 +3724,16 @@ static ssize_t rs_sta_dbgfs_scale_table_write(struct file *file,
 			const char __user *user_buf, size_t count, loff_t *ppos)
 {
 	struct iwl_lq_sta *lq_sta = file->private_data;
-	struct iwl_mvm *mvm;
-	char buf[64];
-	size_t buf_size;
-	u32 parsed_rate;
-
-	mvm = lq_sta->pers.drv;
-	memset(buf, 0, sizeof(buf));
-	buf_size = min(count, sizeof(buf) -  1);
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
+	struct iwl_mvm *mvm = lq_sta->pers.drv;
+	ssize_t ret;
+	u32 rate;
 
-	if (sscanf(buf, "%x", &parsed_rate) == 1)
-		lq_sta->pers.dbg_fixed_rate = parsed_rate;
-	else
-		lq_sta->pers.dbg_fixed_rate = 0;
+	ret = kstrtouint_from_user(user_buf, count, 0, &rate);
+	lq_sta->pers.dbg_fixed_rate = ret ? 0 : rate;
 
 	rs_program_fix_rate(mvm, lq_sta);
 
-	return count;
+	return ret ? ret : count;
 }
 
 static ssize_t rs_sta_dbgfs_scale_table_read(struct file *file,
-- 
2.41.0

