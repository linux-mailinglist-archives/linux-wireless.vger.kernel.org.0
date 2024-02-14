Return-Path: <linux-wireless+bounces-3593-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2F8854F3E
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 17:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65DA1F21625
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 16:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC660604BC;
	Wed, 14 Feb 2024 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lQDi39L+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468C860DC2;
	Wed, 14 Feb 2024 16:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929869; cv=none; b=tWRMS3TE4b8QaKm9ZxIXj+vUPY6RM/LCONjhFBMURkk+EfFwe87QDjUnFS+qgFlhNryB6O0MKdpEz1XfE7VtkZUrXsignWANYvRrkjvNNcpfVSBu3oVCmGtrJ3r891G5ui5rIwFsW+hlIKNcGZifYUt7JScoUiRvGBaLPlX9f1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929869; c=relaxed/simple;
	bh=bHjsv3Dqq5tJu1jXyCBKwRegCnc+WTLnw6hQn8pGFdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a5tktyb8kP16yARc0xsTf2CCqyr6GvKk0ZySqowuNlL06KaXpktRnddm8lhf6Jl5oyJw4qz6ll+rVNiy2QVg0YEzyA3+m2o5umOv8/BweTYC5rzpn0jkrWgc6Zs0DZmpGldFludhFQ+mBUV/Gpy8PmMxXyRdKwzqWbtUaSgEZ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lQDi39L+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41EDpr7l016391;
	Wed, 14 Feb 2024 16:57:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=A5/2i+d4cJP3/60L5tMUEpskhePWx2EdlGQ/W9UG2eQ=; b=lQ
	Di39L+AEIzJN08BKF0NUKFAzXaxvjLSQItwYbb5iZIvlcVL8Ctp3eRI6gfVh3R8Z
	xxuzHQllsycusDnguTN7A/VKGX31nhwJMrZ73rL5F4Uq2g0RZSmhnPNTeRl6E+8Q
	drBcu8bXAFaxn85QomxoNxFaYubC2ctDasRSxJZOupsjQy7n+pmf8tuJTmS2DQAt
	nVZm39toAdxSTAUXCn6iY+1tz/XVGUthS5HSpzC4l4KkI4zLIe4uJ0+d11nbCoUz
	qhThdyTTfKDvJEeLhpAuM+9LcvTyYaLHHHS3awxjQ38TDecjcpB/sB6KqF2tfu+f
	aLCJFj6x5F+PdnEi/Vpw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w8myg1kew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 16:57:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41EGve4U019335
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 16:57:40 GMT
Received: from [10.110.88.210] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 14 Feb
 2024 08:57:39 -0800
Message-ID: <0da40ae1-c033-4089-a64e-27d16bce7ab6@quicinc.com>
Date: Wed, 14 Feb 2024 08:57:39 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] wifi: nl80211: Add support for plumbing SAE groups to
 driver
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
        Jakub Kicinski
	<kuba@kernel.org>
CC: Kalle Valo <kvalo@kernel.org>,
        Vinayak Yadawad
	<vinayak.yadawad@broadcom.com>,
        <linux-wireless@vger.kernel.org>, <jithu.jance@broadcom.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        <netdev@vger.kernel.org>
References: <309965e8ef4d220053ca7e6bd34393f892ea1bb8.1707486287.git.vinayak.yadawad@broadcom.com>
 <87mss6f8jh.fsf@kernel.org>
 <2c38eaed47808a076b6986412f92bb955b0599c3.camel@sipsolutions.net>
 <20240213174314.26982cd8@kernel.org>
 <6641f3f90bdc1d24f3a7fd795be672ce02685630.camel@sipsolutions.net>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <6641f3f90bdc1d24f3a7fd795be672ce02685630.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Kx9ea3egh2xxbCUPzUjaLRaOBrcrUXS-
X-Proofpoint-ORIG-GUID: Kx9ea3egh2xxbCUPzUjaLRaOBrcrUXS-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_09,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxlogscore=408 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401310000
 definitions=main-2402140131

On 2/14/2024 2:27 AM, Johannes Berg wrote:
> At which point, yeah, I'm putting my foot down and saying this has to
> stop. I really don't (**) care about Broadcom doing their own vendor-
> specific APIs if there's zero chance the things they're needed for will
> ever land upstream anyway.
> 
> (**) No longer. I used to think that being more open about this would
> encourage folks to start a journey of contributing more upstream, but
> clearly that hasn't worked out.
> 
> Now this is why I used to be more open: I will also most definitely not
> accept all the vendor APIs upstream if someone later decides they do
> want an upstream driver, and then push all the vendor stuff on grounds
> that "it's used now and we have to support it" ... We don't, at least
> not upstream, what you sell to your customers really isn't our problem.
> 
> (And to be honest, if customers cared, we'd not be in this position)

I feel a need to respond since, as part of the thread, Qualcomm was also
mentioned, and rightfully so. In addition to our in-tree ath drivers we
have multiple out-of-tree wifi drivers, some for mobile-based products
and some for infrastructure-based products. And we have also contributed
patches in the past that were only in support of our out-of-tree drivers.

There are good reasons these out-of-tree drivers exist, but there is
also a movement, at least for the Qualcomm infrastructure products, to
transition to an upstream driver, in part due to customer requests. So
it is disconcerting that you are talking about inserting barriers to
converting to an upstream driver. Converting from an out-of-tree driver
to an upstream driver involves significance NRE cost with little to no
revenue gain, but that is something Qualcomm is willing to do for the
driver. But we need our userspace interfaces to survive since both
Qualcomm and our customers have years of work invested in the existing
userspace interfaces and applications. The customers who want an
upstream driver do not want to be forced to rewrite their applications
to support it.

In the kernel we have a clear mantra to not break userspace. That should
hopefully hold true when converting from an out-of-tree driver to an
upstream one.

/jeff

