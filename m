Return-Path: <linux-wireless+bounces-34751-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGT8Cmsz32lqQAAAu9opvQ
	(envelope-from <linux-wireless+bounces-34751-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 08:42:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE7F400F52
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 08:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1215730AB322
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 06:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C861A39021A;
	Wed, 15 Apr 2026 06:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zhi1MJ7t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAF03FCC
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 06:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776235148; cv=none; b=gRpZunwx852IjNTaMLswNUdFbhn878UKPJmAztcb43tdULREImtwvkxJTZF3AhGyqGoHwf1ulV5qYZ9HSW6enQPwWgBVJpnDYhsTPbnnWRFW6kcwcsvfjDd9nejuxz/xEqo5q0VbvOyPNqB307Zx3egLt9mhOWp8Msv2l6Tn6Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776235148; c=relaxed/simple;
	bh=Eq7BTxYOXZq8e8Pw88tGpnRAxQhEAZSkgHXfPEFoPxc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pcZVyXOWeT/8YIwF2USJWOLYBhU1kqbyPAN5CKp05n645Thb22yrFCkoWxk4lL7GhcLhyisBCBkqirF0rEFuKlPCvAkd0aSRD2LFO03Uos1nlLJ4+LjfX86m9VN1xsVrGHJLm26zLj9mHtrvTjljZspJX7x0X8tvXQB31WGzVMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zhi1MJ7t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F4N8uW3126736;
	Wed, 15 Apr 2026 06:39:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=pfj9x6lxpQvTTzSusG9u/s2yjrB8/3WmF9F
	w6+8o99I=; b=Zhi1MJ7tg2tFCmj0rOt3Up+ZgYiQUsDndugFe1U8ufOctz30g37
	xUPBysPbl5ZWve8BzfkCYyaQXidMTXaZKZAWE8bCv/KKfbalP+zsOl2I5tjiRf8G
	XfLA6CoJP4Uzx0HIH67m6UVN8LZ8Wwo4Dxtx6E2zQVMYQSs5UF0fFfgEZi7KL0WE
	YnB1v4n6FC259HiBPf7T82mzKq/J7pyTqqJ4zOBVzEXUuftFgQcksm1qh0V70TO1
	MBUqDiVtRrX3qgH1tOAQpQUSUWQmiPT0SvUdSZxUR9Urh0wZiT50ghYkfaWTqXxT
	R8bEvT3c0YcA21Wg8E+JYKSfZpuXzOCTUAw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dht56t14h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 06:39:03 +0000 (GMT)
Received: from pps.filterd (nasanppmta04.qualcomm.com [127.0.0.1])
	by NASANPPMTA04.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 63F6d2Q0020655;
	Wed, 15 Apr 2026 06:39:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NASANPPMTA04.qualcomm.com (PPS) with ESMTPS id 4dg55scfw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 06:39:02 +0000 (GMT)
Received: from nasanppmta04.qualcomm.com (nasanppmta04.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 63F6d1lb020634;
	Wed, 15 Apr 2026 06:39:01 GMT
Received: from hu-devc-sha-u22-c.qualcomm.com (hu-yintang-sha.qualcomm.com [10.253.185.253])
	by NASANPPMTA04.qualcomm.com (PPS) with ESMTPS id 63F6d02k020571
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 06:39:01 +0000 (GMT)
Received: by hu-devc-sha-u22-c.qualcomm.com (Postfix, from userid 398181)
	id 22E175F6; Wed, 15 Apr 2026 12:08:59 +0530 (+0530)
From: Yingying Tang <yintang@qti.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, yintang@qti.qualcomm.com,
        yingying.tang@oss.qualcomm.com
Subject: [PATCH ath-next] wifi: ath12k: add channel 177 to the 5 GHz channel list
Date: Wed, 15 Apr 2026 12:08:57 +0530
Message-Id: <20260415063857.2462256-1-yintang@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=LuiiDHdc c=1 sm=1 tr=0 ts=69df3287 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=FF8qzyc13NczEEFYgNUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDA1OSBTYWx0ZWRfX91KPWy9cMDVh
 MD91sQI9LcauAPde+KbtJB0SbPewNtmPhgpRFVT0vptL2Fw49iw+yY43uR90Sa+RWkTTkML4Wat
 GAt1M7m759zDtqVWYB3qwKbNBpETfXm2T9Q1oVr0byibPNd+UTKEjh60iJxbx18EAqsbvII0DLL
 Hdj28D/q1Zicv4gA4KA+40fltAGttyb7z0U8KG9F/zecuy/X1/9jb0LHg4hheqrSlHfyWnZdKiK
 HAzc0pG9WfolRqdWFHkQJOeZThD+CJuOYGJD5AgTEY7xUoyToZXmplCQH//Emqi3Wzdg8U0iWnY
 L1FkGPYGinrvGNg6UDNE2bBGHYgNePkcSQP5gQBckThvLjzt18g2A3l2YcLgMz8c4Vu9Cr8C35L
 43Q01elvOem75CTkltYkc1s0IDpL9kcPsJa57Q/Er+EBfqq/EjEiCA1Sbbbe06skmoDT1eDvwme
 xtjZ3qu4icK36GA8Ayw==
X-Proofpoint-ORIG-GUID: 8VSbwQGdBoQjHQMCrM4BC6ih2CBU7Jvr
X-Proofpoint-GUID: 8VSbwQGdBoQjHQMCrM4BC6ih2CBU7Jvr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 priorityscore=1501 adultscore=0 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150059
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34751-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yintang@qti.qualcomm.com,linux-wireless@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 7CE7F400F52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yingying Tang <yingying.tang@oss.qualcomm.com>

Add support for 5 GHz channel 177 with a center frequency of 5885 MHz and
Operating Class 125 per IEEE Std 802.11-2024 Table E-4.

Channels 169, 173, and 177 are in the 5.9 GHz band and must be disabled
when 5.9 GHz service bit is not supported. The 5.9 GHz band is only permitted
for WLAN operation under FCC regulations.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Yingying Tang <yingying.tang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c   | 26 +++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h   |  1 +
 4 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 59c193b24764..17b31c969cd9 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -541,8 +541,8 @@ struct ath12k_sta {
 #define ATH12K_MAX_5GHZ_FREQ	(ATH12K_5GHZ_MAX_CENTER + ATH12K_HALF_20MHZ_BW)
 #define ATH12K_MIN_6GHZ_FREQ	(ATH12K_6GHZ_MIN_CENTER - ATH12K_HALF_20MHZ_BW)
 #define ATH12K_MAX_6GHZ_FREQ	(ATH12K_6GHZ_MAX_CENTER + ATH12K_HALF_20MHZ_BW)
-#define ATH12K_NUM_CHANS 101
-#define ATH12K_MAX_5GHZ_CHAN 173
+#define ATH12K_NUM_CHANS 102
+#define ATH12K_MAX_5GHZ_CHAN 177
 
 static inline bool ath12k_is_2ghz_channel_freq(u32 freq)
 {
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index f0b4f607b845..5327a427c26c 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -17,6 +17,11 @@
 #include "dp_mon.h"
 #include "debugfs_htt_stats.h"
 
+#define ATH12K_2GHZ_MIN_CHAN_NUM 1
+#define ATH12K_2GHZ_MAX_CHAN_NUM 14
+#define ATH12K_5GHZ_MIN_CHAN_NUM 36
+#define ATH12K_5GHZ_MAX_CHAN_NUM 177
+
 static int ath12k_dp_rx_tid_delete_handler(struct ath12k_base *ab,
 					   struct ath12k_dp_rx_tid_rxq *rx_tid);
 
@@ -1284,9 +1289,11 @@ void ath12k_dp_rx_h_ppdu(struct ath12k_pdev_dp *dp_pdev,
 	    center_freq <= ATH12K_MAX_6GHZ_FREQ) {
 		rx_status->band = NL80211_BAND_6GHZ;
 		rx_status->freq = center_freq;
-	} else if (channel_num >= 1 && channel_num <= 14) {
+	} else if (channel_num >= ATH12K_2GHZ_MIN_CHAN_NUM &&
+		   channel_num <= ATH12K_2GHZ_MAX_CHAN_NUM) {
 		rx_status->band = NL80211_BAND_2GHZ;
-	} else if (channel_num >= 36 && channel_num <= 173) {
+	} else if (channel_num >= ATH12K_5GHZ_MIN_CHAN_NUM &&
+		   channel_num <= ATH12K_5GHZ_MAX_CHAN_NUM) {
 		rx_status->band = NL80211_BAND_5GHZ;
 	}
 
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 553ec28b6aaa..7fb6507cebf8 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -51,6 +51,9 @@
 	.max_power              = 30, \
 }
 
+#define ATH12K_5_9_GHZ_MIN_FREQ 5845
+#define ATH12K_5_9_GHZ_MAX_FREQ 5885
+
 static const struct ieee80211_channel ath12k_2ghz_channels[] = {
 	CHAN2G(1, 2412, 0),
 	CHAN2G(2, 2417, 0),
@@ -96,6 +99,7 @@ static const struct ieee80211_channel ath12k_5ghz_channels[] = {
 	CHAN5G(165, 5825, 0),
 	CHAN5G(169, 5845, 0),
 	CHAN5G(173, 5865, 0),
+	CHAN5G(177, 5885, 0),
 };
 
 static const struct ieee80211_channel ath12k_6ghz_channels[] = {
@@ -13900,6 +13904,26 @@ static int ath12k_mac_update_band(struct ath12k *ar,
 	return 0;
 }
 
+static void ath12k_mac_update_5_9_ghz_ch_list(struct ath12k *ar,
+					      struct ieee80211_supported_band *band)
+{
+	int i;
+
+	if (test_bit(WMI_TLV_SERVICE_5_9GHZ_SUPPORT,
+		     ar->ab->wmi_ab.svc_map))
+		return;
+
+	guard(spinlock_bh)(&ar->ab->base_lock);
+	if (ar->ab->dfs_region != ATH12K_DFS_REG_FCC)
+		return;
+
+	for (i = 0; i < band->n_channels; i++) {
+		if (band->channels[i].center_freq >= ATH12K_5_9_GHZ_MIN_FREQ &&
+		    band->channels[i].center_freq <= ATH12K_5_9_GHZ_MAX_FREQ)
+			band->channels[i].flags |= IEEE80211_CHAN_DISABLED;
+	}
+}
+
 static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 					   u32 supported_bands,
 					   struct ieee80211_supported_band *bands[])
@@ -14033,6 +14057,8 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 			band->n_bitrates = ath12k_a_rates_size;
 			band->bitrates = ath12k_a_rates;
 
+			ath12k_mac_update_5_9_ghz_ch_list(ar, band);
+
 			if (ab->hw_params->single_pdev_only) {
 				phy_id = ath12k_get_phy_id(ar, WMI_HOST_WLAN_5GHZ_CAP);
 				reg_cap = &ab->hal_reg_cap[phy_id];
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 5ba9b7d3a888..8fab8ddaae59 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2259,6 +2259,7 @@ enum wmi_tlv_service {
 	WMI_TLV_SERVICE_FREQINFO_IN_METADATA = 219,
 	WMI_TLV_SERVICE_EXT2_MSG = 220,
 	WMI_TLV_SERVICE_BEACON_PROTECTION_SUPPORT = 244,
+	WMI_TLV_SERVICE_5_9GHZ_SUPPORT = 247,
 	WMI_TLV_SERVICE_SRG_SRP_SPATIAL_REUSE_SUPPORT = 249,
 	WMI_TLV_SERVICE_MBSS_PARAM_IN_VDEV_START_SUPPORT = 253,
 
-- 
base-commit: dbd94b9831bc52a1efb7ff3de841ffc3457428ce

