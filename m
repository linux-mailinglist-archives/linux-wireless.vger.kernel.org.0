Return-Path: <linux-wireless+bounces-6779-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 737A28B1349
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 21:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6F11F246A8
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 19:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6733820B34;
	Wed, 24 Apr 2024 19:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NYl3xd8r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB11A1CFB9
	for <linux-wireless@vger.kernel.org>; Wed, 24 Apr 2024 19:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713985922; cv=none; b=JxtJZtMO5ySMFQ0JXjUwMuQ/rAGidELqkJXhpRiL8Kjq3voKRGpSJ2MwAsx7iaqtvnsQPR9OfPfWVPVVnX6v/BJ3FU35KJnLhvbF8h15nlPXYGvonDi7vv8bjNEyT9k4ujJcbqOMwk6411qDh+1PHAHD+Gbp/PeVRUkVTKdPhpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713985922; c=relaxed/simple;
	bh=hHvbkUluBVCEZ8rx18TnyQkqtsnkv+FId5oI5WwWe00=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XKhzIkj1aK8UIcBcPKGevq8SN/U2AzHSL7NGtuaCmefs4UOEJHipvFB1vfdfW4V4eUgRTaG6jXIq6EfpoDOot6rQigkqJ/Z++I3wSyAJxCxZ+jOWuhQh62TA27r9FI6tXNIgu9WTXtkilQtV9DFiRNEp4cxU8fS2zNCurE8+R0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NYl3xd8r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OImT5t018809;
	Wed, 24 Apr 2024 19:11:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=0Y7GatnxYsRUq9tC5+7k
	t+sWytdHupCfWpn/cqIvMe8=; b=NYl3xd8rQTnoUPGYHq1sdcc6dwMGgufG0ob8
	zJmFEH9iRG7WVXBiJ67I/BgRzvooZuxXCtOmZrQ+5Yvh9T8YNYRZAlDDe+Ipb8b3
	yz81Tl3ftYM0Eei2BQTIyTexn7/MFDrlBuqieLSIZM+bsTuuse3A+SJOhgaDFgJP
	YPi8WAKKxHKW5i6zUNh/AFVbbkDe9OnTjn6FtrEUQwjvG7TdVyPcPwhEx930Nw9x
	tRWJpizCiRwnOGVJnUWzfn2s8UElmAuXeJjk2SpQXzq6IXMD6rrmYDjS9ukt+trm
	D4t0zAsrpEfTk7fkTDn2RS6hDn/4nFkEDmJDmPdXbEbIWnrV2Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9gswv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 19:11:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43OJBqG5019396
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 19:11:52 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 24 Apr 2024 12:11:51 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
Subject: [PATCH V3 2/6] wifi: ath12k: Correct 6 GHz frequency value in rx status
Date: Wed, 24 Apr 2024 12:11:37 -0700
Message-ID: <20240424191141.32549-3-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240424191141.32549-1-quic_pradeepc@quicinc.com>
References: <20240424191141.32549-1-quic_pradeepc@quicinc.com>
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
X-Proofpoint-GUID: Dd54OnMRUB8gX4cshvq2qqVB_8XfN5xh
X-Proofpoint-ORIG-GUID: Dd54OnMRUB8gX4cshvq2qqVB_8XfN5xh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_16,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240091

The frequency in the rx status is currently being filled
incorrectly for the 6 GHz band. The channel number received is
invalid in this case, resulting in packet drops. Fix this
issue by correcting the frequency calculation.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c |  9 ++++++---
 drivers/net/wireless/ath/ath12k/wmi.c   | 10 +++++++---
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 75df622f25d8..e5fb5cb000f0 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2383,8 +2383,10 @@ void ath12k_dp_rx_h_ppdu(struct ath12k *ar, struct hal_rx_desc *rx_desc,
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
@@ -2402,8 +2404,9 @@ void ath12k_dp_rx_h_ppdu(struct ath12k *ar, struct hal_rx_desc *rx_desc,
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


