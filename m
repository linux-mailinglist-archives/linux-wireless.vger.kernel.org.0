Return-Path: <linux-wireless+bounces-29261-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 309A7C7D648
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Nov 2025 20:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B28873516A8
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Nov 2025 19:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB292C178E;
	Sat, 22 Nov 2025 19:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TW3MFJ9a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C4F272E7C
	for <linux-wireless@vger.kernel.org>; Sat, 22 Nov 2025 19:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763839350; cv=none; b=skTEgbr/ltpegeyiNw0iWVXDStzBsn89f7oZnLKL8mpJG7usvkxny0QtRZjrUgdSkPLK/MI4GgPOFinflONtQlvYYcFY2C7tjM6aQV1PZmIqfqF5cNTIiIinvhAPPAe2U9KpdOkLcskCSJjvjliWw1pUXfizF75/WYZvz+FJCP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763839350; c=relaxed/simple;
	bh=IxYYfWWWZmQM0Acs3cNBaEpYmaCWgughb8FgcDWc7r8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SHHiPNj/vHIs9spv+Nu6dt1Wx0DsAEg6kZK25u47kQ7tiyuqGDO1NA5aGbkggNDXv4ORFQM8J0oUiVVmTd4G/daaX+RwrWpDDXoIUP3ie3I5BxgAhfs6ipG1VODRIJ4E+VPF+QqQ/3r2VqKoEQ5omq6tyMs68giMbOKHaa4xKfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TW3MFJ9a; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640ca678745so5147615a12.2
        for <linux-wireless@vger.kernel.org>; Sat, 22 Nov 2025 11:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763839347; x=1764444147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wklJ5vVfHT3E/nIil+ZleMDpgskJqV5hs0yPobXgH4U=;
        b=TW3MFJ9aqOj0oK83bVjZnZYjBgl2XqYjTWKU8FQ+q3Kgn66E+buR3qJ7EwSorOxMAi
         DrwOHXwknR+2zm96kZpy9asLTzKMk5/QByet2RPpXIQ6S+yE0/B/OPQD5TJ1WITCl+ht
         F9Xp+nlK9eEH9TftkXXK2YA3kXXGyBg6kpwg9aufMMGk0C+RB0R7eAd8J6SezPKDcaA1
         F6Ar0qRaIYKYdKECvNGLA1lIkDj1KqL8YogQv2AcnnELP8JrR4tkkvCAvKGLsA/1UgR2
         iYQNSVauMLmEvwLbPuWwzodaXwA0dk4Zx2oweXnbPetbMobprbcFH1A2SStsRdj9JdbV
         uqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763839347; x=1764444147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wklJ5vVfHT3E/nIil+ZleMDpgskJqV5hs0yPobXgH4U=;
        b=lawZ1qo6Bv5lXrwNgIOgL+TfRpkdqydnW6DPvt96vPHgTn4jVcmgUc7rub8b/947BU
         jBjLN2tshasUwArr5sa4292UkIl0pmVaWOQyODNeSgIdidGET2ALwmkj+kKJMpk+UKj8
         7/mG9waY4kxXa3O3B5BFl4bflGEuqSrFQWFXIwx2Xa3Sw6S37GsHD0FdO8kHnE225Nyk
         fHKm2b6/9pESIM4bQOYTS6BiQ3sV9pdaoLozEautNZhrazoLnMoFB5MHizQmkuGN5FpX
         7Nhrh7ef0fZnpwpBtsMg50GVpUGztz+ToSZGU1pOFY56cjPb3M+TgTpY6hSV/2whoEuI
         rndA==
X-Gm-Message-State: AOJu0Yz/yxkLS81mGNSajwe1LAE/dCn1ki5aQmE/bG8igyRvGJ1V5xrD
	8PhXhBPPXXNjmbFIVqEaOwvW2u/KUb5STzIcgZ7Slu9NT8fp3f1Tsx9OjIGvs4GO
X-Gm-Gg: ASbGncvNWzFYu28qxTkUOZ8NMBzHH4dMz6dOGVOLUWhY2WHGkK0OhrcssdyFuU3OUne
	CXazSn+RFZL3xZSLtq9HJkK6WRWhdjZwH13f/0cTVe2y2w+FctBNKjzPQkOYzesn8d/xqMrGbg/
	7CvhjDkilIaQx4AOpWBaXGpDvH5uEROlJGczhGrWnXXTH8vQQu1Ey94GKrxvQE9OGGq3TtaS/yq
	iy3oe1KSYLbkd3Vaz+oahyPA2agXl318XlKHuWu/EcB/ldbFt6R7RjG9tyfzQoeifxFcIV7I1IE
	BjIwoMIEr5ilmqK9ddRmzmGN+djDJJFgtM4YG8PPviMQLR9vboqFvCLIQOx+mGUrImlEzUGVe2F
	BrYP4umGsHkGriOa60KFZmddmlZC2NHkuNLcij66DxJd3lshyoTYWsd2IGTDieKG018dsS/DqzQ
	Rc2uX/ZoW0Brx31bEkaVdpcNZv1Cv7V05oNW8CX+Wq2nMJmp+hL4Y=
X-Google-Smtp-Source: AGHT+IFRIcOr9QbRzoVfYBw2/tS4Dr/oox8Ntwb60Jjf//7onoqLb3af1NElz9jau2KG9LYZ+6rTSw==
X-Received: by 2002:a05:6402:2787:b0:641:2cf3:ec3e with SMTP id 4fb4d7f45d1cf-64555b9819fmr5752918a12.11.1763839346818;
        Sat, 22 Nov 2025 11:22:26 -0800 (PST)
Received: from hp.lan (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6453642d321sm7517378a12.20.2025.11.22.11.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 11:22:26 -0800 (PST)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [RFC v4 wireless-next 4/4] wifi: mac80211_hwsim: background CAC support
Date: Sat, 22 Nov 2025 20:17:06 +0100
Message-ID: <20251122192204.6866-5-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251122192204.6866-1-janusz.dziedzic@gmail.com>
References: <20251122192204.6866-1-janusz.dziedzic@gmail.com>
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
index 551f5eb4e747..cca22d46ad05 100644
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


