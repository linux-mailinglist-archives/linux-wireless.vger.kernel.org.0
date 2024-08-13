Return-Path: <linux-wireless+bounces-11372-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3624950C81
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 20:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 533DB1F230B3
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 18:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56BE1A0B06;
	Tue, 13 Aug 2024 18:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DoSsgHh+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198971BF53
	for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 18:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723574966; cv=none; b=C7997cWqj3LqlvGKyOrNdKSMz50i6N/3gIgdkTE3XfevH5yVkITN2MSYdBiWZRAIwRw1RX6yokIU+4H5Nz5S+CsA5UAHQ7HW884uJ0msqLX0PFy2MlnZbdtycCF+NDIn2exVvZRz2SV6MzSsQnBUMMyR0kACiK6u4rlhzfFhCgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723574966; c=relaxed/simple;
	bh=ade7zht6zyDgUSNPQO+BUPUCZnYqW2Te1Y+1SiK3Kno=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l9V0GCIUeDeYH9FeZMVi+yHphkgkIEycEfS91sztuQDTCAPHmFg2uefB4fjvw26yWQDOI95+Fa22+VLPcCHQhznejcCQGwwJo4edcdvXg8RaNEb97Zz9EuAXGFssac2S2Y+oOp9p0cub4ZSRpi9U3ise6C5erEoHrMQnICcA67U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DoSsgHh+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DBUuvo019383;
	Tue, 13 Aug 2024 18:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	18WA+z47Bl5MtV+s9lN9wU7l+iEIu5pbfYG4fsZTpoo=; b=DoSsgHh+nSmZ9jHJ
	qhJFvbAl7ZA2qsn61eJ0BjnuKqpA+bqp/e2sQigsYaw2xz4IRehSirlONg7WmUPB
	6ZEbfP6Rop4PYqkNISMOVzP0mKM9P4Yl0yNtdH/5t8KAxdoPX9Zrz4AIEP2VP538
	394Y2P9wRjpPJlBYDLNvANgY3GlX9+XjhSagbMYjB2VnJc1Xm8ekDW39mgQLSvRs
	itsSxHnassxyzk0HlDCXaPXwDtAPt7DRejBx6qa1iIfUTqplGom3QF3BLAIf1GmV
	8zgUbbOZrlsKtBmdw3dN6QsiW9qq/VqYZjwc+mJJq2wS0lKitYHY7uy6U6Ya0g7c
	hguDqA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40x1d4gu1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 18:49:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47DInIdT018082
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 18:49:18 GMT
Received: from [10.111.178.117] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 13 Aug
 2024 11:49:18 -0700
Message-ID: <7febfda5-e735-4f91-b897-8cbd0f960d22@quicinc.com>
Date: Tue, 13 Aug 2024 11:49:17 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wireless-regdb: Add .b4-config
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, <linux-wireless@vger.kernel.org>
CC: Chen-Yu Tsai <wens@kernel.org>
References: <20240813-workflow-v1-0-3f63f0ea9d5f@flygoat.com>
 <20240813-workflow-v1-2-3f63f0ea9d5f@flygoat.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240813-workflow-v1-2-3f63f0ea9d5f@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: d9_hBGQ-yVCYplQx_hR4C6Fyu8v2oqip
X-Proofpoint-GUID: d9_hBGQ-yVCYplQx_hR4C6Fyu8v2oqip
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_09,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=404
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408130136

On 8/13/2024 8:38 AM, Jiaxun Yang wrote:
> Add .b4-config to provide default email To / Cc address.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  .b4-config | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/.b4-config b/.b4-config
> new file mode 100644
> index 000000000000..b9178abe3900
> --- /dev/null
> +++ b/.b4-config
> @@ -0,0 +1,5 @@
> +# Configuration for the `b4` tool
> +# See https://b4.docs.kernel.org/en/latest/config.html
> +[b4]
> +    send-series-to = linux-wireless@vger.kernel.org
> +    send-series-cc = Chen-Yu Tsai <wens@kernel.org>
> 
Normally you send to the maintainers and cc the mailing lists
also missing CC: wireless-regdb@lists.infradead.org

