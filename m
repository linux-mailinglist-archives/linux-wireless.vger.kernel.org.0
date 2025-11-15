Return-Path: <linux-wireless+bounces-28999-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53785C609A1
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Nov 2025 18:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0CC6535AF71
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Nov 2025 17:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E496C3043B9;
	Sat, 15 Nov 2025 17:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+aA+UTk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1142C305058
	for <linux-wireless@vger.kernel.org>; Sat, 15 Nov 2025 17:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763228576; cv=none; b=bOiZ4j5Tbhqk4gthgG6w6bErwPo0pt3r9M8G44huemUH9w5xVguGdti5f2Zza3l94RvOTDLOjt+KlX62bEL9tzgf9o/OYPUvSi0TXzWmfUAPLH4qBcDLeuK6YgjV3xVNKUA8c86alolYmgYgXuHqQxxhMaL6Jy+olmgQI3EupBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763228576; c=relaxed/simple;
	bh=g1gUviCz4sf5qkCWx8Rl76xEQ3AP8IplL/xgq+bssto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mKS/O/InsZloU0zt+MHvjzaKeEsVJiaGYzzk/iBiMljAnvIkGfJ1EJBRJukpSCK3NpmOLW8uUPNXb58fJVHgslGfTBNvTqySIhX6+X08YqUJr6IixzaZRPjXaBCOw15/v43bE6/KofksQ1tIYgW9IOM8dupR49s3+Vk75Ik+EpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+aA+UTk; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b737502f77bso181399866b.2
        for <linux-wireless@vger.kernel.org>; Sat, 15 Nov 2025 09:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763228573; x=1763833373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHyBwx1FNc4CPJ4ZgodZQpWk2iEhSJHGADGgRdWvwaM=;
        b=W+aA+UTk+C3zZHoTYlYbALtE1U0oRR10/v1BgpthebAj6l6wiRqaBBROHF13VSa/qK
         A2GxuS1ohcPWM2I2m1+gkEuep6hULlsjTjyBhSxSckOUvsmkn0F/Iig0855krArIr/3F
         A6mdsOsjsCnFj19vhm+7N3a+NEgi/SJVEosKdBh7YTY+W349m97q17WHd8BikXLs0Ca1
         1BEzJ5a/WgNuG+3pbPNUkW1DNeQPtFA5nMv/LKvLD7JFaEfTB61naB3b5LiPbT2cHtKo
         Fsa8Rf9MHyndwDdqSBf0fqgHo1AJWSr8FAhgAfgJ/q05hOlKKiMPAV0MPKaT75R35p59
         dzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763228573; x=1763833373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mHyBwx1FNc4CPJ4ZgodZQpWk2iEhSJHGADGgRdWvwaM=;
        b=sWYR/NY6MkFQvpmS4fF9ZTPmoIsfNKYsz3cgIqVF2ogz33+zRiN0Xv7R91LRePGQok
         hLvMtSti5FkSgMzm/UjFYVo+yNZ/EGPnM35EdepKCcVOCgAn44AHETEgpZL06qP7tiGe
         8bxnzNOFreqmk5vjLC8LTiav9EcV4tzXAPNUxh3s643OfcueWt7tqJtgQwuSFPKcyW52
         5MILEU63YKqG6kAILeEYq1BUPam6tOQXreYdo1DyQYgxINwTwpTMCcqOJyx7RA48cT7y
         wvk7UQPWPccS9aBEIHFu5ZMpwW3zJBn1ZDHz3k31Zb7u4YTDUe04Nhz9vRIOsFKllHWU
         Ln2g==
X-Gm-Message-State: AOJu0YzWtYWull4CyoQboYf1++Ai22J9PM1ydFC/xbI8ovpZ20Ws+e1z
	L4vGQ/k+Dgbpa9MEVKpjKAvLlUCTGy+dojdVf8dhvBRo9FkLd0bTgxn2B8l5Rg==
X-Gm-Gg: ASbGnctZWgPJJJYjAcTlztNdhrR0KyP3cv7lj+clgp1/hUQ3VcMETX/zW6z4tP6byfm
	iJKrarhmmA/QA15DEVPYYWeCpgL9ZPlGAr063bcsO2USPBcmsckYdV/OvQtwtYBDrR2f1fpMKN0
	+uJt+Va2obiZ/wnh1ATOWTbfrb/5nvSKCxhhgs2I05CExXatIGkHF/WVtKGt+Xosyw/ZcV7Zu5m
	j8Yyo1W6loPSoOXIfNTh6/b9LjNc/RBI67rPLi8M71oOMDXcgfs5mYOg9ZZV6zs5vxXKTO0DEL9
	CaQSfFWCHunVHAJspjDS0KMy9KE3GNK9bsEYGzCPhQiRbO4HWHmGHionMwcBv1Ou4LA/Tnp9Y+k
	1D9YhVXuV2UTXkMVu4YMfHsnvoeO6v74G1t3duudiUZ2pX2TOrABQkrIJRLX0HWPXLOX5oLNRXj
	AJ6JXG1ju2nYdBp7btM1kylteTUR/3zxOOvwvrwEzUdZVRpu78jAY=
X-Google-Smtp-Source: AGHT+IF5HIJasy7qwoT6RRNo7PQv30Iw4snGBxYW3aDTGiuY+eKlLVHykCxS9LM4ViP290AeV75fMA==
X-Received: by 2002:a17:906:7309:b0:b45:60ad:daf9 with SMTP id a640c23a62f3a-b73677ed721mr771212666b.3.1763228573244;
        Sat, 15 Nov 2025 09:42:53 -0800 (PST)
Received: from hp.lan (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fd8099asm664941666b.43.2025.11.15.09.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 09:42:52 -0800 (PST)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [RFC v3 wireless-next 4/4] wifi: mac80211_hwsim: background CAC support
Date: Sat, 15 Nov 2025 18:33:22 +0100
Message-ID: <20251115174230.20504-5-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251115174230.20504-1-janusz.dziedzic@gmail.com>
References: <20251115174230.20504-1-janusz.dziedzic@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Report background CAC support and add allow
to cancel background CAC and simulate radar.

echo cancel > /sys/kernel/debug/ieee80211/phy2/hwsim/dfs_background_cac
echo radar > /sys/kernel/debug/ieee80211/phy2/hwsim/dfs_background_cac

Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 64 ++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 551f5eb4e747..0e0fcb0e5ac2 100644
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
+					       struct cfg80211_chan_def *chandef)
+{
+	struct mac80211_hwsim_data *data = hw->priv;
+
+	if (chandef)
+		data->radar_background_chandef = *chandef;
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


