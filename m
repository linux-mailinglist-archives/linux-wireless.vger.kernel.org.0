Return-Path: <linux-wireless+bounces-7351-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 109BA8C0344
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 19:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCDC0281D25
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 17:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBA078C60;
	Wed,  8 May 2024 17:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mKwvNbki"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919CA12B143
	for <linux-wireless@vger.kernel.org>; Wed,  8 May 2024 17:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189843; cv=none; b=jZjm82goqsVImKqcI3g3vGhY9qnn1E0F7b6XD38scUtuqvSvUuaZ747f82MxBxbUZJh9Hx2BVwtzWnPNJUONZa3tmJA5o5Snsw7miCB8eG+Ox4MKq0kmhM/Wxm9nF2eBHfSxzijK7YQYCNdvBVp5gW7bQEbqmfkGmI67nFmeLkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189843; c=relaxed/simple;
	bh=ocuMcqlhxkjM6b0XLyiA/EuXIILNGt8mXpystnXAdZQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JIBqaYngB5JZKwrVsPyE5ja9fhG53q4W2M36+bp3IrV5OEtTz6VdpV7hlce9dZI1rDjBvGz7cctGNBgBf6utr5HOjZqWxDtf22wW1lmNXJVsOZ7Q74lmRZxe70xpZ3d6zTn+hg4D5PEmdMs6cooi7bCPGTdasxZzKQBbp6p4+JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mKwvNbki; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 448G4EqZ024341;
	Wed, 8 May 2024 17:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=AlbyqipWzwbFiknh0sv4
	2kACYHEP0uF4aJXWqbjM/Ro=; b=mKwvNbkipH8bHwM3JPAsfpZiq29AhJo8o/CK
	qsfmQi37sM106HRSLyycyIpxb6/WcacTa6IK61/d+krDUK8rfjDl/t3cy9n8v8je
	jtBWMVb5CBXX7cmAemDyoRIC6U7WNIE9WkMqBlfAy1GgAqlo5a4fipQiYKyovMPv
	MbDpsn+yxnkC94y8VaXvwOI8myZNH+Ct264VUTHHOcVHhI9stIB/AfGfRHkf3liL
	55fGPqd90gIyFG8QnzJ4HiCSJVsCHAwehmerSDRBQafmtZAnIvYltShhf8+mQNYQ
	W+I0PRZtXeoT8kj+V40rRD55qQYP0lQIyRdnlcJhZV+XcLaaNQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y07wfryum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 17:37:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 448Hb7FW018339
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 May 2024 17:37:07 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 8 May 2024 10:37:06 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
Subject: [PATCH V5 2/6] wifi: ath12k: Correct 6 GHz frequency value in rx status
Date: Wed, 8 May 2024 10:36:51 -0700
Message-ID: <20240508173655.22191-3-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240508173655.22191-1-quic_pradeepc@quicinc.com>
References: <20240508173655.22191-1-quic_pradeepc@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Nob21nLuhdtu_jsdxX6fOM3MXDlVSaAy
X-Proofpoint-ORIG-GUID: Nob21nLuhdtu_jsdxX6fOM3MXDlVSaAy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405080127

The frequency in the rx status is currently being filled
incorrectly for the 6 GHz band. The channel number received is
invalid in this case, resulting in packet drops. Fix this
issue by correcting the frequency calculation.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c |  9 ++++++---
 drivers/net/wireless/ath/ath12k/wmi.c   | 10 +++++++---
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 952a377b5491..9f3db6c1b7fc 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2359,8 +2359,10 @@ void ath12k_dp_rx_h_ppdu(struct ath12k *ar, struct hal_rx_desc *rx_desc,
 	channel_num = meta_data;
 	center_freq = meta_data >> 16;
 
-	if (center_freq >= 5935 && center_freq <= 7105) {
+	if (center_freq >= ATH12K_MIN_6G_FREQ &&
+	    center_freq <= ATH12K_MAX_6G_FREQ) {
 		rx_status->band = NL80211_BAND_6GHZ;
+		rx_status->freq = center_freq;
 	} else if (channel_num >= 1 && channel_num <= 14) {
 		rx_status->band = NL80211_BAND_2GHZ;
 	} else if (channel_num >= 36 && channel_num <= 173) {
@@ -2378,8 +2380,9 @@ void ath12k_dp_rx_h_ppdu(struct ath12k *ar, struct hal_rx_desc *rx_desc,
 				rx_desc, sizeof(*rx_desc));
 	}
 
-	rx_status->freq = ieee80211_channel_to_frequency(channel_num,
-							 rx_status->band);
+	if (rx_status->band != NL80211_BAND_6GHZ)
+		rx_status->freq = ieee80211_channel_to_frequency(channel_num,
+								 rx_status->band);
 
 	ath12k_dp_rx_h_rate(ar, rx_desc, rx_status);
 }
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 7a52d2082b79..e88ec9e1201a 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6022,8 +6022,10 @@ static void ath12k_mgmt_rx_event(struct ath12k_base *ab, struct sk_buff *skb)
 	if (rx_ev.status & WMI_RX_STATUS_ERR_MIC)
 		status->flag |= RX_FLAG_MMIC_ERROR;
 
-	if (rx_ev.chan_freq >= ATH12K_MIN_6G_FREQ) {
+	if (rx_ev.chan_freq >= ATH12K_MIN_6G_FREQ &&
+	    rx_ev.chan_freq <= ATH12K_MAX_6G_FREQ) {
 		status->band = NL80211_BAND_6GHZ;
+		status->freq = rx_ev.chan_freq;
 	} else if (rx_ev.channel >= 1 && rx_ev.channel <= 14) {
 		status->band = NL80211_BAND_2GHZ;
 	} else if (rx_ev.channel >= 36 && rx_ev.channel <= ATH12K_MAX_5G_CHAN) {
@@ -6044,8 +6046,10 @@ static void ath12k_mgmt_rx_event(struct ath12k_base *ab, struct sk_buff *skb)
 
 	sband = &ar->mac.sbands[status->band];
 
-	status->freq = ieee80211_channel_to_frequency(rx_ev.channel,
-						      status->band);
+	if (status->band != NL80211_BAND_6GHZ)
+		status->freq = ieee80211_channel_to_frequency(rx_ev.channel,
+							      status->band);
+
 	status->signal = rx_ev.snr + ATH12K_DEFAULT_NOISE_FLOOR;
 	status->rate_idx = ath12k_mac_bitrate_to_idx(sband, rx_ev.rate / 100);
 
-- 
2.17.1


