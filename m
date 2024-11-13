Return-Path: <linux-wireless+bounces-15227-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A329C66F3
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 02:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60778B24BA5
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 01:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC05C70810;
	Wed, 13 Nov 2024 01:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V8wkT3ay"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA2443ABC
	for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 01:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731463010; cv=none; b=rCMLljYXJqz5bKcRf/K9mHqAwUwxMVDmIhLCjp3xIdrkH71H+QDqXWHf0PA6bYQj3R67Pqvg4gcuaTQioPDO2ujqKXpp991pXvDwc+8kvmZpYzFl4I8enn6rGhd6lBY8eVrwuSTcgibZ/t/gN8P9fQTheFrhVDk6GOLoUqaQWr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731463010; c=relaxed/simple;
	bh=PexqryPdNOwBmVeHF/i89Vemf04eNPhKpQU1V9KvFHA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F6HEKasao7IpGaUE+kbFwXW50yM4QsxuGGQ6yleKLtCWlTk3XKW/T7+e96aUmHx4cLqLNKNp4/kDMAdE4phzVp9ZFqq5vj46mXIxCYy01ah+4C+LX00+F7FgCVpe94mZmExP6Vfa5IWlwnwErtCTrh5V8ArnSowhy92H3HrzZdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V8wkT3ay; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACMRUbn009037;
	Wed, 13 Nov 2024 01:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z/guE2Txl9g7USKk9obvJrrRjTnZHuq5paAdFOJhBLE=; b=V8wkT3aysFk2RHuX
	6XJWmJeUcijRX3d+cSRiKpxXPawqQcbED/zLMLaIpqk5jMH3QHn92/xS80rjw7Ov
	OkQYh7avrKZ1lds1irAvF+K3g+RSQx2MizfFJEL7xES/UYcxDcgk1/XLh+B00Bx+
	0M0/a6luuSQUTCLN22nN7OZyE72/YmaRLdk98FsfxACBehVYDgF+5tRI9Ziel5jm
	6CcmaXnVyGEBKfY4V2OBAp+qfio2+Mbd4Sh+XdQMhVux+IxvNcRK+ralLL5c+8Ni
	AL+CZbajYQ2lKXwX3yWFVbqSeF+7gzkm3qLkFDB4APreCA7OH4sS7HZoZc7u8GnV
	wry56A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42uwt5kb1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 01:56:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AD1ukO9028156
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 01:56:46 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 12 Nov 2024 17:56:45 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH 2/6] wifi: ath11k: don't use static variables in ath11k_debugfs_fw_stats_process()
Date: Wed, 13 Nov 2024 09:56:27 +0800
Message-ID: <20241113015631.3105-3-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241113015631.3105-1-quic_bqiang@quicinc.com>
References: <20241113015631.3105-1-quic_bqiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OWBuSfc46Cu-8VEQjws6H25WNDWjG6wa
X-Proofpoint-ORIG-GUID: OWBuSfc46Cu-8VEQjws6H25WNDWjG6wa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411130016

Currently ath11k_debugfs_fw_stats_process() is using static variables to count
firmware stat events. Taking num_vdev as an example, if for whatever reason (
say ar->num_started_vdevs is 0 or firmware bug etc.) the following condition

	(++num_vdev) == total_vdevs_started

is not met, is_end is not set thus num_vdev won't be cleared. Next time when
firmware stats is requested again, even if everything is working fine, we will
fail due to the condition above will never be satisfied.

The same applies to num_bcn as well.

Change to use non-static counters so that we have a chance to clear them each
time firmware stats is requested. Currently only ath11k_fw_stats_request() and
ath11k_debugfs_fw_stats_request() are requesting firmware stats, so clear
counters there.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37

Fixes: da3a9d3c1576 ("ath11k: refactor debugfs code into debugfs.c")
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.h    |  2 ++
 drivers/net/wireless/ath/ath11k/debugfs.c | 16 +++++++---------
 drivers/net/wireless/ath/ath11k/mac.c     |  2 ++
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 09c37e19a168..35d2eee2f91f 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -599,6 +599,8 @@ struct ath11k_fw_stats {
 	struct list_head pdevs;
 	struct list_head vdevs;
 	struct list_head bcn;
+	u32 num_vdev_recvd;
+	u32 num_bcn_recvd;
 };
 
 struct ath11k_dbg_htt_stats {
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index a5e0f2092da5..fd0d2a057084 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -99,6 +99,8 @@ static void ath11k_debugfs_fw_stats_reset(struct ath11k *ar)
 	ar->fw_stats_done = false;
 	ath11k_fw_stats_pdevs_free(&ar->fw_stats.pdevs);
 	ath11k_fw_stats_vdevs_free(&ar->fw_stats.vdevs);
+	ar->fw_stats.num_vdev_recvd = 0;
+	ar->fw_stats.num_bcn_recvd = 0;
 	spin_unlock_bh(&ar->data_lock);
 }
 
@@ -107,7 +109,6 @@ void ath11k_debugfs_fw_stats_process(struct ath11k *ar, struct ath11k_fw_stats *
 	struct ath11k_base *ab = ar->ab;
 	struct ath11k_pdev *pdev;
 	bool is_end;
-	static unsigned int num_vdev, num_bcn;
 	size_t total_vdevs_started = 0;
 	int i;
 
@@ -132,15 +133,14 @@ void ath11k_debugfs_fw_stats_process(struct ath11k *ar, struct ath11k_fw_stats *
 				total_vdevs_started += ar->num_started_vdevs;
 		}
 
-		is_end = ((++num_vdev) == total_vdevs_started);
+		is_end = ((++ar->fw_stats.num_vdev_recvd) == total_vdevs_started);
 
 		list_splice_tail_init(&stats->vdevs,
 				      &ar->fw_stats.vdevs);
 
-		if (is_end) {
+		if (is_end)
 			ar->fw_stats_done = true;
-			num_vdev = 0;
-		}
+
 		return;
 	}
 
@@ -152,15 +152,13 @@ void ath11k_debugfs_fw_stats_process(struct ath11k *ar, struct ath11k_fw_stats *
 		/* Mark end until we reached the count of all started VDEVs
 		 * within the PDEV
 		 */
-		is_end = ((++num_bcn) == ar->num_started_vdevs);
+		is_end = ((++ar->fw_stats.num_bcn_recvd) == ar->num_started_vdevs);
 
 		list_splice_tail_init(&stats->bcn,
 				      &ar->fw_stats.bcn);
 
-		if (is_end) {
+		if (is_end)
 			ar->fw_stats_done = true;
-			num_bcn = 0;
-		}
 	}
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index e6acbff06749..f147ef960c22 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -9334,6 +9334,8 @@ static int ath11k_fw_stats_request(struct ath11k *ar,
 	spin_lock_bh(&ar->data_lock);
 	ar->fw_stats_done = false;
 	ath11k_fw_stats_pdevs_free(&ar->fw_stats.pdevs);
+	ar->fw_stats.num_vdev_recvd = 0;
+	ar->fw_stats.num_bcn_recvd = 0;
 	spin_unlock_bh(&ar->data_lock);
 
 	reinit_completion(&ar->fw_stats_complete);
-- 
2.25.1


