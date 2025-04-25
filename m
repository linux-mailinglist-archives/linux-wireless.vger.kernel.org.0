Return-Path: <linux-wireless+bounces-22031-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDC4A9BC50
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 03:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05FC1465504
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 01:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946BB35959;
	Fri, 25 Apr 2025 01:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FEF1Lc+K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFE526AEC
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 01:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745544517; cv=none; b=e7zZ8L3vSnKeeapCeiYqkZMofVvcA16++EKq62XdYEO2C29+IJCtdRnoMSdVV85hDBOGt0F4IPZgZ7JZqSs93xUzmdA3atq9fUwEfAjZos4zaSSNdYYPGoP59DfSwv+chpeG14NUBBkQ4S60Xu/myeCZOOlAyoothVFCoIEYynI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745544517; c=relaxed/simple;
	bh=j9gt3X0u0xHc/lWUvdcMNpoJ5LMMZvHMz5UJKbT+XVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=M/lndV/MB5oO+U2KgwS4ZO75tmiCjrAnssLdLm2z+INgazykcUWa2lD03T+qKkfxNl4IXTEU3/Dl0GbDXvDuJpxm+Bn0mwv1FK/7wk1BO5coK7frBnCpgA/Qw6DMJlbjXEJZffSlZx70YwKMn9zx4rkQcDHygs4E8aetnqMsP4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FEF1Lc+K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P17OLx002307
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 01:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=y8q7p7/+7E+t4rVFcsV+1D+7rqxoPitw1YzY0CI1gFw=; b=FE
	F1Lc+K3M9aQYrwt02BXEruPt6ReNbnxutTD8fLzCfxRcOwV5AwsYJvWneiqMaTsm
	Nm3ZI4KL+uAVwZeutrHTe8iPyJ4AVX8n75uW/c7JAHura+vdhHwUlGaX1vx5qI78
	ygtrJPbXnrIQCm2Hu78uBps7RjtJZ+tfNDKXq4WrDGSbdHZhyK3O+CuVsLe46Miy
	vv76rGaBi20CsJJ5aDP/JSxJrvIlMqFh9XgsG1J2rnmxyuK7+EFrNXa63wj2DgoK
	tioUD7iTtWe6K5OvOYAC45C5CF5DOfv18ZsVLKUH9TlIf/J+oAKXwTJYBp52OKtC
	1OUpISwMhpvfBgowOKeg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jgy7aea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 01:28:34 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-308677f7d8cso1545435a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 18:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745544513; x=1746149313;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y8q7p7/+7E+t4rVFcsV+1D+7rqxoPitw1YzY0CI1gFw=;
        b=gwHhkmuY/0T8gFNHkPXKRzxLdTkTidwh7FM13Wmunngmc5SkcAgxL7KnEJ9nV6VdGG
         FdbLmz2GsffFcLwJPxLXC2MaOYVlocs2zIBmkS1UH5siPUm4Yu3E/nx2hiwuJDRih+/7
         RuDRRn4OixTrjcRWJyBig1aHRgKg+cwYv1DMasup8gKfYgNgqm0KG7wsl6D/tzonTeoN
         k5KcUmMXQCqQmgdla6BeCjUn4cKcgQfLirb5vU2fGGhnDI09sOkyHZQdwsBsOWH4pnu9
         Lcjy9ajbtF0DJysJqfmLnjC2EHWbYyMB0+gXc8W/H4sdKpq6DTXiJPnydG5Eg6x5oqUh
         zchw==
X-Gm-Message-State: AOJu0Yw/O+clhx5iiRsyOQbNVeWTGuwX+P84EhMFg9UhSjEZV8vZrkl3
	G1tYEZGtW9E0ojaCRXI5uo7IVvRQl2eFSj+EgiNzdlxio3kcmEQWg0bOMJYOHRcgzxGYGP4WYEC
	5UnwK9+b5y/9e+HAyQT8TUaMmAfYffXgldxF4KI1+EBl4Uyzf1ISbNlAI+njqyCIY5fpc1mAzgw
	==
X-Gm-Gg: ASbGncvUjzN/+CtgC1aUWWkBoQKtpHyOSbcIp5zcpgEg1LYd2Ym885mKJlatp4rHgMX
	bfnUhgN5pbLokUgYRoNDjx/fLwOzTUnkv9gZVT/Xg8VoyVoyXmFQxWzb93MieFGPP88yT+qPrA3
	fJl5N0CZcZrLWzygwQByb3tCV4ipF43JI6mp+YJ24gXKRfPo3dgD/Cua2Rv6KGwfDQu1b3KOZVg
	v0awlVZZFj7n6zf566CNP3q9Z8fAhfKryPqtRfGfE+cazWXKd0dVvvX4nws/kdAV9Ld3yBHOPMS
	/gZn5vaVozVgP5bBzMFvLCs4tH71HJyBQwCFALqGAAgZwJAYwhDf1iLYQlInsZ3OhDuMCofxPco
	Zn5HLwBKqdjMyT8gzXQlpgUarlsR3Rf1vJUn1sL6ySpCGow==
X-Received: by 2002:a17:90b:37ce:b0:2fe:9783:afd3 with SMTP id 98e67ed59e1d1-309f7d9a9c4mr1083968a91.2.1745544512573;
        Thu, 24 Apr 2025 18:28:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEeBi9iuqdUjtRdn47ocOfM8w0ewxFwFyL96EUBBHyUrpBsm2jB08sqM8gpFY2vKQaFlUwIw==
X-Received: by 2002:a17:90b:37ce:b0:2fe:9783:afd3 with SMTP id 98e67ed59e1d1-309f7d9a9c4mr1083925a91.2.1745544511957;
        Thu, 24 Apr 2025 18:28:31 -0700 (PDT)
Received: from hu-nithp-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef03bb1asm2160107a91.7.2025.04.24.18.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 18:28:31 -0700 (PDT)
From: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Vinith Kumar R <quic_vinithku@quicinc.com>,
        Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Subject: [PATCH ath-next 3/3] wifi: ath12k: print device dp stats in debugfs
Date: Fri, 25 Apr 2025 06:58:02 +0530
Message-Id: <20250425012802.698914-4-nithyanantham.paramasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250425012802.698914-1-nithyanantham.paramasivam@oss.qualcomm.com>
References: <20250425012802.698914-1-nithyanantham.paramasivam@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDAwOCBTYWx0ZWRfXxBbxyxz9Rsx5 GYMP7lKn7gAdUYBwKtItjczBX9T2veoGzo/90uOiiOwHvvKBqXSMsmSiLzLz8Kq9BIL5TpNMeGJ F4q/RMGGjHH/0P+I3zeS3c3rEe1Qs8cXRDA866VhEQZikDfLeSLN3U2ix1TVPJPx9pt96SvK6GV
 4MkmSyxPISf4X+oWExVGc63tuo+MOzsn1lUbXvpG1ysYMDjudKgER3G4ZcwPLsbpGJUyWtxm7ic QRGroP0QjijbRmfS9Vhxl0Juqz16hKpXUqaev9cD3KaD82ILKms8BC5HkuQNCRl0asY7JyNTXV9 D10myEf4SiSd71jFfbdqVX8qhz8XbfXWSEw+cq2b8w083fYAZsaGmLrzZpMp80BZWdfWMbpSb+N
 26eA6CQAbcuhO8XQrPIu3ZY3lKquZgK5xqOw9UzlqVdaCCXTTacnJ704gy4A5Moel7ugr6Xq
X-Proofpoint-GUID: J02pjr0rhubwJ2JesV74UTw8HnTFwBah
X-Proofpoint-ORIG-GUID: J02pjr0rhubwJ2JesV74UTw8HnTFwBah
X-Authority-Analysis: v=2.4 cv=M5VNKzws c=1 sm=1 tr=0 ts=680ae542 cx=c_pps a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=PwApztsl_qjy-5aDgfcA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 clxscore=1015
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250008
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

From: Vinith Kumar R <quic_vinithku@quicinc.com>

Print the data path related device specific stats in debugfs.
These device_dp_stats are exposed in the ath12k debugfs directory.

Output of device_dp_stats:
root@CDCWLEX0799743-LIN:/home/qctest#
cat /sys/kernel/debug/ath12k/pci-0000\:58\:00.0/device_dp_stats
DEVICE RX STATS:

err ring pkts: 0
Invalid RBM: 0

RXDMA errors:
Overflow: 0
MPDU len: 0
FCS: 0
Decrypt: 0
TKIP MIC: 0
Unencrypt: 0
MSDU len: 0
MSDU limit: 0
WiFi parse: 0
AMSDU parse: 0
SA timeout: 0
DA timeout: 0
Flow timeout: 0
Flush req: 0
AMSDU frag: 0
Multicast echo: 0
AMSDU mismatch: 0
Unauth WDS: 0
AMSDU or WDS: 0

REO errors:
Desc addr zero: 0
Desc inval: 0
AMPDU in non BA: 0
Non BA dup: 0
BA dup: 0
Frame 2k jump: 0
BAR 2k jump: 0
Frame OOR: 155
BAR OOR: 0
No BA session: 0
Frame SN equal SSN: 0
PN check fail: 0
2k err: 0
PN err: 0
Desc blocked: 0

HAL REO errors:
ring0: 0
ring1: 0
ring2: 0
ring3: 0
ring4: 0
ring5: 0
ring6: 0
ring7: 0

DEVICE TX STATS:

TCL Ring Full Failures:
ring0: 0
ring1: 0
ring2: 0
ring3: 0

Misc Transmit Failures: 0

tx_wbm_rel_source: 0:986 1:0 2:0 3:57 4:0

tqm_rel_reason: 0:1043 1:0 2:0 3:0 4:0 5:0 6:0 7:0 8:0 9:0 10:0 11:0 12:0 13:0 14:0

fw_tx_status: 0:57 1:0 2:0 3:0 4:0 5:0 6:0

tx_enqueued: 0:329 1:145 2:464 3:105

tx_completed: 0:329 1:145 2:464 3:105

radio0 tx_pending: 0

REO Rx Received:
Ring1:  0:201   1:0     2:0
Ring2:  0:0     1:0     2:0
Ring3:  0:6152  1:0     2:0
Ring4:  0:9     1:0     2:0
Ring5:  0:0     1:0     2:0
Ring6:  0:0     1:0     2:0
Ring7:  0:0     1:0     2:0
Ring8:  0:0     1:0     2:0

Rx WBM REL SRC Errors:
TQM:    0:0     1:0     2:0
Rxdma:  0:0     1:0     2:0
Reo:    0:155   1:0     2:0
FW:     0:0     1:0     2:0
SW:     0:0     1:0     2:0

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Vinith Kumar R <quic_vinithku@quicinc.com>
Signed-off-by: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.c    |   2 +
 drivers/net/wireless/ath/ath12k/debugfs.c | 199 +++++++++++++++++++++-
 2 files changed, 195 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 2cfeb853289d..5203d94c8b10 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -789,6 +789,8 @@ static int ath12k_core_soc_create(struct ath12k_base *ab)
 		goto err_qmi_deinit;
 	}
 
+	ath12k_debugfs_pdev_create(ab);
+
 	return 0;
 
 err_qmi_deinit:
diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
index 1f0983c33885..dd624d73b8b2 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs.c
@@ -103,12 +103,6 @@ static const struct file_operations fops_simulate_fw_crash = {
 	.llseek = default_llseek,
 };
 
-void ath12k_debugfs_pdev_create(struct ath12k_base *ab)
-{
-	debugfs_create_file("simulate_fw_crash", 0600, ab->debugfs_soc, ab,
-			    &fops_simulate_fw_crash);
-}
-
 static ssize_t ath12k_write_tpc_stats_type(struct file *file,
 					   const char __user *user_buf,
 					   size_t count, loff_t *ppos)
@@ -1027,6 +1021,199 @@ void ath12k_debugfs_op_vif_add(struct ieee80211_hw *hw,
 			    &ath12k_fops_link_stats);
 }
 
+static ssize_t ath12k_debugfs_dump_device_dp_stats(struct file *file,
+						   char __user *user_buf,
+						   size_t count, loff_t *ppos)
+{
+	struct ath12k_base *ab = file->private_data;
+	struct ath12k_device_dp_stats *device_stats = &ab->device_stats;
+	int len = 0, i, j, ret;
+	struct ath12k *ar;
+	const int size = 4096;
+	static const char *rxdma_err[HAL_REO_ENTR_RING_RXDMA_ECODE_MAX] = {
+		[HAL_REO_ENTR_RING_RXDMA_ECODE_OVERFLOW_ERR] = "Overflow",
+		[HAL_REO_ENTR_RING_RXDMA_ECODE_MPDU_LEN_ERR] = "MPDU len",
+		[HAL_REO_ENTR_RING_RXDMA_ECODE_FCS_ERR] = "FCS",
+		[HAL_REO_ENTR_RING_RXDMA_ECODE_DECRYPT_ERR] = "Decrypt",
+		[HAL_REO_ENTR_RING_RXDMA_ECODE_TKIP_MIC_ERR] = "TKIP MIC",
+		[HAL_REO_ENTR_RING_RXDMA_ECODE_UNECRYPTED_ERR] = "Unencrypt",
+		[HAL_REO_ENTR_RING_RXDMA_ECODE_MSDU_LEN_ERR] = "MSDU len",
+		[HAL_REO_ENTR_RING_RXDMA_ECODE_MSDU_LIMIT_ERR] = "MSDU limit",
+		[HAL_REO_ENTR_RING_RXDMA_ECODE_WIFI_PARSE_ERR] = "WiFi parse",
+		[HAL_REO_ENTR_RING_RXDMA_ECODE_AMSDU_PARSE_ERR] = "AMSDU parse",
+		[HAL_REO_ENTR_RING_RXDMA_ECODE_SA_TIMEOUT_ERR] = "SA timeout",
+		[HAL_REO_ENTR_RING_RXDMA_ECODE_DA_TIMEOUT_ERR] = "DA timeout",
+		[HAL_REO_ENTR_RING_RXDMA_ECODE_FLOW_TIMEOUT_ERR] = "Flow timeout",
+		[HAL_REO_ENTR_RING_RXDMA_ECODE_FLUSH_REQUEST_ERR] = "Flush req",
+		[HAL_REO_ENTR_RING_RXDMA_ECODE_AMSDU_FRAG_ERR] = "AMSDU frag",
+		[HAL_REO_ENTR_RING_RXDMA_ECODE_MULTICAST_ECHO_ERR] = "Multicast echo",
+		[HAL_REO_ENTR_RING_RXDMA_ECODE_AMSDU_MISMATCH_ERR] = "AMSDU mismatch",
+		[HAL_REO_ENTR_RING_RXDMA_ECODE_UNAUTH_WDS_ERR] = "Unauth WDS",
+		[HAL_REO_ENTR_RING_RXDMA_ECODE_GRPCAST_AMSDU_WDS_ERR] = "AMSDU or WDS"};
+
+	static const char *reo_err[HAL_REO_DEST_RING_ERROR_CODE_MAX] = {
+		[HAL_REO_DEST_RING_ERROR_CODE_DESC_ADDR_ZERO] = "Desc addr zero",
+		[HAL_REO_DEST_RING_ERROR_CODE_DESC_INVALID] = "Desc inval",
+		[HAL_REO_DEST_RING_ERROR_CODE_AMPDU_IN_NON_BA] =  "AMPDU in non BA",
+		[HAL_REO_DEST_RING_ERROR_CODE_NON_BA_DUPLICATE] = "Non BA dup",
+		[HAL_REO_DEST_RING_ERROR_CODE_BA_DUPLICATE] = "BA dup",
+		[HAL_REO_DEST_RING_ERROR_CODE_FRAME_2K_JUMP] = "Frame 2k jump",
+		[HAL_REO_DEST_RING_ERROR_CODE_BAR_2K_JUMP] = "BAR 2k jump",
+		[HAL_REO_DEST_RING_ERROR_CODE_FRAME_OOR] = "Frame OOR",
+		[HAL_REO_DEST_RING_ERROR_CODE_BAR_OOR] = "BAR OOR",
+		[HAL_REO_DEST_RING_ERROR_CODE_NO_BA_SESSION] = "No BA session",
+		[HAL_REO_DEST_RING_ERROR_CODE_FRAME_SN_EQUALS_SSN] = "Frame SN equal SSN",
+		[HAL_REO_DEST_RING_ERROR_CODE_PN_CHECK_FAILED] = "PN check fail",
+		[HAL_REO_DEST_RING_ERROR_CODE_2K_ERR_FLAG_SET] = "2k err",
+		[HAL_REO_DEST_RING_ERROR_CODE_PN_ERR_FLAG_SET] = "PN err",
+		[HAL_REO_DEST_RING_ERROR_CODE_DESC_BLOCKED] = "Desc blocked"};
+
+	static const char *wbm_rel_src[HAL_WBM_REL_SRC_MODULE_MAX] = {
+		[HAL_WBM_REL_SRC_MODULE_TQM] = "TQM",
+		[HAL_WBM_REL_SRC_MODULE_RXDMA] = "Rxdma",
+		[HAL_WBM_REL_SRC_MODULE_REO] = "Reo",
+		[HAL_WBM_REL_SRC_MODULE_FW] = "FW",
+		[HAL_WBM_REL_SRC_MODULE_SW] = "SW"};
+
+	char *buf __free(kfree) = kzalloc(size, GFP_KERNEL);
+
+	if (!buf)
+		return -ENOMEM;
+
+	len += scnprintf(buf + len, size - len, "DEVICE RX STATS:\n\n");
+	len += scnprintf(buf + len, size - len, "err ring pkts: %u\n",
+			 device_stats->err_ring_pkts);
+	len += scnprintf(buf + len, size - len, "Invalid RBM: %u\n\n",
+			 device_stats->invalid_rbm);
+	len += scnprintf(buf + len, size - len, "RXDMA errors:\n");
+
+	for (i = 0; i < HAL_REO_ENTR_RING_RXDMA_ECODE_MAX; i++)
+		len += scnprintf(buf + len, size - len, "%s: %u\n",
+				 rxdma_err[i], device_stats->rxdma_error[i]);
+
+	len += scnprintf(buf + len, size - len, "\nREO errors:\n");
+
+	for (i = 0; i < HAL_REO_DEST_RING_ERROR_CODE_MAX; i++)
+		len += scnprintf(buf + len, size - len, "%s: %u\n",
+				 reo_err[i], device_stats->reo_error[i]);
+
+	len += scnprintf(buf + len, size - len, "\nHAL REO errors:\n");
+
+	for (i = 0; i < DP_REO_DST_RING_MAX; i++)
+		len += scnprintf(buf + len, size - len,
+				 "ring%d: %u\n", i,
+				 device_stats->hal_reo_error[i]);
+
+	len += scnprintf(buf + len, size - len, "\nDEVICE TX STATS:\n");
+	len += scnprintf(buf + len, size - len, "\nTCL Ring Full Failures:\n");
+
+	for (i = 0; i < DP_TCL_NUM_RING_MAX; i++)
+		len += scnprintf(buf + len, size - len, "ring%d: %u\n",
+				 i, device_stats->tx_err.desc_na[i]);
+
+	len += scnprintf(buf + len, size - len,
+			 "\nMisc Transmit Failures: %d\n",
+			 atomic_read(&device_stats->tx_err.misc_fail));
+
+	len += scnprintf(buf + len, size - len, "\ntx_wbm_rel_source:");
+
+	for (i = 0; i < HAL_WBM_REL_SRC_MODULE_MAX; i++)
+		len += scnprintf(buf + len, size - len, " %d:%u",
+				 i, device_stats->tx_wbm_rel_source[i]);
+
+	len += scnprintf(buf + len, size - len, "\n");
+
+	len += scnprintf(buf + len, size - len, "\ntqm_rel_reason:");
+
+	for (i = 0; i < MAX_TQM_RELEASE_REASON; i++)
+		len += scnprintf(buf + len, size - len, " %d:%u",
+				 i, device_stats->tqm_rel_reason[i]);
+
+	len += scnprintf(buf + len, size - len, "\n");
+
+	len += scnprintf(buf + len, size - len, "\nfw_tx_status:");
+
+	for (i = 0; i < MAX_FW_TX_STATUS; i++)
+		len += scnprintf(buf + len, size - len, " %d:%u",
+				 i, device_stats->fw_tx_status[i]);
+
+	len += scnprintf(buf + len, size - len, "\n");
+
+	len += scnprintf(buf + len, size - len, "\ntx_enqueued:");
+
+	for (i = 0; i < DP_TCL_NUM_RING_MAX; i++)
+		len += scnprintf(buf + len, size - len, " %d:%u", i,
+				 device_stats->tx_enqueued[i]);
+
+	len += scnprintf(buf + len, size - len, "\n");
+
+	len += scnprintf(buf + len, size - len, "\ntx_completed:");
+
+	for (i = 0; i < DP_TCL_NUM_RING_MAX; i++)
+		len += scnprintf(buf + len, size - len, " %d:%u",
+				 i, device_stats->tx_completed[i]);
+
+	len += scnprintf(buf + len, size - len, "\n");
+
+	for (i = 0; i < ab->num_radios; i++) {
+		ar = ath12k_mac_get_ar_by_pdev_id(ab, DP_SW2HW_MACID(i));
+		if (ar) {
+			len += scnprintf(buf + len, size - len,
+					"\nradio%d tx_pending: %u\n", i,
+					atomic_read(&ar->dp.num_tx_pending));
+		}
+	}
+
+	len += scnprintf(buf + len, size - len, "\nREO Rx Received:\n");
+
+	for (i = 0; i < DP_REO_DST_RING_MAX; i++) {
+		len += scnprintf(buf + len, size - len, "Ring%d:", i + 1);
+
+		for (j = 0; j < ATH12K_MAX_DEVICES; j++) {
+			len += scnprintf(buf + len, size - len,
+					"\t%d:%u", j,
+					 device_stats->reo_rx[i][j]);
+		}
+
+		len += scnprintf(buf + len, size - len, "\n");
+	}
+
+	len += scnprintf(buf + len, size - len, "\nRx WBM REL SRC Errors:\n");
+
+	for (i = 0; i < HAL_WBM_REL_SRC_MODULE_MAX; i++) {
+		len += scnprintf(buf + len, size - len, "%s:", wbm_rel_src[i]);
+
+		for (j = 0; j < ATH12K_MAX_DEVICES; j++) {
+			len += scnprintf(buf + len,
+					 size - len,
+					 "\t%d:%u", j,
+					 device_stats->rx_wbm_rel_source[i][j]);
+		}
+
+		len += scnprintf(buf + len, size - len, "\n");
+	}
+
+	ret = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+
+	return ret;
+}
+
+static const struct file_operations fops_device_dp_stats = {
+	.read = ath12k_debugfs_dump_device_dp_stats,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+void ath12k_debugfs_pdev_create(struct ath12k_base *ab)
+{
+	debugfs_create_file("simulate_fw_crash", 0600, ab->debugfs_soc, ab,
+			    &fops_simulate_fw_crash);
+
+	debugfs_create_file("device_dp_stats", 0400, ab->debugfs_soc, ab,
+			    &fops_device_dp_stats);
+}
+
 void ath12k_debugfs_soc_create(struct ath12k_base *ab)
 {
 	bool dput_needed;
-- 
2.17.1


