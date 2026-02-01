Return-Path: <linux-wireless+bounces-31431-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OI6TMvl8f2nMrwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31431-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 01 Feb 2026 17:19:05 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 756B7C66A8
	for <lists+linux-wireless@lfdr.de>; Sun, 01 Feb 2026 17:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DBA143001332
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Feb 2026 16:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC44258CD9;
	Sun,  1 Feb 2026 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llnaSdJN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9867A253340
	for <linux-wireless@vger.kernel.org>; Sun,  1 Feb 2026 16:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769962738; cv=none; b=diPPUgQcpxKDYlPsk35uxFKI0ajhU0Xq+Lb6lYVVN6rAgmWmfieiLBUBZWVh0gJG31Cx1OWVcVnlyR9wdBNJEuo/bZAu1WK4A90O9oB94DhUuwtAtYuJSlugzDfLp26RbmVsHqKXhr7Wk5+Chu23PSr+DL94VYfjv7tGNwg2q64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769962738; c=relaxed/simple;
	bh=vrPRaCernNLhXJfapJgvFkOC1jQR4srBKurZc1A5e34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FcwahLI+NaYJ2qlYtLci6/W1gy7Psf7I69szJZivrE0xGeeEQvBlXKa3VUKLtLSbfLipPD7COXlAGrmB8t5vb5Ct+J25lS9plEGDqJBSQDuSANnHBDwLVzJReXfSdKdODdnup5tXs8aZ2PhYbkNXaf6Xulu6SYgJbL7vCm3p2kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llnaSdJN; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4806bf39419so28237485e9.1
        for <linux-wireless@vger.kernel.org>; Sun, 01 Feb 2026 08:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769962735; x=1770567535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVB/GQQO6uHvVXoogVPrCEx0Kbg6ZlMDIF+ryPjA5kE=;
        b=llnaSdJNqpGwUaRo3bLoR2jFHsktbxexP63POEpfxyjC3cdKc3vt3fiPzvrcu4ar6r
         Y+EMF63kqxj1lrYyNDUWUt6TTRM5t+amnYRtXbT1Aol2izmZdJBNcUrFvMqjVbTg/6CN
         imUCjXeazcRzpM22z6GKNJw4PumS9xx8yXmFOFEqtQT7ZACLm7a5o1zuRTHiKkT0OfCG
         XJf1Xxb7A+MSYeDFmFDOU+y/u5jGIG67hLnYC4xa4DImGPnK2JPL/ixJpyK7nraxrp7J
         0PgVNLEKMJSVvt+XGxdHv8f/JAFEyPsEy5XZe23pj2cB+IC2egw4Cgq7mJ2mT+0+MLr5
         WVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769962735; x=1770567535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NVB/GQQO6uHvVXoogVPrCEx0Kbg6ZlMDIF+ryPjA5kE=;
        b=TjaWkW30nYiHJ7MSu7oC2gFdLhHoKLgD+xxzCR/yBss8PlILfEsz1OJM4EYaLll47N
         ag+DZxDVow8pPne4GV/dwFSLYPsZk9i6ZA6PLdn08RYbXAXl6wZx3lZSE8Jy6Qlb5Izf
         S7utx+HOPpPSeUbTePud9VQ7by9W/9hkssaXifEHJ6VbboDnErVhddKLJFUGdtm/ecjm
         L5otif1VprE237MhjI18TQwMCyc/wUdDxU+BRcmR/NwVqJm+chpJiyj+PvPlZn2f/+Xt
         8YDAR91Dii4oQ8trfLyaO4gpHpE3yKuuvskIhPlTF2OXyGC7nOe7x/TUWflrch0+g5eL
         QY6g==
X-Gm-Message-State: AOJu0YytOcjfZtQPCWkZbFrWi3BZdgD6ItFg6DWfM3sghfix8j2/BjTO
	B8MYKdKE9UGjhoZvNSfxsnG25rlZGg/qeRzYGNJ/UibI8r/3lYTOjz8X4PMEsg==
X-Gm-Gg: AZuq6aL8mCwZ3rSjexuV9xnOw+eH2qM6B8qaHXjURk5yVsCAP1yMsYsIZWDu5Q0brmk
	boBEEZShEEY4VTX+WuQ50gkTA9k6ZWUNxahxgludZeZ4zOqAo7eUm5j/ZMhlJgr9gCiBt8BO7W7
	fESQlo7npltc1isnSOhqdGSFEvkbH1OMQ9pCg/OzaKgLxM7gMmKaSDg65M8Q4C187j4ishZ54L1
	k0F4GSGUbvVyQkWbA2T9leP1tuK5M/rVEgl5IMYZwvHIzmsgCGiabABYm3ol2HcUBFnv4VZ1ReS
	XgXUqDBkqEqNFoiq57Gf0iG+QiD+oP0heZA64dopr27ff6VXSJ7qm3iA8KxyqrHXrQBNx9vZx0j
	LfiDwrPIjoV/JBmx6+Qh9foT2MsMgJaCQ3qWOnPk0vER7kzhzcduFZRje7nh+2n11/hipaQWKTj
	YBfxCyl/hozxkv1rL8SeFWhbpk2r/j6pQgCb8PgtZjGwbuZSmr
X-Received: by 2002:a05:6000:3106:b0:435:dbbb:992a with SMTP id ffacd0b85a97d-435ea05d198mr19432946f8f.6.1769962734843;
        Sun, 01 Feb 2026 08:18:54 -0800 (PST)
Received: from hp.. (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131ce93sm36368545f8f.24.2026.02.01.08.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 08:18:54 -0800 (PST)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [RFC v6 wireless-next 4/4] wifi: mac80211_hwsim: background CAC support
Date: Sun,  1 Feb 2026 17:15:42 +0100
Message-ID: <20260201161836.16506-5-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260201161836.16506-1-janusz.dziedzic@gmail.com>
References: <20260201161836.16506-1-janusz.dziedzic@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31431-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[sipsolutions.net,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[januszdziedzic@gmail.com,linux-wireless@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 756B7C66A8
X-Rspamd-Action: no action

Report background CAC support and add allow
to cancel background CAC and simulate radar.

echo cancel > /sys/kernel/debug/ieee80211/phy2/hwsim/dfs_background_cac
echo radar > /sys/kernel/debug/ieee80211/phy2/hwsim/dfs_background_cac

Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 68 ++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 4d9f5f87e814..682cfc413c9b 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -73,6 +73,10 @@ static bool multi_radio;
 module_param(multi_radio, bool, 0444);
 MODULE_PARM_DESC(multi_radio, "Support Multiple Radios per wiphy");
 
+static bool background_radar = true;
+module_param(background_radar, bool, 0444);
+MODULE_PARM_DESC(background_radar, "Support background radar/CAC");
+
 /**
  * enum hwsim_regtest - the type of regulatory tests we offer
  *
@@ -715,6 +719,7 @@ struct mac80211_hwsim_data {
 	} ps;
 	bool ps_poll_pending;
 	struct dentry *debugfs;
+	struct cfg80211_chan_def radar_background_chandef;
 
 	atomic_t pending_cookie;
 	struct sk_buff_head pending;	/* packets pending */
@@ -1164,6 +1169,41 @@ static int hwsim_write_simulate_radar(void *dat, u64 val)
 DEFINE_DEBUGFS_ATTRIBUTE(hwsim_simulate_radar, NULL,
 			 hwsim_write_simulate_radar, "%llu\n");
 
+static ssize_t hwsim_background_cac_write(struct file *file,
+					  const char __user *user_buf,
+					  size_t count, loff_t *ppos)
+{
+	struct mac80211_hwsim_data *data = file->private_data;
+	char buf[8] = {};
+
+	if (count >= sizeof(buf))
+		return -EINVAL;
+
+	if (copy_from_user(buf, user_buf, count))
+		return -EFAULT;
+
+	/* Check if background radar channel is configured */
+	if (!data->radar_background_chandef.chan)
+		return -ENOENT;
+
+	if (sysfs_streq(buf, "radar"))
+		cfg80211_background_radar_event(data->hw->wiphy,
+						&data->radar_background_chandef,
+						GFP_KERNEL);
+	else if (sysfs_streq(buf, "cancel"))
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
@@ -4154,6 +4194,23 @@ static int mac80211_hwsim_change_nan_config(struct ieee80211_hw *hw,
 	return 0;
 }
 
+static int mac80211_hwsim_set_radar_background(struct ieee80211_hw *hw,
+					       struct cfg80211_chan_def *chan)
+{
+	struct mac80211_hwsim_data *data = hw->priv;
+
+	if (!background_radar)
+		return -EOPNOTSUPP;
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
@@ -4189,6 +4246,7 @@ static int mac80211_hwsim_change_nan_config(struct ieee80211_hw *hw,
 	.start_nan = mac80211_hwsim_start_nan,                  \
 	.stop_nan = mac80211_hwsim_stop_nan,                    \
 	.nan_change_conf = mac80211_hwsim_change_nan_config,    \
+	.set_radar_background = mac80211_hwsim_set_radar_background, \
 	HWSIM_DEBUGFS_OPS
 
 #define HWSIM_NON_MLO_OPS					\
@@ -5794,6 +5852,9 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 
 	wiphy_ext_feature_set(hw->wiphy,
 			      NL80211_EXT_FEATURE_DFS_CONCURRENT);
+	if (background_radar)
+		wiphy_ext_feature_set(hw->wiphy,
+				      NL80211_EXT_FEATURE_RADAR_BACKGROUND);
 
 	if (param->no_vif)
 		ieee80211_hw_set(hw, NO_AUTO_VIF);
@@ -5828,10 +5889,15 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 			    &hwsim_fops_group);
 	debugfs_create_file("rx_rssi", 0666, data->debugfs, data,
 			    &hwsim_fops_rx_rssi);
-	if (!data->use_chanctx)
+	if (!data->use_chanctx) {
 		debugfs_create_file("dfs_simulate_radar", 0222,
 				    data->debugfs,
 				    data, &hwsim_simulate_radar);
+		if (background_radar)
+			debugfs_create_file("dfs_background_cac", 0200,
+					    data->debugfs,
+					    data, &hwsim_background_cac_ops);
+	}
 
 	if (param->pmsr_capa) {
 		data->pmsr_capa = *param->pmsr_capa;
-- 
2.43.0


