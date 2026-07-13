Return-Path: <linux-wireless+bounces-38947-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wsfiKS+UVGoOnwMAu9opvQ
	(envelope-from <linux-wireless+bounces-38947-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:30:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E64B748287
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:30:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=KrAKnSjZ;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=gxuhTQcp;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38947-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38947-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 14004300D763
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 07:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BED238F253;
	Mon, 13 Jul 2026 07:30:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95BD38F951
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:30:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927844; cv=none; b=EIxXT5o9zFoiHxBmWTXFOIZnyIC1lsAuD18AJ+t4jtMVdZ+HDkokkmBVDPF+Rhojgs80cm3A6n5+NA5BAYJL1yRpTiHOT7T6i7jg14okNyc7Rx9JdtJk+iYbYqmxjno/aHgGzxE5y2OxdhUYQpPG/MrlULtEsW5wI9Ws9GOUHRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927844; c=relaxed/simple;
	bh=gAuC4zkk7XPgmt0x0ghBLSxFVZuQbI21SeQVlMc6fV0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uo2suQYim0Ro4JA+7knRY9GT4eqU/a40IUfzTTdrurMmvOn5LCcFPyRIFooJ5wwTjZFstz+K9B5U/hZrB20J1tDgbAyI1KAttboUhdpYU66B5wYxBk6L8nUFMdmQhkctVjpo0Kuqx9JmIpGDHbQsAhqzrhWa8PE4KtVJ/nrjrtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KrAKnSjZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gxuhTQcp; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6Nwm9674466
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aifJCenv1UQ5W+pu7DOQPFIw6v/9P9JnLq1j9kinOIE=; b=KrAKnSjZ1i5MYC/r
	1kn6AfSC2hAObTXJUP2PkiiijiqxuN+1D1K9AOsRByXlfaI1mY25DZ3+5/XpHdkY
	D4OXMiRYGaO1V0zrhEqypjU82bSql5T2dCe1QhH2+1TssPtMvcsVGCD8dHx0El6X
	iWVxZBCuBkcvyXDdkaQO2ebpKt7Stp3qN6LcQGiPGSXTE58p2hRgTvO9yyvA9HAw
	6ek5KfM8/wlJ2ddS4SJpkph+eePh4dYEll5fwmQK7xCBvm1gQz1Twu4G0iKbFKYc
	yepE9hUNl8tMK2m2HPU9oa/oJoUrZrlIkHMZ9ua6sAwwmB8MJm12wQkJzt+nzmaM
	pQ5eCg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbecgn0g7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:30:41 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cab3e9cd922so1308794a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 00:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783927841; x=1784532641; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aifJCenv1UQ5W+pu7DOQPFIw6v/9P9JnLq1j9kinOIE=;
        b=gxuhTQcpbyNFi/teJDBvYnNNFR7Ov93PabL9ZHzucyR7ZxeVUV9ozOCG6JPOBU9Jzf
         09VhCBTf2EkNkC9yXTJ5Q+52M0s2EviXocgWaI3GRCtYSCB5pFYk/KwS3a8K4Gzxfdpi
         IJlLlsdsufAjO0qcj0GmaN3WbZnIU8yTIpRgqWE5iPf0TtuLlT6FLCFfHEc+hYRh5i7R
         WpbNIbFhGkIJfqW8ChD4OnEi2+YbEE3Vbih0K5j4p6p28SnnCH5KGkc7LsDfFNs+UxYY
         DzkE8ImvvnSNqQAm5sZ4ufK1XyxBBS6eG9Y/cDPlHpzUIKEGeBxzBFEFs73JrQkTWAAM
         q/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783927841; x=1784532641;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aifJCenv1UQ5W+pu7DOQPFIw6v/9P9JnLq1j9kinOIE=;
        b=n8V7pVGoxv9/BnahsyIFaFZ/S/fUMH34C9KqQ/bUv9PYdQMBLfk4q68qC5ssQnJgmy
         HkHXUdRX0PAuDpdlrPZZe8q+X53ffu0OxY+LANwj2GCSSR15t2kHWvmTSRmPqrEYL3Bp
         BZ0NCdyV2JiQMvrSOMt50GwfStS6zLflTE4lDBTfFRbNK34Kb5XBNX0kLbGKQJ3zf12k
         2O/x0RNDYc635gCdZjMDkTb/ipYbs4ZKChVr2k1nd+a4LzIA3oVo2yOJq/1ITHtxI2sL
         8JvfCLPjDmvUlB3peAxGbckg2jVlzAerNQ5Yq1gd23EvjAeQ1G9pNZUhZyYN5vddNFBG
         TDzA==
X-Gm-Message-State: AOJu0YxFXe0OPMA3M6l7xQUXbQI0pcjeiuZXQOYiObjplwy5zEDvLPH+
	GcaTu2uDaJnkSAYnSzpfrN9z8akEgjzHfxr3xV4e1t1jn7oqo7NzLLK5O/cNvioJhpAMSuHgIJV
	uwjmRZo1NLwm+iX6mNt49fCw7+xwbUinmhqj2NdlnVJwxnLzAyCCYNvevtkvSEVVfAM9USHVSN3
	FXV7/6
X-Gm-Gg: AfdE7ckWZmscX8A6q/vj9VTwZr4gN7Inh/6t74kUxdyZSspQ/KX6UVATTxBlCi3U4VK
	/f80x1NisFPYc4ESTOXdicFV9qXQEUZTW2giN5jaFLi11FIEh1GhaCHW6ELsd0Q8x864rbun02D
	H9/ZnQgLL7ZLzQijHm4vD+kXBVL8M7Q0u2AosXUlywHdmQoFH6K2mDB2TrJDtU/0UK5Wmd1D4PW
	2FG2IB6FmH9XBPTFp1DDgOUszdqhZ+0eyfshGlm4QXUoKKx2vYUBAlbS25vSWUaMacrALq25Zz7
	pMQAnT3ngfycruRYpX+KwPK3nwvtVmCz4937uW5kEcr0rRZ9FJD+WGPJ3ChwvPbtHdhmIRRchoT
	GDqjOH+ULLRrWqEuzlUsEqK+8RtYxTKtQRziEqnGqp+Svx/gjmKTUu0RInjWvuFDs
X-Received: by 2002:a05:6a21:6b18:b0:3b2:a8cd:ef4a with SMTP id adf61e73a8af0-3c110768b5dmr7896016637.30.1783927840536;
        Mon, 13 Jul 2026 00:30:40 -0700 (PDT)
X-Received: by 2002:a05:6a21:6b18:b0:3b2:a8cd:ef4a with SMTP id adf61e73a8af0-3c110768b5dmr7895980637.30.1783927839979;
        Mon, 13 Jul 2026 00:30:39 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b31628c1sm7947252a12.19.2026.07.13.00.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 00:30:38 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:29:56 +0800
Subject: [PATCH ath-current v6 4/8] wifi: ath12k: add support for
 HTT_T2H_MSG_TYPE_MLO_RX_PEER_MAP
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-ath12k-fw-allocated-ml-peer-id-v6-4-20f6f212e413@oss.qualcomm.com>
References: <20260713-ath12k-fw-allocated-ml-peer-id-v6-0-20f6f212e413@oss.qualcomm.com>
In-Reply-To: <20260713-ath12k-fw-allocated-ml-peer-id-v6-0-20f6f212e413@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA3NiBTYWx0ZWRfX6Ll8Ow3iO2Sc
 kaPnSeeSmzj638PVh9iYQ5hoY8SPLoQDn/J/fPd/mF7/FQINVlCu9O/PomaqlIrthrkIB7dWNxj
 ljiNiEX9CCANZk8ANkzaqYL4LCKb8nE=
X-Proofpoint-ORIG-GUID: AM8rSbQh3ASQj8-r0ZhLTyAGhSwArBD1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA3NiBTYWx0ZWRfXxhddByOn36/V
 NC5QPzmIOEfz9pkmW8XRxRJpTIdzPSgqkvkETdrMTAoSq8uzV9meEUQSPh++Bn1attz6HhsdVHM
 4RXhlPZUNIl8o6qDWJjGBcawm548Rz2tq34RMqLijtdjp6653/2K0HimABlgAl1dk5dvIVktb9G
 PJ9ZeClkgc+YEFGz07j+nBWp+4zinIG45PLgk3RqTCq8Ce8BQg45Rt49Nc6wjba4o4yz1h/tf9Z
 ZiFcEOD3WXxIUhSXdMhDdX2t1HcS5WU20uz3yzZmWdNUUWVQYc10c6s+9vX66PaFxH9RFXtMIbZ
 EH694y60fNWwr9u91xkBYndkp6GXLBMJ6lmQHgYTBzzC8WjEhkR5T/JgsbyR6B3BBv2OIoIbqli
 UoyeeTJcfOgCbDWR2W5DRcrnRgSDumpKVtP0nqlupiBttY7eb5KdaJ7TIylSBw8P8XmHiU7b2xI
 p1EkDU+lIw00e5i9SHQ==
X-Proofpoint-GUID: AM8rSbQh3ASQj8-r0ZhLTyAGhSwArBD1
X-Authority-Analysis: v=2.4 cv=KM9qylFo c=1 sm=1 tr=0 ts=6a549421 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=Z1Ge9yWUdzOQbrqXt3cA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130076
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38947-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:baochen.qiang@oss.qualcomm.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E64B748287

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


