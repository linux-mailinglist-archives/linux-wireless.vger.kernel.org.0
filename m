Return-Path: <linux-wireless+bounces-23506-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 482A9AC956C
	for <lists+linux-wireless@lfdr.de>; Fri, 30 May 2025 20:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C3E3B74E5
	for <lists+linux-wireless@lfdr.de>; Fri, 30 May 2025 18:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0180C277009;
	Fri, 30 May 2025 18:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AbWYpKVv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CFC26463B
	for <linux-wireless@vger.kernel.org>; Fri, 30 May 2025 18:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748628183; cv=none; b=ocKLaPNuIpFLN9IyfuqsZX7H6UFpAHSeDAgwhg45cXlbYmAujHP044XdUYL08HiuvEE7GsR7Txk3fPz9MD/sp7GsS7d7usrVIZX9YlE0IbOIxrWtJteieADqtjJvkxHu1/4CwSL5M5psa9kSuW5Ox8rdTZS9qirtHjwMCZrx4f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748628183; c=relaxed/simple;
	bh=Gs3jU4l33kir9Q4ACsqYdxedfrFyel4trbTjHrJz4zU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=YhVlzkA59UPRMUTYiJyo7qst0ruNY2bQI6ZbqEjwoTNgeTWAw4Njf7fYPVPOyA9ywISa55GKoh5kYh0tLi7xFIlTvl5GHgf0tvO0pllwM/r3X/aGBtgpgYzO+qrAlvDo/VmacivdNn4YYwaJdDD0zbUHZE3SVUV2vJGcG72R6Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AbWYpKVv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54U9nVX0014290
	for <linux-wireless@vger.kernel.org>; Fri, 30 May 2025 18:03:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=sstKLTdJ5BaTm9UV2XH0pQlooV2LCRq6As4GQjiQtMw=; b=Ab
	WYpKVvW/oN2CBFQ0WE4/b9ek2/DdjFL9c9zYYwLTn+LumzF4OmrD/1TQXK32nhNS
	Yb4+lrVjlahZSj+n1b7yZIjLDRWCrbixd2r4sTrTVvr7Jy7rkKr9s0SevZqgIG6F
	x9u1ppZZzjIhWh4R8r362cVMOB6xBDt6kQ3BMGfS7nd9hYqb1rQtEoSMvKq5MmBI
	Rdr+zvKbCshAGWs1oc/3jgPS48TIGJS/6KFldupnkclbqP+IoWv82mjXzL/xc3T1
	FNeo6gb2I9MeD6Hgc65lTFrVIXiEA9KEN7hrx8AlFT01aAHgTmmZcMdK+qECYaQU
	ApaylMltH63D+18A099g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46wavm40ch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 30 May 2025 18:03:01 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-22c31b55ac6so32675735ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 30 May 2025 11:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748628180; x=1749232980;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sstKLTdJ5BaTm9UV2XH0pQlooV2LCRq6As4GQjiQtMw=;
        b=RNSNMePUtQS432WeH3SweJ6B17gdAMM0UP0WTgv8mLy6IJy1iC1uhDNAsEjCFQugQg
         M8JkzhUsUaD7zZKwazwjYerYAiA6er0icc2wIdId1X2lhXJm1wJF3AfTp8IIisfSvNJy
         TWXiAE4PaP0hBYLneUA9832r0GPgvYhWzfyFNRoRjauaPmC0qDhMrgGcy92JRyREwzTb
         nAvxt/mwIIGa3QYq8yTjj8VvJt5ejmpbgQgqOl5hJO5oXoNiXPAv35/BvQLXC3sIL8KZ
         Q8a25RttvOVK9xH7IfIYd5xTXTKEJg1w2/BKDF3OwoQNWoVzRP7s9lil2jYxCpb0AvKW
         8g1A==
X-Gm-Message-State: AOJu0YxpM4MAFwHOAv1+5xmfism54IuSarlSl/6DXTzFpw00KkwIwDmr
	ieMjR6WP0iw1of70JSaPjOXMB524rOEZXwJirZgqva32Col+05FC1Au7JGA/A+aaWOotKTpj/1y
	hoHD4ZhcL1lGLb84RhuPFv3+lbyLIuC6cqNWLdzrahpYVMbo08z3ofizjXr0u6dnwwiYqmQ==
X-Gm-Gg: ASbGncuaw7ofEp3q+IsHQthnLJMFD6xF8hU8z/RU1wRQh+erlOiKTph5ZmaqXpqKUv+
	ayaFkT2O8GBU9IeGIPcdiJ6MMahBUchlglIDaeJgBtR60WgKIQjJ4Udyw7kZDZB3cpDCcVYCFE0
	onpiJtnPvfucv7qCOf0CNHF46vZ7FQRCd5JEl8KFltDCbMXcu+fNBYGIUG7Ba1qv2e5jQXHP8Ll
	yZE9IogmYrlxEGld1hud/34cMBK9+Lxxq92GANJkF3iVP39K73s7rhzdfE9iJ2XMMSLjRGamftK
	tDr74334Eh7+OdMjzlrLAM/d0kaxXMZ2Bb4KC5qNWO0y5Wv53+riQlr2WYgAi6K+ZkDJyY5jrHd
	QrIHXbju8TwTZlWZcobee6Ip4JEc6FgmyzhLgA517BbKmWImN8kyYsdJW
X-Received: by 2002:a17:902:ccd0:b0:210:f706:dc4b with SMTP id d9443c01a7336-23528eedce3mr58333555ad.13.1748628180525;
        Fri, 30 May 2025 11:03:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYSn7RJx8pQlzjYzD7CT51JjXLrU9rnBJj3YSg0fptYM04zJkSIIg9GZtrfFTyLWbhkm72UQ==
X-Received: by 2002:a17:902:ccd0:b0:210:f706:dc4b with SMTP id d9443c01a7336-23528eedce3mr58333025ad.13.1748628179953;
        Fri, 30 May 2025 11:02:59 -0700 (PDT)
Received: from hu-nithp-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bc868asm31374435ad.31.2025.05.30.11.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 11:02:59 -0700 (PDT)
From: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Subject: [PATCH ath-next 2/3] wifi: ath12k: Fix TX status reporting to mac80211 when offload is enabled
Date: Fri, 30 May 2025 23:32:46 +0530
Message-Id: <20250530180247.424349-3-nithyanantham.paramasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250530180247.424349-1-nithyanantham.paramasivam@oss.qualcomm.com>
References: <20250530180247.424349-1-nithyanantham.paramasivam@oss.qualcomm.com>
X-Proofpoint-GUID: 2APuKPitdFqoV64k-rinZru4g96zKrYj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDE1OSBTYWx0ZWRfX72YARddGjYvK
 /Dq6HioXvxyy5ZyapClX34+aQ6IuF946qpWuPXGBwsjlE2q5EUYgvLfZP9YYpjQFYt0Dq4mFSOG
 cJG5zc4fMiM7DoN7uKLKaDZJbUFtB0A/KPiLTVhQHJRT3Ci07SYaPO93t/YIKa9W7lZ/rr+JiaA
 yimmmxGHgDXHKto8/i+mF+rZKiqXLqyAOX/9N06AxtuJ7tmVqFJDiOjDRe62EBhWx1rtxsO8+bO
 gGcV+ePunW70EaT0h7M3uqRZlu33oLZN2GF9H2DU+H9R4oO1aoh0o9EJbyZ7+XbdOIeo14AXGzw
 1HDBBaoj7q0HaT3oBRtPRq3rdiWpBhLUN5K2riT8ZbO0A1dLJx2WMASCHZ4lRbtcmTucswhWk4s
 /xDZ9Kze/fZjbf4me/zWatvGVwTEFTSeZmBcfB+UXUSr4fHrPFfQM8yIEwbgVqfVT6exCbmR
X-Authority-Analysis: v=2.4 cv=fMk53Yae c=1 sm=1 tr=0 ts=6839f2d5 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=5RRWBY4WAAAA:8 a=9wRqoZsPHZivbfTNylsA:9
 a=GvdueXVYPmCkWapjIL-Q:22 a=drtMOSl5Q_Tsf-UZi3mY:22
X-Proofpoint-ORIG-GUID: 2APuKPitdFqoV64k-rinZru4g96zKrYj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_08,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 phishscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=940 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505300159
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

To support all frame formats-including native Wi-Fi, raw, and
Ethernet-station information should instead be retrieved using
ath12k_peer_find_by_id(), and transmission status should be
reported using ieee80211_tx_status_ext().

Additionally, ensure that rate information is included in the
datapath TX status report sent to mac80211.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00217-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_tx.c | 63 +++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index 189c742f2a00..7de545c16d1f 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -569,7 +569,8 @@ static void
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
 	struct ath12k_vif *ahvif;
 	struct ath12k *ar;
 	struct sk_buff *msdu = desc_params->skb;
+	struct ieee80211_tx_status status = { 0 };
+	struct ath12k_peer *peer;
 
 	skb_cb = ATH12K_SKB_CB(msdu);
 	info = IEEE80211_SKB_CB(msdu);
@@ -624,8 +627,24 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
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
@@ -636,6 +655,7 @@ ath12k_dp_tx_process_htt_tx_complete(struct ath12k_base *ab, void *desc,
 	struct htt_tx_wbm_completion *status_desc;
 	struct ath12k_dp_htt_wbm_tx_status ts = {0};
 	enum hal_wbm_htt_tx_comp_status wbm_status;
+	u16 peer_id;
 
 	status_desc = desc;
 
@@ -648,7 +668,11 @@ ath12k_dp_tx_process_htt_tx_complete(struct ath12k_base *ab, void *desc,
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
@@ -799,6 +823,12 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
 	struct ieee80211_vif *vif;
 	struct ath12k_vif *ahvif;
 	struct sk_buff *msdu = desc_params->skb;
+	struct ieee80211_tx_status status = { 0 };
+	struct ieee80211_rate_status status_rate = { 0 };
+	struct ath12k_peer *peer;
+	struct ath12k_link_sta *arsta;
+	struct ath12k_sta *ahsta;
+	struct rate_info rate;
 
 	if (WARN_ON_ONCE(ts->buf_rel_source != HAL_WBM_REL_SRC_MODULE_TQM)) {
 		/* Must not happen */
@@ -885,7 +915,32 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
 
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


