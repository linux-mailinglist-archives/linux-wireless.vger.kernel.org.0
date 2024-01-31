Return-Path: <linux-wireless+bounces-2860-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 176A98433B8
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 03:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F493B25602
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 02:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16EBEADB;
	Wed, 31 Jan 2024 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DtbGAyCb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99FEEAD7
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 02:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706667544; cv=none; b=B0fQWn3pDbM5FARomE/lnZyLbR3KVhSxjRNzYs7xSrs2lWVpqKssjke3ybdRi/b4PgRZEg5IK9l/qEZqZbyWJpxHidXsZ5whr/f+Mx7I19ZW8yTeTexuy+nvLFguBxFifCd+yZTefUoda24OhxM4ggdE+jAeuxpVXGKtZHATN98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706667544; c=relaxed/simple;
	bh=BxEOsrAdkuHuovzJu0y0oW5jKfUvSNAH6h+Sh3thM18=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b6zJlDt+CyF6oJJj9Wz42a1dZCe7I0kz2sQ/pkmAFQlYMYVLvTk7J+nyrgKUI4OVUXsWEL/850OQfW734GcKEo9OiOjn7ViuY8W2FXUwTxaYymtdXEPhH0yj5kMUNFLofO5Om+XVhkSWBwdsNOELVOidgFo6a2bJ8U2vupCYwrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DtbGAyCb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40UN8ex0028444;
	Wed, 31 Jan 2024 02:18:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=IrPzMA0
	u01I/2LBA8mPdHLEkHw96CWFguTjmoCVRapQ=; b=DtbGAyCbIW+bmYbd/xprIzy
	1d/CJH8hpF3EUEbWHF5khRU4ziMX5+Lo8/Dv0v2IcOyWVkqlcZ46nkhW1SzCuIB7
	+jp1yzaGKrb/gQH+BnMFJGEy/2ai2bV3yqAWCV24o/78QupMSIU2hlDGROnJlnqU
	kpvy0wnZBGn9GU9ZNbxkcfzulMhjr8w0vf0nehYclPY4R6sqspKClL9BERVRQz5r
	AcudYLZRY6Ne7/3kIaLl2TPLX/tXKOncbde+wx0i4FCgT6QcwCaAa9JAdje6jvoj
	5zWlU3HxBEf/ZvAVpcpjdm8FthKp2+pGhWnJXimNyXqITxg/JnWOLvSR8lBeNCg=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vy6gmgt5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 02:18:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40V2IufN001220
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 02:18:57 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 30 Jan 2024 18:18:55 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH] wifi: ath11k: change to move WMI_VDEV_PARAM_SET_HEMU_MODE before WMI_PEER_ASSOC_CMDID
Date: Wed, 31 Jan 2024 10:18:32 +0800
Message-ID: <20240131021832.17298-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vhKCeVMTieXWMG22pvIzD3Of8v2YxHCp
X-Proofpoint-ORIG-GUID: vhKCeVMTieXWMG22pvIzD3Of8v2YxHCp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_14,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 phishscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401310018

From: Wen Gong <quic_wgong@quicinc.com>

Currently when connecting to an AP with 11AX-HE phy mode, host sends
WMI_VDEV_PARAM_SET_HEMU_MODE parameter to firmware after
WMI_PEER_ASSOC_CMDID command. This results in TXBF not working, because
firmware calculates TXBF values while handling WMI_PEER_ASSOC_CMDID,
however at that time WMI_VDEV_PARAM_SET_HEMU_MODE has not been sent yet.
See below log:

AP sends "VHT/HE/EHT NDP Announcement" to station, and station sends
"Action no Ack" of category code HE to AP, the "Nc Index" and
"Codebook Information" are wrong:

Issued action:
IEEE 802.11 Action No Ack, Flags: ........
IEEE 802.11 wireless LAN
    Fixed parameters
        Category code: HE (30)
        HE Action: HE Compressed Beamforming And CQI (0)
            Total length: 152
            HE MIMO Control: 0x0004008018
                .... .... .... .... .... .... .... .... .... .000 = Nc Index: 1 Column (0)
                .... .... .... .... .... .... .... ..0. .... .... = Codebook Information: 0

Change to send WMI_VDEV_PARAM_SET_HEMU_MODE before WMI_PEER_ASSOC_CMDID,
then firmware will calculate the TXBF values with valid parameters
instead of empty values. TXBF works well and throughput performance is
improved from 80 Mbps to 130 Mbps with this patch.

Good action after this patch:
IEEE 802.11 Action No Ack, Flags: ........
IEEE 802.11 wireless LAN
    Fixed parameters
        Category code: HE (30)
        HE Action: HE Compressed Beamforming And CQI (0)
            Total length: 409
            HE MIMO Control: 0x0004008219
                .... .... .... .... .... .... .... .... .... .001 = Nc Index: 2 Columns (1)
                .... .... .... .... .... .... .... ..1. .... .... = Codebook Information: 1

This change applies to all chipsets.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Fixes: 38dfe775d0ab ("wifi: ath11k: push MU-MIMO params from hostapd to hardware")
Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index bbf4d1f4d310..df1b1ee71881 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3023,7 +3023,14 @@ static void ath11k_bss_assoc(struct ieee80211_hw *hw,
 
 	rcu_read_unlock();
 
+	if (!ath11k_mac_vif_recalc_sta_he_txbf(ar, vif, &he_cap)) {
+		ath11k_warn(ar->ab, "failed to recalc he txbf for vdev %i on bss %pM\n",
+			    arvif->vdev_id, bss_conf->bssid);
+		return;
+	}
+
 	peer_arg.is_assoc = true;
+
 	ret = ath11k_wmi_send_peer_assoc_cmd(ar, &peer_arg);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to run peer assoc for %pM vdev %i: %d\n",
@@ -3046,12 +3053,6 @@ static void ath11k_bss_assoc(struct ieee80211_hw *hw,
 		return;
 	}
 
-	if (!ath11k_mac_vif_recalc_sta_he_txbf(ar, vif, &he_cap)) {
-		ath11k_warn(ar->ab, "failed to recalc he txbf for vdev %i on bss %pM\n",
-			    arvif->vdev_id, bss_conf->bssid);
-		return;
-	}
-
 	WARN_ON(arvif->is_up);
 
 	arvif->aid = vif->cfg.aid;

base-commit: 17f4b952f067b1f87d14e6df4c8c216fe7a245d1
-- 
2.25.1


