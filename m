Return-Path: <linux-wireless+bounces-17028-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD4EA0042C
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 07:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ABF0163017
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 06:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97FC158D80;
	Fri,  3 Jan 2025 06:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BaXt7mEC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2B813C9D9
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jan 2025 06:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735885289; cv=none; b=nCbn80axaNWKJWDuqCsnUSSJ3Ii6A8y+nDmD8md2GKuwm0wXeoUMm5PjV5mMxeCRRqjmKsGoqG9pkd1nfIzTMx9TfFNYjcbijomxQtPIRMXoT6zQsOCnYO35rzOTR+7VIfsrFga/eTPm30oqcpTjOXz4TmXU8mo6VTOivyoOIUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735885289; c=relaxed/simple;
	bh=gniF1O7CsGb5fIocHFTDoqEY2yL3GpZOwJstMUGzMeI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fP7sUBiSbO0aR3E4+VwYCeWHYwns4UZMRUXxO8jY+0F1DR2r0PmQxRkMC5LMsmwsaO9bAJxug8m3a+Wu+hqs7dlg3XOnl8pPERW8jnw0iNeFI0DIA4pqY85qgt4FcU3DNPp5KKIr9t+QsptIIkPd4zj+zPQgaa5KdspNlO602oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BaXt7mEC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5031hYtY016503;
	Fri, 3 Jan 2025 06:21:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j6eap41FSXrGGIp+9P7B5aqT1/UKYZFFUNQzmQk6Iuc=; b=BaXt7mECblN0AB63
	mdJnR9wIUNMqEA/0sOw+vyj/4andjsO9IA/k8AlzPn+RsByPR5JJqzIfwgrnHk1K
	5aP8scI2mb4Vzbf+nL/AyANne/gX4TjcdG5nFuiiB6Lk0a+GooF+5om2usNR9sR2
	6BfwGhgfSZiXd/n0MFNNLz3JS7Np2/ax37q/C0dCjd/4w8ZATmFSVA6h5pNF3uJJ
	52CLotR6WsaOpXHcQr0ijVNpj/mQXUxx5dU3FLcZNP1urblXd540ahtsHuCxaOB9
	zWeUe6iPnd2tPOchen42RXYUaGN4a1GwTAltSvY9JYWo3YhYA5l10J1ZEcpqjLwO
	fauXyQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43x6g0gg9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jan 2025 06:21:12 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5036L8Ns009942
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 Jan 2025 06:21:08 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 2 Jan 2025 22:21:06 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v5 2/3] wifi: ath12k: properly handling the state variables of monitor mode
Date: Fri, 3 Jan 2025 14:20:40 +0800
Message-ID: <20250103062041.1857-3-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20250103062041.1857-1-quic_kangyang@quicinc.com>
References: <20250103062041.1857-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-GUID: _08OuLvyVaulY9dpRk20rdq_mezrcJw7
X-Proofpoint-ORIG-GUID: _08OuLvyVaulY9dpRk20rdq_mezrcJw7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 mlxscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501030053

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
 drivers/net/wireless/ath/ath12k/mac.c  | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 0c6b35aac96e..cf471acb75e1 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1261,6 +1261,11 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
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
index 6f10813d9378..8b99d01b32e6 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7947,6 +7947,9 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 			goto err_peer_del;
 		}
 		break;
+	case WMI_VDEV_TYPE_MONITOR:
+		ar->monitor_vdev_created = true;
+		break;
 	default:
 		break;
 	}
@@ -7993,6 +7996,10 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 
 err_vdev_del:
 	ath12k_wmi_vdev_delete(ar, arvif->vdev_id);
+	if (ahvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
+		ar->monitor_vdev_created = false;
+		ar->monitor_vdev_id = -1;
+	}
 	ar->num_created_vdevs--;
 	arvif->is_created = false;
 	arvif->ar = NULL;
@@ -11057,6 +11064,10 @@ static void ath12k_mac_setup(struct ath12k *ar)
 	ar->num_tx_chains = hweight32(pdev->cap.tx_chain_mask);
 	ar->num_rx_chains = hweight32(pdev->cap.rx_chain_mask);
 	ar->scan.arvif = NULL;
+	ar->monitor_vdev_id = -1;
+	ar->monitor_started = false;
+	ar->monitor_vdev_created = false;
+	ar->monitor_conf_enabled = false;
 
 	spin_lock_init(&ar->data_lock);
 	INIT_LIST_HEAD(&ar->arvifs);
-- 
2.34.1


