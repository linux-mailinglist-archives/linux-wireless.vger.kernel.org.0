Return-Path: <linux-wireless+bounces-18253-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C47A2436D
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 20:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 840D11646D5
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 19:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828561F238E;
	Fri, 31 Jan 2025 19:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GYkeVL/c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485E0154C0F
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 19:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738352263; cv=none; b=sKBtCG0mBqzeTEFWsaYQBP6S/ZOeCNkOhi9sATqvVKo/UTbN35HZQXvL+U4j6NWN2z+mu7JoP+m5Ny7HBfuoxxxHdEHzqVJl5hH+sD1hxZAx7Orr4myz6Fsbux/VOTu5S9VkdN2fprUXPC2vgBNgH4YCdlFbZcQhmLde/GEfSlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738352263; c=relaxed/simple;
	bh=tdbLz6EIfT/e76iTbQ/JmQz2zLKLSihSI0ZdUz9RHRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IXDReXrNlM+UuO2dIfVBDg7rRdx/3oZa7ieoBcGiEpEWrgaQ7/ujB//BY0g8uR0UVfpDZ7Ak38xicnBuKigagtmRl3xBGumI/LXRrdmUbicc8VIz/XJQcWZABZzTzunOTzXK++NfBJ+tD3r/EZbzceZk+yzK2yLDcpGRgI+gSd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GYkeVL/c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50VDKqVO005573
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 19:37:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=SpbVpsXB8TO
	q24FKhW+a5mN/CUm6Am7sSgRqJjP3wuA=; b=GYkeVL/ccwMpBaXb9oFmjPUFzXQ
	cBDRQ2QKgYWx8pwSJp9c7iIULMwBOela0HA+o0Bu6Xhq5yoH9H1Kydt+aD8xIa5W
	f+dIauLhrUWsO2vhpf6mBXhDX2ykhJACYUJpNrZBWhPKufbSJWCKv8ODrCIbRXca
	ZrR5OMQQY4ujKLie3gZSWHRVsn/rCZ6LaUebekSj1tuMDYb35w/2KR/T6LDt0hcJ
	P0G4EXoWUw7P6+xpLlH7/UQOGQ6a0weGxa8P332ie+Ok4KWsBkQpXl53VsDwZ9OE
	7xa9cNnFzuuHvYAN+x9SHpFR02Sy7chtqWvwPkdLqpLewGKKl4P3+JshfZw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44gyasrv92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 19:37:39 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ee5616e986so6495539a91.2
        for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 11:37:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738352258; x=1738957058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SpbVpsXB8TOq24FKhW+a5mN/CUm6Am7sSgRqJjP3wuA=;
        b=eTdsC4cgwVPEysKhqToxleXZ5B7gWgSAJkbBrnkV91zPLZQPcDvzzf9uX0iEh12o1a
         L5Z5oCcpS1lAFLB7Ko8plQ3xrVNwZPl2dEye9IQoFCsKfyjm3gWNz1E7UPgpyyfybuK/
         wueMisXhV0YasIGKl64swk2jCDp3VUoo9wc1ZXKMSZTStqJrtdR0iA9FE0NmsxuAh1cU
         0lK5gAn0qzZ2o5CySgOpe67McHhB0LGnkU5In7fs334/si71PwQxkArXy6bdP9cHiFpM
         m74PcGA5kjdjCBjQThtuYR/U9uJAcbNN7MipBu2wv7+Uide++ChEe78BcmdNLe9IXsPw
         I3hQ==
X-Gm-Message-State: AOJu0YzoWD9/Vmm43d9fmQpFqD/DjXvW6dYgPnEwFY9pxnsGpH7S7omE
	p9YSo6CGiRPZJOYdSieSfNXHu7OEh3cdfG7iZCmhOro+LeImdcvYJLmS6iPhsebd2/XJw0LcpPw
	BA8B+S+TQf1y4fniMMxifo4CEvK8QhJLaxxZXnHOBv6i9eKUMxMufDJUdjHOU+zAuPA==
X-Gm-Gg: ASbGncvd+oIZXgKX11+6jQHzZGSWn0G6VxQ1WRWLVT7Vge2DWiDx8WYDBNCrpvow0pN
	6vjstW/UkovJ8Zl8Of4X+S782J5J1q7pRRtrgogRy1cc6/4I+O3ugR7cDl+nGX96KnDqcpg8C7G
	7d+QhBnHpKz51bNN1+6Ut5BCJR7hul6Z1r7XUF0fsmzBY95r037/nrqmtAtpfhejdQv9mWt18mL
	9/d9Gc8cKDjlAxmdM+eveRteV0jkuIOyuxeUcAS6/TVllHdr/4oktPPrFV1x62fPubVUMu/By3t
	QsJoj42xbYc+lcJiHDkT+1iXVGeVi1TPjHbXmxbIsEBogTcYevwCaIksKvmPK7jcVD0ELFzHkK7
	C8oidBNtvZ6B8jVK9r7bk1iQw8A2WNxec+g==
X-Received: by 2002:a17:90b:520d:b0:2f6:f107:fae4 with SMTP id 98e67ed59e1d1-2f83abd7cdamr17661798a91.8.1738352258156;
        Fri, 31 Jan 2025 11:37:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1gAf3nGiaYHSzKRRnmoNnhiXuveZTDh6AGcYwigm+N7UGX9POdGruLeFIxgFxSIAabcgzbA==
X-Received: by 2002:a17:90b:520d:b0:2f6:f107:fae4 with SMTP id 98e67ed59e1d1-2f83abd7cdamr17661770a91.8.1738352257588;
        Fri, 31 Jan 2025 11:37:37 -0800 (PST)
Received: from hu-ramess-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f848acac43sm4019271a91.40.2025.01.31.11.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 11:37:37 -0800 (PST)
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Subject: [PATCH v2 1/2] wifi: ath12k: move firmware stats out of debugfs
Date: Sat,  1 Feb 2025 01:07:25 +0530
Message-Id: <20250131193726.3568086-2-rameshkumar.sundaram@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250131193726.3568086-1-rameshkumar.sundaram@oss.qualcomm.com>
References: <20250131193726.3568086-1-rameshkumar.sundaram@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ks0HQWlLDRvxC9rCAfj7Yo-syjPIoonb
X-Proofpoint-ORIG-GUID: ks0HQWlLDRvxC9rCAfj7Yo-syjPIoonb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_07,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 mlxscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2501310149

From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

Currently, firmware stats, comprising pdev, vdev and beacon stats are
part of debugfs. In firmware pdev stats, firmware reports the final
Tx power used to transmit each packet. If driver wants to know the
final Tx power being used at firmware level, it can leverage from
firmware pdev stats.

Move firmware stats out of debugfs context in order to leverage
the final Tx power reported in it even when debugfs is disabled.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.c    |  53 ++++++++++
 drivers/net/wireless/ath/ath12k/core.h    |   4 +
 drivers/net/wireless/ath/ath12k/debugfs.c | 112 +---------------------
 drivers/net/wireless/ath/ath12k/debugfs.h |   5 -
 drivers/net/wireless/ath/ath12k/mac.c     |  50 ++++++++--
 drivers/net/wireless/ath/ath12k/mac.h     |   1 +
 drivers/net/wireless/ath/ath12k/wmi.c     |  99 +++++++++++++++----
 7 files changed, 181 insertions(+), 143 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 60c077b016b4..8dba67e6f462 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1054,6 +1054,59 @@ bool ath12k_core_hw_group_start_ready(struct ath12k_hw_group *ag)
 	return (ag->num_started == ag->num_devices);
 }
 
+static void ath12k_fw_stats_pdevs_free(struct list_head *head)
+{
+	struct ath12k_fw_stats_pdev *i, *tmp;
+
+	list_for_each_entry_safe(i, tmp, head, list) {
+		list_del(&i->list);
+		kfree(i);
+	}
+}
+
+void ath12k_fw_stats_bcn_free(struct list_head *head)
+{
+	struct ath12k_fw_stats_bcn *i, *tmp;
+
+	list_for_each_entry_safe(i, tmp, head, list) {
+		list_del(&i->list);
+		kfree(i);
+	}
+}
+
+static void ath12k_fw_stats_vdevs_free(struct list_head *head)
+{
+	struct ath12k_fw_stats_vdev *i, *tmp;
+
+	list_for_each_entry_safe(i, tmp, head, list) {
+		list_del(&i->list);
+		kfree(i);
+	}
+}
+
+void ath12k_fw_stats_init(struct ath12k *ar)
+{
+	INIT_LIST_HEAD(&ar->fw_stats.vdevs);
+	INIT_LIST_HEAD(&ar->fw_stats.pdevs);
+	INIT_LIST_HEAD(&ar->fw_stats.bcn);
+	init_completion(&ar->fw_stats_complete);
+}
+
+void ath12k_fw_stats_free(struct ath12k_fw_stats *stats)
+{
+	ath12k_fw_stats_pdevs_free(&stats->pdevs);
+	ath12k_fw_stats_vdevs_free(&stats->vdevs);
+	ath12k_fw_stats_bcn_free(&stats->bcn);
+}
+
+void ath12k_fw_stats_reset(struct ath12k *ar)
+{
+	spin_lock_bh(&ar->data_lock);
+	ar->fw_stats.fw_stats_done = false;
+	ath12k_fw_stats_free(&ar->fw_stats);
+	spin_unlock_bh(&ar->data_lock);
+}
+
 static void ath12k_core_trigger_partner(struct ath12k_base *ab)
 {
 	struct ath12k_hw_group *ag = ab->ag;
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 28db100cfac0..373e7baf379b 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1198,6 +1198,10 @@ u32 ath12k_core_get_max_peers_per_radio(struct ath12k_base *ab);
 u32 ath12k_core_get_max_num_tids(struct ath12k_base *ab);
 
 void ath12k_core_hw_group_set_mlo_capable(struct ath12k_hw_group *ag);
+void ath12k_fw_stats_init(struct ath12k *ar);
+void ath12k_fw_stats_bcn_free(struct list_head *head);
+void ath12k_fw_stats_free(struct ath12k_fw_stats *stats);
+void ath12k_fw_stats_reset(struct ath12k *ar);
 
 static inline const char *ath12k_scan_state_str(enum ath12k_scan_state state)
 {
diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
index 6d6708486d14..9c3cd668026b 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs.c
@@ -69,102 +69,6 @@ void ath12k_debugfs_soc_destroy(struct ath12k_base *ab)
 	 */
 }
 
-static void ath12k_fw_stats_pdevs_free(struct list_head *head)
-{
-	struct ath12k_fw_stats_pdev *i, *tmp;
-
-	list_for_each_entry_safe(i, tmp, head, list) {
-		list_del(&i->list);
-		kfree(i);
-	}
-}
-
-static void ath12k_fw_stats_bcn_free(struct list_head *head)
-{
-	struct ath12k_fw_stats_bcn *i, *tmp;
-
-	list_for_each_entry_safe(i, tmp, head, list) {
-		list_del(&i->list);
-		kfree(i);
-	}
-}
-
-static void ath12k_fw_stats_vdevs_free(struct list_head *head)
-{
-	struct ath12k_fw_stats_vdev *i, *tmp;
-
-	list_for_each_entry_safe(i, tmp, head, list) {
-		list_del(&i->list);
-		kfree(i);
-	}
-}
-
-void ath12k_debugfs_fw_stats_reset(struct ath12k *ar)
-{
-	spin_lock_bh(&ar->data_lock);
-	ar->fw_stats.fw_stats_done = false;
-	ath12k_fw_stats_vdevs_free(&ar->fw_stats.vdevs);
-	ath12k_fw_stats_bcn_free(&ar->fw_stats.bcn);
-	ath12k_fw_stats_pdevs_free(&ar->fw_stats.pdevs);
-	spin_unlock_bh(&ar->data_lock);
-}
-
-static int ath12k_debugfs_fw_stats_request(struct ath12k *ar,
-					   struct ath12k_fw_stats_req_params *param)
-{
-	struct ath12k_base *ab = ar->ab;
-	unsigned long timeout, time_left;
-	int ret;
-
-	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
-
-	/* FW stats can get split when exceeding the stats data buffer limit.
-	 * In that case, since there is no end marking for the back-to-back
-	 * received 'update stats' event, we keep a 3 seconds timeout in case,
-	 * fw_stats_done is not marked yet
-	 */
-	timeout = jiffies + msecs_to_jiffies(3 * 1000);
-
-	ath12k_debugfs_fw_stats_reset(ar);
-
-	reinit_completion(&ar->fw_stats_complete);
-
-	ret = ath12k_wmi_send_stats_request_cmd(ar, param->stats_id,
-						param->vdev_id, param->pdev_id);
-
-	if (ret) {
-		ath12k_warn(ab, "could not request fw stats (%d)\n",
-			    ret);
-		return ret;
-	}
-
-	time_left = wait_for_completion_timeout(&ar->fw_stats_complete,
-						1 * HZ);
-	/* If the wait timed out, return -ETIMEDOUT */
-	if (!time_left)
-		return -ETIMEDOUT;
-
-	/* Firmware sends WMI_UPDATE_STATS_EVENTID back-to-back
-	 * when stats data buffer limit is reached. fw_stats_complete
-	 * is completed once host receives first event from firmware, but
-	 * still end might not be marked in the TLV.
-	 * Below loop is to confirm that firmware completed sending all the event
-	 * and fw_stats_done is marked true when end is marked in the TLV
-	 */
-	for (;;) {
-		if (time_after(jiffies, timeout))
-			break;
-
-		spin_lock_bh(&ar->data_lock);
-		if (ar->fw_stats.fw_stats_done) {
-			spin_unlock_bh(&ar->data_lock);
-			break;
-		}
-		spin_unlock_bh(&ar->data_lock);
-	}
-	return 0;
-}
-
 void
 ath12k_debugfs_fw_stats_process(struct ath12k *ar,
 				struct ath12k_fw_stats *stats)
@@ -221,10 +125,6 @@ ath12k_debugfs_fw_stats_process(struct ath12k *ar,
 			num_bcn = 0;
 		}
 	}
-	if (stats->stats_id == WMI_REQUEST_PDEV_STAT) {
-		list_splice_tail_init(&stats->pdevs, &ar->fw_stats.pdevs);
-		ar->fw_stats.fw_stats_done = true;
-	}
 }
 
 static int ath12k_open_vdev_stats(struct inode *inode, struct file *file)
@@ -251,7 +151,7 @@ static int ath12k_open_vdev_stats(struct inode *inode, struct file *file)
 	param.vdev_id = 0;
 	param.stats_id = WMI_REQUEST_VDEV_STAT;
 
-	ret = ath12k_debugfs_fw_stats_request(ar, &param);
+	ret = ath12k_mac_get_fw_stats(ar, &param);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to request fw vdev stats: %d\n", ret);
 		return ret;
@@ -316,7 +216,7 @@ static int ath12k_open_bcn_stats(struct inode *inode, struct file *file)
 			continue;
 
 		param.vdev_id = arvif->vdev_id;
-		ret = ath12k_debugfs_fw_stats_request(ar, &param);
+		ret = ath12k_mac_get_fw_stats(ar, &param);
 		if (ret) {
 			ath12k_warn(ar->ab, "failed to request fw bcn stats: %d\n", ret);
 			return ret;
@@ -383,7 +283,7 @@ static int ath12k_open_pdev_stats(struct inode *inode, struct file *file)
 	param.vdev_id = 0;
 	param.stats_id = WMI_REQUEST_PDEV_STAT;
 
-	ret = ath12k_debugfs_fw_stats_request(ar, &param);
+	ret = ath12k_mac_get_fw_stats(ar, &param);
 	if (ret) {
 		ath12k_warn(ab, "failed to request fw pdev stats: %d\n", ret);
 		return ret;
@@ -438,11 +338,7 @@ void ath12k_debugfs_fw_stats_register(struct ath12k *ar)
 	debugfs_create_file("pdev_stats", 0600, fwstats_dir, ar,
 			    &fops_pdev_stats);
 
-	INIT_LIST_HEAD(&ar->fw_stats.vdevs);
-	INIT_LIST_HEAD(&ar->fw_stats.bcn);
-	INIT_LIST_HEAD(&ar->fw_stats.pdevs);
-
-	init_completion(&ar->fw_stats_complete);
+	ath12k_fw_stats_init(ar);
 }
 
 void ath12k_debugfs_register(struct ath12k *ar)
diff --git a/drivers/net/wireless/ath/ath12k/debugfs.h b/drivers/net/wireless/ath/ath12k/debugfs.h
index 1c30745ee415..c69614f1d2d9 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs.h
@@ -14,7 +14,6 @@ void ath12k_debugfs_register(struct ath12k *ar);
 void ath12k_debugfs_unregister(struct ath12k *ar);
 void ath12k_debugfs_fw_stats_process(struct ath12k *ar,
 				     struct ath12k_fw_stats *stats);
-void ath12k_debugfs_fw_stats_reset(struct ath12k *ar);
 #else
 static inline void ath12k_debugfs_soc_create(struct ath12k_base *ab)
 {
@@ -36,10 +35,6 @@ static inline void ath12k_debugfs_fw_stats_process(struct ath12k *ar,
 						   struct ath12k_fw_stats *stats)
 {
 }
-
-static inline void ath12k_debugfs_fw_stats_reset(struct ath12k *ar)
-{
-}
 #endif /* CONFIG_ATH12K_DEBUGFS */
 
 #endif /* _ATH12K_DEBUGFS_H_ */
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 4fb7e235be66..8cd33ea75590 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -10109,12 +10109,12 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
 	return 0;
 }
 
-static int ath12k_mac_get_fw_stats(struct ath12k *ar, u32 pdev_id,
-				   u32 vdev_id, u32 stats_id)
+int ath12k_mac_get_fw_stats(struct ath12k *ar,
+			    struct ath12k_fw_stats_req_params *param)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_hw *ah = ath12k_ar_to_ah(ar);
-	unsigned long time_left;
+	unsigned long timeout, time_left;
 	int ret;
 
 	guard(mutex)(&ah->hw_mutex);
@@ -10122,9 +10122,18 @@ static int ath12k_mac_get_fw_stats(struct ath12k *ar, u32 pdev_id,
 	if (ah->state != ATH12K_HW_STATE_ON)
 		return -ENETDOWN;
 
+	/* FW stats can get split when exceeding the stats data buffer limit.
+	 * In that case, since there is no end marking for the back-to-back
+	 * received 'update stats' event, we keep a 3 seconds timeout in case,
+	 * fw_stats_done is not marked yet
+	 */
+	timeout = jiffies + msecs_to_jiffies(3 * 1000);
+	ath12k_fw_stats_reset(ar);
+
 	reinit_completion(&ar->fw_stats_complete);
 
-	ret = ath12k_wmi_send_stats_request_cmd(ar, stats_id, vdev_id, pdev_id);
+	ret = ath12k_wmi_send_stats_request_cmd(ar, param->stats_id,
+						param->vdev_id, param->pdev_id);
 
 	if (ret) {
 		ath12k_warn(ab, "failed to request fw stats: %d\n", ret);
@@ -10133,14 +10142,33 @@ static int ath12k_mac_get_fw_stats(struct ath12k *ar, u32 pdev_id,
 
 	ath12k_dbg(ab, ATH12K_DBG_WMI,
 		   "get fw stat pdev id %d vdev id %d stats id 0x%x\n",
-		   pdev_id, vdev_id, stats_id);
+		   param->pdev_id, param->vdev_id, param->stats_id);
 
 	time_left = wait_for_completion_timeout(&ar->fw_stats_complete, 1 * HZ);
 
-	if (!time_left)
+	if (!time_left) {
 		ath12k_warn(ab, "time out while waiting for get fw stats\n");
+		return -ETIMEDOUT;
+	}
 
-	return ret;
+	/* Firmware sends WMI_UPDATE_STATS_EVENTID back-to-back
+	 * when stats data buffer limit is reached. fw_stats_complete
+	 * is completed once host receives first event from firmware, but
+	 * still end might not be marked in the TLV.
+	 * Below loop is to confirm that firmware completed sending all the event
+	 * and fw_stats_done is marked true when end is marked in the TLV.
+	 */
+	for (;;) {
+		if (time_after(jiffies, timeout))
+			break;
+		spin_lock_bh(&ar->data_lock);
+		if (ar->fw_stats.fw_stats_done) {
+			spin_unlock_bh(&ar->data_lock);
+			break;
+		}
+		spin_unlock_bh(&ar->data_lock);
+	}
+	return 0;
 }
 
 static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
@@ -10149,6 +10177,7 @@ static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 					 struct station_info *sinfo)
 {
 	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(sta);
+	struct ath12k_fw_stats_req_params params = {};
 	struct ath12k_link_sta *arsta;
 	struct ath12k *ar;
 	s8 signal;
@@ -10191,10 +10220,13 @@ static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 	/* TODO: Use real NF instead of default one. */
 	signal = arsta->rssi_comb;
 
+	params.pdev_id = ar->pdev->pdev_id;
+	params.vdev_id = 0;
+	params.stats_id = WMI_REQUEST_VDEV_STAT;
+
 	if (!signal &&
 	    ahsta->ahvif->vdev_type == WMI_VDEV_TYPE_STA &&
-	    !(ath12k_mac_get_fw_stats(ar, ar->pdev->pdev_id, 0,
-				      WMI_REQUEST_VDEV_STAT)))
+	    !(ath12k_mac_get_fw_stats(ar, &params)))
 		signal = arsta->rssi_beacon;
 
 	if (signal) {
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index 1acaf3f68292..a0de0ddf175e 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -111,5 +111,6 @@ void ath12k_mac_get_any_chanctx_conf_iter(struct ieee80211_hw *hw,
 u16 ath12k_mac_he_convert_tones_to_ru_tones(u16 tones);
 enum nl80211_eht_ru_alloc ath12k_mac_eht_ru_tones_to_nl80211_eht_ru_alloc(u16 ru_tones);
 enum nl80211_eht_gi ath12k_mac_eht_gi_to_nl80211_eht_gi(u8 sgi);
+int ath12k_mac_get_fw_stats(struct ath12k *ar, struct ath12k_fw_stats_req_params *param);
 
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 61aa5f509338..fa12aceb140a 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -29,6 +29,7 @@ struct ath12k_wmi_svc_ready_parse {
 
 struct wmi_tlv_fw_stats_parse {
 	const struct wmi_stats_event *ev;
+	struct ath12k_fw_stats *stats;
 };
 
 struct ath12k_wmi_dma_ring_caps_parse {
@@ -7195,7 +7196,7 @@ void ath12k_wmi_fw_stats_dump(struct ath12k *ar,
 	else
 		buf[len] = 0;
 
-	ath12k_debugfs_fw_stats_reset(ar);
+	ath12k_fw_stats_reset(ar);
 }
 
 static void
@@ -7314,7 +7315,7 @@ static int ath12k_wmi_tlv_fw_stats_data_parse(struct ath12k_base *ab,
 					      u16 len)
 {
 	const struct wmi_stats_event *ev = parse->ev;
-	struct ath12k_fw_stats stats = {0};
+	struct ath12k_fw_stats *stats = parse->stats;
 	struct ath12k *ar;
 	struct ath12k_link_vif *arvif;
 	struct ieee80211_sta *sta;
@@ -7323,18 +7324,18 @@ static int ath12k_wmi_tlv_fw_stats_data_parse(struct ath12k_base *ab,
 	int i, ret = 0;
 	const void *data = ptr;
 
-	INIT_LIST_HEAD(&stats.vdevs);
-	INIT_LIST_HEAD(&stats.bcn);
-	INIT_LIST_HEAD(&stats.pdevs);
-
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch update stats ev");
 		return -EPROTO;
 	}
 
+	if (!stats)
+		return -EINVAL;
+
 	rcu_read_lock();
 
-	ar = ath12k_mac_get_ar_by_pdev_id(ab, le32_to_cpu(ev->pdev_id));
+	stats->pdev_id = le32_to_cpu(ev->pdev_id);
+	ar = ath12k_mac_get_ar_by_pdev_id(ab, stats->pdev_id);
 	if (!ar) {
 		ath12k_warn(ab, "invalid pdev id %d in update stats event\n",
 			    le32_to_cpu(ev->pdev_id));
@@ -7377,8 +7378,8 @@ static int ath12k_wmi_tlv_fw_stats_data_parse(struct ath12k_base *ab,
 		if (!dst)
 			continue;
 		ath12k_wmi_pull_vdev_stats(src, dst);
-		stats.stats_id = WMI_REQUEST_VDEV_STAT;
-		list_add_tail(&dst->list, &stats.vdevs);
+		stats->stats_id = WMI_REQUEST_VDEV_STAT;
+		list_add_tail(&dst->list, &stats->vdevs);
 	}
 	for (i = 0; i < le32_to_cpu(ev->num_bcn_stats); i++) {
 		const struct ath12k_wmi_bcn_stats_params *src;
@@ -7396,8 +7397,8 @@ static int ath12k_wmi_tlv_fw_stats_data_parse(struct ath12k_base *ab,
 		if (!dst)
 			continue;
 		ath12k_wmi_pull_bcn_stats(src, dst);
-		stats.stats_id = WMI_REQUEST_BCN_STAT;
-		list_add_tail(&dst->list, &stats.bcn);
+		stats->stats_id = WMI_REQUEST_BCN_STAT;
+		list_add_tail(&dst->list, &stats->bcn);
 	}
 	for (i = 0; i < le32_to_cpu(ev->num_pdev_stats); i++) {
 		const struct ath12k_wmi_pdev_stats_params *src;
@@ -7409,7 +7410,7 @@ static int ath12k_wmi_tlv_fw_stats_data_parse(struct ath12k_base *ab,
 			goto exit;
 		}
 
-		stats.stats_id = WMI_REQUEST_PDEV_STAT;
+		stats->stats_id = WMI_REQUEST_PDEV_STAT;
 
 		data += sizeof(*src);
 		len -= sizeof(*src);
@@ -7421,11 +7422,9 @@ static int ath12k_wmi_tlv_fw_stats_data_parse(struct ath12k_base *ab,
 		ath12k_wmi_pull_pdev_stats_base(&src->base, dst);
 		ath12k_wmi_pull_pdev_stats_tx(&src->tx, dst);
 		ath12k_wmi_pull_pdev_stats_rx(&src->rx, dst);
-		list_add_tail(&dst->list, &stats.pdevs);
+		list_add_tail(&dst->list, &stats->pdevs);
 	}
 
-	complete(&ar->fw_stats_complete);
-	ath12k_debugfs_fw_stats_process(ar, &stats);
 exit:
 	rcu_read_unlock();
 	return ret;
@@ -7451,16 +7450,74 @@ static int ath12k_wmi_tlv_fw_stats_parse(struct ath12k_base *ab,
 	return ret;
 }
 
+static int ath12k_wmi_pull_fw_stats(struct ath12k_base *ab, struct sk_buff *skb,
+				    struct ath12k_fw_stats *stats)
+{
+	struct wmi_tlv_fw_stats_parse parse = {};
+
+	stats->stats_id = 0;
+	parse.stats = stats;
+
+	return ath12k_wmi_tlv_iter(ab, skb->data, skb->len,
+				   ath12k_wmi_tlv_fw_stats_parse,
+				   &parse);
+}
+
 static void ath12k_update_stats_event(struct ath12k_base *ab, struct sk_buff *skb)
 {
+	struct ath12k_fw_stats stats = {};
+	struct ath12k *ar;
 	int ret;
-	struct wmi_tlv_fw_stats_parse parse = {};
 
-	ret = ath12k_wmi_tlv_iter(ab, skb->data, skb->len,
-				  ath12k_wmi_tlv_fw_stats_parse,
-				  &parse);
-	if (ret)
-		ath12k_warn(ab, "failed to parse fw stats %d\n", ret);
+	INIT_LIST_HEAD(&stats.pdevs);
+	INIT_LIST_HEAD(&stats.vdevs);
+	INIT_LIST_HEAD(&stats.bcn);
+
+	ret = ath12k_wmi_pull_fw_stats(ab, skb, &stats);
+	if (ret) {
+		ath12k_warn(ab, "failed to pull fw stats: %d\n", ret);
+		goto free;
+	}
+
+	ath12k_dbg(ab, ATH12K_DBG_WMI, "event update stats");
+
+	rcu_read_lock();
+	ar = ath12k_mac_get_ar_by_pdev_id(ab, stats.pdev_id);
+	if (!ar) {
+		rcu_read_unlock();
+		ath12k_warn(ab, "failed to get ar for pdev_id %d: %d\n",
+			    stats.pdev_id, ret);
+		goto free;
+	}
+
+	spin_lock_bh(&ar->data_lock);
+
+	/* WMI_REQUEST_PDEV_STAT can be requested via .get_txpower mac ops or via
+	 * debugfs fw stats. Therefore, processing it separately.
+	 */
+	if (stats.stats_id == WMI_REQUEST_PDEV_STAT) {
+		list_splice_tail_init(&stats.pdevs, &ar->fw_stats.pdevs);
+		ar->fw_stats.fw_stats_done = true;
+		goto complete;
+	}
+
+	/* WMI_REQUEST_VDEV_STAT and WMI_REQUEST_BCN_STAT are currently requested only
+	 * via debugfs fw stats. Hence, processing these in debugfs context.
+	 */
+	ath12k_debugfs_fw_stats_process(ar, &stats);
+
+complete:
+	complete(&ar->fw_stats_complete);
+	spin_unlock_bh(&ar->data_lock);
+	rcu_read_unlock();
+
+	/* Since the stats's pdev, vdev and beacon list are spliced and reinitialised
+	 * at this point, no need to free the individual list.
+	 */
+	return;
+
+free:
+	ath12k_fw_stats_free(&stats);
 }
 
 /* PDEV_CTL_FAILSAFE_CHECK_EVENT is received from FW when the frequency scanned
-- 
2.34.1


