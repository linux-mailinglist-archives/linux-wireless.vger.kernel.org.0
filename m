Return-Path: <linux-wireless+bounces-37606-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mEVBB9rWKGrSKgMAu9opvQ
	(envelope-from <linux-wireless+bounces-37606-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 05:15:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61651665944
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 05:15:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="ckGU/Hj6";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="K8PEsB/d";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37606-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37606-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C43730701FE
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 03:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D2033F5B8;
	Wed, 10 Jun 2026 03:14:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25B15B1EB
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 03:14:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781061246; cv=none; b=nhTIWjqJjodGaJRXAD9kFtUNSgSG5ButhMBpCw9fTcX3E4xN4fmB92a5jO29+Qg+wvp3FtwcWqCRlHI3lc0t5mn1afedFhO8HyNLQbdZcFuJD7UXy4J77fL9CWWB9jCa1+YVk/FYttXZXjPnwAzD9iVECLOLiVudP1Bb8kGx4GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781061246; c=relaxed/simple;
	bh=HLFQraH2yZ5BE7/VJbbR9XOgDSp9zBjqz9c/2rBX1Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I41S6S9WgNwr+jTpCVG8NpDqsnDhd2gxy3VbJT9U5giovc3BxZUD7uTf60toFpjpSKq8QWlGSYMlm9JtCm9In84MVz+nWlYpcfD6R0vmLGkPyYPVrJDickOoNOPnbux9lllYW4rEsa0u8aqdVJCSqPHHwqK1VBPSVoLKHbYBC3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ckGU/Hj6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K8PEsB/d; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A2f0GS4064605
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 03:14:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=FpZbdticemUFSnk51pLgq0EifnRPEpd07Cb
	PDWjk/LY=; b=ckGU/Hj6GPQ+Do5lyDu234ICSphf3fSwI1OFgIX9a7kyieUtBjj
	E1g9NYQlw8mutO/ZCo6hmruD072hnZiIACx9LtsvAlopJwKQCLlNF0W7f1u3dtqS
	w0diA88wSNH5CMWzBi6JZ6Pmg1RLNo3YNE9RMcfFPo4VXN6VvUQqzFrXaNPEQ//2
	bilOKvosQ1XMo6tQJxBYHEyaFnRZ/nxY8SB//iq7t6E1paHQTvm+GPLiXZXpb5T/
	BmN6KF8knJ8PPHiTPoeyl6ZgPunECtCICuQHVBLWUECindBHMXGhDZcEp4AgqqFp
	Gdt/xy3oZsaZ+jxB6nr0D0cQ7j/hEBlwUkQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epdeewegy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 03:14:05 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1370417c0bfso5793480c88.0
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 20:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781061244; x=1781666044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FpZbdticemUFSnk51pLgq0EifnRPEpd07CbPDWjk/LY=;
        b=K8PEsB/dcWafR7dj/seCm97t661RmKnOwA8Ka8ODwf3CFfUYHLVBUi6IZ/fBOBUTZd
         Ff3Zg308NlThysp66+5VQFyq6j/X3JnEoYLgFRgjAUsQljHRtt3MkFJloQBpKm3125sw
         679PxphX/y7MUbB4hfa2ciWnu3tAJpIgSp3ahQvwCguV6wfSW5zUWr0tR/THWEZM7FA9
         jodyf8aAztfQY/fP7stYrqsh1wwQ+cVSqcYb53mi0I1LnxRM0iC+BjomjCc6DxdudJX+
         gmnPUUdy19j7iYAAZSpxbc+K0/BXsRhhYsl9rnx7ZeHgWdFweiYr53GH3QniY2yX5RaY
         +ceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781061244; x=1781666044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpZbdticemUFSnk51pLgq0EifnRPEpd07CbPDWjk/LY=;
        b=sksNQZw2Z3jCiaVz3ZFoHDiHxCPRaAPzLvcCpRJg5+W/qIro574IUntPnYub/n3G3K
         uEKXp+FkYxSzAfUkLZlybFIV2n+nM+/iPAWiewJRvduS1e/tm8BXFP5MZGB7vqRXsrfp
         RcEoHqptXYUBlLbELQphCoo2vzfHHK421mu/yjTZFP5kUejQxC0KCCQeExLosoDVdE4G
         tDpCuz4z9efLEPG8jppBrQob5JEKI5rm12jrmauWGr9EToHyftD05qMNwyr564PQst3l
         6/huy0pBwHO59BbCPtrM7wDnfsICfMcXVcEppcnRogPFIFYL3v9UELgekAm4/MUbJAoe
         J1tg==
X-Gm-Message-State: AOJu0YyR2SbeznwUOj7E23ANlrnPQHfRZXtvNdu0z0b6ayJmRoJKWVmS
	q89AwiJ9ahzljQFKON03pzrDjcSMXKL2BWRFi7kQLsz/ZQQ53qYzw2QKaNW3f7k1gMTb0qHZ8oi
	H5On5Y+QlJ9Kmh9eEyRa4eFjPS2Nr/EE+YVNC8AY24yoi6mBmOLRerbXnwPqJnBq5iy+14Q==
X-Gm-Gg: Acq92OEJ7F2KZhqPbj6gtUwDnTqIu5lHWK5Iwj3UEeT2YxgySqB8H/5jUa+anqnS0An
	cKTiVUPHS9PVUM5WBPserg+fVV+9Tn3zxHLzTkWE8lnjpuFQZQxxjlvR+n46xYV0AQgpqFYbTUM
	4RtCg9byI4BFAffAEKOgL/89IP191NZnCrtYslbCTBLKPEmYLuS9CLZ2qm5FJ2SqM1htWcI3fg2
	ievl9TW/Jrl2WMeVnsrqUStLNi1Mhswp1rYBlQy4jnpO/sPjd9UTLXbFP2VTkDVHstVkYp0uYj+
	wVkwM6zAWIfIqWqKcyf4yYNtCxFggET5xOdHz9DosWZviMwrmrol8y5azPCRHyYGKWiirJi32hu
	0U4g/VuhooSMgEm3I2wou308NO3mjXgG/DTMwuoNG6hC+KF3SsDx9195iVoI3kzgBqtBV7G7+zc
	aBcNUGc+0xkXQ=
X-Received: by 2002:a05:7022:426:b0:136:bb14:b0f8 with SMTP id a92af1059eb24-13807d18667mr10674368c88.5.1781061244263;
        Tue, 09 Jun 2026 20:14:04 -0700 (PDT)
X-Received: by 2002:a05:7022:426:b0:136:bb14:b0f8 with SMTP id a92af1059eb24-13807d18667mr10674359c88.5.1781061243770;
        Tue, 09 Jun 2026 20:14:03 -0700 (PDT)
Received: from hu-yintang-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f54c9c12sm17279534c88.6.2026.06.09.20.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 20:14:03 -0700 (PDT)
From: Yingying Tang <yingying.tang@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, yintang@qti.qualcomm.com,
        yingying.tang@oss.qualcomm.com
Subject: [PATCH ath-next] wifi: ath12k: change MAC buffer ring size to 4096
Date: Tue,  9 Jun 2026 20:13:58 -0700
Message-ID: <20260610031358.2043716-1-yingying.tang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H+DrBeYi c=1 sm=1 tr=0 ts=6a28d67d cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=6UE3-6daUtQSQB2Os-YA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDAyOCBTYWx0ZWRfX8+FDdRnw1hLM
 oorq2VmP0CzmEnyf4909icOJqTnkdhFPW982ecxZYyMaemxvazw2IaVq6Q6rcGSN0n29/DOeYUu
 xT7mP0FyX2XZInhLdbT2DFdoUTbE3eYIj+BeZrN6FyBZGvoPNtwy30dl9qLaYGBnnZleYfuDDFv
 Nnj/CS9JJGdHrX/khzUfZxqJ14VP5rFHn2pXB+S0Sbr+7Iv0kBMR9w6TLwUgx0qm7lSS76/nvQ7
 bIN0sptaWhzNSzrjyheQ+KLqEaR7I7HIxQiNSQXPXiPSWnjmcnDMT1yvrB24v31sekMcPESvbgm
 bl/WoUS7kutedBNxkdgtyUWxD4rCdNhEN0e9hYPe2Av1evJnw6mle3DCrbR2spb/HpGoNGmSKrD
 cDAsFdA2VckItZx4vTfVlOO8GlBcH9iqSTQlTJ0xgzxLZCWdAoT8/KeI5w5BclaqH5vEUjCksB/
 QOUEopzm+6sx51QFpJQ==
X-Proofpoint-ORIG-GUID: uq2KawZXXmpn6mGqBBnnLp1yxALoo9vC
X-Proofpoint-GUID: uq2KawZXXmpn6mGqBBnnLp1yxALoo9vC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1011 adultscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100028
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37606-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:yintang@qti.qualcomm.com,m:yingying.tang@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[yingying.tang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yingying.tang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 61651665944

For WCN7850, MAC buffer ring size is updated to 2048 in
955df16f2a4c3 ("wifi: ath12k: change MAC buffer ring size to 2048")
to increase peak throughput.

But during the RX process, a phenomenon can still be observed where
the throughput drops by about 30% from its peak value and then recovers,
and this behavior repeats during RX.

After increasing MAC buffer ring size to 4096, the data rate drop has
gone.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Yingying Tang <yingying.tang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index f8cfc7bb29dd..6596089d4168 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -205,7 +205,7 @@ struct ath12k_pdev_dp {
 #define DP_REO_CMD_RING_SIZE		256
 #define DP_REO_STATUS_RING_SIZE		2048
 #define DP_RXDMA_BUF_RING_SIZE		4096
-#define DP_RX_MAC_BUF_RING_SIZE		2048
+#define DP_RX_MAC_BUF_RING_SIZE		4096
 #define DP_RXDMA_REFILL_RING_SIZE	2048
 #define DP_RXDMA_ERR_DST_RING_SIZE	1024
 #define DP_RXDMA_MON_STATUS_RING_SIZE	1024
-- 
base-commit: ff49eba595df500e4ddccc593088c8a4ab5f2c27

