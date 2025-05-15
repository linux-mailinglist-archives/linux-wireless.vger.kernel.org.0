Return-Path: <linux-wireless+bounces-23017-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEE8AB8CAA
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 18:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AACAE173CBF
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 16:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A928221289;
	Thu, 15 May 2025 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PrvjWt2E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120921A23A0
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747327212; cv=none; b=c8iqkbBm1pf+BOV9HjxtQm444RjgQUcfdmfTz2z1pXFm7fO9jI0ssCXklmVBVmDra4kaFou/pc/yumdip+RVpBOmCQMJED0AYvzvgCzTCXwi20AI9kmxsiUxUH4O0XonfQnY7qzhMfHIQyTSVOpjbHj9rOleSNoeUwt/0zhBymQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747327212; c=relaxed/simple;
	bh=aTSVwzyXf4pGtZbgvf+XLOlTFDQn+XQgnvbOlruZ3sU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KqrhSDBJM4fd28Cp/7CzKFhqVjNIIKktwu7w/ATY/KdLQiH5Tw5aXeL3ZEP9SRwtfLTM5LF8DwyAl63VVFBBvcuPI3FR/O9JBgn+6eKDrw7q2qVLZ2wirRLHcLfME5qeMIBjH+WO4/QWG7La5spoLZOm1abDddAZfZXmiAGlpck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PrvjWt2E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEFYHn025719
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 16:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xcd0A+eMWyPWvBgiDtrnIRhLjm6ZWFbOhzGDavE359Q=; b=PrvjWt2Ex8NFnVri
	m8GZjGylD7o+VARHtoj4pQSGwTVzW382QngpWFyyT/mX3yfSmDQxPThb4VL8w5wJ
	We/i+Wda5NQOfrRuTKAyT6G3yPJn2PUq/XTZPyhnAWrAQLdYPjX+enGHmvH1kw3p
	a7LFcnyCSUfBRihbQo15F0wg64jF2QyZv+VTbl5mL/zA75bKW+91VS2+xvY0BNCL
	Z/e3zHqTaIti2CNhZ64rzxrW3nYhC21GJNe5AfUQueKpPEKvyrJbHG1SQXb3kf33
	o4JaeRhmsM7Eo9j7bZgUbcZzrxFEWO31zrs5+albf8ujAlLKAiFrDxOM3CTsNHfo
	6vUK3Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcnxxqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 16:40:10 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-231c326fe2bso7642675ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 09:40:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747327209; x=1747932009;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xcd0A+eMWyPWvBgiDtrnIRhLjm6ZWFbOhzGDavE359Q=;
        b=VzfBrKJsFNiowt14f+bzKyM8shHTdhlZ+OA8JTtuk6Yns85wmz6rfefK6RXzLMJ3kc
         LXYfNLg+zBSzPBaYUqDPukhzzhxWfo8uqo+9Y7BkJLOMmRsf2FSRxvoyI1coM8pRwOg7
         EV3bLrghrUTs/j1ZEHmlMVUBlzzaQdoVeHhwB42u1WmwsJI33XR1jMNlJspUQEbcZew+
         gJRnz8Yej0BvhU1IYON5PIviYHVnVXwFgE8nxOHRzfuIsHfwAGxHL8eLa9JdxDbc8rEp
         IutczkgQRscOYQNpKAgtJv3TowBF/7qa58P/AX4iiXvn2qPrwFcSHrNJDRXN1IyArE+T
         oPxg==
X-Gm-Message-State: AOJu0YwPRto941DuN+JY5YEAw6bLrsCTWhOrqKwAVkZ9j6fNdO8Kpwba
	GM11OzgIG7lf0+IkWqHPqKukqbrmp5SuEJ7B//jsFr47o/9fIuBZkSvNZHE6yBRqFT0BRmAQHrR
	CeWAaPeRDxFgZy9r6170ZP64ZNmDZU2A6ZfMybkfYS/fbeuUEC5kT6qvo1K+Bti/brqGf4w==
X-Gm-Gg: ASbGncs7odxjnMJ2r1ItkL4A6gmaEhjxP7K9mXmYaIFAsltfMCvJ9ajon5gWZozHzBv
	+IYMb9EbasEhGhI9GjGi49KibtAAHZwIbBM3BjwJE4babYPhxwL+uykG80LZ1X6X15MeyJip3k+
	depNAoM8r5zvcMYA5vH/rfhHjOGNb4aBI1EO8vR1o0zzhkZ8tLDADVEFm0soZ9Q0iaU2PN+NCiz
	7vo0yngFEDSyRUgCXS9ZJUWSsr/PDTMofdlxWanJdH71nsZHPzcMNir2yitAgkBS9UzGAT5/aud
	Wu6KJ/Xr4cyx7SQgJjBbcH8g3UWww/8Nx9crJRkpl1rrhgywWqqKs+LiLoXHeRTwN8c=
X-Received: by 2002:a17:903:19f0:b0:223:5c33:56a8 with SMTP id d9443c01a7336-231d4536df1mr1916235ad.35.1747327209267;
        Thu, 15 May 2025 09:40:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBNI1iDsweVYvNQZScCgwVYyC9R2SjD/k0IkmWVH0zlYcfDSDnewmfRibak8VlVrqSVdMuLg==
X-Received: by 2002:a17:903:19f0:b0:223:5c33:56a8 with SMTP id d9443c01a7336-231d4536df1mr1916005ad.35.1747327208807;
        Thu, 15 May 2025 09:40:08 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231c6be7b64sm9527795ad.148.2025.05.15.09.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 09:40:08 -0700 (PDT)
Message-ID: <fc8b5d03-20e5-4fab-8aa0-6ba6f6b01f46@oss.qualcomm.com>
Date: Thu, 15 May 2025 09:40:07 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v8 00/10] wifi: cfg80211/mac80211: add
 support to handle per link statistics of multi-link station
To: Johannes Berg <johannes@sipsolutions.net>,
        Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
 <e0c26227b8023ab046606597ecddffe1c3aea307.camel@sipsolutions.net>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e0c26227b8023ab046606597ecddffe1c3aea307.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: SSkZyKDeoCPYQUGaRiXx32ZdCNDBkZXQ
X-Authority-Analysis: v=2.4 cv=D8dHKuRj c=1 sm=1 tr=0 ts=682618ea cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=_n9zmT0pgGCwk4hm-I8A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE2NSBTYWx0ZWRfX/gIPf/xMqCfr
 r+ErvZ/eftVjxO453gso3Zp5MrzKVwUOb6osQKTBZR1Srbh+r2BZLYtqHvFyNISJUwxzQBmlq+a
 WZRfR+84UPGZvWq3aTv3IuIaO8yYK+DSfJBaenIoyEkRvcPN4SDmPRtiHIv0A+TVVTlRrzw1akQ
 m4sanqI3s33JKZ56j9ho3mT2TLe/M/RmhscjENebrHwHz4RoY3pPvSSj0Uh/iy+yxEpVVcGdemN
 LNq8SutxIRiLtjMPoqQNhfVa6V6Hr1Ln+wHFm+Kyow9cLnb1tKqpLw4ZUTCsKaf+AkKqNy5uhse
 Dj9zd1WuH2sAz6+yMPJnrs6DIt+KhPIaBOoVj8MpQTIqoeVaTOzKuQqBTOeigNnkhmkr9bwxHqQ
 GOK1MtBVsw3g+EgGS2A7WnjyZYckQiY3zp/UGH+OhLmlDH3dXVF2l45Pi00sSE+LpheOgi6j
X-Proofpoint-GUID: SSkZyKDeoCPYQUGaRiXx32ZdCNDBkZXQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=844 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505150165

On 5/15/2025 4:19 AM, Johannes Berg wrote:
> On Thu, 2025-05-15 at 11:18 +0530, Sarika Sharma wrote:
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
> 
> Uh. So I really wanted to apply this now, and also started making fixes
> to it, but no, it's not really working for me at this stage.
> 
> I've pushed what I had to wireless-next link-sta-stats branch so you can
> see what fixes I already made (and pick them up), but I have further
> comments.
> 
> Jeff, I think you should probably get stuff that doesn't depend on this
> out soon, from your pending branch, we'd have to have really quick
> turnaround on all of this to get it all in place for 6.16 still.

ACK.
I'm also dealing with patches made for AP features breaking non-AP, so I need
to working through the 'pending' patches to see which I can promote and which
I need to defer.

/jeff

