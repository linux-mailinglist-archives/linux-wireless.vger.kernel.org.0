Return-Path: <linux-wireless+bounces-25104-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA15AFEFE4
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 19:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B00FC3A576E
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 17:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B5C220F3E;
	Wed,  9 Jul 2025 17:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EekFlW8i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D8C3398B
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752082299; cv=none; b=cmq6hxoZF4DXcI7zGzJRIsASydLXFDAifr20MXUoXwFmh+brt0ygDumEfSZHLwoPNt+ewv8Ae4tl28LRdLkGmO1X4ABOkcLNG1XT1/FLeo/cihFtcnVIIaAD/wq2WUkbH1sGmrW2HeyF5E95b0Z7cXwnY4J8gwqpWwtgA/3a9gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752082299; c=relaxed/simple;
	bh=ujDJ3PFCwLU2KBIHMfyF3jr9mu95R6pthR8aJl4tgbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VjAaAFgFA4/ikwfghr980lQtZLSOr2N9LGWWBL/S0y+I5hURbC+MDA3Hn2LbccaXH66f0jFwvsBcOe0UFSczMV78j8SafKKLQj+yZqwfqld43b+oQhLlwBpgv5FtwkY3dZ3gBx1JSK9TI2/7KKuerIG4TlZ15q2B5lEtesOtIn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EekFlW8i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569CofGK023127;
	Wed, 9 Jul 2025 17:31:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2cbjH8duccMWGFAFoVaCqbs66azO9mWBlYVLArNR2c0=; b=EekFlW8iQbCR3Qok
	3jyqnS2nSDWoktDtLW9LL9XZhsIK4fV+wLj2bdJaAs/2WbxWAasvZ7T0LE2wmgj+
	ZaQ4NZNyPpaWF220/+WPrXn1z628x0ngchAEZK4f+WX//6GXfKbAPcTdwReW3CPS
	hc+e6Fk41WkgEMoEaimzxwk5O4HKM9jpm2BMSUPybyM6Zp/I7w9qnBy3tQNwzTW7
	EvyFF8Pm9/OzVemrGxNCN5PmBVUNWoo6GITLPaXD2lS2dft6OtItdOmuC0GJuzuN
	V7pnyuzmWFGtZJ6zg18TchrN8hHCjftxxEFvyNnpxk0j/AXqXnBNlN8RO2v/sbGc
	AyqSHw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smbehxaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 17:31:33 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 569HVWsN018332
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 9 Jul 2025 17:31:32 GMT
Received: from [10.50.16.31] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 9 Jul
 2025 10:31:31 -0700
Message-ID: <24885f19-ab0e-4239-bcb6-e79a88360c43@quicinc.com>
Date: Wed, 9 Jul 2025 23:01:22 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] iw: Add Support to Set per-radio attributes for each
 Radio
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250204085000.3809769-1-quic_rdevanat@quicinc.com>
 <027eb3041693ff54acd16fb4885e5621ff81a973.camel@sipsolutions.net>
Content-Language: en-US
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
In-Reply-To: <027eb3041693ff54acd16fb4885e5621ff81a973.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDE1NyBTYWx0ZWRfX1w2+9vjcUpwG
 NZGc6FOdO41ad/tw1Ws2eHGcurgeETandK5qp1r1EeeZUxxzCVWaKFP4EJP/uu7tyE5XSeJ+emv
 G+UpH9wT92GJ9cNxDtxR+SnKrkdDhwTd5JLFdh4NCUTvYi7BWLrgSonq4ktl+TulbvVjW6AHoNY
 4yCwEk5YEpRfxwoQxnZUk+TEf8ONEpGUa+9bO2SmNIpOK9sgoSdnwUwlqiCrCCST004Jydjt3K8
 4urx8D3J3gbnBtKQRwE0DcenfPug/xxxJtFoRFtKSXQwNPIF23mo83IPmBfTG6GDTwdqXA1Y627
 8Y4JdVzNQB/OHQpoN9ykth0ds6W7JPJzB8e4Iwbo2EJJCviZmI7yxSyMZjezlDMHJBNzBQgSVw/
 t/GM0HzXP24UH4vOfxwymCB4TaTAXNd8OgLuxeLBBSIRpbKeJgBlv5UMmWdzExIOb6cDpL0M
X-Proofpoint-GUID: 9dpAdnXnEeCJkzasbe7GozGEDLdSVOVk
X-Proofpoint-ORIG-GUID: 9dpAdnXnEeCJkzasbe7GozGEDLdSVOVk
X-Authority-Analysis: v=2.4 cv=VpQjA/2n c=1 sm=1 tr=0 ts=686ea775 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=LKtmvGvXiS2ya1KfJAMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 mlxlogscore=822 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507090157



On 7/8/2025 6:12 PM, Johannes Berg wrote:
> On Tue, 2025-02-04 at 14:19 +0530, Roopni Devanathan wrote:
>> Currently, setting per-radio attribute like RTS threshold and Tx power,
>> changes the threshold and power for all radios in a wiphy. But, in a
>> multi-radio wiphy, different radios can have different attribute value
>> requirements. Modify the iw command to handle per-radio attributes for
>> RTS threshold and Tx power.
>>
>> Rameshkumar Sundaram (1):
>>   iw: Add support to set per-radio Tx power config in multi-radio wiphy
>>
>> Roopni Devanathan (1):
>>   iw: Add support to set per-radio RTS threshold in multi-radio wiphy
> 
> I'd kept these around for when the kernel changes land, but I don't
> think they can build now, and I think anyway they cannot because of
> NL80211_WIPHY_RADIO_ID_MAX.
> 
> Please resend an appropriate version when needed.
> 
I am working on this now. Will send a v2 shortly. Thanks!

> johannes

