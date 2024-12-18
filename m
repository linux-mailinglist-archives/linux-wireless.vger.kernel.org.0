Return-Path: <linux-wireless+bounces-16518-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D44F9F5D89
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 04:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8E1E189065D
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 03:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03C114A4F0;
	Wed, 18 Dec 2024 03:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KVMsXxJ5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F91A13AD11;
	Wed, 18 Dec 2024 03:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734493315; cv=none; b=WgT8r0cwWw+YfqgM/fPEn01XPTgLO74R4BoLVcJnMmT1miu+eJJGfeQasi35WmQaqZj5CGlf7j/ir54yuAeCXTWWMEi70yIxoZ22u97JwKPSRj7IrVT5yzYS6WZfN2dwMi5ysNgjoClZ/mlL5MIuxCYiSJr1mbKA9FnsxhKu17o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734493315; c=relaxed/simple;
	bh=EELvv7vk5PnBJ2PW6qYitDd+2nvsKxWuJvqc36vGOus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ZI3wRozLN5FWbiI5XSgKNBFcpjzlv3/dhDzzvdyw/V/Sl1BWjeTSL6/orJ46XI7PZg1O4rGyVNZPslM6/6HGrF/+D8lelrSqLs5X4T6V4pPWTFuqeYujZqgjRV+LYFqwqLgHSV5mdLDeGL8T/tMfJzokv7HRXBe4MTk49l44aAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KVMsXxJ5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHIJgQi013146;
	Wed, 18 Dec 2024 03:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t2a8oRMcfhoHgmYqLWousneWiOscrYBtaYv08MrX9mk=; b=KVMsXxJ5Uv1DUGKM
	wWSEM6za7AuLvU1rZ9O4EnNOYY8bld+t42T7973C9yYOlfk7haroQwCKULMhGS60
	KGUVfnBMeQKOcA7wB6z1cmJSp/SkYlCdrtUu3wfE4HgEga/1QIZ/Sj6IpmHw1MCD
	8EyAppIhj1UHVfS2Ky6f7w0GxiVR1F03h6DrIq79P7Dp7OPJt+3XPINzUi6WOAmf
	1So1Dvh8tmDNkHrdsdf3RsvhGYOczGrSUQq/dHEANLVnlua9VMcCeu3Z1+1ULFxV
	QkB9ysOvYn0FRiC7JxAr8FKVbe65eaqRqM2BkDfb8/ZlvtMrzK1tpeESVo9zbMUA
	OjOd9Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43kefxh248-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 03:41:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BI3flN1021648
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 03:41:47 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 17 Dec 2024 19:41:45 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Date: Wed, 18 Dec 2024 09:11:32 +0530
Subject: [PATCH 1/3] wifi: ath12k: rename CAC_RUNNING flag
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241218-ath12k_mlo_dfs-v1-1-058e783bcfc7@quicinc.com>
References: <20241218-ath12k_mlo_dfs-v1-0-058e783bcfc7@quicinc.com>
In-Reply-To: <20241218-ath12k_mlo_dfs-v1-0-058e783bcfc7@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tU8eNnKILtiAGuYHhP37uT_SvZ2z0xPl
X-Proofpoint-ORIG-GUID: tU8eNnKILtiAGuYHhP37uT_SvZ2z0xPl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 adultscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412180026

Rename the flag ATH12K_CAC_RUNNING to ATH12K_FLAG_CAC_RUNNING to correct
the naming inconsistency in the enum ath12k_dev_flags.

No functionality changes.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h  | 2 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c | 6 +++---
 drivers/net/wireless/ath/ath12k/mac.c   | 8 ++++----
 drivers/net/wireless/ath/ath12k/wmi.c   | 2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index ec61ad3d82c3bb9237cf327976e9f68e8c8f9cc7..f988c8b2490e699c29f3495dfc9fe4381574cc01 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -223,7 +223,7 @@ enum ath12k_hw_group_flags {
 };
 
 enum ath12k_dev_flags {
-	ATH12K_CAC_RUNNING,
+	ATH12K_FLAG_CAC_RUNNING,
 	ATH12K_FLAG_CRASH_FLUSH,
 	ATH12K_FLAG_RAW_MODE,
 	ATH12K_FLAG_HW_CRYPTO_DISABLED,
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 5c5a3aae393be52a241c048c5a60c57d1f8cea92..dad35bfd83f6271253361c618534933e83e7f7fb 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2632,7 +2632,7 @@ static void ath12k_dp_rx_process_received_packets(struct ath12k_base *ab,
 			continue;
 		}
 
-		if (test_bit(ATH12K_CAC_RUNNING, &ar->dev_flags)) {
+		if (test_bit(ATH12K_FLAG_CAC_RUNNING, &ar->dev_flags)) {
 			dev_kfree_skb_any(msdu);
 			continue;
 		}
@@ -3484,7 +3484,7 @@ ath12k_dp_process_rx_err_buf(struct ath12k *ar, struct hal_reo_dest_ring *desc,
 		goto exit;
 	}
 
-	if (test_bit(ATH12K_CAC_RUNNING, &ar->dev_flags)) {
+	if (test_bit(ATH12K_FLAG_CAC_RUNNING, &ar->dev_flags)) {
 		dev_kfree_skb_any(msdu);
 		goto exit;
 	}
@@ -4037,7 +4037,7 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 			continue;
 		}
 
-		if (test_bit(ATH12K_CAC_RUNNING, &ar->dev_flags)) {
+		if (test_bit(ATH12K_FLAG_CAC_RUNNING, &ar->dev_flags)) {
 			dev_kfree_skb_any(msdu);
 			continue;
 		}
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 186765fa95f5302b8188419cbf6073624413a774..c61b1519cc91c6a476e1510b4cf13f80c89a793a 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1323,8 +1323,8 @@ int ath12k_mac_vdev_stop(struct ath12k_link_vif *arvif)
 	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "vdev %pM stopped, vdev_id %d\n",
 		   ahvif->vif->addr, arvif->vdev_id);
 
-	if (test_bit(ATH12K_CAC_RUNNING, &ar->dev_flags)) {
-		clear_bit(ATH12K_CAC_RUNNING, &ar->dev_flags);
+	if (test_bit(ATH12K_FLAG_CAC_RUNNING, &ar->dev_flags)) {
+		clear_bit(ATH12K_FLAG_CAC_RUNNING, &ar->dev_flags);
 		ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "CAC Stopped for vdev %d\n",
 			   arvif->vdev_id);
 	}
@@ -7463,7 +7463,7 @@ static void ath12k_mac_stop(struct ath12k *ar)
 		ath12k_err(ar->ab, "failed to clear rx_filter for monitor status ring: (%d)\n",
 			   ret);
 
-	clear_bit(ATH12K_CAC_RUNNING, &ar->dev_flags);
+	clear_bit(ATH12K_FLAG_CAC_RUNNING, &ar->dev_flags);
 
 	cancel_delayed_work_sync(&ar->scan.timeout);
 	wiphy_work_cancel(ath12k_ar_to_hw(ar)->wiphy, &ar->scan.vdev_clean_wk);
@@ -8782,7 +8782,7 @@ ath12k_mac_vdev_start_restart(struct ath12k_link_vif *arvif,
 	if (arvif->ahvif->vdev_type == WMI_VDEV_TYPE_AP &&
 	    chandef->chan->dfs_cac_ms &&
 	    chandef->chan->dfs_state == NL80211_DFS_USABLE) {
-		set_bit(ATH12K_CAC_RUNNING, &ar->dev_flags);
+		set_bit(ATH12K_FLAG_CAC_RUNNING, &ar->dev_flags);
 		ath12k_dbg(ab, ATH12K_DBG_MAC,
 			   "CAC Started in chan_freq %d for vdev %d\n",
 			   arg.freq, arg.vdev_id);
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 562b0615ed065d094f5d7709cafeb22c41f02d17..d0ae7f142c11ab4720bf95c0c95990ff40bd2815 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6212,7 +6212,7 @@ static void ath12k_mgmt_rx_event(struct ath12k_base *ab, struct sk_buff *skb)
 		goto exit;
 	}
 
-	if ((test_bit(ATH12K_CAC_RUNNING, &ar->dev_flags)) ||
+	if ((test_bit(ATH12K_FLAG_CAC_RUNNING, &ar->dev_flags)) ||
 	    (rx_ev.status & (WMI_RX_STATUS_ERR_DECRYPT |
 			     WMI_RX_STATUS_ERR_KEY_CACHE_MISS |
 			     WMI_RX_STATUS_ERR_CRC))) {

-- 
2.34.1


