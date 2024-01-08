Return-Path: <linux-wireless+bounces-1572-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62133826974
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 09:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10F3E1F21E83
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 08:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E07125D1;
	Mon,  8 Jan 2024 08:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Kqt3pbIV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D124611CAD
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jan 2024 08:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4088IoLl021208;
	Mon, 8 Jan 2024 08:26:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=VegCFk7v20wSP6S+8Dg4YreFOPHH9qXhmANNHZgXWNw=; b=Kq
	t3pbIVlUmCSMl/HgoV62zDpjKIGfZ4LNIEXh/NCMTO6BtqS1uifG31aUydd4xNwk
	3ceEEiIMYb0nZlLEpsKV1RkI6fG2yzKU20PBP9wJWalZoBbavpFd02J8M3TJhVbx
	wjHDOHzaVeSbYUUsuGfU4QZh6Z9rkjBl6uDyR88rQacHOuRZH5T1FuBkuzPl+ZX8
	sOshhPWk2hqyhfz6nwVyC4NYu+bj8Psosbmh8irku+Vuloav7mlP5agJUbJwAonq
	Lz1GfG2n+9cdt46Vel6emHVV2MutsPd7Nklq7a6F5SSBRgUbB93pCROtcip9pwnP
	UpA5q4NRmEqHEQo6zyfQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vg8nwrh48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 08:26:40 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4088QdYe007845
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 08:26:39 GMT
Received: from yk-E5440.local (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 8 Jan
 2024 00:26:38 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH 09/10] wifi: ath12k: designating channel frequency for ROC scan
Date: Mon, 8 Jan 2024 16:25:51 +0800
Message-ID: <20240108082552.7227-10-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108082552.7227-1-quic_kangyang@quicinc.com>
References: <20240108082552.7227-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-GUID: DRt_zA8beIFliPMsqf66RvMpG5LxV2zW
X-Proofpoint-ORIG-GUID: DRt_zA8beIFliPMsqf66RvMpG5LxV2zW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401080070

For P2P mode, the WLAN interface may be requested to remain on a
specific channel and then to send some management frames on that
channel. Now chananel frequency of wmi_mgmt_send_cmd is set as 0. As
a result, firmware may choose a default but wrong channel.

Fix it by assigning chanfreq field with the ROC channel frequency.

This change only applies to WCN7850, other chips are not affected.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 8087b040620c..1aac32036ac9 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -732,6 +732,20 @@ static int ath12k_service_ready_event(struct ath12k_base *ab, struct sk_buff *sk
 	return 0;
 }
 
+static u32 ath12k_wmi_mgmt_get_freq(struct ath12k *ar,
+				    struct ieee80211_tx_info *info)
+{
+	struct ath12k_base *ab = ar->ab;
+	u32 freq = 0;
+
+	if (ab->hw_params->single_pdev_only &&
+	    ar->scan.is_roc &&
+	    (info->flags & IEEE80211_TX_CTL_TX_OFFCHAN))
+		freq = ar->scan.roc_freq;
+
+	return freq;
+}
+
 struct sk_buff *ath12k_wmi_alloc_skb(struct ath12k_wmi_base *wmi_ab, u32 len)
 {
 	struct sk_buff *skb;
@@ -757,6 +771,7 @@ int ath12k_wmi_mgmt_send(struct ath12k *ar, u32 vdev_id, u32 buf_id,
 {
 	struct ath12k_wmi_pdev *wmi = ar->wmi;
 	struct wmi_mgmt_send_cmd *cmd;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(frame);
 	struct wmi_tlv *frame_tlv;
 	struct sk_buff *skb;
 	u32 buf_len;
@@ -775,7 +790,7 @@ int ath12k_wmi_mgmt_send(struct ath12k *ar, u32 vdev_id, u32 buf_id,
 						 sizeof(*cmd));
 	cmd->vdev_id = cpu_to_le32(vdev_id);
 	cmd->desc_id = cpu_to_le32(buf_id);
-	cmd->chanfreq = 0;
+	cmd->chanfreq = cpu_to_le32(ath12k_wmi_mgmt_get_freq(ar, info));
 	cmd->paddr_lo = cpu_to_le32(lower_32_bits(ATH12K_SKB_CB(frame)->paddr));
 	cmd->paddr_hi = cpu_to_le32(upper_32_bits(ATH12K_SKB_CB(frame)->paddr));
 	cmd->frame_len = cpu_to_le32(frame->len);
-- 
2.34.1


