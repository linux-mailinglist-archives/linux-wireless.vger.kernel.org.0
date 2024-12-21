Return-Path: <linux-wireless+bounces-16680-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 935DD9F9E48
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Dec 2024 05:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0324816B025
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Dec 2024 04:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7751DF269;
	Sat, 21 Dec 2024 04:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K/fbkH1r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6471EC4D1
	for <linux-wireless@vger.kernel.org>; Sat, 21 Dec 2024 04:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734755500; cv=none; b=uLY3n9thx33I4Nvzp06nwZSOF3sqeSs8YNhKnS5V14P2wMrVHsa46a7a249SJ3dNyP2hArBbxhDKhh4RdE59j/9X/HP00ZOhXMyZOPjGONc288XsvAMloH3DPIr/7iqYW8ciiwDLolS0ynfj7p4mV4/U3AVITdvoVQ7CFc59+Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734755500; c=relaxed/simple;
	bh=cJzbqTpbIa+AxZD/wcs+400SVHskYV/zAOhkTFD6fdM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZxHgfZ/+AccWdNQPnGPVVG3vXGnyUJGOdxGD5WNQQ4S5peY5lL1emny99OHjWMqArJtMI3J8ly9cSis0ImUejnaeVPwUrirolXWarjA9xKIylTL0Yvp0KNvpQyadGRWdNsrg7FUkZX1hG9gWhwQdQQx4dcqX/yFRnpqiOow8dpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K/fbkH1r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BKCiin6013155;
	Sat, 21 Dec 2024 04:31:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/X4ZFuTXa+wYuc0tkzPTu8kiCqKpDRdufsJ5vezUdKc=; b=K/fbkH1rwh9ZwBwg
	X15d57uwN57QjnnUbjaqBZBQ/KNpw4I+By3i4E8nzPXXzGoCDGD2adp1rrM2gU+2
	U3SGm7wwxDMWWiqCb87nM4CNNyZBMiA3jhb72KvO8mdqmf/ZMgL2IlhesV8Tv2Kz
	vsPEOtNpUEnkAuGCt6TXjfo+U93G1fBPGw9KiUgWWlsoQlacmE87XgTTzFuOwUUe
	qsuD7YvdziMwUR3L3OondtXAp44R69GV/7jJLye/4Awl9DmkKZzMc72B2C7frBNA
	1cgVsJFF7s2R+eLxY0Sl0a9JPRaspmub2/6qO7K+9OuavHMAV1I4fGTpOJJ95JLe
	x0sGbQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43n8uvhxq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Dec 2024 04:31:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BL4Va18008804
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Dec 2024 04:31:36 GMT
Received: from hu-ppranees-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 20 Dec 2024 20:31:34 -0800
From: P Praneesh <quic_ppranees@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>
Subject: [PATCH 13/14] wifi: ath12k: Handle monitor drop TLVs scenario
Date: Sat, 21 Dec 2024 10:00:13 +0530
Message-ID: <20241221043014.1252841-14-quic_ppranees@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241221043014.1252841-1-quic_ppranees@quicinc.com>
References: <20241221043014.1252841-1-quic_ppranees@quicinc.com>
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
X-Proofpoint-GUID: 7__RZ6pbXZHrzREi47sxT1YhARJ4WIdI
X-Proofpoint-ORIG-GUID: 7__RZ6pbXZHrzREi47sxT1YhARJ4WIdI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412210035

During monitor destination ring back-pressure, hardware failed to send
HAL_RX_PPDU_END_STATUS_DONE TLV. But driver uses this TLV as a delimiter
to complete one PPDU worth of data parsing. This causes driver to overwrite
the existing PPDU information with the new PPDU information.

Fix it by recording the end reason which is provided under each buffer's
descriptor in skb->cb and uses it while parsing TLV tags to mark the PPDU
end delimiter.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h   | 1 +
 drivers/net/wireless/ath/ath12k/dp_mon.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index b789b375b891..ad69d8544357 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -141,6 +141,7 @@ struct ath12k_skb_rxcb {
 	u8 is_frag;
 	u8 tid;
 	u16 peer_id;
+	bool is_end_of_ppdu;
 };
 
 enum ath12k_hw_rev {
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 23b1a41c6fd2..4e9a60181c06 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1139,6 +1139,7 @@ ath12k_dp_mon_parse_rx_dest(struct ath12k *ar, struct ath12k_mon_data *pmon,
 			    struct sk_buff *skb)
 {
 	struct hal_tlv_64_hdr *tlv;
+	struct ath12k_skb_rxcb *rxcb;
 	enum hal_rx_mon_status hal_status;
 	u16 tlv_tag, tlv_len;
 	u8 *ptr = skb->data;
@@ -1170,6 +1171,10 @@ ath12k_dp_mon_parse_rx_dest(struct ath12k *ar, struct ath12k_mon_data *pmon,
 		 (hal_status == HAL_RX_MON_STATUS_MPDU_END) ||
 		 (hal_status == HAL_RX_MON_STATUS_MSDU_END));
 
+	rxcb = ATH12K_SKB_RXCB(skb);
+	if (rxcb->is_end_of_ppdu)
+		hal_status = HAL_RX_MON_STATUS_PPDU_DONE;
+
 	return hal_status;
 }
 
@@ -2345,8 +2350,10 @@ int ath12k_dp_mon_srng_process(struct ath12k *ar, int *budget,
 		 * HAL_MON_END_OF_PPDU to ensure that one PPDU worth of data is always
 		 * reaped. This helps to efficiently utilize the NAPI budget.
 		 */
-		if (end_reason == HAL_MON_END_OF_PPDU)
+		if (end_reason == HAL_MON_END_OF_PPDU) {
 			*budget -= 1;
+			rxcb->is_end_of_ppdu = true;
+		}
 
 		end_offset = u32_get_bits(info0, HAL_MON_DEST_INFO0_END_OFFSET);
 		if (likely(end_offset <= DP_RX_BUFFER_SIZE)) {
-- 
2.34.1


