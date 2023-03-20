Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C53A6C13A3
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 14:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjCTNjm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 09:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjCTNjT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 09:39:19 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4CC1A66C
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 06:39:10 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KBvFZ2004731;
        Mon, 20 Mar 2023 13:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=jMz2u2+gyjJJcj5tuRPYVv0di+sn1S5ni8sqhMu/9Kg=;
 b=BNz+KGi99iSZhDkes9KWF52w7CzSYjHOAYXTfBPlCQk7pM1ZZAIsxB8H3zGnapUkas/r
 1FfSr/9GpQ+5F6LsOEhJ4KF4Us8wsGi/jZnw25FoCqH4jPqhHPQzcC4jaVzVtNdjiA/0
 PlEKhMhP6ULKuRkpbM7RDNigSEYSRmhgqbWkVUL69mwPEJi2oHbhQgxFGFO75Rmfk+Gt
 8w4fd4JPJXA1PNOxL3X8nGYxxzxTsUvQi80R1Tm683dJg7fwBKlNOyD/BlmnrBGBeIqv
 CMVmf/KTnEUEFt7WWsvQInmEBZG+JH8TvwUAZ9ndRKqA4kCNXqS5+79KGzUuBP80f3yv ow== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pen6hrh12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 13:39:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32KDd4H6010152
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 13:39:04 GMT
Received: from nmaran-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 20 Mar 2023 06:39:02 -0700
From:   Nagarajan Maran <quic_nmaran@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Bhagavathi Perumal S <quic_bperumal@quicinc.com>,
        Nagarajan Maran <quic_nmaran@quicinc.com>
Subject: [PATCH] wifi: ath11k: Fix invalid management rx frame length issue
Date:   Mon, 20 Mar 2023 19:08:40 +0530
Message-ID: <20230320133840.30162-1-quic_nmaran@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8NkXcGNm6eXVpjTaeMT1e0VxZ9FeT59R
X-Proofpoint-GUID: 8NkXcGNm6eXVpjTaeMT1e0VxZ9FeT59R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_09,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0
 spamscore=0 impostorscore=0 phishscore=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303200115
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bhagavathi Perumal S <quic_bperumal@quicinc.com>

The WMI management rx event has multiple arrays of TLVs, however the common
WMI TLV parser won't handle multiple TLV tags of same type.
So the multiple array tags of WMI management rx TLV is parsed incorrectly
and the length calculated becomes wrong when the target sends multiple
array tags.

Add separate TLV parser to handle multiple arrays for WMI management rx
TLV. This fixes invalid length issue when the target sends multiple array
tags.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: Bhagavathi Perumal S <quic_bperumal@quicinc.com>
Co-developed-by: Nagarajan Maran <quic_nmaran@quicinc.com>
Signed-off-by: Nagarajan Maran <quic_nmaran@quicinc.com>

---
 drivers/net/wireless/ath/ath11k/wmi.c | 45 +++++++++++++++++++++------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 27f3fceb33c5..f338d4447f11 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -82,6 +82,12 @@ struct wmi_tlv_fw_stats_parse {
 	bool chain_rssi_done;
 };
 
+struct wmi_tlv_mgmt_rx_parse {
+	const struct wmi_mgmt_rx_hdr *fixed;
+	const u8 *frame_buf;
+	bool frame_buf_done;
+};
+
 static const struct wmi_tlv_policy wmi_tlv_policies[] = {
 	[WMI_TAG_ARRAY_BYTE]
 		= { .min_len = 0 },
@@ -5633,28 +5639,49 @@ static int ath11k_pull_vdev_stopped_param_tlv(struct ath11k_base *ab, struct sk_
 	return 0;
 }
 
+static int ath11k_wmi_tlv_mgmt_rx_parse(struct ath11k_base *ab,
+					u16 tag, u16 len,
+					const void *ptr, void *data)
+{
+	struct wmi_tlv_mgmt_rx_parse *parse = data;
+
+	switch (tag) {
+	case WMI_TAG_MGMT_RX_HDR:
+		parse->fixed = ptr;
+		break;
+	case WMI_TAG_ARRAY_BYTE:
+		if (!parse->frame_buf_done) {
+			parse->frame_buf = ptr;
+			parse->frame_buf_done = true;
+		}
+		break;
+	}
+	return 0;
+}
+
 static int ath11k_pull_mgmt_rx_params_tlv(struct ath11k_base *ab,
 					  struct sk_buff *skb,
 					  struct mgmt_rx_event_params *hdr)
 {
-	const void **tb;
+	struct wmi_tlv_mgmt_rx_parse parse = { };
 	const struct wmi_mgmt_rx_hdr *ev;
 	const u8 *frame;
 	int ret;
 
-	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
-	if (IS_ERR(tb)) {
-		ret = PTR_ERR(tb);
-		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
+	ret = ath11k_wmi_tlv_iter(ab, skb->data, skb->len,
+				  ath11k_wmi_tlv_mgmt_rx_parse,
+				  &parse);
+	if (ret) {
+		ath11k_warn(ab, "failed to parse mgmt rx tlv %d\n",
+			    ret);
 		return ret;
 	}
 
-	ev = tb[WMI_TAG_MGMT_RX_HDR];
-	frame = tb[WMI_TAG_ARRAY_BYTE];
+	ev = parse.fixed;
+	frame = parse.frame_buf;
 
 	if (!ev || !frame) {
 		ath11k_warn(ab, "failed to fetch mgmt rx hdr");
-		kfree(tb);
 		return -EPROTO;
 	}
 
@@ -5673,7 +5700,6 @@ static int ath11k_pull_mgmt_rx_params_tlv(struct ath11k_base *ab,
 
 	if (skb->len < (frame - skb->data) + hdr->buf_len) {
 		ath11k_warn(ab, "invalid length in mgmt rx hdr ev");
-		kfree(tb);
 		return -EPROTO;
 	}
 
@@ -5685,7 +5711,6 @@ static int ath11k_pull_mgmt_rx_params_tlv(struct ath11k_base *ab,
 
 	ath11k_ce_byte_swap(skb->data, hdr->buf_len);
 
-	kfree(tb);
 	return 0;
 }
 

base-commit: 3df3715e556027e94246b2cb30986563362a65f4
-- 
2.17.1

