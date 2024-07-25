Return-Path: <linux-wireless+bounces-10510-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E123C93C15A
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 14:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D3051F22B05
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 12:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780A7199EA5;
	Thu, 25 Jul 2024 12:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cIUu2S/0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E693D1990CD
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jul 2024 12:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721908874; cv=none; b=R7Lij6KmzWsvaapYPGB/0sxnM0CyK3c5qE2RyAjrTnHzoPuiKbQoUXdXBwn1K5q9zu/r3YPiAWrctKsl9vmgC00xvruzNK73jmo75DUONaK1LD8sA4X1eOaDty0Lq4ESMGgpRUPh6oNL6+P0fYs0zV7Lip9j8sO2FSS8yoY5wzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721908874; c=relaxed/simple;
	bh=Qz4KPLZ02Y6ZdmQ09k4HVvim9Oo44fePfA0guUYBbrs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GRuTdSG1s/W6poig2v9cAlL2NYrbk5YSHCYt4UHmCxJ6OBSzKeUtSx0u6oAtvyg9ORbmnzeADdm0mY8pJZZeK7kys0BfIgN6re0ZsvvN/t9qzT6lsbKXDRhdrc0JxI/5pu2Eir7m6Ey4blC5QL6gvdbZeG3qiscS6IfAC/529XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cIUu2S/0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46P9B5fP018291;
	Thu, 25 Jul 2024 12:01:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fcJgsuGYJifMQU507Q45xqvyY9WgRFd9SdPoGyOI/Ww=; b=cIUu2S/097vLT6jy
	/+86HvJfpz12XKdmrH3SXJhwW/nuDm9e9aWlfoHvEFykfLLtq7TOtm96p8x8jGf/
	7Cu8UY7Asll2LlDuE3bmBuHzacVbm2Otl1E2rEcXJBdp5zHCWwMA0rA56uxMqqOs
	7wN4qEcg/IvuFAv33+4Z79CjYBeX1LAppC2PT+czKx+A5jS/wz4yfgwNuhGYHNCB
	Fv1MlTxCfp+n8simc0kMteuxhv+csG9QRCEhKyOdVEdeU5YPeAicWekQUueTN+sM
	lKYK/wUzqCxNKlA0FjVKxkcG/C3XzctppyNBEGlkzFX/veR7mQtWwSkb6pD/eGYD
	3GbTeQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g2xen8sf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 12:01:10 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46PC19qT013652
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 12:01:09 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 25 Jul 2024 05:01:08 -0700
From: kangyang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH 07/11] wifi: ath12k: properly handling the state variables of monitor mode
Date: Thu, 25 Jul 2024 20:00:31 +0800
Message-ID: <20240725120035.493-8-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20240725120035.493-1-quic_kangyang@quicinc.com>
References: <20240725120035.493-1-quic_kangyang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vQhPLetgxIFWTCx2s0oXSt5TVQjmyDzQ
X-Proofpoint-ORIG-GUID: vQhPLetgxIFWTCx2s0oXSt5TVQjmyDzQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_11,2024-07-25_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407250082

From: Kang Yang <quic_kangyang@quicinc.com>

Now monitor mode has some status variables, such as monitor_started,
monitor_vdev_created. They are not always handled correctly.

For monitor_started, it should be true when driver works in monitor
mode, and should be false at other times.

For monitor_vdev_id, it should be -1 when driver doesn't work in monitor
mode.

For monitor_vdev_created, it should be true after monitor vdev is
created successfully and should be false at other times.

For monitor_conf_enabled, it should be true when mac80211 sets
IEEE80211_CONF_MONITOR, and should be false at other times.

Handle those state variables according to above descriptions.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c |  5 +++++
 drivers/net/wireless/ath/ath12k/mac.c  | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 51252e8bc1ae..6965876137ce 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1060,6 +1060,11 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 				     ath12k_mac_tx_mgmt_pending_free, ar);
 			idr_destroy(&ar->txmgmt_idr);
 			wake_up(&ar->txmgmt_empty_waitq);
+
+			ar->monitor_vdev_id = -1;
+			ar->monitor_started = false;
+			ar->monitor_vdev_created = false;
+			ar->monitor_conf_enabled = false;
 		}
 	}
 
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 8106297f0bc1..642d756db663 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -6565,6 +6565,9 @@ static int ath12k_mac_vdev_create(struct ath12k *ar, struct ieee80211_vif *vif)
 			goto err_peer_del;
 		}
 		break;
+	case WMI_VDEV_TYPE_MONITOR:
+		ar->monitor_vdev_created = true;
+		break;
 	default:
 		break;
 	}
@@ -6614,6 +6617,8 @@ static int ath12k_mac_vdev_create(struct ath12k *ar, struct ieee80211_vif *vif)
 err_vdev_del:
 	ath12k_wmi_vdev_delete(ar, arvif->vdev_id);
 	ar->num_created_vdevs--;
+	ar->monitor_vdev_created = false;
+	ar->monitor_vdev_id = -1;
 	arvif->is_created = false;
 	arvif->ar = NULL;
 	ar->allocated_vdev_map &= ~(1LL << arvif->vdev_id);
@@ -9330,6 +9335,11 @@ static void ath12k_mac_setup(struct ath12k *ar)
 
 	INIT_WORK(&ar->wmi_mgmt_tx_work, ath12k_mgmt_over_wmi_tx_work);
 	skb_queue_head_init(&ar->wmi_mgmt_tx_queue);
+
+	ar->monitor_vdev_id = -1;
+	ar->monitor_started = false;
+	ar->monitor_vdev_created = false;
+	ar->monitor_conf_enabled = false;
 }
 
 int ath12k_mac_register(struct ath12k_base *ab)
-- 
2.34.1


