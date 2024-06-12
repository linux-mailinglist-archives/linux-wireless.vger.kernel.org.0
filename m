Return-Path: <linux-wireless+bounces-8845-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C57904EDF
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 11:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07C961C208FB
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 09:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AD116D4C3;
	Wed, 12 Jun 2024 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Jt9ko12J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8726516D9A0
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 09:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718183599; cv=none; b=rB5leRxHz9+Ks3C9iC2gdfICUIP9IUrtEmkQhkzdp7Q7YtgE02uhKHc/SnrhBIElHwAjXa4ZXwaEY8900Isw3wPihV67OJto8TMFphLYEkmJKoQGe56wKzfFcWHkE/t0JIxc9wNB30asziPnmt/ZBe8u1Ghg72rQax3HFG1/sy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718183599; c=relaxed/simple;
	bh=XrwOQ/gyBVdelGpOqpGJ+oKgljajkKFUTiJVw7kLKxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FXalUTCTvlIMkC+Cx8uhPXXXoEHSDP/jRot4dpKx1AyBIQeujXRCcYoTGQhZD31ciQ5UAbRmvx8ua5LK19mR2aSGwIEa7+W7totNOkyJJjSCdYP5jMsrm95mpnhnH0CwNmrcm2m5KtqT9Uw7kStoVy+jwF3tbdUlhDpgBzVujNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Jt9ko12J; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45C2Vklv008629;
	Wed, 12 Jun 2024 09:12:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Yk63//nEM+nr3n79J4vWVyQ84P+GeX0qcVy1yICizkA=; b=Jt9ko12JJNO8MOQO
	qFnMnUCOUoUwH9WRLMu+vHOwe3w9BWKhHqDUX+plDSBxGSsL3Fc0RuTS0SReaqcW
	PW3wSRJckTU4sly+Oomey6GlAWQiMY3K+T/abk9yIDlgKGM5yuLrbepzcZcR8mpc
	Kbg1dDZ8bDDFVig9IdbeYKxcyaDyicc6uyzmCvohW8TORB8T0siJ6wZdXfD1XMaA
	ayayxeZF82r2WFjA+J1WxxUV1l0PSu2c7H16HM9sWlNK3x+I20ZGviiPmS+01TvU
	mf+VpRslFUEsyMKIvEDaxtQ2mjSUbdD2jFpZmsn0B9rInnlRf7zLWhFJHNAKX6Dr
	hdkEsQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ype913raa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 09:12:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45C9CwV2018738
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 09:12:58 GMT
Received: from [10.216.60.112] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 12 Jun
 2024 02:12:55 -0700
Message-ID: <ba4be7bf-012b-9e4f-c33d-01cc0d039377@quicinc.com>
Date: Wed, 12 Jun 2024 14:42:51 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [REGRESSION][BISECTED] wifi: RTL8821CE does not work in monitor
 mode
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
        Ping-Ke Shih
	<pkshih@realtek.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Savyasaachi Vanga <savyasaachiv@gmail.com>,
        Christian Heusel
	<christian@heusel.eu>
CC: Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>
References: <chwoymvpzwtbmzryrlitpwmta5j6mtndocxsyqvdyikqu63lon@gfds653hkknl>
 <a51f223f-18ac-4d67-9120-8da1c169b7eb@leemhuis.info>
 <809d2332-625e-4a46-a77e-ca2e49b0d651@leemhuis.info>
 <0e65ca6b471b4186a370b9a57de11abe@realtek.com>
 <36c1f49acfcc2cc16c7e54ffeb76f1e93cb96e91.camel@sipsolutions.net>
 <5318640d6eb74301b1fbf6d9385ba69e@realtek.com>
 <6a88e0d3e47ebbd1f0f383094e4804a627c41870.camel@sipsolutions.net>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <6a88e0d3e47ebbd1f0f383094e4804a627c41870.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -7EOd7-WpFJv3MhVVXx-aV3y2-dEkD6m
X-Proofpoint-ORIG-GUID: -7EOd7-WpFJv3MhVVXx-aV3y2-dEkD6m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_05,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 clxscore=1011 mlxlogscore=741 impostorscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406120066



On 6/12/2024 12:37 PM, Johannes Berg wrote:
> On Wed, 2024-06-12 at 00:56 +0000, Ping-Ke Shih wrote:
> 
> 
>>> Just got pinged (sp?) about this, can you share the driver fix so I can
>>> take a look what the issue is about?
>>>
>>
>> Please reference patch below. I copy this idea from rtw89 [1], which the main
>> stuff is to add WANT_MONITOR_VIF and case NL80211_IFTYPE_MONITOR in add_interface().
> 
> Ah, OK, but that gives me a hint. Yes, I see the issue now.
> 
> OK it's not trivial and it might leave ath12k still not working (though
> not sure it ever did before? or maybe I'm missing something...), but I
> think I can fix this. Let's see.
> 

Monitor mode is not yet supported in ath12k, this feature is work in progress.

Vasanth

