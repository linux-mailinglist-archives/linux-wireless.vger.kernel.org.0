Return-Path: <linux-wireless+bounces-24431-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD55AE67CB
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 16:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C4023A4EE6
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 14:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6921C2C08B2;
	Tue, 24 Jun 2025 14:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R0u78mai"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55563FB1B
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 14:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750773986; cv=none; b=F6XfUSz23r8kscQoHC+O4wJWbouYodedLjvGHk1bYDuxwhJP6xcWJ73TETY2ae+XQmSUFrGrcD59bvEylcn7j+QdsbL5HUnzvb6z8MOAXSdE/+NrdFX/NWC1VtmNoVhOah2S+aos7lAroGIlrEgMV76NOS0O5yI31dck8yWbYBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750773986; c=relaxed/simple;
	bh=cATsk936tTc4YaS5CJHMJaP9o1b4/ylcYFvU8qpOj8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CIMu6/0f8haieHHXBvTVBvuiD4jX56BkBg1uDHV8NSTMY/gkEDvCYp9DVqXdfqAQObyIsvLAwMuUvO8e7UMRItra7D9Rh9KIgv73Wd3zfNNmKE3gLRWz5B+3W+MODEnfxP/dSJ//rFnXDLcMNH4ME5Jp6Q6iBo90G0fEreg3lLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R0u78mai; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OCGafO004334
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 14:06:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fS0i6csuU64YhGflRYp+BKuOvqYXv8rVMMsiQYodL9o=; b=R0u78maiNxwJI7U1
	dn4aPgkvh6kr+Yv4/jQCG3h6hIdGP892oEWJnwCCYEMX2ivwi1HwD1ZWobIItrDP
	AuadE6QizJNjTCPI5wih5vBGFMRJ512hy1yhvIbSsG1+W00vRVX7vWiZ/3Dxvxv9
	l9ZHt4wQAHFYeBcAGnnj6Ls8Zd+Lwxl9YVE1YOqTM7/uY1kSkAuC12FWa7jVzkNT
	nNunx5gcbADB/kjDIxABzRlNQ5JDhCyBYhUza5Mid7PsHFbJO6HxAYCxYny6rbYF
	nr2Oqniuhwh8nbG0AwcsA3jAlaooG7xcaBxtb6XePOLzbFLb6hh7ttwK2txmUPyp
	vgIYxg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f4b3v7u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 14:06:17 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b3183193374so3849136a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 07:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750773977; x=1751378777;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fS0i6csuU64YhGflRYp+BKuOvqYXv8rVMMsiQYodL9o=;
        b=n1/tYxBagzYTyM6zxV7elZzj3EohL1GoLsotXU4eUx0W81YjtVnkAtMpmOcV8BKgY5
         oUtXdw/jMC+0Vlicpq9DKm7gL4sLG0IqZXjDFmdlSdWyhwYuEFimtGEV2MdoV2UKdgUU
         A/h/+849tfh1/RTb2MhRR58Rl+abawFLmPiuzer5p5Uh+4CseDopNFXVqT1hkIPZkv9L
         6lPEla7VanzDYA3VqTCN1rg+4Vfg5IcJ4y1lBMCHu/bkhd5JSpFdeTXJS/CxEAKbS5qh
         TMky8xEjgbU+w6z4m6Lu6kRy3OIsWQcudQTDaidedBXbRZ9Iuraxc82s1oTURHBihCRF
         52Qw==
X-Gm-Message-State: AOJu0YxNXdoLR9f/Ul+pz8vRuKpqRFwwj9WNS+My/h1Ih+uHMhyXlr7s
	0rlISfHrPatydwL7KaGat/hnjmvo6lNDS/09ASIU9vO+fDvj+Z+I8PkqydNG99Z8HY+n7IfNCoj
	+LG0UyPNIz49NpSqoAvQpCVAzcppGvDusE9CWTubjK8Oz11CVRMLZcMxV2t7/NugC8oxpCw==
X-Gm-Gg: ASbGnctr028Xa/Rwq1lmePABpOEaDY9wRQe2KkAf4DMfscfrdB3POSnyCvt8h1o8gmC
	t23hsjvfW3hlbIeolaKcUG0CJ09Hanb0BvsgFtIwQ+V5eagcmCUtOUcMfq4N/+EtBekDEV4nkKc
	IjlX1Y33BssGly512TQEATJG+b+mjaqOB88xEXuFzHnNXirud6C4EeA53/hL53Hy4YplDm8X2K+
	zIWrtCNc/xPe/7tsU61ueABUdA5zR/rbzcdFWIuvgHkVI8eZtZ3JBIxP+1CcQ7Ua4XsGEeAqW1r
	gyleqNXiq+z1m0NpBxtQQRZmLzJ1Dr6xTFUXmGG3o5O0cPuQpbNQt6wgmYjPgwolMNyadc+Vn0G
	GbI4KpXXbmHnkErg=
X-Received: by 2002:a05:6a20:3d85:b0:21f:838e:3a5b with SMTP id adf61e73a8af0-22026ef6966mr27720605637.28.1750773976677;
        Tue, 24 Jun 2025 07:06:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF81zguMjdoeQJ7hOBDiarBvWbMTAPJkSzvWRPYOUHZdj5u83I8HJo5j3g8hhpNeRMdF6uaUQ==
X-Received: by 2002:a05:6a20:3d85:b0:21f:838e:3a5b with SMTP id adf61e73a8af0-22026ef6966mr27720548637.28.1750773976186;
        Tue, 24 Jun 2025 07:06:16 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c8872113sm1924222b3a.161.2025.06.24.07.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 07:06:15 -0700 (PDT)
Message-ID: <4872f305-b597-40b9-aa3e-c079f9e0f27a@oss.qualcomm.com>
Date: Tue, 24 Jun 2025 07:06:14 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v10 00/10] wifi: cfg80211/mac80211: add
 support to handle per link statistics of multi-link station
To: Johannes Berg <johannes@sipsolutions.net>,
        Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
References: <20250528054420.3050133-1-quic_sarishar@quicinc.com>
 <ae46cc4ffc3ec8c776f70c4c61031d82ffdc4be0.camel@sipsolutions.net>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ae46cc4ffc3ec8c776f70c4c61031d82ffdc4be0.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDExOCBTYWx0ZWRfXwV7BN90eCScK
 Q0f3ZQrTp1BTfGduXiGTJWWKyNt69z9qobgqjSzqfCHI92aRcPuXrM7s+CGtfhchx/Gv5O76Esz
 dIK0drS+Ha8revsAEFlIFDempQqaNimwe6S1glQSjUrENaVUEIfxoe8MmrdS/kLlQyPLLNdYZej
 dP5QaVltbmBFkDUkvUd7FzT7HwjXBron7yvmuEZ8MFwg6RoUi0xDLpEPaJIHG/HOd74EWzWjCJJ
 1hcyBwuo3IUd97+5Pfglyt2XOajNrIYHWQRuEs09PmDl1yXTpO8NvYn2Xu9btJONAdiUYjxYeX5
 f5RJ0sVKXwsbgrue5//uA6tzOLrLfoPDD1yC+/cFAT3NMJFqr39yeWFjkypRK8+/Q2zw+xeHWd/
 vdEXbANQXq/lL8hLYK6tR9ke1qkIVEdQAJ4FxG2vrbcdOqdAq+FYG6VbpXgh+Y3uzsTN0vH6
X-Proofpoint-ORIG-GUID: x_paeJeXBA_fruU50ZViqx7t_OFC2HJN
X-Proofpoint-GUID: x_paeJeXBA_fruU50ZViqx7t_OFC2HJN
X-Authority-Analysis: v=2.4 cv=A8BsP7WG c=1 sm=1 tr=0 ts=685ab0d9 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=uYVGJH5IAAAA:8
 a=vSnJ7S1lpH5OsQjxafUA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=ZkEWZNUrOYKkpCLSUeX7:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_05,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506240118

On 6/24/2025 4:40 AM, Johannes Berg wrote:
> On Wed, 2025-05-28 at 11:14 +0530, Sarika Sharma wrote:
>> Current implementation of NL80211_CMD_GET_STATION does not work
>> for multi-link operation(MLO) since in case of MLO only deflink
>> (or one of the links) is considered and not all links.
>>
>> Hence, add the link_sinfo structure to provide infrastructure
>> for link-level station statistics for multi-link operation(MLO).
>>
>> Additionally, accumulated stats for MLO are included in a concise
>> manner to provide a comprehensive overview of the ML stations.
>>
>> V10:
>>  - Add WARN_ON_ONCE(!link_sinfo), if valid links.
>>  - Fixed kernel doc error.
>>  - Corrected logic for setting sinfo->valid_links only if memory is
>>    allocated for link_sinfo.
>>
> 
> I'm going to apply this because we're at v10 and I'm losing track of all
> the changes etc., but while looking through it now, here are a couple of
> things I think you/we should still change:

For clarification, do you want to change these as a v11 or as a separate
series after v10 is applied?

> 
>  - We already require a call to allocate TID stats, I think it'd make
>    sense to also do that for link stats, instead of allocating _all_ of
>    them always. The cfg80211_link_sinfo_alloc_tid_stats() could go away
>    in favour of cfg80211_sinfo_allocate_link() that gets an argument
>    'bool tidstats' to allocate (or not) TID stats with it
> 
>  - I still don't like patch 7, I think that should be a WARN_ON_ONCE or
>    so and the producers shouldn't be creating that in the first place,
>    otherwise reading the mac80211 code is misleading since you don't
>    even get that data. Also the producers shouldn't even _have_ valid
>    data for these values.
> 
>  - What about TX statistics, we still have these patches:
>    https://lore.kernel.org/linux-wireless/20241218232519.3156080-1-greearb@candelatech.com/
>    which is still needed, right?
> 
> johannes
> 


