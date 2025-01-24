Return-Path: <linux-wireless+bounces-17915-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F27A1BC7C
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 19:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 653987A3CC9
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 18:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3764146A9B;
	Fri, 24 Jan 2025 18:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R0IxpUMl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9582248AD
	for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737744824; cv=none; b=hXFAU7dHxXP1KxowG25CdniGdRcrHSv2odnKVShbtNqvmjv0sxUqVsYIsVghBMXhLpoUX9E82gvVWRvNZ3PESTOq29B97Cm6+fG2JCdO5LRauIKfxRcwpAXwa21rp7qIvcwUNMLl+0XyLSGOaji69OEbeS5H3/86Skja790JRy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737744824; c=relaxed/simple;
	bh=EwUsetw1MnYEpbESURqrD+ErfVvDjmW2ZNa3s16zQ44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hyX8kF8NnDvISmjoDxciOA+Ss7gepj3rsmk4SXZutcLH+5CPjISq4sRPooKlso6qr5UqtbXhez6FoagMx1yn+W8r0cXPwBee1daewePVIrUSLPbuWUdeBNs82cdWMLrYwirYJzgQPJTGm/F4L0JpXil2UhzMpLPDtb1YGPoLrfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R0IxpUMl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OI9xP7015315;
	Fri, 24 Jan 2025 18:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=VEdY3P1BCwK
	/A7F1pPJp3uuwLlBtcS74Sl4dCCo6s/w=; b=R0IxpUMlhmf9namBSV4LEGp0kdJ
	UpyTYPlsXAIbJrJGXS8d0sdU6VNh14z/j+3tZB4PZJq2IaxUs7pmu3xdjEZ/M6xh
	H0o68ULZjfeDBrhY2mD25KohJKa/cB/33hRzZ56624IYxltuubWUkalZBe7ygxCS
	ZoS+YhPcKdLDUkoIiQQ2XxozQWkweuw018ovCVIYZk4+le/GyHhZEnM0Z2tepW9t
	HVpmVM0JncfGK58HKvVVEMtiHlpJzpuP62Y8VMNK3gC9tvQ5FMzDbEYYfvmdM/TF
	7N1vhuVEuPX7mUl2koDwERb69eD5eBwg2anzwsTmbpU5CiEsanJeQ/XrU6Q==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44cfw3g2ea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 18:53:38 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 50OIrakY013064;
	Fri, 24 Jan 2025 18:53:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4485cmbfnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 18:53:36 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50OIrZRg013058;
	Fri, 24 Jan 2025 18:53:35 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-rgnanase-blr.qualcomm.com [10.190.106.79])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 50OIrZU2013057
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 18:53:35 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 2378837)
	id DB34F41188; Sat, 25 Jan 2025 00:23:34 +0530 (+0530)
From: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
Subject: [PATCH 3/3] wifi: ath12k: Request pdev stats from firmware
Date: Sat, 25 Jan 2025 00:23:30 +0530
Message-Id: <20250124185330.1244585-4-ramya.gnanasekar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124185330.1244585-1-ramya.gnanasekar@oss.qualcomm.com>
References: <20250124185330.1244585-1-ramya.gnanasekar@oss.qualcomm.com>
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
X-Proofpoint-GUID: vhzzAE92m1avTJymg1d6TzH98lxZl_Xa
X-Proofpoint-ORIG-GUID: vhzzAE92m1avTJymg1d6TzH98lxZl_Xa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_08,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240130

Add support to request pdev stats from firmware through WMI and
print the information

Sample Output:
-------------
cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/fw_stats/pdev_stats

             ath12k PDEV stats
             =================

           Channel noise floor        -85
              Channel TX power        126
                TX frame count          0
                RX frame count       8637
                RX clear count      37424
                   Cycle count    4372024
               PHY error count          0
                soc drop count          0

          ath12k PDEV TX stats
          ====================

            HTT cookies queued          0
             HTT cookies disp.          0
                   MSDU queued          0
                   MPDU queued          0
                 MSDUs dropped          0
                  Local enqued          0
                   Local freed          0
                     HW queued          0
                  PPDUs reaped          0
                 Num underruns          0
                 PPDUs cleaned          0
                MPDUs requeued          0
             Excessive retries          0
                       HW rate          0
           Sched self triggers          0
     Dropped due to SW retries          0
       Illegal rate phy errors          0
        PDEV continuous xretry          0
                    TX timeout          9
                   PDEV resets          0
 Stateless TIDs alloc failures          0
                  PHY underrun          0
  MPDU is more than txop limit          0

          ath12k PDEV RX stats
          ====================

         Mid PPDU route change          0
       Tot. number of statuses          0
        Extra frags on rings 0          0
        Extra frags on rings 1          0
        Extra frags on rings 2          0
        Extra frags on rings 3          0
        MSDUs delivered to HTT          0
        MPDUs delivered to HTT          0
      MSDUs delivered to stack          0
      MPDUs delivered to stack          0
               Oversized AMSUs          0
                    PHY errors          0
              PHY errors drops          0
   MPDU errors (FCS, MIC, ENC)          0

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.h    |  60 +++++
 drivers/net/wireless/ath/ath12k/debugfs.c |  79 +++++++
 drivers/net/wireless/ath/ath12k/wmi.c     | 256 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h     |  60 +++++
 4 files changed, 455 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 49780fe51b0b..91e862a6d020 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1108,6 +1108,66 @@ struct ath12k_fw_stats_bcn {
 	u32 tx_bcn_outage_cnt;
 };
 
+struct ath12k_fw_stats_pdev {
+	struct list_head list;
+
+	/* PDEV stats */
+	s32 ch_noise_floor;
+	u32 tx_frame_count;
+	u32 rx_frame_count;
+	u32 rx_clear_count;
+	u32 cycle_count;
+	u32 phy_err_count;
+	u32 chan_tx_power;
+	u32 ack_rx_bad;
+	u32 rts_bad;
+	u32 rts_good;
+	u32 fcs_bad;
+	u32 no_beacons;
+	u32 mib_int_count;
+
+	/* PDEV TX stats */
+	s32 comp_queued;
+	s32 comp_delivered;
+	s32 msdu_enqued;
+	s32 mpdu_enqued;
+	s32 wmm_drop;
+	s32 local_enqued;
+	s32 local_freed;
+	s32 hw_queued;
+	s32 hw_reaped;
+	s32 underrun;
+	s32 tx_abort;
+	s32 mpdus_requed;
+	u32 tx_ko;
+	u32 data_rc;
+	u32 self_triggers;
+	u32 sw_retry_failure;
+	u32 illgl_rate_phy_err;
+	u32 pdev_cont_xretry;
+	u32 pdev_tx_timeout;
+	u32 pdev_resets;
+	u32 stateless_tid_alloc_failure;
+	u32 phy_underrun;
+	u32 txop_ovf;
+
+	/* PDEV RX stats */
+	s32 mid_ppdu_route_change;
+	s32 status_rcvd;
+	s32 r0_frags;
+	s32 r1_frags;
+	s32 r2_frags;
+	s32 r3_frags;
+	s32 htt_msdus;
+	s32 htt_mpdus;
+	s32 loc_msdus;
+	s32 loc_mpdus;
+	s32 oversize_amsdu;
+	s32 phy_errs;
+	s32 phy_err_drop;
+	s32 mpdu_errs;
+};
+
 int ath12k_core_qmi_firmware_ready(struct ath12k_base *ab);
 int ath12k_core_pre_init(struct ath12k_base *ab);
 int ath12k_core_init(struct ath12k_base *ath12k);
diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
index 3cb2bb9fa424..6d6708486d14 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs.c
@@ -69,6 +69,16 @@ void ath12k_debugfs_soc_destroy(struct ath12k_base *ab)
 	 */
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
 static void ath12k_fw_stats_bcn_free(struct list_head *head)
 {
 	struct ath12k_fw_stats_bcn *i, *tmp;
@@ -95,6 +105,7 @@ void ath12k_debugfs_fw_stats_reset(struct ath12k *ar)
 	ar->fw_stats.fw_stats_done = false;
 	ath12k_fw_stats_vdevs_free(&ar->fw_stats.vdevs);
 	ath12k_fw_stats_bcn_free(&ar->fw_stats.bcn);
+	ath12k_fw_stats_pdevs_free(&ar->fw_stats.pdevs);
 	spin_unlock_bh(&ar->data_lock);
 }
 
@@ -210,6 +221,10 @@ ath12k_debugfs_fw_stats_process(struct ath12k *ar,
 			num_bcn = 0;
 		}
 	}
+	if (stats->stats_id == WMI_REQUEST_PDEV_STAT) {
+		list_splice_tail_init(&stats->pdevs, &ar->fw_stats.pdevs);
+		ar->fw_stats.fw_stats_done = true;
+	}
 }
 
 static int ath12k_open_vdev_stats(struct inode *inode, struct file *file)
@@ -347,6 +362,66 @@ static const struct file_operations fops_bcn_stats = {
 	.llseek = default_llseek,
 };
 
+static int ath12k_open_pdev_stats(struct inode *inode, struct file *file)
+{
+	struct ath12k *ar = inode->i_private;
+	struct ath12k_hw *ah = ath12k_ar_to_ah(ar);
+	struct ath12k_base *ab = ar->ab;
+	struct ath12k_fw_stats_req_params param;
+	int ret;
+
+	guard(wiphy)(ath12k_ar_to_hw(ar)->wiphy);
+
+	if (ah && ah->state != ATH12K_HW_STATE_ON)
+		return -ENETDOWN;
+
+	void *buf __free(kfree) = kzalloc(ATH12K_FW_STATS_BUF_SIZE, GFP_ATOMIC);
+	if (!buf)
+		return -ENOMEM;
+
+	param.pdev_id = ath12k_mac_get_target_pdev_id(ar);
+	param.vdev_id = 0;
+	param.stats_id = WMI_REQUEST_PDEV_STAT;
+
+	ret = ath12k_debugfs_fw_stats_request(ar, &param);
+	if (ret) {
+		ath12k_warn(ab, "failed to request fw pdev stats: %d\n", ret);
+		return ret;
+	}
+
+	ath12k_wmi_fw_stats_dump(ar, &ar->fw_stats, param.stats_id,
+				 buf);
+
+	file->private_data = no_free_ptr(buf);
+
+	return 0;
+}
+
+static int ath12k_release_pdev_stats(struct inode *inode, struct file *file)
+{
+	kfree(file->private_data);
+
+	return 0;
+}
+
+static ssize_t ath12k_read_pdev_stats(struct file *file,
+				      char __user *user_buf,
+				      size_t count, loff_t *ppos)
+{
+	const char *buf = file->private_data;
+	size_t len = strlen(buf);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static const struct file_operations fops_pdev_stats = {
+	.open = ath12k_open_pdev_stats,
+	.release = ath12k_release_pdev_stats,
+	.read = ath12k_read_pdev_stats,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
 static
 void ath12k_debugfs_fw_stats_register(struct ath12k *ar)
 {
@@ -360,9 +435,13 @@ void ath12k_debugfs_fw_stats_register(struct ath12k *ar)
 			    &fops_vdev_stats);
 	debugfs_create_file("beacon_stats", 0600, fwstats_dir, ar,
 			    &fops_bcn_stats);
+	debugfs_create_file("pdev_stats", 0600, fwstats_dir, ar,
+			    &fops_pdev_stats);
 
 	INIT_LIST_HEAD(&ar->fw_stats.vdevs);
 	INIT_LIST_HEAD(&ar->fw_stats.bcn);
+	INIT_LIST_HEAD(&ar->fw_stats.pdevs);
+
 	init_completion(&ar->fw_stats_complete);
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index f84102852438..61aa5f509338 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -7001,6 +7001,170 @@ ath12k_wmi_fw_bcn_stats_dump(struct ath12k *ar,
 	}
 }
 
+static void
+ath12k_wmi_fw_pdev_base_stats_dump(const struct ath12k_fw_stats_pdev *pdev,
+				   char *buf, u32 *length, u64 fw_soc_drop_cnt)
+{
+	u32 len = *length;
+	u32 buf_len = ATH12K_FW_STATS_BUF_SIZE;
+
+	len = scnprintf(buf + len, buf_len - len, "\n");
+	len += scnprintf(buf + len, buf_len - len, "%30s\n",
+			"ath12k PDEV stats");
+	len += scnprintf(buf + len, buf_len - len, "%30s\n\n",
+			"=================");
+
+	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
+			"Channel noise floor", pdev->ch_noise_floor);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10u\n",
+			"Channel TX power", pdev->chan_tx_power);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10u\n",
+			"TX frame count", pdev->tx_frame_count);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10u\n",
+			"RX frame count", pdev->rx_frame_count);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10u\n",
+			"RX clear count", pdev->rx_clear_count);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10u\n",
+			"Cycle count", pdev->cycle_count);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10u\n",
+			"PHY error count", pdev->phy_err_count);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10llu\n",
+			"soc drop count", fw_soc_drop_cnt);
+
+	*length = len;
+}
+
+static void
+ath12k_wmi_fw_pdev_tx_stats_dump(const struct ath12k_fw_stats_pdev *pdev,
+				 char *buf, u32 *length)
+{
+	u32 len = *length;
+	u32 buf_len = ATH12K_FW_STATS_BUF_SIZE;
+
+	len += scnprintf(buf + len, buf_len - len, "\n%30s\n",
+			 "ath12k PDEV TX stats");
+	len += scnprintf(buf + len, buf_len - len, "%30s\n\n",
+			 "====================");
+
+	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
+			 "HTT cookies queued", pdev->comp_queued);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
+			 "HTT cookies disp.", pdev->comp_delivered);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
+			 "MSDU queued", pdev->msdu_enqued);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
+			 "MPDU queued", pdev->mpdu_enqued);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
+			 "MSDUs dropped", pdev->wmm_drop);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
+			 "Local enqued", pdev->local_enqued);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
+			 "Local freed", pdev->local_freed);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
+			 "HW queued", pdev->hw_queued);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
+			 "PPDUs reaped", pdev->hw_reaped);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
+			 "Num underruns", pdev->underrun);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
+			 "PPDUs cleaned", pdev->tx_abort);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
+			 "MPDUs requeued", pdev->mpdus_requed);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10u\n",
+			 "Excessive retries", pdev->tx_ko);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10u\n",
+			 "HW rate", pdev->data_rc);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10u\n",
+			 "Sched self triggers", pdev->self_triggers);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10u\n",
+			 "Dropped due to SW retries",
+			 pdev->sw_retry_failure);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10u\n",
+			 "Illegal rate phy errors",
+			 pdev->illgl_rate_phy_err);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10u\n",
+			 "PDEV continuous xretry", pdev->pdev_cont_xretry);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10u\n",
+			 "TX timeout", pdev->pdev_tx_timeout);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10u\n",
+			 "PDEV resets", pdev->pdev_resets);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10u\n",
+			 "Stateless TIDs alloc failures",
+			 pdev->stateless_tid_alloc_failure);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10u\n",
+			 "PHY underrun", pdev->phy_underrun);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10u\n",
+			 "MPDU is more than txop limit", pdev->txop_ovf);
+	*length = len;
+}
+
+static void
+ath12k_wmi_fw_pdev_rx_stats_dump(const struct ath12k_fw_stats_pdev *pdev,
+				 char *buf, u32 *length)
+{
+	u32 len = *length;
+	u32 buf_len = ATH12K_FW_STATS_BUF_SIZE;
+
+	len += scnprintf(buf + len, buf_len - len, "\n%30s\n",
+			 "ath12k PDEV RX stats");
+	len += scnprintf(buf + len, buf_len - len, "%30s\n\n",
+			 "====================");
+
+	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
+			 "Mid PPDU route change",
+			 pdev->mid_ppdu_route_change);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
+			 "Tot. number of statuses", pdev->status_rcvd);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
+			 "Extra frags on rings 0", pdev->r0_frags);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
+			 "Extra frags on rings 1", pdev->r1_frags);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
+			 "Extra frags on rings 2", pdev->r2_frags);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
+			 "Extra frags on rings 3", pdev->r3_frags);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
+			 "MSDUs delivered to HTT", pdev->htt_msdus);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
+			 "MPDUs delivered to HTT", pdev->htt_mpdus);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
+			 "MSDUs delivered to stack", pdev->loc_msdus);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
+			 "MPDUs delivered to stack", pdev->loc_mpdus);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
+			 "Oversized AMSUs", pdev->oversize_amsdu);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
+			 "PHY errors", pdev->phy_errs);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
+			 "PHY errors drops", pdev->phy_err_drop);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
+			 "MPDU errors (FCS, MIC, ENC)", pdev->mpdu_errs);
+	*length = len;
+}
+
+static void
+ath12k_wmi_fw_pdev_stats_dump(struct ath12k *ar,
+			      struct ath12k_fw_stats *fw_stats,
+			      char *buf, u32 *length)
+{
+	const struct ath12k_fw_stats_pdev *pdev;
+	u32 len = *length;
+
+	pdev = list_first_entry_or_null(&fw_stats->pdevs,
+					struct ath12k_fw_stats_pdev, list);
+	if (!pdev) {
+		ath12k_warn(ar->ab, "failed to get pdev stats\n");
+		return;
+	}
+
+	ath12k_wmi_fw_pdev_base_stats_dump(pdev, buf, &len,
+					   ar->ab->fw_soc_drop_count);
+	ath12k_wmi_fw_pdev_tx_stats_dump(pdev, buf, &len);
+	ath12k_wmi_fw_pdev_rx_stats_dump(pdev, buf, &len);
+
+	*length = len;
+}
+
 void ath12k_wmi_fw_stats_dump(struct ath12k *ar,
 			      struct ath12k_fw_stats *fw_stats,
 			      u32 stats_id, char *buf)
@@ -7017,6 +7181,9 @@ void ath12k_wmi_fw_stats_dump(struct ath12k *ar,
 	case WMI_REQUEST_BCN_STAT:
 		ath12k_wmi_fw_bcn_stats_dump(ar, fw_stats, buf, &len);
 		break;
+	case WMI_REQUEST_PDEV_STAT:
+		ath12k_wmi_fw_pdev_stats_dump(ar, fw_stats, buf, &len);
+		break;
 	default:
 		break;
 	}
@@ -7077,6 +7244,70 @@ ath12k_wmi_pull_bcn_stats(const struct ath12k_wmi_bcn_stats_params *src,
 	dst->tx_bcn_outage_cnt = le32_to_cpu(src->tx_bcn_outage_cnt);
 }
 
+static void
+ath12k_wmi_pull_pdev_stats_base(const struct ath12k_wmi_pdev_base_stats_params *src,
+				struct ath12k_fw_stats_pdev *dst)
+{
+	dst->ch_noise_floor = a_sle32_to_cpu(src->chan_nf);
+	dst->tx_frame_count = __le32_to_cpu(src->tx_frame_count);
+	dst->rx_frame_count = __le32_to_cpu(src->rx_frame_count);
+	dst->rx_clear_count = __le32_to_cpu(src->rx_clear_count);
+	dst->cycle_count = __le32_to_cpu(src->cycle_count);
+	dst->phy_err_count = __le32_to_cpu(src->phy_err_count);
+	dst->chan_tx_power = __le32_to_cpu(src->chan_tx_pwr);
+}
+
+static void
+ath12k_wmi_pull_pdev_stats_tx(const struct ath12k_wmi_pdev_tx_stats_params *src,
+			      struct ath12k_fw_stats_pdev *dst)
+{
+	dst->comp_queued = a_sle32_to_cpu(src->comp_queued);
+	dst->comp_delivered = a_sle32_to_cpu(src->comp_delivered);
+	dst->msdu_enqued = a_sle32_to_cpu(src->msdu_enqued);
+	dst->mpdu_enqued = a_sle32_to_cpu(src->mpdu_enqued);
+	dst->wmm_drop = a_sle32_to_cpu(src->wmm_drop);
+	dst->local_enqued = a_sle32_to_cpu(src->local_enqued);
+	dst->local_freed = a_sle32_to_cpu(src->local_freed);
+	dst->hw_queued = a_sle32_to_cpu(src->hw_queued);
+	dst->hw_reaped = a_sle32_to_cpu(src->hw_reaped);
+	dst->underrun = a_sle32_to_cpu(src->underrun);
+	dst->tx_abort = a_sle32_to_cpu(src->tx_abort);
+	dst->mpdus_requed = a_sle32_to_cpu(src->mpdus_requed);
+	dst->tx_ko = __le32_to_cpu(src->tx_ko);
+	dst->data_rc = __le32_to_cpu(src->data_rc);
+	dst->self_triggers = __le32_to_cpu(src->self_triggers);
+	dst->sw_retry_failure = __le32_to_cpu(src->sw_retry_failure);
+	dst->illgl_rate_phy_err = __le32_to_cpu(src->illgl_rate_phy_err);
+	dst->pdev_cont_xretry = __le32_to_cpu(src->pdev_cont_xretry);
+	dst->pdev_tx_timeout = __le32_to_cpu(src->pdev_tx_timeout);
+	dst->pdev_resets = __le32_to_cpu(src->pdev_resets);
+	dst->stateless_tid_alloc_failure =
+		__le32_to_cpu(src->stateless_tid_alloc_failure);
+	dst->phy_underrun = __le32_to_cpu(src->phy_underrun);
+	dst->txop_ovf = __le32_to_cpu(src->txop_ovf);
+}
+
+static void
+ath12k_wmi_pull_pdev_stats_rx(const struct ath12k_wmi_pdev_rx_stats_params *src,
+			      struct ath12k_fw_stats_pdev *dst)
+{
+	dst->mid_ppdu_route_change =
+		a_sle32_to_cpu(src->mid_ppdu_route_change);
+	dst->status_rcvd = a_sle32_to_cpu(src->status_rcvd);
+	dst->r0_frags = a_sle32_to_cpu(src->r0_frags);
+	dst->r1_frags = a_sle32_to_cpu(src->r1_frags);
+	dst->r2_frags = a_sle32_to_cpu(src->r2_frags);
+	dst->r3_frags = a_sle32_to_cpu(src->r3_frags);
+	dst->htt_msdus = a_sle32_to_cpu(src->htt_msdus);
+	dst->htt_mpdus = a_sle32_to_cpu(src->htt_mpdus);
+	dst->loc_msdus = a_sle32_to_cpu(src->loc_msdus);
+	dst->loc_mpdus = a_sle32_to_cpu(src->loc_mpdus);
+	dst->oversize_amsdu = a_sle32_to_cpu(src->oversize_amsdu);
+	dst->phy_errs = a_sle32_to_cpu(src->phy_errs);
+	dst->phy_err_drop = a_sle32_to_cpu(src->phy_err_drop);
+	dst->mpdu_errs = a_sle32_to_cpu(src->mpdu_errs);
+}
+
 static int ath12k_wmi_tlv_fw_stats_data_parse(struct ath12k_base *ab,
 					      struct wmi_tlv_fw_stats_parse *parse,
 					      const void *ptr,
@@ -7094,6 +7325,7 @@ static int ath12k_wmi_tlv_fw_stats_data_parse(struct ath12k_base *ab,
 
 	INIT_LIST_HEAD(&stats.vdevs);
 	INIT_LIST_HEAD(&stats.bcn);
+	INIT_LIST_HEAD(&stats.pdevs);
 
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch update stats ev");
@@ -7167,6 +7399,30 @@ static int ath12k_wmi_tlv_fw_stats_data_parse(struct ath12k_base *ab,
 		stats.stats_id = WMI_REQUEST_BCN_STAT;
 		list_add_tail(&dst->list, &stats.bcn);
 	}
+	for (i = 0; i < le32_to_cpu(ev->num_pdev_stats); i++) {
+		const struct ath12k_wmi_pdev_stats_params *src;
+		struct ath12k_fw_stats_pdev *dst;
+
+		src = data;
+		if (len < sizeof(*src)) {
+			ret = -EPROTO;
+			goto exit;
+		}
+
+		stats.stats_id = WMI_REQUEST_PDEV_STAT;
+
+		data += sizeof(*src);
+		len -= sizeof(*src);
+
+		dst = kzalloc(sizeof(*dst), GFP_ATOMIC);
+		if (!dst)
+			continue;
+
+		ath12k_wmi_pull_pdev_stats_base(&src->base, dst);
+		ath12k_wmi_pull_pdev_stats_tx(&src->tx, dst);
+		ath12k_wmi_pull_pdev_stats_rx(&src->rx, dst);
+		list_add_tail(&dst->list, &stats.pdevs);
+	}
 
 	complete(&ar->fw_stats_complete);
 	ath12k_debugfs_fw_stats_process(ar, &stats);
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index ec2664c62e53..2934d9589007 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -5664,6 +5664,7 @@ struct wmi_stats_event {
 } __packed;
 
 enum wmi_stats_id {
+	WMI_REQUEST_PDEV_STAT	= BIT(2),
 	WMI_REQUEST_VDEV_STAT	= BIT(3),
 	WMI_REQUEST_BCN_STAT	= BIT(11),
 };
@@ -5702,6 +5703,65 @@ struct ath12k_wmi_bcn_stats_params {
 	__le32 tx_bcn_outage_cnt;
 } __packed;
 
+struct ath12k_wmi_pdev_base_stats_params {
+	a_sle32 chan_nf;
+	__le32 tx_frame_count; /* Cycles spent transmitting frames */
+	__le32 rx_frame_count; /* Cycles spent receiving frames */
+	__le32 rx_clear_count; /* Total channel busy time, evidently */
+	__le32 cycle_count; /* Total on-channel time */
+	__le32 phy_err_count;
+	__le32 chan_tx_pwr;
+} __packed;
+
+struct ath12k_wmi_pdev_tx_stats_params {
+	a_sle32 comp_queued;
+	a_sle32 comp_delivered;
+	a_sle32 msdu_enqued;
+	a_sle32 mpdu_enqued;
+	a_sle32 wmm_drop;
+	a_sle32 local_enqued;
+	a_sle32 local_freed;
+	a_sle32 hw_queued;
+	a_sle32 hw_reaped;
+	a_sle32 underrun;
+	a_sle32 tx_abort;
+	a_sle32 mpdus_requed;
+	__le32 tx_ko;
+	__le32 data_rc;
+	__le32 self_triggers;
+	__le32 sw_retry_failure;
+	__le32 illgl_rate_phy_err;
+	__le32 pdev_cont_xretry;
+	__le32 pdev_tx_timeout;
+	__le32 pdev_resets;
+	__le32 stateless_tid_alloc_failure;
+	__le32 phy_underrun;
+	__le32 txop_ovf;
+} __packed;
+
+struct ath12k_wmi_pdev_rx_stats_params {
+	a_sle32 mid_ppdu_route_change;
+	a_sle32 status_rcvd;
+	a_sle32 r0_frags;
+	a_sle32 r1_frags;
+	a_sle32 r2_frags;
+	a_sle32 r3_frags;
+	a_sle32 htt_msdus;
+	a_sle32 htt_mpdus;
+	a_sle32 loc_msdus;
+	a_sle32 loc_mpdus;
+	a_sle32 oversize_amsdu;
+	a_sle32 phy_errs;
+	a_sle32 phy_err_drop;
+	a_sle32 mpdu_errs;
+} __packed;
+
+struct ath12k_wmi_pdev_stats_params {
+	struct ath12k_wmi_pdev_base_stats_params base;
+	struct ath12k_wmi_pdev_tx_stats_params tx;
+	struct ath12k_wmi_pdev_rx_stats_params rx;
+} __packed;
+
 struct ath12k_fw_stats_req_params {
 	u32 stats_id;
 	u32 vdev_id;
-- 
2.34.1


