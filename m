Return-Path: <linux-wireless+bounces-9783-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C0591E259
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 16:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B6F528833A
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 14:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EA33D3BC;
	Mon,  1 Jul 2024 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="YJh9s/ea"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DEC8C1D
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 14:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843919; cv=none; b=WUJeE/e8/pnIEV96Q2NFgyE47eFF5Be8ayKtpidG5c47LOl3Na18dqB3pOiGDLQAkNlDu/8gv3W5ArjnMc73h5SurB9nh9Nwg/YzF9QK0TxUGmb/V7ytmT9PeCSNaXwd5l7jf1/KwbztZyF5kiA/Ldbw6v8hMS8xUYKrX8LG40I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843919; c=relaxed/simple;
	bh=WctNaj/0b0AhTTZL46DhT9To+2ge/g3Mk9SLXAPttwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YioVwYSCFSrTo1sbV+ZicFCUdBVzBzxVsuzqNO8ratlE9hEPzYSvsnNx9chTNfie7rezTTcTYX9TQkeG4Tym399F3jZFIU6IF3c9ti3+QL/vBSF+ybhBmLKIoI3NoCp+BY3UzqOrloF0zA8BmvV+WxIW7dubunQJFVii0gQPvbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=YJh9s/ea; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=JV/ANj3jKAjuMpJ11DXLC1T9vhymTAa8DJXksYH6ngI=; b=YJh9s/eaYNOsuUstw+4O7q/8Yc
	oW/nfq00+B6g9EVa+zpMwWB47+1fr2WREzSzuRBw5a6RSR73Ysp9iiH5uumNu5wm6++bfpscbOREc
	FrNDLchy//wBBPvYuvQzz3m7XSD9eFRsEGNMe2kR/wy1ehiSWy5ml/d6CEZtZY43EsIs=;
Received: from p4ff13dca.dip0.t-ipconnect.de ([79.241.61.202] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sOHmb-001Qfu-0W;
	Mon, 01 Jul 2024 16:13:29 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	quic_adisi@quicinc.com,
	quic_periyasa@quicinc.com,
	ath12k@lists.infradead.org
Subject: [PATCH v3 10/10] wifi: mac80211_hwsim: add support for multi-radio wiphy
Date: Mon,  1 Jul 2024 16:13:25 +0200
Message-ID: <e4fc5d3bf5b85e86ebf68a5bcd071a9565e740ea.1719843147.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.a50ea6fd728e14cfdaafeb9cfac003364713c8e7.1719843147.git-series.nbd@nbd.name>
References: <cover.a50ea6fd728e14cfdaafeb9cfac003364713c8e7.1719843147.git-series.nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This registers one wiphy radio per supported band. Number of different
channels is set per radio.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 74 +++++++++++++++++---
 drivers/net/wireless/virtual/mac80211_hwsim.h |  4 +-
 2 files changed, 67 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 8491eb32f760..86ff0ad5992e 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -69,6 +69,10 @@ static bool mlo;
 module_param(mlo, bool, 0444);
 MODULE_PARM_DESC(mlo, "Support MLO");
 
+static bool multi_radio;
+module_param(multi_radio, bool, 0444);
+MODULE_PARM_DESC(mlo, "Support Multiple Radios per wiphy");
+
 /**
  * enum hwsim_regtest - the type of regulatory tests we offer
  *
@@ -669,6 +673,10 @@ struct mac80211_hwsim_data {
 	struct ieee80211_iface_limit if_limits[3];
 	int n_if_limits;
 
+	struct ieee80211_iface_combination if_combination_radio;
+	struct wiphy_radio_freq_range radio_range[NUM_NL80211_BANDS];
+	struct wiphy_radio radio[NUM_NL80211_BANDS];
+
 	u32 ciphers[ARRAY_SIZE(hwsim_ciphers)];
 
 	struct mac_address addresses[2];
@@ -917,6 +925,7 @@ static const struct nla_policy hwsim_genl_policy[HWSIM_ATTR_MAX + 1] = {
 	[HWSIM_ATTR_MLO_SUPPORT] = { .type = NLA_FLAG },
 	[HWSIM_ATTR_PMSR_SUPPORT] = NLA_POLICY_NESTED(hwsim_pmsr_capa_policy),
 	[HWSIM_ATTR_PMSR_RESULT] = NLA_POLICY_NESTED(hwsim_pmsr_peers_result_policy),
+	[HWSIM_ATTR_MULTI_RADIO] = { .type = NLA_FLAG },
 };
 
 #if IS_REACHABLE(CONFIG_VIRTIO)
@@ -4018,6 +4027,7 @@ struct hwsim_new_radio_params {
 	bool reg_strict;
 	bool p2p_device;
 	bool use_chanctx;
+	bool multi_radio;
 	bool destroy_on_close;
 	const char *hwname;
 	bool no_vif;
@@ -4094,6 +4104,12 @@ static int append_radio_msg(struct sk_buff *skb, int id,
 			return ret;
 	}
 
+	if (param->multi_radio) {
+		ret = nla_put_flag(skb, HWSIM_ATTR_MULTI_RADIO);
+		if (ret < 0)
+			return ret;
+	}
+
 	if (param->hwname) {
 		ret = nla_put(skb, HWSIM_ATTR_RADIO_NAME,
 			      strlen(param->hwname), param->hwname);
@@ -5114,6 +5130,7 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 	struct net *net;
 	int idx, i;
 	int n_limits = 0;
+	int n_bands = 0;
 
 	if (WARN_ON(param->channels > 1 && !param->use_chanctx))
 		return -EINVAL;
@@ -5217,22 +5234,22 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 		n_limits++;
 	}
 
+	data->if_combination.radar_detect_widths =
+				BIT(NL80211_CHAN_WIDTH_5) |
+				BIT(NL80211_CHAN_WIDTH_10) |
+				BIT(NL80211_CHAN_WIDTH_20_NOHT) |
+				BIT(NL80211_CHAN_WIDTH_20) |
+				BIT(NL80211_CHAN_WIDTH_40) |
+				BIT(NL80211_CHAN_WIDTH_80) |
+				BIT(NL80211_CHAN_WIDTH_160);
+
 	if (data->use_chanctx) {
 		hw->wiphy->max_scan_ssids = 255;
 		hw->wiphy->max_scan_ie_len = IEEE80211_MAX_DATA_LEN;
 		hw->wiphy->max_remain_on_channel_duration = 1000;
-		data->if_combination.radar_detect_widths = 0;
 		data->if_combination.num_different_channels = data->channels;
 	} else {
 		data->if_combination.num_different_channels = 1;
-		data->if_combination.radar_detect_widths =
-					BIT(NL80211_CHAN_WIDTH_5) |
-					BIT(NL80211_CHAN_WIDTH_10) |
-					BIT(NL80211_CHAN_WIDTH_20_NOHT) |
-					BIT(NL80211_CHAN_WIDTH_20) |
-					BIT(NL80211_CHAN_WIDTH_40) |
-					BIT(NL80211_CHAN_WIDTH_80) |
-					BIT(NL80211_CHAN_WIDTH_160);
 	}
 
 	if (!n_limits) {
@@ -5350,6 +5367,9 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 
 	for (band = NL80211_BAND_2GHZ; band < NUM_NL80211_BANDS; band++) {
 		struct ieee80211_supported_band *sband = &data->bands[band];
+		struct wiphy_radio_freq_range *radio_range;
+		const struct ieee80211_channel *c;
+		struct wiphy_radio *radio;
 
 		sband->band = band;
 
@@ -5423,8 +5443,36 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 		mac80211_hwsim_sband_capab(sband);
 
 		hw->wiphy->bands[band] = sband;
+
+		if (!param->multi_radio)
+			continue;
+
+		c = sband->channels;
+		radio_range = &data->radio_range[n_bands];
+		radio_range->start_freq = ieee80211_channel_to_khz(c) - 10000;
+
+		c += sband->n_channels - 1;
+		radio_range->end_freq = ieee80211_channel_to_khz(c) + 10000;
+
+		radio = &data->radio[n_bands++];
+		radio->freq_range = radio_range;
+		radio->n_freq_range = 1;
+		radio->iface_combinations = &data->if_combination_radio;
+		radio->n_iface_combinations = 1;
 	}
 
+	if (param->multi_radio) {
+		hw->wiphy->radio = data->radio;
+		hw->wiphy->n_radio = n_bands;
+
+		memcpy(&data->if_combination_radio, &data->if_combination,
+		       sizeof(data->if_combination));
+		data->if_combination.num_different_channels *= n_bands;
+	}
+
+	if (data->use_chanctx)
+		data->if_combination.radar_detect_widths = 0;
+
 	/* By default all radios belong to the first group */
 	data->group = 1;
 	mutex_init(&data->mutex);
@@ -6042,6 +6090,9 @@ static int hwsim_new_radio_nl(struct sk_buff *msg, struct genl_info *info)
 	else
 		param.use_chanctx = (param.channels > 1);
 
+	if (info->attrs[HWSIM_ATTR_MULTI_RADIO])
+		param.multi_radio = true;
+
 	if (info->attrs[HWSIM_ATTR_REG_HINT_ALPHA2])
 		param.reg_alpha2 =
 			nla_data(info->attrs[HWSIM_ATTR_REG_HINT_ALPHA2]);
@@ -6122,7 +6173,7 @@ static int hwsim_new_radio_nl(struct sk_buff *msg, struct genl_info *info)
 
 	param.mlo = info->attrs[HWSIM_ATTR_MLO_SUPPORT];
 
-	if (param.mlo)
+	if (param.mlo || param.multi_radio)
 		param.use_chanctx = true;
 
 	if (info->attrs[HWSIM_ATTR_RADIO_NAME]) {
@@ -6815,7 +6866,8 @@ static int __init init_mac80211_hwsim(void)
 
 		param.p2p_device = support_p2p_device;
 		param.mlo = mlo;
-		param.use_chanctx = channels > 1 || mlo;
+		param.multi_radio = multi_radio;
+		param.use_chanctx = channels > 1 || mlo || multi_radio;
 		param.iftypes = HWSIM_IFTYPE_SUPPORT_MASK;
 		if (param.p2p_device)
 			param.iftypes |= BIT(NL80211_IFTYPE_P2P_DEVICE);
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.h b/drivers/net/wireless/virtual/mac80211_hwsim.h
index 28c1db482e79..f32fc3a492b0 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.h
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.h
@@ -157,6 +157,9 @@ enum hwsim_commands {
  *	to provide details about peer measurement request (nl80211_peer_measurement_attrs)
  * @HWSIM_ATTR_PMSR_RESULT: nested attributed used with %HWSIM_CMD_REPORT_PMSR
  *	to provide peer measurement result (nl80211_peer_measurement_attrs)
+ * @HWSIM_ATTR_MULTI_RADIO: Register multiple wiphy radios (flag).
+ *	Adds one radio for each band. Number of supported channels will be set for
+ *	each radio instead of for the wiphy.
  * @__HWSIM_ATTR_MAX: enum limit
  */
 enum hwsim_attrs {
@@ -189,6 +192,7 @@ enum hwsim_attrs {
 	HWSIM_ATTR_PMSR_SUPPORT,
 	HWSIM_ATTR_PMSR_REQUEST,
 	HWSIM_ATTR_PMSR_RESULT,
+	HWSIM_ATTR_MULTI_RADIO,
 	__HWSIM_ATTR_MAX,
 };
 #define HWSIM_ATTR_MAX (__HWSIM_ATTR_MAX - 1)
-- 
git-series 0.9.1

