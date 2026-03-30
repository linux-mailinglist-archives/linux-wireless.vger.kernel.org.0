Return-Path: <linux-wireless+bounces-34196-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIpvKorgymnEAwYAu9opvQ
	(envelope-from <linux-wireless+bounces-34196-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 22:43:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCD136117F
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 22:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E436306A1E3
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 20:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B433A16A4;
	Mon, 30 Mar 2026 20:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nnC6omH7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xga4U1I/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262EE397688
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 20:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774903171; cv=none; b=lIYQ+GES5XEFn0dd2qBgfdvdaRs5tHcyASjagFDNp1NFI2R2vYfNTZkRvIRJAPIkFOTgkq0A3cmY/x+59TApCogAyAYig9l//Lw7ytQ4ERNtYfzJ0wmpW6VTZb+x08bRZxkYmtSXmNnk5wl/eENI6f0O5gYjHV5ufm1gjn6SjnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774903171; c=relaxed/simple;
	bh=4qfqDIpl9+i1jdlyMFnMeF5YaTgLpAL85qTp0ms9CR4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mbCmqf4mKoKTFglJlqklXumeXLaIwUvZrMJp843gSCCVSfjTLOYiLqI1KFgVOkPWP+lmjHMEZYKjY+1Oac+gHRaVknf3QlEtesYjIk3xsnkeKMk9wfTLDPNHmkRnT0yf8h1GpFX4h+fHiTuuH4f2QRI903iWID4jDhqV9R/BTqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nnC6omH7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xga4U1I/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UGWI311402784
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 20:39:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h0IyBeCS0RIC8L0kumGdv7nrT1SM/aWdVx2fCYERunk=; b=nnC6omH7DK8rffr4
	JJvweljcHOHD8MqehQadaB9avOrHpGUe88uyhfDs5RgN9P85k6WIQpKjNhXqU2iQ
	OxmJwXuzGpe7dtMz7qyfpPrZvRU2MAMnSVeJWy7fF3V2LYumyZs8WtSbVc18hgee
	NV9p7VPiKmzCVh8o+VK3ts5p5mGToGMbeoD5JV9G8zI2QBlDEkMdo3j5Y2MUOhax
	wsd6tcz8nEQbaAmFvZo0cNXKL1P7c8zTQQNsmqWjcO13TLXsah7HEl7QSxREE+Pf
	XcrXJ/FI1tZfl/2M1N9czU5Rl/v026/k8aotYP7/TlbNjLEn2/o7YsrTsd0DqVjJ
	0u4rPA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7r4haa3f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 20:39:28 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b0c96f5d9aso52920475ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 13:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774903168; x=1775507968; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h0IyBeCS0RIC8L0kumGdv7nrT1SM/aWdVx2fCYERunk=;
        b=Xga4U1I/xczo5kpHOduPLudX1Qp/xbqtVzPF/XpWdTcLhPIAOzj///fPA+mUCKj/4J
         QhFUlEimTYsBilDyX0tKggOxD69F2oi7nRiyg/gXb0HkxxzQimi0ExDrYgTObOnNFgA6
         EiVyJLV9OhnNtyR/i8Zrti4DnMh8Mg8o4QzPNVgzNhip25hNLn1zzdGlLg/u2YgJRW97
         llrV5OvBNPF5X/5NRDr+b//bTHTfbrx1K1Jm/9SQXGfo8ULJ/r+jDR/9pdxr1UkAaoW1
         +WZ2UTX/LWaEaRFFDAXZN0UBdsBx6SESkiRFwyw6MQkqkrqHgKSqeBHdzjoy6wCO+bMN
         aw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774903168; x=1775507968;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h0IyBeCS0RIC8L0kumGdv7nrT1SM/aWdVx2fCYERunk=;
        b=sPpgd72R5eNcz6TGHj/nNDa+6UtWkyfFldDDk9Obi1OPqs54+LVMW1ErGqGwswHOnE
         zDJDqyDZgNR7G+beJQBkL22LbtDG5yVCnZ8KKRkq5CZ4vK3gYS4fxnAM2aImEzd1/2TW
         5vL3U32y1+sepNLWwsIoel3tT2OJBNa+thf+b0kMVj7KOsSD4/Frv79UF8svEp4JFh6z
         FfY7G0WcdgneIROWCTkSn7Qj3QIurxU0dll1+BPIC2kFeL26+9fhhm1BSDfi84ny0uXJ
         6/N+TrVJ0BpEo4/7GGvPTFJnLUOPhnyOl7dSaHhq6vkgwp3sj1nz0iRkodkFpKbaEVQP
         PAew==
X-Gm-Message-State: AOJu0Yy/VWgPnjrJYkvqMZDhObEK8Tf6FWeQPz0Dx8GCN9DtEoEmIQ0f
	+vq3K0qac74vuWPCUgAY832JFe4q85UlAmCEierN3zdwKH4bvFaPPcBriH02SA4WtUUR63bYX0N
	OTubLGUYPx/8HbpS+tfQHAuPn5diMhm5r7xZCIWcHfVonT5k/J/tvZEiekde/kcce4xNwFnunEo
	sqLQ==
X-Gm-Gg: ATEYQzxEtW8nJyyuqAbq+CWoNFCfMEC98UFdZJ7d3ZAz9+yF6QevK+cnmnk8uuMi3rJ
	Pb3k4MdPUQnLFXWRXk9OYXlO/hZQQDYq6mJrqIEBVanmt3Kanw0MiSn2D+MOf/2i2r267J/8jmb
	AvZp6gFXBsWU2jRy67La7qLsiHOtFws4QCImW40tohzALKkG5kpIOE7yyIGbx/NRiJu37dHaVY9
	kI27faOfNWMcuKdulc5Pm9eaNpLTN3ypE2Fp+FTRuApfS1pnEf8QGab4Lnv0nUo06dTfHHlI26N
	drMpmbjgifuv1IVWnFLtp4HVfqnecrJLOh/9C7Y8QcyHWsvkwxTf1cmjvFCyEcUUyOWiJKLOL3m
	O9QcQ7vUV1ihjvT5J5rdrJ+cNG0uRkGr//gfH5pMhDEmAKjNS2/7T4PY3x1kLOGM7B+eiMHlRmb
	Ci9rrmOQJRGIV+YA5mweNYal+8eYPPFwzB/SEM44Y=
X-Received: by 2002:a17:902:e541:b0:2b0:5795:9ead with SMTP id d9443c01a7336-2b0cd9eee9amr146049835ad.0.1774903167702;
        Mon, 30 Mar 2026 13:39:27 -0700 (PDT)
X-Received: by 2002:a17:902:e541:b0:2b0:5795:9ead with SMTP id d9443c01a7336-2b0cd9eee9amr146049495ad.0.1774903167179;
        Mon, 30 Mar 2026 13:39:27 -0700 (PDT)
Received: from hu-rajkbhag-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427c3a4esm113517195ad.78.2026.03.30.13.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 13:39:26 -0700 (PDT)
From: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 02:09:08 +0530
Subject: [PATCH ath-next v3 3/6] wifi: ath12k: add ath12k_hw_version_map
 entry for IPQ5424
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-ath12k-ipq5424-v3-3-1455b9cae29c@oss.qualcomm.com>
References: <20260331-ath12k-ipq5424-v3-0-1455b9cae29c@oss.qualcomm.com>
In-Reply-To: <20260331-ath12k-ipq5424-v3-0-1455b9cae29c@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath12k@lists.infradead.org,
        Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE3NCBTYWx0ZWRfXzCj3ylp03Ece
 cR+lyoZHrrmYwVJTzEOtqLx3nO5Ax6ccZiKAc3qK/r+q3lUlM4YqOF2t0zsLO+TjBzQMFTDftmE
 nY1Cdjil4SFOjbICiGhHUy6OA3wgZIeEWZWCKzv1IO1tJYMIhm360MIRK6vEwo5rUVMsKTxy4dW
 1P4LFUaoxQvBtBNQ1BAtHiZc8xgppoJopdwtz9W9w+DsyLjWMwiq2+XE/8Q5WiGP6N7u+9tPwMO
 yGHJk0FDBSQRxGIvEWqHrtzozT0pGzdqTqimxFqr0MSPTqtc3+Lwtrl8CuuKNToiVB/w2CvGTWF
 CYEYJJqcHV0tn8POGXBMAGk3atRPBhe1MpVzrQfKLFrr/kngHX9RzoYnF7IYuqBJ8x4EHuwYFy0
 tR3e4Jt2BtdqiyUMVI+XHenfizgxOBwvV/6lsH9R06STI2PwG+k5ywe1qc04IDutAzZt0+C2gei
 86a77TULdVGorCDG4gw==
X-Proofpoint-ORIG-GUID: k2YgszwAzWjT9rYvs05YPJRhvOeY-gPA
X-Authority-Analysis: v=2.4 cv=PI0COPqC c=1 sm=1 tr=0 ts=69cadf80 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=V2VgLR5doq-8DBhT5hEA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: k2YgszwAzWjT9rYvs05YPJRhvOeY-gPA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300174
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34196-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raj.bhagat@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1FCD136117F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a new ath12k_hw_version_map entry for the AHB based WiFi 7 device
IPQ5424.

Reuse most of the ath12k_hw_version_map fields such as hal_ops,
hal_desc_sz, tcl_to_wbm_rbm_map, and hal_params from IPQ5332. The
register addresses differ on IPQ5424, hence set hw_regs temporarily
to NULL and populated it in a subsequent patch.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ5424 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1

Signed-off-by: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wifi7/hal.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal.c b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
index bd1753ca0db6..c2cc99a83f09 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
@@ -50,6 +50,13 @@ static const struct ath12k_hw_version_map ath12k_wifi7_hw_ver_map[] = {
 		.hal_params = &ath12k_hw_hal_params_wcn7850,
 		.hw_regs = &qcc2072_regs,
 	},
+	[ATH12K_HW_IPQ5424_HW10] = {
+		.hal_ops = &hal_qcn9274_ops,
+		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9274_compact),
+		.tcl_to_wbm_rbm_map = ath12k_hal_tcl_to_wbm_rbm_map_qcn9274,
+		.hal_params = &ath12k_hw_hal_params_ipq5332,
+		.hw_regs = NULL,
+	},
 };
 
 int ath12k_wifi7_hal_init(struct ath12k_base *ab)

-- 
2.34.1


