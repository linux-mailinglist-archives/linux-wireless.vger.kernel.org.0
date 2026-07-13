Return-Path: <linux-wireless+bounces-38957-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6zyJFieVVGpknwMAu9opvQ
	(envelope-from <linux-wireless+bounces-38957-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:35:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8546748344
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:35:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=pf0kL74i;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="fJPsS/++";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38957-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38957-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9686B30325DC
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 07:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A89239023A;
	Mon, 13 Jul 2026 07:33:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2191E38E8C7
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:33:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783928031; cv=none; b=S1DZQB0Ip73aWzv2RMgPzBRnY2SG2pb3mIureHXyS4PI7LdpCxrd3x3Bg2bAAcpc8H4aWo4XkWXe+OEZB1haKeMvEaJTtM3EK3fdozwXQCUFUKL2EFm7ilCJS1mxO6jgG1nVL8moYQ6SexxT3DT3G5abTI4f34HLbDNChzW7u3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783928031; c=relaxed/simple;
	bh=gAuC4zkk7XPgmt0x0ghBLSxFVZuQbI21SeQVlMc6fV0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PHqwLfk4NRIgr7kQMd2YHp5SlXwIfMY/0qB+1dvoAwrNI24baFaCFcH6yaVIEU1KhbbKCc42VInVRTS+LM24HKhZy6Z9IlafPsHa6NkRzU/iR3DhM0KtffGBrA5CufwSgx5rfvIiicBghRKJ63NVzrmmALt4/Ys6w8bHACPKaxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pf0kL74i; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fJPsS/++; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6NtIg507388
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aifJCenv1UQ5W+pu7DOQPFIw6v/9P9JnLq1j9kinOIE=; b=pf0kL74izOnTHn/+
	rGK7a1gJHwkjWGNHHcupWD25qECo2p2ma7bkecAEc87NGhdSTy9HflE84Q9sq6G2
	ETYsFWzznxAdYUagncLjRDylg7Zvy3Me89SKWaSsfo7X1ZfSmmg3gjg7J+/LVpr8
	JmgMRePxqQI1g1Op02zNJJ4Rob6M6KkBvPxfvymZMweHm31z+otkw0kFbLeEuEOi
	rHSTPBZ8myIg6fLOB8QkcmS8aNKrc5qK6zxnLs9pxhR1rvF85fcJ5KnTdrhUrNYQ
	w9H3/m043g5aQjnUnvZOBfGeM53CsM2s3LHVtLIMlbT/dkW2FVyTfoX8SfvVs224
	DNRnfQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fctc8gd0s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:33:49 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc6dd43737so61127555ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 00:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783928028; x=1784532828; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aifJCenv1UQ5W+pu7DOQPFIw6v/9P9JnLq1j9kinOIE=;
        b=fJPsS/++zeDcLJV2CORrv285qwGAxnICcEjeLY/hYTvEOOZNSXkXnpCw0fMjdUG8Ua
         EVX1riB5ALwWxYJHn6RsMRaVX/qyCb4zDZLkWKiQfm57toPbBJhTot5FfGL/uKTZ5jf/
         IXRfMNzZp3osAsRzihRA1Jnn0s7CNZ+NEMOp44TTdswyB9dmtna4KtXc7n4R/MNdx+qe
         psAdHBzW9x3PgNkiX/DzxYWuYLrxQX/1t/8fdfHzZoWuoKkRoPK24xBhY9lfaeMpoYKc
         AWYm+vpwuoCGDnTXRFz6TLTmfaSYolr2bAkfVNlZdDOJGjYkYmXPvIHIyPEOjhneiF1K
         lE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783928028; x=1784532828;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aifJCenv1UQ5W+pu7DOQPFIw6v/9P9JnLq1j9kinOIE=;
        b=i4Q5rdQ4O0w7COWk5K2incBA2qe1DFACirPRbuMilgwcNxJMrrogoHnY6XeDEQQ/W0
         0y9KQtJZp8wFkIe4UxQq1MDsEZEyAVuhB8604pf4nzZWRpv+ZRb/0keH6iZoH8v0j0Gz
         wkns6gFqQgKqQofDVd5UqtZX3r4MuvIEc5yXVp8IVr2yqrWrc+mkghWqpjP5wYOomds8
         kfsunDNpJgy3D6wHPSKHtKtAhGdLgnexkw45TqtJmA1b7Ya34r31tAcHfI8FcL3FB8MH
         piNoKIDVIubLGJB5P0M6q8mBpjSLkUFv9VS1+YU4M0QycVTZJWjHfos2pOQGNyx1yXXS
         +4EQ==
X-Gm-Message-State: AOJu0Yz52/qNUZf23Ca1h1POZJiCRVjobAajii9qQjk+6cjS4SUIXG+B
	zrPdDC8Nx4TvK4uNgVIaxNurDb8fu/iT2e43uOpvi0vGTycHhglVPW+T0QsailWy9pY7Iq9Xd8W
	Vb4U7SMxc7iayliYh28ssGrVrht8vuTkDpRyb7upqWYj9d82+vF82GaLiL5uRe51ZWeHCiz8iLl
	SEuME/
X-Gm-Gg: AfdE7clYTVT8L4H/Bs9lMwKfpwp5fd/Gf7QVKhNgzCQaSImr/H5F2cof/mh+TLq7xFQ
	WozM4lkDmE+IhA1nqtP8m2UDnB3eDEfNaE02MLtCYsRN9FPpoO4Xs52gv05fPdTnsGEaGkGMW7L
	tsyecZaA0b8/1q+eblkPKEXrrK1lf+LebIHpzu7x8Xy+shqsp8OYaYuEi3RHvEzdTeB97l3uX5/
	kWd8SDw9O4yFTy4rA/vvX9P5DWi3iw2DMOgWwuaYCQaImKraefDAAwB1clruKOH/hXZP9M0Sc+7
	LG4f0djAMWlYGpj6dwo0M+dgvQccFMrfI3N56xuOTySR3H2ejh48GFCoYHOpfrqXiTLf5wy0yQm
	zVcH0A6SXNpgQsA3CTtNEVu1nstpU/VZiq01kHYeampK8W+p1TW1MnuyHewvoHKJ1
X-Received: by 2002:a17:902:e850:b0:2cc:f1e7:18c6 with SMTP id d9443c01a7336-2ce9e795628mr75156945ad.2.1783928028412;
        Mon, 13 Jul 2026 00:33:48 -0700 (PDT)
X-Received: by 2002:a17:902:e850:b0:2cc:f1e7:18c6 with SMTP id d9443c01a7336-2ce9e795628mr75156775ad.2.1783928027988;
        Mon, 13 Jul 2026 00:33:47 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb72fsm95073615ad.6.2026.07.13.00.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 00:33:47 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:33:19 +0800
Subject: [PATCH ath-current 4/8] wifi: ath12k: add support for
 HTT_T2H_MSG_TYPE_MLO_RX_PEER_MAP
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-ath12k-fw-allocated-ml-peer-id-v1-4-d0a2a1a519eb@oss.qualcomm.com>
References: <20260713-ath12k-fw-allocated-ml-peer-id-v1-0-d0a2a1a519eb@oss.qualcomm.com>
In-Reply-To: <20260713-ath12k-fw-allocated-ml-peer-id-v1-0-d0a2a1a519eb@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: D8zc4ZYCHsu8sfWvsqBC7mJA5vX8cqlY
X-Proofpoint-ORIG-GUID: D8zc4ZYCHsu8sfWvsqBC7mJA5vX8cqlY
X-Authority-Analysis: v=2.4 cv=UtRT8ewB c=1 sm=1 tr=0 ts=6a5494dd cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=Z1Ge9yWUdzOQbrqXt3cA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA3NyBTYWx0ZWRfX2yIFWu/Ou50b
 Cb7uYAIwSm1ouyssSvaWZDxb3benar23eGckj9hGvk0PFdIPrHSRc9oMzRM8W79D8Z7lvRpgFhU
 bYOnG0bKS2+C7ynEKcMrQ7MI1arMAok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA3NyBTYWx0ZWRfXwnWRgVxitwtN
 Lg2syzP9vIadJeaD+k20XtpzcqMe2Eli9dknVNlnERPBk1gCRgJeZLEd1TCQT26Q07lMAes6UHo
 R6oBuu2RscCaIdInU5O4P1zQE0Rhn6hiegact/0ZkjcY5QSOHP5UvhMu5o2PAeHMDVXT2Ofd2+7
 vxGaj9dwz7LxwS+KIg1YJAKsBP0AeYNlBf4MtgmT1GPAgm5NmZu65Ra/aRJncGeJ0Rq5zkJi+E8
 lxpEtBy1Zu3EnibHvGD5m9tAtLPezL9j/6muaDPAvk2V2DQn9jauq+6f//9bH36tfn3Mvi1I63w
 IxkPfAuRULofpxw4KikMsnzNJ42kW9X09TqLLDvU27dVIbM4xsO9waEfipcPioPZ1EQpZTZVT30
 abmLKDj70qcXgOdgszmk1e7RhxfgDpBR3pFmdAg6RpwKr2KI04exxgm0TN/Jm/t8XLg6v97OdCF
 dsdGIum8ZKxGSL1UoCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130077
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38957-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:baochen.qiang@oss.qualcomm.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E8546748344

Firmware on chips that allocate the MLD peer ID itself (WCN7850 and
QCC2072) reports the assignment back to the host through
HTT_T2H_MSG_TYPE_MLO_RX_PEER_MAP. The message carries the chosen
MLD peer id, the MLD MAC address etc.

Add the message type, the on-the-wire struct, the field masks and a
handler that parses them out. The host-side state update (publishing the
dp peer into ath12k_dp_hw::dp_peers[], propagating the ID to
ath12k_dp_link_peer::ml_id and ath12k_sta::ml_peer_id) is added in a
follow-up patch;

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_htt.c | 30 ++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/dp_htt.h | 12 ++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp_htt.c b/drivers/net/wireless/ath/ath12k/dp_htt.c
index 52e10059c6d5..150b190f9c7f 100644
--- a/drivers/net/wireless/ath/ath12k/dp_htt.c
+++ b/drivers/net/wireless/ath/ath12k/dp_htt.c
@@ -575,6 +575,33 @@ static void ath12k_htt_mlo_offset_event_handler(struct ath12k_base *ab,
 	rcu_read_unlock();
 }
 
+static void ath12k_dp_htt_mlo_peer_map_handler(struct ath12k_base *ab,
+					       struct sk_buff *skb)
+{
+	struct htt_resp_msg *resp = (struct htt_resp_msg *)skb->data;
+	struct htt_t2h_mlo_peer_map_event *ev = &resp->mlo_peer_map_ev;
+	u16 raw_peer_id, peer_id, addr_h16;
+	u8 peer_addr[ETH_ALEN];
+
+	if (skb->len < sizeof(*ev)) {
+		ath12k_warn(ab, "unexpected htt mlo peer map event len %u\n",
+			    skb->len);
+		return;
+	}
+
+	raw_peer_id = le32_get_bits(ev->info0,
+				    HTT_T2H_MLO_PEER_MAP_INFO0_MLO_PEER_ID);
+	peer_id = raw_peer_id | ATH12K_PEER_ML_ID_VALID;
+
+	addr_h16 = le32_get_bits(ev->info1,
+				 HTT_T2H_MLO_PEER_MAP_INFO1_MAC_ADDR_H16);
+	ath12k_dp_get_mac_addr(le32_to_cpu(ev->mac_addr_l32), addr_h16,
+			       peer_addr);
+
+	ath12k_dbg(ab, ATH12K_DBG_DP_HTT, "htt mlo peer map peer %pM id %u\n",
+		   peer_addr, peer_id);
+}
+
 void ath12k_dp_htt_htc_t2h_msg_handler(struct ath12k_base *ab,
 				       struct sk_buff *skb)
 {
@@ -659,6 +686,9 @@ void ath12k_dp_htt_htc_t2h_msg_handler(struct ath12k_base *ab,
 	case HTT_T2H_MSG_TYPE_MLO_TIMESTAMP_OFFSET_IND:
 		ath12k_htt_mlo_offset_event_handler(ab, skb);
 		break;
+	case HTT_T2H_MSG_TYPE_MLO_RX_PEER_MAP:
+		ath12k_dp_htt_mlo_peer_map_handler(ab, skb);
+		break;
 	default:
 		ath12k_dbg(ab, ATH12K_DBG_DP_HTT, "dp_htt event %d not handled\n",
 			   type);
diff --git a/drivers/net/wireless/ath/ath12k/dp_htt.h b/drivers/net/wireless/ath/ath12k/dp_htt.h
index 987689f11cda..2db7fb27c036 100644
--- a/drivers/net/wireless/ath/ath12k/dp_htt.h
+++ b/drivers/net/wireless/ath/ath12k/dp_htt.h
@@ -930,6 +930,7 @@ enum htt_t2h_msg_type {
 	HTT_T2H_MSG_TYPE_EXT_STATS_CONF = 0x1c,
 	HTT_T2H_MSG_TYPE_BKPRESSURE_EVENT_IND = 0x24,
 	HTT_T2H_MSG_TYPE_MLO_TIMESTAMP_OFFSET_IND = 0x28,
+	HTT_T2H_MSG_TYPE_MLO_RX_PEER_MAP = 0x29,
 	HTT_T2H_MSG_TYPE_PEER_MAP3	= 0x2b,
 	HTT_T2H_MSG_TYPE_VDEV_TXRX_STATS_PERIODIC_IND = 0x2c,
 };
@@ -974,11 +975,22 @@ struct htt_t2h_peer_unmap_event {
 	__le32 info1;
 } __packed;
 
+#define HTT_T2H_MLO_PEER_MAP_INFO0_MLO_PEER_ID		GENMASK(23, 8)
+#define HTT_T2H_MLO_PEER_MAP_INFO1_MAC_ADDR_H16		GENMASK(15, 0)
+
+struct htt_t2h_mlo_peer_map_event {
+	__le32 info0;
+	__le32 mac_addr_l32;
+	__le32 info1;
+	__le32 reserved[5];
+} __packed;
+
 struct htt_resp_msg {
 	union {
 		struct htt_t2h_version_conf_msg version_msg;
 		struct htt_t2h_peer_map_event peer_map_ev;
 		struct htt_t2h_peer_unmap_event peer_unmap_ev;
+		struct htt_t2h_mlo_peer_map_event mlo_peer_map_ev;
 	};
 } __packed;
 

-- 
2.25.1


