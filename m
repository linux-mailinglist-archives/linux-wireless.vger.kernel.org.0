Return-Path: <linux-wireless+bounces-38478-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EkWtDW1bRWqc+woAu9opvQ
	(envelope-from <linux-wireless+bounces-38478-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 20:24:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8729D6F091C
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 20:24:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="DZD/jmby";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38478-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38478-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 494AB301DBB4
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jul 2026 18:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB39A270545;
	Wed,  1 Jul 2026 18:24:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5724B8DE8
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jul 2026 18:24:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782930282; cv=none; b=PWIXOhmYOC/TdKnuuvtgQ6AlBY903tm5kaEj0AvnfRzv5xOrzri0eVioadH1jb+V/jU5I0WB+/yi7JSsHBy+16m5HqeO3rV1DuLskh0O6zw/7kWxrpeX605BrdvGfkzTkeB3uxKvvPFUzmb6HXRs5/ee4fGfbc2J+bp8Q66Kzds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782930282; c=relaxed/simple;
	bh=LFJTmmCDkKOQGd2Yd1AXgPLYsGg5+vfkhtVlNQpP6vU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H8a8CAZ4EdjWGaMYbeLZIxBk4gXfNglF9GP3xnHxZQj1KRY55zkyGBsW28vzA7xBtCiyNMM0Hlg4FurViT6ElILNhWOWfrw0ZYbXtgWvkyj93srfqK9udzWkMgbaVltIVVEiX8KfxhliKeaYHqrEhl9ViLEIzEP2txvIYHZy1IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DZD/jmby; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661Gmjsr1590015;
	Wed, 1 Jul 2026 18:24:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=an6l+UBY9zYHhOzobJ04B17pbxItZKYTRAF
	RIOIYwJM=; b=DZD/jmby3kEenkyXxQ4h4u8EyDrMTcvWPSQ7XMUjKiRdpV1TeUv
	kEl9nOMILAPjmrxsx35GV4Drqy7088DtBKqMB0Co8kQew7lRpPu91ro5Uo6fc13g
	zbzNCqxo+2Ji6bmqvLTH/ybDeTKD7lw6hvXZ9FGn6ZxrgmQuohPaNT/gEFt7fpLs
	FIm8BBrCDMWDH4QawrMO2xcPMBQLrZ1nwl61w1iq0qdvTpkzDhO94QMu66p6dugt
	VRJtlrCFXfMpPoJev7yxObIixyAFbsZzVv5yq+WMK9F9XFOEP30Se8I+4ohdc0m1
	PbD0wifgnW1gjgLe7eUQrXRkLFvZ06nlOZA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f53q098wr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 18:24:38 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 661IOYHM006989;
	Wed, 1 Jul 2026 18:24:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4f27kk5p7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 18:24:34 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 661IOXpT006975;
	Wed, 1 Jul 2026 18:24:33 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-tamizhr-blr.qualcomm.com [10.190.110.180])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 661IOXx6006973
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 18:24:33 +0000 (GMT)
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 380741)
	id 168E9418D5; Wed,  1 Jul 2026 23:54:33 +0530 (+0530)
From: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
Subject: [PATCH ath-next v2] wifi: ath12k: Set IEEE80211_OFFLOAD_ENCAP_4ADDR after tx_encap_type vdev param
Date: Wed,  1 Jul 2026 23:54:28 +0530
Message-Id: <20260701182428.906441-1-tamizh.raja@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=dtnrzVg4 c=1 sm=1 tr=0 ts=6a455b66 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=jat_AlTXxbiFn7Gwr7IA:9
X-Proofpoint-ORIG-GUID: K6By3zqch5ixyY4pi0yC-iAunWLuO2oG
X-Proofpoint-GUID: K6By3zqch5ixyY4pi0yC-iAunWLuO2oG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE5NyBTYWx0ZWRfX1Rbr1vt30dxk
 hMbaxIZAR+k7SPu9AIalbi3ltpr4qs+L7TmRgKzIRo9Gt/zkupHOM3X0qyntuHv5rcKDgBAiXua
 xPDeMs99Xaw9009wfc2pTxQu0CIhTwjC4bXIZA1Ox+8epaOmfF5QqIt8fE2X/oLmM6V1TnmaQRp
 uakbY5fEtV2O1DpQjdJYgpk7JTnmUCeXPdflXIaI7YkabO7hrEYMMSiOQGyb7dufY2ilzcGVb0r
 aCpj6VdONK39nHyIDGqfvUd9ezqoMdArqox5eMoTEREUd5iGynBzfs1pnEhpyFeHA/X/EX+gS7o
 6yQVJnMaM+gFoU4UJghKoXGcjd5wRhoffNcL5fb6beI6tGh2OcsoGPYZStu4tFdl+E5GF452J4S
 3HzgCcRRluP85/mheCOCsah3fjmcidpSlugAyIsk3oz68Eqn/fPzWABeGdX32YP2H9fjxvFm98R
 tsA0PO4tkM38Yi+zgEw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE5NyBTYWx0ZWRfXyXpPGt0L17C5
 y14AdvlH5UJzK5BQj8kCBJqUPP4Bg5iLH90z6fWJDW+E3bxc0wmFM9ah2evrrnA1+3nXpYKOQOx
 o+rSWv0/ttGwDnPpnanqXuz5ORjtuEI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010197
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38478-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:tamizh.raja@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[tamizh.raja@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamizh.raja@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8729D6F091C

Currently, IEEE80211_OFFLOAD_ENCAP_4ADDR is set when
IEEE80211_OFFLOAD_ENCAP_ENABLED is present in vif->offload_flags
at the beginning of ath12k_mac_update_vif_offload().

However, if the WMI vdev set_param for tx_encap_type fails,
IEEE80211_OFFLOAD_ENCAP_ENABLED is cleared but
IEEE80211_OFFLOAD_ENCAP_4ADDR remains set, leaving the flags in
an inconsistent state.

Fix this by setting IEEE80211_OFFLOAD_ENCAP_4ADDR only after the
tx_encap_type has been configured via the WMI vdev set parameter.

Compile tested only.

Fixes: 729cad3c3c9e ("wifi: ath12k: Add 4-address mode support for eth offload")

Signed-off-by: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
---
v2:
  * Rebased of top ToT

 drivers/net/wireless/ath/ath12k/mac.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 16339469c24c..edd5b8c3df34 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -10118,16 +10118,15 @@ static void ath12k_mac_update_vif_offload(struct ath12k_link_vif *arvif)
 	    vif->type != NL80211_IFTYPE_AP)
 		vif->offload_flags &= ~(IEEE80211_OFFLOAD_ENCAP_ENABLED |
 					IEEE80211_OFFLOAD_DECAP_ENABLED |
-					IEEE80211_OFFLOAD_ENCAP_MCAST);
+					IEEE80211_OFFLOAD_ENCAP_MCAST |
+					IEEE80211_OFFLOAD_ENCAP_4ADDR);
 
-	if (vif->offload_flags & IEEE80211_OFFLOAD_ENCAP_ENABLED) {
+	if (vif->offload_flags & IEEE80211_OFFLOAD_ENCAP_ENABLED)
 		ahvif->dp_vif.tx_encap_type = ATH12K_HW_TXRX_ETHERNET;
-		vif->offload_flags |= IEEE80211_OFFLOAD_ENCAP_4ADDR;
-	} else if (test_bit(ATH12K_FLAG_RAW_MODE, &ab->dev_flags)) {
+	else if (test_bit(ATH12K_FLAG_RAW_MODE, &ab->dev_flags))
 		ahvif->dp_vif.tx_encap_type = ATH12K_HW_TXRX_RAW;
-	} else {
+	else
 		ahvif->dp_vif.tx_encap_type = ATH12K_HW_TXRX_NATIVE_WIFI;
-	}
 
 	ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
 					    param_id, ahvif->dp_vif.tx_encap_type);
@@ -10138,7 +10137,8 @@ static void ath12k_mac_update_vif_offload(struct ath12k_link_vif *arvif)
 	}
 
 	if (vif->offload_flags & IEEE80211_OFFLOAD_ENCAP_ENABLED)
-		vif->offload_flags |= IEEE80211_OFFLOAD_ENCAP_MCAST;
+		vif->offload_flags |= (IEEE80211_OFFLOAD_ENCAP_MCAST |
+				       IEEE80211_OFFLOAD_ENCAP_4ADDR);
 
 	param_id = WMI_VDEV_PARAM_RX_DECAP_TYPE;
 	if (vif->offload_flags & IEEE80211_OFFLOAD_DECAP_ENABLED)

base-commit: 913998f903fb1432c0046c33003db38a9e8bedb1
-- 
2.34.1


