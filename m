Return-Path: <linux-wireless+bounces-31147-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDtKAQ4/dmmXOAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31147-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 17:04:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B654581553
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 17:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEA4E300C805
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 16:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656E631A7E1;
	Sun, 25 Jan 2026 16:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kARm8l8b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7142326921
	for <linux-wireless@vger.kernel.org>; Sun, 25 Jan 2026 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769357052; cv=none; b=UMIF91idB9dEVavH8MfSftqBh46NKYvkEfRqGtSOllN0TrkgY0/cxi6RmOBpWXcfv/7O3jytCpfZqCog4dqIKip7RdPbAeFmZkAVeVClehK3FEgQzSvVCMoFGHDJdobn5tQNoF60t+5dsW53Io3uMGwFO1LehZjrsEXqGuFMebA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769357052; c=relaxed/simple;
	bh=SSHLvHF4xN8IG3l2Ve8vuDuxkploOeSYOQiTdjbolzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aaWRXbyARfnn68AhRFvaAdnqdhh0E51Mi9qy47DLPvIAHFerPjDpGLI7ulyVxrb95gHIPzZe2OAizLV0ABvHDmcVJflZZWRpg6EQOVvNidQ1/ztXkzIJfEVwsyBsCy+uieAVoqqFJ+HUjRMuVOv3lrhqyJzZf9foPOvRGpONWJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kARm8l8b; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b87677a8abeso572569366b.1
        for <linux-wireless@vger.kernel.org>; Sun, 25 Jan 2026 08:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769357049; x=1769961849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnW69OHvK9zG9vM9gktyytFfmC/dalmrzkbZKfiSzrI=;
        b=kARm8l8bGnK2pVJe+kebGbQcw6ejoIUUSx/Mm/CoSwVk4TM4XOQgrzWMm1nGVq4SAG
         5WP4Ycq/afkrSUGWU8pKfxfyGY+JWePO4ndQ9d0JS1Jd2vKjTb4IgeKad5FNnuhOfoQS
         EvNjo56nJM0RmuCxb2t7k3GZ8UnqUZfewuP9M+Slkh177NdGPRXHqRmtI4vRj/W4zcBf
         2HbdWKo6zjHTMwiblaYcTLal3jCVsPVKGlsY4+jxDcxvuFfeuO+6wy51ftObBgh2re3B
         FFtDeudpvayxak5P5gqAwY4zTops/17u2HN064feLN8F4psKSwSvWgqmSQ4zU//cvIHq
         5icg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769357049; x=1769961849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZnW69OHvK9zG9vM9gktyytFfmC/dalmrzkbZKfiSzrI=;
        b=STEZWCAJQv/ZtAQKpKq7XvrxBwltynj3f+GMk+sqmbQtFV/MSzjwk/UK/sMiKX1rbf
         4vdp2pO8pUI4Noop4VJ3oFIx7frgMQ389IvyXP4bWAZazcTmlKLQML42maGJy3SkBkwT
         t36Xf1usVieDC8fggTHfvQsAxPBx0VomMLcstG8kMB3L1QFbqW46GU4YtZTRvpKOeUJZ
         IvkWO9a4/97TI01vXMhobxIUyvLP3hixw4HkiZ0OCmT9up2cqw4vBUi6XB/FPihWd8n9
         JQq0BMQXgSyLLAeVbv0Shk6AvUq03kGlKKTdi5vKxjJqmlGGQMYw84dgWh8DdehYYMOL
         wosg==
X-Gm-Message-State: AOJu0Yx2JDrmJmsXunUQWp1X+2N4Y18gseghzjHGd/ZlsHSHnegSNJTv
	Xui4i1271QSQL/4CVtkhGOeeRUks9xZFlHgOo7vW9ve+s2AyIcd2KnAYWvxPBw==
X-Gm-Gg: AZuq6aKW15jRCSpou4XbBrctWqK1gP3RcRz0leJhYINT7eVEUXyJnZzlQLN5r3gjsLl
	bqGjkybZcrRqse7QotFi0Q7GW1pCpFjhQBy/o/67Lre/2RhXDZQKPmq1kT7z5m8dIF9BqIwH9qw
	8nW+eNsdCB8E8LKeSX7izW1Ov/TkzL70epMV+4Gd/ZGAmhAASmWwOsUpO/7neHHX0DWRO+Zdh0u
	inm9ws23TeS6LnXtA2venHTULKZGLvlrwkN4YWhQY7ZWNtTRktj+b61bmHSxEpFa+iTznrVD8Dz
	ybyELv9zHkszRkiw4Z7FdQp3PSn618uGnNgIhGZ5U6MYR8QA6QgQTXb7m9XzPPsoeF8YAmfeXEK
	igw47T45EyAEn8jV6JsQBJDZjJJSpGFeRwcoPkS2mfn/eE0OhDSCJA3Wpibp5BSOUo2KCVHOJ55
	CXys0SnlSr7AsG0XUWsA+mopY8Ec9aD9Bv88vjWRPWmWC9jYZH
X-Received: by 2002:a17:907:7b8d:b0:b87:892:f43b with SMTP id a640c23a62f3a-b8d2e815dcbmr133557266b.42.1769357049208;
        Sun, 25 Jan 2026 08:04:09 -0800 (PST)
Received: from hp.. (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b886a249e69sm408330466b.6.2026.01.25.08.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 08:04:08 -0800 (PST)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [RFC v5 wireless-next 4/4] wifi: mac80211_hwsim: background CAC support
Date: Sun, 25 Jan 2026 17:00:32 +0100
Message-ID: <20260125160353.34102-5-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260125160353.34102-1-janusz.dziedzic@gmail.com>
References: <20260125160353.34102-1-janusz.dziedzic@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31147-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[januszdziedzic@gmail.com,linux-wireless@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B654581553
X-Rspamd-Action: no action

Report background CAC support and add allow
to cancel background CAC and simulate radar.

echo cancel > /sys/kernel/debug/ieee80211/phy2/hwsim/dfs_background_cac
echo radar > /sys/kernel/debug/ieee80211/phy2/hwsim/dfs_background_cac

Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 64 ++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 4d9f5f87e814..d88e519008a2 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -715,6 +715,7 @@ struct mac80211_hwsim_data {
 	} ps;
 	bool ps_poll_pending;
 	struct dentry *debugfs;
+	struct cfg80211_chan_def radar_background_chandef;
 
 	atomic_t pending_cookie;
 	struct sk_buff_head pending;	/* packets pending */
@@ -1164,6 +1165,46 @@ static int hwsim_write_simulate_radar(void *dat, u64 val)
 DEFINE_DEBUGFS_ATTRIBUTE(hwsim_simulate_radar, NULL,
 			 hwsim_write_simulate_radar, "%llu\n");
 
+static ssize_t hwsim_background_cac_write(struct file *file,
+					  const char __user *user_buf,
+					  size_t count, loff_t *ppos)
+{
+	struct mac80211_hwsim_data *data = file->private_data;
+	size_t buf_size;
+	char buf[16];
+
+	buf_size = min(count, sizeof(buf) - 1);
+	if (copy_from_user(buf, user_buf, buf_size))
+		return -EFAULT;
+
+	buf[buf_size] = '\0';
+
+	/* Remove trailing newline if present */
+	if (buf_size > 0 && buf[buf_size - 1] == '\n')
+		buf[buf_size - 1] = '\0';
+
+	/* Check if background radar channel is configured */
+	if (!data->radar_background_chandef.chan)
+		return -ENOENT;
+
+	if (strcmp(buf, "radar") == 0)
+		cfg80211_background_radar_event(data->hw->wiphy,
+						&data->radar_background_chandef,
+						GFP_KERNEL);
+	else if (strcmp(buf, "cancel") == 0)
+		cfg80211_background_cac_abort(data->hw->wiphy);
+	else
+		return -EINVAL;
+
+	return count;
+}
+
+static const struct file_operations hwsim_background_cac_ops = {
+	.write = hwsim_background_cac_write,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+
 static int hwsim_fops_group_read(void *dat, u64 *val)
 {
 	struct mac80211_hwsim_data *data = dat;
@@ -4154,6 +4195,20 @@ static int mac80211_hwsim_change_nan_config(struct ieee80211_hw *hw,
 	return 0;
 }
 
+static int mac80211_hwsim_set_radar_background(struct ieee80211_hw *hw,
+					       struct cfg80211_chan_def *chan)
+{
+	struct mac80211_hwsim_data *data = hw->priv;
+
+	if (chan)
+		data->radar_background_chandef = *chan;
+	else
+		memset(&data->radar_background_chandef, 0,
+		       sizeof(data->radar_background_chandef));
+
+	return 0;
+}
+
 #ifdef CONFIG_MAC80211_DEBUGFS
 #define HWSIM_DEBUGFS_OPS					\
 	.link_add_debugfs = mac80211_hwsim_link_add_debugfs,
@@ -4189,6 +4244,7 @@ static int mac80211_hwsim_change_nan_config(struct ieee80211_hw *hw,
 	.start_nan = mac80211_hwsim_start_nan,                  \
 	.stop_nan = mac80211_hwsim_stop_nan,                    \
 	.nan_change_conf = mac80211_hwsim_change_nan_config,    \
+	.set_radar_background = mac80211_hwsim_set_radar_background, \
 	HWSIM_DEBUGFS_OPS
 
 #define HWSIM_NON_MLO_OPS					\
@@ -5794,6 +5850,8 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 
 	wiphy_ext_feature_set(hw->wiphy,
 			      NL80211_EXT_FEATURE_DFS_CONCURRENT);
+	wiphy_ext_feature_set(hw->wiphy,
+			      NL80211_EXT_FEATURE_RADAR_BACKGROUND);
 
 	if (param->no_vif)
 		ieee80211_hw_set(hw, NO_AUTO_VIF);
@@ -5828,10 +5886,14 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 			    &hwsim_fops_group);
 	debugfs_create_file("rx_rssi", 0666, data->debugfs, data,
 			    &hwsim_fops_rx_rssi);
-	if (!data->use_chanctx)
+	if (!data->use_chanctx) {
 		debugfs_create_file("dfs_simulate_radar", 0222,
 				    data->debugfs,
 				    data, &hwsim_simulate_radar);
+		debugfs_create_file("dfs_background_cac", 0200,
+				    data->debugfs,
+				    data, &hwsim_background_cac_ops);
+	}
 
 	if (param->pmsr_capa) {
 		data->pmsr_capa = *param->pmsr_capa;
-- 
2.43.0


