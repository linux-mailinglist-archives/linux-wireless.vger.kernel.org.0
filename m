Return-Path: <linux-wireless+bounces-24245-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B21DDADE9E3
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 13:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507CF17AA44
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 11:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA94429B221;
	Wed, 18 Jun 2025 11:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EwlossD/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33F328000E
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 11:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750245950; cv=none; b=BAWau5W8V5D/SKNNNGQe67cyipyb2aM4CnBBiNCP7CfTPDxM3oV7h36G36odZltaqkE1iBJuUUDc7Om9JdKL60H/M4O/NLVpB4ae6XpZyHQk8RI3kWC0/WuvtBDfuZGIwl8KHFjvcir6LFeMcdsn4IZczLDIYVm+0tzDdUt6S2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750245950; c=relaxed/simple;
	bh=Ef1977iLgwXAyHbSw8lMTI2AqTLHT5DCKyNjlouiQig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ItRr9g55LtmteuB6u/kyWT5xKKzPeixA5TqjWeC1iPXHD6hHi5v/Yk032Snwzjx3VG8gWsyRDnrLzX+r5zioA+va4xnFFdhCcArV94SuFbM2Q1nvplfTGI6nHmcMMjVTqDTOUCbfc/pQiSvTSvl8mNokyMzksILXPJJmJjxaSuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EwlossD/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55IBJMEc014275
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 11:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p/VPhOp0fr9k3lcchVhp+R5+r5N+QHL1esWQ9MLD7/Q=; b=EwlossD/p2x7/4ep
	LkLNhwuNY4gzt48zyJAXTYmX6aPSpb8lQAGSJ5Zzuf6Q25KXgyiQGs5vGbAQiIsK
	GNau5J7BREQpj6mq+7r/zM7OneweQbyliMu3Z9Q4bqzGWxvujMgZDTzK7Gt5aBjv
	y/WGJfAbZXTxy0/q6nmulkFJvqm60DwFDZ6z8ZS9/tI3TFPdzns6fFnNo7G0BCr9
	k6/S93bZ4GtoBXKLHBmPLk5W94hV66S2qcT5jBUFQ7YwEMiMjrflAiXV99wt80pv
	4uKs9Y4j0v6QPwMUfo3CIZG5Ti+Rd/z+G+OJj8HvhXJNBUIQ+/rKmtyXKa+itZaF
	cWqfWA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47akuwfbdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 11:25:47 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2355651d204so58430605ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 04:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750245947; x=1750850747;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p/VPhOp0fr9k3lcchVhp+R5+r5N+QHL1esWQ9MLD7/Q=;
        b=jIS5R679G3cfveggujzmZJI2SPZ2N7P9kik+mZpTNkBXGFbp/llSFHAHWLLlBa83Wj
         XtR6TZ/rPCghqJ5GYdj7rH+NJaamn0Uilo7iS//ISOWvvk1y6s+bv9/SL4azVWG8T8Ph
         IfGv5bDUse9eRTZLmjWY1BOQG1YB7EO5TZGswunAVb2ErxdOvMuDDoCozbcwdwtRxK9n
         iIy7swWBc65Z3LxlU9nhXncH+KHjb64FWO+ujLqcLdlGfCOaqzzBfyLtZ+/dChFN2wWc
         +YdlchlBA8E0GrWrOY/llrRro7CdDHld6VbM+yGjZK3JDvuebMzEPQS/m2L/gaQD1R3h
         +Q2Q==
X-Gm-Message-State: AOJu0YxiGQLDqWYkiHmqbA49NKMqp9aw8TQZ+/QJPSdnBxrCNjnW41vn
	6TRmiFOinXDwb1cYb7pasrqNAxrY8iZrHonTx0ygnTD/b6J7R6CH5JDdVOWtGAgjnq7MwmltH1P
	aeh2mUxYTLAtnrpsejfIz+I5BbbV7OidQEhrW+Ou2JtosX9K+ALCKLTvV/GihVSZg3Vu71Q==
X-Gm-Gg: ASbGnct348QAMGi9QMqStWapt62sB68cLMqGtAf4yzRTOZ4b9eV4Cx4dHJ9NEZJimcr
	eAwb2wWEDs3Vi31Q0tB8LwKCb2F7BMzi0CyWL1ltO5XkoEZl84INyuH+XA3POd+iji/sppTmtyk
	297cLKQDg5no1eTClXtC57QbwyOp+Qi7JX0ELfOimmRJ5INr9iujEjSLhs+GqBSSCH/GZLPF8EL
	ZBZyxGz4tgGbNa6IHZCrsb8M2H+Rm24eyFRjw14oomw5l20dqk4zwSYYxzpXyzaoBii3eIOEboF
	uoigS0YqWOI8AZqwavKAOBTIG6s0zqw0Nm6Y0N9piFV8v7Thr9g5XYhGMm8SL8Y=
X-Received: by 2002:a17:903:1a70:b0:236:93cb:48b with SMTP id d9443c01a7336-23693cb0648mr113233535ad.44.1750245946927;
        Wed, 18 Jun 2025 04:25:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIMIeEl+pPfBMPJCGUdosRNemYiNlqt4CENlb48SLmI8e3OBqjiECloDc8xI5ZSw43sKcE2g==
X-Received: by 2002:a17:903:1a70:b0:236:93cb:48b with SMTP id d9443c01a7336-23693cb0648mr113233115ad.44.1750245946496;
        Wed, 18 Jun 2025 04:25:46 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365decc11fsm96827105ad.222.2025.06.18.04.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 04:25:46 -0700 (PDT)
Message-ID: <ec688c7e-65b1-4ef4-a977-e6c89d2176ef@oss.qualcomm.com>
Date: Wed, 18 Jun 2025 16:55:42 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next] wifi: mac80211: Fix 6 GHz Band capabilities
 element advertisement in lower bands
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
        Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
References: <20250606104436.326654-1-rameshkumar.sundaram@oss.qualcomm.com>
 <4ab522796b91ed3421991799d3a7831a3c0ffb53.camel@sipsolutions.net>
 <92a6a3b6-397d-4cf3-95d6-01b50f827183@oss.qualcomm.com>
 <6290a248adbc1208df293dc22b85fe5a33963239.camel@sipsolutions.net>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <6290a248adbc1208df293dc22b85fe5a33963239.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: GpPjjE1aoi43V0GiQHTNoESsgZjf88PC
X-Authority-Analysis: v=2.4 cv=He0UTjE8 c=1 sm=1 tr=0 ts=6852a23b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=k9v7OFRpD0pY56RcHtcA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: GpPjjE1aoi43V0GiQHTNoESsgZjf88PC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA5NyBTYWx0ZWRfXx20q8VPoF+Pd
 Mb73Gs7AjsHGHQ7SeccNB6EKFPD09+tlehZaWQLpzZyyT0Um3L2jrUQL+al980vd77NsG9u+LIG
 H9i0aclbXMEMTNYF8w6vv+ShhvNqzHEiWhNfLLg9GPJ5uf8SqSBYY34W/2YwW+HI1LLOkdPR7Rg
 W1t63iDnnsdifz2lHo6Xqryua9b36uDYzUxCuj+5let2d8wRGwU+L3Pe/juMP0NOdS9hCSllaoe
 U8KxFTUvhNyE+MlSJoL3XwnrVvPib5uyIG18ckg92GJGjRWc6gUt6TCfpKR6xqeekHNHrU+Pnxb
 BWfRRc5fVlSe2Pbs6aU/x/vhFN5k8mM1Jdek0ahiqPnAMCjYBugexGa9OHwfFe8MwDQrMjd8vsH
 SdRBubSO6S6bVZVJsXVT9Rjt70dH+yC93qHNZXeM1a0fzJhJJBxhKC1GyQY/YpFHNcJM2yUh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_04,2025-06-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506180097



On 6/16/2025 2:32 PM, Johannes Berg wrote:
> On Wed, 2025-06-11 at 09:59 +0530, Rameshkumar Sundaram wrote:
>>
>> While this might be appropriate for a multi-band wiphy (i.e., a single
>> radio capable of operating on both 5 GHz and 6 GHz), it may not be
>> suitable for a multi-radio wiphy where each band is handled by a
>> separate radio. In such cases, the Mesh BSS could be running on the 5
>> GHz radio, which does not inherently support 6 GHz capabilities.
>>
> 
> I think it might make more sense for _mesh_ to do this, and honestly
> mesh probably doesn't have much 6 GHz language in the spec anyway? I
> didn't check now.

Guess mesh is defined for 6 GHz as well,

26.17.2 HE BSS operation in the 6 GHz band
A mesh STA with dot11HE6GOptionImplemented equal to true and operating 
in the 6 GHz band is a 6 GHz mesh STA.

> 
> I don't see why multi-radio would behave differently, sure, something
> else could be occupying the 6 GHz band but that's also true for a "non-
> multi-radio design", after all that doesn't mean it doesn't have
> multiple radios, it just manages them differently.
> 

That makes sense, thanks for the explanation, but is there a reason we 
should include the 6 GHz band capabilities element even-though the link 
STA/ mesh BSS that is going to send the beacon/assoc req frames is 
operating in a lower band (say 5GHz) ?

Does this help in discovery of any out of band capabilities ? Just 
trying to understand how this is useful.

With current implementation, an ML STA negotiating 5 GHz and 6 GHz links 
with an ML AP would send HE 6 GHz Band capabilities element in both the 
links as part of association request.


--
Ramesh


