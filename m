Return-Path: <linux-wireless+bounces-5774-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 979EF895E70
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Apr 2024 23:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52DA428779A
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Apr 2024 21:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE2015E5AE;
	Tue,  2 Apr 2024 21:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AQPkQMFz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A3715E209
	for <linux-wireless@vger.kernel.org>; Tue,  2 Apr 2024 21:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712091964; cv=none; b=bAq4tFfzMCaO94cm5NwNtxv9Y9uzOK8rvQQIfkF3K9QLhyMkOcTZFqcOH0ojPoqekwPlqO+C+y7bnnX8SKruosllrbhYx5OqO7JmXSzaoNsEInoNSTOr5oEAUcCV1MVkegJrnzGijMqFbOIuZ5xNLqDsB+4vUzNqCm5X0+1IDQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712091964; c=relaxed/simple;
	bh=m5YwXVcNPJ25YGL+JhyxWK9uXZITivfFioMjXzpk4Rs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JQMJwIGfwGjjmnW13ECC8X83/ubBARhIBQlISLMNuzL2GCuuR+OYln5RTClIXQDaVq/DK4sET6VyqETuLBZ9UqA2BomCAfe2GJcZYvax46V4t5fZQMnP3Cn0YXI0MGeMkXthODpOmDijUxFR9wODvYwb8y5fHc50jrBHUrVLDOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AQPkQMFz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 432HE6VA019265;
	Tue, 2 Apr 2024 21:05:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=3NAT9qr/pCrJjhuKj5GOGd31Ur9L2Tb7W4TFyHWfYRg=; b=AQ
	PkQMFzaKxYGvZx8I/KeQjvY7lpJX68zuPHviEH4lY3jYTCTcwhAHwxLl4Z6wCgHQ
	XtHpwcVormLmvKMVW3/3BEj7t42C0fqIwAd8nBYsjgcLUFUbDYIOi3u+COwQRaj4
	eyrHiqOC3xEzRgK89aBnfyKMps9ZdbGqXKp7k+rdDvXxagYLPMIt6i+AQCUDNZJJ
	fkgHKQOontXYJGtndp2JeorvoEFDBrJyFbTdIx4+uY0sfBoWuU9/rW8liqIvPFcP
	OukUe5WH+1uTQRDknA6VirW0zKaU9IjBzRnekffTrNlUEfXjY4iY7KRCXJV9eTc0
	NPmAwnlV59LDiJN3646A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x8ha3hfd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 21:05:52 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 432L5pN3004682
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Apr 2024 21:05:51 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 2 Apr 2024 14:05:51 -0700
From: Aloka Dixit <quic_alokad@quicinc.com>
To: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC: Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH 9/9] wifi: ath12k: skip sending vdev down for channel switch
Date: Tue, 2 Apr 2024 14:05:38 -0700
Message-ID: <20240402210538.7308-10-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240402210538.7308-1-quic_alokad@quicinc.com>
References: <20240402210538.7308-1-quic_alokad@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Qzysvws-NB2HOKNvTmQwyE7qjC66ywwz
X-Proofpoint-GUID: Qzysvws-NB2HOKNvTmQwyE7qjC66ywwz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_14,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=687 spamscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404020157

Remove the unnecessary WMI vdev down operation as firmware
internally does so already as part of WMI vdev restart.
Repeated vdev down results in a firmware crash during channel
switch operation when multiple BSSID advertisements are enabled:
ath12k_pci 0000:06:00.0: firmware crashed: MHI_CB_SYS_ERROR
ath12k_pci 0000:06:00.0: failed to send WMI_VDEV_SET_PARAM_CMDID
ath12k_pci 0000:06:00.0: failed to set vdev 5 HE MU mode: -108 param_value 7b
ath12k_pci 0000:06:00.0: failed to set he mode vdev 5
ath12k_pci 0000:06:00.0: failed to restart vdev 5: -108
ath12k_pci 0000:06:00.0: failed to send WMI_VDEV_SET_PARAM_CMDID
ath12k_pci 0000:06:00.0: failed to set vdev 4 HE MU mode: -108 param_value 7b
ath12k_pci 0000:06:00.0: failed to set he mode vdev 4
ath12k_pci 0000:06:00.0: failed to restart vdev 4: -108
ath12k_pci 0000:06:00.0: failed to send WMI_VDEV_SET_PARAM_CMDID

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 29 +++------------------------
 1 file changed, 3 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index af5851373bcc..69ea2e98910a 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -6741,9 +6741,10 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 	lockdep_assert_held(&ar->conf_mutex);
 
 	for (i = 0; i < n_vifs; i++) {
-		arvif = ath12k_vif_to_arvif(vifs[i].vif);
+		vif = vifs[i].vif;
+		arvif = ath12k_vif_to_arvif(vif);
 
-		if (vifs[i].vif->type == NL80211_IFTYPE_MONITOR)
+		if (vif->type == NL80211_IFTYPE_MONITOR)
 			monitor_vif = true;
 
 		ath12k_dbg(ab, ATH12K_DBG_MAC,
@@ -6754,30 +6755,6 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 			   vifs[i].old_ctx->def.width,
 			   vifs[i].new_ctx->def.width);
 
-		if (WARN_ON(!arvif->is_started))
-			continue;
-
-		if (WARN_ON(!arvif->is_up))
-			continue;
-
-		ret = ath12k_wmi_vdev_down(ar, arvif->vdev_id);
-		if (ret) {
-			ath12k_warn(ab, "failed to down vdev %d: %d\n",
-				    arvif->vdev_id, ret);
-			continue;
-		}
-	}
-
-	/* All relevant vdevs are downed and associated channel resources
-	 * should be available for the channel switch now.
-	 */
-
-	/* TODO: Update ar->rx_channel */
-
-	for (i = 0; i < n_vifs; i++) {
-		vif = vifs[i].vif;
-		arvif = ath12k_vif_to_arvif(vif);
-
 		if (WARN_ON(!arvif->is_started))
 			continue;
 
-- 
2.39.0


