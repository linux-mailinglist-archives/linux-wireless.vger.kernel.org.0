Return-Path: <linux-wireless+bounces-2597-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAA983EB58
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 06:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39DB01F24295
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 05:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B041014274;
	Sat, 27 Jan 2024 05:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YlhbxCQu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8657F
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jan 2024 05:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706334418; cv=none; b=vFS3vh5q3XHCQOSS1/NNW6HmymJWWKdISvmNpKxtauvM+aHkAIZTvULYSuXtBP89APEO+q15hjUzhiy9PXMgfHPn/hepL1imAzFDKY/PQ/Xo9aj8pz6OJtPlCnnxoGfWRFCX7Iz/ESdAoEWmtD3oHuFYj3RwchAQsdgYf06mh9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706334418; c=relaxed/simple;
	bh=XA6vmW8i+/PD1fv/Kmmacuycq+M29uwljcq3/DGYo10=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QY5GuXMvQaR88bh6bUyR2LmuroXGf7s3/7ux9I9/zEYpeEvfP3tgCyajJhis4YBDSIh9jB5Qe7itsguycEMrWnFhF9zfn5ASWoYa7Ee1jNZAHYOptt/Q9AAeUNTKMpwGxMPke7nhvt61eFb0yaL0xnB1TUPiBT/qxjTeFydMMu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YlhbxCQu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40R4eXC6030899;
	Sat, 27 Jan 2024 05:46:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=b8LqddyNZIutMabBlK6oa5hjo085FyGn9so3nMbVHIk=; b=Yl
	hbxCQu0b1/URJXQl5Qj2dS0qlh+NLX3+yphTF9Oor4I7fy2aQHZcFMrlqFYx21UJ
	J+Fe6gonPcU74jDprvXE4MOEY0sdqsFeT/HgMLjcHhQaDSsa1A99fPB/ecazWaYH
	qJCWDYgY1BivLqqIvbGkncKokc0qKZT5DiAaZHcLGP3ca2pifNOb8Y2qkcarwaGW
	7AzLATsbJ+kgA+W+vdKMSn+Ulps0JQSSX2xOTgd0IYkGNoIAIz0QQz9iA6FuGQBT
	NJA9w00IojAXPGCjdXqBCrIj0i4+Mf8SEiTm7sCFtgJTOdTNAwMsziG56OcoV/GB
	NYCna4luccI7xvcyNm2g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvs5p061v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 05:46:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40R5kq1O028309
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 05:46:52 GMT
Received: from [10.216.58.0] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 26 Jan
 2024 21:46:50 -0800
Message-ID: <9e03fd16-4109-4304-9539-2967c93e5e93@quicinc.com>
Date: Sat, 27 Jan 2024 11:16:47 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] wifi: mac80211: add link id argument for sta_flush()
 function
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240125125855.827619-1-quic_adisi@quicinc.com>
 <20240125125855.827619-3-quic_adisi@quicinc.com>
 <3a56c591a03a17e4ad1332b88bcd5790346cdc7c.camel@sipsolutions.net>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <3a56c591a03a17e4ad1332b88bcd5790346cdc7c.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EflqqglJRMxOhmfTDe0A6xOKIkqCzoGl
X-Proofpoint-ORIG-GUID: EflqqglJRMxOhmfTDe0A6xOKIkqCzoGl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=854 malwarescore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401270041

On 1/26/24 14:41, Johannes Berg wrote:
> On Thu, 2024-01-25 at 18:28 +0530, Aditya Kumar Singh wrote:
>> Whenever sta_flush() function is invoked, all sta present in that interface
> 
> STAs
> 
>> is flushed. However, there is a requirement in case of MLO that only flush
> 
> are flushed; The sentence starting here could be reworded.
> 
>> those sta who are using a given link id.
> 
> who -> which/that? They're not people :)
> 
>>   This is not possible currently.
> 
> reorder the words a bit here?
> 
>> Hence add the support for the same.
> 
> I think (and hope :) ) you can improve the commit messages ... Maybe say
> "Add support for this by implementing the new cfg80211 API ..."
> 
>> Passing link id is done currently via cfg80211 op - del_station.
> 
> The mechanics of this aren't really all _that_ interesting unless
> they're really complicated - we can all read the code if we care about
> that part.
> 
> johannes

Sure got it. Thanks for all suggestion. Will address them in next version.

