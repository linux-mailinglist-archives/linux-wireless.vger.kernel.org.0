Return-Path: <linux-wireless+bounces-38949-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Fh6dM/qUVGpbnwMAu9opvQ
	(envelope-from <linux-wireless+bounces-38949-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:34:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C71A574831C
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:34:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=GRYYkVu2;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=XRl18Gbp;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38949-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38949-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 711993018A97
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 07:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1492938E133;
	Mon, 13 Jul 2026 07:30:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1D13563E1
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:30:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927851; cv=none; b=B+5AxJ8A+2+qIGEvlkAfFEqiFtXjka+FBv1qmmjdm0hW3H/lztu4MF0fDRiOD5/enGu45tUEflHU9FALJ2aL1Czt4g3Psp+AQav+Xkcsr5DKc/GPbNqoCZvIEUjXNXOJLFzASv+aBmnMaqrGdUaVXJKX6D9BEpyNGxbqoZNzcJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927851; c=relaxed/simple;
	bh=DMe7ZO6cU/e71VJeTmd/KsjgeZDDt5YTr7cUZWxwp8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fh9WTqVY4JNPYuuvY8DHs5/gOTLSS5hQJCZM6IBSBNmAubUrMtUdHJEqZW/JQh6nX8agxd0poWGJFzl1ZIBMKAIXiFQul/roTcyTiG3Q+BZye1O8kch/9RGF6YDBgw284cCxz3fHUtUwpP07PJAJwqctDqTqnHQglaO2ElFJlhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GRYYkVu2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XRl18Gbp; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6Oc5W605164
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:30:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	slLVtfDbDJmYzwbjOSmqxM9AOyJ3tClD0VC9hBTruLU=; b=GRYYkVu2hFw4lLTq
	FvcJozrtIVAADmTjHVyx8brQlU4+bjJyKVmVuE/p98pcde4YhP52qXxImJJLWZ3F
	sa3VZA2p46AQjTUCo9w6JaQbeeG72UMhLJaSl5QXGSRQPeDwzw/kLRL5DL9W4GvP
	bxTr1+PCGd66tDZKLFY013dVJ1B71i5x+UiQXJ6wF2COR7liMB4HORa7uDcQQwP9
	P+IOabAPT4Lg7VQpyUXynzLhLklFxgddEBS6ksFUq67MugoYg7HBMVFndFekMlKw
	1w8uGiVrsnpkIJj5iBK3QFD/k1zuaNjVTySH6A39eTur7G8tRStjCMC+bhy23xhg
	Qyd3Vw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbeehmyyx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:30:48 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c890bac374eso7341053a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 00:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783927847; x=1784532647; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=slLVtfDbDJmYzwbjOSmqxM9AOyJ3tClD0VC9hBTruLU=;
        b=XRl18GbpOrASX5Gx1J4yGwJ/9BNyv6mrLE+tiDzPeZWNVCtNb5tYwMcpOf79CUP20T
         hYWWyBqBwX990O0nSTW/d11r0Q2AGnkGlCMkBowTIQxB1CpXrpJYhNm56pnQmlAh5nPK
         pdLroPLcOB6y45eklkU1/W4AIxEWStgbSazAeIsd8qodQCWCgHPHF8N0YwCyRm6l2qIR
         Lnj0bv9SslduzcuBRfHaUFWsn1bGPMGVtlQeRwfwg4T6x+yBf+LD4WNRQNW6P5vOmcOV
         +8Tkn/N9rbQ4Nbuw2C1SS8Fo85KQAtv80nU1YERYyqGtLgjHJeUTTOr4m2FUhChXndVN
         FbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783927847; x=1784532647;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=slLVtfDbDJmYzwbjOSmqxM9AOyJ3tClD0VC9hBTruLU=;
        b=C+Bn0zDXVvyRmi+hfP8UGYvU1nyya6Bid0RR0B9TRS8y9Yap7tx3Ve8e5iEjPdbEH5
         K0piWKw1Cbvbt6gM2kby2fEccTMCenwj45rTllpVlq7I2FaWM4jOzo9bUHVXBHGheeOp
         rn5fe5qpqY760wDzNmkZDg0vuIFTNolJZzASi04iw9EdrfRBE/ft66/hOWYAZpyWDmi8
         lWW3rnAexrnku7Ol7BU1+x5qX1P/W7PVfM45e3W6H89+QbGJk+/IwxIsZ6AQOwbnqAp8
         c7pj2HNiwllDqthChVmL8FSls2m2eF13uFI+WcP42/h1FWttERDoW52o6e+Z/xqIELer
         Xocg==
X-Gm-Message-State: AOJu0Yy1tQG+aVCzwejhBIfQVcT0VAX0yk106HugtbSu0xlBVDW2dSCY
	2Kn0Q4CMvP9jmilSNMWGxMwf+JdrwZBu29ZE3xE9wobjw13NNgTU/l9tQMCQeIGApWRPKNiMZFe
	Ee7zWaNHSpXAKFDYz6zuDp9slvv0TGAWgJwAXc9N4uq34oHIByZKUYhwadybjzhs0BAFn+on7ez
	AZctr1
X-Gm-Gg: AfdE7ckgjXmn+AyH1Yy19LpkO+dT0BJACIgtDFT6UKsovm81WzZIU07iyoqDOQTzHEp
	8eUGLxXzJ+Vsjv+cxm4iFMZh8nn6mSqclQEGouf8rX5VJ1bxfA+bQYTSFKXMlnErjRy9TKG9Vxw
	B/BXqAKabmLfXqIsvv4RVY0+FCBWU7IjMN6CC81MRDfmii/SFSZhraow/fe0jc6MQuZu/BInGP2
	MyThuedqhfjFQ9gwLcF3klJ6cTFdZb1IiHUSOmCGkwCxIjPFBvG6hoUHJgrRzs/AAh+LkfClrZ+
	qEZxAp7qQlat46TBV5BaebI8UMXHEqCC+jxa/ygh4UsPD/BfXtesVv9B7lRim+fcb7c+vGmHhNj
	xM5STf0VcF0LjN7KlbcHeWuBtHSC1cybSIDoN9LLC11DV8lZ4UA2NL1sfiQ1xMOR8
X-Received: by 2002:a05:6a20:4324:b0:3bf:80a5:51b0 with SMTP id adf61e73a8af0-3c10fb6f300mr9071211637.0.1783927847505;
        Mon, 13 Jul 2026 00:30:47 -0700 (PDT)
X-Received: by 2002:a05:6a20:4324:b0:3bf:80a5:51b0 with SMTP id adf61e73a8af0-3c10fb6f300mr9071189637.0.1783927847017;
        Mon, 13 Jul 2026 00:30:47 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b31628c1sm7947252a12.19.2026.07.13.00.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 00:30:45 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:29:58 +0800
Subject: [PATCH ath-current v6 6/8] wifi: ath12k: do not advertise MLD peer
 ID for firmware-allocate devices
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-ath12k-fw-allocated-ml-peer-id-v6-6-20f6f212e413@oss.qualcomm.com>
References: <20260713-ath12k-fw-allocated-ml-peer-id-v6-0-20f6f212e413@oss.qualcomm.com>
In-Reply-To: <20260713-ath12k-fw-allocated-ml-peer-id-v6-0-20f6f212e413@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA3NiBTYWx0ZWRfX2lS56XuF4P0F
 NqzHn3i5GVsYGxrH4U78UBv7jDquTTfGyM3kluyKWBHkRPtgxjc0C+pFttxFLu+/Z2NQlyLJPx0
 90PBUPHJTFyqKEeQ3Ek/IrsvgXHDUBc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA3NiBTYWx0ZWRfX0Lkqdv9zGq/A
 IiSv571UkY2sN0/Ydz4JFPKgNznXcypWfS9raZ0RKk6NEHfLGl9itD6ibz1t6WHDu40LTIfZy11
 J/pFmkrv3dGLBMuEbY2TFf9755edbpeKh2rWiMdL+5f+BmLVZrMgEbi9hz0w2S0SQQAT9ZHq7dL
 Cssx1LTIK0pNZVzE1XVJ7DVFRajonohpVcpoJbdvZ3TZk/37EgBqbjBkHboZcbcnw7/xa8TO9Nr
 +8whGV0w6ZeiB8miZNPiAJtArObh6cpLKeYjDDufhezUQjC6lvUQ9Zu+/W6ngxqzEI7w7EGq9Fs
 lBFp7NsdV90r1s8/wxJrYoydtPezbZ0nfn7x6ewuQNRswRdPs2Q7CZVnZQ9DX8uKgSuytJT68Bp
 +4JDWZoWw0e78WHb2Fwn9vrUQkhdFubxaYOmJU9LP+foQJxZt8iYDzA2OQjeV3htZR6+z1FJX/R
 PfEMZBqjmwY9H2AWT5A==
X-Proofpoint-GUID: 6jwP2_XtNAtncKQ2L03JNM0Zv1_ylGcq
X-Proofpoint-ORIG-GUID: 6jwP2_XtNAtncKQ2L03JNM0Zv1_ylGcq
X-Authority-Analysis: v=2.4 cv=aPvAb79m c=1 sm=1 tr=0 ts=6a549428 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=zO7lKvSgDLHZEP5-WbMA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130076
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38949-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:baochen.qiang@oss.qualcomm.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C71A574831C

ath12k_peer_assoc_h_mlo() unconditionally sets ml->peer_id_valid and copies
ahsta->ml_peer_id (with the ATH12K_PEER_ML_ID_VALID bookkeeping bit masked
off) into the WMI_PEER_ASSOC_CMDID ML params, which causes
ath12k_wmi_send_peer_assoc_cmd() to set ATH12K_WMI_FLAG_MLO_PEER_ID_VALID.
This needs to be gated on chips where the firmware allocates the MLD peer
ID:

  - WCN7850/QCC2072 firmware always picks the ID itself and does not honor
    a host-supplied one, so the value would be silently ignored anyway;
  - QCC2072 firmware additionally crashes during MLO disconnect when
    ATH12K_WMI_FLAG_MLO_PEER_ID_VALID was set in the preceding peer assoc,
    so the bit must not be sent at all.

Branch on ah->host_alloc_ml_id:

  - When true (QCN9274 etc.), behavior is unchanged: peer_id_valid is set
    and the raw ahsta->ml_peer_id (without the VALID bit) is sent down.
  - When false (WCN7850, QCC2072), peer_id_valid stays unset and
    ml_peer_id is sent as 0. The firmware ignores both fields and reports
    the ID it allocated through HTT_T2H_MSG_TYPE_MLO_RX_PEER_MAP.

The early-return on ahsta->ml_peer_id == ATH12K_MLO_PEER_ID_INVALID only
applies on the host-alloc path, since on the firmware-alloc path the value
is ATH12K_MLO_PEER_ID_PENDING here, not INVALID.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 9e5fcbf8c730..8cd5e9b15db5 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3529,11 +3529,16 @@ static void ath12k_peer_assoc_h_mlo(struct ath12k_link_sta *arsta,
 	struct ath12k_sta *ahsta = arsta->ahsta;
 	struct ath12k_link_sta *arsta_p;
 	struct ath12k_link_vif *arvif;
+	struct ath12k_hw *ah = arsta->arvif->ar->ah;
 	unsigned long links;
 	u8 link_id;
 	int i;
 
-	if (!sta->mlo || ahsta->ml_peer_id == ATH12K_MLO_PEER_ID_INVALID)
+	if (!sta->mlo)
+		return;
+
+	if (ah->host_alloc_ml_id &&
+	    ahsta->ml_peer_id == ATH12K_MLO_PEER_ID_INVALID)
 		return;
 
 	ml->enabled = true;
@@ -3541,16 +3546,25 @@ static void ath12k_peer_assoc_h_mlo(struct ath12k_link_sta *arsta,
 
 	/* For now considering the primary umac based on assoc link */
 	ml->primary_umac = arsta->is_assoc_link;
-	ml->peer_id_valid = true;
+	/*
+	 * Only chips that allocate the MLD peer ID on the host send a valid
+	 * ml_peer_id in WMI_PEER_ASSOC_CMDID. For chips where the firmware
+	 * picks the ID, leave peer_id_valid false to avoid unexpected issues.
+	 */
+	ml->peer_id_valid = ah->host_alloc_ml_id;
 	ml->logical_link_idx_valid = true;
 
 	ether_addr_copy(ml->mld_addr, sta->addr);
 	ml->logical_link_idx = arsta->link_idx;
 	/*
 	 * WMI_MLO_PEER_ASSOC_PARAMS expects the raw ML peer ID without
-	 * the host-side ATH12K_PEER_ML_ID_VALID bookkeeping bit.
+	 * the host-side ATH12K_PEER_ML_ID_VALID bookkeeping bit. For chips
+	 * where the firmware allocates the ID, the field is unused (the
+	 * firmware always allocates regardless of the value here); send 0
+	 * to make that intent explicit.
 	 */
-	ml->ml_peer_id = ahsta->ml_peer_id & ~ATH12K_PEER_ML_ID_VALID;
+	ml->ml_peer_id = ah->host_alloc_ml_id ?
+			 (ahsta->ml_peer_id & ~ATH12K_PEER_ML_ID_VALID) : 0;
 	ml->ieee_link_id = arsta->link_id;
 	ml->num_partner_links = 0;
 	ml->eml_cap = sta->eml_cap;

-- 
2.25.1


