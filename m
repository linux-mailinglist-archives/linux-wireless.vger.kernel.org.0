Return-Path: <linux-wireless+bounces-25628-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F75FB099F9
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 04:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA8AE1C4522B
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 02:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7090A923;
	Fri, 18 Jul 2025 02:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O2aqXrSi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3F31C860E
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 02:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752807334; cv=none; b=WgOxEzvkcdZjfrgvdWLm+CJEjmbCO1amMBExc3Z57mwCqKK0Ffgf7dgCNtqvA1nFNSqoHSpu2jzz2FVYSFSaciRzLVhGNEv2U0Id7LhLeJASxLCJpYmpzXZBI+qenbcAaneZHjS1RWwQyb0eHceS33il8j2X5ywLFtYLDehcd18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752807334; c=relaxed/simple;
	bh=YcUc6tu8i1c6uNLXdyBgkEeODcG/rXTIu5sqFol5agY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Iu+Lg3cbaSUkhx3I5XtvlNTmgYtHsM9qLVlw52I3MzQ5a+JkGUnqpT3wbQY0xDLw/B4SSnzu8tnIKyIZL0H/F689xyV5+U1FzsmdK/3ut5u5weqt2H7l3ZIQHycSStOCfAsfFOQGivIY2yhA2CaXqp4JRsDxepN2pbNPpurIFXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O2aqXrSi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HLUSjq025197
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 02:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=/5aF3Y37Htuj50hi/E4OxlWZ1R2rw2wLXQRFj5kpMY4=; b=O2
	aqXrSi8MbHoCHXGew/F6650weLr9a7MWTG9hE+wjDOwJ1FjXFHxLmm3n0FWBLT2q
	+UCtR9H+iiSXzirHnGPchdKmBa6wNYnCuCg141UsOE6FGWL84GVGDwSC1T9Co0Bo
	/f0x346m+s3MfumCUIe7YM4gFgkmeaDLGlcmwg69DR3sDFdmY6SvlukGTWVigPJ5
	HbR8q2bUyYa00bUiCbaXUqk8nLpHtIRmoOA3s6qP08hNC8WCe1A5KHtAMiEAqvP1
	xmF3w3MV/CuEaRhjLjIiAFu02PnTdqTdrsMZqWhAZ9CNu05RwNZGMzQSEsbT+bUP
	kwZPlq6SY1p5yNRO6P1g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47xbsqe3f8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 02:55:31 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b31ff607527so1128895a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 19:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752807330; x=1753412130;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/5aF3Y37Htuj50hi/E4OxlWZ1R2rw2wLXQRFj5kpMY4=;
        b=DZgy095djpV8a1GvEkgOwBETMFEeIUTQtt4jkuAkJmp6b5p5MIIoo9KIU/dFgDamiE
         ZHDA2MzeLAoyKZrD3CjIYexcUl9lmST+OxXRvzC5TTRWEVdjujJONFsqllQqbujyHFm6
         qB13Bmhft8ogkCZO3H4A3vnX8OamVqk+CwAgBESJ8Y8qADmgU48j+WM5hZJ71040/7Ue
         gBG/Fi/8dX44bTgxsKJisOdRTMX20t+T7CozhKCADLYnRMtrrpOVa8puC5csfRxKLlzP
         hu1eKiK7PKD6m0slekLev06/zYQ/wfYObsWeUq6MQ8ZCiqKT/n/zAehqT/IlJ5olg+yg
         X3Og==
X-Gm-Message-State: AOJu0YzZZfTGR89yyBjnK2B5PT1p/WmcicxPfz5CHF99V/rHrMxCJk6q
	PnqJ9+TDwmVT7ioEwl8S3TE6qh3WU4ndPKVR4ebSSl6V8+gqITFyEx3pgwtPdL6ZyBkrwu96GgH
	bJb3MEHDDZgRij9dkG1ZeiNQ00gjqvkjv3mb2Zh3y4UcW6+ID4euzPV63HDtb5IViTKgfSlBjX7
	414Q==
X-Gm-Gg: ASbGncspDhzVLOSOkxRtVqTwdYMvjRPfY93COE2emFQZ6MzpOYnB/IasYN2jpD492Za
	J1sND0Zg5Rrr5Re5h09jyxwiFMVf6/85osktGRIPpS35xYbQj4JDqVRTXE8BG01Ut8t8Oo38Vkk
	iP/o64zT84JjmgJZqNsXKGWQ7E2WkduZ/P4jX4RgR8+AI/2F2ijEjNlFbkZ6OQQArCr/TWp8dtV
	qQX7qE0sM50DYAdbmlQ4NpZz2+AJn6KxWC8zxjfgVSFXOtipx+2YKNz6aEOg7bOXPUhgoyV8l8W
	DmzVW9H3de8TxZngBjZldHYHLw3wsUFBBrFlBpx82UoW02O6Ks+kRAaa+HO0MnYmBERAp6SN4jW
	Uj+wZRihSBK/H5v03SMNcMPt80P3dZLVznd199VA79DmZjM4VsEr7OskMHpkoZZOP7Z1EiN6O4A
	==
X-Received: by 2002:a05:6a20:7283:b0:232:6040:ccf0 with SMTP id adf61e73a8af0-23812a5a2fcmr16205605637.27.1752807330183;
        Thu, 17 Jul 2025 19:55:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMlFUJ9wB3L8riEPr4ZMca+vA531Ehwcd3n/RHw/Jkh5QtXvrRfjltD1uhm3u1ecDqWdc4Cg==
X-Received: by 2002:a05:6a20:7283:b0:232:6040:ccf0 with SMTP id adf61e73a8af0-23812a5a2fcmr16205567637.27.1752807329725;
        Thu, 17 Jul 2025 19:55:29 -0700 (PDT)
Received: from hu-nithp-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cbc68095sm255334b3a.139.2025.07.17.19.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 19:55:29 -0700 (PDT)
From: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Subject: [PATCH ath-next v2 2/3] wifi: ath12k: Fix TX status reporting to mac80211 when offload is enabled
Date: Fri, 18 Jul 2025 08:25:12 +0530
Message-Id: <20250718025513.32982-3-nithyanantham.paramasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250718025513.32982-1-nithyanantham.paramasivam@oss.qualcomm.com>
References: <20250718025513.32982-1-nithyanantham.paramasivam@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=ad1hnQot c=1 sm=1 tr=0 ts=6879b7a3 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=5RRWBY4WAAAA:8 a=9wRqoZsPHZivbfTNylsA:9
 a=3WC7DwWrALyhR5TkjVHa:22 a=drtMOSl5Q_Tsf-UZi3mY:22
X-Proofpoint-ORIG-GUID: JgvhLR1pvixqP9IG90l9K266vGx-FrGo
X-Proofpoint-GUID: JgvhLR1pvixqP9IG90l9K266vGx-FrGo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDAyMiBTYWx0ZWRfX9qr+1JwIiiNB
 oLjT0wTuv4z9eIZidQ+d5WZbJHNzndn58CKGaVWypHDgRgsXkBWGhun2WhmFVmGgOuqSMLS8bNq
 BtSqTssAW8Y6bsfmt/hv0xiJjP2jY4HvT6HfMN+BUhhZt5U2Tr4oO2HAazzZikM+RmHmFLxsPwL
 DH6xiWlFvj8fex8K2/OjfhkCiIPJxGWyi85LlKwZeM/7Vaeh+H21ZuFecH22VliRtDPNUKi4dIT
 2+pdER9HYMEiFTkzbPKQJ7oKxpnM2dtocX5HX25u0Rs2RJPK3wPyCPgMrBJwh3FQPnzP0kBgiEX
 aub75YTxOy6DORqEOVjnE+QSnAdtm8+4bK7n4gekexOWN8FejpI7EIos+tlswM6kTr1Rlf9R6RB
 tOazWXfQ9xts9nWFKp2agJXOVRQlVUF2/QrltQGjwL+kap0FxtwETaOIMHsEbLFlyc9he12Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 mlxlogscore=900 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180022
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Currently, the ath12k driver supports only the native Wi-Fi
frame format. In this mode, the ieee80211_tx_status() function
works correctly to report transmission status to mac80211, as
it retrieves station information using sta_info_get_by_addrs().

However, this method is not applicable for Ethernet-converted
packets, since sta_info_get_by_addrs() cannot extract station
information from such formats.

Retrieve station information using ath12k_peer_find_by_id() to
support all frame formats, including native Wi-Fi, raw, and Ethernet.
Report transmission status using ieee80211_tx_status_ext(), and
include rate information as part of the datapath TX status report.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00217-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_tx.c | 64 +++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index e8d3bcc90a2d..c102628c2e5f 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -568,7 +568,8 @@ static void
 ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
 				 struct ath12k_tx_desc_params *desc_params,
 				 struct dp_tx_ring *tx_ring,
-				 struct ath12k_dp_htt_wbm_tx_status *ts)
+				 struct ath12k_dp_htt_wbm_tx_status *ts,
+				 u16 peer_id)
 {
 	struct ieee80211_tx_info *info;
 	struct ath12k_link_vif *arvif;
@@ -578,6 +579,8 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
 	struct ath12k *ar;
 	struct sk_buff *msdu = desc_params->skb;
 	s32 noise_floor;
+	struct ieee80211_tx_status status = { 0 };
+	struct ath12k_peer *peer;
 
 	skb_cb = ATH12K_SKB_CB(msdu);
 	info = IEEE80211_SKB_CB(msdu);
@@ -629,8 +632,25 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
 			info->flags |= IEEE80211_TX_STAT_NOACK_TRANSMITTED;
 		}
 	}
+	rcu_read_lock();
+	spin_lock_bh(&ab->base_lock);
+	peer = ath12k_peer_find_by_id(ab, peer_id);
+	if (!peer || !peer->sta) {
+		ath12k_dbg(ab, ATH12K_DBG_DATA,
+			   "dp_tx: failed to find the peer with peer_id %d\n", peer_id);
+		spin_unlock_bh(&ab->base_lock);
+		ieee80211_free_txskb(ath12k_ar_to_hw(ar), msdu);
+		goto exit;
+	} else {
+		status.sta = peer->sta;
+	}
+	spin_unlock_bh(&ab->base_lock);
 
-	ieee80211_tx_status_skb(ath12k_ar_to_hw(ar), msdu);
+	status.info = info;
+	status.skb = msdu;
+	ieee80211_tx_status_ext(ath12k_ar_to_hw(ar), &status);
+exit:
+	rcu_read_unlock();
 }
 
 static void
@@ -641,6 +661,7 @@ ath12k_dp_tx_process_htt_tx_complete(struct ath12k_base *ab, void *desc,
 	struct htt_tx_wbm_completion *status_desc;
 	struct ath12k_dp_htt_wbm_tx_status ts = {0};
 	enum hal_wbm_htt_tx_comp_status wbm_status;
+	u16 peer_id;
 
 	status_desc = desc;
 
@@ -653,7 +674,11 @@ ath12k_dp_tx_process_htt_tx_complete(struct ath12k_base *ab, void *desc,
 		ts.acked = (wbm_status == HAL_WBM_REL_HTT_TX_COMP_STATUS_OK);
 		ts.ack_rssi = le32_get_bits(status_desc->info2,
 					    HTT_TX_WBM_COMP_INFO2_ACK_RSSI);
-		ath12k_dp_tx_htt_tx_complete_buf(ab, desc_params, tx_ring, &ts);
+
+		peer_id = le32_get_bits(((struct hal_wbm_completion_ring_tx *)desc)->
+				info3, HAL_WBM_COMPL_TX_INFO3_PEER_ID);
+
+		ath12k_dp_tx_htt_tx_complete_buf(ab, desc_params, tx_ring, &ts, peer_id);
 		break;
 	case HAL_WBM_REL_HTT_TX_COMP_STATUS_DROP:
 	case HAL_WBM_REL_HTT_TX_COMP_STATUS_TTL:
@@ -805,6 +830,12 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
 	struct ath12k_vif *ahvif;
 	struct sk_buff *msdu = desc_params->skb;
 	s32 noise_floor;
+	struct ieee80211_tx_status status = { 0 };
+	struct ieee80211_rate_status status_rate = { 0 };
+	struct ath12k_peer *peer;
+	struct ath12k_link_sta *arsta;
+	struct ath12k_sta *ahsta;
+	struct rate_info rate;
 
 	if (WARN_ON_ONCE(ts->buf_rel_source != HAL_WBM_REL_SRC_MODULE_TQM)) {
 		/* Must not happen */
@@ -896,7 +927,32 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
 
 	ath12k_dp_tx_update_txcompl(ar, ts);
 
-	ieee80211_tx_status_skb(ath12k_ar_to_hw(ar), msdu);
+	spin_lock_bh(&ab->base_lock);
+	peer = ath12k_peer_find_by_id(ab, ts->peer_id);
+	if (!peer || !peer->sta) {
+		ath12k_err(ab,
+			   "dp_tx: failed to find the peer with peer_id %d\n",
+			   ts->peer_id);
+		spin_unlock_bh(&ab->base_lock);
+		ieee80211_free_txskb(ath12k_ar_to_hw(ar), msdu);
+		goto exit;
+	}
+	ahsta = ath12k_sta_to_ahsta(peer->sta);
+	arsta = &ahsta->deflink;
+
+	spin_unlock_bh(&ab->base_lock);
+
+	status.sta = peer->sta;
+	status.info = info;
+	status.skb = msdu;
+	rate = arsta->last_txrate;
+
+	status_rate.rate_idx = rate;
+	status_rate.try_count = 1;
+
+	status.rates = &status_rate;
+	status.n_rates = 1;
+	ieee80211_tx_status_ext(ath12k_ar_to_hw(ar), &status);
 
 exit:
 	rcu_read_unlock();
-- 
2.17.1


