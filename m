Return-Path: <linux-wireless+bounces-25970-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B94EB0FF6A
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 06:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD491C853F1
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 04:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F36F1EF09D;
	Thu, 24 Jul 2025 04:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jFHYm5QU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A72A10E0
	for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 04:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753329966; cv=none; b=IC7GFsnPGCMyk3RmkbRMuAADvXxFOV0EAbVEaQpGnS+gbzuGszK/LdJBgSDw7u3dKLXx8xIVDq2VpuBXzvjt8brNkNnBCB+y/u/BeFN7LEW7acJOM4er3/EihzLmoXyB/mGCK8WMG/y1ipx0Cme5cO+EtENZ0rj2WOwkFwbVCUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753329966; c=relaxed/simple;
	bh=RIbMe1Sbv51FjIWKjKWwFB7xwSsUFCWc0XoMM6janvg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R2VWPbZPg6ujpeIFHTjGsUP1VIJADWRA3RAydhRR6xxbOOsKPS+9pRyP2zNXpxbRcH4ZIyLBOxjlW6U+V+zpVfBu0D9Nj28OYi+2+m9TGsmJdhzG2Qd7ShVz/qR/3L5GbgPOPO/kPrAW+yXAX0t0s/Vg3C3Z6wwPcXEG40McL+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jFHYm5QU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NMXRSv022538
	for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 04:05:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=x293Msh9UDQSVhuyx5pXKkWx65B9HMQhf7b
	vndfkyps=; b=jFHYm5QUgEAN2PX1I6kdy8Du+pkjXpVncV9Amweqd83l/k6XoDL
	PPolZ6jia0CZw/8/sjiQqiCmA7ZD5t19BQq5wY0HwRqbYLP5tQaJAtLJ5WBe5RZk
	9LrNfydbY5y7+fsZxEuMOCKE8tdCWMxFYzTAgtkzSg5Wnnt+7NXA7vexMoT4618e
	UC32JisBEkIE8BhcHLmmM9rsadeoFKLJBcrR5oJ3RBDA8YRMdyUccUsDWtl6lEkc
	oa8VPD5OTkTABaWJveboDhBisS8QPvyOIu1N2twc+eZtYa03uHYTHbUeW8Bub2l/
	/wpof5JOZYAR9d7SMLtU9H78DL3WtvzolUg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48313kj09d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 04:05:59 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-31e3d563a53so814054a91.3
        for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 21:05:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753329958; x=1753934758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x293Msh9UDQSVhuyx5pXKkWx65B9HMQhf7bvndfkyps=;
        b=i0oWq5liwJ6y2sy/rGnrCbx2kMyXpAGxsBxjzijNTNXYeIgdCI9ue4iPEhe9tUo7DK
         LR0DoYDWrtWDt5Z//sU8Oo3+3OTtZh3Z92FASSyNyCpBeS6alm/vjCkSGMox7c3mnM6H
         stkIT6CSOa4MjnUDTj633a+ONnHhJPMZOl6Enrfj8fECIjoSfHZrzfxxW11SNYH2shbs
         HEGk8WPK9btZL0W8NMlBXAZBaCciOviZJEm8EcBLOFJB3hdt+XY6BMhSg0QNjH42KVyY
         UbEQ4iO9rGCf0XHyTIXbSiwTcf6yTFPAaT6BCBepUUknV89TqiCAOCcsvTdniKWkSckW
         B1YQ==
X-Gm-Message-State: AOJu0Ywxc6zk3HaAvo6uAV4O9vF6kpVkxTPhm//lXjgwZjIgGnM10eQH
	bxmFeDTrVrTm4asUSSOBP9oUQyvdthtgWZ0Tx6BbV8BbxQGfMs3Xjbaw6HqTQN+867rmj9ZCnGb
	WGFALPbBk816RsO8p88zzSlFLOcjP3fOcd7Dq2lKtLSCsqvt+iwumMuff5zG9qZIGi9A6DQ==
X-Gm-Gg: ASbGncvJcXu7WWHEsKyXeBO6W6IfEutFFPL96M/mgikiqzM99X5Im8B4xiBw+pPJLP8
	gKP+yu6Cyk2F/Vb9nupVTEj3mdzRMEc9xR3MI/8GC8dABHEhkkjS+EMH57TOtOhOd689l8AttfK
	y8+UTyLS2abGzgOOrO4r29exf2K8IqecPYxMapiTvptco6WYErZktyKYjDSj/rn6VCamDKWTsrW
	VhqFBRx/uXZZPciiEB5aQAjlTlLifV96scFl0bR5Js4l5UXoUd4nqCFpl6nivAzF6c5aY+bNypp
	A3vuhemSE1DgMHrVTnRTPypJ/mZX8qrvo1Nbu18jk0jfzx0aMDv8K21T/Eh7vULUJlxI6WHMa+q
	bISmYnHjJbWYXSZjsLx0/MvKJLyLr50lG/kANk3a5IuGGYQM8/UboKA==
X-Received: by 2002:a17:90b:558e:b0:31e:3bac:96bc with SMTP id 98e67ed59e1d1-31e507e8344mr8169610a91.33.1753329958293;
        Wed, 23 Jul 2025 21:05:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7RRLQZ2EKFLTBH+I/O/BM5AMrbNye04wA8S432vnqf1FV08tg7cUWvY7jsYrtsuFxWpbNCA==
X-Received: by 2002:a17:90b:558e:b0:31e:3bac:96bc with SMTP id 98e67ed59e1d1-31e507e8344mr8169576a91.33.1753329957822;
        Wed, 23 Jul 2025 21:05:57 -0700 (PDT)
Received: from hu-aisr-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e662c0383sm253847a91.24.2025.07.23.21.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 21:05:57 -0700 (PDT)
From: Aishwarya R <aishwarya.r@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Hari Chandrakanthan <quic_haric@quicinc.com>,
        Aishwarya R <aishwarya.r@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: Fix peer lookup in ath12k_dp_mon_rx_deliver_msdu()
Date: Thu, 24 Jul 2025 09:35:52 +0530
Message-Id: <20250724040552.1170642-1-aishwarya.r@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDAyMSBTYWx0ZWRfX0e5xqZcO8sfP
 3HFsjF8/1WcFiX0YCsYQtmkOFLfDfEjCJmaIB8P4MukG+NDlhfwQNjfDmtD1a4p/QPdzNsvSrC0
 XxQlGkgjSgDumejLjHY4M1UgbrVbBnHPoOHPB41xBnu34wh5ODJGuFBM7MWD3xp5nUcN6/Q44HL
 vQz04SzS/grjzTu2obcPwfinhefgyZ5WRsg712DbY+JaWWHJutdOXh0/yuZ069V8DdhFArHChMq
 UQaAAte/HZvncAT/6B+nRMGcy2HO0Qf8mfQgaFeEE0X5U8i1NLuv/YxEGQd1JmlL3svDsfAdX4O
 CgGVhp6a0BGMoFEyENTkm9Tboo6VX6Tr3defNQ96v7892TpQwWLJAKhjLvbDUGywrUaYbcfFs+w
 aMPTCE7MO/fQWZ0e2i1ZhWCr9GpJGovLhTvMe+aiw0FIh5efSh6eUCQLPYU4//36Si98JPNo
X-Proofpoint-ORIG-GUID: GcIRYrCyhAQawTfUkERuFOEucZkPFU7i
X-Proofpoint-GUID: GcIRYrCyhAQawTfUkERuFOEucZkPFU7i
X-Authority-Analysis: v=2.4 cv=C/TpyRP+ c=1 sm=1 tr=0 ts=6881b127 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=o0mWW05dekoEtN9qp9QA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 mlxscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240021

From: Hari Chandrakanthan <quic_haric@quicinc.com>

In ath12k_dp_mon_rx_deliver_msdu(), peer lookup fails because
rxcb->peer_id is not updated with a valid value. This is expected
in monitor mode, where RX frames bypass the regular RX
descriptor path that typically sets rxcb->peer_id.
As a result, the peer is NULL, and link_id and link_valid fields
in the RX status are not populated. This leads to a WARN_ON in
mac80211 when it receives data frame from an associated station
with invalid link_id.

Fix this potential issue by using ppduinfo->peer_id, which holds
the correct peer id for the received frame. This ensures that the
peer is correctly found and the associated link metadata is updated
accordingly.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Fixes: bd00cc7e8a4c ("wifi: ath12k: replace the usage of rx desc with rx_info")
Signed-off-by: Hari Chandrakanthan <quic_haric@quicinc.com>
Signed-off-by: Aishwarya R <aishwarya.r@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index b408103fe9d4..73ba756b28a9 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -2244,6 +2244,7 @@ static void ath12k_dp_mon_update_radiotap(struct ath12k *ar,
 
 static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k *ar, struct napi_struct *napi,
 					  struct sk_buff *msdu,
+					  const struct hal_rx_mon_ppdu_info *ppduinfo,
 					  struct ieee80211_rx_status *status,
 					  u8 decap)
 {
@@ -2257,7 +2258,6 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k *ar, struct napi_struct
 	struct ieee80211_sta *pubsta = NULL;
 	struct ath12k_peer *peer;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
-	struct ath12k_dp_rx_info rx_info;
 	bool is_mcbc = rxcb->is_mcbc;
 	bool is_eapol_tkip = rxcb->is_eapol;
 
@@ -2271,8 +2271,7 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k *ar, struct napi_struct
 	}
 
 	spin_lock_bh(&ar->ab->base_lock);
-	rx_info.addr2_present = false;
-	peer = ath12k_dp_rx_h_find_peer(ar->ab, msdu, &rx_info);
+	peer = ath12k_peer_find_by_id(ar->ab, ppduinfo->peer_id);
 	if (peer && peer->sta) {
 		pubsta = peer->sta;
 		if (pubsta->valid_links) {
@@ -2365,7 +2364,7 @@ static int ath12k_dp_mon_rx_deliver(struct ath12k *ar,
 			decap = mon_mpdu->decap_format;
 
 		ath12k_dp_mon_update_radiotap(ar, ppduinfo, mon_skb, rxs);
-		ath12k_dp_mon_rx_deliver_msdu(ar, napi, mon_skb, rxs, decap);
+		ath12k_dp_mon_rx_deliver_msdu(ar, napi, mon_skb, ppduinfo, rxs, decap);
 		mon_skb = skb_next;
 	} while (mon_skb);
 	rxs->flag = 0;

base-commit: 708243c62efde8241e2c66e9c3f377658855149d
-- 
2.34.1


