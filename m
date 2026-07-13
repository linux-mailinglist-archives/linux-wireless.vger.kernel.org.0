Return-Path: <linux-wireless+bounces-38986-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fIqaFXQQVWpPjgAAu9opvQ
	(envelope-from <linux-wireless+bounces-38986-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 18:21:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A698274D897
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 18:21:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=EzLrYT3Z;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=RaUnJE4I;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38986-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38986-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A1D831017DF
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 16:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736D4233937;
	Mon, 13 Jul 2026 16:16:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131F33368BF
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 16:15:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783959368; cv=none; b=EmigpZNASJytaa5IqaCy/0ZeI8yQRGGbAVujOuDtwna/vbxRQSs5/fvFDGbS5yrxRn3fmcIUmBlaBCk3r6w50YSqaNX51iee2LY9pYVsvXTWFd8jP6OURtvgKKjP9MYG9hG0KnS4vvB+Vz5EEJIycvuwkWROsnOkMTYFC8yFxQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783959368; c=relaxed/simple;
	bh=pfCOKpJkzAPPABkt6Kvshpp3Cs+cx+pFhUyTtXT45Uw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ld/XjkH+yWxZGh9XZpB1Ndkr4dsyuv3emmFiuXJ8UPBRMgj9qrWMHD/PGRHceCjr+12UIKeYT++D9Koe1H6lp52WEnW2EBSUDHn2SrUFTiZXdjlQFLZQkuojGP3K8uyh0b7KydwSQwBWw9qVOksAZfDomWEJkYbR4j52jbAGMOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EzLrYT3Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RaUnJE4I; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DF8MP51709355
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 16:15:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/SEIS1vL/+8nOxtKCLA1mNY2y1cK6U6iZy+GY0kR19c=; b=EzLrYT3Zxjwtibuk
	TyoLLNMqGzSEyXeBi2kgCSRqSD3boQivLX0NERvsUnK92Bb32PXuhvot0R96N0R5
	/h/G9pCNy506wiBZIJuJwY58jptG31REWXNxiZm3yz++paCV0tbJ5rqvihA0HrE4
	fWtCqxWdUqa7y0BASOc8pMGqB+aCxOUGUpNsLk8pG84I0nLm/Y+fyzEb88fXU1dJ
	Z5NFfW/ltI72MxahmRnZWTedg+1ZRRs09BfLQ8dQifS9uutrJVC4Kp/YCbdDyh/0
	jsP9JobK7cC6k2LhG5JBOvvXwhheGum0yqwScI8TMHfmmTLzk8MxmijRfV/VRTKp
	CnF9YA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwk9sjr7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 16:15:57 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38de842a1a9so2099588a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 09:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783959357; x=1784564157; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/SEIS1vL/+8nOxtKCLA1mNY2y1cK6U6iZy+GY0kR19c=;
        b=RaUnJE4ITsHIy4LgBqkzdMCC5A0n9Be/Mtsg7I9ElAzR9shkn50ZSYT+QEoWreP+Us
         rNd2QrTTK66I5eqojn/zrWZ98n6km1MG38wFnO/aPslwlPTsp1z85zlb0rHNWTLFoZvn
         Hq1xIt6C23xZfBFmEvS4jBrrT9EyXFVsF9gP43aFRveD5K5ineXZq36aaZsoqexlZ8Uo
         TGGyLonitp3aiIy9mXInFHgkCGE/a8n7wt3p8ZsIfJcvyNTVyxq24mFlG7vt0n3pMXlw
         YeYZFKX31/+5efNUD1RZZI4Dc3YsXB+kKY4Bx73Wlhf6zyMxnYK4H3UsUe48N3aL7RTj
         XuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783959357; x=1784564157;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/SEIS1vL/+8nOxtKCLA1mNY2y1cK6U6iZy+GY0kR19c=;
        b=epNxDcnGNyWi1iaM/p/oUeqaUjCxON9l27AKp3vnKvGvdwpAFBvmiTLiW+mFfMFAyO
         PhLz5S9Y4stGtwzdKHC8UHczOpdFfoQgJgfhJbPsPRbvVdnPZvoUIY+aK8kov5hvmTfE
         rANaWBByUiUq6ucYHNYherMNyMKFSiJcYStKkv5X0NpiF9658frdefqGWP28PFulgZ5C
         e6O4Ckqt3W66N+JOMpZBKphlD5PrfPKpOV4tinb34Z2q+aLk7WawDnxldgpseJ6caXNa
         8v1uYyVKLTWcgbuHV50Z8CqGLaE/lJnkrbsUvt/CSnZXTzihVxMk0IwfybFTzSnFilq0
         8HJA==
X-Gm-Message-State: AOJu0Ywglz6cSKNQ8DSZNpVHSyx2x1l/dxn8tL4BhKbKlAhzqaz65IN8
	0xZJWzn99a4KpgUuRLdQOO7whY57CChtzxqFNXGpTotRfnEMvwUGj/SPv+4FBdLwEDJh29dD/gb
	9nCL9oAil/zYDHBrRwms1QWO9stTyTm9arCCbs719JnAmugqLUEVCBPyUAKnIATooLYXwvA==
X-Gm-Gg: AfdE7cldIAfzeh1Fwko71ANEP6cIU3bP7L35mrm3LAa9zIkqdkGBbdN3FRbzbOyYqsQ
	0ryof3/15/AEVkTFeffR827aU5If6DCMoZJ9nm3fJsr02S/z3O6y3YxuyEqsFmWnu58llu6twI6
	v9R+MjM1HKM4elgLCZSvRW7ULB/IbQHShx0ZXfT1U7JzEewFs7iowV+wP3dmK6u6H9TGQJZy3nv
	op0yzMN500lFDjD9VN+tNeGD9+ivRqreHnSqm+iG2VlJxvzyqQlN3ZrNpAXDTM49TDkJ9lv8jQ2
	IXOzNP8drWghJP4hADlilhnC1eTu4M4cKSJNgyHjvIeIMBFxVq+8zicPs/T/eNOi9Fgeuva3cJ8
	KnhWCY6gR+qJmAajDjaa5EUCIvpVOAS2TLYiP88a8NO8oug6fuVQ0TlR5ar8l3oAypg==
X-Received: by 2002:a17:90b:3903:b0:387:df8f:1409 with SMTP id 98e67ed59e1d1-38dc77d8a8fmr8610359a91.42.1783959356570;
        Mon, 13 Jul 2026 09:15:56 -0700 (PDT)
X-Received: by 2002:a17:90b:3903:b0:387:df8f:1409 with SMTP id 98e67ed59e1d1-38dc77d8a8fmr8610324a91.42.1783959356092;
        Mon, 13 Jul 2026 09:15:56 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118389d9bcsm60877039eec.20.2026.07.13.09.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 09:15:52 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 09:15:49 -0700
Subject: [PATCH ath-next 1/2] wifi: ath12k: Correctly copy the hint BSSID
 in WMI scan request
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-ath12k_wmi_send_scan_start_cmd-bad-hint_bssid-v1-1-4ffc4a472992@oss.qualcomm.com>
References: <20260713-ath12k_wmi_send_scan_start_cmd-bad-hint_bssid-v1-0-4ffc4a472992@oss.qualcomm.com>
In-Reply-To: <20260713-ath12k_wmi_send_scan_start_cmd-bad-hint_bssid-v1-0-4ffc4a472992@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE2OCBTYWx0ZWRfX+E4qvRveeh4g
 r4XS4MKM3fw5dzVHzYqCCJNTN72G0pnniIlJfbVcpDvX1opQPzXqrJrzWn3Lf5w7ovYM2QIECjI
 m16QSqEw7qCM/Phj3w5//I+ozATTrSqweCJQhjwEJ8ndUSYwaF/FhRMstYtHQwdau+nH1+G2X49
 h7gsrKVR1R37ET7D0D1SuHXXyKggAA0yPmaUBYvl15Q88brGHkPZeHteFIOL5chFcodmuah9h4x
 JxfrUFg4HCKu4FggTl6XfFzKHJWQueGXEtAwnUn5o1U3RN/cDsdGBh44vgWcyJvo4YShHW/PAsl
 nnDFoz2Zk7BL8uLay0OHcHQL+6gII4nFXi/F7KAWd0mw8oKVt+az/GXXFFtvkzDbIAxFD5ZqJuC
 rVfI47sy5PGmQhANoacBI9ge5mvVFgiD3k0QmlMAqfKHFE1qUSTPNpt1iLvIWxPY7sN02x/bvtG
 j8Mj2YKpY2aujeCJCCg==
X-Proofpoint-ORIG-GUID: 9ntvgaWlPBh01biIKWW4AK6B5PXssIsO
X-Authority-Analysis: v=2.4 cv=UMHt2ify c=1 sm=1 tr=0 ts=6a550f3d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=vlSVdC5Z7QfGigt1aOQA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: 9ntvgaWlPBh01biIKWW4AK6B5PXssIsO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE2OCBTYWx0ZWRfX3Xi4c6XQp18N
 kUv4td/Q+w+r9LbpaAAb6ZRq+AvYGSBzjrbue5OsdeALdDU2r3Jl5hd4mQfXzNvLvCCRZyjZpPk
 JpcqBaPj46odAj37YmaCViaQjmv+SYs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130168
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38986-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:baochen.qiang@oss.qualcomm.com,m:jeff.johnson@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A698274D897

Currently, in ath12k_wmi_send_scan_start_cmd(), the logic to populate
the hint_bssid copies the BSSID in the wrong direction, from the
firmware message to the argument buffer. Swap the parameters so that
the BSSID is correctly populated in the firmware message from the
argument buffer.

Compile tested only.

Reported-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Closes: https://lore.kernel.org/linux-wireless/afbff608-a005-43c4-af76-968a58bf0cc3@oss.qualcomm.com/
Fixes: f40abb4788a2 ("ath12k: New driver for Qualcomm 11be hw family")
Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index ad739bffcf88..fe9394d561f1 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -2796,8 +2796,8 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
 		for (i = 0; i < arg->num_hint_bssid; ++i) {
 			hint_bssid->freq_flags =
 				arg->hint_bssid[i].freq_flags;
-			ether_addr_copy(&arg->hint_bssid[i].bssid.addr[0],
-					&hint_bssid->bssid.addr[0]);
+			ether_addr_copy(&hint_bssid->bssid.addr[0],
+					&arg->hint_bssid[i].bssid.addr[0]);
 			hint_bssid++;
 		}
 	}

-- 
2.43.0


