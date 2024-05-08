Return-Path: <linux-wireless+bounces-7357-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCFF8C05AD
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 22:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED371C20B05
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 20:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19924130E32;
	Wed,  8 May 2024 20:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZQ//Nate"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F044130AD3
	for <linux-wireless@vger.kernel.org>; Wed,  8 May 2024 20:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715200179; cv=none; b=lEbhM9oZs5OUYIcBZCC+EvBr7qPNAsqHf5i0TQv+/IpGLx53sV8nJwICGNu6Lj3t5NUTgXMqxw3asz2DtdIHbbjC9CbWOHw4lvuH/96ZNOMFZGtysPqOcNFxVsn2ASxAb3p3sJ0FFJJuBQdyyS/tQGTGhQOug2MJRvW7VDCp+9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715200179; c=relaxed/simple;
	bh=FXNZAYjsufCCs8WDc/c5MxHovHijGfVG8pxfe+EQ9H4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PhC7WwEYP7c3VrLkH3kFhtvGRSPMA+iCF1+kQBw1i05fSMtgarWR2hCV6eaKTjAB7kgP6p+m7MsKTCeD8xm5ztso1gngs4FsoaawVKT5RazkCBT10ekmf+e0c44Zqlkb9TPlM1JyhAu7tNS9oCsg2y+4WQ5zgs8XQmySDDV71G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZQ//Nate; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 448C5Jik030119;
	Wed, 8 May 2024 20:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=/40iWCr2ZViJTJZshhpjGDe8vMVcacYlaJEU7CLnSxg=; b=ZQ
	//NateuzZjUfnXz1E4h2TzcqVxfzHvGrb4BSjVDFjMO+WUWKVhlyNv7IxLUhubml
	yjZJAy7Ic9sWTuZoqdFZkWtm+YEblIn2RaFrdNE3vr9/8z1NSr2wvSc83fAnQhzJ
	vKCUGhghD2WmqG87zdtXasN9c3wV8TtsDwEuvbV+VVhOp/6E57EG6lVNM5WX6GNe
	iFuXCH7Y6F0poxQSUsD/2exzGUkSGfSAPTPo5VZ1ZfDHs9wDnbP45Rp06lYnOfFf
	1KJHCM3YjxqwqemhNq05H7y2qAesxYkocbaNb1tsvcG9EGVkoLicV8qW0RtbGrNt
	ffinjJRaMpNP8TTvTOdA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y0930s4nd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 20:29:29 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 448KTOmX023157
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 May 2024 20:29:24 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 8 May 2024 13:29:24 -0700
From: Aloka Dixit <quic_alokad@quicinc.com>
To: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC: Aloka Dixit <quic_alokad@quicinc.com>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
Subject: [PATCH v2 5/9] wifi: ath12k: configure MBSSID parameters in AP mode
Date: Wed, 8 May 2024 13:29:08 -0700
Message-ID: <20240508202912.11902-6-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240508202912.11902-1-quic_alokad@quicinc.com>
References: <20240508202912.11902-1-quic_alokad@quicinc.com>
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
X-Proofpoint-GUID: gnm7Br0q0qRMfPinEljibHKc1avJDsS7
X-Proofpoint-ORIG-GUID: gnm7Br0q0qRMfPinEljibHKc1avJDsS7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 mlxlogscore=959 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405080151

Include MBSSID parameters in WMI vdev up operation.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 15 ++++++++++++++-
 drivers/net/wireless/ath/ath12k/wmi.c |  6 ++++++
 drivers/net/wireless/ath/ath12k/wmi.h |  3 +++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 8068519828b7..97bb50e04b00 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1395,6 +1395,11 @@ static void ath12k_control_beaconing(struct ath12k_vif *arvif,
 	params.vdev_id = arvif->vdev_id;
 	params.aid = arvif->aid;
 	params.bssid = arvif->bssid;
+	if (arvif->vif->mbssid_tx_vif) {
+		params.tx_bssid = ath12k_vif_to_arvif(arvif->vif->mbssid_tx_vif)->bssid;
+		params.nontx_profile_idx = info->bssid_index;
+		params.nontx_profile_cnt = 1 << info->bssid_indicator;
+	}
 	ret = ath12k_wmi_vdev_up(arvif->ar, &params);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to bring up vdev %d: %i\n",
@@ -7125,6 +7130,7 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 {
 	struct ath12k_wmi_vdev_up_params params = {};
 	struct ath12k_base *ab = ar->ab;
+	struct ieee80211_vif *vif;
 	struct ath12k_vif *arvif;
 	int ret;
 	int i;
@@ -7167,7 +7173,8 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 	/* TODO: Update ar->rx_channel */
 
 	for (i = 0; i < n_vifs; i++) {
-		arvif = ath12k_vif_to_arvif(vifs[i].vif);
+		vif = vifs[i].vif;
+		arvif = ath12k_vif_to_arvif(vif);
 
 		if (WARN_ON(!arvif->is_started))
 			continue;
@@ -7204,9 +7211,15 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 			ath12k_warn(ab, "failed to update bcn tmpl during csa: %d\n",
 				    ret);
 
+		memset(&params, 0, sizeof(params));
 		params.vdev_id = arvif->vdev_id;
 		params.aid = arvif->aid;
 		params.bssid = arvif->bssid;
+		if (vif->mbssid_tx_vif) {
+			params.tx_bssid = ath12k_vif_to_arvif(vif->mbssid_tx_vif)->bssid;
+			params.nontx_profile_idx = vif->bss_conf.bssid_index;
+			params.nontx_profile_cnt = 1 << vif->bss_conf.bssid_indicator;
+		}
 		ret = ath12k_wmi_vdev_up(arvif->ar, &params);
 		if (ret) {
 			ath12k_warn(ab, "failed to bring vdev up %d: %d\n",
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index bed5ca00305d..1c179b218144 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -1123,6 +1123,12 @@ int ath12k_wmi_vdev_up(struct ath12k *ar, struct ath12k_wmi_vdev_up_params *para
 
 	ether_addr_copy(cmd->vdev_bssid.addr, params->bssid);
 
+	if (params->tx_bssid) {
+		ether_addr_copy(cmd->tx_vdev_bssid.addr, params->tx_bssid);
+		cmd->nontx_profile_idx = cpu_to_le32(params->nontx_profile_idx);
+		cmd->nontx_profile_cnt = cpu_to_le32(params->nontx_profile_cnt);
+	}
+
 	ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
 		   "WMI mgmt vdev up id 0x%x assoc id %d bssid %pM\n",
 		   params->vdev_id, params->aid, params->bssid);
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 12c6cfb943c8..9b0166a5a575 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2767,6 +2767,9 @@ struct ath12k_wmi_vdev_up_params {
 	u32 vdev_id;
 	u32 aid;
 	const u8 *bssid;
+	const u8 *tx_bssid;
+	u32 nontx_profile_idx;
+	u32 nontx_profile_cnt;
 };
 
 struct wmi_vdev_up_cmd {
-- 
2.39.0


