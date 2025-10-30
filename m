Return-Path: <linux-wireless+bounces-28407-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F4CC2021F
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 14:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C6494EAA7B
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 13:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC0435471E;
	Thu, 30 Oct 2025 13:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oxP8d/dA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c7adt7Ld"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F64B340DB8
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 13:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761829233; cv=none; b=BudBkRrus3v8ljBImhW5k95TRUQleok1tbnfVBKudx17Jh3UHOZJbjlsfxEBHJDbR1Ewnd2qbyVzratvkwlXFfbS80U5DaUi18U856hVLoqb+8aHdhnxA7pxVVkEJMCRGHEosOUN9b7ftsD8pBBc1ZjiQ8dyRKFQ0jPhYRVFeRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761829233; c=relaxed/simple;
	bh=FvEKukIb4FiRwnihOAFVCXG641tVZls3AwenpEiviq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQqZQnpzYFBfGA8JH/qaWi+NWyB0S5RudkFAdVns3LQC68Ur9ulwMKNc/3/byWm5dfv+Pv/Ge5vHS8F+F1D2ElN79m/rIs+rNj210mGuzxUTBf6a+XX1LKvKF5DNlYg6veAEi5Oyokw5Mq2eI9pvBcyftWi4DrxVmaDNll6qutE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oxP8d/dA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c7adt7Ld; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UB8fAL3808875
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 13:00:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=1RdG6M8abF2
	3iPRfGT5yGy3GEha7khLmMinYZRnghAg=; b=oxP8d/dAdHoMKvPnvbICpF7j9tP
	37Ncrgzjspz3/cIW2vSHaf6ye/tPH3DuqFiZRQ9rjr1en9ptMdb/ASuqaQy5vwze
	IbnOoVcpFd2N/ZBjqVwEDIx9E1mZhNET7YkqW8wCqxsSlm/6PaUahqOZ2qOcR1iY
	grMgyckmvQ7yuZ/s6GH0J1PDc2NaEaA72xPmaZE9EksCwJlzxyefBEhJuSyivcWq
	ewI78k2YtDXU74p2bMyKP6ABHy245WqaReGjx1Jk209G7L4w6rOKO4G+G0R39dNN
	jCdbhWE8pNpKGdwGz3UhNvh2ZUYsd6mlXAHFzqwCjJJoOYUbQVm7Yk2SF9A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a46vv88xf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 13:00:30 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7a440d38452so1825522b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 06:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761829230; x=1762434030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RdG6M8abF23iPRfGT5yGy3GEha7khLmMinYZRnghAg=;
        b=c7adt7LdoA/mlz5JCVsxtXQd7epS2UG5sfuVHHV+0NDEMFk/cUuCxuOcJrUdv5SXzU
         Qgmkv1IxNizEz3j8wEG2EjbXLxV2l04D8gsucfKjbDxwARb8oEyNNazUUV1OxqQVTevP
         BrRA4zYjetewWS/CGFmxfng39pS4k8dU2wW3gqWmqG3pVSxdWcWFx8pwlOAJPnna5ASe
         OxXB1jxBUyO5lYPX+NH2UEdHLb7NB+TbxJZGOqxRUeF5OX4A+96ozbjoML4gLufTw8MH
         Cd71XBTvYLqjJIwF4yP+lKSPt5CPoUpzKRcMXNuZU8C04V3BzvQwaKpFaAX4fjvthDv0
         o/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761829230; x=1762434030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1RdG6M8abF23iPRfGT5yGy3GEha7khLmMinYZRnghAg=;
        b=t32kyftIqxAZ1DAhQM1wgFn/9g5uELYzYOUr4v+wGZQhbYJ2UKmxp8d6g85qdPpWBS
         ghF+fjS+hlJEspMara2BDLDARSp52P8ULZfvzQwy6iDZTBGNKSUURQ1eDJ1nwjf/UxN4
         pyLVZNA1RdxVT06E+lE3Du9JNQP1QfIrS/z0UdnfpKvFpNinNJCsqzI2LDq715/J4CG+
         XwOMUaQITRA5KGg667eH9tunqvnd/WMwhhQ6EtuYf8hnxWjMms/IB1gC46PgX5/iHXTu
         F/RpUu1vj2w+CQY9Y2nUeTnY8G8zSIfaIacFl0k8AcD1SpKxw4QXX412g+Fl2YMoSuiG
         NsSg==
X-Forwarded-Encrypted: i=1; AJvYcCX4j2x+R01QbgZg3nr5zyD8VDmQoUs2FKnEZuQWY9+oIcZA0OVexFHLqiwdhPAOHCbcsyr4GKiQDrDXDQ74aA==@vger.kernel.org
X-Gm-Message-State: AOJu0YybzJBo0KjAxVZktqeyqFvM/FxwGS96/w3pAzdFbqJKJnkcRHlV
	e4FVGDQaSmbHzDsV+JOQutGNBwJvzlgK6x83Ur7Q5fNh7FY+ybclwpB8Zlfe87NOugOhDTYUK0m
	LfYuGbkUrX0PguC71QjxCR1F6IwsmKmdJlaEWp+FgIbdsiZMKpeiTN2Xq3rSnvcaEKeszeQ==
X-Gm-Gg: ASbGncuqypsECYm9kkb2aXK94uuDIZbx4RojVJsMdPgXCvYsxFV26VkwebnL4EX/xX9
	Ld1oMseqNZBSTF8OFBu6QN4unD+dqgGJlyczpZbf+bAlEiDG1tVnGLZYaw71Yjvh4XzxiafbucE
	mcl3ljeZfkskdrQJTcYMV6Ukp0ZAr3EvngVq9Hr+tMFb41spsHVhGP4nr2mrT2llJ8DOvKlHae7
	wtFcnnxY1sykGaALhO+6DUi3TyqWMZ0mTlStCqytBikeMc9uOtFCirvfl4BI7mudmaRImflmaIr
	CAYzv9WwfiG4cTURPxQzfSPmwHEego5AcOWrPVX5ymSUNwmuu+SaJJnhxHCQgJ4cQdTzHMuXmnk
	eswQGsxNdGIO6PHaR7dd1pkCRB0yQ34mn0LKtcFjab52a1SyFMauQrNj1EHdEaR06YA==
X-Received: by 2002:a05:6a00:1a8f:b0:792:5db2:73ac with SMTP id d2e1a72fcca58-7a4e2cf522cmr7753651b3a.7.1761829229972;
        Thu, 30 Oct 2025 06:00:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9q5eFnUbX2on4oyRbuZgTJQukoO2R9eFR8yg08lWKVG/A0tR4UZL3TCr+G2QedSkdx1dXyQ==
X-Received: by 2002:a05:6a00:1a8f:b0:792:5db2:73ac with SMTP id d2e1a72fcca58-7a4e2cf522cmr7753549b3a.7.1761829229152;
        Thu, 30 Oct 2025 06:00:29 -0700 (PDT)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414068addsm19078757b3a.44.2025.10.30.06.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 06:00:28 -0700 (PDT)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
Subject: [PATCH 1/2] wifi: ath10k: use = {} to initialize pm_qos_request instead of memset
Date: Thu, 30 Oct 2025 21:00:22 +0800
Message-ID: <20251030130023.1836808-2-zhongqiu.han@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030130023.1836808-1-zhongqiu.han@oss.qualcomm.com>
References: <20251030130023.1836808-1-zhongqiu.han@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: LcbKlZtFKewC1hBMP0s5HnM9DTHsVWsq
X-Authority-Analysis: v=2.4 cv=dK6rWeZb c=1 sm=1 tr=0 ts=6903616e cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=ZsA58p3M-7yRb83_00oA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: LcbKlZtFKewC1hBMP0s5HnM9DTHsVWsq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDEwNSBTYWx0ZWRfX0UFMjWHw6Ujq
 y0ccazWCFuWM2lsANKdNucfeFddYnaePd078O7HwgCk45eni/bZcy28X8XhVVk7Q8+k4tm5GRAN
 +5QbkSqrIpU3+oO8WXXVRdLlCs17SC4dL9H/W5drs0RwehJL6wVOlocG+MTIovrL2y/XStr1sSp
 vouIHbb2KlZdiOv9rv351cj9omUqB1b2jieTpOyNAxOyS4YJUQZjYzEqqDui1feM2+0rRDgyV+2
 gcRuM4fwm4WS8J3dw3ibsym4up+VKlCCsLwOLGUDkrcPWr8Qbye38bP41OHXut3SmZ+oVbD2lt7
 54NIohPqq9wJkSz4MZtgMItxGGsTRqtpnWXfEU9w87x+5KEt0FQC7nohwiQZmuHyIZC4fJ4lC2p
 bOkM41FfHsyK421ETqUGjXPjXOjnYA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 clxscore=1011 spamscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300105

Initialize the pm_qos_request structure using = {} instead of memset() in
ath10k_download_fw(). This ensures the structure is properly zeroed before
passing it to cpu_latency_qos_add_request(), and improves efficiency by
avoiding an explicit runtime memset.

Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath10k/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 9ae3595fb698..670c31a52a12 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -1186,7 +1186,7 @@ static int ath10k_download_fw(struct ath10k *ar)
 	u32 address, data_len;
 	const void *data;
 	int ret;
-	struct pm_qos_request latency_qos;
+	struct pm_qos_request latency_qos = {};
 
 	address = ar->hw_params.patch_load_addr;
 
@@ -1220,7 +1220,6 @@ static int ath10k_download_fw(struct ath10k *ar)
 			    ret);
 	}
 
-	memset(&latency_qos, 0, sizeof(latency_qos));
 	cpu_latency_qos_add_request(&latency_qos, 0);
 
 	ret = ath10k_bmi_fast_download(ar, address, data, data_len);
-- 
2.43.0


