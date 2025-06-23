Return-Path: <linux-wireless+bounces-24333-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B3DAE3443
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 06:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CACFD7A26DB
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 04:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6024D24B28;
	Mon, 23 Jun 2025 04:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HuSINB3T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5A32FB2
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 04:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750652349; cv=none; b=BRqXrJNeqyxToYvIBeW99hcg1VWoBO2Lf2yOULbGmrhQPVXKXGjrR6GDgU5MzPVcSw4Gu2u/qOebjyK6efWpZ0hvozXl7jZREE0YPk+76+A0qJwir2v+xA3UcycK3cnXRQbgtd5pOhrusGCly6LF8Mdyq3sur8UZogyphRHNtTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750652349; c=relaxed/simple;
	bh=mb07Bn24ei2zt5v6XueHjGiQbKF2rH5FnYy/VNk8Tcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z25VFocqyK8yMC1DPN59i4kyg95wh8q1CUBa8O8XLZakwSgMPMOXarYnEyQyoEiHDq/Xnp4u8Fo02Z3PHLUD6A626p62tK5W5SyXwlZJzlhvmpb1ow/qXc0yEyLtlUAk28iS15V12rWyLMupO/0sB1Dq1R/pbJ7M439SCJIpCik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HuSINB3T; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55MNJECI012662;
	Mon, 23 Jun 2025 04:19:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oL6nG8GOX8cSTgKalYLdEe0t5pO20ymiGwKegnv5//M=; b=HuSINB3TjyObcyuR
	RcmZZe2p1YEZNx5eT8Xk3zpXQsmFYyrJ/2qfVdbgTc5Tl9ozTgFoqusKAR8ZUq73
	mZ9QaAPqToCVIHLx7oX3aBW4Gvf2cv0xUuwmSfGr3V/+Vt0wmlzY1AoSmcRIQjFv
	FwsQzS6tIS7OKoN1wPw0lZLHaih/DW2rz6/CI9ONfgn05NoBgNjLbFc0rqVUEsmS
	5llilajrTEEym6aaTiL5yaaehwvss00gz2Rf9eaQF9LJR0+i8V9VU9nEkgq+8/kJ
	6XmpQQEOD31L/P0MZcH0Ikt+vA3nDVXd5l6kw5kX9GHZX9ebQy4viL0zafqPHyse
	9ruPZg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47eud08ehx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 04:19:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55N4J3h6020701
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 04:19:03 GMT
Received: from [10.216.31.112] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 22 Jun
 2025 21:19:01 -0700
Message-ID: <783d66a9-1d06-a068-7650-2a58c4023164@quicinc.com>
Date: Mon, 23 Jun 2025 09:48:58 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath12k: Decrement TID on RX peer frag
 setup error handling
Content-Language: en-US
To: Sarika Sharma <quic_sarishar@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Kathirvel
	<quic_kathirve@quicinc.com>
References: <20250526034713.712592-1-quic_sarishar@quicinc.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250526034713.712592-1-quic_sarishar@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 75mA3c7xbhm0reUAnqyphYI6b-_hxOg-
X-Proofpoint-ORIG-GUID: 75mA3c7xbhm0reUAnqyphYI6b-_hxOg-
X-Authority-Analysis: v=2.4 cv=eco9f6EH c=1 sm=1 tr=0 ts=6858d5b8 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=BsdNM8JOicQgXtT25-8A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDAyMiBTYWx0ZWRfXwDN2mCqFGKIO
 Icu1ocds0JBkS2Q6vx5Tc8uotjgTeB8wo8XtdUbBLCiFm5wL5fSAFibVOpWDhAuKiUgKz7cPsPu
 rKEjDKm/pfEdzSBTBjSCi4g+N3QNTJwLQjHcLb82oWGg9Q4yBVXKDk4v9y14q/2bG1K+D1hFyUA
 L75WACoNCLsp5a5NwwmkHnq7Iu3YKliJjd+5ku5ELNKAMCgP0MWukd1ioQUSOtxb9nXu8yKBywg
 6qXTEUoqGWnMXkZhcYgPf+mHG5qEckFCQZrqc03+lKQoRJw6HEVAPJ59siIPThy9VZUc8bywpIT
 Vj3lnvAOJ/jHBNh3V4Tuucd/ALNt9AneZ1MkWoCHfUg/KGQUq1K/W/QRWSlaoGjcexg1nDqIT/Q
 9Jbf0ysjaZV8QLQ9g2g24bpZvKsqtyAEX6hBwn5vtDaO6rV0PDGC2VYANiR6QA8uhl1hW03h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_01,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0 adultscore=0 clxscore=1015 mlxlogscore=513
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230022



On 5/26/2025 9:17 AM, Sarika Sharma wrote:
> From: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
> 
> Currently, TID is not decremented before peer cleanup, during error
> handling path of ath12k_dp_rx_peer_frag_setup(). This could lead to
> out-of-bounds access in peer->rx_tid[].
> 
> Hence, add a decrement operation for TID, before peer cleanup to
> ensures proper cleanup and prevents out-of-bounds access issues when
> the RX peer frag setup fails.
> 
> Found during code review. Compile tested only.
> 
> Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
> Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

