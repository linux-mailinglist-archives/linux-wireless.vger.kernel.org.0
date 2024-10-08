Return-Path: <linux-wireless+bounces-13709-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F43994101
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 10:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 811061C213BE
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 08:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423391D417C;
	Tue,  8 Oct 2024 07:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DDyAyrmR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AB81D6DD4
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 07:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728372976; cv=none; b=hdVnIEEiJzDVrbRYRNMX2iRRol2ifDyh9GC4hLpOiKOeZ99mpiVoVezfRuZV9L9oq7ZNHlh93VYUX00/I12hZ2l6vxfKvif2F0v88rwcJ4wMlzvrNMvcrHQFBs69CSAG9flCExmWvBrS6HQCRXUnGeoZQ7nUd9x5K5P40h/6Y4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728372976; c=relaxed/simple;
	bh=wKH7znX0GzxvBMTZWcjXtxK7qQEPDwAjaMWwsB2kA5g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=imRVoOh2x5bF+UJJ46EnQOYLQ2WQ0GgqzlyQpB4SiTalQVl9hX0ERnixUmWN0jYqyt4KRmJ720ScCdDLP2QA74aBzT6pw0YkUDDSs6pepzw11bGVifA/HIXxiEWZr79H1zZIhlterK6qjSyJEgg0Vm2hPvsnG4ZAweeuS7/64e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DDyAyrmR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4986HT72025511;
	Tue, 8 Oct 2024 07:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PkYjWUfeckB0xwDB86Xq5qNJ2J/s2Nay9l2ypLnvcEI=; b=DDyAyrmRtYPi2t5w
	TEUTZy046c7VatkPArdUXHptjW0xb814BMURB2dqDEffSGnu1GAkS9gY3iHQzy89
	3Ji9bS9cAjYpa2QjeJDB0J6k83GethdUt7hkXc+vIzZbJUf6ZlwnZuUJZi30PPwr
	o3oPNWhp6oZrs7gzIys/t93oQDgJcYNfh+yQImVD0BuBoQjhiNJZG/SiK5LwOrKg
	tvtRYEMPZw3o2Ya7cXd8Dy3MuU2B8W1XB/lryooGHinQMjIuuthbn9tr28BDWZKV
	ovCPU5OgaY7g05Az1BoT3x6wQIiC7huc+GdQwbYngT1lcA47sr9Tw2iEV3CO0hFt
	nC7IuQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 422xs86h33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 07:36:11 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4987aAje010751
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Oct 2024 07:36:10 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 8 Oct 2024 00:36:09 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v2 07/11] wifi: ath12k: properly handling the state variables of monitor mode
Date: Tue, 8 Oct 2024 15:35:30 +0800
Message-ID: <20241008073534.1195-8-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20241008073534.1195-1-quic_kangyang@quicinc.com>
References: <20241008073534.1195-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-GUID: S4T81q0BpS-z8uYP30Me7TASsGBNhaLh
X-Proofpoint-ORIG-GUID: S4T81q0BpS-z8uYP30Me7TASsGBNhaLh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080048

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
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
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
index 6d0784a21558..2001d82f8d40 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -6573,6 +6573,9 @@ static int ath12k_mac_vdev_create(struct ath12k *ar, struct ieee80211_vif *vif)
 			goto err_peer_del;
 		}
 		break;
+	case WMI_VDEV_TYPE_MONITOR:
+		ar->monitor_vdev_created = true;
+		break;
 	default:
 		break;
 	}
@@ -6622,6 +6625,8 @@ static int ath12k_mac_vdev_create(struct ath12k *ar, struct ieee80211_vif *vif)
 err_vdev_del:
 	ath12k_wmi_vdev_delete(ar, arvif->vdev_id);
 	ar->num_created_vdevs--;
+	ar->monitor_vdev_created = false;
+	ar->monitor_vdev_id = -1;
 	arvif->is_created = false;
 	arvif->ar = NULL;
 	ar->allocated_vdev_map &= ~(1LL << arvif->vdev_id);
@@ -9339,6 +9344,11 @@ static void ath12k_mac_setup(struct ath12k *ar)
 
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


