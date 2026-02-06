Return-Path: <linux-wireless+bounces-31622-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLSwNZUihmklKAQAu9opvQ
	(envelope-from <linux-wireless+bounces-31622-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Feb 2026 18:19:17 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A74A100DFF
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Feb 2026 18:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89F5B30396B9
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Feb 2026 17:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6375B3E95BB;
	Fri,  6 Feb 2026 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgwIknZR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149BB3DA7CF
	for <linux-wireless@vger.kernel.org>; Fri,  6 Feb 2026 17:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398327; cv=none; b=S/nRA8wzzeV2CNMMBRgPsOGpB/bsPU9hEC5APZf7Qaleo4vw6bZR4FUK7Z5q4p+jWO/5JM5BjnFZfPD3/2WPp1V2/VC2gUzGXlkonI7dJBhgyoW3TjQrklCJeB+dP86aBNt/Vd13RnnF2pAeWt6AgLvSNsa3gzdalR8ctqc+g3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398327; c=relaxed/simple;
	bh=+V+g3D9Luz3B3dTeS18x16bC4svBIdk2YYruVrwhESc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSt5R7niDcKJLvmE5+vi4qCsRnAwQjGbC0HFb5APoKHIgvyftBazY5FS8NDfXE+BHxubZvoVuh/tdw8T/tdNcOn9g+mWcGZ6MuGyghlaavtzSkzxdSzgawpF/zi8ZAunBbvmEPzMhsUajeSssGkZpSqeuCP1dSGvT6/VblxW5lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgwIknZR; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4362ab556f5so715143f8f.3
        for <linux-wireless@vger.kernel.org>; Fri, 06 Feb 2026 09:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770398325; x=1771003125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Jg0o4TdMJmXtV1vN+Qv1MoVD9q9l2k1x/duYF/0zTg=;
        b=ZgwIknZR2ewo2RtVauhmiERiCBXxUR8MIqFElUOWMMDhmk1+xgUzbNOR8nrY1CPgoP
         IIJBROtD+kQlXXechuKAtybCkfyBXbyM//cy8D6AvsacpMUsM0CPrEcQO7M+CJD3NvBc
         srohZ0sjvNimWS/MymfvmGrbxuB2mxcImryHjj+TPMArH0hC+4jQTerCxibIMv31gmMR
         CFhoHs7a2mUYC9vAJeZzxlln3yR1SSaw3enw6GSK2LljVHMxxsPBI1krrvPgRPPfmQjN
         ebhBqQBZ+O4V8Ppkx4A3BCmc4iGOSmg2/2hbAcgxikeF15QiwH0NIa8D0RAqiC8dTBdV
         pThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770398325; x=1771003125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Jg0o4TdMJmXtV1vN+Qv1MoVD9q9l2k1x/duYF/0zTg=;
        b=AMT0VUPtM+PxvKAq5D3aO0fyul+HJV3zzrX+m9k2O/3uC3kqLOuUjJhaXRMUBTl3qz
         TdjYY26v8wPQTc7XRqGJuhFVM5GT6NRqkTQuQA3PB6/tE2k3EDyR35j5DpcPBK9v2OVj
         vL+4Sfq0TDpcHcBsyFBVQpq4CTmHMEVsaoe+g1ycOFVbeEoEIXqWk1K+pFsU0BQ7vges
         Pf0uGEamuFtPQuuECtU1mYkPmsVicX1BLf2DgM2YJYY8RQWeV78GNgBGoEoO5C3ej/Fj
         sBkg+u49tL7Q6vJBj82DP4Irh5HQoYxXmD6201oFxyhrZqehj7JsvyXs+slY5KrrVf7b
         AIsw==
X-Gm-Message-State: AOJu0YxXbRxt6rAZJwBbw8drgTWv03GefKLqk1Ls9b42jN0vD1WOpEyq
	fE82BDZYWkprQi/cZprgCUU765XowJWastHRv299aNJRDhRlbgIRvomnHMsE3ppw
X-Gm-Gg: AZuq6aLFKt+fMU7wMVMwUhNQv3ylX9ek0+be4QlqPChvMhQpDQGdgKQiE4n4DIznU08
	9bNemkXCLWmebdT6wi+qDTxp2BqggyniY8kq8WuBneUFPHalSNdXVt+ygg2vdEM1NqayRPEV1Zy
	Dj2gO79uc5fcTKAFuHmXAQ5Ky2breKZxngWUTm4Yvrt9LCCgv12D2D/V8g3VYeWOA1oWBO/gg3R
	L0RtrAmpNvV0EV88ZskOgVAaYtDBEiOyA9BsGa+QjKGvp1pOQLiW0F4mTL5oXfv9pLenkd+jYpd
	zSbnHCGV3EfpaUiAZRRbtRlaeJLz5ViJ4TCweDHnhbt2WRofn0HZ69DFfkbBmAjoaZhcZ8X5/IH
	edk8DgCYufCEFt9cSiey4kgVEqUc2m27P+xEssWPCCX4AK1VzyjnCOvoNrs2AMSKw+ebESPgZjS
	iVD6Wede7jg46qUyhboYs/oN3DtTZCN2jVrWUJcKJnniWvRVsn
X-Received: by 2002:a5d:5f54:0:b0:435:9ce0:f93c with SMTP id ffacd0b85a97d-4362969509amr5819282f8f.62.1770398325200;
        Fri, 06 Feb 2026 09:18:45 -0800 (PST)
Received: from hp.. (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4362974527fsm7986208f8f.31.2026.02.06.09.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 09:18:44 -0800 (PST)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [PATCH v2 wireless-next 4/4] wifi: mac80211_hwsim: background CAC support
Date: Fri,  6 Feb 2026 18:15:51 +0100
Message-ID: <20260206171830.553879-5-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206171830.553879-1-janusz.dziedzic@gmail.com>
References: <20260206171830.553879-1-janusz.dziedzic@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-31622-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A74A100DFF
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


