Return-Path: <linux-wireless+bounces-4724-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8203787B6CF
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 04:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CDFA283793
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 03:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2E8F9F2;
	Thu, 14 Mar 2024 03:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W7vAQkyn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C09F9DB
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 03:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710386565; cv=none; b=qWGTyzr3hRz6QCDnqtbJ99/3dY+sdYXnot/8tjozw3CslhU3yl0KtOnH/LLSQlr7Unsp14nFUV8oGfM3MSGEVrnz7S64hP5XaHBYtLtK52t5BDHE9ZouwlMX0haGIo/kNdGzrfQAk8VifS9mFlJnmziuEbKcKDDPw4RSmppYzY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710386565; c=relaxed/simple;
	bh=0LtvBnfwcRgXsRgcjOAuYTBzydCZQud6NvlLPhE4UrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=elmwg83BMUQA5Zyf9yCoODuBbksdYeATLXyj8eKXfYkKSiLTOM/Ycgj9Q9o2z9Il/qU7N01uwu9EkVJ44ipEhNhBEQm2hjZsGIMkORUvMi3znUdRe0UszpNFBKi/cQOgP3naoW7b/cDhv9glGseKSe4hFbXjIzYWDmj04NH2Gh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=W7vAQkyn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42E1FwJm027195;
	Thu, 14 Mar 2024 03:22:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=EAmrHMQaRhpNKwTcYiIzpc+fyv8/JvxKZ7z8xq0tZT4=; b=W7
	vAQkyn+QAjjxQdZlickSQQCP/7iWhJRxxN3eM3FqBLlLNF78V17iSVPi8DYCdzoA
	7NhRgMLHv+QyeOGcBHbPxgYUiIQRYAAnc9FrucWj83rN+00tzOOz3U7KTnk4ttVd
	Wtx6egH++nXbEHKAtmwvFnK3XqMUK6QtPg6EDSoBUW57i2rA1cjT2oV9UAieCSyI
	fznMYbFC0NPRkEYxbHlJ6+xAf4+DpEG9Pga3eTajvcquAw8UCnHwbug335/oeLUe
	euDPfm+aWggeWDsljk8PMnPFkFNkgOsJZcMrkVYrXPAQRT1OYsCsVLaChhA96Lu4
	o/nVNCtoVMLgQqG/cO+Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wuc5f9ty6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 03:22:36 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42E3M1bX026185
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 03:22:01 GMT
Received: from [10.253.38.102] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 13 Mar
 2024 20:22:00 -0700
Message-ID: <4f79391f-cd81-4a3d-a236-447cb4c1f4d2@quicinc.com>
Date: Thu, 14 Mar 2024 11:21:58 +0800
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
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ea00wEw_5WFrFE92N0m03flU5jqox_Hb
X-Proofpoint-ORIG-GUID: ea00wEw_5WFrFE92N0m03flU5jqox_Hb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_11,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=955 spamscore=0 phishscore=0
 malwarescore=0 adultscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403140020



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


So what are you planning to do with this patch?

Any suggestions or you want to add puncutring bitmap parsing by your patch?


> johannes
> 
> 

