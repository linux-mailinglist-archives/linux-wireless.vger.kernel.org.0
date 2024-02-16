Return-Path: <linux-wireless+bounces-3675-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B757857F2B
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 15:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254691C228DD
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 14:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48373768F2;
	Fri, 16 Feb 2024 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ao0OOPHF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C23312C804
	for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 14:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708093284; cv=none; b=aZRbAa7I4+OpxSFfc7y83FZ7gyu+bQoBrhpm8MZ5qQNnvhfI8Bdl78+7OI5nH09gHnK53LLUtGMb3raFmK9uB5OZSYglj0fBdugJoqVW67cWZSKZtKRa82oFyIK1dZ6vjG/WnAx8bXlSPBnn4eF9P0un+aieOhGmhWok0As7HMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708093284; c=relaxed/simple;
	bh=0dq78Ui2MRjPTzWquJmFH9TjPzG8VwsKXoeL7frZRoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dwkUjhMefZ1thfJVGsWBpli6IWiDMTgj2NJ94Rb+EPp/O2VedREwiuFY6L6IYQEiV77jXkLeaDOIrQeCSyH/zXDkAekYKPuyIYupBeaQl0vLogpQsZ2fV10olmCmKLstg4+JCL/W0/glN112oSEm6k9EUAVj4l7nfbGRy0uSPfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ao0OOPHF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41GCWD0m021196;
	Fri, 16 Feb 2024 14:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=HZxf/icU1Qn/02SY8MEqluzf3i71l6JSrerFhrnkyKM=; b=ao
	0OOPHFggwuO51oO2aXs8n5acYcmRklBawmU9W7EXueOrlLyc8NE63OlOwNKp4ZeZ
	bhMsDh5/QrNB+x6V2mEyjnmWc9nIdcAeSItEPWSF95kaVoq3PgkFlsIO5OqJ6PQl
	0rOcVJYiv0yghhecpoIMoYpko+NZBVbw/F38rvbA7UtnQ9ZmMxtYSt8IDrHOOVbr
	QixPywuNI9E/LbxafofyAlo4kIDFu9bDm6KPWMn3F4Y7N6yeSPV2fqYgZ1s9CzKN
	8SfnuAxs+diFaewXbtzfG0lYxXVpUkGwOTbyxmHsOTtzEPi1532Ttv6FdMKuxbHa
	Nsl6Dd2cGU98oSSz9iww==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9yta93mt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 14:21:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41GELH5o011852
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 14:21:17 GMT
Received: from [10.216.11.141] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 16 Feb
 2024 06:21:16 -0800
Message-ID: <213c603a-8516-4352-9e38-61ed7bf17a8e@quicinc.com>
Date: Fri, 16 Feb 2024 19:51:12 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: mac80211_hwsim: add support for
 switch_vif_chanctx callback
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240215162811.506065-1-quic_adisi@quicinc.com>
 <20240215162811.506065-3-quic_adisi@quicinc.com>
 <de92380b3ec6d4e6bf854479fb3eca5ae88cf1fc.camel@sipsolutions.net>
 <78c51497-dd6b-4d7a-b789-e3823e89a96a@quicinc.com>
 <e5893311f9a5cf31f2bcb1eff9018e0924f83eba.camel@sipsolutions.net>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <e5893311f9a5cf31f2bcb1eff9018e0924f83eba.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 676-TTfIwa8GSRYN7I2v5Y6ZDtOXevsq
X-Proofpoint-ORIG-GUID: 676-TTfIwa8GSRYN7I2v5Y6ZDtOXevsq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_13,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0
 phishscore=0 clxscore=1015 mlxscore=0 malwarescore=0 mlxlogscore=465
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160115

On 2/16/24 12:42, Johannes Berg wrote:
> On Fri, 2024-02-16 at 08:45 +0530, Aditya Kumar Singh wrote:
>>
>>>> +	for (i = 0; i < n_vifs; i++) {
>>>> +		hwsim_check_chanctx_magic(vifs[i].old_ctx);
>>>> +		wiphy_dbg(hw->wiphy,
>>>> +			  "switch vif channel context: %d MHz/width: %d/cfreqs:%d/%d MHz -> %d MHz/width: %d/cfreqs:%d/%d MHz\n",
>>>> +			  vifs[i].old_ctx->def.chan->center_freq,
>>>> +			  vifs[i].old_ctx->def.width,
>>>> +			  vifs[i].old_ctx->def.center_freq1,
>>>> +			  vifs[i].old_ctx->def.center_freq2,
>>>> +			  vifs[i].new_ctx->def.chan->center_freq,
>>>> +			  vifs[i].new_ctx->def.width,
>>>> +			  vifs[i].new_ctx->def.center_freq1,
>>>> +			  vifs[i].new_ctx->def.center_freq2);
>>>> +		hwsim_set_chanctx_magic(vifs[i].new_ctx);
>>>
>>>
>>> hwsim_set_chanctx_magic() is only partially correct, I think, this
>>> depends on the mode? For CHANCTX_SWMODE_REASSIGN_VIF the chanctx should
>>> already exist as well, so should also be hwsim_check_chanctx_magic() in
>>> that case?
>>>
>>
>> Oh yeah missed the mode dependency here. Thanks for pointing it out. So
>> it should be something like -
>>
>> ...
>>
>> /* old already exist so check magic */
>> hwsim_check_chanctx_magic(vifs[i].old_ctx);
>>
>> if (mode == CHANCTX_SWMODE_REASSIGN_VIF) {
>> 	/* Reassign then new would also exist, just interface is
>> 	 * switching
>> 	 */
>> 	hwsim_check_chanctx_magic(vifs[i].new_ctx);
>> } else {
>> 	/* SWAP_* then new context does not exist hence set magic.
>> 	 * Also old will no longer exist so clear the magic
>> 	 */
>> 	hwsim_set_chanctx_magic(vifs[i].new_ctx);
>> 	hwsim_clear_chanctx_magic(vifs[i].old_ctx);
>> }
>>
>> ...
>>
>> One thing, in patch should I keep those comments or those are noisy?
>> Seems noisy to me (if at least mode documentation is referred then
>> things are clear already)?
>>
> 
> I'm not sure I care all that much, but I'd say even with the reference
> to the modes, it's fairly easy to figure out at least by looking at the
> mode docs?
> 

Yes correct. I will drop inline comments. Not required tbh.

> I'd probably go for a switch () statement on the modes and even WARN on
> invalid mode, while at it? hwsim is a test vehicle, after all.
> 

Yes, good point :). Thanks will incorporate and send v2 soon.


