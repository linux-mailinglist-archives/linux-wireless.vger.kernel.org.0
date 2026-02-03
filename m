Return-Path: <linux-wireless+bounces-31510-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EZ1CoZFgmlHRQMAu9opvQ
	(envelope-from <linux-wireless+bounces-31510-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 19:59:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D6ADDFE5
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 19:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0617D306E352
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Feb 2026 18:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766D436681F;
	Tue,  3 Feb 2026 18:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ev+J0Sqn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B053026B756
	for <linux-wireless@vger.kernel.org>; Tue,  3 Feb 2026 18:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770145058; cv=none; b=FfMzw1ro6+V/nGIe39kGWgOUuUEqsu5vow2fajjTCACFWa5bNy/dIie579604UIXccjYOuN8C8CSPZurcPTIOa5EMgPI6yWMizJ+/a06icg/QY7ZUppV5aURNox1jpWZnDkLIxNbyIeKRpgriE4V1yxZSuiHgr2TA2T6qExVhJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770145058; c=relaxed/simple;
	bh=+V+g3D9Luz3B3dTeS18x16bC4svBIdk2YYruVrwhESc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZEKmOp9SbVWh6CrLzFizG4gDKZAJQ0q4CuFcMdpXNxU5vOykwgSZiDGXL0wDqAy7jBl6AUNcMNvxKeUFNh4xnSqjWzNppt+hThoFENBDxOWXgbf82Djxd5hc0CP7YOibiKClVdps4iPwN8aaq+mf6xczgGfQupQJIsjQF+DM2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ev+J0Sqn; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-482f454be5bso1335605e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 03 Feb 2026 10:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770145055; x=1770749855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Jg0o4TdMJmXtV1vN+Qv1MoVD9q9l2k1x/duYF/0zTg=;
        b=Ev+J0Sqn+HndSlr0bAlET3apblbLmYPFriuOZqvN7seU/b/g2Y4D04rLsfHh+zS3R9
         wT1DOhyx9VMtyaYryFuXUmdT+zT4A04ZNdn4kQ7RvdXfni3rSVFQoVBv5FFLzPr9onZy
         ADzxPqdzGk2Pps8KMCXzhgm25BjBDxLDT+edRfnAS9zl1q6Jy9HK2LtMQfPd4bDlVb2U
         8iIeRFGugXCynmAEFpp6nGetIE+hV0z8zmAe2uoLyGNIUEBTfCMZxuKlh/RQll0j3Hpq
         HbpcpYqFORg9bjGyRAexCRUCdV8pjgePmVNaJKALctu8WPaayBCEu+4wqxEn/3u8O0Jf
         V5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770145055; x=1770749855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Jg0o4TdMJmXtV1vN+Qv1MoVD9q9l2k1x/duYF/0zTg=;
        b=tdVIRwERel4FrvTXP/s1fXDOfau9KyeZ/r39TGoNN+vlrZwD07pOMAOXTLSNNoYJRX
         xFOe+zsA1Hb3xGfc7xzMXSALbrsEOeQIirMYol4K5pvwsDhDMGLiHrQ4ZcpmoQ1aeVFw
         TKoiYJN3lH1IoBadGLEvv5JC0GefqvAOUQUjIBwXKQrrz+OOK6/MX3FGys8qZtdpkq21
         Q3vqM6zco/fy5oAT8LsEGckxJCN1zwMgYYswNaVGpVKWgI3bOo8kEaF/3nD6F42u39yk
         AjnVkoZPtlfWXoqMBHFuCKC+W650svzqNoe4eBkW4/K7xD19tnS+llfNZPs8/mLyTymj
         nBGw==
X-Gm-Message-State: AOJu0YzpoIGoGDpQ1x66v69DKeGa2bGk7v6qBER0OMu1LUsTipVnAFK9
	jH4rBQwqmWU2j6M3GBUMuiE8I2U3QMKjuW+Rnh0hFDxI0FENGPC4XJwZDGYW2g==
X-Gm-Gg: AZuq6aJ0skZYSmr+xdnB17kawzvqyNiKfYoCoWSFkNh9GbCBO4oU/yYo8tpedDpZqrZ
	DgZx2zCp6Z15S4/H5Gam+u9VrRsen7bi5QirP0BIWUGd30EesQ3nYQB29NfnvK90ILT8nXUY3vV
	cz6EnrEJkBf2/dky1BUnZZYsDqgwlpo+RSJMBiPdFkbZIkQ8cU8JtNoEjaHH19DI2fAq1hqbSOx
	8vOvGXOw9kyQTtt9u2jqyDFfrEFVUQxB8XUOu95kSS4mZbU7zHaVaZh4jUXUEhQTfic2rUzc/5s
	gRMNFm8/Q2u8ppekInvKz3FbREO2R+Jwj+oHwXcQP+H/dsEnUCVdiDDPFOlEzKM1/VfI1Os+ryJ
	nNpSe5yiP3VSYVP2iqfSzWCyrZLDo1FNDSnY2Xr0XHfVl4qmTDoMVbW+iilzAm2VzvXZb14CFKz
	iGTv0KzIpKtBqf6IzSzeKgl8dTa/1eMLHfqXk+biMdJuFgPfAn
X-Received: by 2002:a05:600c:154e:b0:475:d9de:952e with SMTP id 5b1f17b1804b1-4830eb1cc31mr5962775e9.1.1770145054904;
        Tue, 03 Feb 2026 10:57:34 -0800 (PST)
Received: from hp.. (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830eac4d11sm7773425e9.3.2026.02.03.10.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 10:57:34 -0800 (PST)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [PATCH wireless-next 4/4] wifi: mac80211_hwsim: background CAC support
Date: Tue,  3 Feb 2026 19:53:49 +0100
Message-ID: <20260203185717.103810-5-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203185717.103810-1-janusz.dziedzic@gmail.com>
References: <20260203185717.103810-1-janusz.dziedzic@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31510-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07D6ADDFE5
X-Rspamd-Action: no action

Report background CAC support and add allow
to cancel background CAC and simulate radar.

echo cancel > /sys/kernel/debug/ieee80211/phy2/hwsim/dfs_background_cac
echo radar > /sys/kernel/debug/ieee80211/phy2/hwsim/dfs_background_cac

Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 77 +++++++++++++++++++
 drivers/net/wireless/virtual/mac80211_hwsim.h |  2 +
 2 files changed, 79 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 4d9f5f87e814..8b5618c2111f 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -715,6 +715,7 @@ struct mac80211_hwsim_data {
 	} ps;
 	bool ps_poll_pending;
 	struct dentry *debugfs;
+	struct cfg80211_chan_def radar_background_chandef;
 
 	atomic_t pending_cookie;
 	struct sk_buff_head pending;	/* packets pending */
@@ -936,6 +937,7 @@ static const struct nla_policy hwsim_genl_policy[HWSIM_ATTR_MAX + 1] = {
 	[HWSIM_ATTR_PMSR_RESULT] = NLA_POLICY_NESTED(hwsim_pmsr_peers_result_policy),
 	[HWSIM_ATTR_MULTI_RADIO] = { .type = NLA_FLAG },
 	[HWSIM_ATTR_SUPPORT_NAN_DEVICE] = { .type = NLA_FLAG },
+	[HWSIM_ATTR_SUPPORT_BACKGROUND_RADAR] = { .type = NLA_FLAG },
 };
 
 #if IS_REACHABLE(CONFIG_VIRTIO)
@@ -1164,6 +1166,41 @@ static int hwsim_write_simulate_radar(void *dat, u64 val)
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
@@ -4154,6 +4191,24 @@ static int mac80211_hwsim_change_nan_config(struct ieee80211_hw *hw,
 	return 0;
 }
 
+static int mac80211_hwsim_set_radar_background(struct ieee80211_hw *hw,
+					       struct cfg80211_chan_def *chan)
+{
+	struct mac80211_hwsim_data *data = hw->priv;
+
+	if (!wiphy_ext_feature_isset(hw->wiphy,
+				     NL80211_EXT_FEATURE_RADAR_BACKGROUND))
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
@@ -4189,6 +4244,7 @@ static int mac80211_hwsim_change_nan_config(struct ieee80211_hw *hw,
 	.start_nan = mac80211_hwsim_start_nan,                  \
 	.stop_nan = mac80211_hwsim_stop_nan,                    \
 	.nan_change_conf = mac80211_hwsim_change_nan_config,    \
+	.set_radar_background = mac80211_hwsim_set_radar_background, \
 	HWSIM_DEBUGFS_OPS
 
 #define HWSIM_NON_MLO_OPS					\
@@ -4255,6 +4311,7 @@ struct hwsim_new_radio_params {
 	bool mlo;
 	const struct cfg80211_pmsr_capabilities *pmsr_capa;
 	bool nan_device;
+	bool background_radar;
 };
 
 static void hwsim_mcast_config_msg(struct sk_buff *mcast_skb,
@@ -4340,6 +4397,12 @@ static int append_radio_msg(struct sk_buff *skb, int id,
 		if (ret < 0)
 			return ret;
 	}
+
+	if (param->background_radar) {
+		ret = nla_put_flag(skb, HWSIM_ATTR_SUPPORT_BACKGROUND_RADAR);
+		if (ret < 0)
+			return ret;
+	}
 	return 0;
 }
 
@@ -5794,6 +5857,9 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 
 	wiphy_ext_feature_set(hw->wiphy,
 			      NL80211_EXT_FEATURE_DFS_CONCURRENT);
+	if (param->background_radar)
+		wiphy_ext_feature_set(hw->wiphy,
+				      NL80211_EXT_FEATURE_RADAR_BACKGROUND);
 
 	if (param->no_vif)
 		ieee80211_hw_set(hw, NO_AUTO_VIF);
@@ -5832,6 +5898,10 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 		debugfs_create_file("dfs_simulate_radar", 0222,
 				    data->debugfs,
 				    data, &hwsim_simulate_radar);
+	if (param->background_radar)
+		debugfs_create_file("dfs_background_cac", 0200,
+				    data->debugfs,
+				    data, &hwsim_background_cac_ops);
 
 	if (param->pmsr_capa) {
 		data->pmsr_capa = *param->pmsr_capa;
@@ -5950,6 +6020,9 @@ static int mac80211_hwsim_get_radio(struct sk_buff *skb,
 	param.channels = data->channels;
 	param.hwname = wiphy_name(data->hw->wiphy);
 	param.pmsr_capa = &data->pmsr_capa;
+	param.background_radar =
+		wiphy_ext_feature_isset(data->hw->wiphy,
+					NL80211_EXT_FEATURE_RADAR_BACKGROUND);
 
 	res = append_radio_msg(skb, data->idx, &param);
 	if (res < 0)
@@ -6387,6 +6460,9 @@ static int hwsim_new_radio_nl(struct sk_buff *msg, struct genl_info *info)
 	if (info->attrs[HWSIM_ATTR_MULTI_RADIO])
 		param.multi_radio = true;
 
+	if (info->attrs[HWSIM_ATTR_SUPPORT_BACKGROUND_RADAR])
+		param.background_radar = true;
+
 	if (info->attrs[HWSIM_ATTR_REG_HINT_ALPHA2])
 		param.reg_alpha2 =
 			nla_data(info->attrs[HWSIM_ATTR_REG_HINT_ALPHA2]);
@@ -7165,6 +7241,7 @@ static int __init init_mac80211_hwsim(void)
 		param.p2p_device = support_p2p_device;
 		param.mlo = mlo;
 		param.multi_radio = multi_radio;
+		param.background_radar = true;
 		param.use_chanctx = channels > 1 || mlo || multi_radio;
 		param.iftypes = HWSIM_IFTYPE_SUPPORT_MASK;
 		if (param.p2p_device)
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.h b/drivers/net/wireless/virtual/mac80211_hwsim.h
index c2d06cf852a5..a022cd5c0f1c 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.h
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.h
@@ -161,6 +161,7 @@ enum hwsim_commands {
  *	Adds one radio for each band. Number of supported channels will be set for
  *	each radio instead of for the wiphy.
  * @HWSIM_ATTR_SUPPORT_NAN_DEVICE: support NAN Device virtual interface (flag)
+ * @HWSIM_ATTR_SUPPORT_BACKGROUND_RADAR: background radar/CAC support (flag)
  * @__HWSIM_ATTR_MAX: enum limit
  */
 enum hwsim_attrs {
@@ -195,6 +196,7 @@ enum hwsim_attrs {
 	HWSIM_ATTR_PMSR_RESULT,
 	HWSIM_ATTR_MULTI_RADIO,
 	HWSIM_ATTR_SUPPORT_NAN_DEVICE,
+	HWSIM_ATTR_SUPPORT_BACKGROUND_RADAR,
 	__HWSIM_ATTR_MAX,
 };
 #define HWSIM_ATTR_MAX (__HWSIM_ATTR_MAX - 1)
-- 
2.43.0


