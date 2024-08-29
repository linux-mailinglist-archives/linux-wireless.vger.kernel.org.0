Return-Path: <linux-wireless+bounces-12204-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC705963EE8
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 10:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B8C61F23217
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 08:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA5B189B9D;
	Thu, 29 Aug 2024 08:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pTnEpfHp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A993915C13B
	for <linux-wireless@vger.kernel.org>; Thu, 29 Aug 2024 08:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724921067; cv=none; b=QQKYN3jbm9tk/Oj90Qh2VE7r3ChGQFHncuScKgw+5jVMaELi/yUuFr3WFs7NMktOEIkVWHzOIUd8pdNjH6BufMsytMnLf5Uc0Mo1WggKhj8Xm3Qb5SnXPTMrJRs++GWHf1zgfaFVvrGB1HzN+OQkxhRvlyMlrlVXLaYJnljzoy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724921067; c=relaxed/simple;
	bh=M9SyX15b88tgoaAGd3OsBOde6ll7WVlDzb1YmLdndXs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s4qp2EVHXtowDvobaQ1JtG2GHX7ukT7D7/fxeSroITmr6WtZWeIbUwJik+zPBzztC0kmcyOLqEsKQlnIG9wzZqfUd+NwAoSVYSLeBLEuI0DP8364XYnLR0NA6sEJg289HtQ1iTLH/p7hr2HiElNTBjxTfGy5FvnVnw4AUqVdDFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pTnEpfHp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47T8IoPO003416;
	Thu, 29 Aug 2024 08:44:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=XLcLOdG8Ov8LVUAi8KltLGD30AHzlsYsx2K
	gqDQrB2U=; b=pTnEpfHpMt5zZjzrNb4XMSk87Wjw8rMDFievZphZr7uUQzoUyi6
	3MDUYNWl86dKlt4E+AL7guj6O5pZpXuhIR/PjOwDSB1zb293kfobfVIhlywIvcG+
	HJYjx3d7lBx43HI3Dmr/jk+LEIQBFXg4QR6L1nP52Xi7jg8xCVONsmUKgHeZ9KvE
	O1xinjOqsjB7SpxpynVQvgb7QBunJaLJ2NPcgtW15+QmvEOTP++eOJGBrPh4lxmf
	aasSVdTl0zFB4Twl0VbsboD4Z1kmcaVKzZO2KyLE2hBHJr0IVvPbmOscGuMFgbCa
	/vCqp7ET4z7XgOlpT4oa5/RW/OI72V9tVTw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419putvk4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 08:44:21 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 47T8iIWh008418;
	Thu, 29 Aug 2024 08:44:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4178kmc8y2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 08:44:18 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47T8iImK008412;
	Thu, 29 Aug 2024 08:44:18 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-rgnanase-blr.qualcomm.com [10.190.106.79])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 47T8iIY6008411
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 08:44:18 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 2378837)
	id 58B5741144; Thu, 29 Aug 2024 14:14:17 +0530 (+0530)
From: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Dinesh Karthikeyan <quic_dinek@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Subject: [PATCH] wifi: ath12k: Add support to simulate firmware crash
Date: Thu, 29 Aug 2024 14:14:11 +0530
Message-Id: <20240829084411.3521261-1-quic_rgnanase@quicinc.com>
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
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hyrjN-el_Izze-4sz97aOYT2svDcLAL8
X-Proofpoint-GUID: hyrjN-el_Izze-4sz97aOYT2svDcLAL8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_02,2024-08-29_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0
 clxscore=1011 mlxscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408290064

From: Dinesh Karthikeyan <quic_dinek@quicinc.com>

Add debugfs support to simulate firmware crash to test firmware restart.

Usage:
-----
echo assert > /sys/kernel/debug/ath12k/pci-0000\:58\:00.0/simulate_fw_crash

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
---
Depends-On: [PATCH v5] wifi: ath12k: Add firmware coredump collection support
Link: https://lore.kernel.org/linux-wireless/f77ed82f-299b-4f99-bc83-39c053b8042b@quicinc.com/
---
 drivers/net/wireless/ath/ath12k/debugfs.c | 76 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/debugfs.h |  4 ++
 drivers/net/wireless/ath/ath12k/mac.c     |  2 +
 3 files changed, 82 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
index 2a977c36af00..4d1cd4d5e3df 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs.c
@@ -6,6 +6,7 @@
 
 #include "core.h"
 #include "debugfs.h"
+#include "debug.h"
 #include "debugfs_htt_stats.h"
 
 static ssize_t ath12k_write_simulate_radar(struct file *file,
@@ -31,6 +32,81 @@ static const struct file_operations fops_simulate_radar = {
 	.open = simple_open
 };
 
+static ssize_t ath12k_read_simulate_fw_crash(struct file *file,
+					     char __user *user_buf,
+					     size_t count, loff_t *ppos)
+{
+	const char buf[] =
+		 "To simulate firmware crash write one of the keywords to this file:\n"
+		 "`assert` - send WMI_FORCE_FW_HANG_CMDID to firmware to cause assert.\n";
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, strlen(buf));
+}
+
+static ssize_t ath12k_write_simulate_fw_crash(struct file *file,
+					      const char __user *user_buf,
+					      size_t count, loff_t *ppos)
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
 void ath12k_debugfs_soc_create(struct ath12k_base *ab)
 {
 	bool dput_needed;
diff --git a/drivers/net/wireless/ath/ath12k/debugfs.h b/drivers/net/wireless/ath/ath12k/debugfs.h
index 8d64ba03aa9a..4b59906c03d6 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs.h
@@ -12,6 +12,7 @@ void ath12k_debugfs_soc_create(struct ath12k_base *ab);
 void ath12k_debugfs_soc_destroy(struct ath12k_base *ab);
 void ath12k_debugfs_register(struct ath12k *ar);
 void ath12k_debugfs_unregister(struct ath12k *ar);
+void ath12k_debugfs_pdev_create(struct ath12k_base *ab);
 #else
 static inline void ath12k_debugfs_soc_create(struct ath12k_base *ab)
 {
@@ -29,6 +30,9 @@ static inline void ath12k_debugfs_unregister(struct ath12k *ar)
 {
 }
 
+static inline void ath12k_debugfs_pdev_create(struct ath12k_base *ab)
+{
+}
 #endif /* CONFIG_ATH12K_DEBUGFS */
 
 #endif /* _ATH12K_DEBUGFS_H_ */
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 137394c36460..8947ca308dbb 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -9347,6 +9347,8 @@ int ath12k_mac_register(struct ath12k_base *ab)
 	if (test_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags))
 		return 0;
 
+	ath12k_debugfs_pdev_create(ab);
+
 	/* Initialize channel counters frequency value in hertz */
 	ab->cc_freq_hz = 320000;
 	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS)) - 1;
-- 
2.34.1


