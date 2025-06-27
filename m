Return-Path: <linux-wireless+bounces-24611-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA05AEB09B
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 09:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEEB3561572
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 07:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DC41D79BE;
	Fri, 27 Jun 2025 07:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N4hVff0g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065F1194098
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 07:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751010791; cv=none; b=epH4EMYkuhQbvoEyZWwANcacf3yuO6VzUOBMMPqP27BQoH/gcxpGS5IMZpFe2CECj8S1U/E1RxVTMCM5NdAGQ9XZ/j8aXI3vjVgwn7+2cDRTHdj0BpZ7UpABCaEcuzvTY1xUC+rA7NzxhUx3047VokmveoiD4/d79Lu3HPJZqDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751010791; c=relaxed/simple;
	bh=ZU6SvRS/nUh/2VOCg0zxuc//bSKfeeypTBGz74+NwCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nv6VmYAfGBmh55KkjLhZDHaqIO0ewAcl/qpyPjd6CREJqCzuabfSGzIPFRmKBAPkAolQV7+6jEYEXhyaRYbjYYsvxZWJHpOWqFaK3pM57L75i7AXcRbFHqXDF0XZU+c9/y2EnqJ3QadpeFrFKsRm/1OpfMeSU5YCUsb82BwZXOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=N4hVff0g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55R4DChe009538;
	Fri, 27 Jun 2025 07:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VTNwDhChWcJTPQ6bt09bczxVdFNDpFkawtS+7JbK2Ig=; b=N4hVff0gnbqG9Jrn
	Hvhe7YujAZLzcX2oDEo4wgTkbqxogzZseHA7tMCDqk9slwwGmmBPZSH/uzMCOIBu
	ChtSAdwkHvCQ8A30Zw/HlYtoY/6P14nyKx9oYXoGG8I6LdB4B3uAzwoThY5r5Oca
	aj/pDwIO2hdIctrziMEjvW6xiXWL6FUkVVaUrG4UpNjY3xmjmIQa95xGJn4WrGSc
	3e/cY07AcTkQEHxD1NgdzsVoi31EkcxseRoyDOONI6/SIM1wqMtgimovpNevnQbR
	MEh6tQlXMAlWs4g06oikAH0MSJMODZAp6aURWcAYuxtJ4oyrU675FodWY7sh1XdB
	pu7puw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f4b45vb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 07:53:08 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55R7r7AS009569
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 07:53:08 GMT
Received: from [10.216.46.83] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 27 Jun
 2025 00:53:06 -0700
Message-ID: <cb60cdc5-f74c-4238-a7c1-e8ddfea28631@quicinc.com>
Date: Fri, 27 Jun 2025 13:23:03 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v4 0/2] wifi: mac80211: Fix Rx packet
 handling in multi-radio devices
To: Johannes Berg <johannes@sipsolutions.net>,
        Maharaja Kennadyrajan
	<maharaja.kennadyrajan@oss.qualcomm.com>
CC: <linux-wireless@vger.kernel.org>
References: <20250612121127.1960948-1-maharaja.kennadyrajan@oss.qualcomm.com>
 <a4a41f5549a1becb441264c811e4378e6a0ee7bb.camel@sipsolutions.net>
Content-Language: en-US
From: Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
In-Reply-To: <a4a41f5549a1becb441264c811e4378e6a0ee7bb.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDA2MiBTYWx0ZWRfXzhmg2qJBMJRD
 0pTMLLcoPjlfME7JrURFip+g86pBSRChPuoVYDL8dLYaMTGHMYwE/bm8qSZOVn+TlmKRDC5WHyd
 BkxJXOkkBG9GJxxptkU/GtrHgVqlRZOsPnGqQxnFoq56vG9IlHlcomf5nBHHXWH5m73nu1ISgJH
 i3fIYeZul2ZT/gBk7wehIz3kRn3+xUspvOrsYjpYfzQ3Nls6E+wxCHtB/s3z5eKCVL147riVjZh
 nAj4/+8a8QU6WC/5IHnYwypFj8jek3QVwI0QNUhXsoJ0y2lhianReQcD80P64nFEdOXh35M1bCo
 3PMVEeccSBpCNugMYJz9Ln8RzZgq5HCs5xJWL+7GZ0qYyQI9/3WuOvpSiHvHdQ4UTHsdLFT3fzO
 esrKvQZWPlelvBcOmirqfeYUgXEWM5rEkFuft1kIfJ47JATthDu7iamVGY9VPGPiNsQZTuGB
X-Proofpoint-ORIG-GUID: TOaSudexLdfkUo3_68MnxGGCIBao_mpj
X-Proofpoint-GUID: TOaSudexLdfkUo3_68MnxGGCIBao_mpj
X-Authority-Analysis: v=2.4 cv=A8BsP7WG c=1 sm=1 tr=0 ts=685e4de4 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=KesfzlC_kwqETzpDSLgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_02,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506270062


On 6/24/2025 6:51 PM, Johannes Berg wrote:
> On Thu, 2025-06-12 at 17:41 +0530, Maharaja Kennadyrajan wrote:
>> This patch series addresses issues related to the handling of Rx group
>> addressed data and management frames in multi-radio devices with ath12k
>> driver. These frames don't have the destination station information, unlike
>> unicast Rx frames, and are forwarded to all the active sdata of the device.
>>
>> This happens because currently there is no check to ensure if the sdata is
>> running on the same band as the frames are received on before start
>> processing those frames.
>>
>> The patches ensure that packets are correctly processed and forwarded only
>> to the appropriate interfaces by mandating the ieee80211_rx_status::freq
>> for group addressed data frames and check the operating frequency against
>> the rx_status->freq and forward to the appropriate interface when the
>> frequency matches.
>>
> This series fails hwsim tests due to lockdep complaints.


This is because of this macro for_each_link_data() using 
sdata_dereference instead of rcu_dereference.
Will fix this in the next version.


>
> johannes
>

