Return-Path: <linux-wireless+bounces-20679-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A75E0A6BFEB
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 17:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AAE117F1C7
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 16:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4112F1E5B68;
	Fri, 21 Mar 2025 16:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LpQ8sILj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06CC22D4D8
	for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 16:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742574680; cv=none; b=m56vDVPDasYdP3NnuKVQf/tkXl+pdLpk1QOP+o3/OJhDxnk7nZm7XYUMQoN889fsLSH7alCwusQMYT9lPy3cokk48JznqzEgkLy0zbh2U4Jg7tTqqhOlmya8Tp8gv4V0fWBpXyY0Bd6lW0iRiSKq7WCvJNKml9RU7RmlW72AVPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742574680; c=relaxed/simple;
	bh=zojdPWtEGUjvrbgAMqva/TKdcj3Cxw4XjqxiaqiNiiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZs7FhnHaNByjry9QjJsjT9DnOPN4lh0Qqtul1GktLPXlwRYF2pBzwFkrxferpSOD6qerPvJMl7QnKruAIeC0PV3SMDfHZ29+hyCW69ccY8kuCDkmaPLt/ecDYIgPLt/nbrr6z5kdy57bFEYE2e7oiRWorzjrVRJtteUyx25lH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LpQ8sILj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LATEuu011531
	for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 16:31:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UQ+EQ5JGQ/p3NSEWSaxtIU/HftXFPwlWY/6AZof8vvA=; b=LpQ8sILjllXrzXkB
	Ycfm98+ptIVH8dh0c5/x0khSiWKpeKQOftDjH1Sc2QVdINtGmdt02zndLn6KtTKj
	bsCwXjVIqM8Pny+qYwZGc1+UixIP7cw4WA+nEIvcfFUWBMKBNPZy15KVtfrm5krY
	jgXBW78KyDPMj1OjZuyuTcFOOxbr6C+Rqar+Lh8gCBMcjuupv42jFCaVLY9S4fmD
	/KMtgJiImCu1xE+qFa70ZIT77TQxWl+153rgLDYo5hh27l/XVkgy0+2H32uyW7xQ
	qc9TwaNKzebqs2l36TmE74LmqpzRICRl9pR5kI9CNfZsBh8TvedTSy58dmxzftiE
	tcIKBg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45g15y7257-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 16:31:17 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff82dd6de0so2901232a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 09:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742574676; x=1743179476;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UQ+EQ5JGQ/p3NSEWSaxtIU/HftXFPwlWY/6AZof8vvA=;
        b=To9JZwblvNG04z1DCV8AVWGP1gk4iGVnYenFHn0/UrU9X9YAizkemuhEcrpMzLxhA9
         4PL8GuoVy9LWqhpTaYSjq7rYr1s1qDP2vVecbQz/aUYAijDDKYYNVJPnsKgCVoXuc6Ll
         ZLXr84c+V/VExoDBZWec6/7cYY5NPhc9EvmljHHqIiNPK0jvUEYpFRy0nnfrjp3xyP2o
         Akr9Yn83AQod3a001mTf54ddBfGiJ4WRQuwFXzbIa/tOgVmyCcJyJ9qwuBVWbWDMPXNz
         rTFqRrzf3XUHaZ7VeY1vLSSmcyQd3gW0eAEk4gkGMAQn30FOnXe/kDeMeUMeqAZdescM
         h2DQ==
X-Gm-Message-State: AOJu0YxPrgvU1qBQ7TaDBQJzx8g41kFpKjY5uU/VMY5+WV1LwbB/tBTV
	MO9ouusuzDBglCHT4JtlYXG3aNkUSf/zXXdUZvM2hHxKXOibRKUSbhIKqjy20NgPOWEzCzbh1KN
	e2OkxSzbhDttCYaKZ2DmggCQv1SW7pfB3El6gCdIezUB5jVriRAedaifjbs9MVzdwBw==
X-Gm-Gg: ASbGncunKtnSxmMerPU7syqyey6SAnbESGGotAijKSaMRD9iSSbK9X/Lbn9NPIjyUVJ
	PNE98kMmcvqnbq5WPsdvywM/4gv2SbwNV39e3ZdeyxXKS4YoqXdHjPW0TD7s4KJ0MRO+W4ebQrw
	aPx1dfl1WluKEAtHzJx25bPJ1w0/+odoHMJ4dQ4Iu5IxGDy2ZO3TGQRdl3pEFtVQNIHtzI8w1y1
	WiFMyG0/6RWADefQObZJlZVhHRojIAEN4M2u7zV4Fjr8Oyj8f0YilIWH20d6XZ31ojB3andChUd
	Nis02Fah9cdAYeR2aIhpc7BrPXzC2cNzfBuZBNxsdQZfOG+m/FSIilpy1uBGxaxKQNq4I7nqzRK
	Gz3N2vAsk
X-Received: by 2002:a05:6a20:d81b:b0:1f5:93cd:59b5 with SMTP id adf61e73a8af0-1fe43327edbmr7689396637.28.1742574675870;
        Fri, 21 Mar 2025 09:31:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiuQMISl1eN9RX+Es821Eblup8CDwjYoGKpMH5CGlq8b1HHOajXsiimxB0ELiPyxoSm0dayA==
X-Received: by 2002:a05:6a20:d81b:b0:1f5:93cd:59b5 with SMTP id adf61e73a8af0-1fe43327edbmr7689338637.28.1742574675301;
        Fri, 21 Mar 2025 09:31:15 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a2a4d016sm1690127a12.69.2025.03.21.09.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 09:31:14 -0700 (PDT)
Message-ID: <89db5e91-2162-4724-bdf1-238f84bca8a6@oss.qualcomm.com>
Date: Fri, 21 Mar 2025 09:31:13 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: don't put ieee80211_chanctx_conf
 struct in ath12k_link_vif
To: Baochen Qiang <quic_bqiang@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20250321-ath12k-dont-put-chanctx-in-arvif-v1-1-c8e93061952b@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250321-ath12k-dont-put-chanctx-in-arvif-v1-1-c8e93061952b@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: fLL23puLyq5_1dwPMZYJT-6UxjwdeNh6
X-Proofpoint-ORIG-GUID: fLL23puLyq5_1dwPMZYJT-6UxjwdeNh6
X-Authority-Analysis: v=2.4 cv=VaD3PEp9 c=1 sm=1 tr=0 ts=67dd9455 cx=c_pps a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=bC-a23v3AAAA:8 a=VwQbUJbxAAAA:8 a=uvMg_fejPkrpZwH_nmEA:9 a=QEXdDO2ut3YA:10
 a=-FEs8UIgK8oA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=908 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210121

On 3/20/2025 6:45 PM, Baochen Qiang wrote:
> ieee80211_chanctx_conf struct is not put at the end of ath12k_link_vif.
> Note ieee80211_chanctx_conf has flexible array member inside it, causing
> below warning with GCC-14:
> 
> drivers/net/wireless/ath/ath12k/core.h:298:39: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Although there is no issue for now since the array is not getting used,
> this should be fixed to avoid any potential data corruption issue in the
> future.
> 
> Remove this struct from ath12k_link_vif, fetch it from ieee80211_bss_conf
> instead when needed.
> 
> This change only applies to WCN7850, and should has no impact on other
> chipsets.
> 
> This is an alternative to the solution proposed in [1].
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Reported-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Link: https://msgid.link/Z8-Snz86Xfwdlyd7@kspp # [1]

I'll change this to Closes: in pending to address checkpatch:
WARNING:BAD_REPORTED_BY_LINK: Reported-by: should be immediately followed by Closes: with a URL to the report


