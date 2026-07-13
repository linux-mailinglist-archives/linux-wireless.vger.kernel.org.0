Return-Path: <linux-wireless+bounces-38950-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n73aCjiUVGoRnwMAu9opvQ
	(envelope-from <linux-wireless+bounces-38950-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:31:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D600748294
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:31:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=SP0N4RKD;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=OUG7Q6iK;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38950-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38950-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B3B36300D367
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 07:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06CE38F957;
	Mon, 13 Jul 2026 07:30:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D216B38F92A
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:30:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927853; cv=none; b=OdwkONREM0eJV010YOg4nsisfpHIxyXrcv6W+fLZp/cDMOoLdlZJDPZK4AR3O2vwA4shSUNWVd1b7kMI74J0m8geobFcKCmL8RjWJCKzP7diSGyJgUVb8HO4F15NHKznR43L1axpKHiX898RRhmcANT1CO/w3u0T37gKB4TiO9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927853; c=relaxed/simple;
	bh=n4/Q3yR/LWAyxgC4NAls5vX3OWpxKkmEyAbj3V/9YCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LMiKWzxF2dp6XJg14HRTGlJcUYICSbV8/WcZNF9pUmvqiDxg6TXmbYhWx+cYFfV1kTws85KMmHqyrDln5LuPBNjLPz/WXMireFWuJphXxtWLM9kXajiwlltSV/cFrD/h6ry0OfP9ShV6yRvdRpyzN2hG8VCgPlCD41qS3XnMrdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SP0N4RKD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OUG7Q6iK; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6NhjG648375
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o0az8tsVR7zS2GhqdLGHW1f/gmLg6FxiIQXtaw3jsQc=; b=SP0N4RKD6joAVp5L
	YsLx0jShhYaHixiDFHLJdwDkl/aWSDuP0aYNCGRj01yrNhwYtvLCCCVPDAI/CNYH
	puw2wGuhDX7GAPKoC+lTJjj3ud3R3+L//h7v5HnZJQ2amjdtQV3r+7rFd3bz2et0
	QfeBWgo/EQMTgLaWQkAFFWbb/N9VmyJumbujrJC3oia/WTUOuHrq4Gk//CNxbbpO
	usoY9s+jPeFBxrYTQfYPAufKxUgM+l62tR+VAwRkkY0hs9A4c/icD7txbo6+lMDG
	VzHGgCBALm9llPvGPoxR8TD6zIEK83P5aNdqtP/JezJzGENEZb+aWPGcduTaAPfr
	SxjYlg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbebr4v33-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:30:51 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cceabd70f5so71210465ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 00:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783927850; x=1784532650; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o0az8tsVR7zS2GhqdLGHW1f/gmLg6FxiIQXtaw3jsQc=;
        b=OUG7Q6iKzRcduopixgbOauEjWSMxcHQozmhaWFiRR3iXXs68KzQvb4mhR6InNUxnGL
         4pK8DEPMwYSA1NmEAncJdI21Z8JACA5h1Gcgt/ThpDmZBdSfQYS+3LiJYlz+6/596MuZ
         6kZj/DK/HIqy2yQLgiOrcw4LV9Kf61QVuhAraNpFwptL/+Mdeg9IJyDyhdLlQ68/W9gN
         Ma7WA3CvCUKz/mHhbjRol4a0a94Kr2j22Ns75Ux7S/r0j/ZrJMzrhnKBKlxh+hvHo4v8
         zoph3cW13SQPQy/ZXiWESCPlz16D3fQh1naYnOZWCPsgEiHes7y8qUjAIA6hFo6EVHSX
         SpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783927850; x=1784532650;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o0az8tsVR7zS2GhqdLGHW1f/gmLg6FxiIQXtaw3jsQc=;
        b=Ohxc8NwqamYX4JGnLOWt+gXDUCpnj7JZtWVfN+wf855164HdRTiDkHz/Q+sIOiMWU5
         YMOJA2TLfHJm9xtGzHSAMUbl/NyvclsdWbWPfg+f+9/gjF/3Zr3pZlu/eGUeb51G3iLJ
         LtnPd5BJ/Wu0j4C3XY5uT51vNgC0voTJXohOtM5FBhqNUdtsMMnquGwW06YRJGFpsaCT
         N2p6XsJFhsb01g/j+M797SIXPAGbEI3OjxbCL2ljewcscaGju9Ql0e60paI5Ef28nNnT
         8n97w9G00DBxDMmoYW3/orbUC8WZTpZIAGeJ7lfi9pwBsDWd6W5f2AnnBWAbPQ3JPNIZ
         aeLg==
X-Gm-Message-State: AOJu0Yw5Kruu4VxC+LgJhm6luS0MNyyt7GfCXgOXu6V563JxHT3AqbTj
	8xkO2C0qgDmWFLdiPgTOkclqw2HoMS/DgiWn1nv4TsdK/jrLkST1Kh6KorRMEAHFOOitQC6MLft
	ohypPcLE/ByAXWp9t5qBo59UlyCkjEIC6uo1J59h4Q61ikLkwMox69phAMExYJ3a7WJxPxFlfsM
	RhbVRy
X-Gm-Gg: AfdE7cmUs3w6pYdbVilrAKrNiXJ71cUibaQ8C4MBEYzYTkQQ3X4PfdOcaSm2efOon2Y
	XOEw4xzMWvMphrTrHk0qU3AlC8PtCuCAGJ9NywVf1TElX3ipyujH+EEIxhGCtJtM2yYyjzN9cDZ
	2hL6f+CfZbhXE88VXF+BUpL65/XwplFor3Q6uSRHKVOfw543ZM+8lsFn5t9NqGdzxBONDqK5atR
	vhRPCG0/pVaJhQ3weQYXdsC9nJgVv9i1Lrp2b1DQNKN1UzLlG3R7sa0VkJSyJ0cJOptZ42CENlC
	PPgZ9/0t1WB5GfH2hxoPOnkID2mluyyAJ5NeIpiMzfH0d9E2Yskte3Y4E3OKbyFkz86+dpwh0gg
	abfDozu9JnPIUQ4TPFPTD2lhpmeIDBmHzRNZ3YTIuI8OM9sfKCvi6zmhKzLIwpcxk
X-Received: by 2002:a05:6a20:a10b:b0:3c0:9c1b:d0bd with SMTP id adf61e73a8af0-3c110a18f83mr8622545637.72.1783927850245;
        Mon, 13 Jul 2026 00:30:50 -0700 (PDT)
X-Received: by 2002:a05:6a20:a10b:b0:3c0:9c1b:d0bd with SMTP id adf61e73a8af0-3c110a18f83mr8622506637.72.1783927849779;
        Mon, 13 Jul 2026 00:30:49 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b31628c1sm7947252a12.19.2026.07.13.00.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 00:30:48 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:29:59 +0800
Subject: [PATCH ath-current v6 7/8] wifi: ath12k: defer dp_peer
 registration when firmware allocates MLD peer ID
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-ath12k-fw-allocated-ml-peer-id-v6-7-20f6f212e413@oss.qualcomm.com>
References: <20260713-ath12k-fw-allocated-ml-peer-id-v6-0-20f6f212e413@oss.qualcomm.com>
In-Reply-To: <20260713-ath12k-fw-allocated-ml-peer-id-v6-0-20f6f212e413@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA3NiBTYWx0ZWRfX8WAZhH909u75
 afYHmfeFiNGLj/CZB3tGy7Y+LLbEIuAo9eh0Q3MVOcUWNGU5K+gk7Rk2saKEp/GGph4S/6mfSDM
 5A+B+nWQHpXJZB469Lnm0CVIr6pFNUQ=
X-Authority-Analysis: v=2.4 cv=OK8XGyaB c=1 sm=1 tr=0 ts=6a54942b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=DmUR2gHJotVURrrF6hgA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: St2IyEWB2vI_m0sA_XbBySWP8ELGkq06
X-Proofpoint-ORIG-GUID: St2IyEWB2vI_m0sA_XbBySWP8ELGkq06
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA3NiBTYWx0ZWRfX95t7PQ4oNICC
 BArYwRjLBR0IsQulFTx4PP7ihzLc7XtRlmWOUnxIw78Z9I6Pt1z5V/oGhDT3rpyXaQuV7/TEkQ3
 4Z8KVp5oBLOuBHmHunld/IYXiPuMC79nu43qMia1pY3GjaYIM/wZuBLgd/fiZ7jmubc0jOdYg9y
 cKHFiOpWaeUCePoatrWPssKLh/qecghvbcirhgrKvl1U9iS2Qnw3ndUx8ebzuVpuWRSYj3+SGx2
 iGG/Xz7lrGQJibEEgI6Dyb7p01r2b1p7sKyatfymJ9WRoeysSu6RK5Ky8bbdHulFVMaDemdWX+m
 vuW5nvcaOx6k9D/IHKA3Wt1jZ9r0beM4G7XFQThl/sivf1EafNa9R6a9CKr4vHEwiTegHkitrS3
 tlYxA0qm8lKY2Laa5V62hmRuIn1rcuzHb7SpQBgSYJng++F6qm6Oz0dSd8azGLkHUrQAgTjJqus
 GsVc5KgjZNVVGylvBPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130076
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38950-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D600748294

For chips with host_alloc_ml_id=true (QCN9274 etc.), the host allocates
the MLD peer ID up front; ath12k_dp_peer_create() publishes the dp_peer
into dp_hw->dp_peers[] using that ID immediately. WCN7850/QCC2072 does
not work that way: the firmware picks the ID and only tells the host
afterwards via HTT_T2H_MSG_TYPE_MLO_RX_PEER_MAP, so the publication has
to be delayed until the event arrives.

Introduce ATH12K_MLO_PEER_ID_PENDING (0xFFFE) as a sentinel for "is_mlo,
but ID not yet known". On the firmware-allocates path:

  - ath12k_mac_op_sta_state(NOTEXIST->NONE) skips ath12k_peer_ml_alloc()
    and stores PENDING in ahsta->ml_peer_id and dp_params.peer_id;
  - ath12k_dp_peer_create() skips dp_peer registration until a real ID is
    known;
  - ath12k_peer_create() leaves peer->ml_id at INVALID so consumer sites
    do not treat PENDING as a real ID;
  - ath12k_peer_ml_free() and ath12k_mac_dp_peer_cleanup() skip the
    dp_peers[] write and the free_ml_peer_id_map clear when
    host_alloc_ml_id is false or the ID is still PENDING.

The HTT handler change that resolves the PENDING ID is added in a
follow-up patch.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.h    |  1 +
 drivers/net/wireless/ath/ath12k/dp_peer.c | 23 +++++++++++++++--------
 drivers/net/wireless/ath/ath12k/mac.c     | 22 ++++++++++++++++------
 drivers/net/wireless/ath/ath12k/peer.c    | 20 +++++++++++++++++---
 4 files changed, 49 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 1f56474efbea..8769b41f5db5 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -72,6 +72,7 @@
 
 #define ATH12K_MAX_MLO_PEERS            256
 #define ATH12K_MLO_PEER_ID_INVALID      0xFFFF
+#define ATH12K_MLO_PEER_ID_PENDING      0xFFFE
 
 #define ATH12K_INVALID_RSSI_FULL -1
 #define ATH12K_INVALID_RSSI_EMPTY -128
diff --git a/drivers/net/wireless/ath/ath12k/dp_peer.c b/drivers/net/wireless/ath/ath12k/dp_peer.c
index 47d009a0d61f..2a2eae194007 100644
--- a/drivers/net/wireless/ath/ath12k/dp_peer.c
+++ b/drivers/net/wireless/ath/ath12k/dp_peer.c
@@ -472,7 +472,9 @@ int ath12k_dp_peer_create(struct ath12k_dp_hw *dp_hw, u8 *addr,
 	dp_peer->is_mlo = params->is_mlo;
 
 	/*
-	 * For MLO client, the host assigns the ML peer ID, so set peer_id in dp_peer
+	 * For MLO client, the ML peer ID, either known or PENDING, needs to be
+	 * initialized here since the following logic depends on it.
+	 *
 	 * For non-MLO client, host gets link peer ID from firmware and will be
 	 * assigned at the time of link peer creation
 	 */
@@ -488,13 +490,17 @@ int ath12k_dp_peer_create(struct ath12k_dp_hw *dp_hw, u8 *addr,
 	list_add(&dp_peer->list, &dp_hw->dp_peers_list);
 
 	/*
-	 * For MLO client, the peer_id for ath12k_dp_peer is allocated by host
-	 * and that peer_id is known at this point, and hence this ath12k_dp_peer
-	 * can be added to the RCU table using the peer_id.
-	 * For non-MLO client, this addition to RCU table shall be done at the
-	 * time of assignment of ath12k_dp_link_peer to ath12k_dp_peer.
+	 * For an MLO client whose ML peer ID is allocated by the host, the
+	 * peer_id is known here and the dp_peer can be added to the RCU
+	 * table using it. For an MLO client on chips where the firmware
+	 * allocates the ID, peer_id is ATH12K_MLO_PEER_ID_PENDING and the
+	 * RCU table publish is deferred to the
+	 * HTT_T2H_MSG_TYPE_MLO_RX_PEER_MAP handler. For a non-MLO client
+	 * the publish happens later, at the time of assignment of
+	 * ath12k_dp_link_peer to ath12k_dp_peer.
 	 */
-	if (dp_peer->is_mlo)
+	if (dp_peer->is_mlo &&
+	    dp_peer->peer_id != ATH12K_MLO_PEER_ID_PENDING)
 		rcu_assign_pointer(dp_hw->dp_peers[dp_peer->peer_id], dp_peer);
 
 	spin_unlock_bh(&dp_hw->peer_lock);
@@ -515,7 +521,8 @@ void ath12k_dp_peer_delete(struct ath12k_dp_hw *dp_hw, u8 *addr,
 		return;
 	}
 
-	if (dp_peer->is_mlo)
+	if (dp_peer->is_mlo &&
+	    dp_peer->peer_id != ATH12K_MLO_PEER_ID_PENDING)
 		rcu_assign_pointer(dp_hw->dp_peers[dp_peer->peer_id], NULL);
 
 	list_del(&dp_peer->list);
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 8cd5e9b15db5..818eb3aa919e 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1285,7 +1285,9 @@ void ath12k_mac_dp_peer_cleanup(struct ath12k_hw *ah)
 	spin_lock_bh(&dp_hw->peer_lock);
 	list_for_each_entry_safe(dp_peer, tmp, &dp_hw->dp_peers_list, list) {
 		if (dp_peer->is_mlo) {
-			rcu_assign_pointer(dp_hw->dp_peers[dp_peer->peer_id], NULL);
+			if (dp_peer->peer_id != ATH12K_MLO_PEER_ID_PENDING)
+				rcu_assign_pointer(dp_hw->dp_peers[dp_peer->peer_id],
+						   NULL);
 			ath12k_peer_ml_free(ah, ath12k_sta_to_ahsta(dp_peer->sta));
 		}
 
@@ -7746,11 +7748,19 @@ int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 		/* ML sta */
 		if (sta->mlo && !ahsta->links_map &&
 		    (hweight16(sta->valid_links) == 1)) {
-			ahsta->ml_peer_id = ath12k_peer_ml_alloc(ah);
-			if (ahsta->ml_peer_id == ATH12K_MLO_PEER_ID_INVALID) {
-				ath12k_hw_warn(ah, "unable to allocate ML peer id for sta %pM",
-					       sta->addr);
-				goto exit;
+			if (ah->host_alloc_ml_id) {
+				ahsta->ml_peer_id = ath12k_peer_ml_alloc(ah);
+				if (ahsta->ml_peer_id == ATH12K_MLO_PEER_ID_INVALID) {
+					ath12k_hw_warn(ah, "unable to allocate ML peer id for sta %pM",
+						       sta->addr);
+					goto exit;
+				}
+			} else {
+				/*
+				 * firmware allocates the ML peer ID and notifies
+				 * the host via HTT_T2H_MSG_TYPE_MLO_RX_PEER_MAP
+				 */
+				ahsta->ml_peer_id = ATH12K_MLO_PEER_ID_PENDING;
 			}
 
 			dp_params.is_mlo = true;
diff --git a/drivers/net/wireless/ath/ath12k/peer.c b/drivers/net/wireless/ath/ath12k/peer.c
index ae93731b4177..25e4b79f11d6 100644
--- a/drivers/net/wireless/ath/ath12k/peer.c
+++ b/drivers/net/wireless/ath/ath12k/peer.c
@@ -230,7 +230,16 @@ int ath12k_peer_create(struct ath12k *ar, struct ath12k_link_vif *arvif,
 		/* Fill ML info into created peer */
 		if (sta->mlo) {
 			ml_peer_id = ahsta->ml_peer_id;
-			peer->ml_id = ml_peer_id;
+			/*
+			 * For chips where firmware allocates the ML peer ID,
+			 * ml_peer_id is ATH12K_MLO_PEER_ID_PENDING here. The
+			 * MLO_RX_PEER_MAP HTT event handler fixes up
+			 * peer->ml_id once the ID is known.
+			 */
+			if (ml_peer_id == ATH12K_MLO_PEER_ID_PENDING)
+				peer->ml_id = ATH12K_MLO_PEER_ID_INVALID;
+			else
+				peer->ml_id = ml_peer_id;
 			ether_addr_copy(peer->ml_addr, sta->addr);
 
 			/* the assoc link is considered primary for now */
@@ -285,8 +294,13 @@ void ath12k_peer_ml_free(struct ath12k_hw *ah, struct ath12k_sta *ahsta)
 {
 	lockdep_assert_wiphy(ah->hw->wiphy);
 
-	if (ahsta->ml_peer_id <
-	    (ATH12K_MAX_MLO_PEERS | ATH12K_PEER_ML_ID_VALID))
+	/*
+	 * Only devices that allocate the ID on the host own a slot in
+	 * free_ml_peer_id_map.
+	 */
+	if (ah->host_alloc_ml_id &&
+	    (ahsta->ml_peer_id <
+	     (ATH12K_MAX_MLO_PEERS | ATH12K_PEER_ML_ID_VALID)))
 		clear_bit(ahsta->ml_peer_id & ~ATH12K_PEER_ML_ID_VALID,
 			  ah->free_ml_peer_id_map);
 	ahsta->ml_peer_id = ATH12K_MLO_PEER_ID_INVALID;

-- 
2.25.1


