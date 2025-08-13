Return-Path: <linux-wireless+bounces-26371-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D83B252C6
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 20:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E2BA56698E
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 18:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4520A287247;
	Wed, 13 Aug 2025 18:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E3JqcPUU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C6D2857CA
	for <linux-wireless@vger.kernel.org>; Wed, 13 Aug 2025 18:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755108388; cv=none; b=mHtyposgfuOQdvX1hl8qPpBgU5JkPtddo+X2mQQwV6P5qGC/DJ/6ZxkHxlkzSzHog9JHUWE+k9Pma/x/DrilBdEFVOaMC1kQhIPryi0K8pViGoX4NIGft2T64xEHteujGbPG1/d2ur1XTMcfObZwC89Cpdlu+OCHI6QAp+gpSfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755108388; c=relaxed/simple;
	bh=WqQmFGyGStx+Ni3txnBWkFwvJTl6aH2xX6FFJ7uzs9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t8o4ikJCPTv0WuLkErvxxKPXQEi1hWn5QjI9K5gHD+HBVtp0ktcFAzyZCOkvC7Dz4z4ADFatheNTalcxWfUDI9W/pBp8Axw2FZoND3jCricVbNns+1FwE92hOLGtETyyGXtJMKL07mgHnICqaPQmTrAMSzuF7ojdXlJqMPMMIhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E3JqcPUU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DBLoeT027282
	for <linux-wireless@vger.kernel.org>; Wed, 13 Aug 2025 18:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oSoIvL+pc4m7OPZJ6P7l7I02a8wRIgJL6XNsdZhf+4c=; b=E3JqcPUU+y3LqTIq
	mT/45oybFZ0m6nvNrUNq94pq9SWvX017G/AY8YaIC4AZGCH4oj80WHbMeflkax0T
	yE66TqneCvhgSLIQB8wfSnhdLF8KaUqRPoHhlFSsL3vufLSOTuwvyKvKuUDlDPj4
	RkKd4QRobs8gtqtAeDf9pvqRzmGJbcF5nmGiBBfFyGxKFflv+TOCcFLQXO+6P/xi
	xvjd6BH8KrDqMgFaJ9tZe3OTHt65q4ZetKTqoGkEZ/e6bqpzj1NYt5eWmhUoKw4g
	2XO+g8V3DVYfvdky0RiY3VjlYt77c7dRyap88Dk/eevY2jQNM3dMos4+1EQFVeHz
	QIW5Tg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffhjrmgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 13 Aug 2025 18:06:25 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32326e72dfbso289675a91.3
        for <linux-wireless@vger.kernel.org>; Wed, 13 Aug 2025 11:06:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755108384; x=1755713184;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oSoIvL+pc4m7OPZJ6P7l7I02a8wRIgJL6XNsdZhf+4c=;
        b=ig7KCm7W8UzhOYJXXBVu4fNuQeTYFkJlXN8w0vGGitPvDzwuPwT2bG8ozPIDWMDFqq
         PabrBHyk6G7VjyFfYIYRNsgHRBQBtjugay1IAAqxNtV0fxhD/d4FmK+VqaXzuDV88+Wp
         ugKBuApK/F3EZe1c8w0NmIzytNo9BdWXzIQQOyqR2up0y/rjrSZgGRd24i18gVeTrQZk
         mEwi/LA8xwzLHAXIfu4FJXH+JbQ0nyK1WKtCv21rbmt9+DYi5daqrysEGqLjPQk22erJ
         tIJXtA8l4hFT87JkPiAGj6PMiqubJJRTDa6q3XGBg0XlsYIRtnIgnYIxPirE6bDSQkFb
         qEIg==
X-Forwarded-Encrypted: i=1; AJvYcCXCUrn4UvHpqOQy7mFuqqyOSrxLhBYgz1TZxp7m0oMm2+1BVZ3xAbxblaRrgLUFUIbng6+3pSA10SvFmLqcRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw51M0aQSsGixg0WOyslnnEglymPjnigmB2h94+zJqpIFbcbPRM
	QhZ0mCOQyrOSFmntTguvpKQb8MuV6f9MOCffwMROsrPNgJWnJVkEW1pMqillFiKUnpeTpgisFkf
	yjGXTV3bDVSbjq9PgHR3OF8UHJ69LdEHjU7Ih2L3CuFhISLvARZ7oY7EiE0otprDjOfGEbG8huj
	ei0w==
X-Gm-Gg: ASbGnctKuXXDt/VYxDpTJkBBWVpCZMXHnBUtKl7uw+xOKkKFVlv3Qsgq6bFOpeuIc3a
	Zn91cxm6Bg0o3o/D+YH9HkfG40ysbS2jq7Jk1OEzH1dX0x2EQgFVyn3Rcv+jS9WGkfeGWWn75bQ
	1Y346RHwK3qMePnSfBUVztLF/W1EhuqDRzvnJccB2BFiV0+AzCUSaqk50lt9KsV9gTDnQuqa94I
	CtmJOMbXdSuFBC2zjgcp/dIEUVMiEZdlRwiy07KyVQY2i2MGbBSj0Ll3+2XHJukuOq7KAqTz0iP
	8HkbY+eDK5ReIf1553dwZddo89wm7BE8prVpLn/LXFH5duefJ67uZ56QuIfp0j5UoeaCkseHxWL
	icfjgPhULNx3ymi9BCv8=
X-Received: by 2002:a17:90b:5705:b0:321:c0e3:a8ce with SMTP id 98e67ed59e1d1-32327c87849mr277033a91.22.1755108383650;
        Wed, 13 Aug 2025 11:06:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7tSSwdEVF0PFpxkGJiiCoWVGyWp67B4Q5ibZHoXDQlloJTr5+h7IW0h6eguGtmhYEarj0kA==
X-Received: by 2002:a17:90b:5705:b0:321:c0e3:a8ce with SMTP id 98e67ed59e1d1-32327c87849mr276989a91.22.1755108383065;
        Wed, 13 Aug 2025 11:06:23 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3232555f41csm734132a91.10.2025.08.13.11.06.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 11:06:22 -0700 (PDT)
Message-ID: <bce51392-d5f1-40a2-ae22-58df01b993e7@oss.qualcomm.com>
Date: Wed, 13 Aug 2025 11:06:21 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath12k-ng 03/13] wifi: ath12k: Move Wi-Fi 7 WMI
 configuration to dedicated file
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kiran Venkatappa <quic_kiranv@quicinc.com>, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
References: <20250812-ath12k-mod-v1-0-8c9b0eb9335d@quicinc.com>
 <20250812-ath12k-mod-v1-3-8c9b0eb9335d@quicinc.com>
 <00a72188-8ac7-4527-8128-352d0882754f@kernel.org>
 <b62af6d9-eea1-41d0-997d-b9585f2a9533@oss.qualcomm.com>
 <f6b046b0-d230-41e6-ab18-686cc7b65f16@kernel.org>
 <2025081320-coastal-graded-40a2@gregkh>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <2025081320-coastal-graded-40a2@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NCBTYWx0ZWRfXztXddKr47asE
 q7OTu7hnEpJb2tyPrgj/aLY4asONk/e5tBJ3cOUl82zo2t1p/Fe/vmH2xtrYXpUSDhvwyIiBYlu
 LUntKiy6pfYDpkaXZ9LmQUlVdg0gQeJZ+ojXpvDFhg/idyPSt6O2oJu3EwhEA7YPKVYxTxTUb7B
 lbZwl/+TTH4/RLAkTX2i97PvvhFb1YHJoHkUykm88EVKlL8zJhKWENucJlsRYSzZ9prhtDwEjYJ
 ZPiTZpfSCotn83w4DtfhiGnI3oLA2yPRRtuCSMZRfhCseA9IG2Gi1NPzAe4o4K8EmNK1wo6EEDD
 xaUtqltDwkzY8ty+ChKWgZTdBW7PcnjkZ87f5acfKWAezsidJdPSyTmWpDZbultqTYXdOrEGfnR
 93HmvxWm
X-Proofpoint-GUID: vkG43DNF-VT6HiDYIR0npP4hSBGf7gCa
X-Authority-Analysis: v=2.4 cv=TJFFS0la c=1 sm=1 tr=0 ts=689cd421 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=mDV3o1hIAAAA:8 a=wz68kt-ga7Guwb8P1o0A:9
 a=QEXdDO2ut3YA:10 a=JEtk54xxEQEA:10 a=UDyAGHZwfzgA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: vkG43DNF-VT6HiDYIR0npP4hSBGf7gCa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110074

On 8/13/2025 9:24 AM, Greg Kroah-Hartman wrote:
> On Wed, Aug 13, 2025 at 06:00:44PM +0200, Krzysztof Kozlowski wrote:
>> On 13/08/2025 17:43, Jeff Johnson wrote:
>>> On 8/12/2025 10:52 PM, Krzysztof Kozlowski wrote:
>>>> On 12/08/2025 19:09, Kiran Venkatappa wrote:
>>>>> +}
>>>>> diff --git a/drivers/net/wireless/ath/ath12k/wmi_wifi7.h b/drivers/net/wireless/ath/ath12k/wmi_wifi7.h
>>>>> new file mode 100644
>>>>> index 0000000000000000000000000000000000000000..1514e3e8d4cb65d3d95d95a1c1593a7b66abcf58
>>>>> --- /dev/null
>>>>> +++ b/drivers/net/wireless/ath/ath12k/wmi_wifi7.h
>>>>> @@ -0,0 +1,15 @@
>>>>> +/* SPDX-License-Identifier: BSD-3-Clause-Clear */
>>>>> +/*
>>>>> + * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
>>>>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>>>
>>>> Don't rewrite the copyrights. Original file had different one. GPL FAQ
>>>> also EXPLICITLY asks for date in copyrights and does not allow one
>>>> without the date.
>>>>
>>>> (and before you bring internal qcom regulations, let me remind that they
>>>> do not matter. we discussed this in other thread)
>>>
>>> Wi-Fi team wasn't party to the other thread, and this series was following the
>>> legal guidance we were given. I'm circling with the core kernel team and the
>>> legal team to make sure your concerns are resolved.
>>
>> +Cc Greg,
> 
> Oops, I just responded to this issue elsewhere.
> 
>> Please follow legal guidance expressed in:
>> https://www.gnu.org/licenses/gpl-howto.en.html#copyright-notice
>>
>> and the license you agreed by signing of the patch:
>> LICENSES/preferred/GPL-2.0:
>>
>> "Copyright (C) <year>  <name of author> "
>> ...
>> "... publish on each copy an appropriate
>> copyright notice and disclaimer of warranty;"
> 
> Nope, we do NOT force the FSF's legal intrepretation of copyright marks
> on any company at all.  It's up to the copyright holders themselves for
> how they wish to mark the copyright, if at all.
> 
> And really, Qualcomm is a company that is run by lawyers, they know what
> they want to do for whatever reason that might be...
> 
>> Just to remind - you as author sign off your patch, not your legal team.
> 
> Agreed, but in some cases, I have forced legal teams to sign off on
> patches, so don't rule that out :)

Thanks for the clarification, Greg.

Just for reference, the guidance we received follows. In that guidance:
- LF means Linux Foundation, the entity to which Qualcomm assigned copyright
when open source development was being done as Code Aurora Forum (though
December 2021)
- QuIC means Qualcomm Innovation Center, the open source entity used from
December 2021 until March 2025.
- QTI means Qualcomm Technologies, Inc., the entity now being used for open
source contributions.

Guidance:
1. Should existing QuIC copyright be left alone or absorbed into the added QTI
copyright text?
Yes, all QuIC copyright years should be absorbed. Replace the QuIC copyrights
with the QTI copyright. Leave LF and other 3rd party copyrights alone.

2. When we are creating new file in open source, if it is copied/derived from
existing QUIC authored open source file, should we retain the QUIC markings?
No, the QuIC copyright years should be absorbed into the year-less QTI copyright.

3. Is there any use case where we MUST keep the QuIC copyright?
No, all projects can move to using QTI copyright.

/jeff

