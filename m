Return-Path: <linux-wireless+bounces-28636-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FA3C370C0
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 18:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4109B3492DC
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 17:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDC633CE81;
	Wed,  5 Nov 2025 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fjsJtXBz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rnj1zQqY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF4333B97F
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 17:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762363358; cv=none; b=UkFkU1LvC5mPRk3dGFqZiaIJEqCB0OLvESXFvkyv6SBW6FCIvZJ14a5Zp9SdA9h5Rc7oMgGvtgl6+bKbeuGGrpDE/xURRgmEFvB1sL3eBcOhd+Blwb4xmb0kzPHMsu2Og+J3hZ+HLlM9OZSEll315JV8LwkXhHJnlVys50oEJ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762363358; c=relaxed/simple;
	bh=t5/ge6GzdGgh1+ffRzwal3+n/u8ueUwYnBULeeTMjhs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EtdR105emMH6m+CAHeraTeINCfn/UFCcPXffxSMhsLDFWDxT7jTuE40gUDy+7RmtF304ww1QBWh0djz/MEXYRqRm3ty28LE/ijnPh9o3R0ERiRyFo4FLHg1a2j7XSkJAhlr2ZOak8GAYKT++ndazeJkakAEG9USa4eejhbcnfvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fjsJtXBz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rnj1zQqY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5CYsD13913970
	for <linux-wireless@vger.kernel.org>; Wed, 5 Nov 2025 17:22:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=E/JGA8NlNfL
	RHt5JiK60dzndBvs8Ulpj2FKRq2wFm+Y=; b=fjsJtXBzDSPJJ349QyWR+5zW7t2
	BHj9sS6k6/MPWe5I9YF4lCXV0+M5tLznEKi5kAG/egd3EnpEXcwPO1JYOzidhLtr
	qn5ScDgkUT1WPeijvvVH7diNH0AI5Cv9CF1IJokHnFNF0CE0+Q8SplvoKdmZ5FeW
	CxLxX/uUm7xMLcnSkCmNsqyLK8p1bDgBKg7GnD23uvP7V44FfuhsN86xDcE2xG1Q
	nyOzuX2Ug8pAf8Xi+uxGFD4v/W0x0nCwufmShzKOUdbL9z91dcsWA88YnHdFYqyZ
	YF5f+EPPLYUWvKngW30dCpqTCOaRerwFRPxftDj0SNgBShlyNN79b7LRO6Q==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7y37a4pq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 05 Nov 2025 17:22:35 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-ba795c4d4a2so4884a12.3
        for <linux-wireless@vger.kernel.org>; Wed, 05 Nov 2025 09:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762363355; x=1762968155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/JGA8NlNfLRHt5JiK60dzndBvs8Ulpj2FKRq2wFm+Y=;
        b=Rnj1zQqYMzUY4txLQMyS46y706g8n8ljYnVMJwIHO+Ypp9unkwfCy2EmfJfyqvzCgX
         y+4egnuun6uSJokoyW44uk3MSv2FejSMte2kz3sUuzfve8ayN15GYo3ld/I9hZARJrXo
         tn8/8emf8yk2+32G9OxKNqGhSmsORDW2dFBDVd4OWnhQsauViSDeEhEfgbmqNr2PyjU/
         4wvzeAw3UgNyPXbn9AzIxz6LwFpZQStYfbpWv47OjGIOCM1pfjV0JRkQfpwE9U35yeiJ
         jnNy3QYPhqqK7VMfWb/EdEF3/yTFIw3nc8a9bx3XBYOojkyPVhcn4GThqQwfFt5J4EnW
         +VSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762363355; x=1762968155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E/JGA8NlNfLRHt5JiK60dzndBvs8Ulpj2FKRq2wFm+Y=;
        b=PUfN/PyQXGef2kI6jO1FPqFgA5vnhrljfEc6BNb9aQymx6ZJPxbq16iKsSRFZDaSAb
         2VO8MgiNV44O+a/6VIfcvM+ThAa4VyTU5bzcXRn0qd9ghGFloXDODL5yhn9LgRlBQQMY
         YwLvmWNI3YKDuJ+yFVSkNSYFSG27b0zVLOg6jNBrZGsOtcoym8uIlH+9fAIT61TOLTKt
         MRxwbAusM1IHdFswDDIiwuPq8HzbX76PuanQ9Ys6+0BYqAvQyNX9B2QSlgnr6bHdWE69
         KFPSqx8qmOtApZ3CxSmAswXE/TOsUjiGj0ApgdBbdci9T1E6qDHz8BVO1JGp3MPnHyjY
         9rOA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ39G+hgWO/BEsrDZiCVSxvORuWnu0+Ev/m3FyXE0HamUNc0BWg7HbqqM5ndsqFcyUerVs6GP/RUYferGLkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoG8IaLhHVPyq20u68AcgzEDeO+4wHB/9p2/VWLg5QElearcmV
	r/7rORcRi61oE8vPETgZCL9u/saCK4H7GbnSPhEVqDvFYrQxoiCLGtFgEI00XzJdLadZOMpFOvc
	IXTi5pqwxnV/ETurnkaWaRdcM7AQ3utqahBdjxc7IYjjOP3vV8FC3vidtD1d+QY/b2nSRMQ==
X-Gm-Gg: ASbGncveFnINOaqCRv/bxTd/NGhFumkj99OO90LiPQrwjFDjCnuqQ2igZnek5WcDKA5
	T5yFY/ummT4jmgODy00JQYEbes+vjkyXb/r7vrEsWoznx0dyiTFQZifHiQSzRJtqOZOQF/kS6rt
	cPtz/YjYHm5xYVCG7v7j02t3NXJTEjGxrcxzpCF5su3cd5elQThAtK9FJq/tl9R7teLzP5r8ZsA
	0Ix1Y2Do6zX41SOTb1Ym6nGgW5D1Mfd6xtNH57p/mEdRl4vyqZTrFWxkACWRRrMBi7iMoILSq1J
	QYe0HItMe1yY13r8HF8Dd0LizFmmaSwr5gVYcX1s8x+ewDxeAjxZpdJkliqwNQdOD6/LjMnHYYZ
	OSBIGPQMQ2MhqSQsEq9ChxJuSHUQ4hR4LjyPKU+TWN4lJ
X-Received: by 2002:a05:6a21:999a:b0:34e:8864:7952 with SMTP id adf61e73a8af0-34f837ed9b3mr5866646637.2.1762363354804;
        Wed, 05 Nov 2025 09:22:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhtxpt0U6Mdf8qB4LCjblFkBg1cLt9Axqbp/AgV/z0MjgUl5CIsJwY6PTbirUDR60J6qg/9g==
X-Received: by 2002:a05:6a21:999a:b0:34e:8864:7952 with SMTP id adf61e73a8af0-34f837ed9b3mr5866532637.2.1762363353727;
        Wed, 05 Nov 2025 09:22:33 -0800 (PST)
Received: from hu-yuzha-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af48d83c20sm518014b3a.62.2025.11.05.09.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 09:22:33 -0800 (PST)
From: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: baochen.qiang@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Yu Zhang <yu.zhang@oss.qualcomm.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Subject: [PATCH ath-next v3 4/6] wifi: ath11k: Register relayfs entries for CFR dump
Date: Wed,  5 Nov 2025 09:22:24 -0800
Message-Id: <20251105172226.3182968-5-yu.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105172226.3182968-1-yu.zhang@oss.qualcomm.com>
References: <20251105172226.3182968-1-yu.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: pB0gE5IYgrKEgSKMP5iY7QDuX9uHm1Qt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzNSBTYWx0ZWRfXwJTHu4x+JN6/
 xYIpxuklKNKsplCc8gicFHU5b4teEQuE+NGB5lZDF6Ia+NYUh4bDrxB1oeMWGrDjuVJnhMvxLFK
 eWF/0jalh6bi9lntXRLGPXHOSuORcWoifZVeKXwdTuDg0do63jrmp+ASbB5zUXX4C1lzaQdunmc
 AU65+hq3/E599o0kOEMqBPs/zazBh44WTEYM2mbPQCdFV3KVePuj4YGJcKE3UnF2ejHKpKuvDii
 6bNZ+YnJlcWOqIlqpRVWm5l3pjpA59ywNj5Febkk78zVnajZjMSfLJXAsXPyTY5GBmUoLlsdoGe
 QshFQtqa0Yf4fYFsp818gPkOVVtIikGKrmv7H/MJWx8jQxGaV/vVPCHk2/mYfHoe4NQeDs2I2OF
 nQ8a7E5zrV7bh/NHnJYCwXjhvXdEew==
X-Proofpoint-ORIG-GUID: pB0gE5IYgrKEgSKMP5iY7QDuX9uHm1Qt
X-Authority-Analysis: v=2.4 cv=Ev3fbCcA c=1 sm=1 tr=0 ts=690b87db cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=6mQ44K8ZfP1dJrZg0vYA:9
 a=x9snwWr2DeNwDh03kgHS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050135

From: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>

Provide a relayfs interface to collect the CFR dump from the user space.

'/sys/kernel/debug/ieee80211/phyX/ath11k/cfr_capture' is exposed to user
space to get CFR data.

CFR format to user space:
 ___________________________________________
| CFR header | CFR payload | CFR tail data |
|____________|_____________|_______________|

CFR header contains the following fields,

* Start magic number 0xDEADBEAF - 4 bytes
* vendor id - 4 bytes
* cfr metadata version - 1 byte
* cfr data version - 1 byte
* device type - 1 byte
* platform type - 1 byte
* CFR metadata length - 4 bytes
* metadata - 92 bytes
        peer mac - 6 bytes
        capture status - 1 byte (1 for success 0 for failure)
        capture_bw - 1 byte
        channel_bw - 1 byte
        phy_mode - 1 byte
        prim20_chan - 2 bytes
        center_freq1 - 2 bytes
        center_freq2 - 2 bytes
        capture_mode - 1 byte
        capture_type - 1 byte
        sts_count - 1 byte
        num_rx_chain - 1 byte
        timestamp - 4 bytes
        length - 4 bytes
        chain_rssi - 32 bytes (4 bytes for each chain)
        chain_phase - 16 bytes (2 bytes for each chain)
        cfo_measurement - 4 bytes
        agc_gain - 8 bytes (1 bytes for each chain)
        rx_start_ts - 4 bytes

CFR payload:

CFR payload contains 8bytes of ucode header followed by the tone
information. Tone order is positive tones, followed by PHY memory
garbage, followed by negative tones. Dummy tones are uploaded to make
number of tones always integer number of 64. Number of tones is not
preamble type dependent.

Each CFR tone has 14-bit I component and 14-bit Q component and is sign
extended to 16-bit I/Q. Two tones are packed into one 64-bit unit as:

[63:0] = [Tone1_Q(63:48) Tone1_I(47:32) Tone0_Q(31:16) Tone0_I(15:0)]

CFR tail: end magic number 0xBEAFDEAD

Tested-on: IPQ8074 hw2.0 PCI IPQ8074 WLAN.HK.2.5.0.1-00991-QCAHKSWPL_SILICONZ-1
Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04685-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Co-developed-by: Yu Zhang (Yuriy) <yu.zhang@oss.qualcomm.com>
Signed-off-by: Yu Zhang (Yuriy) <yu.zhang@oss.qualcomm.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/cfr.c | 35 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/cfr.h |  1 +
 2 files changed, 36 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/cfr.c b/drivers/net/wireless/ath/ath11k/cfr.c
index e22b0151833c..495b2c6742aa 100644
--- a/drivers/net/wireless/ath/ath11k/cfr.c
+++ b/drivers/net/wireless/ath/ath11k/cfr.c
@@ -416,10 +416,45 @@ static void ath11k_cfr_debug_unregister(struct ath11k *ar)
 	ar->cfr.enable_cfr = NULL;
 	debugfs_remove(ar->cfr.cfr_unassoc);
 	ar->cfr.cfr_unassoc = NULL;
+
+	relay_close(ar->cfr.rfs_cfr_capture);
+	ar->cfr.rfs_cfr_capture = NULL;
 }
 
+static struct dentry *ath11k_cfr_create_buf_file_handler(const char *filename,
+							 struct dentry *parent,
+							 umode_t mode,
+							 struct rchan_buf *buf,
+							 int *is_global)
+{
+	struct dentry *buf_file;
+
+	buf_file = debugfs_create_file(filename, mode, parent, buf,
+				       &relay_file_operations);
+	*is_global = 1;
+	return buf_file;
+}
+
+static int ath11k_cfr_remove_buf_file_handler(struct dentry *dentry)
+{
+	debugfs_remove(dentry);
+
+	return 0;
+}
+
+static const struct rchan_callbacks rfs_cfr_capture_cb = {
+	.create_buf_file = ath11k_cfr_create_buf_file_handler,
+	.remove_buf_file = ath11k_cfr_remove_buf_file_handler,
+};
+
 static void ath11k_cfr_debug_register(struct ath11k *ar)
 {
+	ar->cfr.rfs_cfr_capture = relay_open("cfr_capture",
+					     ar->debug.debugfs_pdev,
+					     ar->ab->hw_params.cfr_stream_buf_size,
+					     ar->ab->hw_params.cfr_num_stream_bufs,
+					     &rfs_cfr_capture_cb, NULL);
+
 	ar->cfr.enable_cfr = debugfs_create_file("enable_cfr", 0600,
 						 ar->debug.debugfs_pdev, ar,
 						 &fops_enable_cfr);
diff --git a/drivers/net/wireless/ath/ath11k/cfr.h b/drivers/net/wireless/ath/ath11k/cfr.h
index e7b69e98cbf5..19f136d34c65 100644
--- a/drivers/net/wireless/ath/ath11k/cfr.h
+++ b/drivers/net/wireless/ath/ath11k/cfr.h
@@ -60,6 +60,7 @@ struct ath11k_cfr {
 	struct ath11k_look_up_table *lut;
 	struct dentry *enable_cfr;
 	struct dentry *cfr_unassoc;
+	struct rchan *rfs_cfr_capture;
 	u8 cfr_enabled_peer_cnt;
 	u32 lut_num;
 	u64 tx_evt_cnt;
-- 
2.34.1


