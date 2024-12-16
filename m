Return-Path: <linux-wireless+bounces-16424-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 610289F38CB
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 19:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 424D91898801
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 18:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907071119A;
	Mon, 16 Dec 2024 18:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="njHugKE6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9A4204569
	for <linux-wireless@vger.kernel.org>; Mon, 16 Dec 2024 18:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734373021; cv=none; b=DB0B4jGprawdM1SDNsomX3nd8RHEOL+dw39DKGGKY6lnkG+HoBqB0I/yZOrRe0lC8+AnSYMOi65//iNMZBLlKDAPbTCrIfq8AtNfoEl27bS4UlE1XFs9AEM/Hy00aBBvd36tTrIUqheKMhtAR1KfNVy7znaZK5rGIHKySSf9P3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734373021; c=relaxed/simple;
	bh=emwdqpwdGi9WXHFDI7FlK2Q0KaSGe6nS9tJE/O3LYLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PDLRGAYeuzKCPupwz9tTArbwmB9dbzODIsYuc9m2jtASGNQv8HU71shn+bifDdekxEnQ4kG4/tIsTXkeQXcoivGIi1k3vrcsIfpYTerXCg0B5kEmzzCQfdvowZV87VE6lq29SUAZkSkl7wnerqUhyRvif9bv5mmvfxTOcIzujVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=njHugKE6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGCjZWF032234;
	Mon, 16 Dec 2024 18:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Dy6OD2kfOq5jZtRwgqLyHz97eQClXLTknziBS2FSwz8=; b=njHugKE6pWy9FTwI
	KHZK/mHqv/2WKebaW2fFHVu7Q1PlcHhXt8JWyoW8YUHdKHKnNZg6KEB0DJ1LX3n2
	10/FTR+pSXAGAN4ehQrLTP32FPSQSIJMelzOghJAr98E+yzAQsKcSyhS9w76Fjje
	JW0sDuy7p7nJ1ZmfG3Ls8a57b/E8Xxwl2iFrM2yhnAMgAn/u7CZcJIqcOVt5+Hv4
	pxE0K/Lm2aMERJmbze0f7Ymh5z1ITCN8jA9Xk1fT1XYz0eGsxJPm1POcx34HqYtA
	dBRTUQqR2pau2SzY3bd6qY/xe9I3JlSRGk25U75hdEC/ti8+g7c4txscqO4H3Zuj
	LNxQcQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43jmgagvc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 18:16:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BGIGsYn029961
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 18:16:54 GMT
Received: from [10.111.178.85] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 16 Dec
 2024 10:16:54 -0800
Message-ID: <a78e51f4-ea73-4d46-8893-07dbf4c9a2a3@quicinc.com>
Date: Mon, 16 Dec 2024 10:16:53 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ieee80211: update Indoor AFC standard power type
 definition
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>,
        Veerendranath Jakkam
	<quic_vjakkam@quicinc.com>
CC: <linux-wireless@vger.kernel.org>
References: <20241213121146.2398269-1-quic_vjakkam@quicinc.com>
 <a850fd692db3458301eb5b7388110a3ec6ec0d01.camel@sipsolutions.net>
 <11d8f3a6-3942-44dd-9c41-fdc645e5fdeb@oss.qualcomm.com>
 <42e0e767b0dd55c8ddaca0cbf6aa123ec8fa3942.camel@sipsolutions.net>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <42e0e767b0dd55c8ddaca0cbf6aa123ec8fa3942.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mhH52YrNOeMQ0GjoGhuQPJ3ledmqUz_T
X-Proofpoint-GUID: mhH52YrNOeMQ0GjoGhuQPJ3ledmqUz_T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160152

On 12/16/2024 2:54 AM, Johannes Berg wrote:
> On Fri, 2024-12-13 at 12:11 -0800, Jeff Johnson wrote:
>> On 12/13/2024 4:16 AM, Johannes Berg wrote:
>>> On Fri, 2024-12-13 at 17:41 +0530, Veerendranath Jakkam wrote:
>>>> Update 6 GHz regulatory info subfield mask and Indoor AFC standard power
>>>> type definitions to align with spec changes introduced in the Draft
>>>> P802.11Revme_D4.2, Figure 9-896 and Table E-13.
>>>>
>>>
>>> Huh. That seems like a change explicitly *designed* to break backward
>>> compatibility? Should we accept the old value from older APs or so?
>>> Otherwise we can't connect in some scenarios, I think?
>>>
>>> Or at least should we say here in the commit message or so why backward
>>> compatibility was broken, and that it was for other clients that didn't
>>> behave well or something but our code was already fine?
>>>
>>> Or am I completely confused about it?
>>
>> IEEE Drafts sometimes make non-backward-compatible changes.
> 
> Umm. Me voicing confusion isn't a reason to state obvious things back to
> me as if that explained anything at all?
> 
> In any case, they actually do that _very_ rarely (these days at least,
> that was different 20 years ago I'd say) without taking existing
> deployed things into account though.
> 
>> This change brings
>> us up to date with the language in Draft 7.0 that was ratified and will be
>> published as IEEE 802.11be-2024.>
> That's not what this claimed in the commit log.

You are correct. When writing my response I referenced IEEE 802.11be Draft 7.0
when I meant to reference P802.11Revme_D7.0 (since that is the latest Revme)

I've been so focused on 11be that I completely messed up the reference.

> 
> It also _cannot_ be correct since this stuff is in baseline as far as
> 802.11be is concerned, so it really cannot make incompatible changes
> that suddenly make all HE stations non-compliant.
> 
> And now that you're forcing me to look into it, I see that of course it
> doesn't do that. This has nothing to do with Draft 802.11be in any
> version which only makes one simple change to Annex E to add 320 MHz.
> 
> The commit log claims that REVme changes it, and while that might be
> true, looking at REVme (I don't have a redline version at hand right
> now) indicates that certainly it didn't make it backward incompatible,
> it now accepts multiple values and accepts the old values.
> 
>>  So if anything breaks, it is because it
>> hasn't been updated from the draft to the ratified standard.
> 
> Clearly not.
> 
> Suggest you go back to the drawing board with these changes.

Veerendranath, can you follow up on this part.

/jeff


