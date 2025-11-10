Return-Path: <linux-wireless+bounces-28744-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F57C45FA5
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 11:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A643AA81F
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 10:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9BA3081CE;
	Mon, 10 Nov 2025 10:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jm9iZjqh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1C33064A3
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 10:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771053; cv=none; b=RNEeptC3UJc5EfpWmj0haqKaWXTXKYtZsDG99cyuEKPRBmia3SULBAoYeTNXhGuCikPPIfYHPM9uZA4VvykVc+75vDPIANkOFfqHS6rKVw0TWOzRCUxGuRX957SwjrXHwt0tnxUXO0WX/WvvhG4tpCT4SCgTVZKF+7FyzR+1T2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771053; c=relaxed/simple;
	bh=k4G6/wmijNok3JNfJiVFe5Cv6Cj/qIm9yRazS24jy0E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p6TaGyShoTZmBXaI5vQQmoxmaEJs+gTCnBUcezL+h4m3IHj8wSWYuCidxIMrxWLCBOQm29uZOR61E+foaXDhr9L2y56USmvswo+7FffMrKrO/n1Pi1j+YhtP4wJZWpkTK7QGKFepRSWSrSfwrCOaFSUNnyezkktP+aP089bxW9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jm9iZjqh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA8Ttoq1672507;
	Mon, 10 Nov 2025 10:37:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=azEBKPU7PHp
	rloK0Q2HbBx9eP176qJoFdiIbFhVb6L8=; b=jm9iZjqhqF1dzJKNlSBxdlefk3l
	wyJ4WR+IkTL6mRD3PIK6z1vQzWyH6jOVEYTyxC/qtxCuVGurD47VGln3rJ/t2jx2
	8aVnIPjkPzplr4+OzZed4D97mXDjX26F7bbtwUiGlgh6P7kXn25CPwXSug3djK0s
	9ga0RnmRoVf3WWiHzsdfhPH/spboz0MQ7ptX00+AYj/FGkJl6lLfMolSU27JM1eJ
	Dy3++/uCzNoX3/KWU212jxtvlaG9cZ5XHihXqaaCEhnjutS8d2VNbvsT3jGoJ7Tr
	A4FrDeoSbpUXswnCypqi1tB5rv/uVK37F2Y9d2eb2HpOhC3aQmF/RvQ1DBg==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xs7ceqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 10:37:21 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAAbIQZ008145;
	Mon, 10 Nov 2025 10:37:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4a9xxkq1gh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 10:37:18 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AAAbIDe008102;
	Mon, 10 Nov 2025 10:37:18 GMT
Received: from hu-devc-blr-u22-c.qualcomm.com (hu-aloksing-blr.qualcomm.com [10.190.111.138])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 5AAAbIGY008096
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 10:37:18 +0000
Received: by hu-devc-blr-u22-c.qualcomm.com (Postfix, from userid 2272527)
	id 8CB4FB6E; Mon, 10 Nov 2025 16:07:16 +0530 (+0530)
From: Alok Singh <quic_aloksing@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Alok Singh <quic_aloksing@quicinc.com>
Subject: [PATCH ath12k-ng 05/12] wifi: ath12k: Move TX monitor functionality to Wi-Fi 7 module
Date: Mon, 10 Nov 2025 16:07:06 +0530
Message-Id: <20251110103713.3484779-6-quic_aloksing@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110103713.3484779-1-quic_aloksing@quicinc.com>
References: <20251110103713.3484779-1-quic_aloksing@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: erxY4FR2xzan_6Rs6UBS_x50F3lvb6rq
X-Proofpoint-ORIG-GUID: erxY4FR2xzan_6Rs6UBS_x50F3lvb6rq
X-Authority-Analysis: v=2.4 cv=LtifC3dc c=1 sm=1 tr=0 ts=6911c062 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8
 a=sHVUcBV4vWwOBuQ15t8A:9 a=KOCKj5Bpm3jaHvXx:21 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA5MiBTYWx0ZWRfXwoDTyJPFpwEp
 ovg+alj5H49vhxQpMmRhhAnQa6mp+hqu1lR+OSLaDeuV0TdrN06FZklaumnz2vV1hYyqcF2daCQ
 btZXqef31h5Ao5ESE6GR4xX+JE4yv+LlCJH34sfuO/bmaNLvv0fYOSTi7QrlIPDHVnXWgVbULmm
 ZlpxvuBKzYKXRkGk3FYchJU7H/tzrsQBJ4qZ6k3mK5Z8Mv2vcSYL+IzpBbqBDIpImquKmdEAvsW
 V7geyS2yX3JMDn05YuFFmWdZLFEeTfEWyOb+hgOCdrs9SqmoGdglNI5QmdPT9TKDyQwMzelPhoc
 XWlSQz5hoIqDVemosPE+gBB7N1N0KhtzMvVnoOINrMP8OzHnmyYUpoDzMbJqbjN4kh0l0l6hCfX
 cw5/p6Oj4yiNx/3ziuAyB+SmF/i3xg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100092

Separate Wi-Fi 7-specific TX monitor functionality from ath12k
common code to improve modularity and maintainability.

Move following TX monitor processing functions to wifi7/dp_mon.c and
rename the functions with the ath12k_wifi7_ prefix:
- ath12k_dp_mon_tx_get_ppdu_info()
- ath12k_dp_mon_hal_tx_ppdu_info()
- ath12k_dp_mon_tx_alloc_skb()
- ath12k_dp_mon_tx_gen_cts2self_frame()
- ath12k_dp_mon_tx_gen_rts_frame()
- ath12k_dp_mon_tx_gen_3addr_qos_null_frame()
- ath12k_dp_mon_tx_gen_4addr_qos_null_frame()
- ath12k_dp_mon_tx_gen_ack_frame()
- ath12k_dp_mon_tx_gen_prot_frame()
- ath12k_dp_mon_tx_parse_status_tlv()
- ath12k_dp_mon_tx_status_get_num_user()
- ath12k_dp_mon_tx_process_ppdu_info()
- ath12k_dp_mon_tx_parse_mon_status()

Export helper functions required by the ath12k_wifi7 module.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1

Signed-off-by: Alok Singh <quic_aloksing@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c      | 671 -----------------
 drivers/net/wireless/ath/ath12k/dp_mon.h      |  11 -
 .../net/wireless/ath/ath12k/wifi7/dp_mon.c    | 676 ++++++++++++++++++
 .../net/wireless/ath/ath12k/wifi7/dp_mon.h    |   6 +
 4 files changed, 682 insertions(+), 682 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index dc4827771a64..d3e662399c31 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -2366,677 +2366,6 @@ int ath12k_dp_mon_status_bufs_replenish(struct ath12k_base *ab,
 	return req_entries - num_remain;
 }
 
-static struct dp_mon_tx_ppdu_info *
-ath12k_dp_mon_tx_get_ppdu_info(struct ath12k_mon_data *pmon,
-			       unsigned int ppdu_id,
-			       enum dp_mon_tx_ppdu_info_type type)
-{
-	struct dp_mon_tx_ppdu_info *tx_ppdu_info;
-
-	if (type == DP_MON_TX_PROT_PPDU_INFO) {
-		tx_ppdu_info = pmon->tx_prot_ppdu_info;
-
-		if (tx_ppdu_info && !tx_ppdu_info->is_used)
-			return tx_ppdu_info;
-		kfree(tx_ppdu_info);
-	} else {
-		tx_ppdu_info = pmon->tx_data_ppdu_info;
-
-		if (tx_ppdu_info && !tx_ppdu_info->is_used)
-			return tx_ppdu_info;
-		kfree(tx_ppdu_info);
-	}
-
-	/* allocate new tx_ppdu_info */
-	tx_ppdu_info = kzalloc(sizeof(*tx_ppdu_info), GFP_ATOMIC);
-	if (!tx_ppdu_info)
-		return NULL;
-
-	tx_ppdu_info->is_used = 0;
-	tx_ppdu_info->ppdu_id = ppdu_id;
-
-	if (type == DP_MON_TX_PROT_PPDU_INFO)
-		pmon->tx_prot_ppdu_info = tx_ppdu_info;
-	else
-		pmon->tx_data_ppdu_info = tx_ppdu_info;
-
-	return tx_ppdu_info;
-}
-
-static struct dp_mon_tx_ppdu_info *
-ath12k_dp_mon_hal_tx_ppdu_info(struct ath12k_mon_data *pmon,
-			       u16 tlv_tag)
-{
-	switch (tlv_tag) {
-	case HAL_TX_FES_SETUP:
-	case HAL_TX_FLUSH:
-	case HAL_PCU_PPDU_SETUP_INIT:
-	case HAL_TX_PEER_ENTRY:
-	case HAL_TX_QUEUE_EXTENSION:
-	case HAL_TX_MPDU_START:
-	case HAL_TX_MSDU_START:
-	case HAL_TX_DATA:
-	case HAL_MON_BUF_ADDR:
-	case HAL_TX_MPDU_END:
-	case HAL_TX_LAST_MPDU_FETCHED:
-	case HAL_TX_LAST_MPDU_END:
-	case HAL_COEX_TX_REQ:
-	case HAL_TX_RAW_OR_NATIVE_FRAME_SETUP:
-	case HAL_SCH_CRITICAL_TLV_REFERENCE:
-	case HAL_TX_FES_SETUP_COMPLETE:
-	case HAL_TQM_MPDU_GLOBAL_START:
-	case HAL_SCHEDULER_END:
-	case HAL_TX_FES_STATUS_USER_PPDU:
-		break;
-	case HAL_TX_FES_STATUS_PROT: {
-		if (!pmon->tx_prot_ppdu_info->is_used)
-			pmon->tx_prot_ppdu_info->is_used = true;
-
-		return pmon->tx_prot_ppdu_info;
-	}
-	}
-
-	if (!pmon->tx_data_ppdu_info->is_used)
-		pmon->tx_data_ppdu_info->is_used = true;
-
-	return pmon->tx_data_ppdu_info;
-}
-
-#define MAX_MONITOR_HEADER 512
-#define MAX_DUMMY_FRM_BODY 128
-
-struct sk_buff *ath12k_dp_mon_tx_alloc_skb(void)
-{
-	struct sk_buff *skb;
-
-	skb = dev_alloc_skb(MAX_MONITOR_HEADER + MAX_DUMMY_FRM_BODY);
-	if (!skb)
-		return NULL;
-
-	skb_reserve(skb, MAX_MONITOR_HEADER);
-
-	if (!IS_ALIGNED((unsigned long)skb->data, 4))
-		skb_pull(skb, PTR_ALIGN(skb->data, 4) - skb->data);
-
-	return skb;
-}
-
-static int
-ath12k_dp_mon_tx_gen_cts2self_frame(struct dp_mon_tx_ppdu_info *tx_ppdu_info)
-{
-	struct sk_buff *skb;
-	struct ieee80211_cts *cts;
-
-	skb = ath12k_dp_mon_tx_alloc_skb();
-	if (!skb)
-		return -ENOMEM;
-
-	cts = (struct ieee80211_cts *)skb->data;
-	memset(cts, 0, MAX_DUMMY_FRM_BODY);
-	cts->frame_control =
-		cpu_to_le16(IEEE80211_FTYPE_CTL | IEEE80211_STYPE_CTS);
-	cts->duration = cpu_to_le16(tx_ppdu_info->rx_status.rx_duration);
-	memcpy(cts->ra, tx_ppdu_info->rx_status.addr1, sizeof(cts->ra));
-
-	skb_put(skb, sizeof(*cts));
-	tx_ppdu_info->tx_mon_mpdu->head = skb;
-	tx_ppdu_info->tx_mon_mpdu->tail = NULL;
-	list_add_tail(&tx_ppdu_info->tx_mon_mpdu->list,
-		      &tx_ppdu_info->dp_tx_mon_mpdu_list);
-
-	return 0;
-}
-
-static int
-ath12k_dp_mon_tx_gen_rts_frame(struct dp_mon_tx_ppdu_info *tx_ppdu_info)
-{
-	struct sk_buff *skb;
-	struct ieee80211_rts *rts;
-
-	skb = ath12k_dp_mon_tx_alloc_skb();
-	if (!skb)
-		return -ENOMEM;
-
-	rts = (struct ieee80211_rts *)skb->data;
-	memset(rts, 0, MAX_DUMMY_FRM_BODY);
-	rts->frame_control =
-		cpu_to_le16(IEEE80211_FTYPE_CTL | IEEE80211_STYPE_RTS);
-	rts->duration = cpu_to_le16(tx_ppdu_info->rx_status.rx_duration);
-	memcpy(rts->ra, tx_ppdu_info->rx_status.addr1, sizeof(rts->ra));
-	memcpy(rts->ta, tx_ppdu_info->rx_status.addr2, sizeof(rts->ta));
-
-	skb_put(skb, sizeof(*rts));
-	tx_ppdu_info->tx_mon_mpdu->head = skb;
-	tx_ppdu_info->tx_mon_mpdu->tail = NULL;
-	list_add_tail(&tx_ppdu_info->tx_mon_mpdu->list,
-		      &tx_ppdu_info->dp_tx_mon_mpdu_list);
-
-	return 0;
-}
-
-static int
-ath12k_dp_mon_tx_gen_3addr_qos_null_frame(struct dp_mon_tx_ppdu_info *tx_ppdu_info)
-{
-	struct sk_buff *skb;
-	struct ieee80211_qos_hdr *qhdr;
-
-	skb = ath12k_dp_mon_tx_alloc_skb();
-	if (!skb)
-		return -ENOMEM;
-
-	qhdr = (struct ieee80211_qos_hdr *)skb->data;
-	memset(qhdr, 0, MAX_DUMMY_FRM_BODY);
-	qhdr->frame_control =
-		cpu_to_le16(IEEE80211_FTYPE_DATA | IEEE80211_STYPE_QOS_NULLFUNC);
-	qhdr->duration_id = cpu_to_le16(tx_ppdu_info->rx_status.rx_duration);
-	memcpy(qhdr->addr1, tx_ppdu_info->rx_status.addr1, ETH_ALEN);
-	memcpy(qhdr->addr2, tx_ppdu_info->rx_status.addr2, ETH_ALEN);
-	memcpy(qhdr->addr3, tx_ppdu_info->rx_status.addr3, ETH_ALEN);
-
-	skb_put(skb, sizeof(*qhdr));
-	tx_ppdu_info->tx_mon_mpdu->head = skb;
-	tx_ppdu_info->tx_mon_mpdu->tail = NULL;
-	list_add_tail(&tx_ppdu_info->tx_mon_mpdu->list,
-		      &tx_ppdu_info->dp_tx_mon_mpdu_list);
-
-	return 0;
-}
-
-static int
-ath12k_dp_mon_tx_gen_4addr_qos_null_frame(struct dp_mon_tx_ppdu_info *tx_ppdu_info)
-{
-	struct sk_buff *skb;
-	struct dp_mon_qosframe_addr4 *qhdr;
-
-	skb = ath12k_dp_mon_tx_alloc_skb();
-	if (!skb)
-		return -ENOMEM;
-
-	qhdr = (struct dp_mon_qosframe_addr4 *)skb->data;
-	memset(qhdr, 0, MAX_DUMMY_FRM_BODY);
-	qhdr->frame_control =
-		cpu_to_le16(IEEE80211_FTYPE_DATA | IEEE80211_STYPE_QOS_NULLFUNC);
-	qhdr->duration = cpu_to_le16(tx_ppdu_info->rx_status.rx_duration);
-	memcpy(qhdr->addr1, tx_ppdu_info->rx_status.addr1, ETH_ALEN);
-	memcpy(qhdr->addr2, tx_ppdu_info->rx_status.addr2, ETH_ALEN);
-	memcpy(qhdr->addr3, tx_ppdu_info->rx_status.addr3, ETH_ALEN);
-	memcpy(qhdr->addr4, tx_ppdu_info->rx_status.addr4, ETH_ALEN);
-
-	skb_put(skb, sizeof(*qhdr));
-	tx_ppdu_info->tx_mon_mpdu->head = skb;
-	tx_ppdu_info->tx_mon_mpdu->tail = NULL;
-	list_add_tail(&tx_ppdu_info->tx_mon_mpdu->list,
-		      &tx_ppdu_info->dp_tx_mon_mpdu_list);
-
-	return 0;
-}
-
-static int
-ath12k_dp_mon_tx_gen_ack_frame(struct dp_mon_tx_ppdu_info *tx_ppdu_info)
-{
-	struct sk_buff *skb;
-	struct dp_mon_frame_min_one *fbmhdr;
-
-	skb = ath12k_dp_mon_tx_alloc_skb();
-	if (!skb)
-		return -ENOMEM;
-
-	fbmhdr = (struct dp_mon_frame_min_one *)skb->data;
-	memset(fbmhdr, 0, MAX_DUMMY_FRM_BODY);
-	fbmhdr->frame_control =
-		cpu_to_le16(IEEE80211_FTYPE_DATA | IEEE80211_STYPE_QOS_CFACK);
-	memcpy(fbmhdr->addr1, tx_ppdu_info->rx_status.addr1, ETH_ALEN);
-
-	/* set duration zero for ack frame */
-	fbmhdr->duration = 0;
-
-	skb_put(skb, sizeof(*fbmhdr));
-	tx_ppdu_info->tx_mon_mpdu->head = skb;
-	tx_ppdu_info->tx_mon_mpdu->tail = NULL;
-	list_add_tail(&tx_ppdu_info->tx_mon_mpdu->list,
-		      &tx_ppdu_info->dp_tx_mon_mpdu_list);
-
-	return 0;
-}
-
-static int
-ath12k_dp_mon_tx_gen_prot_frame(struct dp_mon_tx_ppdu_info *tx_ppdu_info)
-{
-	int ret = 0;
-
-	switch (tx_ppdu_info->rx_status.medium_prot_type) {
-	case DP_MON_TX_MEDIUM_RTS_LEGACY:
-	case DP_MON_TX_MEDIUM_RTS_11AC_STATIC_BW:
-	case DP_MON_TX_MEDIUM_RTS_11AC_DYNAMIC_BW:
-		ret = ath12k_dp_mon_tx_gen_rts_frame(tx_ppdu_info);
-		break;
-	case DP_MON_TX_MEDIUM_CTS2SELF:
-		ret = ath12k_dp_mon_tx_gen_cts2self_frame(tx_ppdu_info);
-		break;
-	case DP_MON_TX_MEDIUM_QOS_NULL_NO_ACK_3ADDR:
-		ret = ath12k_dp_mon_tx_gen_3addr_qos_null_frame(tx_ppdu_info);
-		break;
-	case DP_MON_TX_MEDIUM_QOS_NULL_NO_ACK_4ADDR:
-		ret = ath12k_dp_mon_tx_gen_4addr_qos_null_frame(tx_ppdu_info);
-		break;
-	}
-
-	return ret;
-}
-
-static enum dp_mon_tx_tlv_status
-ath12k_dp_mon_tx_parse_status_tlv(struct ath12k_base *ab,
-				  struct ath12k_mon_data *pmon,
-				  u16 tlv_tag, const void *tlv_data, u32 userid)
-{
-	struct dp_mon_tx_ppdu_info *tx_ppdu_info;
-	enum dp_mon_tx_tlv_status status = DP_MON_TX_STATUS_PPDU_NOT_DONE;
-	u32 info[7];
-
-	tx_ppdu_info = ath12k_dp_mon_hal_tx_ppdu_info(pmon, tlv_tag);
-
-	switch (tlv_tag) {
-	case HAL_TX_FES_SETUP: {
-		const struct hal_tx_fes_setup *tx_fes_setup = tlv_data;
-
-		info[0] = __le32_to_cpu(tx_fes_setup->info0);
-		tx_ppdu_info->ppdu_id = __le32_to_cpu(tx_fes_setup->schedule_id);
-		tx_ppdu_info->num_users =
-			u32_get_bits(info[0], HAL_TX_FES_SETUP_INFO0_NUM_OF_USERS);
-		status = DP_MON_TX_FES_SETUP;
-		break;
-	}
-
-	case HAL_TX_FES_STATUS_END: {
-		const struct hal_tx_fes_status_end *tx_fes_status_end = tlv_data;
-		u32 tst_15_0, tst_31_16;
-
-		info[0] = __le32_to_cpu(tx_fes_status_end->info0);
-		tst_15_0 =
-			u32_get_bits(info[0],
-				     HAL_TX_FES_STATUS_END_INFO0_START_TIMESTAMP_15_0);
-		tst_31_16 =
-			u32_get_bits(info[0],
-				     HAL_TX_FES_STATUS_END_INFO0_START_TIMESTAMP_31_16);
-
-		tx_ppdu_info->rx_status.ppdu_ts = (tst_15_0 | (tst_31_16 << 16));
-		status = DP_MON_TX_FES_STATUS_END;
-		break;
-	}
-
-	case HAL_RX_RESPONSE_REQUIRED_INFO: {
-		const struct hal_rx_resp_req_info *rx_resp_req_info = tlv_data;
-		u32 addr_32;
-		u16 addr_16;
-
-		info[0] = __le32_to_cpu(rx_resp_req_info->info0);
-		info[1] = __le32_to_cpu(rx_resp_req_info->info1);
-		info[2] = __le32_to_cpu(rx_resp_req_info->info2);
-		info[3] = __le32_to_cpu(rx_resp_req_info->info3);
-		info[4] = __le32_to_cpu(rx_resp_req_info->info4);
-		info[5] = __le32_to_cpu(rx_resp_req_info->info5);
-
-		tx_ppdu_info->rx_status.ppdu_id =
-			u32_get_bits(info[0], HAL_RX_RESP_REQ_INFO0_PPDU_ID);
-		tx_ppdu_info->rx_status.reception_type =
-			u32_get_bits(info[0], HAL_RX_RESP_REQ_INFO0_RECEPTION_TYPE);
-		tx_ppdu_info->rx_status.rx_duration =
-			u32_get_bits(info[1], HAL_RX_RESP_REQ_INFO1_DURATION);
-		tx_ppdu_info->rx_status.mcs =
-			u32_get_bits(info[1], HAL_RX_RESP_REQ_INFO1_RATE_MCS);
-		tx_ppdu_info->rx_status.sgi =
-			u32_get_bits(info[1], HAL_RX_RESP_REQ_INFO1_SGI);
-		tx_ppdu_info->rx_status.is_stbc =
-			u32_get_bits(info[1], HAL_RX_RESP_REQ_INFO1_STBC);
-		tx_ppdu_info->rx_status.ldpc =
-			u32_get_bits(info[1], HAL_RX_RESP_REQ_INFO1_LDPC);
-		tx_ppdu_info->rx_status.is_ampdu =
-			u32_get_bits(info[1], HAL_RX_RESP_REQ_INFO1_IS_AMPDU);
-		tx_ppdu_info->rx_status.num_users =
-			u32_get_bits(info[2], HAL_RX_RESP_REQ_INFO2_NUM_USER);
-
-		addr_32 = u32_get_bits(info[3], HAL_RX_RESP_REQ_INFO3_ADDR1_31_0);
-		addr_16 = u32_get_bits(info[3], HAL_RX_RESP_REQ_INFO4_ADDR1_47_32);
-		ath12k_dp_get_mac_addr(addr_32, addr_16, tx_ppdu_info->rx_status.addr1);
-
-		addr_16 = u32_get_bits(info[4], HAL_RX_RESP_REQ_INFO4_ADDR1_15_0);
-		addr_32 = u32_get_bits(info[5], HAL_RX_RESP_REQ_INFO5_ADDR1_47_16);
-		ath12k_dp_get_mac_addr(addr_32, addr_16, tx_ppdu_info->rx_status.addr2);
-
-		if (tx_ppdu_info->rx_status.reception_type == 0)
-			ath12k_dp_mon_tx_gen_cts2self_frame(tx_ppdu_info);
-		status = DP_MON_RX_RESPONSE_REQUIRED_INFO;
-		break;
-	}
-
-	case HAL_PCU_PPDU_SETUP_INIT: {
-		const struct hal_tx_pcu_ppdu_setup_init *ppdu_setup = tlv_data;
-		u32 addr_32;
-		u16 addr_16;
-
-		info[0] = __le32_to_cpu(ppdu_setup->info0);
-		info[1] = __le32_to_cpu(ppdu_setup->info1);
-		info[2] = __le32_to_cpu(ppdu_setup->info2);
-		info[3] = __le32_to_cpu(ppdu_setup->info3);
-		info[4] = __le32_to_cpu(ppdu_setup->info4);
-		info[5] = __le32_to_cpu(ppdu_setup->info5);
-		info[6] = __le32_to_cpu(ppdu_setup->info6);
-
-		/* protection frame address 1 */
-		addr_32 = u32_get_bits(info[1],
-				       HAL_TX_PPDU_SETUP_INFO1_PROT_FRAME_ADDR1_31_0);
-		addr_16 = u32_get_bits(info[2],
-				       HAL_TX_PPDU_SETUP_INFO2_PROT_FRAME_ADDR1_47_32);
-		ath12k_dp_get_mac_addr(addr_32, addr_16, tx_ppdu_info->rx_status.addr1);
-
-		/* protection frame address 2 */
-		addr_16 = u32_get_bits(info[2],
-				       HAL_TX_PPDU_SETUP_INFO2_PROT_FRAME_ADDR2_15_0);
-		addr_32 = u32_get_bits(info[3],
-				       HAL_TX_PPDU_SETUP_INFO3_PROT_FRAME_ADDR2_47_16);
-		ath12k_dp_get_mac_addr(addr_32, addr_16, tx_ppdu_info->rx_status.addr2);
-
-		/* protection frame address 3 */
-		addr_32 = u32_get_bits(info[4],
-				       HAL_TX_PPDU_SETUP_INFO4_PROT_FRAME_ADDR3_31_0);
-		addr_16 = u32_get_bits(info[5],
-				       HAL_TX_PPDU_SETUP_INFO5_PROT_FRAME_ADDR3_47_32);
-		ath12k_dp_get_mac_addr(addr_32, addr_16, tx_ppdu_info->rx_status.addr3);
-
-		/* protection frame address 4 */
-		addr_16 = u32_get_bits(info[5],
-				       HAL_TX_PPDU_SETUP_INFO5_PROT_FRAME_ADDR4_15_0);
-		addr_32 = u32_get_bits(info[6],
-				       HAL_TX_PPDU_SETUP_INFO6_PROT_FRAME_ADDR4_47_16);
-		ath12k_dp_get_mac_addr(addr_32, addr_16, tx_ppdu_info->rx_status.addr4);
-
-		status = u32_get_bits(info[0],
-				      HAL_TX_PPDU_SETUP_INFO0_MEDIUM_PROT_TYPE);
-		break;
-	}
-
-	case HAL_TX_QUEUE_EXTENSION: {
-		const struct hal_tx_queue_exten *tx_q_exten = tlv_data;
-
-		info[0] = __le32_to_cpu(tx_q_exten->info0);
-
-		tx_ppdu_info->rx_status.frame_control =
-			u32_get_bits(info[0],
-				     HAL_TX_Q_EXT_INFO0_FRAME_CTRL);
-		tx_ppdu_info->rx_status.fc_valid = true;
-		break;
-	}
-
-	case HAL_TX_FES_STATUS_START: {
-		const struct hal_tx_fes_status_start *tx_fes_start = tlv_data;
-
-		info[0] = __le32_to_cpu(tx_fes_start->info0);
-
-		tx_ppdu_info->rx_status.medium_prot_type =
-			u32_get_bits(info[0],
-				     HAL_TX_FES_STATUS_START_INFO0_MEDIUM_PROT_TYPE);
-		break;
-	}
-
-	case HAL_TX_FES_STATUS_PROT: {
-		const struct hal_tx_fes_status_prot *tx_fes_status = tlv_data;
-		u32 start_timestamp;
-		u32 end_timestamp;
-
-		info[0] = __le32_to_cpu(tx_fes_status->info0);
-		info[1] = __le32_to_cpu(tx_fes_status->info1);
-
-		start_timestamp =
-			u32_get_bits(info[0],
-				     HAL_TX_FES_STAT_PROT_INFO0_STRT_FRM_TS_15_0);
-		start_timestamp |=
-			u32_get_bits(info[0],
-				     HAL_TX_FES_STAT_PROT_INFO0_STRT_FRM_TS_31_16) << 15;
-		end_timestamp =
-			u32_get_bits(info[1],
-				     HAL_TX_FES_STAT_PROT_INFO1_END_FRM_TS_15_0);
-		end_timestamp |=
-			u32_get_bits(info[1],
-				     HAL_TX_FES_STAT_PROT_INFO1_END_FRM_TS_31_16) << 15;
-		tx_ppdu_info->rx_status.rx_duration = end_timestamp - start_timestamp;
-
-		ath12k_dp_mon_tx_gen_prot_frame(tx_ppdu_info);
-		break;
-	}
-
-	case HAL_TX_FES_STATUS_START_PPDU:
-	case HAL_TX_FES_STATUS_START_PROT: {
-		const struct hal_tx_fes_status_start_prot *tx_fes_stat_start = tlv_data;
-		u64 ppdu_ts;
-
-		info[0] = __le32_to_cpu(tx_fes_stat_start->info0);
-
-		tx_ppdu_info->rx_status.ppdu_ts =
-			u32_get_bits(info[0],
-				     HAL_TX_FES_STAT_STRT_INFO0_PROT_TS_LOWER_32);
-		ppdu_ts = (u32_get_bits(info[1],
-					HAL_TX_FES_STAT_STRT_INFO1_PROT_TS_UPPER_32));
-		tx_ppdu_info->rx_status.ppdu_ts |= ppdu_ts << 32;
-		break;
-	}
-
-	case HAL_TX_FES_STATUS_USER_PPDU: {
-		const struct hal_tx_fes_status_user_ppdu *tx_fes_usr_ppdu = tlv_data;
-
-		info[0] = __le32_to_cpu(tx_fes_usr_ppdu->info0);
-
-		tx_ppdu_info->rx_status.rx_duration =
-			u32_get_bits(info[0],
-				     HAL_TX_FES_STAT_USR_PPDU_INFO0_DURATION);
-		break;
-	}
-
-	case HAL_MACTX_HE_SIG_A_SU:
-		ath12k_dp_mon_parse_he_sig_su(tlv_data, &tx_ppdu_info->rx_status);
-		break;
-
-	case HAL_MACTX_HE_SIG_A_MU_DL:
-		ath12k_dp_mon_parse_he_sig_mu(tlv_data, &tx_ppdu_info->rx_status);
-		break;
-
-	case HAL_MACTX_HE_SIG_B1_MU:
-		ath12k_dp_mon_parse_he_sig_b1_mu(tlv_data, &tx_ppdu_info->rx_status);
-		break;
-
-	case HAL_MACTX_HE_SIG_B2_MU:
-		ath12k_dp_mon_parse_he_sig_b2_mu(tlv_data, &tx_ppdu_info->rx_status);
-		break;
-
-	case HAL_MACTX_HE_SIG_B2_OFDMA:
-		ath12k_dp_mon_parse_he_sig_b2_ofdma(tlv_data, &tx_ppdu_info->rx_status);
-		break;
-
-	case HAL_MACTX_VHT_SIG_A:
-		ath12k_dp_mon_parse_vht_sig_a(tlv_data, &tx_ppdu_info->rx_status);
-		break;
-
-	case HAL_MACTX_L_SIG_A:
-		ath12k_dp_mon_parse_l_sig_a(tlv_data, &tx_ppdu_info->rx_status);
-		break;
-
-	case HAL_MACTX_L_SIG_B:
-		ath12k_dp_mon_parse_l_sig_b(tlv_data, &tx_ppdu_info->rx_status);
-		break;
-
-	case HAL_RX_FRAME_BITMAP_ACK: {
-		const struct hal_rx_frame_bitmap_ack *fbm_ack = tlv_data;
-		u32 addr_32;
-		u16 addr_16;
-
-		info[0] = __le32_to_cpu(fbm_ack->info0);
-		info[1] = __le32_to_cpu(fbm_ack->info1);
-
-		addr_32 = u32_get_bits(info[0],
-				       HAL_RX_FBM_ACK_INFO0_ADDR1_31_0);
-		addr_16 = u32_get_bits(info[1],
-				       HAL_RX_FBM_ACK_INFO1_ADDR1_47_32);
-		ath12k_dp_get_mac_addr(addr_32, addr_16, tx_ppdu_info->rx_status.addr1);
-
-		ath12k_dp_mon_tx_gen_ack_frame(tx_ppdu_info);
-		break;
-	}
-
-	case HAL_MACTX_PHY_DESC: {
-		const struct hal_tx_phy_desc *tx_phy_desc = tlv_data;
-
-		info[0] = __le32_to_cpu(tx_phy_desc->info0);
-		info[1] = __le32_to_cpu(tx_phy_desc->info1);
-		info[2] = __le32_to_cpu(tx_phy_desc->info2);
-		info[3] = __le32_to_cpu(tx_phy_desc->info3);
-
-		tx_ppdu_info->rx_status.beamformed =
-			u32_get_bits(info[0],
-				     HAL_TX_PHY_DESC_INFO0_BF_TYPE);
-		tx_ppdu_info->rx_status.preamble_type =
-			u32_get_bits(info[0],
-				     HAL_TX_PHY_DESC_INFO0_PREAMBLE_11B);
-		tx_ppdu_info->rx_status.mcs =
-			u32_get_bits(info[1],
-				     HAL_TX_PHY_DESC_INFO1_MCS);
-		tx_ppdu_info->rx_status.ltf_size =
-			u32_get_bits(info[3],
-				     HAL_TX_PHY_DESC_INFO3_LTF_SIZE);
-		tx_ppdu_info->rx_status.nss =
-			u32_get_bits(info[2],
-				     HAL_TX_PHY_DESC_INFO2_NSS);
-		tx_ppdu_info->rx_status.chan_num =
-			u32_get_bits(info[3],
-				     HAL_TX_PHY_DESC_INFO3_ACTIVE_CHANNEL);
-		tx_ppdu_info->rx_status.bw =
-			u32_get_bits(info[0],
-				     HAL_TX_PHY_DESC_INFO0_BANDWIDTH);
-		break;
-	}
-
-	case HAL_TX_MPDU_START: {
-		struct dp_mon_mpdu *mon_mpdu = tx_ppdu_info->tx_mon_mpdu;
-
-		mon_mpdu = kzalloc(sizeof(*mon_mpdu), GFP_ATOMIC);
-		if (!mon_mpdu)
-			return DP_MON_TX_STATUS_PPDU_NOT_DONE;
-		status = DP_MON_TX_MPDU_START;
-		break;
-	}
-
-	case HAL_TX_MPDU_END:
-		list_add_tail(&tx_ppdu_info->tx_mon_mpdu->list,
-			      &tx_ppdu_info->dp_tx_mon_mpdu_list);
-		break;
-	}
-
-	return status;
-}
-
-enum dp_mon_tx_tlv_status
-ath12k_dp_mon_tx_status_get_num_user(u16 tlv_tag,
-				     struct hal_tlv_hdr *tx_tlv,
-				     u8 *num_users)
-{
-	u32 tlv_status = DP_MON_TX_STATUS_PPDU_NOT_DONE;
-	u32 info0;
-
-	switch (tlv_tag) {
-	case HAL_TX_FES_SETUP: {
-		struct hal_tx_fes_setup *tx_fes_setup =
-				(struct hal_tx_fes_setup *)tx_tlv;
-
-		info0 = __le32_to_cpu(tx_fes_setup->info0);
-
-		*num_users = u32_get_bits(info0, HAL_TX_FES_SETUP_INFO0_NUM_OF_USERS);
-		tlv_status = DP_MON_TX_FES_SETUP;
-		break;
-	}
-
-	case HAL_RX_RESPONSE_REQUIRED_INFO: {
-		/* TODO: need to update *num_users */
-		tlv_status = DP_MON_RX_RESPONSE_REQUIRED_INFO;
-		break;
-	}
-	}
-
-	return tlv_status;
-}
-
-static void
-ath12k_dp_mon_tx_process_ppdu_info(struct ath12k_pdev_dp *dp_pdev,
-				   struct napi_struct *napi,
-				   struct dp_mon_tx_ppdu_info *tx_ppdu_info)
-{
-	struct dp_mon_mpdu *tmp, *mon_mpdu;
-
-	list_for_each_entry_safe(mon_mpdu, tmp,
-				 &tx_ppdu_info->dp_tx_mon_mpdu_list, list) {
-		list_del(&mon_mpdu->list);
-
-		if (mon_mpdu->head)
-			ath12k_dp_mon_rx_deliver(dp_pdev, mon_mpdu,
-						 &tx_ppdu_info->rx_status, napi);
-
-		kfree(mon_mpdu);
-	}
-}
-
-enum hal_rx_mon_status
-ath12k_dp_mon_tx_parse_mon_status(struct ath12k_pdev_dp *dp_pdev,
-				  struct ath12k_mon_data *pmon,
-				  struct sk_buff *skb,
-				  struct napi_struct *napi,
-				  u32 ppdu_id)
-{
-	struct ath12k_dp *dp = dp_pdev->dp;
-	struct ath12k_base *ab = dp->ab;
-	struct dp_mon_tx_ppdu_info *tx_prot_ppdu_info, *tx_data_ppdu_info;
-	struct hal_tlv_hdr *tlv;
-	u8 *ptr = skb->data;
-	u16 tlv_tag;
-	u16 tlv_len;
-	u32 tlv_userid = 0;
-	u8 num_user;
-	u32 tlv_status = DP_MON_TX_STATUS_PPDU_NOT_DONE;
-
-	tx_prot_ppdu_info = ath12k_dp_mon_tx_get_ppdu_info(pmon, ppdu_id,
-							   DP_MON_TX_PROT_PPDU_INFO);
-	if (!tx_prot_ppdu_info)
-		return -ENOMEM;
-
-	tlv = (struct hal_tlv_hdr *)ptr;
-	tlv_tag = le32_get_bits(tlv->tl, HAL_TLV_HDR_TAG);
-
-	tlv_status = ath12k_dp_mon_tx_status_get_num_user(tlv_tag, tlv, &num_user);
-	if (tlv_status == DP_MON_TX_STATUS_PPDU_NOT_DONE || !num_user)
-		return -EINVAL;
-
-	tx_data_ppdu_info = ath12k_dp_mon_tx_get_ppdu_info(pmon, ppdu_id,
-							   DP_MON_TX_DATA_PPDU_INFO);
-	if (!tx_data_ppdu_info)
-		return -ENOMEM;
-
-	do {
-		tlv = (struct hal_tlv_hdr *)ptr;
-		tlv_tag = le32_get_bits(tlv->tl, HAL_TLV_HDR_TAG);
-		tlv_len = le32_get_bits(tlv->tl, HAL_TLV_HDR_LEN);
-		tlv_userid = le32_get_bits(tlv->tl, HAL_TLV_USR_ID);
-
-		tlv_status = ath12k_dp_mon_tx_parse_status_tlv(ab, pmon,
-							       tlv_tag, ptr,
-							       tlv_userid);
-		ptr += tlv_len;
-		ptr = PTR_ALIGN(ptr, HAL_TLV_ALIGN);
-		if ((ptr - skb->data) >= DP_TX_MONITOR_BUF_SIZE)
-			break;
-	} while (tlv_status != DP_MON_TX_FES_STATUS_END);
-
-	ath12k_dp_mon_tx_process_ppdu_info(dp_pdev, napi, tx_data_ppdu_info);
-	ath12k_dp_mon_tx_process_ppdu_info(dp_pdev, napi, tx_prot_ppdu_info);
-
-	return tlv_status;
-}
-
 static void
 ath12k_dp_mon_rx_update_peer_rate_table_stats(struct ath12k_rx_peer_stats *rx_stats,
 					      struct hal_rx_mon_ppdu_info *ppdu_info,
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.h b/drivers/net/wireless/ath/ath12k/dp_mon.h
index bfea7d4041cb..1d2ec4072a83 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.h
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.h
@@ -85,17 +85,6 @@ int ath12k_dp_mon_buf_replenish(struct ath12k_base *ab,
 int ath12k_dp_mon_status_bufs_replenish(struct ath12k_base *ab,
 					struct dp_rxdma_mon_ring *rx_ring,
 					int req_entries);
-struct sk_buff *ath12k_dp_mon_tx_alloc_skb(void);
-enum dp_mon_tx_tlv_status
-ath12k_dp_mon_tx_status_get_num_user(u16 tlv_tag,
-				     struct hal_tlv_hdr *tx_tlv,
-				     u8 *num_users);
-enum hal_rx_mon_status
-ath12k_dp_mon_tx_parse_mon_status(struct ath12k_pdev_dp *dp_pdev,
-				  struct ath12k_mon_data *pmon,
-				  struct sk_buff *skb,
-				  struct napi_struct *napi,
-				  u32 ppdu_id);
 void ath12k_dp_mon_rx_process_ulofdma(struct hal_rx_mon_ppdu_info *ppdu_info);
 void
 ath12k_dp_mon_rx_update_peer_mu_stats(struct ath12k_base *ab,
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
index 076fb75a101f..abdfd3cfd0e4 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
@@ -331,6 +331,682 @@ ath12k_wifi7_dp_mon_parse_rx_dest_tlv(struct ath12k_pdev_dp *dp_pdev,
 	return 0;
 }
 
+static struct dp_mon_tx_ppdu_info *
+ath12k_wifi7_dp_mon_tx_get_ppdu_info(struct ath12k_mon_data *pmon,
+				     unsigned int ppdu_id,
+				     enum dp_mon_tx_ppdu_info_type type)
+{
+	struct dp_mon_tx_ppdu_info *tx_ppdu_info;
+
+	if (type == DP_MON_TX_PROT_PPDU_INFO) {
+		tx_ppdu_info = pmon->tx_prot_ppdu_info;
+
+		if (tx_ppdu_info && !tx_ppdu_info->is_used)
+			return tx_ppdu_info;
+		kfree(tx_ppdu_info);
+	} else {
+		tx_ppdu_info = pmon->tx_data_ppdu_info;
+
+		if (tx_ppdu_info && !tx_ppdu_info->is_used)
+			return tx_ppdu_info;
+		kfree(tx_ppdu_info);
+	}
+
+	/* allocate new tx_ppdu_info */
+	tx_ppdu_info = kzalloc(sizeof(*tx_ppdu_info), GFP_ATOMIC);
+	if (!tx_ppdu_info)
+		return NULL;
+
+	tx_ppdu_info->is_used = 0;
+	tx_ppdu_info->ppdu_id = ppdu_id;
+
+	if (type == DP_MON_TX_PROT_PPDU_INFO)
+		pmon->tx_prot_ppdu_info = tx_ppdu_info;
+	else
+		pmon->tx_data_ppdu_info = tx_ppdu_info;
+
+	return tx_ppdu_info;
+}
+
+static struct dp_mon_tx_ppdu_info *
+ath12k_wifi7_dp_mon_hal_tx_ppdu_info(struct ath12k_mon_data *pmon,
+				     u16 tlv_tag)
+{
+	switch (tlv_tag) {
+	case HAL_TX_FES_SETUP:
+	case HAL_TX_FLUSH:
+	case HAL_PCU_PPDU_SETUP_INIT:
+	case HAL_TX_PEER_ENTRY:
+	case HAL_TX_QUEUE_EXTENSION:
+	case HAL_TX_MPDU_START:
+	case HAL_TX_MSDU_START:
+	case HAL_TX_DATA:
+	case HAL_MON_BUF_ADDR:
+	case HAL_TX_MPDU_END:
+	case HAL_TX_LAST_MPDU_FETCHED:
+	case HAL_TX_LAST_MPDU_END:
+	case HAL_COEX_TX_REQ:
+	case HAL_TX_RAW_OR_NATIVE_FRAME_SETUP:
+	case HAL_SCH_CRITICAL_TLV_REFERENCE:
+	case HAL_TX_FES_SETUP_COMPLETE:
+	case HAL_TQM_MPDU_GLOBAL_START:
+	case HAL_SCHEDULER_END:
+	case HAL_TX_FES_STATUS_USER_PPDU:
+		break;
+	case HAL_TX_FES_STATUS_PROT: {
+		if (!pmon->tx_prot_ppdu_info->is_used)
+			pmon->tx_prot_ppdu_info->is_used = true;
+
+		return pmon->tx_prot_ppdu_info;
+	}
+	}
+
+	if (!pmon->tx_data_ppdu_info->is_used)
+		pmon->tx_data_ppdu_info->is_used = true;
+
+	return pmon->tx_data_ppdu_info;
+}
+
+#define MAX_MONITOR_HEADER 512
+#define MAX_DUMMY_FRM_BODY 128
+
+static struct
+sk_buff *ath12k_wifi7_dp_mon_tx_alloc_skb(void)
+{
+	struct sk_buff *skb;
+
+	skb = dev_alloc_skb(MAX_MONITOR_HEADER + MAX_DUMMY_FRM_BODY);
+	if (!skb)
+		return NULL;
+
+	skb_reserve(skb, MAX_MONITOR_HEADER);
+
+	if (!IS_ALIGNED((unsigned long)skb->data, 4))
+		skb_pull(skb, PTR_ALIGN(skb->data, 4) - skb->data);
+
+	return skb;
+}
+
+static int
+ath12k_wifi7_dp_mon_tx_gen_cts2self_frame(struct dp_mon_tx_ppdu_info *tx_ppdu_info)
+{
+	struct sk_buff *skb;
+	struct ieee80211_cts *cts;
+
+	skb = ath12k_wifi7_dp_mon_tx_alloc_skb();
+	if (!skb)
+		return -ENOMEM;
+
+	cts = (struct ieee80211_cts *)skb->data;
+	memset(cts, 0, MAX_DUMMY_FRM_BODY);
+	cts->frame_control =
+		cpu_to_le16(IEEE80211_FTYPE_CTL | IEEE80211_STYPE_CTS);
+	cts->duration = cpu_to_le16(tx_ppdu_info->rx_status.rx_duration);
+	memcpy(cts->ra, tx_ppdu_info->rx_status.addr1, sizeof(cts->ra));
+
+	skb_put(skb, sizeof(*cts));
+	tx_ppdu_info->tx_mon_mpdu->head = skb;
+	tx_ppdu_info->tx_mon_mpdu->tail = NULL;
+	list_add_tail(&tx_ppdu_info->tx_mon_mpdu->list,
+		      &tx_ppdu_info->dp_tx_mon_mpdu_list);
+
+	return 0;
+}
+
+static int
+ath12k_wifi7_dp_mon_tx_gen_rts_frame(struct dp_mon_tx_ppdu_info *tx_ppdu_info)
+{
+	struct sk_buff *skb;
+	struct ieee80211_rts *rts;
+
+	skb = ath12k_wifi7_dp_mon_tx_alloc_skb();
+	if (!skb)
+		return -ENOMEM;
+
+	rts = (struct ieee80211_rts *)skb->data;
+	memset(rts, 0, MAX_DUMMY_FRM_BODY);
+	rts->frame_control =
+		cpu_to_le16(IEEE80211_FTYPE_CTL | IEEE80211_STYPE_RTS);
+	rts->duration = cpu_to_le16(tx_ppdu_info->rx_status.rx_duration);
+	memcpy(rts->ra, tx_ppdu_info->rx_status.addr1, sizeof(rts->ra));
+	memcpy(rts->ta, tx_ppdu_info->rx_status.addr2, sizeof(rts->ta));
+
+	skb_put(skb, sizeof(*rts));
+	tx_ppdu_info->tx_mon_mpdu->head = skb;
+	tx_ppdu_info->tx_mon_mpdu->tail = NULL;
+	list_add_tail(&tx_ppdu_info->tx_mon_mpdu->list,
+		      &tx_ppdu_info->dp_tx_mon_mpdu_list);
+
+	return 0;
+}
+
+static int
+ath12k_wifi7_dp_mon_tx_gen_3addr_qos_null_frame(struct dp_mon_tx_ppdu_info *tx_ppdu_info)
+{
+	struct sk_buff *skb;
+	struct ieee80211_qos_hdr *qhdr;
+
+	skb = ath12k_wifi7_dp_mon_tx_alloc_skb();
+	if (!skb)
+		return -ENOMEM;
+
+	qhdr = (struct ieee80211_qos_hdr *)skb->data;
+	memset(qhdr, 0, MAX_DUMMY_FRM_BODY);
+	qhdr->frame_control =
+		cpu_to_le16(IEEE80211_FTYPE_DATA | IEEE80211_STYPE_QOS_NULLFUNC);
+	qhdr->duration_id = cpu_to_le16(tx_ppdu_info->rx_status.rx_duration);
+	memcpy(qhdr->addr1, tx_ppdu_info->rx_status.addr1, ETH_ALEN);
+	memcpy(qhdr->addr2, tx_ppdu_info->rx_status.addr2, ETH_ALEN);
+	memcpy(qhdr->addr3, tx_ppdu_info->rx_status.addr3, ETH_ALEN);
+
+	skb_put(skb, sizeof(*qhdr));
+	tx_ppdu_info->tx_mon_mpdu->head = skb;
+	tx_ppdu_info->tx_mon_mpdu->tail = NULL;
+	list_add_tail(&tx_ppdu_info->tx_mon_mpdu->list,
+		      &tx_ppdu_info->dp_tx_mon_mpdu_list);
+
+	return 0;
+}
+
+static int
+ath12k_wifi7_dp_mon_tx_gen_4addr_qos_null_frame(struct dp_mon_tx_ppdu_info *tx_ppdu_info)
+{
+	struct sk_buff *skb;
+	struct dp_mon_qosframe_addr4 *qhdr;
+
+	skb = ath12k_wifi7_dp_mon_tx_alloc_skb();
+	if (!skb)
+		return -ENOMEM;
+
+	qhdr = (struct dp_mon_qosframe_addr4 *)skb->data;
+	memset(qhdr, 0, MAX_DUMMY_FRM_BODY);
+	qhdr->frame_control =
+		cpu_to_le16(IEEE80211_FTYPE_DATA | IEEE80211_STYPE_QOS_NULLFUNC);
+	qhdr->duration = cpu_to_le16(tx_ppdu_info->rx_status.rx_duration);
+	memcpy(qhdr->addr1, tx_ppdu_info->rx_status.addr1, ETH_ALEN);
+	memcpy(qhdr->addr2, tx_ppdu_info->rx_status.addr2, ETH_ALEN);
+	memcpy(qhdr->addr3, tx_ppdu_info->rx_status.addr3, ETH_ALEN);
+	memcpy(qhdr->addr4, tx_ppdu_info->rx_status.addr4, ETH_ALEN);
+
+	skb_put(skb, sizeof(*qhdr));
+	tx_ppdu_info->tx_mon_mpdu->head = skb;
+	tx_ppdu_info->tx_mon_mpdu->tail = NULL;
+	list_add_tail(&tx_ppdu_info->tx_mon_mpdu->list,
+		      &tx_ppdu_info->dp_tx_mon_mpdu_list);
+
+	return 0;
+}
+
+static int
+ath12k_wifi7_dp_mon_tx_gen_ack_frame(struct dp_mon_tx_ppdu_info *tx_ppdu_info)
+{
+	struct sk_buff *skb;
+	struct dp_mon_frame_min_one *fbmhdr;
+
+	skb = ath12k_wifi7_dp_mon_tx_alloc_skb();
+	if (!skb)
+		return -ENOMEM;
+
+	fbmhdr = (struct dp_mon_frame_min_one *)skb->data;
+	memset(fbmhdr, 0, MAX_DUMMY_FRM_BODY);
+	fbmhdr->frame_control =
+		cpu_to_le16(IEEE80211_FTYPE_DATA | IEEE80211_STYPE_QOS_CFACK);
+	memcpy(fbmhdr->addr1, tx_ppdu_info->rx_status.addr1, ETH_ALEN);
+
+	/* set duration zero for ack frame */
+	fbmhdr->duration = 0;
+
+	skb_put(skb, sizeof(*fbmhdr));
+	tx_ppdu_info->tx_mon_mpdu->head = skb;
+	tx_ppdu_info->tx_mon_mpdu->tail = NULL;
+	list_add_tail(&tx_ppdu_info->tx_mon_mpdu->list,
+		      &tx_ppdu_info->dp_tx_mon_mpdu_list);
+
+	return 0;
+}
+
+static int
+ath12k_wifi7_dp_mon_tx_gen_prot_frame(struct dp_mon_tx_ppdu_info *tx_ppdu_info)
+{
+	int ret = 0;
+
+	switch (tx_ppdu_info->rx_status.medium_prot_type) {
+	case DP_MON_TX_MEDIUM_RTS_LEGACY:
+	case DP_MON_TX_MEDIUM_RTS_11AC_STATIC_BW:
+	case DP_MON_TX_MEDIUM_RTS_11AC_DYNAMIC_BW:
+		ret = ath12k_wifi7_dp_mon_tx_gen_rts_frame(tx_ppdu_info);
+		break;
+	case DP_MON_TX_MEDIUM_CTS2SELF:
+		ret = ath12k_wifi7_dp_mon_tx_gen_cts2self_frame(tx_ppdu_info);
+		break;
+	case DP_MON_TX_MEDIUM_QOS_NULL_NO_ACK_3ADDR:
+		ret = ath12k_wifi7_dp_mon_tx_gen_3addr_qos_null_frame(tx_ppdu_info);
+		break;
+	case DP_MON_TX_MEDIUM_QOS_NULL_NO_ACK_4ADDR:
+		ret = ath12k_wifi7_dp_mon_tx_gen_4addr_qos_null_frame(tx_ppdu_info);
+		break;
+	}
+
+	return ret;
+}
+
+static enum dp_mon_tx_tlv_status
+ath12k_wifi7_dp_mon_tx_parse_status_tlv(struct ath12k_base *ab,
+					struct ath12k_mon_data *pmon,
+					u16 tlv_tag, const void *tlv_data,
+					u32 userid)
+{
+	struct dp_mon_tx_ppdu_info *tx_ppdu_info;
+	enum dp_mon_tx_tlv_status status = DP_MON_TX_STATUS_PPDU_NOT_DONE;
+	u32 info[7];
+
+	tx_ppdu_info = ath12k_wifi7_dp_mon_hal_tx_ppdu_info(pmon, tlv_tag);
+
+	switch (tlv_tag) {
+	case HAL_TX_FES_SETUP: {
+		const struct hal_tx_fes_setup *tx_fes_setup = tlv_data;
+
+		info[0] = __le32_to_cpu(tx_fes_setup->info0);
+		tx_ppdu_info->ppdu_id = __le32_to_cpu(tx_fes_setup->schedule_id);
+		tx_ppdu_info->num_users =
+			u32_get_bits(info[0], HAL_TX_FES_SETUP_INFO0_NUM_OF_USERS);
+		status = DP_MON_TX_FES_SETUP;
+		break;
+	}
+
+	case HAL_TX_FES_STATUS_END: {
+		const struct hal_tx_fes_status_end *tx_fes_status_end = tlv_data;
+		u32 tst_15_0, tst_31_16;
+
+		info[0] = __le32_to_cpu(tx_fes_status_end->info0);
+		tst_15_0 =
+			u32_get_bits(info[0],
+				     HAL_TX_FES_STATUS_END_INFO0_START_TIMESTAMP_15_0);
+		tst_31_16 =
+			u32_get_bits(info[0],
+				     HAL_TX_FES_STATUS_END_INFO0_START_TIMESTAMP_31_16);
+
+		tx_ppdu_info->rx_status.ppdu_ts = (tst_15_0 | (tst_31_16 << 16));
+		status = DP_MON_TX_FES_STATUS_END;
+		break;
+	}
+
+	case HAL_RX_RESPONSE_REQUIRED_INFO: {
+		const struct hal_rx_resp_req_info *rx_resp_req_info = tlv_data;
+		u32 addr_32;
+		u16 addr_16;
+
+		info[0] = __le32_to_cpu(rx_resp_req_info->info0);
+		info[1] = __le32_to_cpu(rx_resp_req_info->info1);
+		info[2] = __le32_to_cpu(rx_resp_req_info->info2);
+		info[3] = __le32_to_cpu(rx_resp_req_info->info3);
+		info[4] = __le32_to_cpu(rx_resp_req_info->info4);
+		info[5] = __le32_to_cpu(rx_resp_req_info->info5);
+
+		tx_ppdu_info->rx_status.ppdu_id =
+			u32_get_bits(info[0], HAL_RX_RESP_REQ_INFO0_PPDU_ID);
+		tx_ppdu_info->rx_status.reception_type =
+			u32_get_bits(info[0], HAL_RX_RESP_REQ_INFO0_RECEPTION_TYPE);
+		tx_ppdu_info->rx_status.rx_duration =
+			u32_get_bits(info[1], HAL_RX_RESP_REQ_INFO1_DURATION);
+		tx_ppdu_info->rx_status.mcs =
+			u32_get_bits(info[1], HAL_RX_RESP_REQ_INFO1_RATE_MCS);
+		tx_ppdu_info->rx_status.sgi =
+			u32_get_bits(info[1], HAL_RX_RESP_REQ_INFO1_SGI);
+		tx_ppdu_info->rx_status.is_stbc =
+			u32_get_bits(info[1], HAL_RX_RESP_REQ_INFO1_STBC);
+		tx_ppdu_info->rx_status.ldpc =
+			u32_get_bits(info[1], HAL_RX_RESP_REQ_INFO1_LDPC);
+		tx_ppdu_info->rx_status.is_ampdu =
+			u32_get_bits(info[1], HAL_RX_RESP_REQ_INFO1_IS_AMPDU);
+		tx_ppdu_info->rx_status.num_users =
+			u32_get_bits(info[2], HAL_RX_RESP_REQ_INFO2_NUM_USER);
+
+		addr_32 = u32_get_bits(info[3], HAL_RX_RESP_REQ_INFO3_ADDR1_31_0);
+		addr_16 = u32_get_bits(info[3], HAL_RX_RESP_REQ_INFO4_ADDR1_47_32);
+		ath12k_dp_get_mac_addr(addr_32, addr_16, tx_ppdu_info->rx_status.addr1);
+
+		addr_16 = u32_get_bits(info[4], HAL_RX_RESP_REQ_INFO4_ADDR1_15_0);
+		addr_32 = u32_get_bits(info[5], HAL_RX_RESP_REQ_INFO5_ADDR1_47_16);
+		ath12k_dp_get_mac_addr(addr_32, addr_16, tx_ppdu_info->rx_status.addr2);
+
+		if (tx_ppdu_info->rx_status.reception_type == 0)
+			ath12k_wifi7_dp_mon_tx_gen_cts2self_frame(tx_ppdu_info);
+		status = DP_MON_RX_RESPONSE_REQUIRED_INFO;
+		break;
+	}
+
+	case HAL_PCU_PPDU_SETUP_INIT: {
+		const struct hal_tx_pcu_ppdu_setup_init *ppdu_setup = tlv_data;
+		u32 addr_32;
+		u16 addr_16;
+
+		info[0] = __le32_to_cpu(ppdu_setup->info0);
+		info[1] = __le32_to_cpu(ppdu_setup->info1);
+		info[2] = __le32_to_cpu(ppdu_setup->info2);
+		info[3] = __le32_to_cpu(ppdu_setup->info3);
+		info[4] = __le32_to_cpu(ppdu_setup->info4);
+		info[5] = __le32_to_cpu(ppdu_setup->info5);
+		info[6] = __le32_to_cpu(ppdu_setup->info6);
+
+		/* protection frame address 1 */
+		addr_32 = u32_get_bits(info[1],
+				       HAL_TX_PPDU_SETUP_INFO1_PROT_FRAME_ADDR1_31_0);
+		addr_16 = u32_get_bits(info[2],
+				       HAL_TX_PPDU_SETUP_INFO2_PROT_FRAME_ADDR1_47_32);
+		ath12k_dp_get_mac_addr(addr_32, addr_16, tx_ppdu_info->rx_status.addr1);
+
+		/* protection frame address 2 */
+		addr_16 = u32_get_bits(info[2],
+				       HAL_TX_PPDU_SETUP_INFO2_PROT_FRAME_ADDR2_15_0);
+		addr_32 = u32_get_bits(info[3],
+				       HAL_TX_PPDU_SETUP_INFO3_PROT_FRAME_ADDR2_47_16);
+		ath12k_dp_get_mac_addr(addr_32, addr_16, tx_ppdu_info->rx_status.addr2);
+
+		/* protection frame address 3 */
+		addr_32 = u32_get_bits(info[4],
+				       HAL_TX_PPDU_SETUP_INFO4_PROT_FRAME_ADDR3_31_0);
+		addr_16 = u32_get_bits(info[5],
+				       HAL_TX_PPDU_SETUP_INFO5_PROT_FRAME_ADDR3_47_32);
+		ath12k_dp_get_mac_addr(addr_32, addr_16, tx_ppdu_info->rx_status.addr3);
+
+		/* protection frame address 4 */
+		addr_16 = u32_get_bits(info[5],
+				       HAL_TX_PPDU_SETUP_INFO5_PROT_FRAME_ADDR4_15_0);
+		addr_32 = u32_get_bits(info[6],
+				       HAL_TX_PPDU_SETUP_INFO6_PROT_FRAME_ADDR4_47_16);
+		ath12k_dp_get_mac_addr(addr_32, addr_16, tx_ppdu_info->rx_status.addr4);
+
+		status = u32_get_bits(info[0],
+				      HAL_TX_PPDU_SETUP_INFO0_MEDIUM_PROT_TYPE);
+		break;
+	}
+
+	case HAL_TX_QUEUE_EXTENSION: {
+		const struct hal_tx_queue_exten *tx_q_exten = tlv_data;
+
+		info[0] = __le32_to_cpu(tx_q_exten->info0);
+
+		tx_ppdu_info->rx_status.frame_control =
+			u32_get_bits(info[0],
+				     HAL_TX_Q_EXT_INFO0_FRAME_CTRL);
+		tx_ppdu_info->rx_status.fc_valid = true;
+		break;
+	}
+
+	case HAL_TX_FES_STATUS_START: {
+		const struct hal_tx_fes_status_start *tx_fes_start = tlv_data;
+
+		info[0] = __le32_to_cpu(tx_fes_start->info0);
+
+		tx_ppdu_info->rx_status.medium_prot_type =
+			u32_get_bits(info[0],
+				     HAL_TX_FES_STATUS_START_INFO0_MEDIUM_PROT_TYPE);
+		break;
+	}
+
+	case HAL_TX_FES_STATUS_PROT: {
+		const struct hal_tx_fes_status_prot *tx_fes_status = tlv_data;
+		u32 start_timestamp;
+		u32 end_timestamp;
+
+		info[0] = __le32_to_cpu(tx_fes_status->info0);
+		info[1] = __le32_to_cpu(tx_fes_status->info1);
+
+		start_timestamp =
+			u32_get_bits(info[0],
+				     HAL_TX_FES_STAT_PROT_INFO0_STRT_FRM_TS_15_0);
+		start_timestamp |=
+			u32_get_bits(info[0],
+				     HAL_TX_FES_STAT_PROT_INFO0_STRT_FRM_TS_31_16) << 15;
+		end_timestamp =
+			u32_get_bits(info[1],
+				     HAL_TX_FES_STAT_PROT_INFO1_END_FRM_TS_15_0);
+		end_timestamp |=
+			u32_get_bits(info[1],
+				     HAL_TX_FES_STAT_PROT_INFO1_END_FRM_TS_31_16) << 15;
+		tx_ppdu_info->rx_status.rx_duration = end_timestamp - start_timestamp;
+
+		ath12k_wifi7_dp_mon_tx_gen_prot_frame(tx_ppdu_info);
+		break;
+	}
+
+	case HAL_TX_FES_STATUS_START_PPDU:
+	case HAL_TX_FES_STATUS_START_PROT: {
+		const struct hal_tx_fes_status_start_prot *tx_fes_stat_start = tlv_data;
+		u64 ppdu_ts;
+
+		info[0] = __le32_to_cpu(tx_fes_stat_start->info0);
+
+		tx_ppdu_info->rx_status.ppdu_ts =
+			u32_get_bits(info[0],
+				     HAL_TX_FES_STAT_STRT_INFO0_PROT_TS_LOWER_32);
+		ppdu_ts = (u32_get_bits(info[1],
+					HAL_TX_FES_STAT_STRT_INFO1_PROT_TS_UPPER_32));
+		tx_ppdu_info->rx_status.ppdu_ts |= ppdu_ts << 32;
+		break;
+	}
+
+	case HAL_TX_FES_STATUS_USER_PPDU: {
+		const struct hal_tx_fes_status_user_ppdu *tx_fes_usr_ppdu = tlv_data;
+
+		info[0] = __le32_to_cpu(tx_fes_usr_ppdu->info0);
+
+		tx_ppdu_info->rx_status.rx_duration =
+			u32_get_bits(info[0],
+				     HAL_TX_FES_STAT_USR_PPDU_INFO0_DURATION);
+		break;
+	}
+
+	case HAL_MACTX_HE_SIG_A_SU:
+		ath12k_dp_mon_parse_he_sig_su(tlv_data, &tx_ppdu_info->rx_status);
+		break;
+
+	case HAL_MACTX_HE_SIG_A_MU_DL:
+		ath12k_dp_mon_parse_he_sig_mu(tlv_data, &tx_ppdu_info->rx_status);
+		break;
+
+	case HAL_MACTX_HE_SIG_B1_MU:
+		ath12k_dp_mon_parse_he_sig_b1_mu(tlv_data, &tx_ppdu_info->rx_status);
+		break;
+
+	case HAL_MACTX_HE_SIG_B2_MU:
+		ath12k_dp_mon_parse_he_sig_b2_mu(tlv_data, &tx_ppdu_info->rx_status);
+		break;
+
+	case HAL_MACTX_HE_SIG_B2_OFDMA:
+		ath12k_dp_mon_parse_he_sig_b2_ofdma(tlv_data, &tx_ppdu_info->rx_status);
+		break;
+
+	case HAL_MACTX_VHT_SIG_A:
+		ath12k_dp_mon_parse_vht_sig_a(tlv_data, &tx_ppdu_info->rx_status);
+		break;
+
+	case HAL_MACTX_L_SIG_A:
+		ath12k_dp_mon_parse_l_sig_a(tlv_data, &tx_ppdu_info->rx_status);
+		break;
+
+	case HAL_MACTX_L_SIG_B:
+		ath12k_dp_mon_parse_l_sig_b(tlv_data, &tx_ppdu_info->rx_status);
+		break;
+
+	case HAL_RX_FRAME_BITMAP_ACK: {
+		const struct hal_rx_frame_bitmap_ack *fbm_ack = tlv_data;
+		u32 addr_32;
+		u16 addr_16;
+
+		info[0] = __le32_to_cpu(fbm_ack->info0);
+		info[1] = __le32_to_cpu(fbm_ack->info1);
+
+		addr_32 = u32_get_bits(info[0],
+				       HAL_RX_FBM_ACK_INFO0_ADDR1_31_0);
+		addr_16 = u32_get_bits(info[1],
+				       HAL_RX_FBM_ACK_INFO1_ADDR1_47_32);
+		ath12k_dp_get_mac_addr(addr_32, addr_16, tx_ppdu_info->rx_status.addr1);
+
+		ath12k_wifi7_dp_mon_tx_gen_ack_frame(tx_ppdu_info);
+		break;
+	}
+
+	case HAL_MACTX_PHY_DESC: {
+		const struct hal_tx_phy_desc *tx_phy_desc = tlv_data;
+
+		info[0] = __le32_to_cpu(tx_phy_desc->info0);
+		info[1] = __le32_to_cpu(tx_phy_desc->info1);
+		info[2] = __le32_to_cpu(tx_phy_desc->info2);
+		info[3] = __le32_to_cpu(tx_phy_desc->info3);
+
+		tx_ppdu_info->rx_status.beamformed =
+			u32_get_bits(info[0],
+				     HAL_TX_PHY_DESC_INFO0_BF_TYPE);
+		tx_ppdu_info->rx_status.preamble_type =
+			u32_get_bits(info[0],
+				     HAL_TX_PHY_DESC_INFO0_PREAMBLE_11B);
+		tx_ppdu_info->rx_status.mcs =
+			u32_get_bits(info[1],
+				     HAL_TX_PHY_DESC_INFO1_MCS);
+		tx_ppdu_info->rx_status.ltf_size =
+			u32_get_bits(info[3],
+				     HAL_TX_PHY_DESC_INFO3_LTF_SIZE);
+		tx_ppdu_info->rx_status.nss =
+			u32_get_bits(info[2],
+				     HAL_TX_PHY_DESC_INFO2_NSS);
+		tx_ppdu_info->rx_status.chan_num =
+			u32_get_bits(info[3],
+				     HAL_TX_PHY_DESC_INFO3_ACTIVE_CHANNEL);
+		tx_ppdu_info->rx_status.bw =
+			u32_get_bits(info[0],
+				     HAL_TX_PHY_DESC_INFO0_BANDWIDTH);
+		break;
+	}
+
+	case HAL_TX_MPDU_START: {
+		struct dp_mon_mpdu *mon_mpdu = tx_ppdu_info->tx_mon_mpdu;
+
+		mon_mpdu = kzalloc(sizeof(*mon_mpdu), GFP_ATOMIC);
+		if (!mon_mpdu)
+			return DP_MON_TX_STATUS_PPDU_NOT_DONE;
+		status = DP_MON_TX_MPDU_START;
+		break;
+	}
+
+	case HAL_TX_MPDU_END:
+		list_add_tail(&tx_ppdu_info->tx_mon_mpdu->list,
+			      &tx_ppdu_info->dp_tx_mon_mpdu_list);
+		break;
+	}
+
+	return status;
+}
+
+static enum dp_mon_tx_tlv_status
+ath12k_wifi7_dp_mon_tx_status_get_num_user(u16 tlv_tag,
+					   struct hal_tlv_hdr *tx_tlv,
+					   u8 *num_users)
+{
+	u32 tlv_status = DP_MON_TX_STATUS_PPDU_NOT_DONE;
+	u32 info0;
+
+	switch (tlv_tag) {
+	case HAL_TX_FES_SETUP: {
+		struct hal_tx_fes_setup *tx_fes_setup =
+				(struct hal_tx_fes_setup *)tx_tlv;
+
+		info0 = __le32_to_cpu(tx_fes_setup->info0);
+
+		*num_users = u32_get_bits(info0, HAL_TX_FES_SETUP_INFO0_NUM_OF_USERS);
+		tlv_status = DP_MON_TX_FES_SETUP;
+		break;
+	}
+
+	case HAL_RX_RESPONSE_REQUIRED_INFO: {
+		/* TODO: need to update *num_users */
+		tlv_status = DP_MON_RX_RESPONSE_REQUIRED_INFO;
+		break;
+	}
+	}
+
+	return tlv_status;
+}
+
+static void
+ath12k_wifi7_dp_mon_tx_process_ppdu_info(struct ath12k_pdev_dp *dp_pdev,
+					 struct napi_struct *napi,
+					 struct dp_mon_tx_ppdu_info *tx_ppdu_info)
+{
+	struct dp_mon_mpdu *tmp, *mon_mpdu;
+
+	list_for_each_entry_safe(mon_mpdu, tmp,
+				 &tx_ppdu_info->dp_tx_mon_mpdu_list, list) {
+		list_del(&mon_mpdu->list);
+
+		if (mon_mpdu->head)
+			ath12k_dp_mon_rx_deliver(dp_pdev, mon_mpdu,
+						 &tx_ppdu_info->rx_status, napi);
+
+		kfree(mon_mpdu);
+	}
+}
+
+enum hal_rx_mon_status
+ath12k_wifi7_dp_mon_tx_parse_mon_status(struct ath12k_pdev_dp *dp_pdev,
+					struct ath12k_mon_data *pmon,
+					struct sk_buff *skb,
+					struct napi_struct *napi,
+					u32 ppdu_id)
+{
+	struct ath12k_dp *dp = dp_pdev->dp;
+	struct ath12k_base *ab = dp->ab;
+	struct dp_mon_tx_ppdu_info *tx_prot_ppdu_info, *tx_data_ppdu_info;
+	struct hal_tlv_hdr *tlv;
+	u8 *ptr = skb->data;
+	u16 tlv_tag;
+	u16 tlv_len;
+	u32 tlv_userid = 0;
+	u8 num_user;
+	u32 tlv_status = DP_MON_TX_STATUS_PPDU_NOT_DONE;
+
+	tx_prot_ppdu_info =
+		ath12k_wifi7_dp_mon_tx_get_ppdu_info(pmon, ppdu_id,
+						     DP_MON_TX_PROT_PPDU_INFO);
+	if (!tx_prot_ppdu_info)
+		return -ENOMEM;
+
+	tlv = (struct hal_tlv_hdr *)ptr;
+	tlv_tag = le32_get_bits(tlv->tl, HAL_TLV_HDR_TAG);
+
+	tlv_status = ath12k_wifi7_dp_mon_tx_status_get_num_user(tlv_tag, tlv,
+								&num_user);
+	if (tlv_status == DP_MON_TX_STATUS_PPDU_NOT_DONE || !num_user)
+		return -EINVAL;
+
+	tx_data_ppdu_info =
+		ath12k_wifi7_dp_mon_tx_get_ppdu_info(pmon, ppdu_id,
+						     DP_MON_TX_DATA_PPDU_INFO);
+	if (!tx_data_ppdu_info)
+		return -ENOMEM;
+
+	do {
+		tlv = (struct hal_tlv_hdr *)ptr;
+		tlv_tag = le32_get_bits(tlv->tl, HAL_TLV_HDR_TAG);
+		tlv_len = le32_get_bits(tlv->tl, HAL_TLV_HDR_LEN);
+		tlv_userid = le32_get_bits(tlv->tl, HAL_TLV_USR_ID);
+
+		tlv_status = ath12k_wifi7_dp_mon_tx_parse_status_tlv(ab, pmon,
+								     tlv_tag, ptr,
+								     tlv_userid);
+		ptr += tlv_len;
+		ptr = PTR_ALIGN(ptr, HAL_TLV_ALIGN);
+		if ((ptr - skb->data) >= DP_TX_MONITOR_BUF_SIZE)
+			break;
+	} while (tlv_status != DP_MON_TX_FES_STATUS_END);
+
+	ath12k_wifi7_dp_mon_tx_process_ppdu_info(dp_pdev, napi, tx_data_ppdu_info);
+	ath12k_wifi7_dp_mon_tx_process_ppdu_info(dp_pdev, napi, tx_prot_ppdu_info);
+
+	return tlv_status;
+}
+
 static u32
 ath12k_wifi7_dp_rx_mon_mpdu_pop(struct ath12k *ar, int mac_id,
 				void *ring_entry, struct sk_buff **head_msdu,
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.h b/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.h
index 3cf82864c41c..148d1e0b70fe 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.h
@@ -14,4 +14,10 @@ enum dp_monitor_mode;
 int ath12k_wifi7_dp_mon_process_ring(struct ath12k_dp *dp, int mac_id,
 				     struct napi_struct *napi, int budget,
 				     enum dp_monitor_mode monitor_mode);
+enum hal_rx_mon_status
+ath12k_wifi7_dp_mon_tx_parse_mon_status(struct ath12k_pdev_dp *dp_pdev,
+					struct ath12k_mon_data *pmon,
+					struct sk_buff *skb,
+					struct napi_struct *napi,
+					u32 ppdu_id);
 #endif
-- 
2.34.1


