Return-Path: <linux-wireless+bounces-2321-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CE0836246
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 12:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2791F2670F
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 11:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEED73D97F;
	Mon, 22 Jan 2024 11:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IJSKF3kn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B71E3D975
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jan 2024 11:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923580; cv=none; b=BZEogOpKc5GH+WOmT+Yym4+j8g3pULknjYNQffJRQaKH143H9BQ7VoFPR3hpH4Jh6Pv3h9Omnb52nqy1KtEvONjdG3N1LqPRhpmXiMDxfIJ4AciW4y0HHEuVQ7MaYgQIOxDwNreAZlSez9oaCPEIapm//hZXa1ma4vrrHRlpB7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923580; c=relaxed/simple;
	bh=1dd9zL0n6zG1xww5irneqabHF5L4QVGMooqBYJP4jaA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CYI6jvTsVx/yePbGmPiCDqMVHODfEPc4vUqqQO0tiaYiFQn7mgMMZ7d+FM3A5uYqMCMH+iEGrYFTkSNy/96EU63oJ/LY2NA2vZpdtHiuvlUeYKYoNA/AA2tPxayq2W+qaowX6+rci3rUvPU2QX7UXO2DNXyG5V9RWPz3orlOT+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IJSKF3kn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40M5ma7B000337;
	Mon, 22 Jan 2024 11:39:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=955ENI/v172A5+QEJTHcaiyn9W+17q3OueWXK8oLj+M=; b=IJ
	SKF3kn6qgLVV6j5DPNZcwP2D3KDwWlaKH4R9Zj3xwT4zL5UHVjhgAKaEdAQEojOe
	Xk0xObPdoRpYt+kvfM+4ZUNXtYU21ptozV/zKfeZqFOfvv/GzsW+GCPFSZk2MK2s
	iTfSrdRp8yWFQnj0g6fKOTwPHMyZqNbqf97llKmvU7CL7vnvmA+ei6YxR6q8/lgQ
	qwXY6rpbQkxUqPB4PilzlNWu+rqruQFGza6GRmasNX4zTpa35ejKVuZaIANYAK/p
	EIgdpHlHiUbsKfdRldbPfpcq1EQlUCsG77ERfUDmEF1evXt+f5kby/JWKKUib1DN
	ACQ8ScARDUZCmhsEsA7w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vr7bqknc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 11:39:36 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40MBdab9025412
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 11:39:36 GMT
Received: from yk-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 03:39:34 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v3 08/10] wifi: ath12k: move peer delete after vdev stop of station for WCN7850
Date: Mon, 22 Jan 2024 19:39:02 +0800
Message-ID: <20240122113904.8938-9-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122113904.8938-1-quic_kangyang@quicinc.com>
References: <20240122113904.8938-1-quic_kangyang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mkHN_K2ErH6zm51LvgEBNaC4PfPFWdVF
X-Proofpoint-ORIG-GUID: mkHN_K2ErH6zm51LvgEBNaC4PfPFWdVF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_02,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0
 clxscore=1015 spamscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220083

In current code, when STA/P2P Client connect to AP/P2P GO, the WMI
command sequence is:

peer_create->vdev_start->vdev_up

And sequence of STA/P2P Client disconnect from AP/P2P GO is:

peer_delete->vdev_down->vdev_stop

This sequence of disconnect is not opposite of connect. For STA or P2P
GO, bss peer is not needed by firmware during handling vdev stop
command. So with this sequence, STA and P2P GO can work normally.

But for P2P Client, firmware needs bss peer in some functions during
handling vdev stop command. The opposite sequence of disconnect should
be:

vdev_down->vdev_stop->peer_delete

So change the sequence of disconnect as above opposite sequence for
WCN7850.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---

v3: no change.
v2: add Tested-on tag of QCN9274.

---
 drivers/net/wireless/ath/ath12k/mac.c | 99 +++++++++++++++------------
 1 file changed, 54 insertions(+), 45 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 65ac1d0b52a4..10aa8b20ef7a 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1083,6 +1083,46 @@ static int ath12k_mac_monitor_stop(struct ath12k *ar)
 	return ret;
 }
 
+static int ath12k_mac_vdev_stop(struct ath12k_vif *arvif)
+{
+	struct ath12k *ar = arvif->ar;
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	reinit_completion(&ar->vdev_setup_done);
+
+	ret = ath12k_wmi_vdev_stop(ar, arvif->vdev_id);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to stop WMI vdev %i: %d\n",
+			    arvif->vdev_id, ret);
+		goto err;
+	}
+
+	ret = ath12k_mac_vdev_setup_sync(ar);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to synchronize setup for vdev %i: %d\n",
+			    arvif->vdev_id, ret);
+		goto err;
+	}
+
+	WARN_ON(ar->num_started_vdevs == 0);
+
+	ar->num_started_vdevs--;
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "vdev %pM stopped, vdev_id %d\n",
+		   arvif->vif->addr, arvif->vdev_id);
+
+	if (test_bit(ATH12K_CAC_RUNNING, &ar->dev_flags)) {
+		clear_bit(ATH12K_CAC_RUNNING, &ar->dev_flags);
+		ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "CAC Stopped for vdev %d\n",
+			   arvif->vdev_id);
+	}
+
+	return 0;
+err:
+	return ret;
+}
+
 static int ath12k_mac_config(struct ath12k *ar, u32 changed)
 {
 	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
@@ -3905,6 +3945,13 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 				    sta->addr, arvif->vdev_id);
 	} else if ((old_state == IEEE80211_STA_NONE &&
 		    new_state == IEEE80211_STA_NOTEXIST)) {
+		if (arvif->vdev_type == WMI_VDEV_TYPE_STA) {
+			ath12k_bss_disassoc(ar, arvif);
+			ret = ath12k_mac_vdev_stop(arvif);
+			if (ret)
+				ath12k_warn(ar->ab, "failed to stop vdev %i: %d\n",
+					    arvif->vdev_id, ret);
+		}
 		ath12k_dp_peer_cleanup(ar, arvif->vdev_id, sta->addr);
 
 		ret = ath12k_peer_delete(ar, arvif->vdev_id, sta->addr);
@@ -6336,46 +6383,6 @@ ath12k_mac_vdev_start_restart(struct ath12k_vif *arvif,
 	return 0;
 }
 
-static int ath12k_mac_vdev_stop(struct ath12k_vif *arvif)
-{
-	struct ath12k *ar = arvif->ar;
-	int ret;
-
-	lockdep_assert_held(&ar->conf_mutex);
-
-	reinit_completion(&ar->vdev_setup_done);
-
-	ret = ath12k_wmi_vdev_stop(ar, arvif->vdev_id);
-	if (ret) {
-		ath12k_warn(ar->ab, "failed to stop WMI vdev %i: %d\n",
-			    arvif->vdev_id, ret);
-		goto err;
-	}
-
-	ret = ath12k_mac_vdev_setup_sync(ar);
-	if (ret) {
-		ath12k_warn(ar->ab, "failed to synchronize setup for vdev %i: %d\n",
-			    arvif->vdev_id, ret);
-		goto err;
-	}
-
-	WARN_ON(ar->num_started_vdevs == 0);
-
-	ar->num_started_vdevs--;
-	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "vdev %pM stopped, vdev_id %d\n",
-		   arvif->vif->addr, arvif->vdev_id);
-
-	if (test_bit(ATH12K_CAC_RUNNING, &ar->dev_flags)) {
-		clear_bit(ATH12K_CAC_RUNNING, &ar->dev_flags);
-		ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "CAC Stopped for vdev %d\n",
-			   arvif->vdev_id);
-	}
-
-	return 0;
-err:
-	return ret;
-}
-
 static int ath12k_mac_vdev_start(struct ath12k_vif *arvif,
 				 struct ieee80211_chanctx_conf *ctx)
 {
@@ -6742,11 +6749,13 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 		arvif->is_started = false;
 	}
 
-	ret = ath12k_mac_vdev_stop(arvif);
-	if (ret)
-		ath12k_warn(ab, "failed to stop vdev %i: %d\n",
-			    arvif->vdev_id, ret);
-
+	if (arvif->vdev_type != WMI_VDEV_TYPE_STA) {
+		ath12k_bss_disassoc(ar, arvif);
+		ret = ath12k_mac_vdev_stop(arvif);
+		if (ret)
+			ath12k_warn(ab, "failed to stop vdev %i: %d\n",
+				    arvif->vdev_id, ret);
+	}
 	arvif->is_started = false;
 
 	if (ab->hw_params->vdev_start_delay &&
-- 
2.34.1


