Return-Path: <linux-wireless+bounces-23730-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5EAACE974
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 07:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A794173813
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 05:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F93E1DB34B;
	Thu,  5 Jun 2025 05:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H0ghIfgR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C401AD3E5
	for <linux-wireless@vger.kernel.org>; Thu,  5 Jun 2025 05:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749102637; cv=none; b=afh6y4Jt5yqzJX/orJld/D7XBsHqDdtYLVBlZA85l2bJ+2Sbl8/UP6gR681bL5Lmg7vnPbPU78Oq1afwSrvnKMugyhS+y7iV7i9HHSco52XNxUxDF21/iEy7mq5pdtbAJ5V2/SZeuGI8ahiagYF9WLtYz6IF1OuHUF0Tx+EnRXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749102637; c=relaxed/simple;
	bh=OneoRMzMAqeL9bcmSVEl0VUMW29SNQYC8chJOTgYNDk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uMIU1+1MyoodFCv3C1jmxo3zX3kf/JGsJ9f5aqdBPGZAz85B53+j7+TXg6opkgtxI+7rAKYCkI+Bk798B2nt8H2ZiRjwhDkZKDN2H4wX5cTwl0Y0U+TFq7BeLj2eSV1BbMN5FAFBWJVYrRCb/rzdu/cwITgsrbX/bJlw3CT2mxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H0ghIfgR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554LMxrN014030
	for <linux-wireless@vger.kernel.org>; Thu, 5 Jun 2025 05:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=AmfveYyUzz3HLoOz48JItt7Y3x48XLDOXgz
	/I8EFHUE=; b=H0ghIfgRsFyiq6EKileOX5SCm5lEJ46ZyRyZutjksvrJp5Q2GrR
	7liN8/fLzJpDNabJjQsaQ5a3WOZUYvl8tVUczryLyTii78HN6jBfzCuKTzp5vmgH
	jIUdDKb+9cPHVGYrVxuEXWPlsblR23SKQcozM1GNWpM7BWyUGLWmUXFeEsPgN0T2
	rcOxRFbE5bmb5c3LLa4gEEHtZnLGQS4qevtfYFU/PRRamfZI4FhW89jac9FDUlbz
	75yVkrAxdb6vETrUHL117Xp1/M5lju2yORgobwpf1bMVb7oI2g+zGRZdv6sCXyRg
	MoKfz8BUgeUY+OZPlU4J7HGIyZcDWYtB7xA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 472be83y6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 05 Jun 2025 05:50:34 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b2ede156ec4so724889a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 04 Jun 2025 22:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749102634; x=1749707434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AmfveYyUzz3HLoOz48JItt7Y3x48XLDOXgz/I8EFHUE=;
        b=EfokTZceV5mwut7awBr2khsMPHj7IDDM/STCL+1XBhOK++D/zoKRlhoMQJRdoPDdFb
         rxi6ntmAOsERlVadDKahVSGNKoR22zUsJ9jNWpJpkvejnHGAU7MeqVGYYxHobZvMeRk0
         PksOmbFoy2S/drbodCoexU3PRVAQwX1k3tov0eR+lVz2LXfLpy07GI6YosP5wETESGaB
         hzaWSgH3Xs6q/bMGZiBduyVbUyoKBZ094/4ZjljAGm595ufO3VmeKwnWe8u/Tl1RYqYZ
         UB93lFwgBrrxM2DdZN64IvjUmgHnL69tEu1z5QHsNlm5cpFfQgEGCo9+tt+m7yaYQOhB
         w88g==
X-Gm-Message-State: AOJu0Yw8gwalgWUXH7AyjU3+J/DMLEk3nhO0GGQT2NIu0N8CkiEOkHPS
	Z24KEfyMwGXDlSeONpnaGNoXQbOMwjg+ILa8zSUIMMoyJRVND9/iypWXNSj8WC7SHcYj5f3WdDV
	xxTrbXG7uVPb++aGbLZ6RYIebp0Fu20l1EqOWBAGOMwxHJrn7FvDhYESa0ysUeDQJU6Apvyo+d5
	40Ow==
X-Gm-Gg: ASbGncuNFveNC8FNtG5H81w9UMk4XfJWh21O+CfKcrAQLCpbZDXbGjJ55ccObvtH3XM
	h1ZN6zR2SopajE6NsLu57HJASNhCzGOpRmk8XUvyQpPbtxzTi0bvMM8bCDZHsI6uDJvMFWfxOjy
	oawETYkVQblPHV+sXNJOo+/rXsDijI4mjcr35dtGOGfriWljkL1WK3mUjerCfm6YmQPf4p09Hn/
	Ef6qWkxptyzri3BSl9V0dCvNFNd5Unq/dogJNCEWYiNQMq+W5Nn0xj6GMhWjxzXKNIVLnlgsTwz
	VdkzeLdqvbU+5rLo/oow43z/3YQ2P0Bckpl4b8fSyHvFl0lrhZA4g7TusdrcxK0IgX0XjtOhI39
	DEhNnpaLe2GqSed7h8UaMNqthACtoLw==
X-Received: by 2002:a17:902:d484:b0:234:f4da:7eef with SMTP id d9443c01a7336-235e122a9b8mr70067485ad.52.1749102633622;
        Wed, 04 Jun 2025 22:50:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYAfaXDJywW3iDzWpFksbi0hvBeqtK6pVImfikKDuKXfpQ8khbucDl1XqnNpYxhWRhT0Kiyw==
X-Received: by 2002:a17:902:d484:b0:234:f4da:7eef with SMTP id d9443c01a7336-235e122a9b8mr70067235ad.52.1749102633222;
        Wed, 04 Jun 2025 22:50:33 -0700 (PDT)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf539esm112561465ad.194.2025.06.04.22.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 22:50:32 -0700 (PDT)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, P Praneesh <praneesh.p@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: remove monitor handling from ath12k_dp_rx_deliver_msdu()
Date: Thu,  5 Jun 2025 11:14:38 +0530
Message-Id: <20250605054438.1855365-1-praneesh.p@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bNYWIO+Z c=1 sm=1 tr=0 ts=6841302a cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=VBHITUC6nVLiB0tyTDQA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: MIL3Z15p1pyk45oKPpXmWuF90kYjiCIS
X-Proofpoint-ORIG-GUID: MIL3Z15p1pyk45oKPpXmWuF90kYjiCIS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDA1MCBTYWx0ZWRfX15nLd52egZ2N
 DSbB1LqlymC8TJjMPrY53YBWKyHfTcYt5bInYHqikbaPeJl20Xg7rORt+GU6vgTGF+NzjT+ysko
 OncrdPeUl7hOB+qSnhFKYDEMJiEUZ5tza+uW8nN0UUKxHA6ZD1wY3BJj0VG2YGLnK6wtXtCBZpY
 s2vOmZuftAs5KuCB8VeOXz7roH+DOiyYLYMOuw4/ODVgFbtiiPDkWxxkr66AwFhgklQpI2jPRs+
 vRuTirX+KhnqLtnodcrsvAEeB2I7D2OhlYjW1VTW8XI4j/K0wv67j03d83BSbYZdjfAKk0w3gAO
 zFnryDQajdt8qoxgZPIWW6hSwcyggQIAbQqj+yBDaXjCytTw9K4ldkaCXDsnTF0K2OTiK1HkBEK
 lQe90UB1/HezUtbvtt/FXGbVaLopd2wBDYsyJAo7KwGGLMJ9LyolnwrbosF1DHPjTiucQSU+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_01,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 impostorscore=0 spamscore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506050050

ath12k_dp_rx_deliver_msdu() currently includes logic related to
monitor mode handling. This code was inherited from the ath11k driver,
where a single rx handler was used for both regular and monitor mode
packets. In ath12k, however, monitor mode packets are handled separately
via ath12k_dp_mon_rx_deliver_msdu(), which contains all the necessary
monitor-specific logic. Therefore, monitor-related checks and operations
in ath12k_dp_rx_deliver_msdu() are no longer needed. Remove this dead code
to simplify the rx path and avoid unnecessary per-packet checks.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 7e1a8f29c7b6..490ad1cc81d1 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2533,31 +2533,15 @@ static void ath12k_dp_rx_deliver_msdu(struct ath12k *ar, struct napi_struct *nap
 				      struct ath12k_dp_rx_info *rx_info)
 {
 	struct ath12k_base *ab = ar->ab;
-	static const struct ieee80211_radiotap_he known = {
-		.data1 = cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_DATA_MCS_KNOWN |
-				     IEEE80211_RADIOTAP_HE_DATA1_BW_RU_ALLOC_KNOWN),
-		.data2 = cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA2_GI_KNOWN),
-	};
-	struct ieee80211_radiotap_he *he;
 	struct ieee80211_rx_status *rx_status;
 	struct ieee80211_sta *pubsta;
 	struct ath12k_peer *peer;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
 	struct ieee80211_rx_status *status = rx_info->rx_status;
-	u8 decap = DP_RX_DECAP_TYPE_RAW;
+	u8 decap = rx_info->decap_type;
 	bool is_mcbc = rxcb->is_mcbc;
 	bool is_eapol = rxcb->is_eapol;
 
-	if (status->encoding == RX_ENC_HE && !(status->flag & RX_FLAG_RADIOTAP_HE) &&
-	    !(status->flag & RX_FLAG_SKIP_MONITOR)) {
-		he = skb_push(msdu, sizeof(known));
-		memcpy(he, &known, sizeof(known));
-		status->flag |= RX_FLAG_RADIOTAP_HE;
-	}
-
-	if (!(status->flag & RX_FLAG_ONLY_MONITOR))
-		decap = rx_info->decap_type;
-
 	spin_lock_bh(&ab->base_lock);
 	peer = ath12k_dp_rx_h_find_peer(ab, msdu, rx_info);
 

base-commit: 1b98f357dadd6ea613a435fbaef1a5dd7b35fd21
-- 
2.34.1


