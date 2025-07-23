Return-Path: <linux-wireless+bounces-25953-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BA4B0FAB9
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 21:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A7321C852B2
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 19:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD9F2222BF;
	Wed, 23 Jul 2025 19:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DxEHCCps"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4E37F9
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 19:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753297628; cv=none; b=KvBkZuE8x0agcsf5yBdCarWeMYxg6pIVF0vnCmBqdIjr6S/WbDdZOzEZvZzXjb9DOAorzmdsjSOrFHPLtVj4r34Xw5+lwyIqEzqoR44YcmL6umbaOFzXVUOxHWCADyAbcuLORe0mvM7CNGP7Iiv6gcXhaZSh2skqEfs3Ls6x57Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753297628; c=relaxed/simple;
	bh=l7kkiYxJVZAeZsfOmI9aCmsB3ZWA0Zumh9lbWpQcG9k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BnOOh42ZHYxJfXFL2NVYSuyXSH5sP+65Ge22TiInFmXZMjS1gefaoFxSx6BNJVtzFT7ekrc49v0C1yMbMZCDP1uXaDghxuP5hv1d7h0Rl1fCZ8cDZA/x6cXvfFAL1tLPPeky5MpEQLDhPtYU/RT0TQNJtAsivxSTcrZyDeS3LE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DxEHCCps; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NHBpH1010741
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 19:07:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=6OAgETBIo5KYl0wAQ2L6Hxvxd9XFR9GD7QB
	ZUpNqysQ=; b=DxEHCCpsdExlGWLApGnobsYhg7ZujnVkou5AMy5oVHNPrKwm37h
	RdL0u4mtJ7Qt8adp2rRVwEOrLZ73PqwCQP5rMJF38cwTJ7n0VMXz2mnc83Mc7ACb
	Pd5z1FIq5rckC+OWXrscz3f5uqNg45bSQ9hdYGQSzsE9W3RKluTcE98zUEavDAUJ
	lKJv7I4Ikx/ykgw6OSXvOmCs7HzaV/JjC6xNx/BKS7rskkBEJfWb45fooYyA55Oe
	Z2ub3cztE3qCgbpZnG9nwsRGTCOPNe1KYXsue7f1FxTt/xSrtpfRTeGoPadbxE77
	WT3LCcnyyI8cZRa0wRyDA1Yz4yxR+Gz4x1A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48313kgwpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 19:07:02 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-31cb5c75e00so165418a91.0
        for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 12:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753297621; x=1753902421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6OAgETBIo5KYl0wAQ2L6Hxvxd9XFR9GD7QBZUpNqysQ=;
        b=NgdewDf8Iw0JKL/mQvLHhQ2P+i3Ry3fL4m3XCLm48kSgWTVzq+YR5dxB0KHJ0F2X/X
         sFk5L6JRYCgtXOiAPO22256bcl0Rbij6AR7Yg2R93orw/XyL2ehvCG/clnOtC8eP9E81
         xq5zgLvYpTdY61JU49T7MKLogRzWqUaL4EanwTQDxtqdjh/oRCv/kcXrSM+mZLcEq3lb
         Maroo+y1YgzJkE5NaIGHDeEBRu76uK7Oqsd7btqZjEkm9pRYr7/QPe+ujr/SohvfVOm0
         Wb3Ke1UaIqG8EpWn9i8oyDroLzobuCS3ihqGnnFBJBcoCYDISfZFLYlwVrnKRWHJP01U
         zmiQ==
X-Gm-Message-State: AOJu0YyOac5uKJeZj/Kk4CE2/oIc/yulWnt5pN63UtPS4jIDq9S3iM5c
	HpCUFLXEGZWG0KLNrzii3SOGBnAW2Jlwseyp7GBokEwcuaVHvIxzTz12Cgkif8xsURsj4R4iTYm
	ZnUXvgSHhB7gqdzyvMwizeSeLtJ3DVtUDtd8onsrqW+gmbtkdjfReatNKBHzAT5TvPlNDrkLRYH
	6tww==
X-Gm-Gg: ASbGncuMvVSe9PqOf9e6lfWWUd03Vv/d1a63JI/STXzPS2gj5MQ75r80M8SVFPYjTeT
	ei5CfR3F1POSKdJ4kHwOB7CLoNE7Bfbd89OnvXT6/vaxrgJEhvyzsvdxektcbLphwJgVglhZceC
	KQtNpqo+E49WSHTW1hr2Yik9lmPXuzKFLVjpUH2bjOO01NdjRvtiUkbZvT5QH5BmMyp2HzUdOis
	d6tBmfw0QWu2FYrf6lP96P6F4OyZwEmsA6MfR0/WhC7Gz0qHwToY+2YNCRUwquqIusH0+Pzt2lo
	PNAfdcpwCzhe+1dkACsssdncv0+c4ganPgVnclhrV1Xf/h9KjAVkxWeRXV/W7GgdXv7Ly9biOS+
	y5CKr7NI2kEfqrQU54mAfQQmleZW1JPf5LjQNnCxc5Dk5iOUtAAbSmw==
X-Received: by 2002:a17:90b:3ec4:b0:2fa:42f3:e3e4 with SMTP id 98e67ed59e1d1-31e3e107b35mr10939152a91.3.1753297620716;
        Wed, 23 Jul 2025 12:07:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMW7SPxYd5AV88V01ROsSqlFgmOzoQGRQjlPHQTKSQch4m9RBwARFM9Viisr5FxDFdGrXm8A==
X-Received: by 2002:a17:90b:3ec4:b0:2fa:42f3:e3e4 with SMTP id 98e67ed59e1d1-31e3e107b35mr10939111a91.3.1753297620202;
        Wed, 23 Jul 2025 12:07:00 -0700 (PDT)
Received: from hu-aisr-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e519ce880sm2219528a91.1.2025.07.23.12.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 12:06:59 -0700 (PDT)
From: Aishwarya R <aishwarya.r@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Sriram R <quic_srirrama@quicinc.com>,
        Vinith Kumar R <quic_vinithku@quicinc.com>,
        Aishwarya R <aishwarya.r@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: Add fallback for invalid channel number in PHY metadata
Date: Thu, 24 Jul 2025 00:36:51 +0530
Message-Id: <20250723190651.699828-1-aishwarya.r@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE2MSBTYWx0ZWRfXwt0EAcsSVWmu
 r/qVDCwwBRXJpZVJk1Pe5eNBFYulUST2iylG+MHSQPtcO0XeYBqQvCAbBt4Zwl5nMgKSDUTeYkZ
 rAyivErOx7fWL/LRML3fBmMKeKtcfZnf/l5ZPHlg6QePaDkYTWyv8rVj6YO4pyorAPoJXvGuPOY
 bBliUPudpYkwkddEHNSk5VJrRSxuCJOvSlHDuDhbRGLZ4q0coIupy9xDMm1dWNHanFDcfJQBxDj
 wZbWkVtn5SqGWVIwCTNf++JPM+ea7bfCnklNaoy0VtSjXfqdcGAm21QTRwmsJOYyQeAYUXqTOFl
 qKO3vAh+17XytfLmPSnvwmpf854M5tFhvA4nPpE9RCIfAF2BfPELL+MZupnKQtIT+m+Nfefwlf7
 jz7jo3ejLkeQv3paROwBh/twtrO6ikwetNXG1sYAzwObipAwKHveJQ89/H7fzBKWsrWPrGN9
X-Proofpoint-ORIG-GUID: m71A9FnXH_SJZEjrRf5J13QFR8XxHbdA
X-Proofpoint-GUID: m71A9FnXH_SJZEjrRf5J13QFR8XxHbdA
X-Authority-Analysis: v=2.4 cv=C/TpyRP+ c=1 sm=1 tr=0 ts=688132d6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=wNp79QKJu4ZgEVFT10sA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 mlxscore=0 clxscore=1011 impostorscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230161

From: Sriram R <quic_srirrama@quicinc.com>

Currently, ath12k_dp_rx_h_ppdu() determines the band and frequency
based on the channel number and center frequency from the RX descriptor's
PHY metadata. However, in rare cases, it is observed that frequency
retrieved from the metadata may be invalid or unexpected especially for
6 GHz frames.
This can result in a NULL sband, which prevents proper frequency assignment
in rx_status and potentially leading to incorrect RX packet classification.

To fix this potential issue, add a fallback mechanism that uses
ar->rx_channel to populate the band and frequency when the derived
sband is invalid or missing.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Co-developed-by: Vinith Kumar R <quic_vinithku@quicinc.com>
Signed-off-by: Vinith Kumar R <quic_vinithku@quicinc.com>
Signed-off-by: Aishwarya R <aishwarya.r@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 8ab91273592c..adb0cfe109e6 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2533,6 +2533,8 @@ void ath12k_dp_rx_h_ppdu(struct ath12k *ar, struct ath12k_dp_rx_info *rx_info)
 	channel_num = meta_data;
 	center_freq = meta_data >> 16;
 
+	rx_status->band = NUM_NL80211_BANDS;
+
 	if (center_freq >= ATH12K_MIN_6GHZ_FREQ &&
 	    center_freq <= ATH12K_MAX_6GHZ_FREQ) {
 		rx_status->band = NL80211_BAND_6GHZ;
@@ -2541,21 +2543,33 @@ void ath12k_dp_rx_h_ppdu(struct ath12k *ar, struct ath12k_dp_rx_info *rx_info)
 		rx_status->band = NL80211_BAND_2GHZ;
 	} else if (channel_num >= 36 && channel_num <= 173) {
 		rx_status->band = NL80211_BAND_5GHZ;
-	} else {
+	}
+
+	if (unlikely(rx_status->band == NUM_NL80211_BANDS ||
+		     !ath12k_ar_to_hw(ar)->wiphy->bands[rx_status->band])) {
+		ath12k_warn(ar->ab, "sband is NULL for status band %d channel_num %d center_freq %d pdev_id %d\n",
+			    rx_status->band, channel_num, center_freq, ar->pdev_idx);
+
 		spin_lock_bh(&ar->data_lock);
 		channel = ar->rx_channel;
 		if (channel) {
 			rx_status->band = channel->band;
 			channel_num =
 				ieee80211_frequency_to_channel(channel->center_freq);
+			rx_status->freq = ieee80211_channel_to_frequency(channel_num,
+									 rx_status->band);
+		} else {
+			ath12k_err(ar->ab, "unable to determine channel, band for rx packet");
 		}
 		spin_unlock_bh(&ar->data_lock);
+		goto h_rate;
 	}
 
 	if (rx_status->band != NL80211_BAND_6GHZ)
 		rx_status->freq = ieee80211_channel_to_frequency(channel_num,
 								 rx_status->band);
 
+h_rate:
 	ath12k_dp_rx_h_rate(ar, rx_info);
 }

base-commit: 708243c62efde8241e2c66e9c3f377658855149d 
-- 
2.34.1


