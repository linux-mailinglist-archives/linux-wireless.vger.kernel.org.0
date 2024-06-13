Return-Path: <linux-wireless+bounces-8968-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E84090695B
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 11:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08BF41F21B84
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 09:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BDA13A41A;
	Thu, 13 Jun 2024 09:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RvdQ1ARx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B833713774D;
	Thu, 13 Jun 2024 09:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718272358; cv=none; b=cavdTHhmJHXVTMXkx4jNJFkiAPPPDE+MhjGdEoQOHSMgFXdUhPulZv6yHEJmfS7oPNyXgLTAfZwYT5e5pvSe0r6KvyzBO2NQ3NHhZ9WZVPmlsRqKTu11C5iP7Jx7ghkCTkTtDaC5YTG5hyQRVtLm8BXgwtmoZ06q3/WBi0guMMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718272358; c=relaxed/simple;
	bh=RrwJyBp5r48PP0OB7E9bbtZaSKSU+dE831Q19RMIi60=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Jx2nT0cciv/ty7lDm0qn+sQBU9XEFsfUDJuHRmCB59UaIRuBG9bqmdZm3VPCOWoCZrb1WtLXQDrl5/JV4cyyGJWmnOROtOCKiYKYvAIg59MWz+IKHVN69vmTFMw21+wwLNmYKgYgGRnstuU/PxPJOASe/rTkNDePoULZMtYnydk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RvdQ1ARx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D8rrmP002076;
	Thu, 13 Jun 2024 09:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jIsKe1t72C0n6LQKxWqUjNjoizn7ErYhYoFZfb3QbJ4=; b=RvdQ1ARx0qFDREf2
	SCvrb27ywb1VKv8vgaBs7amIjaPE6Fkjg5TJTPE4s3dpMSz+UtPM7ojTJb6Z23+K
	MloeePFXGatom3LyvhxZ7GzKr94AIF+P5DfXp0i7GGbFhWOexxjYixuaY+yJ27JV
	6dW82sMZiJJivdMxmBGpYG6gWco5slCFJ166IsIObhxHmH6GlhYcQHdbF4AbrDd5
	tV044qWPZgIf+9otM/zacvWEZItIjIu0HzeTRtRnS95azqgsW1hbCwNjeWtTygbX
	ZhX6he4MyvY0Q/zhVYO8PjkIPMNoOOzwoGqY1NCd+4rWf8GXJ2OWz04y9HKNldw9
	FOArkA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ypp87x2a7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 09:52:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45D9q6rP019968
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 09:52:06 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 13 Jun
 2024 02:51:58 -0700
Message-ID: <35750452-e362-4dfa-803a-3360a4e16cd8@quicinc.com>
Date: Thu, 13 Jun 2024 17:51:56 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iwlwifi: Regression after migrating to 6.6.32
To: Johannes Berg <johannes@sipsolutions.net>,
        Fabio Estevam
	<festevam@gmail.com>
CC: <miriam.rachel.korenblit@intel.com>, <kvalo@kernel.org>,
        Jakub Kicinski
	<kuba@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <CAOMZO5A7+nxACoBPY0k8cOpVQByZtEV_N1489MK5wETHF_RXWA@mail.gmail.com>
 <3fbb5317d9ff33ef1b60ca8297537335ce86a79d.camel@sipsolutions.net>
 <CAOMZO5Aufe7zAE7TFVprvRreamYd9=RHjybjaEz2O9WaPksV=Q@mail.gmail.com>
 <95163ee547da95964c16f87a38d3326ae4da3253.camel@sipsolutions.net>
 <CAOMZO5CYDsh70u3To7HYXVki_MzzhFyCCHkigt_Es7o_+XG3oA@mail.gmail.com>
 <7a8e220d77d7e30a0cfaf984404ef2f57eaa785f.camel@sipsolutions.net>
 <CAOMZO5BktgtaSPzCf3WOOnkD2n+fj3FeQEfHeT7CYFL+tCHeaw@mail.gmail.com>
 <fb60b7f5bcf5ba47be54398225075a5bfab7c141.camel@sipsolutions.net>
 <CAOMZO5CMX_juW4-t6CSd2xdzXkFfBiamuSTjsTB80Ly_TUsxRA@mail.gmail.com>
 <d49fcc32-bfa8-41d2-8666-af6256b7b4b4@quicinc.com>
 <50101085cba7fc089339c96f531f797e27c632ff.camel@sipsolutions.net>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <50101085cba7fc089339c96f531f797e27c632ff.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: X2zS0ggyJuVatQl9Jw7gduj9iIOpNr1a
X-Proofpoint-ORIG-GUID: X2zS0ggyJuVatQl9Jw7gduj9iIOpNr1a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_02,2024-06-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxlogscore=822 priorityscore=1501 adultscore=0
 bulkscore=0 mlxscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406130070



On 6/13/2024 3:40 PM, Johannes Berg wrote:
> On Thu, 2024-06-13 at 15:10 +0800, Baochen Qiang wrote:
>>
>> On 6/13/2024 3:15 AM, Fabio Estevam wrote:
>>> Hi Johannes,
>>>
>>> On Wed, Jun 12, 2024 at 4:10 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>>>
>>>> Strange. Is there an IOMMU involved on this platform?
>>>
>>> IOMMU isn't available on i.MX8M as far as I know.
>> If IOMMU not present, likely the buffer is mapped by SWIOTLB.
> 
> Why? The device can do 64-bit DMA, so should be able to just access any
> page in the system. Even older devices can do 36-bit DMA, but this is a
> newer one. And if IOMMU isn't present, you have no protection anyway.
Then no idea :(

> 
>>  The iova 4215433216, aka 0xFB426800, is 2K aligned, which also supports such guessing. See definition of IO_TLB_SIZE.
> 
> Not sure that means anything though, I really would have expected a 4k
> buffer to be 4k aligned - why would you even want to map it across two
> pages?
IMO SWIOTLB manages buffers in a unit of IO_TLB_SIZE, it does not care about whether or not we are crossing page boundaries, no?

> 
> If it is SWIOTLB, shouldn't we get into this condition?
> 
>         /*
>          * Historically, swiotlb allocations >= PAGE_SIZE were guaranteed to be
>          * page-aligned in the absence of any other alignment requirements.
>          * 'alloc_align_mask' was later introduced to specify the alignment
>          * explicitly, however this is passed as zero for streaming mappings
>          * and so we preserve the old behaviour there in case any drivers are
>          * relying on it.
>          */
>         if (!alloc_align_mask && !iotlb_align_mask && alloc_size >= PAGE_SIZE)
>                 alloc_align_mask = PAGE_SIZE - 1;
> 
This is not present in 6.6.32 stable kernel.

> 
> Otherwise, not sure though how we could possibly fix this in the driver,
> we really shouldn't do dma_set_min_align_mask() since on the TX side we
> really have no alignment requirements, and swiotlb_map() uses 0 as
> alignment.
> 
> johannes

