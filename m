Return-Path: <linux-wireless+bounces-10806-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5956E94431A
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 08:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC215B2194A
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 06:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7369C15749C;
	Thu,  1 Aug 2024 06:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="l6JUvGm2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B94B15749A
	for <linux-wireless@vger.kernel.org>; Thu,  1 Aug 2024 06:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722492546; cv=none; b=mE6XVegrUHtvMx+/nj+VkNRo+AhCYwUsiOQXAffUROzEpdrD3IXR0dtFZRUPLijQFigVj5JlKJR/e6uhHIquWgvz4PHoG+Z4TOD+UUX8Br8L8s0WWNdC/EYdlXy7fmvIZi16GjEnZBWd9VovfbL5h9qbObOxkruJl4dh76tA60Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722492546; c=relaxed/simple;
	bh=oxJsbiwxnJ0fX3LSF2pWb4D6nQHC4mIiOr/a62yAWoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dy0orPeoi4BYYyLuocfia+AZEvXfkemx7h3QNbJSluIzuqZ8H+olcXUH1qpHrRVNtL8JLkw2/69ekbeqA+MP9YTAWeoprI1wX1RX/eXQfg4w8FPHE6jvVkLnlmO/xVCULPmDcBbUyBD3A4QiV4c2piC4n1KMn50AUaDtLwLsX6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=l6JUvGm2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46VNMb5Y030523;
	Thu, 1 Aug 2024 06:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jNo6/gxM1rLGBcliP3cTqkYZyKg9Syd+5iPaCoyo5m8=; b=l6JUvGm2xDHl9R4F
	29LorhF/5Yjtn96DzBhLMUXAzCcjDvOIz0nnj6uV/XeLhICSctA4l6egOiv6jipQ
	Q/CTCUjm/PNk3PbAiiulmUsdpC/e1FaS4R99aT44i84BDFwrzEZWq4MCmDI6hQsl
	kF/1S6HjrAr6uciM698H1rzkEBuQZ6iZLJ0dK6v6vhnzwBKZmORYjjczhNQZxzgA
	THnAMi09z4tu0Y/83WkcYc29z0qD1dyEdpJtWrRSYRKAkOsLN8JjV22McUs/aUoU
	7f6ymjpGRVRaj26Zz6cuaYR489MED3oe7vK/f4VV5liR7ybIhDLZ8wVXuGpteD9o
	NJgK0A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40qm082ss9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 06:08:58 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 47168vtE023335
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Aug 2024 06:08:57 GMT
Received: from [10.110.121.28] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 31 Jul
 2024 23:08:56 -0700
Message-ID: <4e92994e-33d0-4104-a0a9-5f75833e09f3@quicinc.com>
Date: Thu, 1 Aug 2024 14:08:54 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] wifi: ath12k: some fixes and clean up for monitor
 mode
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240725120035.493-1-quic_kangyang@quicinc.com>
 <87ttg5kdvc.fsf@kernel.org>
Content-Language: en-US
From: Kang Yang <quic_kangyang@quicinc.com>
In-Reply-To: <87ttg5kdvc.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OyYX_VDZ5d51Y02P08JRVoDbYkm54BWz
X-Proofpoint-ORIG-GUID: OyYX_VDZ5d51Y02P08JRVoDbYkm54BWz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_03,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=773 spamscore=0 clxscore=1011
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408010034



On 7/31/2024 7:19 PM, Kalle Valo wrote:
> kangyang <quic_kangyang@quicinc.com> writes:
> 
>> From: Kang Yang <quic_kangyang@quicinc.com>
>>
>> This patch set does some fixes and clean up for monitor mode.
> 
> Please fix your SMTP From header, it's currently:
> 
> kangyang <quic_kangyang@quicinc.com>
> 
> It should be:
> 
> Kang Yang <quic_kangyang@quicinc.com>
> 
> When you fix that git won't include the extra From header to the mail body.
> 

Thanks for the reminder, changed.

