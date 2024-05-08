Return-Path: <linux-wireless+bounces-7361-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6E48C05B2
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 22:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F861F221DE
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 20:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01171311AA;
	Wed,  8 May 2024 20:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YRbXBcle"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E39E130E55
	for <linux-wireless@vger.kernel.org>; Wed,  8 May 2024 20:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715200180; cv=none; b=OhCO4ZhAQiR83jwjY/WRpjgeXh0x00LpNbpIWJAyW8KCdPbLXw7tJ5zUOsZiQw16Z8KtN+KhTjHejNFhqzZy7IJYihJWRP43vABCCWx3luVDbSzJ8XBpSuTKnqE+JMCPZGWoYI5RvEupUWr/7G6uzozW21hh66K1JnmP6HxtO1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715200180; c=relaxed/simple;
	bh=6TNrtz/uWs08edS3XuT7jbv59WHaLeeO6CABLMfvUxc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oDI85PRQLkNmftHLiVbDq6+4PZukc7/a4Ow16MrdPUZkTAsWuKUdnE5JrI0MsYFr+ZG9zip74rd2aOPwZeQ4u3MQ/kwWSUuzuitOfce52TMRY2INigTpoh+90Bqvw05klynvNTDgfr/+TN4z4oYgS32LD1PbszAJ7oXaVyLmek8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YRbXBcle; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 448Fn24M024818;
	Wed, 8 May 2024 20:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=bPhaYa9ueoCxhBgDg/0eyjwvppCIZ433XJPWNiByEHA=; b=YR
	bXBcleFQxc6FMek+RyScJrkfowXzMed+7ewdL6sJzmk9dbm89HphmdFaQNvhMg7j
	GE92iO+3tfHuzhTwEtkkkFw5jIQ9SY/jRR7yPnYLV+cH77zifyfUbK0Cswn5tChc
	GUeSzlI8fyM/aCz4SbhfDCkZHYVER1SXfllhwE4xj5LtK0KscNoIV7Th/vEXy+fq
	v9finkaYYMORrOcRfclphl8fS5/5OAE5+15vIi2mFFsFM93eQTgOAyAZVYDV4bz0
	yqPXZZmiT2OFe92+UDMKZIilex7XdYctJ7+EFTgIgrwIJONqgekRugKrXOYeWzO+
	LUS05hTbDs1dWQ+pH9tQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y08ne16p1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 20:29:34 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 448KTQ2O023178
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 May 2024 20:29:26 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 8 May 2024 13:29:26 -0700
From: Aloka Dixit <quic_alokad@quicinc.com>
To: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC: Aloka Dixit <quic_alokad@quicinc.com>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
Subject: [PATCH v2 9/9] wifi: ath12k: skip sending vdev down for channel switch
Date: Wed, 8 May 2024 13:29:12 -0700
Message-ID: <20240508202912.11902-10-quic_alokad@quicinc.com>
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
X-Proofpoint-GUID: Fl4zXmhldJlY4w9BANQMMtTY5FOOqcSC
X-Proofpoint-ORIG-GUID: Fl4zXmhldJlY4w9BANQMMtTY5FOOqcSC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=684 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405080151

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
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 29 +++------------------------
 1 file changed, 3 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 71da4fe0006f..7d7aac553b3c 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7290,9 +7290,10 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 	lockdep_assert_held(&ar->conf_mutex);
 
 	for (i = 0; i < n_vifs; i++) {
-		arvif = ath12k_vif_to_arvif(vifs[i].vif);
+		vif = vifs[i].vif;
+		arvif = ath12k_vif_to_arvif(vif);
 
-		if (vifs[i].vif->type == NL80211_IFTYPE_MONITOR)
+		if (vif->type == NL80211_IFTYPE_MONITOR)
 			monitor_vif = true;
 
 		ath12k_dbg(ab, ATH12K_DBG_MAC,
@@ -7303,30 +7304,6 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
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


