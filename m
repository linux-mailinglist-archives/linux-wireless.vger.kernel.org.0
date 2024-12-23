Return-Path: <linux-wireless+bounces-16738-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7F89FB2C3
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 17:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2810167938
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 16:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFD11C5CDE;
	Mon, 23 Dec 2024 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eYd2GYxs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730E21C54A4;
	Mon, 23 Dec 2024 16:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734970924; cv=none; b=rK+gL9tR8sibbjMxPRuiUMOPO/kvq2qIJr2xbvU0aHXPMLMRCaj1I8ojYimg4eBhwVcoy/a0ItJgMlWFUMFaVS1y0D1ojgxKrZM5YQBFEmT/VsaceDMyi2HJ39iDqfQ90kUIawXD+pUoHNQlElSSKxX5G3E4ri3fvjZYVysDWLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734970924; c=relaxed/simple;
	bh=Q4Zn9Tc2or5sQeV7bU0GK7FKVS6Fsl6KbiN9kdkzQrI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=oykd5urzuxVSP23y0PDhyT29zddcFfNG4v/FKEwIpo9LHGF+MUAxeR0vbjZbizfm0CBnBkyL2SpiocdgJ0pDwwemYUmaHPo2BzjwkFvPklDJe4rHWhPrWN2dTmhYlKg9TCUyAugRZOqvoD5Jm3JfX9aaVYEXjsCkg3nIwGpFoOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eYd2GYxs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNBgeP4025279;
	Mon, 23 Dec 2024 16:21:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m4LH3u2csEVYMvumO2dpdbOmUHBzlaSzLqwCcCPqEFA=; b=eYd2GYxseyOccO5y
	olDpA67kmBAfMqHIB3lpWUsDLV64MlEpbNEm0NGdWoX9flLSvUs+YD1enq4q4o0a
	T97ZQBju/mXSof1yXCthNVAMuQ9PPelCiBtfV/51sCGB4beRbPpm4fs4nytTXv0c
	qr/96wa4xxcLVKNi3tDtY6RnUr4sRk2XMx22blRXPBNaowV20B/06HFMDKU25vUi
	re7OFApPJJgXHpQvPz8M3pn+SBu377WVCrKBmkeOwHtVWy6IZfi8phARvqEaM0bK
	e5xS1udgWGkTc6iAkOMvavjcYtBipuNoyejaG2tFvoyI19f79hVh02key5QfHA08
	ogJNtw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43q77rh23m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 16:21:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BNGLtJS011400
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 16:21:55 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 23 Dec 2024 08:21:53 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Date: Mon, 23 Dec 2024 21:51:38 +0530
Subject: [PATCH 3/4] wifi: ath12k: update the latest CSA counter
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241223-ath12k_mlo_csa-v1-3-78b6d7515568@quicinc.com>
References: <20241223-ath12k_mlo_csa-v1-0-78b6d7515568@quicinc.com>
In-Reply-To: <20241223-ath12k_mlo_csa-v1-0-78b6d7515568@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IZ_6088-tyEmXbGOw7yAsKXlRgKrCJ0C
X-Proofpoint-ORIG-GUID: IZ_6088-tyEmXbGOw7yAsKXlRgKrCJ0C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412230145

At present, the driver configures the firmware to send the Channel Switch
(CS) count event only when the count reaches zero during a Channel Switch
Announcement (CSA). For frames managed by the upper layer, where the driver
does not update the counter, the CS count in these frames remains unchanged
throughout the entire CSA period. This is because the upper layer is not
aware of the latest ongoing count. Indicating same count value throughout
the CSA time is wrong and could lead to connection instabilities.

Fix this by configuring firmware to send CS count event for every count and
then accordingly decrementing the count in mac80211.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index ff973372a01a85bede15fde72bbe7db99bcfb300..99f6dc2fbbe3d0aa71ab96e500cfaa8e4bf9930f 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -1933,6 +1933,7 @@ int ath12k_wmi_bcn_tmpl(struct ath12k_link_vif *arvif,
 				cpu_to_le32(offs->cntdwn_counter_offs[0]);
 		cmd->ext_csa_switch_count_offset =
 				cpu_to_le32(offs->cntdwn_counter_offs[1]);
+		cmd->csa_event_bitmap = cpu_to_le32(0xFFFFFFFF);
 	}
 
 	cmd->buf_len = cpu_to_le32(bcn->len);
@@ -6876,17 +6877,15 @@ ath12k_wmi_process_csa_switch_count_event(struct ath12k_base *ab,
 					  const struct ath12k_wmi_pdev_csa_event *ev,
 					  const u32 *vdev_ids)
 {
-	int i;
+	u32 current_switch_count = le32_to_cpu(ev->current_switch_count);
+	u32 num_vdevs = le32_to_cpu(ev->num_vdevs);
 	struct ieee80211_bss_conf *conf;
 	struct ath12k_link_vif *arvif;
 	struct ath12k_vif *ahvif;
-
-	/* Finish CSA once the switch count becomes NULL */
-	if (ev->current_switch_count)
-		return;
+	int i;
 
 	rcu_read_lock();
-	for (i = 0; i < le32_to_cpu(ev->num_vdevs); i++) {
+	for (i = 0; i < num_vdevs; i++) {
 		arvif = ath12k_mac_get_arvif_by_vdev_id(ab, vdev_ids[i]);
 
 		if (!arvif) {
@@ -6909,8 +6908,14 @@ ath12k_wmi_process_csa_switch_count_event(struct ath12k_base *ab,
 			continue;
 		}
 
-		if (arvif->is_up && conf->csa_active)
-			ieee80211_csa_finish(ahvif->vif, 0);
+		if (!arvif->is_up || !conf->csa_active)
+			continue;
+
+		/* Finish CSA when counter reaches zero */
+		if (!current_switch_count)
+			ieee80211_csa_finish(ahvif->vif, arvif->link_id);
+		else if (current_switch_count > 1)
+			ieee80211_beacon_update_cntdwn(ahvif->vif, arvif->link_id);
 	}
 	rcu_read_unlock();
 }

-- 
2.34.1


