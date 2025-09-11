Return-Path: <linux-wireless+bounces-27233-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A55B52616
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Sep 2025 03:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26CCF17DB4E
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Sep 2025 01:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F2D16DC28;
	Thu, 11 Sep 2025 01:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UEYAt3ZE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63C71C01
	for <linux-wireless@vger.kernel.org>; Thu, 11 Sep 2025 01:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757555529; cv=none; b=B8U2XGALg8TS3tf9mIrylo85zCv+8F++3zvgVQfX4KiqBh0Ne3AQT3BAYuKdMrZsauTYmMutNMHNFH+jPt3s+4vYwVAORBnm+JhhEvsrirQSIErytai7gF9ZkHLJH8blU/lQSxuYd0FgcUugMsT3zegisazdEcso1my5Z7qoL0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757555529; c=relaxed/simple;
	bh=Q59qeucLTh6z2g9kKjUKuodTcmmEz8Ds85mKc+BCmN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YKnr1JWReTsgcH+xOioQzEEMF6SZWhmmYNtus+oGEWW1fHwvs3AG6GbQu70a/KMp2sQNP9nmviyVic+rzpKLHRV1aBS8nvEuxtq4EPiGrVdww4VLPpIQd8zYTe8Rc/18n3iEyJ1z36+ORuAFfQjNG5xN6Zroy0xU3Wy3FokVPaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UEYAt3ZE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B1hr6T012081
	for <linux-wireless@vger.kernel.org>; Thu, 11 Sep 2025 01:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lcCH8ZFtJMRB/ZNu25jxmFYingDIGeN/jFSZffgZcb0=; b=UEYAt3ZEaGjC0aJa
	kc44RMQ1R9Ns2ZJCbqX6EHPl6/LAW3XcqCLhu2DgSDXd9xkR3ePjI+6taRIB7Fqe
	cdMFjKCprEFQEmSMTxZqmRT5uQwTRjUy6kZwT2iK3Ss1lavbHLQ0slsDUTW+enpw
	3sI3CmgbQj3g5MVAqaJe2dlaGKGNICQYMpukj3XpPpitxaPzw7RYX2t7NxzE4lkc
	JaqQHcj/WUw4Cg03XNhRtXnWB7x9Vh+136OUPuORHno9zutOSwkV4X6FCuSkQZXj
	BLJ6zln3TjA9CRE83GUyLjbo7StECACKdfWXVCMpDpoblI/wvuk9pBO90o8q6CmW
	A/GVTw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e4m5s1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Sep 2025 01:52:06 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77243618babso210572b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 10 Sep 2025 18:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757555526; x=1758160326;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lcCH8ZFtJMRB/ZNu25jxmFYingDIGeN/jFSZffgZcb0=;
        b=BJMV46diJUZ/UYSgQdlTigg5D6sG6bw5lGyZ6Gd6+a2wGQ8EIABfc2dnlgXL8UGxVt
         ky6w50lYEPgmxE4SQMeMxgGaDRNkeMLoTwbphhBJgbSvesNe3pLSgquUl7cS1+NIi86S
         1IZsnflf3k0EMBWQG1XQ8mY9XTki1riwQg//TfjkAhKxwcnK73ng40C9w17iX+ogZS7A
         fcxOFUojGGsmsmut6Y4rcCVUstD8ZfriDhh4hF7wgTjR27XPvwHx6ccutT7M7vd+r6Sq
         4s8y4BoBgKLRpmp6eNb2iX/4LWhw2Jw//B5Fon5DZQiYi+pNSTYW0Hq1TVFxRglAHwyU
         AMkw==
X-Gm-Message-State: AOJu0YwfHkpnb8IOLegB3P9XltJEiTWLCgiTIWFGAFr/Mv3KhQwxlpZp
	SblnP42cb5xDhilqlGw0kjEQoN0vvafovTSTDJbbyb27oUfGkP2qir7BE2LuAuHEgMWEBmVSp9P
	9yAmm1o6b7CbULIV3VBuTusp4t6Ca9xY8wwJhhWIWxWK/m3w6WK63K+1rBbvzV1oBOqgHYw==
X-Gm-Gg: ASbGncskpiSMIa135yIuknyyb/QSJ5QSQkXka5okaF98J5znx53ypoHfgLHIHmhZATs
	3/15uci5gKhlDG8dbMGhzRTXedwarbMY1as1z09f1pqMCVHCBOwGxUWvM6bxRBXWt16qMitxzJY
	sEh4FXhrpn40ItuSCZ+bdsFOt5tLLqssgtZA5Dt1p0j5N8kA8UQUsklmuq/VVzya+Scfbge+nGJ
	tJvjijJz13d5WBal+O4z9154n/a3DZnMqFgJB7GcuQS9UDFSse8iAKvdBSBwFACre+e7df+0h9Z
	Z8gtM916sfjYPMXcF6mhdmu+cnasGHua/pahLNayGLj61QMRaYqSsWqOQiMPxQTeEN3Spo+1lrP
	xT/Y3DjLojpPvxPli2CDdARMcnHKuEYNMpBDNyQ==
X-Received: by 2002:a05:6a00:18a0:b0:772:8dd7:f55f with SMTP id d2e1a72fcca58-7742de3fc5amr22247971b3a.25.1757555525788;
        Wed, 10 Sep 2025 18:52:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0sxY7aOgILMDdCsSOiqoLkHnh7icX8tiTp5J9HTZFVHeKmZ8n2U0m9CT1HcGEi6OdXTMh4w==
X-Received: by 2002:a05:6a00:18a0:b0:772:8dd7:f55f with SMTP id d2e1a72fcca58-7742de3fc5amr22247949b3a.25.1757555525271;
        Wed, 10 Sep 2025 18:52:05 -0700 (PDT)
Received: from [10.133.33.160] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607a4746dsm223331b3a.29.2025.09.10.18.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 18:52:04 -0700 (PDT)
Message-ID: <2522a3bf-e56f-4fc7-ac42-d0abf9908418@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 09:51:59 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath12k-ng v2 0/8] wifi: ath12k: Improve hal APIs usage in
 rx path
To: Ripan Deuri <quic_rdeuri@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250910181414.2062280-1-quic_rdeuri@quicinc.com>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <20250910181414.2062280-1-quic_rdeuri@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOCBTYWx0ZWRfX8jkxP00Dt5mT
 OkbmHVpIpfsqXQu0+HvGwNpp+hy2cGS1CIGKsl9WOKy2x5etEMoNTZBRK+/htYG5oQ+exCaBb/x
 3jUIPK4y+ySOVy2MYenBPmDpeBCT9JaF0I3VFjTEoF8HaIlahAP6xfnFcTY47O8Hqg4NyK4oAQJ
 XpMgPCG/9e5xBb0qlAkbCpV+nLS3dLnt+eUWO5xKkXIivR3vEpTMG5EFBEWeA3cz6iPW6JrYIi3
 8zggJQRQfgkd6IZ5GQ5+B2UJarpB5bWbtMibADp+ewjGYO7COYvlDFb7pZg1GnBsTAbeulHFtYj
 Uutlnqe6vLMUMw95GfLhbYjy02sliXwkJpNNzi6RuGKXG80g8HRde/iqeOblZuoYwaZjVI2ACfN
 VhiGGbVm
X-Authority-Analysis: v=2.4 cv=J66q7BnS c=1 sm=1 tr=0 ts=68c22b46 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=nnDDZHBImGbq5RFmGnAA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: VtNxQqiT2WMfWA06OHcJk7yHi3g1VHn8
X-Proofpoint-ORIG-GUID: VtNxQqiT2WMfWA06OHcJk7yHi3g1VHn8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060038



On 9/11/2025 2:14 AM, Ripan Deuri wrote:
> The existing usage of rx_ops to reach the hal_apis at multiple places uses
> function pointer indirections. In order to avoid such multiple function
> pointer indirection, extract the required hal parameters in the rx path
> right at the beginning and store them in a structure which is then
> leveraged by the rest of the rx path.
> 
> Move remaining rx_ops APIs to hal_ops to simplify hal API usage.
> 
> Also, make compact tlvs as default mode and remove the non-compact tlvs
> as they are unused. Since there is no need to maintain multiple versions
> of tlv extraction APIs, move the rx_ops callbacks to hal_ops.
> 
> ----
> Changes in v2:
>      - Update commit messages in patch 1/8 and 7/8
> ----
> 
> Pavankumar Nandeshwar (5):
>   wifi: ath12k: Remove non-compact TLV support from QCN
>   wifi: ath12k: Replace ops with direct calls for rxdma ring mask
>   wifi: ath12k: Move hal_rx_ops callbacks to hal_ops
>   wifi: ath12k: Add new infra for the rx path
>   wifi: ath12k: Change the API prefixes to ath12k_wifi7 in tx/rx
> 
> Ripan Deuri (3):
>   wifi: ath12k: Move the hal APIs to hardware specific files
>   wifi: ath12k: unify HAL ops naming across chips
>   wifi: ath12k: Remove hal_rx_ops and merge into hal_ops
> 
>  drivers/net/wireless/ath/ath12k/Makefile      |    4 +-
>  drivers/net/wireless/ath/ath12k/ahb.c         |    2 +-
>  drivers/net/wireless/ath/ath12k/core.c        |    2 +-
>  drivers/net/wireless/ath/ath12k/core.h        |    2 -
>  drivers/net/wireless/ath/ath12k/dbring.c      |    5 +-
>  drivers/net/wireless/ath/ath12k/dp.c          |   31 +-
>  drivers/net/wireless/ath/ath12k/dp.h          |    1 -
>  drivers/net/wireless/ath/ath12k/dp_mon.c      |   36 +-
>  drivers/net/wireless/ath/ath12k/dp_rx.c       |  128 +-
>  drivers/net/wireless/ath/ath12k/dp_rx.h       |  204 +---
>  drivers/net/wireless/ath/ath12k/hal.c         | 1048 +----------------
>  drivers/net/wireless/ath/ath12k/hal.h         |  106 +-
>  drivers/net/wireless/ath/ath12k/mac.c         |    6 +-
>  drivers/net/wireless/ath/ath12k/pci.c         |    2 +-
>  drivers/net/wireless/ath/ath12k/wifi7/dp.c    |   19 +-
>  drivers/net/wireless/ath/ath12k/wifi7/dp.h    |    5 +-
>  drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c |  501 ++++----
>  drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h |   74 +-
>  drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c |   49 +-
>  drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h |    8 +-
>  .../wireless/ath/ath12k/wifi7/hal_qcn9274.c   |  369 ++++++
>  .../wireless/ath/ath12k/wifi7/hal_qcn9274.h   |   35 +
>  .../net/wireless/ath/ath12k/wifi7/hal_rx.c    |  161 +--
>  .../net/wireless/ath/ath12k/wifi7/hal_rx.h    |   82 +-
>  .../wireless/ath/ath12k/wifi7/hal_rx_desc.h   |    7 -
>  .../net/wireless/ath/ath12k/wifi7/hal_tx.c    |   13 +-
>  .../net/wireless/ath/ath12k/wifi7/hal_tx.h    |   18 +-
>  .../wireless/ath/ath12k/wifi7/hal_wcn7850.c   |  364 ++++++
>  .../wireless/ath/ath12k/wifi7/hal_wcn7850.h   |   32 +
>  drivers/net/wireless/ath/ath12k/wifi7/pci.c   |    2 -
>  30 files changed, 1452 insertions(+), 1864 deletions(-)
>  create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
>  create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h
>  create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
>  create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h
> 
> 
> base-commit: d637c58a29475d646f8decfbbc1d27fae999a449

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


