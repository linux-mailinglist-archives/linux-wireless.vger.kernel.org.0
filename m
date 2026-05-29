Return-Path: <linux-wireless+bounces-37120-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HLkMJpOGWr2uggAu9opvQ
	(envelope-from <linux-wireless+bounces-37120-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 10:30:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1800A5FF303
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 10:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95ED531A7306
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 08:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E792DEA89;
	Fri, 29 May 2026 08:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="YyIkMMRh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C37B371CEA
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 08:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043224; cv=none; b=WPVpZqMO86AnJFdrea+cd2potVRz6ZdG/VCNkQ2nLTdYg1R3XRvG9v2kysI4bTLPipW2TQMVM9QKir3u1Uk1GsJ+EZGTojEKE0yLMW4hnLfgh/KKdytVa4FK7+A8xFH7VvPqpwWhfCMxUF7mXOSq3tL8Yb9nZywkBi5aD9pLJ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043224; c=relaxed/simple;
	bh=hoGrIWpnLEVohK7nPOvW95mnSD/gES8Jp5e8CRQ6mgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dv3htxTTWLV17u0Dk3Cy+ADZ5W0DOADVifj7aOZqVpDNs6pMYNlWjzV5+Wo21D8udhB/4DqXzpOuX021TDFST5Uhqgh9b16oCL3pp53efcBYQwPB0NDdAQkIBK8Lra4d+Ofuvy5Gs0qWXmB6XNxEzz4qZydmRN6m0NHLkowMeoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=YyIkMMRh; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=aZewBZmuxfUK4jm+i5DrEKcDl6NzL0xPruzsfdeeDc8=;
	t=1780043221; x=1781252821; b=YyIkMMRhrJ0rXDPFUFAS9YDHZ5sbFW35t4ErrzOjnw6hM9w
	afUCamsfyfdwKjyuHJ4a86fSASxMtEN1IiUlnjk+K4Y9zV5SF4IcHuTyLRhBMezCXvfTR7N6xPJA7
	oBIv1ZuzwZJopdh+9QL3W5exjld0HCFmgWaOh/fWKqJvmq/K1csQanrAHTQysEN8zhGZxsmmpsvDl
	AjRqCiA44WRdmKiFuBIUeApxtV12u/nmvXg2OLPr3U2dWiQ3f0K1NhtlOtqqVHukytZPp7uhHbX0t
	D3ch2xJr6uYUHjqlGdi+T8ApIqN255OjMymiKH+PclRaMZyPChN/Kr9xoCLHrM+g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wSsYV-00000009bVp-1dlt;
	Fri, 29 May 2026 10:26:59 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 14/16] wifi: mac80211: parse and apply UHR DBE channel
Date: Fri, 29 May 2026 10:25:07 +0200
Message-ID: <20260529102644.cb810f212128.Ife37c2673251346e84e4250b242b31f0895520ab@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529082644.106145-18-johannes@sipsolutions.net>
References: <20260529082644.106145-18-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37120-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sipsolutions.net:dkim,intel.com:email,status_work.work:url]
X-Rspamd-Queue-Id: 1800A5FF303
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

When a UHR AP has DBE enabled, parse the channel and apply it
to the chandef. Apply for TX only after the OMP response (or
timeout) so that the AP doesn't receive frames with DBE width
before the station completed transition to DBE.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211-eht.h  |  18 +-
 include/linux/ieee80211-uhr.h  |  92 +++++++
 net/mac80211/ieee80211_i.h     |  15 +-
 net/mac80211/mlme.c            | 449 ++++++++++++++++++++++++++++++++-
 net/mac80211/rx.c              |  14 +
 net/mac80211/sta_info.c        |  16 ++
 net/mac80211/sta_info.h        |   4 +
 net/mac80211/status.c          |  25 ++
 net/mac80211/tests/chan-mode.c |   4 +-
 9 files changed, 616 insertions(+), 21 deletions(-)

diff --git a/include/linux/ieee80211-eht.h b/include/linux/ieee80211-eht.h
index 87d92fb86fab..73e97fe30724 100644
--- a/include/linux/ieee80211-eht.h
+++ b/include/linux/ieee80211-eht.h
@@ -1038,13 +1038,17 @@ ieee80211_mle_basic_sta_prof_bss_param_ch_cnt(const struct ieee80211_mle_per_sta
 #define IEEE80211_MLE_STA_RECONF_CONTROL_COMPLETE_PROFILE		0x0010
 #define IEEE80211_MLE_STA_RECONF_CONTROL_STA_MAC_ADDR_PRESENT		0x0020
 #define IEEE80211_MLE_STA_RECONF_CONTROL_AP_REM_TIMER_PRESENT		0x0040
-#define	IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_TYPE                 0x0780
-#define IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_TYPE_AP_REM          0
-#define IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_TYPE_OP_PARAM_UPDATE 1
-#define IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_TYPE_ADD_LINK        2
-#define IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_TYPE_DEL_LINK        3
-#define IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_TYPE_NSTR_STATUS     4
-#define IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_PARAMS_PRESENT       0x0800
+#define IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_TYPE			0x0780
+#define IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_TYPE_AP_REM		0
+#define IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_TYPE_OP_PARAM_UPDATE	1
+#define IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_TYPE_ADD_LINK	2
+#define IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_TYPE_DEL_LINK	3
+#define IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_TYPE_NSTR_STATUS	4
+#define IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_TYPE_UHR_OMP_UPD	5
+#define IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_PARAMS_PRESENT	0x0800
+#define IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_NSTR_BMAP_SIZE	0x1000
+#define IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_NSTR_IND_BMAP_PRES	0x2000
+#define IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_DSO_INFO_PRESENT	0x4000
 
 /**
  * ieee80211_mle_reconf_sta_prof_size_ok - validate reconfiguration multi-link
diff --git a/include/linux/ieee80211-uhr.h b/include/linux/ieee80211-uhr.h
index 0c1715280fe7..f9592ffae3eb 100644
--- a/include/linux/ieee80211-uhr.h
+++ b/include/linux/ieee80211-uhr.h
@@ -10,11 +10,13 @@
 #include <linux/types.h>
 #include <linux/bitfield.h>
 #include <linux/if_ether.h>
+#include "ieee80211-eht.h"
 
 #define IEEE80211_UHR_OPER_PARAMS_DPS_ENA		0x0001
 #define IEEE80211_UHR_OPER_PARAMS_NPCA_ENA		0x0002
 #define IEEE80211_UHR_OPER_PARAMS_PEDCA_ENA		0x0004
 #define IEEE80211_UHR_OPER_PARAMS_DBE_ENA		0x0008
+#define IEEE80211_UHR_OPER_PARAMS_DBE_BW		0x0070
 
 struct ieee80211_uhr_operation {
 	__le16 params;
@@ -177,6 +179,29 @@ enum ieee80211_uhr_dbe_oper_bw {
 	IEEE80211_UHR_DBE_OPER_BW_320_2 = 5,
 };
 
+/**
+ * ieee80211_uhr_dbe_bw_mhz - get bandwidth in MHz from UHR DBE bandwidth
+ * @bw: UHR DBE bandwidth
+ *
+ * Return: the bandwidth in MHz, or -1 for invalid values
+ */
+static inline int ieee80211_uhr_dbe_bw_mhz(enum ieee80211_uhr_dbe_oper_bw bw)
+{
+	switch (bw) {
+	case IEEE80211_UHR_DBE_OPER_BW_40:
+		return 40;
+	case IEEE80211_UHR_DBE_OPER_BW_80:
+		return 80;
+	case IEEE80211_UHR_DBE_OPER_BW_160:
+		return 160;
+	case IEEE80211_UHR_DBE_OPER_BW_320_1:
+	case IEEE80211_UHR_DBE_OPER_BW_320_2:
+		return 320;
+	default:
+		return -1;
+	}
+}
+
 /**
  * struct ieee80211_uhr_dbe_info - DBE operation information
  *
@@ -335,6 +360,35 @@ ieee80211_uhr_npca_dis_subch_bitmap(const struct ieee80211_uhr_operation *oper)
 	return npca->dis_subch_bmap;
 }
 
+/*
+ * Note: cannot call this on the element coming from a beacon,
+ * must ensure ieee80211_uhr_oper_size_ok(..., false) first
+ */
+static inline const struct ieee80211_uhr_dbe_info *
+ieee80211_uhr_oper_dbe_info(const struct ieee80211_uhr_operation *oper)
+{
+	const u8 *pos = oper->variable;
+
+	if (!(oper->params & cpu_to_le16(IEEE80211_UHR_OPER_PARAMS_DBE_ENA)))
+		return NULL;
+
+	if (oper->params & cpu_to_le16(IEEE80211_UHR_OPER_PARAMS_DPS_ENA))
+		pos += sizeof(struct ieee80211_uhr_dps_info);
+
+	if (oper->params & cpu_to_le16(IEEE80211_UHR_OPER_PARAMS_NPCA_ENA)) {
+		const struct ieee80211_uhr_npca_info *npca = (const void *)pos;
+
+		pos += sizeof(*npca);
+		if (npca->params & cpu_to_le32(IEEE80211_UHR_NPCA_PARAMS_DIS_SUBCH_BMAP_PRES))
+			pos += sizeof(npca->dis_subch_bmap[0]);
+	}
+
+	if (oper->params & cpu_to_le16(IEEE80211_UHR_OPER_PARAMS_PEDCA_ENA))
+		pos += sizeof(struct ieee80211_uhr_p_edca_info);
+
+	return (const void *)pos;
+}
+
 #define IEEE80211_UHR_MAC_CAP0_DPS_SUPP			0x01
 #define IEEE80211_UHR_MAC_CAP0_DPS_ASSIST_SUPP		0x02
 #define IEEE80211_UHR_MAC_CAP0_DPS_AP_STATIC_HCM_SUPP	0x04
@@ -475,6 +529,44 @@ static inline bool ieee80211_uhr_capa_size_ok(const u8 *data, u8 len,
 	return len >= needed;
 }
 
+#define IEEE80211_UHR_OM_PU_TO_128TU	11
+
+/**
+ * ieee80211_uhr_capa_get_om_pu_to_us - get OM parameter update timeout in usec
+ * @cap: the UHR capability element, size must be validated
+ *
+ * Return: the OM parameter update timeout in usec, or -1 if it's not valid
+ */
+static inline int
+ieee80211_uhr_capa_get_om_pu_to_us(const struct ieee80211_uhr_cap *cap)
+{
+	u8 timeout;
+
+	timeout = u8_get_bits(cap->mac.mac_cap[3],
+			      IEEE80211_UHR_MAC_CAP3_UHR_OM_PU_TO_HIGH);
+	timeout <<= 2;
+	timeout |= u8_get_bits(cap->mac.mac_cap[2],
+			       IEEE80211_UHR_MAC_CAP2_UHR_OM_PU_TO_LOW);
+
+	if (timeout > IEEE80211_UHR_OM_PU_TO_128TU)
+		return -1;
+
+	if (!timeout)
+		return 0;
+
+	return 128 << (timeout - 1);
+}
+
+/* only valid from AP, must check ieee80211_uhr_capa_size_ok(..., true) */
+static inline const struct ieee80211_uhr_cap_dbe *
+ieee80211_uhr_dbe_cap(const struct ieee80211_uhr_cap *cap)
+{
+	if (!(cap->mac.mac_cap[1] & IEEE80211_UHR_MAC_CAP1_DBE_SUPP))
+		return NULL;
+
+	return (const void *)cap->variable;
+}
+
 #define IEEE80211_SMD_INFO_CAPA_DL_DATA_FWD		0x01
 #define IEEE80211_SMD_INFO_CAPA_MAX_NUM_PREP		0x0E
 #define IEEE80211_SMD_INFO_CAPA_TYPE			0x10
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 339faa7a0a0e..29bdfd2a39bd 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -99,6 +99,7 @@ enum ieee80211_status_data {
 	IEEE80211_STATUS_TYPE_INVALID	= 0,
 	IEEE80211_STATUS_TYPE_SMPS	= 1,
 	IEEE80211_STATUS_TYPE_NEG_TTLM	= 2,
+	IEEE80211_STATUS_TYPE_UHR_OMP	= 3,
 	IEEE80211_STATUS_SUBDATA_MASK	= 0x1ff0,
 };
 
@@ -412,6 +413,7 @@ enum ieee80211_conn_bw_limit {
 struct ieee80211_conn_settings {
 	enum ieee80211_conn_mode mode;
 	enum ieee80211_conn_bw_limit bw_limit;
+	bool dbe_enabled;
 };
 
 extern const struct ieee80211_conn_settings ieee80211_conn_settings_unlimited;
@@ -639,6 +641,15 @@ struct ieee80211_if_managed {
 		bool enabled;
 		u8 dialog_token;
 	} epcs;
+
+	struct {
+		struct wiphy_hrtimer_work status_work;
+		u32 timeout_us;
+		u16 links;
+		u16 pending, pending_init;
+		u8 dialog_token;
+		bool acked;
+	} uhr_omp;
 };
 
 struct ieee80211_if_ibss {
@@ -2790,6 +2801,7 @@ ieee80211_chanreq_downgrade(struct ieee80211_chan_req *chanreq,
 		return;
 	if (conn->mode < IEEE80211_CONN_MODE_EHT)
 		chanreq->ap.chan = NULL;
+	conn->dbe_enabled = false;
 }
 
 bool ieee80211_chanreq_identical(const struct ieee80211_chan_req *a,
@@ -2980,7 +2992,8 @@ void ieee80211_rearrange_tpe_psd(struct ieee80211_parsed_tpe_psd *psd,
 struct ieee802_11_elems *
 ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 			      struct ieee80211_conn_settings *conn,
-			      struct cfg80211_bss *cbss, int link_id,
+			      struct cfg80211_bss *cbss,
+			      struct link_sta_info *link_sta, int link_id,
 			      struct ieee80211_chan_req *chanreq,
 			      struct cfg80211_chan_def *ap_chandef,
 			      unsigned long *userspace_selectors);
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 2b0be473c82c..655d782bd078 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -171,14 +171,24 @@ struct ieee80211_determine_ap_chan_data {
 	const struct ieee80211_conn_settings *conn;
 	u32 vht_cap_info;
 	bool ignore_ht_channel_mismatch;
+	const struct cfg80211_chan_def *cur_chandef;
+	bool cur_dbe_used;
 
 	/* target chandef is filled in */
 	struct cfg80211_chan_def *chandef;
 };
 
+struct ieee80211_determine_ap_chan_output {
+	/* filled to indicate UHR DBE was used */
+	bool dbe_used;
+	/* and need to know non-DBE width */
+	enum nl80211_chan_width non_dbe_width;
+};
+
 static enum ieee80211_conn_mode
 ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
-			    struct ieee80211_determine_ap_chan_data *data)
+			    const struct ieee80211_determine_ap_chan_data *data,
+			    struct ieee80211_determine_ap_chan_output *out)
 {
 	bool ignore_ht_channel_mismatch = data->ignore_ht_channel_mismatch;
 	const struct ieee802_11_elems *elems = data->elems;
@@ -196,6 +206,8 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
 	bool no_vht = false;
 	u32 ht_cfreq;
 
+	memset(out, 0, sizeof(*out));
+
 	if (ieee80211_hw_check(&sdata->local->hw, STRICT))
 		ignore_ht_channel_mismatch = false;
 
@@ -396,6 +408,8 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
 		struct cfg80211_chan_def npca_chandef = *chandef;
 		const struct ieee80211_sta_uhr_cap *uhr_cap;
 		const struct ieee80211_uhr_npca_info *npca;
+		const struct ieee80211_uhr_dbe_info *dbe;
+		struct cfg80211_chan_def dbe_chandef;
 
 		/* frames other than beacons carry UHR capability too */
 		if (!elems->uhr_cap)
@@ -427,6 +441,96 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
 
 		if (uhr_cap->mac.mac_cap[0] & IEEE80211_UHR_MAC_CAP0_NPCA_SUPP)
 			*chandef = npca_chandef;
+
+		dbe = ieee80211_uhr_oper_dbe_info(uhr_oper);
+		if (dbe) {
+			const struct ieee80211_uhr_cap_dbe *dbe_cap;
+			u8 dbe_bw_oper;
+			u8 dbe_bw_cap;
+
+			dbe_cap = ieee80211_uhr_dbe_cap(elems->uhr_cap);
+
+			if (!dbe_cap) {
+				sdata_info(sdata,
+					   "AP without UHR DBE capability uses it, disabling UHR\n");
+				return IEEE80211_CONN_MODE_EHT;
+			}
+
+			dbe_bw_oper = u8_get_bits(dbe->params,
+						  IEEE80211_UHR_DBE_OPER_BANDWIDTH);
+
+			if (le16_get_bits(uhr_oper->params,
+					  IEEE80211_UHR_OPER_PARAMS_DBE_BW) != dbe_bw_oper) {
+				sdata_info(sdata,
+					   "AP UHR DBE settings mismatch, disabling UHR\n");
+				return IEEE80211_CONN_MODE_EHT;
+			}
+
+			if (ieee80211_uhr_dbe_bw_mhz(dbe_bw_oper) < 0) {
+				sdata_info(sdata,
+					   "AP UHR DBE bandwidth invalid, disabling UHR\n");
+				return IEEE80211_CONN_MODE_EHT;
+			}
+
+			dbe_bw_cap = u8_get_bits(dbe_cap->cap,
+						 IEEE80211_UHR_MAC_CAP_DBE_MAX_BW);
+
+			switch (dbe_bw_cap) {
+			case IEEE80211_UHR_DBE_MAX_BW_40:
+			case IEEE80211_UHR_DBE_MAX_BW_80:
+			case IEEE80211_UHR_DBE_MAX_BW_160:
+			case IEEE80211_UHR_DBE_MAX_BW_320:
+				break;
+			default:
+				sdata_info(sdata,
+					   "AP UHR DBE capability invalid, disabling UHR\n");
+				return IEEE80211_CONN_MODE_EHT;
+			}
+
+			/* 1-4 are same in DBE capabilities, map 320-2 to 320 */
+			if (dbe_bw_oper == IEEE80211_UHR_DBE_OPER_BW_320_2)
+				dbe_bw_oper = IEEE80211_UHR_DBE_MAX_BW_320;
+			if (dbe_bw_oper > dbe_bw_cap) {
+				sdata_info(sdata,
+					   "AP UHR DBE wider than capability, disabling UHR\n");
+				return IEEE80211_CONN_MODE_EHT;
+			}
+		}
+
+		dbe_chandef = *chandef;
+
+		if (cfg80211_chandef_add_dbe(&dbe_chandef, dbe)) {
+			sdata_info(sdata,
+				   "AP UHR DBE settings invalid, disabling UHR\n");
+			return IEEE80211_CONN_MODE_EHT;
+		}
+
+		if (dbe &&
+		    /* maybe driver would like to never use DBE */
+		    uhr_cap->mac.mac_cap[1] & IEEE80211_UHR_MAC_CAP1_DBE_SUPP &&
+		    ieee80211_chandef_usable(sdata, &dbe_chandef,
+					     IEEE80211_CHAN_DISABLED)) {
+			out->non_dbe_width = chandef->width;
+			*chandef = dbe_chandef;
+			out->dbe_used = true;
+		}
+	} else if (data->cur_chandef && data->cur_dbe_used &&
+		   cfg80211_chandef_compatible(chandef, data->cur_chandef)) {
+		u8 dbe_bw = le16_get_bits(uhr_oper->params,
+					  IEEE80211_UHR_OPER_PARAMS_DBE_BW);
+		int dbe_bw_mhz;
+
+		dbe_bw_mhz = ieee80211_uhr_dbe_bw_mhz(dbe_bw);
+		if (dbe_bw_mhz < 0) {
+			sdata_info(sdata,
+				   "AP UHR DBE bandwidth invalid, drop UHR\n");
+			return IEEE80211_CONN_MODE_EHT;
+		}
+
+		if (cfg80211_chandef_get_width(data->cur_chandef) == dbe_bw_mhz) {
+			*chandef = *data->cur_chandef;
+			out->dbe_used = true;
+		}
 	}
 
 	return IEEE80211_CONN_MODE_UHR;
@@ -1069,7 +1173,8 @@ static void ieee80211_set_chanreq_ap(struct ieee80211_sub_if_data *sdata,
 VISIBLE_IF_MAC80211_KUNIT struct ieee802_11_elems *
 ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 			      struct ieee80211_conn_settings *conn,
-			      struct cfg80211_bss *cbss, int link_id,
+			      struct cfg80211_bss *cbss,
+			      struct link_sta_info *link_sta, int link_id,
 			      struct ieee80211_chan_req *chanreq,
 			      struct cfg80211_chan_def *ap_chandef,
 			      unsigned long *userspace_selectors)
@@ -1099,6 +1204,7 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 	enum ieee80211_conn_mode ap_mode;
 	unsigned long unknown_rates_selectors[BITS_TO_LONGS(128)] = {};
 	unsigned long sta_selectors[BITS_TO_LONGS(128)] = {};
+	struct ieee80211_determine_ap_chan_output ap_chan_out;
 	struct ieee80211_determine_ap_chan_data ap_chan_data = {
 		.channel = channel,
 		.vht_cap_info = bss->vht_cap_info,
@@ -1115,7 +1221,9 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 		return ERR_PTR(-ENOMEM);
 
 	ap_chan_data.elems = elems;
-	ap_mode = ieee80211_determine_ap_chan(sdata, &ap_chan_data);
+	ap_mode = ieee80211_determine_ap_chan(sdata, &ap_chan_data,
+					      &ap_chan_out);
+	conn->dbe_enabled = ap_chan_out.dbe_used;
 
 	/* this should be impossible since parsing depends on our mode */
 	if (WARN_ON(ap_mode > conn->mode)) {
@@ -1331,6 +1439,10 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 		goto free;
 	}
 
+	if (conn->dbe_enabled && link_sta)
+		link_sta->uhr_usable_tx_width =
+			ieee80211_chan_width_to_rx_bw(ap_chan_out.non_dbe_width);
+
 	return elems;
 free:
 	kfree(elems);
@@ -1338,12 +1450,152 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 }
 EXPORT_SYMBOL_IF_MAC80211_KUNIT(ieee80211_determine_chan_mode);
 
+static void ieee80211_send_uhr_omp_req_dbe(struct ieee80211_sub_if_data *sdata,
+					   u16 link_mask, bool initial)
+{
+	struct ieee80211_mle_basic_common_info *common;
+	struct ieee80211_mle_per_sta_profile *per_sta;
+	struct ieee80211_uhr_mode_change_tuple *tuple;
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_multi_link_elem *mle;
+	struct ieee80211_link_data *link;
+	struct ieee80211_tx_info *info;
+	struct ieee80211_mgmt *mgmt;
+	struct sk_buff *skb;
+	u8 *ml_elem_len;
+	size_t size;
+
+	if (initial) {
+		bool enabled = false;
+
+		for_each_link_data(sdata, link) {
+			if (!(link_mask & BIT(link->link_id)))
+				continue;
+			if (link->u.mgd.conn.dbe_enabled) {
+				enabled = true;
+				break;
+			}
+		}
+
+		if (!enabled)
+			return;
+	}
+
+	if (sdata->u.mgd.uhr_omp.links) {
+		if (initial)
+			sdata->u.mgd.uhr_omp.pending_init |= link_mask;
+		else
+			sdata->u.mgd.uhr_omp.pending |= link_mask;
+		return;
+	}
+
+	size = local->hw.extra_tx_headroom +
+	       IEEE80211_MIN_ACTION_SIZE(uhr_link_reconf_req) +
+	       3 + sizeof(*mle) + sizeof(*common) +
+	       IEEE80211_MLD_MAX_NUM_LINKS *
+		(2 + sizeof(*per_sta) +
+		 3 + sizeof(*tuple) /* single tuple for each link */);
+
+	skb = alloc_skb(size, GFP_KERNEL);
+	if (!skb)
+		return;
+
+	skb_reserve(skb, local->hw.extra_tx_headroom);
+
+	mgmt = skb_put_zero(skb, IEEE80211_MIN_ACTION_SIZE(uhr_link_reconf_req));
+	mgmt->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
+					  IEEE80211_STYPE_ACTION);
+	memcpy(mgmt->da, sdata->vif.cfg.ap_addr, ETH_ALEN);
+	memcpy(mgmt->sa, sdata->vif.addr, ETH_ALEN);
+	memcpy(mgmt->bssid, sdata->vif.cfg.ap_addr, ETH_ALEN);
+
+	mgmt->u.action.category = WLAN_CATEGORY_PROTECTED_UHR;
+	mgmt->u.action.action_code =
+		IEEE80211_PROTECTED_UHR_ACTION_LINK_RECONFIG_REQUEST;
+
+	sdata->u.mgd.dialog_token_alloc++;
+	/*
+	 * NOTE:
+	 * Driver and FW might both send these frames, and iwlwifi
+	 * decided that the driver uses odd numbers, FW uses even
+	 * numbers. For now, hardcode that here, until it matters
+	 * to some other driver.
+	 *
+	 * Note also that there's currently no real synchronisation
+	 * in this case, but it's not valid that both send such a
+	 * frame at the same time, i.e. while waiting for a response
+	 * there can't be another frame sent. This needs addressing
+	 * in the future.
+	 */
+	if (sdata->u.mgd.dialog_token_alloc % 2 == 0)
+		sdata->u.mgd.dialog_token_alloc++;
+
+	sdata->u.mgd.uhr_omp.dialog_token = sdata->u.mgd.dialog_token_alloc;
+	mgmt->u.action.uhr_link_reconf_req.dialog_token =
+		sdata->u.mgd.uhr_omp.dialog_token;
+	mgmt->u.action.uhr_link_reconf_req.type =
+		IEEE80211_UHR_LINK_RECONFIG_REQUEST_OMP_REQUEST;
+
+	skb_put_u8(skb, WLAN_EID_EXTENSION);
+	ml_elem_len = skb_put(skb, 1);
+	skb_put_u8(skb, WLAN_EID_EXT_EHT_MULTI_LINK);
+	mle = skb_put_zero(skb, sizeof(*mle));
+	mle->control = cpu_to_le16(IEEE80211_ML_CONTROL_TYPE_RECONF |
+				   IEEE80211_MLC_RECONF_PRES_MLD_MAC_ADDR);
+
+	common = skb_put(skb, sizeof(*common));
+	common->len = sizeof(*common);
+	memcpy(common->mld_mac_addr, sdata->vif.addr, ETH_ALEN);
+
+	for_each_link_data(sdata, link) {
+		u8 *subelem_len;
+
+		if (!(link_mask & BIT(link->link_id)))
+			continue;
+
+		sdata->u.mgd.uhr_omp.links |= BIT(link->link_id);
+
+		skb_put_u8(skb, IEEE80211_MLE_SUBELEM_PER_STA_PROFILE);
+		subelem_len = skb_put(skb, 1);
+		per_sta = skb_put_zero(skb, sizeof(*per_sta));
+		per_sta->control =
+			le16_encode_bits(link->link_id,
+					 IEEE80211_MLE_STA_CONTROL_LINK_ID) |
+			le16_encode_bits(IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_TYPE_UHR_OMP_UPD,
+					 IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_TYPE);
+		per_sta->sta_info_len = 1; /* includes itself */
+
+		skb_put_u8(skb, WLAN_EID_EXTENSION);
+		skb_put_u8(skb, 1 + sizeof(*tuple));
+		skb_put_u8(skb, WLAN_EID_EXT_UHR_MODE_CHG);
+		tuple = skb_put_zero(skb, sizeof(*tuple));
+		tuple->control =
+			le16_encode_bits(IEEE80211_UHR_MODE_CHANGE_MODE_ID_DBE,
+					 IEEE80211_UHR_MODE_CHANGE_CONTROL_MODE_ID);
+
+		if (link->u.mgd.conn.dbe_enabled)
+			tuple->control |=
+				cpu_to_le16(IEEE80211_UHR_MODE_CHANGE_CONTROL_MODE_ENABLE);
+
+		ieee80211_fragment_element(skb, subelem_len,
+					   IEEE80211_MLE_SUBELEM_FRAGMENT);
+	}
+
+	ieee80211_fragment_element(skb, ml_elem_len, WLAN_EID_FRAGMENT);
+
+	info = IEEE80211_SKB_CB(skb);
+	info->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
+	info->status_data = IEEE80211_STATUS_TYPE_UHR_OMP;
+	ieee80211_tx_skb(sdata, skb);
+}
+
 static int ieee80211_config_bw(struct ieee80211_link_data *link,
 			       struct ieee802_11_elems *elems,
 			       bool update, u64 *changed, u16 stype)
 {
 	struct ieee80211_channel *channel = link->conf->chanreq.oper.chan;
 	struct cfg80211_chan_def ap_chandef;
+	struct ieee80211_determine_ap_chan_output ap_chan_out;
 	struct ieee80211_determine_ap_chan_data ap_chan_data = {
 		.channel = channel,
 		.vht_cap_info = 0,
@@ -1351,6 +1603,8 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 		.chandef = &ap_chandef,
 		.elems = elems,
 		.conn = &link->u.mgd.conn,
+		.cur_chandef = &link->conf->chanreq.oper,
+		.cur_dbe_used = link->u.mgd.conn.dbe_enabled,
 	};
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_chanctx_conf *chanctx_conf;
@@ -1387,7 +1641,9 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 		ap_chan_data.vht_cap_info =
 			le32_to_cpu(elems->vht_cap_elem->vht_cap_info);
 
-	ap_mode = ieee80211_determine_ap_chan(sdata, &ap_chan_data);
+	ap_mode = ieee80211_determine_ap_chan(sdata, &ap_chan_data,
+					      &ap_chan_out);
+	link->u.mgd.conn.dbe_enabled = ap_chan_out.dbe_used;
 
 	if (ap_mode != link->u.mgd.conn.mode) {
 		link_info(link,
@@ -2652,6 +2908,7 @@ static void ieee80211_csa_switch_work(struct wiphy *wiphy,
 		cfg80211_ch_switch_notify(sdata->dev, &link->csa.chanreq.oper,
 					  link->link_id);
 		link->conf->csa_active = false;
+		link->u.mgd.conn.dbe_enabled = false;
 
 		ap_sta = sta_info_get(sdata, sdata->vif.cfg.ap_addr);
 		if (WARN_ON(!ap_sta))
@@ -2662,6 +2919,12 @@ static void ieee80211_csa_switch_work(struct wiphy *wiphy,
 		if (WARN_ON(!link_sta))
 			return;
 
+		/*
+		 * If the link was somehow deactivated in the middle of enabling
+		 * DBE while waiting for a response, this could be stuck, reset.
+		 */
+		link_sta->uhr_usable_tx_width = IEEE80211_STA_RX_BW_MAX;
+
 		link_sta->pub->bandwidth =
 			ieee80211_sta_current_bw(link_sta,
 						 &link->csa.chanreq.oper,
@@ -2754,6 +3017,8 @@ static void ieee80211_chswitch_post_beacon(struct ieee80211_link_data *link)
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
+	struct link_sta_info *link_sta;
+	struct sta_info *ap_sta;
 	int ret;
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
@@ -2763,6 +3028,7 @@ static void ieee80211_chswitch_post_beacon(struct ieee80211_link_data *link)
 	ieee80211_vif_unblock_queues_csa(sdata);
 
 	link->conf->csa_active = false;
+	link->u.mgd.conn.dbe_enabled = false;
 	link->u.mgd.csa.blocked_tx = false;
 	link->u.mgd.csa.waiting_bcn = false;
 
@@ -2775,6 +3041,20 @@ static void ieee80211_chswitch_post_beacon(struct ieee80211_link_data *link)
 		return;
 	}
 
+	ap_sta = sta_info_get(sdata, sdata->vif.cfg.ap_addr);
+	if (WARN_ON(!ap_sta))
+		return;
+
+	link_sta = sdata_dereference(ap_sta->link[link->link_id], sdata);
+	if (WARN_ON(!link_sta))
+		return;
+
+	/*
+	 * If DBE was being activated and CSA happened, this could be
+	 * on a wrong value. Reset it.
+	 */
+	link_sta->uhr_usable_tx_width = IEEE80211_STA_RX_BW_MAX;
+
 	cfg80211_ch_switch_notify(sdata->dev, &link->conf->chanreq.oper,
 				  link->link_id);
 }
@@ -4479,6 +4759,9 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 
 	memset(ifmgd->userspace_selectors, 0,
 	       sizeof(ifmgd->userspace_selectors));
+
+	ifmgd->uhr_omp.pending = 0;
+	ifmgd->uhr_omp.pending_init = 0;
 }
 
 static void ieee80211_reset_ap_probe(struct ieee80211_sub_if_data *sdata)
@@ -4799,6 +5082,101 @@ static void __ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
 	ifmgd->reconnect = false;
 }
 
+static void ieee80211_uhr_omp_req_status(struct ieee80211_sub_if_data *sdata)
+{
+	bool acked = sdata->u.mgd.uhr_omp.acked;
+	u16 links = sdata->u.mgd.uhr_omp.links;
+	struct ieee80211_link_data *link;
+	struct sta_info *ap;
+
+	/* timer and queued RX could overlap */
+	if (!links)
+		return;
+
+	sdata->u.mgd.uhr_omp.links = 0;
+	sdata->u.mgd.uhr_omp.acked = false;
+
+	if (!acked) {
+		sdata_dbg(sdata, "UHR OMP frame not ACKed - disconnect\n");
+		__ieee80211_disconnect(sdata);
+		return;
+	}
+
+	ap = sta_info_get(sdata, sdata->vif.cfg.ap_addr);
+	if (!ap)
+		return;
+
+	for_each_link_data(sdata, link) {
+		struct link_sta_info *link_sta;
+
+		if (!(links & BIT(link->link_id)))
+			continue;
+
+		/* only handle transition to enabled for now */
+		if (!link->u.mgd.conn.dbe_enabled)
+			continue;
+
+		link_sta = sdata_dereference(ap->link[link->link_id], sdata);
+		if (WARN_ON(!link_sta))
+			continue;
+
+		link_sta->uhr_usable_tx_width = IEEE80211_STA_RX_BW_MAX;
+		ieee80211_link_sta_update_rc_bw(link, link_sta);
+	}
+
+	/* next round - send pending frames if needed */
+
+	if (sdata->u.mgd.uhr_omp.pending_init) {
+		links = sdata->u.mgd.uhr_omp.pending_init;
+
+		sdata->u.mgd.uhr_omp.pending_init = 0;
+		ieee80211_send_uhr_omp_req_dbe(sdata, links, true);
+		return;
+	}
+
+	if (sdata->u.mgd.uhr_omp.pending) {
+		links = sdata->u.mgd.uhr_omp.pending;
+
+		sdata->u.mgd.uhr_omp.pending = 0;
+		ieee80211_send_uhr_omp_req_dbe(sdata, links, false);
+		return;
+	}
+}
+
+static void ieee80211_uhr_omp_req_status_wk(struct wiphy *wiphy,
+					    struct wiphy_work *work)
+{
+	struct ieee80211_sub_if_data *sdata =
+		container_of(work, struct ieee80211_sub_if_data,
+			     u.mgd.uhr_omp.status_work.work);
+
+	ieee80211_uhr_omp_req_status(sdata);
+}
+
+static void ieee80211_process_uhr_omp_resp(struct ieee80211_sub_if_data *sdata,
+					   struct ieee80211_mgmt *mgmt)
+{
+	if (mgmt->u.action.uhr_link_reconf_notif.dialog_token !=
+	    sdata->u.mgd.uhr_omp.dialog_token)
+		return;
+
+	wiphy_hrtimer_work_cancel(sdata->local->hw.wiphy,
+				  &sdata->u.mgd.uhr_omp.status_work);
+	ieee80211_uhr_omp_req_status(sdata);
+}
+
+static void
+ieee80211_process_uhr_link_reconf_notif(struct ieee80211_sub_if_data *sdata,
+					struct ieee80211_mgmt *mgmt,
+					size_t len)
+{
+	switch (mgmt->u.action.uhr_link_reconf_notif.type) {
+	case IEEE80211_UHR_LINK_RECONFIG_NOTIFY_OMP_RESPONSE:
+		ieee80211_process_uhr_omp_resp(sdata, mgmt);
+		break;
+	}
+}
+
 static void ieee80211_beacon_connection_loss_work(struct wiphy *wiphy,
 						  struct wiphy_work *work)
 {
@@ -5777,12 +6155,27 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 
 	if (elems->uhr_operation && elems->uhr_cap &&
 	    link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_UHR) {
+		int omp_to_us;
+
 		ieee80211_uhr_cap_ie_to_sta_uhr_cap(sdata, sband,
 						    elems->uhr_cap,
 						    elems->uhr_cap_len,
 						    link_sta);
 
 		bss_conf->uhr_support = link_sta->pub->uhr_cap.has_uhr;
+
+		/*
+		 * This assumes that the timeout is the same across all links,
+		 * maybe we should actually validate that.
+		 */
+		omp_to_us = ieee80211_uhr_capa_get_om_pu_to_us(elems->uhr_cap);
+		if (omp_to_us < 0) {
+			ret = false;
+			link_info(link, "Invalid UHR OMP timeout\n");
+			goto out;
+		}
+
+		sdata->u.mgd.uhr_omp.timeout_us = omp_to_us;
 	} else {
 		bss_conf->uhr_support = false;
 	}
@@ -6312,6 +6705,7 @@ ieee80211_determine_our_sta_mode_assoc(struct ieee80211_sub_if_data *sdata,
 
 static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 				  struct ieee80211_link_data *link,
+				  struct link_sta_info *link_sta,
 				  int link_id,
 				  struct cfg80211_bss *cbss, bool mlo,
 				  struct ieee80211_conn_settings *conn,
@@ -6327,7 +6721,8 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	rcu_read_lock();
-	elems = ieee80211_determine_chan_mode(sdata, conn, cbss, link_id,
+	elems = ieee80211_determine_chan_mode(sdata, conn, cbss,
+					      link_sta, link_id,
 					      &chanreq, &ap_chandef,
 					      userspace_selectors);
 
@@ -6649,7 +7044,8 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		if (link_id != assoc_data->assoc_link_id) {
 			link->u.mgd.conn = assoc_data->link[link_id].conn;
 
-			err = ieee80211_prep_channel(sdata, link, link_id, cbss,
+			err = ieee80211_prep_channel(sdata, link, link_sta,
+						     link_id, cbss,
 						     true, &link->u.mgd.conn,
 						     sdata->u.mgd.userspace_selectors);
 			if (err) {
@@ -6730,6 +7126,8 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	ieee80211_sta_reset_beacon_monitor(sdata);
 	ieee80211_sta_reset_conn_monitor(sdata);
 
+	ieee80211_send_uhr_omp_req_dbe(sdata, ~0, true);
+
 	return true;
 out_err:
 	eth_zero_addr(sdata->vif.cfg.ap_addr);
@@ -9069,6 +9467,8 @@ void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata)
 				ieee80211_neg_ttlm_timeout_work);
 	wiphy_work_init(&ifmgd->teardown_ttlm_work,
 			ieee80211_teardown_ttlm_work);
+	wiphy_hrtimer_work_init(&ifmgd->uhr_omp.status_work,
+				ieee80211_uhr_omp_req_status_wk);
 
 	ifmgd->flags = 0;
 	ifmgd->powersave = sdata->wdev.ps;
@@ -9283,6 +9683,9 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (new_sta || override) {
+		struct link_sta_info *link_sta;
+		struct sta_info *ap;
+
 		/*
 		 * Only set this if we're also going to calculate the AP
 		 * settings etc., otherwise this was set before in a
@@ -9290,7 +9693,18 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 		 * if the settings were changed.
 		 */
 		link->u.mgd.conn = *conn;
-		err = ieee80211_prep_channel(sdata, link, link->link_id, cbss,
+
+		ap = new_sta ?: have_sta;
+		link_sta = sdata_dereference(ap->link[link->link_id], sdata);
+		if (!link_sta) {
+			err = -EINVAL;
+			if (new_sta)
+				sta_info_free(local, new_sta);
+			goto out_err;
+		}
+
+		err = ieee80211_prep_channel(sdata, link, link_sta,
+					     link->link_id, cbss,
 					     mlo, &link->u.mgd.conn,
 					     userspace_selectors);
 		if (err) {
@@ -10185,8 +10599,8 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 			continue;
 		if (i == assoc_data->assoc_link_id)
 			continue;
-		/* only calculate the mode, hence link == NULL */
-		err = ieee80211_prep_channel(sdata, NULL, i,
+		/* only calculate the mode, hence link/link_sta == NULL */
+		err = ieee80211_prep_channel(sdata, NULL, NULL, i,
 					     assoc_data->link[i].bss, true,
 					     &assoc_data->link[i].conn,
 					     sdata->u.mgd.userspace_selectors);
@@ -10369,6 +10783,8 @@ void ieee80211_mgd_stop(struct ieee80211_sub_if_data *sdata)
 			  &ifmgd->csa_connection_drop_work);
 	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
 				  &ifmgd->tdls_peer_del_work);
+	wiphy_hrtimer_work_cancel(sdata->local->hw.wiphy,
+				  &ifmgd->uhr_omp.status_work);
 
 	if (ifmgd->assoc_data)
 		ieee80211_destroy_assoc_data(sdata, ASSOC_TIMEOUT);
@@ -10615,7 +11031,7 @@ ieee80211_process_ml_reconf_resp(struct ieee80211_sub_if_data *sdata,
 		link->conf->dtim_period = link->u.mgd.dtim_period ?: 1;
 
 		link->u.mgd.conn = add_links_data->link[link_id].conn;
-		if (ieee80211_prep_channel(sdata, link, link_id, cbss,
+		if (ieee80211_prep_channel(sdata, link, link_sta, link_id, cbss,
 					   true, &link->u.mgd.conn,
 					   sdata->u.mgd.userspace_selectors)) {
 			link_info(link, "mlo: reconf: prep_channel failed\n");
@@ -10660,6 +11076,8 @@ ieee80211_process_ml_reconf_resp(struct ieee80211_sub_if_data *sdata,
 	ieee80211_recalc_ps(local);
 	ieee80211_recalc_ps_vif(sdata);
 
+	ieee80211_send_uhr_omp_req_dbe(sdata, link_mask, true);
+
 	done_data.buf = (const u8 *)mgmt;
 	done_data.len = orig_len;
 	done_data.added_links = link_mask;
@@ -11030,7 +11448,7 @@ int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
 				continue;
 
 			/* only used to verify the mode, nothing is allocated */
-			err = ieee80211_prep_channel(sdata, NULL, link_id,
+			err = ieee80211_prep_channel(sdata, NULL, NULL, link_id,
 						     data->link[link_id].bss,
 						     true,
 						     &data->link[link_id].conn,
@@ -11492,6 +11910,15 @@ void ieee80211_sta_rx_queued_frame(struct ieee80211_sub_if_data *sdata,
 				break;
 			}
 			break;
+		case WLAN_CATEGORY_PROTECTED_UHR:
+			switch (mgmt->u.action.action_code) {
+			case IEEE80211_PROTECTED_UHR_ACTION_LINK_RECONFIG_NOTIFY:
+				ieee80211_process_uhr_link_reconf_notif(sdata,
+									mgmt,
+									skb->len);
+				break;
+			}
+			break;
 		}
 		break;
 	}
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index ef6086b183f7..4579ebdebdf5 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3947,6 +3947,20 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 			break;
 		}
 		break;
+	case WLAN_CATEGORY_PROTECTED_UHR:
+		if (len < IEEE80211_MIN_ACTION_SIZE(action_code))
+			break;
+
+		switch (mgmt->u.action.action_code) {
+		case IEEE80211_PROTECTED_UHR_ACTION_LINK_RECONFIG_NOTIFY:
+			if (sdata->vif.type != NL80211_IFTYPE_STATION)
+				break;
+
+			if (len < IEEE80211_MIN_ACTION_SIZE(uhr_link_reconf_notif))
+				goto invalid;
+			goto queue;
+		}
+		break;
 	}
 
 	return RX_CONTINUE;
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 85e0b6c5ff00..6b44030659fc 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -572,6 +572,20 @@ static int sta_info_alloc_link(struct ieee80211_local *local,
 	link_info->rx_omi_bw_tx = IEEE80211_STA_RX_BW_MAX;
 	link_info->rx_omi_bw_staging = IEEE80211_STA_RX_BW_MAX;
 
+	/*
+	 * This will always be taken into account, so set to MAX.
+	 * When mac80211 is the client on a UHR AP, it'll be used
+	 * for the TX side, to limit the bandwidth to TX to the AP
+	 * with, to limit to the BSS width during DBE enablement.
+	 *
+	 * This is needed since the chanreq, which normally has
+	 * maximum bandwidth to use with the AP, will already be
+	 * set to the DBE width during enablement to prepare for
+	 * RX (and not be racy), but the TX can only use higher
+	 * bandwidth after enablement finishes.
+	 */
+	link_info->uhr_usable_tx_width = IEEE80211_STA_RX_BW_MAX;
+
 	link_info->op_mode_bw = IEEE80211_STA_RX_BW_MAX;
 
 	/*
@@ -3717,6 +3731,8 @@ ieee80211_sta_current_bw_tx_to_sta(struct link_sta_info *link_sta,
 	bw = min(bw, link_sta->op_mode_bw);
 	/* also limit to RX OMI bandwidth we TX to the STA */
 	bw = min(bw, link_sta->rx_omi_bw_tx);
+	/* and UHR DBE transition limits */
+	bw = min(bw, link_sta->uhr_usable_tx_width);
 
 	/* Don't consider AP's bandwidth for TDLS peers, section 11.23.1 of
 	 * IEEE80211-2016 specification makes higher bandwidth operation
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 1da074dfffb4..6974fccb839f 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -511,6 +511,9 @@ struct ieee80211_fragment_cache {
  * @rx_omi_bw_tx: RX OMI bandwidth restriction to apply for TX
  * @rx_omi_bw_staging: RX OMI bandwidth restriction to apply later
  *	during finalize
+ * @uhr_usable_tx_width: bandwidth restriction for UHR for TX, only when
+ *	the link_sta is an AP, to restrict TX to BSS width during DBE
+ *	enablement
  * @debugfs_dir: debug filesystem directory dentry
  * @pub: public (driver visible) link STA data
  */
@@ -562,6 +565,7 @@ struct link_sta_info {
 	enum ieee80211_sta_rx_bandwidth rx_omi_bw_rx,
 					rx_omi_bw_tx,
 					rx_omi_bw_staging;
+	enum ieee80211_sta_rx_bandwidth uhr_usable_tx_width;
 
 #ifdef CONFIG_MAC80211_DEBUGFS
 	struct dentry *debugfs_dir;
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 8716eda8317d..dd1dbba06838 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -731,6 +731,28 @@ ieee80211_handle_teardown_ttlm_status(struct ieee80211_sub_if_data *sdata,
 			 &sdata->u.mgd.teardown_ttlm_work);
 }
 
+static void
+ieee80211_handle_uhr_omp_status(struct ieee80211_sub_if_data *sdata, bool acked)
+{
+	if (!sdata || !ieee80211_sdata_running(sdata))
+		return;
+
+	if (sdata->vif.type != NL80211_IFTYPE_STATION)
+		return;
+
+	sdata->u.mgd.uhr_omp.acked = acked;
+
+	if (!acked) {
+		wiphy_hrtimer_work_queue(sdata->local->hw.wiphy,
+					 &sdata->u.mgd.uhr_omp.status_work, 0);
+		return;
+	}
+
+	wiphy_hrtimer_work_queue(sdata->local->hw.wiphy,
+				 &sdata->u.mgd.uhr_omp.status_work,
+				 us_to_ktime(sdata->u.mgd.uhr_omp.timeout_us));
+}
+
 static void ieee80211_report_used_skb(struct ieee80211_local *local,
 				      struct sk_buff *skb, bool dropped,
 				      ktime_t ack_hwtstamp)
@@ -811,6 +833,9 @@ static void ieee80211_report_used_skb(struct ieee80211_local *local,
 		case IEEE80211_STATUS_TYPE_NEG_TTLM:
 			ieee80211_handle_teardown_ttlm_status(sdata, acked);
 			break;
+		case IEEE80211_STATUS_TYPE_UHR_OMP:
+			ieee80211_handle_uhr_omp_status(sdata, acked);
+			break;
 		}
 		rcu_read_unlock();
 	}
diff --git a/net/mac80211/tests/chan-mode.c b/net/mac80211/tests/chan-mode.c
index fa370831d617..ab7d38ef6a3a 100644
--- a/net/mac80211/tests/chan-mode.c
+++ b/net/mac80211/tests/chan-mode.c
@@ -2,7 +2,7 @@
 /*
  * KUnit tests for channel mode functions
  *
- * Copyright (C) 2024-2025 Intel Corporation
+ * Copyright (C) 2024-2026 Intel Corporation
  */
 #include <net/cfg80211.h>
 #include <kunit/test.h>
@@ -243,7 +243,7 @@ static void test_determine_chan_mode(struct kunit *test)
 
 	rcu_read_lock();
 	elems = ieee80211_determine_chan_mode(t_sdata->sdata, &conn, &cbss,
-					      0, &chanreq, &ap_chandef,
+					      NULL, 0, &chanreq, &ap_chandef,
 					      userspace_selectors);
 	rcu_read_unlock();
 
-- 
2.53.0


