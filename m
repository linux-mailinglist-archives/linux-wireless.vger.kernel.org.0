Return-Path: <linux-wireless+bounces-25148-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD76AFF7BD
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 06:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ABDE5A253B
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 04:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C774207A;
	Thu, 10 Jul 2025 04:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E8vGI8pZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D25DDC1
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 04:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752120239; cv=none; b=pFwkUx6k2FipKfbFQSAdOGWIIoNYIj+zjyRNg7A8gCpuu5EciPLPvJlV76C/8FFOHDY3/wIAeWZEcdcHvFNbj8ZHo3si13qFEGS7YFiVrHaxh0wmytfuKUbiFdcSmdUDw87VGm1gD+yJt2xHqDJ/UcGDCAGG0mcvvoaPcXag9W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752120239; c=relaxed/simple;
	bh=ozUxJBpccOs7DoeI0f5733XzUV+NBXqqFc/UQAKa34w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eGmgT1Ln4bIHCSd+kS/p6wK6560oBY+IAmeAmc50S5ukTzl2LJEcmZagEoXPGKP2JXUPIJgr0QIgsnME4CQt8ilXBbKApMVyLH0RXkU3Qau+9gy9vhTJjtc2hLOI32gqMF66vI9F0pEpF2MKgneS8OwQUT5+Jzh4qDhOqlF+Wc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E8vGI8pZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A1PjJH016188
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 04:03:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/cOMMc1XfeBpd6NIV4GqD9lwT/BJE2uXmJIOj8BYXLI=; b=E8vGI8pZtkLdhrOo
	KzABqEIUd5qV/tUd/E2Y0ovyTB1xsbf4MQ8fsyHECHKEaxNepLS4WfyelPYDNbYL
	2WQFzuKuaDpNh1MGtz96nG+ZGrG1lcpBkgEBYQd9RhqdInvjrnUVCJ3p8frpAHME
	E1mTPdd33NYlmrHrqDeg/w5K/KdElqVuDgMutGIbj2glkLa4OAmewUjxgTeD/qUL
	KVILwhlTNV1mHuKPVub57SHRJuXNt1Bfdt3Nsex1quCqvIpQqjGs3Bv/qgk3dpvL
	ntdnB2LG+AAe0G0ikiLFzUQYHQhN44UQ0vz7/vzNgl54cQE0vuRnxaznOkd+ptu9
	KOED0g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pvefpvr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 04:03:51 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-311ae2b6647so550427a91.0
        for <linux-wireless@vger.kernel.org>; Wed, 09 Jul 2025 21:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752120230; x=1752725030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/cOMMc1XfeBpd6NIV4GqD9lwT/BJE2uXmJIOj8BYXLI=;
        b=kHFCSoHA4/XAuj4qBiRpVxKeVBPeoOARDJSXMXBo1dB4wxdAQnomvURitgPDZeM5+A
         MIZtKIK+/zorhazCmCuFS6KlIWcoAWDNfvIplDtwLWmqnb8aA1nfgai5wMU71sPlmvZG
         VfBK19G297YKD/fmXjYergEOyjxzQGVkGoKRZov6lozAjeK5D809Qgas1j0Y1BgjhZL8
         Vasw6aRa/gbCUcC+XfmufiVlHv7Wc7rdiDt2ozVA+qP5hpSkRWijEgYB/sbXiMyZRgmc
         14CTWtloli9Ho6FltfAvMQMBq1wdnqBCd0g/WK41efrJzYhKhPjPZpASGJwlzEE3L0Yg
         abnw==
X-Gm-Message-State: AOJu0YzHFgw2L0GrHhnthmk97Evtd7T4sHc5pYTm0A7uOqwSLCn4iIt5
	CY3WLbDADdMv9MOq5CqJBtMQKidqSUU3iH4i0qwPcnPRKHbRFpbtrwkpRrzSwtxNdO+7hgAXcHB
	xS/KlHHZjDztKdSNLhXZ2B3EpB53BlfpniEM3GobQkhOUgAoHhx3VgCBquTWOP9VE53EjoV7Y+Y
	Em6A==
X-Gm-Gg: ASbGncupjszbqURPAhCCUSlOtOFHmYAu5jJ0DfqdXv6A6wAwe89A2CHC1GxUH4Dhp/r
	7JXqfFrkAMwHnQrkS+HSCezAImkVIQBEQihKp1yLQj11nnlaUh/zVoBajyHIGVXJqyiPhp22nK+
	Q0Z7QCAlf3lmD9VNkSZwg40M8Pj+bsLva6aR3pkyxCY+MIzvWOXLGQCeh3RDr1Fgo2I85Uj/SpI
	sA4gz8RkapgoHX+cqlGQCGd90IqeaIv+kT+bFermOINW1ySChkYJhMJF3PgF29VFRRqCea9S7Yp
	T6iXd9J7bHgmJKt3EElOR7qz+IBzIPMe+K7hvqdErgPdOHVjkoxB2UCrOijjBw==
X-Received: by 2002:a17:90b:28c8:b0:312:e49b:c972 with SMTP id 98e67ed59e1d1-31c3c2a215cmr4509250a91.15.1752120229815;
        Wed, 09 Jul 2025 21:03:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMEy4WkiWJBnP46D179XoWWT5PKzwj8yODTk7jYtdtGjM3aivROH7JHI9Gv85UzbvlH697Lg==
X-Received: by 2002:a17:90b:28c8:b0:312:e49b:c972 with SMTP id 98e67ed59e1d1-31c3c2a215cmr4509218a91.15.1752120229430;
        Wed, 09 Jul 2025 21:03:49 -0700 (PDT)
Received: from [10.152.194.206] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3003faa6sm3947202a91.4.2025.07.09.21.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 21:03:49 -0700 (PDT)
Message-ID: <7aadfaff-f8f3-410f-90db-20b24d4e2c5a@oss.qualcomm.com>
Date: Thu, 10 Jul 2025 09:33:45 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 1/2] wifi: cfg80211: parse attribute to
 update unsolicited probe response template
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuvarani V <quic_yuvarani@quicinc.com>
References: <20250709-update_unsol_bcast_probe_resp-v1-0-d3323ce9a7b5@oss.qualcomm.com>
 <20250709-update_unsol_bcast_probe_resp-v1-1-d3323ce9a7b5@oss.qualcomm.com>
 <9dd32e266523cc7f5f5fdc3e676216f4a0057615.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
In-Reply-To: <9dd32e266523cc7f5f5fdc3e676216f4a0057615.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDAzMSBTYWx0ZWRfX6gC3jJvvGgJP
 dM8bQNq4i8izxm4X77uvv1tgxQ7Pwge0/rFdGUcq+jPpZOyYQCD+EX3nI2TRKHzvY2APanDU7t7
 jLeK60EDoIDhQQey2pUf35m8M0kawewWzFB0KeaSg4IpGFA44rG7RgY59YZlo7dldqUymES0FtB
 +mEjxxnZ2fTgd8dIOudqDcgtk+GWZY2PRnHvM0E8yl5Lh6bl2nv2NpXtEln6GEWAMkP/EjUN1E6
 H/opBegniMDl/uDf7vqcG4WFDxzw4FmuFBS7USiqMif3gBmMtekOl2/OzeueV5BANfeU9V0DCwg
 TAFz3PDtjBM4jJC7IC2smEByz2uOZHgk+uOk1pno8pUbkxGDKSMyd0saBjokrCfDQfn8rXw1upH
 UIkoEr/k1Hamn7ZEynMTOlTnQ1n/GzKqzbVZEHZ99JvWp//6A4wZz6juKO5CnizjvAYzcBxh
X-Authority-Analysis: v=2.4 cv=dciA3WXe c=1 sm=1 tr=0 ts=686f3ba7 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=_mHSiI0rn1d2AkKRWjQA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: d5L5dnjXBks8aQ3GXcO3axhh5zIRRAUv
X-Proofpoint-ORIG-GUID: d5L5dnjXBks8aQ3GXcO3axhh5zIRRAUv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100031

On 7/9/2025 3:08 PM, Johannes Berg wrote:
> On Wed, 2025-07-09 at 08:05 +0530, Aditya Kumar Singh wrote:
>>
>> +	if (wdev->iftype == NL80211_IFTYPE_AP &&
>> +	    info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP]) {
>> +		err = nl80211_parse_unsol_bcast_probe_resp(
>> +			rdev, info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP],
>> +			&params.unsol_bcast_probe_resp);
> 
> I don't see why this should be only for AP, not e.g. P2P GO?

Yes, my bad. It should be for both here. Got confused with color_change 
handler. Let me fix this and send next version. Thanks for pointing it out.

-- 
Aditya

