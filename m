Return-Path: <linux-wireless+bounces-21775-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B54FA94B0E
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 04:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC145188E5BB
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 02:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B252571DA;
	Mon, 21 Apr 2025 02:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U1ihZKE4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E665B2571CE
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745202943; cv=none; b=kaXpzEznXtJ6EzMkl4RB7E5yncsp3HtQi8pYlPqsqEvB8VN6TI6dwBAPtNiIw25QVecE3o/HI3pKnXec6gMI3t1NQuoBmM4YPHn4YrUNVvQHA4IfmYfonPeRrLFRbuHhtE1Vt0sx4fD/4aeS7ZTYaosyhBazjSD9a05snCvXYOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745202943; c=relaxed/simple;
	bh=Cn0zf3ReHTZ+gJOA+d/mphNbQfvn8BKjPgiNjFuRAUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mcNghz52ti2NQYptBT/tJou+rAvkaZVDMmp6A0Ov+2cXzLO1t0LsCXDeIj3SjhSVe5EJb2C2Tty4kQSWg15eraKcQE7Y2IyC/1ubQIzH/B3be9mnwPIHHfIuFHqPYtsi4oebHLLR8CkGEEKZLbZtjc9otMx0Z7s/c7KKLVeGmyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U1ihZKE4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53KMWErE001601
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=gesON2CEg60
	SDvlicUFLEupsU8yrVPsf/z621XhBNZM=; b=U1ihZKE4MmcJ8hgojGukEruQOAH
	SHwvWSAQGyyu6+ccskEz+u7I4Cni7IH2rEhV8Gcp9QfeAeC1lGnNe+k7KPxw+XP9
	VHDgfDD7v0AIG8MsSBN9WZnnTHjCcXo46b+iNGrsCc6lM7EhjZOEe/ckrOeofqbW
	ZM0pOCCOE6X7zsKQal3o668Uwgc5MR2UfwG5F9B3/xBfZw25wS7HnT7NYaW6hKj/
	/mDtXSJDCXMBJinsy09j4W+ZPF2YOSOCTgTgHoV5JJPcOcdYytSawg1QB+WDFr5i
	N1UWYvFmO4zBcvpZSm/OpEc9CTAlUWiWghkNcUBTP6HTue7UZ1rfj+V2Fxg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4644kjaq3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:41 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-224347aef79so49125095ad.2
        for <linux-wireless@vger.kernel.org>; Sun, 20 Apr 2025 19:35:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745202938; x=1745807738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gesON2CEg60SDvlicUFLEupsU8yrVPsf/z621XhBNZM=;
        b=JWy269NrGtXagWHMeHWPss0aiRGHNKadmIPapTr/FBhH7IrTh2S9AHOvbVAumHQUQC
         vdnBTX8ar6ekQiCUICJald3GaPtIAw9s1e2+u+pTsTwTVVS2eSdt6DpiXDUSg457kY+F
         2YAB/CL+pfv+H8C3xP4zr7OMdfWkvHEVYhV88zgB2GWWxRTXX0Bsn/EV3Icy0Ur3iEZ+
         X2ilYfgjWEfLTpq4RiRHGY5PayOiKf7yuKwvNcrqjLxHBetCXQhn02x5NzDrVXYi6mNm
         s2iZQsWUjKrjp0Ixo4TRtB2TrTBb7cwLtVfobWmnJ+O6tY/nIIa4vrjvfwviw1USSy07
         32Pw==
X-Gm-Message-State: AOJu0YwY0a97xnSIyxHBxyWS6eEYzXlTsgM1KYRUnGPH/SV/ziXbiv/j
	vZzsnrclsm4oXrUTH6Tk0p5KGQNWVMdrr1xMbfRqeUlXqtGDe8EceSMZeDzVvku5tjSjJaTP19z
	6lUKdsoX61VGXHDg1GZre2da+FB+OAvHl0zDM7x9BhGMyOWJ+gge0iLnbRdWrVH5pnHPaRdFSpn
	My
X-Gm-Gg: ASbGncssZu+zqVTbkPlhQ+lbxDtDKpEzWQeXiTttq2e7qKXEyGMDwfocW6S07iXV69Q
	HgwqLaD7CwDUOuu+k0q1PkV0tmDbm0Rt2/lUTyL4OQV0bMDcBjW/DEMRrITUcAn8lQ9GcD31/4d
	fJjYLEub4h65NYUSyYac+xtBGBfeiFbmXZMGBWUbM2erxEw5oo75kXF6KCeEAA13qYutCM0EZ8J
	69F8I8HgOgpnuIepUJgswtvcM061LYZ2h9JJClabHy4Xk9e7uzoJVMU3zc96mWzJHS9oLY67aFB
	m63Ps0MXrdYmpwKEr+EjCGWyPH+Kiax6jeG6RDHyf2KOzr2ogKu+4evnJl/htsW9yBWyIIqxsLH
	TKfh5wIE00M0=
X-Received: by 2002:a17:902:d546:b0:227:e74a:a057 with SMTP id d9443c01a7336-22c53631d76mr157868505ad.44.1745202938317;
        Sun, 20 Apr 2025 19:35:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQrbfsrPTpnu5PWwGEpRYv0c+vIVsT++xkokknPcxMUq0vFPisysy1eBQlP3GsCCga9SrssQ==
X-Received: by 2002:a17:902:d546:b0:227:e74a:a057 with SMTP id d9443c01a7336-22c53631d76mr157868195ad.44.1745202937884;
        Sun, 20 Apr 2025 19:35:37 -0700 (PDT)
Received: from kangyang.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb4287sm54631685ad.130.2025.04.20.19.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 19:35:37 -0700 (PDT)
From: Kang Yang <kang.yang@oss.qualcomm.com>
To: ath12k@lists.infradead.org, kang.yang@oss.qualcomm.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next 12/13] wifi: ath12k: use different packet offset for WCN7850
Date: Mon, 21 Apr 2025 10:34:43 +0800
Message-Id: <20250421023444.1778-13-kang.yang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20250421023444.1778-1-kang.yang@oss.qualcomm.com>
References: <20250421023444.1778-1-kang.yang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4OyQ_XlIyGYPSeGter_-eaojSVVr6X4Y
X-Authority-Analysis: v=2.4 cv=f5pIBPyM c=1 sm=1 tr=0 ts=6805aefd cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=QblmAMADz5KIc7vKYBUA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: 4OyQ_XlIyGYPSeGter_-eaojSVVr6X4Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_01,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxlogscore=837 mlxscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504210018

In ath12k_dp_mon_rx_merg_msdus(), will set packet offset to 8. This is a
right value for QCN9274.

But WCN7850 use different hardware rings for monitor mode because it
doesn't have RX MON component. So the packet offset is different. With
current offset, upper-layer application will failed to parse the payload
correctly.

Should use different value for those who don't have RX MON component.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 29 ++++++++++++++++++++----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 7e0dc4d0327c..28cadc4167f7 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1948,6 +1948,24 @@ ath12k_dp_mon_fill_rx_rate(struct ath12k *ar,
 	}
 }
 
+static void ath12k_dp_mon_rx_msdus_set_payload(struct ath12k *ar,
+					       struct sk_buff *head_msdu,
+					       struct sk_buff *tail_msdu)
+{
+	u32 rx_pkt_offset, l2_hdr_offset, total_offset;
+
+	rx_pkt_offset = ar->ab->hal.hal_desc_sz;
+	l2_hdr_offset =
+		ath12k_dp_rx_h_l3pad(ar->ab, (struct hal_rx_desc *)tail_msdu->data);
+
+	if (ar->ab->hw_params->rxdma1_enable)
+		total_offset = ATH12K_MON_RX_PKT_OFFSET;
+	else
+		total_offset = rx_pkt_offset + l2_hdr_offset;
+
+	skb_pull(head_msdu, total_offset);
+}
+
 static struct sk_buff *
 ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
 			    struct dp_mon_mpdu *mon_mpdu,
@@ -1956,7 +1974,7 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
 {
 	struct ath12k_base *ab = ar->ab;
 	struct sk_buff *msdu, *mpdu_buf, *prev_buf, *head_frag_list;
-	struct sk_buff *head_msdu;
+	struct sk_buff *head_msdu, *tail_msdu;
 	struct hal_rx_desc *rx_desc;
 	u8 *hdr_desc, *dest, decap_format = mon_mpdu->decap_format;
 	struct ieee80211_hdr_3addr *wh;
@@ -1966,8 +1984,9 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
 
 	mpdu_buf = NULL;
 	head_msdu = mon_mpdu->head;
+	tail_msdu = mon_mpdu->tail;
 
-	if (!head_msdu)
+	if (!head_msdu || !tail_msdu)
 		goto err_merge_fail;
 
 	ath12k_dp_mon_fill_rx_stats_info(ar, ppdu_info, rxs);
@@ -1995,14 +2014,14 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
 	ath12k_dp_mon_fill_rx_rate(ar, ppdu_info, rxs);
 
 	if (decap_format == DP_RX_DECAP_TYPE_RAW) {
-		skb_pull(head_msdu, ATH12K_MON_RX_PKT_OFFSET);
+		ath12k_dp_mon_rx_msdus_set_payload(ar, head_msdu, tail_msdu);
 
 		prev_buf = head_msdu;
 		msdu = head_msdu->next;
 		head_frag_list = NULL;
 
 		while (msdu) {
-			skb_pull(msdu, ATH12K_MON_RX_PKT_OFFSET);
+			ath12k_dp_mon_rx_msdus_set_payload(ar, head_msdu, tail_msdu);
 
 			if (!head_frag_list)
 				head_frag_list = msdu;
@@ -2037,7 +2056,7 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
 		msdu = head_msdu;
 
 		while (msdu) {
-			skb_pull(msdu, ATH12K_MON_RX_PKT_OFFSET);
+			ath12k_dp_mon_rx_msdus_set_payload(ar, head_msdu, tail_msdu);
 			if (qos_pkt) {
 				dest = skb_push(msdu, sizeof(__le16));
 				if (!dest)
-- 
2.34.1


