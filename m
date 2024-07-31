Return-Path: <linux-wireless+bounces-10749-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DD5943176
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 15:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6F0DB20CF8
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 13:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA9A1AE872;
	Wed, 31 Jul 2024 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HI+YjFAy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D641A8BEB
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 13:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722434149; cv=none; b=tvOur5DOG2n6ZwA9+bZNsxDyr01ACbuQ8N18cZE45LCazmORz6APE+AMPV6p1fK/t5SxrtNIvmVJ1WF6od6D1udMCjTn+F6VKoPFVWI8svDmUoJp97M7DRFwlzh41lvt5nMxJQPPjjdgG4/C+Twa2FkKYtBG2X+nOh6WBpDG454=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722434149; c=relaxed/simple;
	bh=TqT1upJiGZAMuVb9ijH0DZSuNGz7SqZ8alvqKG8bth0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JOwR8bnqzdEFTqf8/kCBtFPqJHirUQl58UNIOBLa9PUl9OaH2pk7yNn3/yp7rPUlV+jUPuo0/GLN8bgifxbt4scHUF83pBKGijTdJ6wIm3TB8ezGaAM0LbxG6ill7s4d31AoEOlZEWowLsi8rogq95woJkyr6TY4ANmfAth311c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HI+YjFAy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46V76t7G029965;
	Wed, 31 Jul 2024 13:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YWJ19l1mlFKnkTHIRrqeIeKHgb6EHtD5b4grRM6IlYg=; b=HI+YjFAyDN5vEw70
	0VtVT2kL4P+QNBglpRZ2FOlt5zbmaYGkD7ZPFsx76hL6vnBVk9wnKFPOx2KchLyt
	h5hlk4q7+53xszgFGYLZ2BCpOakqTJ5Dq8E1+8VTyvdhgVKXDSOi/XBFoE3oir2j
	xdpgyJXhw+chj3yqbnQRGcWzxBsKEspAlVmDzCrmBrHaeSkCevGwWRzrtjBvmO1A
	MDAHxtSXotrYPzOZHNzsjo7CR2sph6u/ajC4j42Dx6CaJ4LGQn2TIrnxUmmHiI6f
	hYJIs+YNP2wwRYAvLz9XXK6gNW86UgIi2hb7CDjv+uEG6svp4ARORUtiK0gBxW0b
	dZ0W3g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40pq525hym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 13:55:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46VDthIH004146
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 13:55:43 GMT
Received: from [10.111.177.34] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 31 Jul
 2024 06:55:43 -0700
Message-ID: <3de102b4-81c9-48f8-bef5-b2d6df1ce225@quicinc.com>
Date: Wed, 31 Jul 2024 06:55:42 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] wifi: ath12k: fix struct hal_rx_ppdu_start
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: kangyang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
References: <20240725120035.493-1-quic_kangyang@quicinc.com>
 <20240725120035.493-5-quic_kangyang@quicinc.com>
 <aa2b6791-9d18-479b-a80d-722b99592cb8@quicinc.com>
 <87y15hkdyf.fsf@kernel.org> <87plqtkdr2.fsf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <87plqtkdr2.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _o0w2VwO7exbMJv6-O9PATqg4-v7zMNi
X-Proofpoint-ORIG-GUID: _o0w2VwO7exbMJv6-O9PATqg4-v7zMNi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_08,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=374
 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407310100

On 7/31/2024 4:22 AM, Kalle Valo wrote:
> Kalle Valo <kvalo@kernel.org> writes:
> 
>> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>>
>>> On 7/25/2024 5:00 AM, kangyang wrote:
>>>> From: Kang Yang <quic_kangyang@quicinc.com>
>>>>
>>>> Current struct hal_rx_ppdu_start in hal_rx.h is not matched with
>>>> hardware descriptor definition.
>>>>
>>>> So update this structure and related code.
>>>>
>>>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>>>
>>>> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
>>>
>>>
>>
>> Jeff, your reply was empty.
> 
> Actually I saw several empty replies in this patchset.
> 
Please add the following to every patch in the series if it isn't present:
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


