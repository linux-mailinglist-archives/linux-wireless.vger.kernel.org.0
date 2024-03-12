Return-Path: <linux-wireless+bounces-4591-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D50878FEA
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 09:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1F71C20ECC
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 08:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90FF77A0E;
	Tue, 12 Mar 2024 08:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EiWhH4Pi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F82777A1E
	for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 08:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710233166; cv=none; b=Dc9bS+t294B9nZ1N/rd8Ge+rHkZHab65kyF1xofoNVYEUnYbHnrvzMNULImMdqXQW/Z5/aHdcEF/dt+v091G2L4HOHM4BjnkFnq44bznRl9vhU7/ooHdjlu3zPaw0HOO62CQOC6SSsndlTvfKdSWVSwWoYzmgCn8MywKkGx1Mlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710233166; c=relaxed/simple;
	bh=5Lmee2aKeDzUsom+LMdI8CHYrYhgXGTVGomld06XDH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h5s10zjkPl1Ijh6TYNbj1D2meZhE+JJ2dljnaURFjhY9h83wi+c2SfX112SK+DbBaVQLKWMTd7T8LhWGyUAp3adih6a2SuIZIidvZh6I2YJBhzSpobnV1PlYH2r4ynCvt441WeBttcNXKOFvUEmYcjTOE43AMMfiOY3C9+S5jpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EiWhH4Pi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42C6POe9024085;
	Tue, 12 Mar 2024 08:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=1+rSUVWfCzdIkoheg30LFd7Q7z9zAOEXR0rnTbQBLXc=; b=Ei
	WhH4Picu7hRHM3oOYSk3zwHomcSPWZVQgMGQZutLMYsIWJsAJ1JhDBEAXCw5Q8XD
	Ork87I7+/JE0jqjF8kcghnBqq9BktUpAY9FHhkgtVmL93l8zHMgDg69FZErYn9dN
	4QoH7m/DfF6gXh0FS8JmpXoXlZl8fpNirYYxyOgKk2Z0f45tFR6pgHjILiYmgBCE
	H/p5nyyLhl190vLH9ctP8HkLLbm4hwe3atT77PShLa7qIrjWsAZRFXzCAFfxyH0y
	2Hlm2PQnflg9v3YJI5HVkoiUtvWp89ayKToFygcmkGo+42mLsxmxKpenfkDsBUAy
	PEWqpjoOWnYKPsmqlV+w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wthqfr81p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 08:45:55 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42C8js5P011980
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 08:45:54 GMT
Received: from [10.253.9.188] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 12 Mar
 2024 01:45:53 -0700
Message-ID: <3250c791-fb06-488b-9736-aeb0c8d48a42@quicinc.com>
Date: Tue, 12 Mar 2024 16:45:51 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: mac80211: supplement parsing of puncturing
 bitmap
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240312045947.576231-1-quic_kangyang@quicinc.com>
 <20240312045947.576231-2-quic_kangyang@quicinc.com>
 <8cc7e7f7b2914385b481ecfdd7bc3f67fc4546b3.camel@sipsolutions.net>
From: Kang Yang <quic_kangyang@quicinc.com>
In-Reply-To: <8cc7e7f7b2914385b481ecfdd7bc3f67fc4546b3.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IT9hNNU8tNDBmAku01N4_fWcaE3g90h2
X-Proofpoint-ORIG-GUID: IT9hNNU8tNDBmAku01N4_fWcaE3g90h2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_06,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403120067



On 3/12/2024 4:16 PM, Johannes Berg wrote:
> On Tue, 2024-03-12 at 12:59 +0800, Kang Yang wrote:
>> Current mac80211 won't parsing puncturing bitmap when process EHT
>> Operation element in 6 GHz band or Bandwidth Indication element. This
>> leads to puncturing bitmap cannot be updated in related situations, such
>> as connecting to an EHT AP in 6 GHz band.
>>
>> So supplement parsing of puncturing bitmap for these elements.
> 
> Hah, yes, I just noticed that too and fixed the second part yesterday,
> and was still thinking about how I could test the first part :-)
> 

Our AP could set puncturing bitmap manually.

So i just add printk() to check if it matches the value sent by AP.


> johannes
> 
> 

