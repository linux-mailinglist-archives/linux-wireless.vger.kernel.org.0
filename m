Return-Path: <linux-wireless+bounces-34966-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLLnHquz42kQKAEAu9opvQ
	(envelope-from <linux-wireless+bounces-34966-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Apr 2026 18:39:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD875421A48
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Apr 2026 18:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00B24300A106
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Apr 2026 16:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43B72F3C0E;
	Sat, 18 Apr 2026 16:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c1IpWUlY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705742FB965
	for <linux-wireless@vger.kernel.org>; Sat, 18 Apr 2026 16:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776530191; cv=none; b=X682N1fUqV//aiNDLoP6I7QHLfpqwSgZaVplk7vEXwaChS7Ky34XvYIZDbG4fH6aRJz7HyGtNBFRxr38jurL0ZIluCIedUABhTGgK8A864NWVcT92J2XKVr0dFc3sS5OeDG5SbyDS/5HbnxQHnjopeI0h2/WYuubykU/MZo1hBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776530191; c=relaxed/simple;
	bh=sMdcAMP7bJMx87KsDulDK1WKyR98msyuqrP3fSyPDWU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=skPaeXTkFmqNgI6Fw9+Sh4NZTp6qDUyxSpxPFtgsCdVWsueevka/sT24jkrnqpAKt/Q/H1YvuqvsRNJW9WaItIYkywpr0tQSEnuPL6+oApPrBG+JSYmHLyDh5bbMxBpgIlfN1fCcEt2tL35NNgvAjpEnvHH2+o3xEu2YctKN3WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c1IpWUlY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63I4dsNO326469;
	Sat, 18 Apr 2026 16:36:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=EIov3vZowt5bVNydawHb/4jPVvuIa5Cbwf/
	oc3CDOVc=; b=c1IpWUlYluUFK8az0OUgg/s+H39Gmbg2rpN9ojxD8C8LY2sJ93h
	tGszmm/Zm2Q1gb3VusDo6Uif7t77op+OfunYayOgbIvsPKkkZ3NMOF+HVzO28aXI
	pYgML8yIHzfy6AbIR5hZ5e0/3+Ka2WwbFqVFn47BaawnoLKpBgbBxTlywV0iLrk3
	LblJpeBqwRpvJ7p0krzwPW1+Z+ufQ7dFis2XOBbyalYc545CrdtlVdMafClst4Ie
	J3EXNgIIaa9vY+DroRi/YhSraHchO8ambt7hXyTsKc16uR2gMf92+or0nwfwVXpZ
	QfIZ1oZdBriTK1dsyMjYptnWngfE6GCrbuA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm34h92hd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 Apr 2026 16:36:26 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 63IGaNJt026278;
	Sat, 18 Apr 2026 16:36:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4dm31hdc8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 Apr 2026 16:36:23 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 63IGaN0b026273;
	Sat, 18 Apr 2026 16:36:23 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-tamizhr-blr.qualcomm.com [10.190.110.180])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 63IGaM8k026272
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 Apr 2026 16:36:23 +0000 (GMT)
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 380741)
	id 21B28418EB; Sat, 18 Apr 2026 22:06:22 +0530 (+0530)
From: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: Handle DP_RX_DECAP_TYPE_8023 type in Rx path
Date: Sat, 18 Apr 2026 22:06:20 +0530
Message-Id: <20260418163620.3633959-1-tamizh.raja@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=J46aKgnS c=1 sm=1 tr=0 ts=69e3b30b cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=Cu7rrvbFi3rOH6yX9OAA:9
X-Proofpoint-GUID: hHWe2p7e_m6k-6NKay-q4eDJV-LbM3Bu
X-Proofpoint-ORIG-GUID: hHWe2p7e_m6k-6NKay-q4eDJV-LbM3Bu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDE2NSBTYWx0ZWRfX+1/kNBjwgXuZ
 ABoho4dK5UgRSY90F0ZaxbusxhUaaQrSZxysM3+TTHP8xU4hxJ/7tbAttcUL/Q2bc8pFiOLczhc
 ADXWjhcPnpc2wXOhLjk0Cj/Oxry20UzWOukw+cjTEXBrPoWeqmWJB2J4cw7P2C60cw3rt33hAyt
 vZkIGrnFQiR9PrncVAKCHPzSWpsXp+NwWyP7t4eHpN/rJVsOWWYpDYHXhivrcbb3jRNp0C5cZ5L
 cRAPcuuIB2qZs8cVr+zUBNSbVEEPSqA3qIzHl6efZuRYGfk/ysQKqPnWwIxYnh3+JJfQGhvyXlq
 MsMONs/7L24GzO/f5v5yWRWfJcvx63/2iB6JVIh9OwReK/iyoyHVAUGK6i3NAUR+7+RkG5AiFoz
 nVJdk7CBtMvs3blemlCvUNiU+JFRxLMXJowZLZMOkA6WcB2s8cuae1s73GyerK38WozuNwXcHvB
 QIUx29vRYseeQkzdsQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_05,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 clxscore=1011 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604180165
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34966-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamizh.raja@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: CD875421A48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The driver does not currently set any rx_flag for frames received with
decap type DP_RX_DECAP_TYPE_8023. When the hardware reports
LLC-encapsulated packets whose length field is below 0x0600, the MSDU_END
descriptor may indicate decap type DP_RX_DECAP_TYPE_8023.

These frames are effectively equivalent to Ethernet-II (DIX) packets,
similar to those decoded as DP_RX_DECAP_TYPE_ETHERNET2_DIX. If the
driver does not set RX_FLAG_8023 for these frames, mac80211 will
misinterpret them as 802.11 frames. This causes valid frames such as
Bridge Protocol Data Units (BPDUs) to be dropped. BPDUs are exchanged
between switches to maintain and manage network topology, and must
be treated as Ethernet frames.

Set RX_FLAG_8023 for decap type DP_RX_DECAP_TYPE_8023 in
ath12k_dp_rx_h_undecap() to ensure mac80211 handles these frames
correctly. Also add multicast packet handling support for the
DP_RX_DECAP_TYPE_8023 decap type.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1

Signed-off-by: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 57 ++++++++++++++++---------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 250459facff3..cae00e0539df 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1092,7 +1092,8 @@ static void ath12k_get_dot11_hdr_from_rx_desc(struct ath12k_pdev_dp *dp_pdev,
 static void ath12k_dp_rx_h_undecap_eth(struct ath12k_pdev_dp *dp_pdev,
 				       struct sk_buff *msdu,
 				       enum hal_encrypt_type enctype,
-				       struct hal_rx_desc_data *rx_info)
+				       struct hal_rx_desc_data *rx_info,
+				       enum ath12k_dp_rx_decap_type decap_type)
 {
 	struct ieee80211_hdr *hdr;
 	struct ethhdr *eth;
@@ -1100,12 +1101,24 @@ static void ath12k_dp_rx_h_undecap_eth(struct ath12k_pdev_dp *dp_pdev,
 	u8 sa[ETH_ALEN];
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
 	struct ath12k_dp_rx_rfc1042_hdr rfc = {0xaa, 0xaa, 0x03, {0x00, 0x00, 0x00}};
+	struct ath12k_dp_rx_rfc1042_hdr *llc;
 
 	eth = (struct ethhdr *)msdu->data;
 	ether_addr_copy(da, eth->h_dest);
 	ether_addr_copy(sa, eth->h_source);
-	rfc.snap_type = eth->h_proto;
-	skb_pull(msdu, sizeof(*eth));
+	if (decap_type == DP_RX_DECAP_TYPE_8023) {
+		/*
+		 * For 802.3 frames, eth->h_proto carries a length field, not
+		 * an EtherType. The actual EtherType is in the LLC/SNAP header
+		 * that follows the Ethernet header.
+		 */
+		llc = (struct ath12k_dp_rx_rfc1042_hdr *)(msdu->data + sizeof(*eth));
+		rfc.snap_type = llc->snap_type;
+		skb_pull(msdu, sizeof(*eth) + sizeof(*llc));
+	} else {
+		rfc.snap_type = eth->h_proto;
+		skb_pull(msdu, sizeof(*eth));
+	}
 	memcpy(skb_push(msdu, sizeof(rfc)), &rfc,
 	       sizeof(rfc));
 	ath12k_get_dot11_hdr_from_rx_desc(dp_pdev, msdu, rxcb, enctype, rx_info);
@@ -1123,9 +1136,10 @@ void ath12k_dp_rx_h_undecap(struct ath12k_pdev_dp *dp_pdev, struct sk_buff *msdu
 			    bool decrypted,
 			    struct hal_rx_desc_data *rx_info)
 {
+	enum ath12k_dp_rx_decap_type decap_type = rx_info->decap_type;
 	struct ethhdr *ehdr;
 
-	switch (rx_info->decap_type) {
+	switch (decap_type) {
 	case DP_RX_DECAP_TYPE_NATIVE_WIFI:
 		ath12k_dp_rx_h_undecap_nwifi(dp_pdev, msdu, enctype, rx_info);
 		break;
@@ -1139,19 +1153,33 @@ void ath12k_dp_rx_h_undecap(struct ath12k_pdev_dp *dp_pdev, struct sk_buff *msdu
 		/* mac80211 allows fast path only for authorized STA */
 		if (ehdr->h_proto == cpu_to_be16(ETH_P_PAE)) {
 			ATH12K_SKB_RXCB(msdu)->is_eapol = true;
-			ath12k_dp_rx_h_undecap_eth(dp_pdev, msdu, enctype, rx_info);
+			ath12k_dp_rx_h_undecap_eth(dp_pdev, msdu, enctype, rx_info,
+						   decap_type);
 			break;
 		}
 
 		/* PN for mcast packets will be validated in mac80211;
 		 * remove eth header and add 802.11 header.
 		 */
-		if (ATH12K_SKB_RXCB(msdu)->is_mcbc && decrypted)
-			ath12k_dp_rx_h_undecap_eth(dp_pdev, msdu, enctype, rx_info);
+		if (ATH12K_SKB_RXCB(msdu)->is_mcbc && decrypted) {
+			ath12k_dp_rx_h_undecap_eth(dp_pdev, msdu, enctype, rx_info,
+						   decap_type);
+			break;
+		}
+
+		rx_info->rx_status->flag |= RX_FLAG_8023;
 		break;
 	case DP_RX_DECAP_TYPE_8023:
-		/* TODO: Handle undecap for these formats */
-		break;
+		/*
+		 * Note that ethernet decap format indicates that the decapped
+		 * packet is either Ethernet 2 (DIX)  or 802.3 (uses SNAP/LLC).
+		 */
+		if (ATH12K_SKB_RXCB(msdu)->is_mcbc && decrypted) {
+			ath12k_dp_rx_h_undecap_eth(dp_pdev, msdu, enctype, rx_info,
+						   decap_type);
+			break;
+		}
+		rx_info->rx_status->flag |= RX_FLAG_8023;
 	}
 }
 EXPORT_SYMBOL(ath12k_dp_rx_h_undecap);
@@ -1333,9 +1361,7 @@ void ath12k_dp_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev, struct napi_struc
 	struct ath12k_dp_peer *peer;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
 	struct ieee80211_rx_status *status = rx_info->rx_status;
-	u8 decap = rx_info->decap_type;
 	bool is_mcbc = rxcb->is_mcbc;
-	bool is_eapol = rxcb->is_eapol;
 
 	peer = ath12k_dp_peer_find_by_peerid(dp_pdev, rx_info->peer_id);
 
@@ -1380,15 +1406,6 @@ void ath12k_dp_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev, struct napi_struc
 
 	/* TODO: trace rx packet */
 
-	/* PN for multicast packets are not validate in HW,
-	 * so skip 802.3 rx path
-	 * Also, fast_rx expects the STA to be authorized, hence
-	 * eapol packets are sent in slow path.
-	 */
-	if (decap == DP_RX_DECAP_TYPE_ETHERNET2_DIX && !is_eapol &&
-	    !(is_mcbc && rx_status->flag & RX_FLAG_DECRYPTED))
-		rx_status->flag |= RX_FLAG_8023;
-
 	ieee80211_rx_napi(ath12k_pdev_dp_to_hw(dp_pdev), pubsta, msdu, napi);
 }
 EXPORT_SYMBOL(ath12k_dp_rx_deliver_msdu);

base-commit: 9a4f673eb08d2a7713b258d671b4a45f2a6e68b7
-- 
2.34.1


