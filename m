Return-Path: <linux-wireless+bounces-25491-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4BAB06447
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 18:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0CB05824B0
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 16:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6293B277CBD;
	Tue, 15 Jul 2025 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ajk7F4Ms"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE18D1E531
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752596650; cv=none; b=HpuQErkIwx15MQyjAkS5a20FUjDy7Kn96CqbCS8MBmmffPag9za1OOtE/CfK0ASvfz3F+5On93R1pP6EnyJei+1vt5Te1OZkw7wbtojP6qbe7umtXNRgM5Piu6oXK0pbSr8by4j3m6zGz1jNdChuccOazD2Yw88RrUfvzBWHZfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752596650; c=relaxed/simple;
	bh=gVyrwjeX+GMTim1SYTNo5MWJmeBUeHv17LOSoqI6Bh0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=exOgZZysdRZUb6DY/Z5ZgWqoNuheVpoPOSz1qbzTp3+DcLMTA3PblO1PRHHSE2aIbSNJVTiit5o1ODDnyOgIERzyVyNsMG+EmHqztDpEx34A8n/7LCbE8cIV+J+j98XaHYLsGPPJIdVBQgyFUeZrA+XN2ye4/LgiMRRLAWZMiFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ajk7F4Ms; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FGDIXp024685
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 16:24:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n83EQ6KplxBdN8niFuzxAF76NZhTqT2FpXssYODZebc=; b=Ajk7F4MsTpPv28NI
	EKNfV3u7ji1pukri8imGRTnpfTrtxHCNfRt8D4ZXwnbfstmWj1nlaIHB2EHBhKYd
	sTZFdAnwl0Q2C1Ed5SEUbFTz4UXoGjoTHJw1Wp4M6DTzL6fmsOrNnK1iMmt4qio1
	Pc/2LacsFH6ComtRsrJgkaSqiSwl5jU5GYEmlJbFIZJI7zSFOXMO/JcuE4YQsgAp
	geK+orQ6D2bXm1uegFJAut9GA0PXQEuhGtfGoXjl3J9kBVShE+5jPaCC9ljyenGO
	DVX5JWnFp+4vY1OuwmDkIT1OO6Lvh5IOuOjGK9IHg/azeF6Yz8qc5GOC/epfNHz4
	dbOssQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dpbu46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 16:24:07 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-74928291bc3so4877779b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 09:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752596647; x=1753201447;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n83EQ6KplxBdN8niFuzxAF76NZhTqT2FpXssYODZebc=;
        b=cntqb4XLgPSjkpL0bH1gV8mWaQCsYX7nYzJvQjKpqCh05m5ZAqkX0AYuSucJkLlCtj
         p2Eguw6cs3M+C/qp+QolRBPD9fk5sVDpO7Qh+JUbLVJQDfP91IKurl9UGzuvbkRu4pEh
         B2I00CFGXmQnJIJ4OKxdptu4IKuHZpFmYochDz9+l7mLflGJW5sFK2A/vWMPs8obWU8u
         OJ6aoQPefoiTqcvWcr/xGhN86SL/vNQLpNrl9DfpxJnq+3UM+Uu+VEPnILlmDEKcWCuT
         cSo1sG+Nz7BgwaRvkXAAwADbhjqVhQQMiA/OeH4cnSgsH/UbMLLAC0PtV1MvOcplARC1
         5qMQ==
X-Gm-Message-State: AOJu0Yy0wnXLnL7HNuxzfSF/+c4mXsz1Y8EjnBGxQcbNJ/pCOoGSxboJ
	76mTydTgLou/wvXF+lfUajRNGJSHqHl/uvWsmSTWTUEsTANf9Mxr+UhRuYkKkDR3Db9Q6hzeKwM
	uCP+jM245UnGyGBHLO/OhGU/Ful6QoksJYgoBHh3D9jRlrGBydOq/2qU35PV7iJKfiIy/4BETBI
	Mc0w==
X-Gm-Gg: ASbGncsXdA9fTCspg4XZj5fwGT7ljobHWCS8ofgyM/e1mr/x0pGC0NjtzVJPYwKZh8U
	gOQW//OZN+P4g+gP+Dodz8ecOjwIthjypV1SZiz+o8wqA1LUplTXo7VSAi+U3UhDT6NIg3xqHmJ
	UJTPRdyziOV2ItmbB5twDecA9796QUFCo9UTzSF1rLuTlBGN2V45Y//4IS7fxdJY++iXQC4E16A
	ZLcb5xi0KXyGD4TWirQon5MJP0O+xUsrrPiz8vfzBNZWea9Wb7B2RnyIGuFiv0Dk34ho0d+br8b
	DJhc2Dv2aIzFE88ZtwSDEP3LP7ZytZZSHrSG3rID9Nn42Chw9xaagLh7W0PTRvhIPQOo4jzRyAC
	U
X-Received: by 2002:a05:6a21:329b:b0:237:c17f:9813 with SMTP id adf61e73a8af0-237c17f98ffmr383773637.28.1752596646669;
        Tue, 15 Jul 2025 09:24:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9yxvqSV+l3b7v266rmFhGhvhLcbbc/QTVLpv+MDVZbF7ryPH1BRcAqtw3C6RkWgrW/KDJrQ==
X-Received: by 2002:a05:6a21:329b:b0:237:c17f:9813 with SMTP id adf61e73a8af0-237c17f98ffmr383741637.28.1752596646210;
        Tue, 15 Jul 2025 09:24:06 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1b715sm12815373b3a.93.2025.07.15.09.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 09:24:05 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Nagarajan Maran <nagarajan.maran@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, Sriram R <quic_srirrama@quicinc.com>
In-Reply-To: <20250714111438.1134438-1-nagarajan.maran@oss.qualcomm.com>
References: <20250714111438.1134438-1-nagarajan.maran@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v2] wifi: ath12k: Validate peer_id before
 searching for peer
Message-Id: <175259664470.3448282.10740985705944149227.b4-ty@oss.qualcomm.com>
Date: Tue, 15 Jul 2025 09:24:04 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE1MCBTYWx0ZWRfXzbqsGC0JlgDe
 nqlnaBclbbu66wiA+MXhk7OVBdhiWcIuF6mrDzqjANCJuAzPubQcWN4Yunghms6B19KgQFupDdP
 VQquHtqnQOKDmK+AJNhBzNHJLh1Wodrt5JazTruNubhLoXbmhsz5o2tk9+OE8rZWy0IV4j6gaJD
 yVCI7z/Ms4yHugTkOuttNefprrI1FLpZyGzDF6/f1NRDy4NYXrrmXOZwHwj0lLrGXkDsU0vbuAJ
 Cv+du/2vCsw8S2dkG/sAlGdYhSDo7y+8YTjzq0Ej09WTjsmfptrJKxC9xH7h1xk82hSzniORRg1
 hPSrc63QdFOLk03+EelCYsWv+FSP2kHxXkh5yPE6pa+cDYEmEUJwGESjvp0myKb4aGAqHUpYg16
 QS1vgq78Wg1efBPP1eJeHYo1UkxAWt5BAl/kU/eMRF5PDjyPR4iE5FTqG87mtkLOgYbY2TJh
X-Proofpoint-GUID: kkYPzv0-24nq1QhN5E-BKCmDTxaV68Q0
X-Proofpoint-ORIG-GUID: kkYPzv0-24nq1QhN5E-BKCmDTxaV68Q0
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=687680a7 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=o3kOZhjVV3aoIho8ZNQA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=656 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150150


On Mon, 14 Jul 2025 16:44:38 +0530, Nagarajan Maran wrote:
> In RX WBM error path, error packet is received with invalid
> peer_id (0x3FFF) as there is no peer associated with that packet.
> However, this invalid peer_id coincides with the ML peer_id valid
> bit mask, causing an unnecessary search in the ML peer list.
> 
> Prevent searching the peer list for invalid peer_id and return NULL.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Validate peer_id before searching for peer
      commit: 136aad17e14250c815dcfc2e3cf9926e763b7436

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


