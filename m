Return-Path: <linux-wireless+bounces-38504-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Dt4pFuNFRmobNgsAu9opvQ
	(envelope-from <linux-wireless+bounces-38504-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 13:05:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7622C6F6655
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 13:05:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=mail header.b=G2MjV5Z3;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38504-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38504-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=collabora.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC49C31A93CD
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2026 10:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8BA3C2B8F;
	Thu,  2 Jul 2026 10:50:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4103439F187;
	Thu,  2 Jul 2026 10:50:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782989426; cv=none; b=WDft2+Fuy5IZUOju9s3BXgS26DLA/qo0mKoMBX+ykVy+xcQJ8MC6FNwpqEdqpUFoU+/gfIfVwMOssGhMcSlhFT4HjqX4gCrh8Z+mLgNtdv45pvdVOYcPn4yhtj59hHzT+3Chh2sVF716P7n6Yh/lVlcNC24h0vxjuiQpo5N0mY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782989426; c=relaxed/simple;
	bh=TdAKQ5bkpDJ+q8vtr1fnXS4gPKoJw8I70LTsjzfMgM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=e/m/Zw5+s8fSipu3aDuVlGMU2WhlrY1T9fEIdM/6GSRn5OeBD96bOT3mHoMvjTDmuK3Uxux7IBdav7hIE4/LSVwZi7neHiFQlK5iQ94N/Y8AUq9M43B+K9rlnlEy4tNLzdmz8sSfh2vsgpCd+fZRYhADwtO1rmOgRo2zioBuY8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=G2MjV5Z3; arc=none smtp.client-ip=148.251.105.195
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1782989422;
	bh=TdAKQ5bkpDJ+q8vtr1fnXS4gPKoJw8I70LTsjzfMgM8=;
	h=From:Date:Subject:To:Cc:From;
	b=G2MjV5Z3MMQ+EENa0wQ8ycXV9qtAp0jrp07oJUCKnuXC1BioqUk07NwF/G0GtUsBZ
	 F6gHsiUazjA0i+DjmhhTM5UJ0yAu299lenpZ5vxykKSTuDZvaFF+PzkljuCBqi87B4
	 3f/d+hvQ5/fFUTMbqlQOrb0M7zvTOnDMouG7+hPBPzuX3rLFcdVIn1Q41xKtuvfL4P
	 dqGLTLzaK+qv3Z7eWiskJcWvnJZmti7WoO8RoKA+yPrMZpXze1Eg/q0YFGGMinJkju
	 oeQrBAWOwsd3KhOXq5AFpP8wY0ih2f2ig6vLE8L6IcOhxYrNHXJmvTsPV+PO7/x8VM
	 o+gxM4EvwKQNw==
Received: from [192.168.1.156] (unknown [100.64.1.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mattl)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CEAFD17E0CA2;
	Thu,  2 Jul 2026 12:50:21 +0200 (CEST)
From: Matthew Leach <matthew.leach@collabora.com>
Date: Thu, 02 Jul 2026 11:50:16 +0100
Subject: [PATCH v2] wifi: ath12k: fix survey indexing across bands
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-ath12-survey-band-fix-v2-1-75b5bdf72a08@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6CMBREr0L+2m9opRRYeQ/Doi1fqUFqWmgkh
 Ltb8AAu32Rm3gqBvKUATbaCp2iDdWMCfsrA9Gp8ENouMfCcl3nJJKqpZxzD7CMtqNXY4d1+sNC
 CZCVkfZE1pO3bU4qP31v74zDrJ5lpP9sbvQ2T88shjmzv/XNEhgxJdrUQQutCVlfjhkFp59XZu
 Be027Z9AbFo5NzQAAAA
X-Change-ID: 20260617-ath12-survey-band-fix-4b5e78579379
To: Jeff Johnson <jjohnson@kernel.org>, 
 Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>, 
 Baochen Qiang <quic_bqiang@quicinc.com>, 
 Ramya Gnanasekar <quic_rgnanase@quicinc.com>, 
 Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>, 
 Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>, 
 P Praneesh <quic_ppranees@quicinc.com>, 
 Sriram R <quic_srirrama@quicinc.com>, linux-wireless@vger.kernel.org, 
 ath12k@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, 
 Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>, 
 Matthew Leach <matthew.leach@collabora.com>, 
 Rameshkumar Sundaram <quic_ramess@quicinc.com>, 
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38504-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:quic_vthiagar@quicinc.com,m:quic_bqiang@quicinc.com,m:quic_rgnanase@quicinc.com,m:quic_periyasa@quicinc.com,m:kvalo@kernel.org,m:quic_pradeepc@quicinc.com,m:quic_ppranees@quicinc.com,m:quic_srirrama@quicinc.com,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:kernel@collabora.com,m:rameshkumar.sundaram@oss.qualcomm.com,m:matthew.leach@collabora.com,m:quic_ramess@quicinc.com,m:jeff.johnson@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[matthew.leach@collabora.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.leach@collabora.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:email,qualcomm.com:email,collabora.com:dkim,collabora.com:email,collabora.com:mid,collabora.com:from_mime,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7622C6F6655

When running 'iw dev wlan0 survey dump' the values for the channel busy
time have the same sequence across bands. This is caused by indexing
into the ath12k survey array using a band-local index rather than the
global index passed by mac80211. This results in surveys for 5 GHz and 6
GHz channels returning values from 2.4 GHz slots, making the survey
unusable on those bands. Further, there are redundant survey slots for
multi-radio/single-phy instances.

Fix by moving the survey data into ath12k_hw so multiple radios under a
single wiphy share one table, and index into it using the global
mac80211 index. A new spinlock in ath12k_hw serialises access to the
survey array, which is now shared across all radios under a single hw.

Band busy-times Before this fix:

2.4 GHz: 9, 2, 2, 2, 4, 2, 10, 16, 4, 12, 5
5 GHz:   9, 2, 2, 2, 4, 2, 10, 16, 4, 12, 5
6 GHz:   9, 2, 2, 2, 4, 2, 10, 16, 4, 12, 5

After this fix, times are independent:

2.4 GHz: 23, 5,  5,  12, 2,   12,  26,  5,   3,  1,  27
5 GHz:   30, 40, 29, 27, 118, 118, 112, 120, 11, 11, 11
6 GHz:   1,  0,  0,  0,  0,   0,   0,   0,   0,  0,  1

Tested-on: wcn7850 hw2.0 PCI WLAN.IOE_HMT.1.1-00018-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1

Fixes: 4f242b1d6996 ("wifi: ath12k: support get_survey mac op for single wiphy")
Signed-off-by: Matthew Leach <matthew.leach@collabora.com>
---
Changes in v2:
- Move survey[] from ath12k to ath12k_hw so multi-radio single-wiphy
  setups share one global table (suggested by Rameshkumar Sundaram).
- Drop the ar->mac.sbands[] filter in freq_to_idx() so the WMI event
  handlers use the same global index
- Add ah->survey_lock to serialise access to the shared survey table
- Update Fixes: tag to the correct commit
- Link to v1: https://patch.msgid.link/20260617-ath12-survey-band-fix-v1-1-e7d9555bb478@collabora.com

To: Jeff Johnson <jjohnson@kernel.org>
To: Sriram R <quic_srirrama@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
Cc: ath12k@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/net/wireless/ath/ath12k/core.h |  6 ++++-
 drivers/net/wireless/ath/ath12k/mac.c  | 33 ++++++++++++++-------------
 drivers/net/wireless/ath/ath12k/wmi.c  | 41 ++++++++++++++++++----------------
 3 files changed, 45 insertions(+), 35 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 8be435535a4e..6ce2f7b3fa50 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -712,7 +712,6 @@ struct ath12k {
 	 * avoid reporting garbage data.
 	 */
 	bool ch_info_can_report_survey;
-	struct survey_info survey[ATH12K_NUM_CHANS];
 	struct completion bss_survey_done;
 
 	struct work_struct regd_update_work;
@@ -774,6 +773,11 @@ struct ath12k_hw {
 	 */
 	struct mutex hw_mutex;
 	enum ath12k_hw_state state;
+
+	/* protects survey[] shared across radios of this hw. */
+	spinlock_t survey_lock;
+	struct survey_info survey[ATH12K_NUM_CHANS];
+
 	bool regd_updated;
 	bool use_6ghz_regd;
 
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 2cff9485c95a..daf9bc8722df 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -13348,52 +13348,54 @@ ath12k_mac_update_bss_chan_survey(struct ath12k *ar,
 int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
 			     struct survey_info *survey)
 {
+	struct ath12k_hw *ah = hw->priv;
 	struct ath12k *ar;
 	struct ieee80211_supported_band *sband;
-	struct survey_info *ar_survey;
+	struct survey_info *ah_survey;
+	int sband_idx = idx;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
-	if (idx >= ATH12K_NUM_CHANS)
+	if (sband_idx >= ATH12K_NUM_CHANS)
 		return -ENOENT;
 
 	sband = hw->wiphy->bands[NL80211_BAND_2GHZ];
-	if (sband && idx >= sband->n_channels) {
-		idx -= sband->n_channels;
+	if (sband && sband_idx >= sband->n_channels) {
+		sband_idx -= sband->n_channels;
 		sband = NULL;
 	}
 
 	if (!sband)
 		sband = hw->wiphy->bands[NL80211_BAND_5GHZ];
-	if (sband && idx >= sband->n_channels) {
-		idx -= sband->n_channels;
+	if (sband && sband_idx >= sband->n_channels) {
+		sband_idx -= sband->n_channels;
 		sband = NULL;
 	}
 
 	if (!sband)
 		sband = hw->wiphy->bands[NL80211_BAND_6GHZ];
 
-	if (!sband || idx >= sband->n_channels)
+	if (!sband || sband_idx >= sband->n_channels)
 		return -ENOENT;
 
-	ar = ath12k_mac_get_ar_by_chan(hw, &sband->channels[idx]);
+	ar = ath12k_mac_get_ar_by_chan(hw, &sband->channels[sband_idx]);
 	if (!ar) {
-		if (sband->channels[idx].flags & IEEE80211_CHAN_DISABLED) {
+		if (sband->channels[sband_idx].flags & IEEE80211_CHAN_DISABLED) {
 			memset(survey, 0, sizeof(*survey));
 			return 0;
 		}
 		return -ENOENT;
 	}
 
-	ar_survey = &ar->survey[idx];
+	ah_survey = &ah->survey[idx];
 
-	ath12k_mac_update_bss_chan_survey(ar, &sband->channels[idx]);
+	ath12k_mac_update_bss_chan_survey(ar, &sband->channels[sband_idx]);
 
-	spin_lock_bh(&ar->data_lock);
-	memcpy(survey, ar_survey, sizeof(*survey));
-	spin_unlock_bh(&ar->data_lock);
+	scoped_guard(spinlock_bh, &ah->survey_lock) {
+		memcpy(survey, ah_survey, sizeof(*survey));
+	}
 
-	survey->channel = &sband->channels[idx];
+	survey->channel = &sband->channels[sband_idx];
 
 	if (ar->rx_channel == survey->channel)
 		survey->filled |= SURVEY_INFO_IN_USE;
@@ -15055,6 +15057,7 @@ static struct ath12k_hw *ath12k_mac_hw_allocate(struct ath12k_hw_group *ag,
 
 	mutex_init(&ah->hw_mutex);
 
+	spin_lock_init(&ah->survey_lock);
 	spin_lock_init(&ah->dp_hw.peer_lock);
 	INIT_LIST_HEAD(&ah->dp_hw.dp_peers_list);
 
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index b5e904a55aea..aa70d2a61d38 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6617,16 +6617,12 @@ static int ath12k_pull_roam_ev(struct ath12k_base *ab, struct sk_buff *skb,
 	return 0;
 }
 
-static int freq_to_idx(struct ath12k *ar, int freq)
+static int freq_to_idx(struct ieee80211_hw *hw, int freq)
 {
 	struct ieee80211_supported_band *sband;
-	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
 	int band, ch, idx = 0;
 
 	for (band = NL80211_BAND_2GHZ; band < NUM_NL80211_BANDS; band++) {
-		if (!ar->mac.sbands[band].channels)
-			continue;
-
 		sband = hw->wiphy->bands[band];
 		if (!sband)
 			continue;
@@ -7507,6 +7503,7 @@ static void ath12k_chan_info_event(struct ath12k_base *ab, struct sk_buff *skb)
 {
 	struct wmi_chan_info_event ch_info_ev = {};
 	struct ath12k *ar;
+	struct ath12k_hw *ah;
 	struct survey_info *survey;
 	int idx;
 	/* HW channel counters frequency value in hertz */
@@ -7538,6 +7535,7 @@ static void ath12k_chan_info_event(struct ath12k_base *ab, struct sk_buff *skb)
 		return;
 	}
 	spin_lock_bh(&ar->data_lock);
+	ah = ath12k_ar_to_ah(ar);
 
 	switch (ar->scan.state) {
 	case ATH12K_SCAN_IDLE:
@@ -7549,8 +7547,8 @@ static void ath12k_chan_info_event(struct ath12k_base *ab, struct sk_buff *skb)
 		break;
 	}
 
-	idx = freq_to_idx(ar, le32_to_cpu(ch_info_ev.freq));
-	if (idx >= ARRAY_SIZE(ar->survey)) {
+	idx = freq_to_idx(ath12k_ar_to_hw(ar), le32_to_cpu(ch_info_ev.freq));
+	if (idx >= ARRAY_SIZE(ah->survey)) {
 		ath12k_warn(ab, "chan info: invalid frequency %d (idx %d out of bounds)\n",
 			    ch_info_ev.freq, idx);
 		goto exit;
@@ -7563,14 +7561,16 @@ static void ath12k_chan_info_event(struct ath12k_base *ab, struct sk_buff *skb)
 		cc_freq_hz = (le32_to_cpu(ch_info_ev.mac_clk_mhz) * 1000);
 
 	if (ch_info_ev.cmd_flags == WMI_CHAN_INFO_START_RESP) {
-		survey = &ar->survey[idx];
-		memset(survey, 0, sizeof(*survey));
-		survey->noise = le32_to_cpu(ch_info_ev.noise_floor);
-		survey->filled = SURVEY_INFO_NOISE_DBM | SURVEY_INFO_TIME |
+		scoped_guard(spinlock_bh, &ah->survey_lock) {
+			survey = &ah->survey[idx];
+			memset(survey, 0, sizeof(*survey));
+			survey->noise = le32_to_cpu(ch_info_ev.noise_floor);
+			survey->filled = SURVEY_INFO_NOISE_DBM | SURVEY_INFO_TIME |
 				 SURVEY_INFO_TIME_BUSY;
-		survey->time = div_u64(le32_to_cpu(ch_info_ev.cycle_count), cc_freq_hz);
-		survey->time_busy = div_u64(le32_to_cpu(ch_info_ev.rx_clear_count),
-					    cc_freq_hz);
+			survey->time = div_u64(le32_to_cpu(ch_info_ev.cycle_count), cc_freq_hz);
+			survey->time_busy = div_u64(le32_to_cpu(ch_info_ev.rx_clear_count),
+						    cc_freq_hz);
+		}
 	}
 exit:
 	spin_unlock_bh(&ar->data_lock);
@@ -7583,6 +7583,7 @@ ath12k_pdev_bss_chan_info_event(struct ath12k_base *ab, struct sk_buff *skb)
 	struct wmi_pdev_bss_chan_info_event bss_ch_info_ev = {};
 	struct survey_info *survey;
 	struct ath12k *ar;
+	struct ath12k_hw *ah;
 	u32 cc_freq_hz = ab->cc_freq_hz;
 	u64 busy, total, tx, rx, rx_bss;
 	int idx;
@@ -7623,15 +7624,18 @@ ath12k_pdev_bss_chan_info_event(struct ath12k_base *ab, struct sk_buff *skb)
 		return;
 	}
 
-	spin_lock_bh(&ar->data_lock);
-	idx = freq_to_idx(ar, le32_to_cpu(bss_ch_info_ev.freq));
-	if (idx >= ARRAY_SIZE(ar->survey)) {
+	ah = ath12k_ar_to_ah(ar);
+
+	guard(spinlock_bh)(&ah->survey_lock);
+
+	idx = freq_to_idx(ath12k_ar_to_hw(ar), le32_to_cpu(bss_ch_info_ev.freq));
+	if (idx >= ARRAY_SIZE(ah->survey)) {
 		ath12k_warn(ab, "bss chan info: invalid frequency %d (idx %d out of bounds)\n",
 			    bss_ch_info_ev.freq, idx);
 		goto exit;
 	}
 
-	survey = &ar->survey[idx];
+	survey = &ah->survey[idx];
 
 	survey->noise     = le32_to_cpu(bss_ch_info_ev.noise_floor);
 	survey->time      = div_u64(total, cc_freq_hz);
@@ -7644,7 +7648,6 @@ ath12k_pdev_bss_chan_info_event(struct ath12k_base *ab, struct sk_buff *skb)
 			     SURVEY_INFO_TIME_RX |
 			     SURVEY_INFO_TIME_TX);
 exit:
-	spin_unlock_bh(&ar->data_lock);
 	complete(&ar->bss_survey_done);
 
 	rcu_read_unlock();

---
base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
change-id: 20260617-ath12-survey-band-fix-4b5e78579379

Best regards,
--  
Matt


