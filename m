Return-Path: <linux-wireless+bounces-7082-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744E98B8E94
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2024 18:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BD87283BE7
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2024 16:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17BD134CC;
	Wed,  1 May 2024 16:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZSH31iQm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3803610A2A
	for <linux-wireless@vger.kernel.org>; Wed,  1 May 2024 16:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714582539; cv=none; b=R/8O9/Gnf/t1WGd+9W4I/Hyj3j/wZj7UZePTJwxaSyflOqs020BaGBEbRxAI++VyQITHt6Yj1XrL+aclJ+vXlf1LfZIE1ZNIHmS31lgDuW3t3uSWvf+B82pAKZ8xF0E5mw0yTgUryRLU8Qf5JmlocflLxwlw5q/9xNAdX8AyUVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714582539; c=relaxed/simple;
	bh=VgZTPZcjmN1Q7XQH0PWW2dhory2kM7pUNFP0GQyh7hU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ld/iexrbLREb90c4Y1EMEN4gE2MQpqYOEW7vY7ITuPW7E3u7q84Z0Ha01nFAYYlQgkirjjkUSgpgK2par5xiI6C2HT8BtAu7AB6jXQTPvRm6AbZTTp4NRepsR4uCEW9ACZ3BjTUCbB7iuvxYAo0WaUXANipvUiBHXoifano5UuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZSH31iQm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 441Go61Z020952;
	Wed, 1 May 2024 16:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=XRpm/sdx8K4n8j1vToaQ8zfiJF4VvppikFnC1BBmYhc=; b=ZS
	H31iQmRY4scxDiFPwxDu5mRwTv+I0ii1g730E0YluOQsmr6V0VUyRdQCVS4cvXe+
	eyPAbjCwkNpDmSjuNDprEXPBEv3qd9gaNOUoW9TD9nnfKxL41wuNkxDvd3xHFulc
	o8IRIIj5VO/rqje8h/YBGvUzc/JAfzwSyn0wspmPvmNoxdUTN33Ydvv1I4mgtHNE
	JbG69n9qjBfWsyc7ld37Fa9m5BzQzidJ8BfXQH+FI9WqFxXOYL8A7/hi/pID5a7x
	gIByorwn7LK0XIrIh9VreFcR0XTzS24z12yjG7H09onL0U9i82rLWEaxaUdtECym
	DzgjAA1m48fJBYte8l9w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xu71ja0k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 May 2024 16:55:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 441GtVNq011542
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 1 May 2024 16:55:31 GMT
Received: from [10.110.13.147] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 1 May 2024
 09:55:30 -0700
Message-ID: <b9fe599c-a0fb-40ad-9cde-0bd311ce17b7@quicinc.com>
Date: Wed, 1 May 2024 09:55:23 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] wifi: ath12k: Introduce device group abstraction
Content-Language: en-US
To: Harshitha Prem <quic_hprem@quicinc.com>, Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240425055759.1181165-1-quic_hprem@quicinc.com>
 <87le4voyka.fsf@kernel.org>
 <824269da-c69d-668b-4e6b-d0453c4572c1@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <824269da-c69d-668b-4e6b-d0453c4572c1@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6gbE9shhYxB5viRE32Y36hov9MjMSKw1
X-Proofpoint-ORIG-GUID: 6gbE9shhYxB5viRE32Y36hov9MjMSKw1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=621 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2405010119

On 5/1/2024 8:34 AM, Harshitha Prem wrote:
> 
> 
> On 4/30/2024 5:24 PM, Kalle Valo wrote:
>> 47] WARNING: possible circular locking dependency detected
>> [  147.211599] 6.9.0-rc5-wt-ath+ #1403 Not tainted
> 
> Thank you, Kalle, for sharing the full logs. Unfortunately, I did not 
> see this warning in my testbed with QCN9274.

I didn't see it in my testing either, which caused me to look at my .config
and notice that I didn't have any of the lock debugging enabled.

Have fixed that now.


