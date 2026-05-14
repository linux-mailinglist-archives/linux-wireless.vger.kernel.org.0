Return-Path: <linux-wireless+bounces-36402-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHa4Do04BWq6TQIAu9opvQ
	(envelope-from <linux-wireless+bounces-36402-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 04:50:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D33DA53D2CA
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 04:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 324FF3018D60
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 02:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DD02D97B9;
	Thu, 14 May 2026 02:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dd-wrt.com header.i=@dd-wrt.com header.b="dZ8Hf7Xx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.as201155.net (mail.as201155.net [185.84.6.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF9F3F4133
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 02:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.84.6.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778727049; cv=none; b=uiPDqFXXVPjYOOpvK2VRrsKrqQFfWAf48pu5Rt8MVNMXBza6vllGxJJclhwJ6kMjSBSsv6o3FB7umxKOVHELDqrHCUyAhy90lNFNH4YP8CAXjFgUW9fdCgwnEpITN8G6vXDQfw/A3qFoGK5icRjazRuT8zcGOjgjnsLq7tXY2UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778727049; c=relaxed/simple;
	bh=HT030quXnaA+x05jb58akn21NHuvtAU+rftZzNxtQSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a4q+xxMQfUkvolY3KiV1BOT7N5gG0f+K2sLj8hkEZpLG5BKHzjWmyTjFDQdE80f4quPaV1EHtUoGHokexlbh3SNvfvA5hHv32I0qpkF+6ys9Yq51Ud6rzff3+YB7uWhYewyazpnA8HIMBOsXlXCccAsZI1y4Ia+cNX9nVRFmjTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dd-wrt.com; spf=pass smtp.mailfrom=dd-wrt.com; dkim=pass (1024-bit key) header.d=dd-wrt.com header.i=@dd-wrt.com header.b=dZ8Hf7Xx; arc=none smtp.client-ip=185.84.6.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dd-wrt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dd-wrt.com
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:34068 helo=webmail.newmedia-net.de)
	by mail.as201155.net with esmtps  (TLS1) tls TLS_RSA_WITH_AES_256_CBC_SHA
	(Exim 4.97.1)
	(envelope-from <s.gottschall@dd-wrt.com>)
	id 1wNM9j-000000003BQ-1axn;
	Thu, 14 May 2026 04:50:35 +0200
X-SASI-Hits: BODY_SIZE_3000_3999 0.000000, BODY_SIZE_5000_LESS 0.000000,
	BODY_SIZE_7000_LESS 0.000000, CTE_8BIT 0.000000, DKIM_ALIGNS 0.000000,
	DKIM_SIGNATURE 0.000000, HTML_00_01 0.050000, HTML_00_10 0.050000,
	LEGITIMATE_SIGNS 0.000000, MULTIPLE_RCPTS 0.100000,
	MULTIPLE_REAL_RCPTS 0.000000, NO_CTA_URI_FOUND 0.000000,
	NO_FUR_HEADER 0.000000, NO_REAL_NAME 0.000000, NO_URI_HTTPS 0.000000,
	OUTBOUND 0.000000, OUTBOUND_SOPHOS 0.000000, SENDER_NO_AUTH 0.000000,
	SUSP_DH_NEG 0.000000, TO_IN_SUBJECT 0.500000, __ANY_URI 0.000000,
	__BODY_NO_MAILTO 0.000000, __BULK_NEGATE 0.000000, __CC_NAME 0.000000,
	__CC_NAME_DIFF_FROM_ACC 0.000000, __CC_REAL_NAMES 0.000000, __CTE 0.000000,
	__DKIM_ALIGNS_1 0.000000, __DKIM_ALIGNS_2 0.000000, __DQ_NEG_DOMAIN 0.000000,
	__DQ_NEG_HEUR 0.000000, __DQ_NEG_IP 0.000000, __FRAUD_BADTHINGS 0.000000,
	__FROM_DOMAIN_IN_ANY_CC1 0.000000, __FROM_DOMAIN_IN_RCPT 0.000000,
	__FROM_NAME_NOT_IN_ADDR 0.000000, __FUR_RDNS_SOPHOS 0.000000,
	__HAS_CC_HDR 0.000000, __HAS_FROM 0.000000, __HAS_MSGID 0.000000,
	__HAS_X_MAILER 0.000000, __MIME_TEXT_ONLY 0.000000, __MIME_TEXT_P 0.000000,
	__MIME_TEXT_P1 0.000000, __MIME_VERSION 0.000000,
	__MULTIPLE_RCPTS_CC_X2 0.000000, __NO_HTML_TAG_RAW 0.000000,
	__OUTBOUND_SOPHOS_FUR 0.000000, __OUTBOUND_SOPHOS_FUR_IP 0.000000,
	__OUTBOUND_SOPHOS_FUR_RDNS 0.000000, __RCVD_PASS 0.000000,
	__SANE_MSGID 0.000000, __SL_HEAVY 0.000000, __SUBJ_ALPHA_END 0.000000,
	__SUBJ_STARTS_S_BRACKETS 0.000000, __TO_IN_SUBJECT2 0.000000,
	__TO_MALFORMED_2 0.000000, __TO_NO_NAME 0.000000, __URI_MAILTO 0.000000,
	__URI_NO_WWW 0.000000, __URI_NS 0.000000, __X_MAILSCANNER 0.000000
X-SASI-Probability: 10%
X-SASI-RCODE: 200
X-SASI-Version: Antispam-Engine: 5.1.4, AntispamData: 2026.5.14.22719
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dd-wrt.com; s=mikd;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From; bh=7CMKcbI18CZoAdN/ImXeXGh+qevbiPMNi4nmYhMHeRA=;
	b=dZ8Hf7XxTMyMmL/5xV/157HVgvlmGFZCN3WHLfaq3a/KtvyG1ute8FxC4yPbGi9YoFThUb48JPfUTPzekulc7n4yrgQsWEQ9m6+obppMg816+r1qIBjffd8+xmc46n3d495CxGmS5a+xoupZm0lJfSHMvmcGu3cbqAf1+YbyKjg=;
From: s.gottschall@dd-wrt.com
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	Sebastian Gottschall <s.gottschall@dd-wrt.com>
Subject: [PATCH v2] wifi: ath11k: fix txpower in ap mode for 6 Ghz
Date: Thu, 14 May 2026 08:50:33 +0600
Message-ID: <20260514025033.582687-1-s.gottschall@dd-wrt.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass (webmail.newmedia-net.de: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=s.gottschall@dd-wrt.com; helo=webmail.newmedia-net.de;
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: s.gottschall@dd-wrt.com
X-SA-Exim-Scanned: No (on webmail.newmedia-net.de); SAEximRunCond expanded to false
X-NMN-MailScanner-Information: Please contact the ISP for more information
X-NMN-MailScanner-ID: 1wNM9i-000CHH-MH
X-NMN-MailScanner: Found to be clean
X-NMN-MailScanner-From: s.gottschall@dd-wrt.com
X-Received:  from localhost ([127.0.0.1] helo=webmail.newmedia-net.de)
	by webmail.newmedia-net.de with esmtp (Exim 4.72)
	(envelope-from <s.gottschall@dd-wrt.com>)
	id 1wNM9i-000CHH-MH; Thu, 14 May 2026 04:50:34 +0200
X-Rspamd-Queue-Id: D33DA53D2CA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[dd-wrt.com,none];
	R_DKIM_ALLOW(-0.20)[dd-wrt.com:s=mikd];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36402-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s.gottschall@dd-wrt.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[dd-wrt.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,dd-wrt.com:email,dd-wrt.com:mid,dd-wrt.com:dkim]
X-Rspamd-Action: no action

From: Sebastian Gottschall <s.gottschall@dd-wrt.com>

there is an issue which has been discovered a while ago while testing
which killed txpower to 0 dBm once scanning is triggered in AP mode
on QCN9074 based chipsets if 6 GHz is in use.
ath11k_wmi_send_vdev_set_tpc_power must be set in AP mode in the same
way is it is for STA as it is implemented in ath12k and in the
qsdk version for ath11k.
this patch must be considered to be backported (i discovered that issue
already 2 years ago)

fixes: i74ef2d05ede63fd6416aa635aa8972dff901325f
(wifi: ath11k: use WMI_VDEV_SET_TPC_POWER_CMDID when EXT_TPC_REG_SUPPORT for 6 GHz)

Signed-off-by: Sebastian Gottschall <s.gottschall@dd-wrt.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index a48b6bf1f29a..0984c3981ee4 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3497,13 +3497,13 @@ static int ath11k_mac_config_obss_pd(struct ath11k *ar,
 	return 0;
 }
 
-static bool ath11k_mac_supports_station_tpc(struct ath11k *ar,
-					    struct ath11k_vif *arvif,
-					    const struct cfg80211_chan_def *chandef)
+static bool ath11k_mac_supports_tpc(struct ath11k *ar, struct ath11k_vif *arvif,
+				    const struct cfg80211_chan_def *chandef)
 {
 	return ath11k_wmi_supports_6ghz_cc_ext(ar) &&
 		test_bit(WMI_TLV_SERVICE_EXT_TPC_REG_SUPPORT, ar->ab->wmi_ab.svc_map) &&
-		arvif->vdev_type == WMI_VDEV_TYPE_STA &&
+		(arvif->vdev_type == WMI_VDEV_TYPE_STA ||
+		arvif->vdev_type == WMI_VDEV_TYPE_AP) &&
 		arvif->vdev_subtype == WMI_VDEV_SUBTYPE_NONE &&
 		chandef->chan &&
 		chandef->chan->band == NL80211_BAND_6GHZ;
@@ -7647,8 +7647,8 @@ ath11k_mac_vdev_start_restart(struct ath11k_vif *arvif,
 	/* TODO: For now we only set TPC power here. However when
 	 * channel changes, say CSA, it should be updated again.
 	 */
-	if (ath11k_mac_supports_station_tpc(ar, arvif, chandef)) {
-		ath11k_mac_fill_reg_tpc_info(ar, arvif->vif, &arvif->chanctx);
+	if (ath11k_mac_supports_tpc(ar, arvif, chandef)) {
+		ath11k_mac_fill_reg_tpc_info(ar, arvif->vif, ctx);
 		ath11k_wmi_send_vdev_set_tpc_power(ar, arvif->vdev_id,
 						   &arvif->reg_tpc_info);
 	}
@@ -8155,6 +8155,7 @@ void ath11k_mac_fill_reg_tpc_info(struct ath11k *ar,
 		psd_power, tx_power;
 	s8 eirp_power = 0;
 	u16 start_freq, center_freq;
+	u8 reg_6ghz_power_mode;
 
 	chan = ctx->def.chan;
 	start_freq = ath11k_mac_get_6ghz_start_frequency(&ctx->def);
@@ -8311,8 +8312,14 @@ void ath11k_mac_fill_reg_tpc_info(struct ath11k *ar,
 	reg_tpc_info->num_pwr_levels = num_pwr_levels;
 	reg_tpc_info->is_psd_power = is_psd_power;
 	reg_tpc_info->eirp_power = eirp_power;
+	if (arvif->vdev_type == WMI_VDEV_TYPE_STA)
+		reg_6ghz_power_mode = vif->bss_conf.power_type;
+	else
+		/* For now, LPI is the only supported AP power mode */
+		reg_6ghz_power_mode = IEEE80211_REG_LPI_AP;
+
 	reg_tpc_info->ap_power_type =
-		ath11k_reg_ap_pwr_convert(vif->bss_conf.power_type);
+		ath11k_reg_ap_pwr_convert(reg_6ghz_power_mode);
 }
 
 static void ath11k_mac_parse_tx_pwr_env(struct ath11k *ar,
-- 
2.51.0


