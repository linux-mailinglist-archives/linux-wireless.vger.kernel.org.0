Return-Path: <linux-wireless+bounces-5293-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A6D88CC0A
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 19:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13AE21F8361E
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 18:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B5C84FDA;
	Tue, 26 Mar 2024 18:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EZu1VO9f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577F41CAA6
	for <linux-wireless@vger.kernel.org>; Tue, 26 Mar 2024 18:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711477910; cv=none; b=eMgl5n+42X5C1PFQqju8T9D7QJwUUJsD0ADftiKftwV8df0tVydIkFGemLwpdQs+nVL6yJC7tjaugieU7pe/NyszcN5M0AVpdJgTGOUj9pv9NCz7osaXeXm8aRTMBkusDes+7fyJ1UmtuCWqk435u2WxLlFxxPVchYFTj5wGk8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711477910; c=relaxed/simple;
	bh=8JUlIWLLGWxEyA/HAr89xoqy4UiJHJnr3e2FJ4TRLtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UEBG7BNdV9oACOcHIX/lRS5xlKCBK2SI/x1D+csWYZ4TfCSjm5eHV4Mghjh5eb0Kr3+KO3Qk1Jw3O8bRfmiIoWts+39+gBU9QMGJ2qlNsXmv0hIc4VZ8rhTR3xm+qs4ZSnKGaSz0+R4XFwZj6MmPPVH8Ixvvo2x6NO+/5TtB4/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EZu1VO9f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42QI9Xrd001003;
	Tue, 26 Mar 2024 18:31:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=mh9v77OTAT+zRJ8lG1yREsapsoklakuL3iIBWfvkNTU=; b=EZ
	u1VO9fXvWhBjXgdc9VErNDMSz9xGLvsX9PHEcU7L5sOiRZUP5KiLISrd2V6/6IKH
	zKe7FJskVSSUZezrtCm7EhyJrfafru4mLPtwawt7aLnrMPaSIuzjtMPbtoMvZt6g
	Vmq0pZwyDEkk0+IA7UXPTq4zrApi6jSZi9ObNAZ1CyTmDufWWmnVM+k/dv6PEE9N
	3zxB+CqIHJGPcBUdorWvr3qHriPcEfw5iYJBS4dElPA9Tbrlsng6KyxF6IJtEL+r
	TdX871akpgC4Lb6gfML/hw2+iNjeT4ykQyfhB9kcoqYkbrcIgN4wQNj98hU15pSy
	WB5D7Bo57gvWyibQtScw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x43byg1r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 18:31:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42QIVaO6020842
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 18:31:36 GMT
Received: from [10.110.10.42] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 26 Mar
 2024 11:31:36 -0700
Message-ID: <b4fb2e9f-b7af-42da-be97-9ae1560ebad2@quicinc.com>
Date: Tue, 26 Mar 2024 11:31:35 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] wifi: mac80211: Add EHT UL MU-MIMO flag in
 ieee80211_bss_conf
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240325201031.10837-1-quic_pradeepc@quicinc.com>
 <20240325201031.10837-2-quic_pradeepc@quicinc.com>
 <8efc258b698acd504c1fc699d026b906bf383894.camel@sipsolutions.net>
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
In-Reply-To: <8efc258b698acd504c1fc699d026b906bf383894.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oEywFPi1G61Vp-7O_LFNpqAeEN65EUXk
X-Proofpoint-ORIG-GUID: oEywFPi1G61Vp-7O_LFNpqAeEN65EUXk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_08,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1011 impostorscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403260133



On 3/26/2024 6:00 AM, Johannes Berg wrote:
> On Mon, 2024-03-25 at 13:10 -0700, Pradeep Kumar Chitrapu wrote:
>> Add flag for Full Bandwidth UL MU-MIMO for EHT. This is utilized
>> to pass EHT MU-MIMO configurations from user space to driver in
>> AP mode.
> 
> This ^^ doesn't match this:
> 
>> + * @eht_80mhz_full_bw_ul_mumimo: does this BSS support the reception (AP) or transmission
>> + *	(non-AP STA) of an EHT TB PPDU on an RU that spans the entire PPDU
>> + *	bandwidth
>>
> 
> which doesn't match the implementation ... Wouldn't be a bad idea to
> actually do what it documents though, I guess?
> 
> johannes
Thanks Johannes for review.
can you please help clarify what you meant by "actually do what it 
documents"? This will help me to amend next revision appropriately.

I have tried to describe what this flag is trying to represent. This is 
part of EHT MU-MIMO capabilities and driver may want to look at this 
flag for MU-MIMO configurations.

Also this follows other parameters added to struct earlier.
example: 
https://patchwork.kernel.org/project/linux-wireless/patch/1665006886-23874-2-git-send-email-quic_msinada@quicinc.com/


