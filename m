Return-Path: <linux-wireless+bounces-24270-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1C7AE083C
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jun 2025 16:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B856716BE1D
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jun 2025 14:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4A323496F;
	Thu, 19 Jun 2025 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QOLXza8W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F78F25F970
	for <linux-wireless@vger.kernel.org>; Thu, 19 Jun 2025 14:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750341965; cv=none; b=Hwpmcy5gWWfYNV1mX6rSRfwQhmUlRpear4zwA0sQiK+Z2it6mivQACs6+XlisFIA8KMufj0Ffpylo134ILeymkHqCkk/K/Wr+g8DAv+XiFl9zE/97AlNVP9BIdWUm1phHhqSXbEIoSBaIsr2lNSXm2vWIeygsyRS/ghWHmHy9w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750341965; c=relaxed/simple;
	bh=ZVmgT2s6SZ70A/9Dhoo1SD+oZjDDp7qhQCOPOHMwFq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SSPcuGTWQRtsmCvzRWvOvIeNeqiMPxmHM/LGohfDTx/iKCSkPlz26znpfNTj9ipaD2awn6uzpsJIeELrNEWwls4FHwHTJkylroNViFKemVQJf0S8wYQ831mymsMJyg/5jCzjav2DAvOTKMDz0mz1WcxR6v0fKv4q4LH88HcTwT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QOLXza8W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55J938CX032388
	for <linux-wireless@vger.kernel.org>; Thu, 19 Jun 2025 14:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ulMJeCyYI5IB6//qPN7mq8KEhDVWpcgCCr3KrMRtkBA=; b=QOLXza8Wst5QbFEw
	wqOY0ja23RjpxLvSiXpDVOnDl89E54CPHrRR/Rpu/mA2N3wDEV+q0bpNj3DyYecX
	WP4pw736vvqE3TSe6b30FM/7HOXZt8KEXg2MaN2ly3z/OyjbOYCA7rZZemmOZeeF
	uIso8AJKMe6EIhKeCriQD7Uo6+ZpKHYt/bd0r9ezKj5rkfg0mLiyue9R5SpHYXNf
	1w5L1WNKTdd38ZqHLTJyQS1DPzIQ4W9/6GvQf9sLaicDNc5/AwQU2QL3E17tdEzv
	4Bl1C6KUGIoaPKhzr1tkPPN+xT6b7GtNPUihDNaOy1q8pFclFKqAKzSmX0bEgWcz
	V61lhg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47928mr3vs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 19 Jun 2025 14:06:02 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-311f4f2e6baso826271a91.0
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jun 2025 07:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750341961; x=1750946761;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ulMJeCyYI5IB6//qPN7mq8KEhDVWpcgCCr3KrMRtkBA=;
        b=NDl+9Ld0YpmgKB+7OC9ATAPClWz33Viccv5tomGVPK6zyh7kTM6AhreP3JWkV04Oga
         e/Ur1GhOp2BBIiG8hm30SGuUmvl7TZJSOgK01dwRBjggBGXYmJYF5HnJ1ZKc1k4FSuGy
         sSJXHO2qFfDpbRoby46DuBg2KZXn3VzIWI6vN/QxqlS3TiErgQUvxVrcGa0q6KRMF4lu
         1/N3WXrSv0bNxj2znDSJ7vzcuosiGGNTpHQf786+LHbamkuxsQLgBU6TCSMdaEmx0ujW
         qR1GoLH/55vxUG5Zm37X9m4LU1itjfRENs1vBvyOPlmInRlMUeJVu/9yr0UDVM10D1RK
         JBpQ==
X-Gm-Message-State: AOJu0YwqiqKWJVxaS2Xcb2r98tFVFtGjBgCMcTfINGTNx5ItRCzkQ7Hb
	OlcSCTONAq9NGqhYsYBos0SyLYKUtCjYjgvh7h/7PPe3TVnlL/q8LR0xWN5RL/xONqchssV8An8
	HdIzR0xTDz0mmDj7KekjpKyk0JdloMMjH6w6h3xXw7rkcpNeElHUYeDAZTA9UkxH3X3Xt5A==
X-Gm-Gg: ASbGncshPUJ19NtcrAR67MT9CTpZaHIPYi5+6RESr7oU4KxeDvx0+cZE6IMaRtZTTyV
	s+XK7aY52BeaSm8Wg+aaC5IGxWI9/A8P4YkKAb3tgOzJYWj3G4NEeFcQ0O4miWjb1/txGHFZ5mv
	tpK874G3jTzrKTMazWe+V8iqM8p9VL3msYyXNcqyhX/dJRyOt1gzdBWIj3jHtsa0WxQonDaUSbY
	8NanC2VI4Qbo5ifwMmb3Mweuez3q1q+wvdtsUcMt24hcY9AmItR49IMQS6mWfOmDatiZ0qiiJsj
	YZ3m6EYMaoq8Pd7QufLpxn1gC5VGzlLcrNVVjjMxh+Sb/vqtPPOo/5cPrerlMe8IV7A=
X-Received: by 2002:a17:90b:1d50:b0:313:28f1:fc1b with SMTP id 98e67ed59e1d1-313f1ca127bmr34509204a91.9.1750341961388;
        Thu, 19 Jun 2025 07:06:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxEZxw6yv6fxzBWQzL808AZTwJh+fj/FW9ppTk+1ZWotethNWagpS5HYSLGVmsVeMQ1kzapQ==
X-Received: by 2002:a17:90b:1d50:b0:313:28f1:fc1b with SMTP id 98e67ed59e1d1-313f1ca127bmr34509139a91.9.1750341960814;
        Thu, 19 Jun 2025 07:06:00 -0700 (PDT)
Received: from [192.168.11.100] ([124.123.81.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d88c034sm120219265ad.50.2025.06.19.07.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 07:06:00 -0700 (PDT)
Message-ID: <48b3af20-dd6c-49cf-88b0-1d535bd917f7@oss.qualcomm.com>
Date: Thu, 19 Jun 2025 19:35:56 +0530
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
 <ec688c7e-65b1-4ef4-a977-e6c89d2176ef@oss.qualcomm.com>
 <f80c107d6cf596091865961f8d1371b98486a14a.camel@sipsolutions.net>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <f80c107d6cf596091865961f8d1371b98486a14a.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDExNyBTYWx0ZWRfX+pyx9GLagDyM
 7eG7JBoJhXNZbWIN0ZxwNu759Orxns8MeW2kVzIr3o8kIxeeE7V8nN7CwMd/WU+mSFxw972Hshq
 d7PDTkJIgBdIxNBiGHvZE3AQq302y11FrEdX5MPgxOxOkgLDvTLwLI5hMm7exCqyp24a18Pm5RT
 tFskblH7dfYLCSGY1YKLpaiAS8+SgZ2UQWfuJ4fDBWo/D4+ZafqRRpD+rdvwSdntoWfIFoeWbPc
 OZjMr/P1k+tyZElI+QmZHk0dGhR6PEj/0cvGi0uPmwA/zRTEJr2LonYInoY3fFj8g4nlYL2Vvns
 q/yREmijNbACG4NrMaiwydJDrXeYpx1yr92BFfmigRbEpBDu/TbTJxcNlOa+jRSfVTAN9kC28nS
 DLFY6KDbJFlIgB+W4ucesd1wcgaYRUZVvHPXmVl5mq07VpT7sCOooypXbvqyRdjd13GYkYci
X-Authority-Analysis: v=2.4 cv=fvbcZE4f c=1 sm=1 tr=0 ts=6854194a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=R7zuFBDiW8lgADV909h7jA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=8_dq1OcrlyS03M-rYkMA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: dwUUo3bh6S6SuULol_slUHan_QA0HNQ9
X-Proofpoint-ORIG-GUID: dwUUo3bh6S6SuULol_slUHan_QA0HNQ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 adultscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506190117



On 6/18/2025 5:05 PM, Johannes Berg wrote:
> On Wed, 2025-06-18 at 16:55 +0530, Rameshkumar Sundaram wrote:
>>> I think it might make more sense for _mesh_ to do this, and honestly
>>> mesh probably doesn't have much 6 GHz language in the spec anyway? I
>>> didn't check now.
>>
>> Guess mesh is defined for 6 GHz as well,
>>
>> 26.17.2 HE BSS operation in the 6 GHz band
>> A mesh STA with dot11HE6GOptionImplemented equal to true and operating
>> in the 6 GHz band is a 6 GHz mesh STA.
> 
> OK fair :)
> 
>>> I don't see why multi-radio would behave differently, sure, something
>>> else could be occupying the 6 GHz band but that's also true for a "non-
>>> multi-radio design", after all that doesn't mean it doesn't have
>>> multiple radios, it just manages them differently.
>>>
>>
>> That makes sense, thanks for the explanation, but is there a reason we
>> should include the 6 GHz band capabilities element even-though the link
>> STA/ mesh BSS that is going to send the beacon/assoc req frames is
>> operating in a lower band (say 5GHz) ?
> 
> It's probably not useful in a *beacon*, I guess?
> 
>> Does this help in discovery of any out of band capabilities ? Just
>> trying to understand how this is useful.
>>
>> With current implementation, an ML STA negotiating 5 GHz and 6 GHz links
>> with an ML AP would send HE 6 GHz Band capabilities element in both the
>> links as part of association request.
> 
> There was, afaik, some discussion here in the spec asking explicitly to
> have it included if the STA is 6 GHz capable, but don't ask me why.
> 
> Now that I look at it again though, it says for both beacon and probe -
> _request_ to include it when dot11HEOptionImplemented and
> dot11HE6GOptionImplemented are (both) true... We always though, with
> some discussions with Cisco IIRC, that we should then always include it
> even on the other bands for probe requests etc.
> 

Thanks for the detailed explanation.

> But does that make sense for beacons? Not really?

Feel like it doesn't. Shall i make this patch to restrict this only for 
mesh beacons ?


--
Ramesh


