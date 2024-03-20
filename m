Return-Path: <linux-wireless+bounces-4998-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D289B88163F
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 18:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62084B239C6
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 17:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927DD6A010;
	Wed, 20 Mar 2024 17:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pnjKGp8h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD51469DE8
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 17:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710954809; cv=none; b=JaCFhnzIhE+vH3AebHGHvzNt6phCqu8C61p7k4ig/AYV/nBVrWt/HAprcNYUjoIbcf8H+cE/iN7WyaKTrCXWQIlY1xczsJQGYhCk94g0BpoDelQKm/y4/Ki22xiGaKxyoWcvuEm/KTawX2yz+mx4P7Sy7Ib3/t/BA6cH6YQqskg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710954809; c=relaxed/simple;
	bh=toEHmX7Y1iYYggglyJ97/XD1NW2HUScLEX17BAhQRMk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XfgGZL4vCZw8vkUGdwY9nGOsETVOEoxHDlO3UfDYZkUPwRM+aRndcmPSw3a2or29SKcKH1jr0UqRtwMgFG+qERkE5j8AZVq2KEb3g3mOpYakQECUhqOB9oJ9I93i0jhkjkChokmOVZW139y9a8TVddr8CuntWDSYu+Qc9k+Qxm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pnjKGp8h; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KEllxN026329;
	Wed, 20 Mar 2024 17:13:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=CTXBCtf
	XCxYc611xL35TE8CazjY9B/HsC2l12V8lW5Y=; b=pnjKGp8h47f0UDYa8RyM+Z0
	knB+qzTSYB/IIrD1NOemqUp3HuLVK2TDL0Rtw57usbq0PTswMf83/4G2Gqo9YZ90
	wtd1UAZY751QeYiJmqsF4PcmVDNDAbdTzJLn5ow8w0297A8+E0r98E/V6DGK82QP
	wvJzuPJXG8/wuGErnMCbawSv31/dpM5fHp7W2+6gLqf7ZWNJSM9EzNBhz1Xv95T1
	OLJ5b5CSnoM1O7z3kQI1TxL9HAZkfUTy5SjXDkZBvLrru+ybWvKvac2hhbOze0Zl
	IHOQp2nxNHSpQpxET+VmPQHQC/FHN0rzGHvXKTEfiZ2R4VyrEr/expUqmK0Eo5Q=
	=
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyy76gsv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 17:13:23 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 42KHDLNs028208;
	Wed, 20 Mar 2024 17:13:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3ww4gm7num-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 17:13:21 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42KHDKfj028195;
	Wed, 20 Mar 2024 17:13:20 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-rgnanase-blr.qualcomm.com [10.190.106.79])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 42KHDKJ0028193
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 17:13:20 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 2378837)
	id 12ACF41138; Wed, 20 Mar 2024 22:43:20 +0530 (+0530)
From: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Subject: [PATCH 2/2] wifi: ath12k: Add radar simulation debugfs support
Date: Wed, 20 Mar 2024 22:43:05 +0530
Message-Id: <20240320171305.655288-3-quic_rgnanase@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320171305.655288-1-quic_rgnanase@quicinc.com>
References: <20240320171305.655288-1-quic_rgnanase@quicinc.com>
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
X-Proofpoint-GUID: Ge9-l4I6LyKxUxwtrhjn0g1Vs7f6n81I
X-Proofpoint-ORIG-GUID: Ge9-l4I6LyKxUxwtrhjn0g1Vs7f6n81I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403200138

Create dfs_simulate_radar debugfs in ath12k debugfs directory.

Usage:
echo 1 > /sys/kernel/debug/ath12k/pci-0000:06:00.0/mac0/dfs_simulate_radar

This debugfs helps user to simulate RADAR interference in run time.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/debugfs.c | 29 +++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
index 65f3c8bf3f10..8d8ba951093b 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs.c
@@ -7,6 +7,29 @@
 #include "core.h"
 #include "debugfs.h"
 
+static ssize_t ath12k_write_simulate_radar(struct file *file,
+					   const char __user *user_buf,
+					   size_t count, loff_t *ppos)
+{
+	struct ath12k *ar = file->private_data;
+	int ret;
+
+	mutex_lock(&ar->conf_mutex);
+	ret = ath12k_wmi_simulate_radar(ar);
+	if (ret)
+		goto exit;
+
+	ret = count;
+exit:
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
+}
+
+static const struct file_operations fops_simulate_radar = {
+	.write = ath12k_write_simulate_radar,
+	.open = simple_open
+};
+
 void ath12k_debugfs_soc_create(struct ath12k_base *ab)
 {
 	bool dput_needed;
@@ -58,4 +81,10 @@ void ath12k_debugfs_register(struct ath12k *ar)
 	/* Create a symlink under ieee80211/phy* */
 	scnprintf(buf, sizeof(buf), "../../ath12k/%pd2", ar->debug.debugfs_pdev);
 	debugfs_create_symlink("ath12k", hw->wiphy->debugfsdir, buf);
+
+	if (ar->mac.sbands[NL80211_BAND_5GHZ].channels) {
+		debugfs_create_file("dfs_simulate_radar", 0200,
+				    ar->debug.debugfs_pdev, ar,
+				    &fops_simulate_radar);
+	}
 }
-- 
2.34.1


