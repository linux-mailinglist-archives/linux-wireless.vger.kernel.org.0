Return-Path: <linux-wireless+bounces-21630-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C80A91452
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 08:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3193318898C7
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 06:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A238A1DDA0C;
	Thu, 17 Apr 2025 06:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kwn42MhW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A2E21517D
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 06:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744872772; cv=none; b=milFIZ7m8DcDcdbQA3im0/elAh0+MNVOfq/16tuPhIo3v3fVe+KWwP4/pZShPbdInoR7gtM8Tc6WEZZrZS7J4TS4BLnqX1olNRh4P5wz52WVRHpLvCvcultCwcz/x8qGw3ljndPGYWrsNaChCgA+Y1BqgQ4hDsfs1C6iyz17nHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744872772; c=relaxed/simple;
	bh=DpTptF2AjRaaZtOaOcw6bgxh6D/54Ht9F3rAczlTW+k=;
	h=From:To:Cc:Subject:Date:Message-Id; b=uLTusWFohspFisUHtFEjhwfPfA9qFbx5vTxaK9vLpSeN1fWOalJhTsHDTgg75R4VI0++ckS931lcehPaNS+fcGPvJdfKAtQOpoiu94Cwq/m7oqB8lrwwjztoRIhrfmb2GtVm2ZvrB/0YllKbSwwlHijMkQj8CmF/wk4CUxrlvm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Kwn42MhW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H5lEIj030164
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 06:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=y1GQHy6cqMBQ
	hYP1koW6prJaZyjnNx0mkx1JtvKBy0I=; b=Kwn42MhWBxFMkX3PDzJ+qmap+tO0
	Zm9IJZ43DdHvNF8UD0hJYFPDzfxMOqEi1v4820CpnVxBAzQvnJ1foABiw6EIi63q
	YP1pqX3cBDOc6e6hN2KwGYXWDNmAheLVI5vLFyrKhDDqs5f7bTz7bQMEuzi1C9lE
	mO/KFkN1Y0SKkziO+qMoDiOYK2LZ7r9xAoWoEdZJ2BU+xnSv4j0LqbQloAq93qRe
	p7pg8PDQBPU/xgNpB+/Rzv+7gQgbi5cH55xjTdXuWdwu3ngo02CXCLsXB/ifDW6w
	NKowe7OoqpRhb/wv+nUkxAAtIn5x07P48+CwdUa9/nQqCss4ax4CyY4XWA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yf69wxwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 06:52:49 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2242ce15cc3so5319375ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 23:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744872768; x=1745477568;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1GQHy6cqMBQhYP1koW6prJaZyjnNx0mkx1JtvKBy0I=;
        b=WHwl6GCpRi0UirbYDQLPRKHpcBX5Xb3OuQSemmH8HCcqQTH3krQOiTt5XJg4l9rwV4
         knU7yLTtbi2m4TS+CvYK6CAdBGsGeGSQETy2Q2olEZpa7gmJsyz2/v0kuZKUngFbcnDC
         ZLALna7DX6iPJxJKMYA1U7Oqh85KiCAh2ajwIzj7nvJ7SwDwxsCdOTGGXk1ot+9Ohw+4
         ZVf76S0PIL1EspPzvRaX3kclCzyk1eUVk00XNiGuHR6gnwpVclpQqQ6MGWTFwXF59FWH
         t0B93E9v1eRum0WaZUzhngW4qGJTOlkA+768TZ9sVOe9qWQ0J3GhxQFEETVVWuWRS/+q
         D6kw==
X-Gm-Message-State: AOJu0YyOHNrorS9km+zG0EWBafR4D0olgUEblO8SyXYc+ieT7D3LhmzR
	bBsg942yAXa/dkXCDyAHn9ZRcpLF/7pbPBtNXxPopOoaMroBFZdAbpUF2Ng5HxmucOikl4T1y03
	kZVET6cQ7hcIz/gzz6PursPdrAKMBNpa5lBNqlUBiyCzp8GZXgvaM+rolRgis4EQhmnrW8ipPXg
	==
X-Gm-Gg: ASbGncvxQrXHGfdH85MjJRydWVnI1CpowbbE1yJOVGlS1jaNXY5igK7McVVBzGbnhMj
	ZFDqeSOPjja6ZyHEB5EZLbBARy+Evt5AUj7ydJFsIk8aquxYyRV+mHZuneMbeZZJM0VRvjj2w9G
	5SQ/0X8riiJQ+wlI5p0Llth4//48ct+cu85tHv1Q9sdpBjgYIL2eBNZFmDFKpKEedKeLJVRIAUd
	TuBWWc9yQgWDwtO3pJobnbXPtb+gwGLq7rWQguqinXdr6BTgW9I71CAwv+hu7beQRWy02vxlRin
	GAzb8RVuKgL/GxwlfGwg9ZNUQFKBZhAnXITn3ISUHu/+B3NmuauSRBmC/xrEffexhTmeEHqOwUk
	bSoH66W+MJBZXRnfSpzpqSrUjJYkxkMrplJhGVZBWnGRtWQ==
X-Received: by 2002:a17:902:c40f:b0:223:66a1:4503 with SMTP id d9443c01a7336-22c358ead7cmr60265655ad.30.1744872767613;
        Wed, 16 Apr 2025 23:52:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLt4QsJ2nKuq0fjcgEugFnOrWyESmkX/yGp1OXSXb7VG+MSohudXSATxpF0u28pesxfhNA8Q==
X-Received: by 2002:a17:902:c40f:b0:223:66a1:4503 with SMTP id d9443c01a7336-22c358ead7cmr60264875ad.30.1744872766054;
        Wed, 16 Apr 2025 23:52:46 -0700 (PDT)
Received: from che-siroccolnx03.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33ef0fbasm25966145ad.19.2025.04.16.23.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 23:52:45 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Dinesh Karthikeyan <quic_dinek@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH ath-next v2] wifi: ath12k: Add support to simulate firmware crash
Date: Thu, 17 Apr 2025 12:22:37 +0530
Message-Id: <20250417065237.2507613-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-GUID: MdoHq1zHneWxv95YOfeQZDBvcRsFT-Mp
X-Authority-Analysis: v=2.4 cv=JNc7s9Kb c=1 sm=1 tr=0 ts=6800a541 cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=639jykY1kkF2cMweqlIA:9 a=1OuFwYUASf3TG4hYMiVC:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: MdoHq1zHneWxv95YOfeQZDBvcRsFT-Mp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170052
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

From: Dinesh Karthikeyan <quic_dinek@quicinc.com>

Add debugfs support to simulate firmware crash to test firmware restart.

Usage:
-----
echo assert > /sys/kernel/debug/ath12k/pci-0000\:58\:00.0/simulate_fw_crash

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
---

v2: Jeff gave ACK for v1 patch and later conflict was seen with latest TOT.
    Hence, rebased this patch on latest TOT.

 drivers/net/wireless/ath/ath12k/debugfs.c | 76 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/debugfs.h |  5 ++
 drivers/net/wireless/ath/ath12k/mac.c     |  1 +
 3 files changed, 82 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
index bab7be9c5a38..1f0983c33885 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs.c
@@ -33,6 +33,82 @@ static const struct file_operations fops_simulate_radar = {
 	.open = simple_open
 };
 
+static ssize_t ath12k_read_simulate_fw_crash(struct file *file,
+					     char __user *user_buf,
+					     size_t count, loff_t *ppos)
+{
+	const char buf[] =
+		"To simulate firmware crash write one of the keywords to this file:\n"
+		"`assert` - send WMI_FORCE_FW_HANG_CMDID to firmware to cause assert.\n";
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, strlen(buf));
+}
+
+static ssize_t
+ath12k_write_simulate_fw_crash(struct file *file,
+			       const char __user *user_buf,
+			       size_t count, loff_t *ppos)
+{
+	struct ath12k_base *ab = file->private_data;
+	struct ath12k_pdev *pdev;
+	struct ath12k *ar = NULL;
+	char buf[32] = {0};
+	int i, ret;
+	ssize_t rc;
+
+	/* filter partial writes and invalid commands */
+	if (*ppos != 0 || count >= sizeof(buf) || count == 0)
+		return -EINVAL;
+
+	rc = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, user_buf, count);
+	if (rc < 0)
+		return rc;
+
+	/* drop the possible '\n' from the end */
+	if (buf[*ppos - 1] == '\n')
+		buf[*ppos - 1] = '\0';
+
+	for (i = 0; i < ab->num_radios; i++) {
+		pdev = &ab->pdevs[i];
+		ar = pdev->ar;
+		if (ar)
+			break;
+	}
+
+	if (!ar)
+		return -ENETDOWN;
+
+	if (!strcmp(buf, "assert")) {
+		ath12k_info(ab, "simulating firmware assert crash\n");
+		ret = ath12k_wmi_force_fw_hang_cmd(ar,
+						   ATH12K_WMI_FW_HANG_ASSERT_TYPE,
+						   ATH12K_WMI_FW_HANG_DELAY);
+	} else {
+		return -EINVAL;
+	}
+
+	if (ret) {
+		ath12k_warn(ab, "failed to simulate firmware crash: %d\n", ret);
+		return ret;
+	}
+
+	return count;
+}
+
+static const struct file_operations fops_simulate_fw_crash = {
+	.read = ath12k_read_simulate_fw_crash,
+	.write = ath12k_write_simulate_fw_crash,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+void ath12k_debugfs_pdev_create(struct ath12k_base *ab)
+{
+	debugfs_create_file("simulate_fw_crash", 0600, ab->debugfs_soc, ab,
+			    &fops_simulate_fw_crash);
+}
+
 static ssize_t ath12k_write_tpc_stats_type(struct file *file,
 					   const char __user *user_buf,
 					   size_t count, loff_t *ppos)
diff --git a/drivers/net/wireless/ath/ath12k/debugfs.h b/drivers/net/wireless/ath/ath12k/debugfs.h
index 74a255a27886..ebef7dace344 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs.h
@@ -16,6 +16,7 @@ void ath12k_debugfs_fw_stats_process(struct ath12k *ar,
 				     struct ath12k_fw_stats *stats);
 void ath12k_debugfs_op_vif_add(struct ieee80211_hw *hw,
 			       struct ieee80211_vif *vif);
+void ath12k_debugfs_pdev_create(struct ath12k_base *ab);
 
 static inline bool ath12k_debugfs_is_extd_rx_stats_enabled(struct ath12k *ar)
 {
@@ -144,6 +145,10 @@ static inline void ath12k_debugfs_op_vif_add(struct ieee80211_hw *hw,
 					     struct ieee80211_vif *vif)
 {
 }
+
+static inline void ath12k_debugfs_pdev_create(struct ath12k_base *ab)
+{
+}
 #endif /* CONFIG_ATH12K_DEBUGFS */
 
 #endif /* _ATH12K_DEBUGFS_H_ */
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index dfc803879028..c5b0ddb5ed85 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -11976,6 +11976,7 @@ int ath12k_mac_allocate(struct ath12k_hw_group *ag)
 		if (!ab)
 			continue;
 
+		ath12k_debugfs_pdev_create(ab);
 		ath12k_mac_set_device_defaults(ab);
 		total_radio += ab->num_radios;
 	}

base-commit: 176f3009ae598d0523b267db319fe16f69577231
-- 
2.17.1


