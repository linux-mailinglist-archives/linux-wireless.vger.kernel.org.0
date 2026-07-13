Return-Path: <linux-wireless+bounces-38959-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4rb8LVeWVGq6nwMAu9opvQ
	(envelope-from <linux-wireless+bounces-38959-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:40:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D62974845C
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:40:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=gDP2bzW7;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=NS6xJ58I;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38959-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38959-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C29803066255
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 07:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB9438E8C7;
	Mon, 13 Jul 2026 07:33:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3E23905F4
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:33:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783928035; cv=none; b=MQNWw6dIFipWF8NMyZ5w+ODQjQC6ObnI7/w5M2wAGyF6ktqH57OUEJiiYqraC5JZuTvT7Io8DScFeobv8PP6Qxf5KoiuY/2A2519D88PfdRB0qGHTrOghyBGEWcnACIcdv/WkI6J/5CS2sZvzJq6u8Q/cEDZmHAgFM4J47cLbBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783928035; c=relaxed/simple;
	bh=DMe7ZO6cU/e71VJeTmd/KsjgeZDDt5YTr7cUZWxwp8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MoEjiCfp7YlRTPrpQbDs+5zdmQTJ2O27yQzIZJ9XwOcLr32Qi+Z5DxioQ19ioXN3G5XYQyZZ8oRkcadUZDHQNAr6mbpfbkw7Zr9pjlt/SrD7IeFh7Q4xHf/q1hz02MOTNfeJdH/5IEKKKoeq5GxKzCJI6XNU68LGsISMGl9J0JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gDP2bzW7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NS6xJ58I; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6Nllt668676
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:33:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	slLVtfDbDJmYzwbjOSmqxM9AOyJ3tClD0VC9hBTruLU=; b=gDP2bzW7GYHi0QdF
	Qb51WQTYgI/QCT8OA6xf1C+ynNqz8Fr0eFVAA2oSIeUgsWUsHDyvXJRtBXSGkfon
	D0yUqvJku2qmVRXIE56IiVbxITv3K5uLias5tpEC6M/p3NamyNpHQmuLTAD5kNfw
	28TKH2NVoDkvfn42kRkyFJ+o3fd9yNoTnI5pH6hk1Pxipa9LRf/LE3mMIlw48Mq2
	MbsHxGG1iSxxvWCaShbRahONQYqF11c7y+33VZEnfyeoRmXNQ1xcy/NGYbexMadp
	18EkzEvRTYUBkMfyyXegkb+GVO+8yftr5WetdZOobXUxPvxVjP5nMzQ0h/d9rHEt
	9yPe9A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcjnm1eub-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:33:53 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cce406883eso27318085ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 00:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783928033; x=1784532833; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=slLVtfDbDJmYzwbjOSmqxM9AOyJ3tClD0VC9hBTruLU=;
        b=NS6xJ58IKGABBkhi56QAS1WkkQaSTsmlMXobRoMh9UQ1Carn0AzG8MkNdbL3PDBkGt
         cszYoEWB5VHfeo6QXGlIacZpA0nfaFILY/QUTlUniOwXdoyJGBur06YN1MRnvgjHsVTW
         yBCkNm8u0UPvugB7q/ympvRoNfRxkVDwtBGBSCqhm+wsaQyDSjBcfsTH7oG9lfFmCrmx
         zyVYQoCQ5Yh7fiCOBTQqTYYNB2HlmtWlnEwv0g9/PyVS+EAgA9Kx1zitJ+gJKXMqmMXW
         YIolRo9S8U6W4zhba8hkQsJPKQxExdWsPTioN4VcIZslSYXufQvB/1zzEWQMFgyvbqtS
         PiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783928033; x=1784532833;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=slLVtfDbDJmYzwbjOSmqxM9AOyJ3tClD0VC9hBTruLU=;
        b=WP1JTMRXv9vwjcc2Xww848ZgHmZ/zIFdF4S21V9hsMdFYek6AIcaazttKJoTSDNXku
         nrDB4tqFL0zTq353iT7IKjWV7kzgManO9l7hKCl81ZnkGzu1RkyMkGtxyV1l+NfWwdgC
         TC8F0Az5SM6eTIjPN/FhhPCJS3/nGBBMC61OyA20rDHFybHe6jyJV8UD8s1+UzsBosji
         IGoyc7PWYvcDWsuOj9ZrB7tokeBblAeCuxtmTp4ZDXOK0eA38TokepLZkBiyJPKegODn
         xLqsGNGjILBAw094wu49HWCF+QiLizbuoop3TX5ja+xNenhQYsSPsVzxyPqBwpDd6iox
         2pfw==
X-Gm-Message-State: AOJu0Yw9p5O9NgY0VfQVC9S4L3wHo2fpTWy4RfHZGk2olT+so8c9UVm9
	aUn+iY51Ax8fnZPvAO26eLEEMmQhDK4h4Mc3GmxQbd1WzRnOe+p84nFoSvtTzUoY3sm1Yh2Skew
	a7jTPwd9DTBqDa5oVWIWW/F1rYSyHKz74TcuFDJjEYX8IPZwcL3BvPaL8fUBDHgFRgpMIwgltan
	Puyywc
X-Gm-Gg: AfdE7cnOtkvMSEb3X48YlglTYJL1+05SaxISCq81Tnm8B2fdMxrr704jRESnENs7VIF
	sbOe17PakNUGdpSCZao30uJ9QuaLyoH8Q7WQhiTlryZnn8uRwRHCz9c1t3yGCq8g9Jsqg6EtcUG
	VEEy9bC9TL70z9DzR3nIKqLYpyIxPKJRIrIRBpTkHDtdxD4i0YBGS8GicLnXtoPJRjBvHqpDp7T
	PqLaocAbLH0L8pd6zIotksta+kUPejuS8Mbw0wtqLfc3Qsf272jn3cQuLA4XRymPHAuFynAvCPR
	yfv6nFI+dXd+NF/FQwHc7eKP5ANHLuape9uV9xpGUuBBRW5lq4bnSy8Adr/Yj8qbfXBDUjUZIl6
	O1Skn77xtZBAw3mFZcvCVewFCuOr7MkmU4XLkRGZ9qF7POt5x77OzpMPYdk5tHFx0
X-Received: by 2002:a17:903:1aeb:b0:2c9:97a8:aff5 with SMTP id d9443c01a7336-2ce9f4d41acmr88512295ad.46.1783928032650;
        Mon, 13 Jul 2026 00:33:52 -0700 (PDT)
X-Received: by 2002:a17:903:1aeb:b0:2c9:97a8:aff5 with SMTP id d9443c01a7336-2ce9f4d41acmr88512045ad.46.1783928032226;
        Mon, 13 Jul 2026 00:33:52 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb72fsm95073615ad.6.2026.07.13.00.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 00:33:51 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:33:21 +0800
Subject: [PATCH ath-current 6/8] wifi: ath12k: do not advertise MLD peer ID
 for firmware-allocate devices
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-ath12k-fw-allocated-ml-peer-id-v1-6-d0a2a1a519eb@oss.qualcomm.com>
References: <20260713-ath12k-fw-allocated-ml-peer-id-v1-0-d0a2a1a519eb@oss.qualcomm.com>
In-Reply-To: <20260713-ath12k-fw-allocated-ml-peer-id-v1-0-d0a2a1a519eb@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: roUWe7obCEs-kOY_Ejih8MXXW3yyWyB0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA3NyBTYWx0ZWRfX1oH9ozoW+mGF
 Ix5d8BHdRQu+w2WpW39ea7xjj6fQxSCjiEeXhgrpzEr21EV/RJpnoGJ0xi2zAmumVJ6MlClUbux
 cbFcEKCgw6KAmQpLfxVIBXZ3BN7Bf5eI5t4I7ovD6VKkvSNIANDioQCHqvXnsCwXEvQbJ+vfe8L
 3DA+xf+5cu0csj24FDacd5myKR/3PPPoWCbemwH0WXPY/E2PY3bXVF1INzG9oTQ9SeGK9ZS6Dyy
 Bq92pa7WNqEOcauB8vu0t7olVENMprTbLTNRYNP6pX4AiCUF2t0tD1cGogd8QXZrSfOgd9Glh4/
 IIGB5j87fLH6paIjPLOTHa2B2VdDKKFZSoHZJ/rMaPiWq4JM/m6ueelc6q0s/apQfLOJMleumVF
 h2H4C4fcYMZ7GeiV1TF3k+OnkSzNAq9XRrfRQyiTNS/inlZnmDmBZvfKjcFKIMfyipBlIv7SUH7
 328c9jszgtmDeAe5IMw==
X-Proofpoint-GUID: roUWe7obCEs-kOY_Ejih8MXXW3yyWyB0
X-Authority-Analysis: v=2.4 cv=AfmB2XXG c=1 sm=1 tr=0 ts=6a5494e1 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=zO7lKvSgDLHZEP5-WbMA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA3NyBTYWx0ZWRfX8gs+UlQhdOt7
 +NCT/M3zX3/FLqt68l/BjYCjHtjRJdgXnVU2BU2Sm0pmeZjlY9aiPbt0XPf/3EeCc8VOp1a9FRj
 F78DzsBuEkHK4AR39i1iieIxmHU1BNg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130077
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38959-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:baochen.qiang@oss.qualcomm.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D62974845C

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


