Return-Path: <linux-wireless+bounces-7362-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F21788C05B3
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 22:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A929D283703
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 20:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F581311B9;
	Wed,  8 May 2024 20:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bW6L3g1U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2340F130E39
	for <linux-wireless@vger.kernel.org>; Wed,  8 May 2024 20:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715200181; cv=none; b=IvjF+tI2vIXQs4CEeQ393an1+7HTVmlvjkoPSaZkva+SfeYZiyK4T64QIxWxZ4Pb5bG4GkEkDQC9Fx3dwulr6MNRjU8gGti3PXgiCQxnz2awssNdRM2pYaSVj6kB4nvkFFiCs6fg0IZweg5TupY7sB6qXvpJ7HJR+4maRlVB4WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715200181; c=relaxed/simple;
	bh=Q0Xjl2X6dt9RKrc9sxW1XdG1Ssmjb4xu59rh+K/JR2o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hQRva2pQ1WCAGb7lWHo3z5cDI7BYLHZdUYS5U7CiERe8oz0A4wsK7fUO0rhvgIfLOXkjehRdgGKGvnLd5nS5jrGrRdX9g/kBtiFnR8obdrNMhg5ItbQjO200CHtnNG/5ENbIQfD1W5p76vnphFcd88L3rBCwgDf1kA3sCiHBsGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bW6L3g1U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 448AeOF8008072;
	Wed, 8 May 2024 20:29:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=0ZuRNs27s83GbhPaewWhA6paRd7KTiyfKroep0mhOxE=; b=bW
	6L3g1U+8sPANA8hYT1/xl8gzNs6aY6CkJhPTspq/z/CaliU7iykfTZm5qkM24axM
	ZpL5c4ZaJNYgQcaLS0QOFxpY4hueWaZ0ECFy8zQrkPhgVhwZx/FSOjXAzTlAgF7m
	rUT8/dlTEOUwGpEpWzMd/q405ALgMkdzwcHU1jFXhAMKysEDLiI9eCICm9EurbZ6
	PugwdaeYReMsF8LDlE6gf3NPoprY5y45/dHswLuToyyCz0XoIdmFTygeOupILynl
	glssJcnMWmG0UmFIgw0s/ZbXOaG18QtF+uUnNgksApGU38AsqYdYCACSdUly6NSO
	P/ANCbsRkduIhsoSFR7A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y07u0h9y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 20:29:27 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 448KTOSC009212
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
Subject: [PATCH v2 4/9] wifi: ath12k: create a structure for WMI vdev up parameters
Date: Wed, 8 May 2024 13:29:07 -0700
Message-ID: <20240508202912.11902-5-quic_alokad@quicinc.com>
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
X-Proofpoint-GUID: YgDRxmkTKnpV2_pzzqkGdW-HQvHZja5i
X-Proofpoint-ORIG-GUID: YgDRxmkTKnpV2_pzzqkGdW-HQvHZja5i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405080151

Host needs to send multiple BSSID configurations to firmware for
each vdev in ath12k_wmi_vdev_up() for AP mode. This function accepts
individual input parameters hence any new argument will require changes
to all callers. Most of these will use default value (0 or NULL).
Create a structure for the function arguments and include objects with
all members initialized to zero to minimize future changes.

Tested-on : QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 30 ++++++++++++++++++++-------
 drivers/net/wireless/ath/ath12k/wmi.c | 10 ++++-----
 drivers/net/wireless/ath/ath12k/wmi.h |  9 ++++++--
 3 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 32d370c8e756..8068519828b7 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -863,9 +863,12 @@ static int ath12k_mac_vdev_setup_sync(struct ath12k *ar)
 
 static int ath12k_monitor_vdev_up(struct ath12k *ar, int vdev_id)
 {
+	struct ath12k_wmi_vdev_up_params params = {};
 	int ret;
 
-	ret = ath12k_wmi_vdev_up(ar, vdev_id, 0, ar->mac_addr);
+	params.vdev_id = vdev_id;
+	params.bssid = ar->mac_addr;
+	ret = ath12k_wmi_vdev_up(ar, &params);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to put up monitor vdev %i: %d\n",
 			    vdev_id, ret);
@@ -882,6 +885,7 @@ static int ath12k_mac_monitor_vdev_start(struct ath12k *ar, int vdev_id,
 {
 	struct ieee80211_channel *channel;
 	struct wmi_vdev_start_req_arg arg = {};
+	struct ath12k_wmi_vdev_up_params params = {};
 	int ret;
 
 	lockdep_assert_held(&ar->conf_mutex);
@@ -922,7 +926,9 @@ static int ath12k_mac_monitor_vdev_start(struct ath12k *ar, int vdev_id,
 		return ret;
 	}
 
-	ret = ath12k_wmi_vdev_up(ar, vdev_id, 0, ar->mac_addr);
+	params.vdev_id = vdev_id;
+	params.bssid = ar->mac_addr;
+	ret = ath12k_wmi_vdev_up(ar, &params);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to put up monitor vdev %i: %d\n",
 			    vdev_id, ret);
@@ -1358,6 +1364,7 @@ static int ath12k_mac_setup_bcn_tmpl(struct ath12k_vif *arvif)
 static void ath12k_control_beaconing(struct ath12k_vif *arvif,
 				     struct ieee80211_bss_conf *info)
 {
+	struct ath12k_wmi_vdev_up_params params = {};
 	struct ath12k *ar = arvif->ar;
 	int ret;
 
@@ -1385,8 +1392,10 @@ static void ath12k_control_beaconing(struct ath12k_vif *arvif,
 
 	ether_addr_copy(arvif->bssid, info->bssid);
 
-	ret = ath12k_wmi_vdev_up(arvif->ar, arvif->vdev_id, arvif->aid,
-				 arvif->bssid);
+	params.vdev_id = arvif->vdev_id;
+	params.aid = arvif->aid;
+	params.bssid = arvif->bssid;
+	ret = ath12k_wmi_vdev_up(arvif->ar, &params);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to bring up vdev %d: %i\n",
 			    arvif->vdev_id, ret);
@@ -2533,6 +2542,7 @@ static void ath12k_bss_assoc(struct ath12k *ar,
 			     struct ieee80211_bss_conf *bss_conf)
 {
 	struct ieee80211_vif *vif = arvif->vif;
+	struct ath12k_wmi_vdev_up_params params = {};
 	struct ath12k_wmi_peer_assoc_arg peer_arg;
 	struct ieee80211_sta *ap_sta;
 	struct ath12k_peer *peer;
@@ -2584,7 +2594,10 @@ static void ath12k_bss_assoc(struct ath12k *ar,
 	arvif->aid = vif->cfg.aid;
 	ether_addr_copy(arvif->bssid, bss_conf->bssid);
 
-	ret = ath12k_wmi_vdev_up(ar, arvif->vdev_id, arvif->aid, arvif->bssid);
+	params.vdev_id = arvif->vdev_id;
+	params.aid = arvif->aid;
+	params.bssid = arvif->bssid;
+	ret = ath12k_wmi_vdev_up(ar, &params);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to set vdev %d up: %d\n",
 			    arvif->vdev_id, ret);
@@ -7110,6 +7123,7 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 			   struct ieee80211_vif_chanctx_switch *vifs,
 			   int n_vifs)
 {
+	struct ath12k_wmi_vdev_up_params params = {};
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_vif *arvif;
 	int ret;
@@ -7190,8 +7204,10 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 			ath12k_warn(ab, "failed to update bcn tmpl during csa: %d\n",
 				    ret);
 
-		ret = ath12k_wmi_vdev_up(arvif->ar, arvif->vdev_id, arvif->aid,
-					 arvif->bssid);
+		params.vdev_id = arvif->vdev_id;
+		params.aid = arvif->aid;
+		params.bssid = arvif->bssid;
+		ret = ath12k_wmi_vdev_up(arvif->ar, &params);
 		if (ret) {
 			ath12k_warn(ab, "failed to bring vdev up %d: %d\n",
 				    arvif->vdev_id, ret);
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 58c67ede777e..bed5ca00305d 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -1103,7 +1103,7 @@ int ath12k_wmi_vdev_start(struct ath12k *ar, struct wmi_vdev_start_req_arg *arg,
 	return ret;
 }
 
-int ath12k_wmi_vdev_up(struct ath12k *ar, u32 vdev_id, u32 aid, const u8 *bssid)
+int ath12k_wmi_vdev_up(struct ath12k *ar, struct ath12k_wmi_vdev_up_params *params)
 {
 	struct ath12k_wmi_pdev *wmi = ar->wmi;
 	struct wmi_vdev_up_cmd *cmd;
@@ -1118,14 +1118,14 @@ int ath12k_wmi_vdev_up(struct ath12k *ar, u32 vdev_id, u32 aid, const u8 *bssid)
 
 	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_VDEV_UP_CMD,
 						 sizeof(*cmd));
-	cmd->vdev_id = cpu_to_le32(vdev_id);
-	cmd->vdev_assoc_id = cpu_to_le32(aid);
+	cmd->vdev_id = cpu_to_le32(params->vdev_id);
+	cmd->vdev_assoc_id = cpu_to_le32(params->aid);
 
-	ether_addr_copy(cmd->vdev_bssid.addr, bssid);
+	ether_addr_copy(cmd->vdev_bssid.addr, params->bssid);
 
 	ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
 		   "WMI mgmt vdev up id 0x%x assoc id %d bssid %pM\n",
-		   vdev_id, aid, bssid);
+		   params->vdev_id, params->aid, params->bssid);
 
 	ret = ath12k_wmi_cmd_send(wmi, skb, WMI_VDEV_UP_CMDID);
 	if (ret) {
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 4051ed5a0b0a..12c6cfb943c8 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2763,6 +2763,12 @@ struct wmi_vdev_delete_cmd {
 	__le32 vdev_id;
 } __packed;
 
+struct ath12k_wmi_vdev_up_params {
+	u32 vdev_id;
+	u32 aid;
+	const u8 *bssid;
+};
+
 struct wmi_vdev_up_cmd {
 	__le32 tlv_header;
 	__le32 vdev_id;
@@ -4893,8 +4899,7 @@ int ath12k_wmi_bcn_tmpl(struct ath12k *ar, u32 vdev_id,
 			struct ieee80211_mutable_offsets *offs,
 			struct sk_buff *bcn);
 int ath12k_wmi_vdev_down(struct ath12k *ar, u8 vdev_id);
-int ath12k_wmi_vdev_up(struct ath12k *ar, u32 vdev_id, u32 aid,
-		       const u8 *bssid);
+int ath12k_wmi_vdev_up(struct ath12k *ar, struct ath12k_wmi_vdev_up_params *params);
 int ath12k_wmi_vdev_stop(struct ath12k *ar, u8 vdev_id);
 int ath12k_wmi_vdev_start(struct ath12k *ar, struct wmi_vdev_start_req_arg *arg,
 			  bool restart);
-- 
2.39.0


