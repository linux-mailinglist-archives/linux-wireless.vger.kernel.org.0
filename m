Return-Path: <linux-wireless+bounces-26128-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C06B1A459
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 16:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 062514E193C
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 14:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663F22727E7;
	Mon,  4 Aug 2025 14:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FbNECHKS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D117271A71
	for <linux-wireless@vger.kernel.org>; Mon,  4 Aug 2025 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754317039; cv=none; b=t4VwR2a0/3YkF3wHY5VwZebGrYC3rvccRs1mHUybF1M+2tIGZZj1od8l2tU3kDOZ1MeYgpx8J1F622WE7VrJUV40xgow4foFkC5VZCHv1FI1SoOvuTTArbf3yTSezJpFXswm/wlZz9M1rifdlGEhv/cAaskU15UrlB4fx/8yYF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754317039; c=relaxed/simple;
	bh=A8DC5GZiezWSG87vEws0C6j85Kf6YPZuvC+TN+JTLpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g4PbdS1g1s1zyp5+wciISkGwZ6UO7Tz0vsyykwQqjcIhKtW/MHJBgtsHBU/xudlM3QG4ypGSlNVwljLdmPZ4SJc2cJGCTnCKcsqFNEPeTbND5HesHFRqHDc2leZzwNAmgkKUhGZ3ElvCuLQrNmt5VJwIAhFVJ85hRQTdAx2dav4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FbNECHKS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574E1xl1027900
	for <linux-wireless@vger.kernel.org>; Mon, 4 Aug 2025 14:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Gvpm8a+Po3AvQHyqTVypgq8YhFb8qXLB0jdSvQ5uttg=; b=FbNECHKSPMlvxaR8
	+1TSgffV1F63Cw3pBysSRWE9dSLwjhlmI38dZO7d5+Jqc0QI3LNC71UP5oyfzjtH
	U7xCmKbE7z7Too77s3Y6z8NNOyMJcQ7++P/yiPnavxDkEFpZWazXr7HJr3jYh+Lq
	J++xkirzs7DGhQgqnzB0Lj5JhSjnmjWQ4XfL0Oq6giJowZ4arispTlZdSwPiCQy0
	4f91W0VNc4vW4j5/6+I2wTwn5W0McWr0FiCjhBr9rSQbqSxViluw4/UbwXOhjAby
	P/tR6sbAV3I1rMbRakVDTzel2h8rhXk98hp0G2ZSpOGGJaan8/2OnyF3rpZb70XU
	ALC5OQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ak5a2267-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 04 Aug 2025 14:17:15 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23fd831def4so34320755ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 04 Aug 2025 07:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754317026; x=1754921826;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gvpm8a+Po3AvQHyqTVypgq8YhFb8qXLB0jdSvQ5uttg=;
        b=rs55muC6oUftuLRmaL43AdHMxF85W4N5G1ktfKsJ5FwKGW5TD3BI2J93IJ/RZxc0FS
         nBlS7n3HyrPiN2DUZ/c0I4ZAWWomAXRp7QI5tC3CInC+d4e6zqFARLZ6TDgYlBar3UwP
         O9vbQx0Fby/ThAcskCmtqNfFcuYlF/IP9Ydnvypye48YkLl615Qo+ILkTykE5weCPcOo
         UjNTaICuqTQX+tm8TiclMvfDRyE6daYPt2J9ghkSVJMjv6v3tPJ70MC4iblar9LmYA27
         hR4wv7A3g5gHOp/PeP7odt9aPfOou0e59dyWC36Zwih4VkwYDevMjdnIo/EO9VND7E65
         n4cA==
X-Forwarded-Encrypted: i=1; AJvYcCUddBJFra2tSv7QObfX2V+e9k6Iti6FqGDwcczxrBwedgGUKbvbBh8zjxMhn0h56KHA/8uBW4zy5DLvy0z5bQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyErM7SR2S/3JhDUgYEIVlJ/n+BIVFBVjwront7z9yoPd3I5Ohf
	yMV/RIlUprO3h15ZnUeZOorhlQ/phm6YJ6JnT8YD7q8h23TFrdUgFVPmFXwHYIHddIOXOSVsNIn
	puMYvMX/mp+QbFXT7nx6nK1+8O8J0rF/mWhOQKUirhLJeIRWMwb45uVBlbCuzdaHCvLK7YQ==
X-Gm-Gg: ASbGncvOnSeepInILGjidKZurdSPtYUHBseUCo1/t+6ubzHebzNko9//7vflN1DGr/t
	GG4UiPcK6IqpMsf2JzUHckJpqauySi16B4B5smGNTZIdhQHQqzk4NI644YislA4crpRFHOSpeBp
	STt9CJdg0UDBPjoIuQd0iB09U9ycrdn19qMBzQMG2FSFMHFURsPDWf1Coh9O7pthCM7N+7gEjZE
	fD3XQRmVHqhyiqV8tHo0mjBXU2ET48BTpVZMeJZv7cbF2ELH95JXRRzXmN8Xn0miZjQfmOJUm3j
	lZlfropXbF1aZHO+Gh0zdEX19i2H8rqFep+hnlFGLWj0PDeMxqJKEYNwgYUEkswYfb4j/UiGrNC
	BRyxny7Rv5a7twZvEXxWHT/6+NuylweV1
X-Received: by 2002:a17:902:ef45:b0:240:3dea:b269 with SMTP id d9443c01a7336-24247033fc0mr139082305ad.48.1754317025692;
        Mon, 04 Aug 2025 07:17:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHaeEa9NWdmU9v/K3+J+uYiBAHxa0ZMd4TXiIz+8nIet/FavC5/MvKeVD+zMUzhg/+SbvBVg==
X-Received: by 2002:a17:902:ef45:b0:240:3dea:b269 with SMTP id d9443c01a7336-24247033fc0mr139081745ad.48.1754317025156;
        Mon, 04 Aug 2025 07:17:05 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899a81fsm110766825ad.120.2025.08.04.07.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 07:17:04 -0700 (PDT)
Message-ID: <658d7d55-fd5e-42cb-bc5d-abcc0b47a168@oss.qualcomm.com>
Date: Mon, 4 Aug 2025 07:17:02 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] soc: qcom: mdt_loader: Remove pas id parameter
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
References: <20250804-mdtloader-changes-v1-0-5e74629a2241@oss.qualcomm.com>
 <20250804-mdtloader-changes-v1-2-5e74629a2241@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250804-mdtloader-changes-v1-2-5e74629a2241@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA3OSBTYWx0ZWRfX1hi28punZRwb
 68dDQz41zagMEu0mP8Gf8Vdge9LQzF6NseZI9pILFL/fg6HHgNzcarLT11Yu9kUl6CG2LqC7XHH
 wIUXsdchPKJhok6l0C+EYicHhINQTumuaWYJHASyVIqoxpMuxQYF/Gyz3+EsD0uaWoIp7SCmjJ3
 bdppw4OgM7kdvSM2O74vduBv6JkHqkeVjgoRCDnyElupaz80swxb672MSxvxLBSwbmXK0qRKds6
 97NjKZa/k+/JWNeO5pdgEjAHSvQcmcw5RdKdc2aGdO1MMC4SwHCLOpW/pw+/k5EH6BbzWo0XmFi
 9gp0d1U27vX4TVyORuQJlIK2aseeXl21iHXddvwstSv3D7Rr2SQditE/wOlett+sMZnRcGCk4Dw
 35AeTvVuQr9ELVL/wov3VjZ+rIm7cnO6EmF+k3fyhpJ6aQzl5VAA7icpFOXdY0APPR7sY22y
X-Proofpoint-GUID: cM-UhBO2ye1NToXSDryZx1qwwR7oWrUO
X-Authority-Analysis: v=2.4 cv=LP1mQIW9 c=1 sm=1 tr=0 ts=6890c0eb cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=IDvrs2r2PCma8_SM7s4A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: cM-UhBO2ye1NToXSDryZx1qwwR7oWrUO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_06,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxlogscore=910 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040079

On 8/4/2025 5:41 AM, Mukesh Ojha wrote:
> pas id is not used in qcom_mdt_load_no_init() and it should not
> be used as it is non-PAS specific function and has no relation
> to PAS specific mechanism.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/venus/firmware.c |  4 ++--
>  drivers/net/wireless/ath/ath12k/ahb.c        |  2 +-
>  drivers/remoteproc/qcom_q6v5_adsp.c          |  2 +-
>  drivers/remoteproc/qcom_q6v5_pas.c           |  7 +++----
>  drivers/remoteproc/qcom_q6v5_wcss.c          |  2 +-
>  drivers/soc/qcom/mdt_loader.c                | 14 ++++++--------
>  include/linux/soc/qcom/mdt_loader.h          |  7 +++----
>  7 files changed, 17 insertions(+), 21 deletions(-)

Since this patch touches files which go through different maintainers, do you
have a plan on how this will be merged?

I can ack the drivers/net/wireless/ath change once I know how it will be handled.

/jeff

