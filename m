Return-Path: <linux-wireless+bounces-1505-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 179EE824671
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jan 2024 17:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76861F21D58
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jan 2024 16:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D8E250FE;
	Thu,  4 Jan 2024 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RJB4Vv0T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9A0250F2
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jan 2024 16:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 404DhCAo030989;
	Thu, 4 Jan 2024 16:38:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=725xWrXyb9AEsIa2JUrisQww8XUSBvF31V7Coo8VDbo=; b=RJ
	B4Vv0TmVrMz+0h00lGOm8INXdNALmQLzeJqM4OyHOOxtB+gUxO8z5SHktK2V8z34
	yzLfFyvFdi6ki61GncQgnJdFKbsMMLjfhGUZ6ZoEsVSYC43n0TuDN+GgijP6ydCJ
	jP7/n82e5NZOzZu/JCCB4ow+X5BSO7M9QyHSqUpTMpJlDza0d+pnerqKg4tmNsp3
	n5IjgKN1xFRmL0c80za/RLBC4iTr0qnAX3cFAk9Gl87S5mF1By0JVio3jKTHos/C
	SyAiKzdQqwVeLu6SseFst1U0paRpz8jW2G0D0hw63L7VjGZEhVucYnKseNYy3zpv
	cxZ4exSRBgKbTAVTd/7A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vdsams72w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 16:38:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 404GcaQK005358
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Jan 2024 16:38:36 GMT
Received: from [10.110.76.17] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 4 Jan
 2024 08:38:36 -0800
Message-ID: <5c853e8f-f7df-408f-b520-76eaa4fa436e@quicinc.com>
Date: Thu, 4 Jan 2024 08:38:35 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] wifi: ath: replace ENOTSUPP with EOPNOTSUPP
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>, <ath11k@lists.infradead.org>,
        <ath10k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240104031509.366302-1-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240104031509.366302-1-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vwhDW2pZALrk7aFCkVFSaf1YxJLQ2vMX
X-Proofpoint-ORIG-GUID: vwhDW2pZALrk7aFCkVFSaf1YxJLQ2vMX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 phishscore=0 mlxscore=0 mlxlogscore=620 suspectscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401040131

On 1/3/2024 7:15 PM, Karthikeyan Periyasamy wrote:
> ENOTSUPP is not a standard error code, don't use it. Replace with
> EOPNOTSUPP instead.
> 
> No functional changes, compile tested only.
> 

I would have expected a changelog for v2

But no need to resend as a result of the missing changelog since it is
trivial

> Karthikeyan Periyasamy (3):
>   wifi: ath12k: replace ENOTSUPP with EOPNOTSUPP
>   wifi: ath11k: replace ENOTSUPP with EOPNOTSUPP
>   wifi: ath10k: replace ENOTSUPP with EOPNOTSUPP
> 
>  drivers/net/wireless/ath/ath10k/core.c    |  4 ++--
>  drivers/net/wireless/ath/ath10k/htt.c     |  3 ++-
>  drivers/net/wireless/ath/ath10k/mac.c     |  6 +++---
>  drivers/net/wireless/ath/ath10k/pci.c     | 10 +++++-----
>  drivers/net/wireless/ath/ath10k/wmi-tlv.c |  7 ++++---
>  drivers/net/wireless/ath/ath10k/wmi.c     | 12 ++++++------
>  drivers/net/wireless/ath/ath11k/dp_tx.c   |  6 +++---
>  drivers/net/wireless/ath/ath11k/hal_rx.c  |  4 ++--
>  drivers/net/wireless/ath/ath12k/dp_tx.c   |  6 +++---
>  drivers/net/wireless/ath/ath12k/hal_rx.c  |  4 ++--
>  drivers/net/wireless/ath/ath12k/mac.c     | 10 +++++-----
>  11 files changed, 37 insertions(+), 35 deletions(-)
> 
> 
> base-commit: 2cd4e3f91f264926a6b11df948417b74d52ca9b9


