Return-Path: <linux-wireless+bounces-19217-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D019AA3DE3B
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 16:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8769A70051C
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 15:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38E81C5D5C;
	Thu, 20 Feb 2025 15:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c1a9rDLu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACCE1CCEF0
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 15:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064711; cv=none; b=lyBXte7ACn5N0eeTO/FsQJnPi0lFSG6FjZhUe7zz4xit/xGGjkdP8uRiHr4Zfi6/CfJS320xklsICBXmXQmdiUime7Fb6PHNyv4D0O4Lcbc72j09LW/dSW88wavbrLoB5Krp3FROX15xF70dM56+rmswWmF0VTrwBm32PRYNXSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064711; c=relaxed/simple;
	bh=A/xckXlMp+bSIBZjHFCeDUE6CoVJSN2YBcDkQHl6pSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YJe2nNUOnXURvi2iPvW3Thjr70Gqcqeaajhm+dmBA6r6/2yTdHAMhFIYJIYWbJ6Nqdb/Vp1e+Ch03Hz8qpdWVFpuErx8z1NL0kANF0xJsNsPRefDVRDME0BNJe9X7L4MzWdfAI/nK3uG3G8XPDO0m9LVg5n8FsgwnZZ+xqZVXsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c1a9rDLu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KEvCU4024497
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 15:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MDFhrNsdY1kx0kPJdMeAswDsNzYeQpnI4+da35acGnw=; b=c1a9rDLu/S6atHUN
	2dcIDMFXWsWoxuboAfhNvheZhOeMKWaICbCtciAG0fV8nbkV2DEAgJqh9hvIgUsp
	sDuYs5IPv3snQe5FN/B6aFJvxtoxAZI+drI6u6XZthDp83vPc9KK+XD+YNUIOsTr
	2y7Atpr+nsKBNfH28Y2xnn1maNDt8LOwbuhyPfmJJUFlWNVtqDw+G5VqcZJG+eif
	3LFBvIm5ybzRyvJXy+T/ZYITVcOSwrucdDgxQcNN5V9d18orEBJgjjfpjQK+g6hm
	j9eu6Ygkijf7RRSX6FL70HvwffI1gXXFeaYmhlHxUliysLJU4gUxLXq1Vrdg0hpy
	RyWXkg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy3pkyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 15:18:28 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-220ec5c16e9so24388585ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 07:18:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740064707; x=1740669507;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MDFhrNsdY1kx0kPJdMeAswDsNzYeQpnI4+da35acGnw=;
        b=shpPjCHvlmetj7MouxZdFkSS4g8kg5Mzccujngy6l3yE9R+hdmJzYku9Z3c63TOaXQ
         dqY9QkWM9IZOyFchqL7JRzF375XHLR8sgAW95HGFgDlNwnwGihLX4PNPAnOAsVPEmvdK
         fnVDsMalCbb3RlyLDJH32gyngfyRgJ1tC5vqFlTCRHlUUN0dPNO1Ev2Ca4bHT3CDwJ07
         wW5gsUpefa6sPxjAGmbPlVdsEXXTiP6P1GO8IRVLHQvq2P33RY2oNNi20sIbFVnQWOlm
         aIjkjD02MB0NPUjE59Vn5wpX7cZN9ljsKaMRBcuenBbQ5mh+GVZMRK864zoOUQ9tK7ph
         DC1A==
X-Gm-Message-State: AOJu0YyaIxxMaNaZMM+1dzcRrTN5koFqMYYMaCup1IVaRG7OKNy4w/eZ
	0esFlOx8CFkJvFtES2J2ZEOyjc4bYwh9fI9R7pSwh8KIdVvUxGPWOrtRSrQDUYBCziOORYBp9Bx
	dOI03/rhTIkoJxN5KlfhXQQnZEEKcKPOokYDSQQehyR4lXQjrbNNsMGJPtKcFwy+aH6YTQOGpFg
	==
X-Gm-Gg: ASbGncu0334LWXld8AX9booLw+heRZqsriBaaODFys6aSPzU4eyJ2NOd61MwjL6lljx
	MSnlwfki7TSGAilSN4FfOaWidmOd8wIBstlI8zwfwFwqyZuZf3uhgez/TwqJ/b4Xo4mv5UWf05n
	s2pUF8+achei5svVreh3Sbxpybq7l4i30tGiUNe3fE/w7cs/8Bj37UHQqjYyPbeNQFI9+2FTdMC
	F5m+lndRLIAtzf5M2z2DOHqwME04b+7nzFkAzUM9xSv1eHpgMfVpp3ZlMjU10CIzQsZOQg7YM76
	wS+HAPRWeM/v/RU5tEmnfN0QmmbTjuuHbYvnPhkhj+TJDf83xjfhKODAYR7zsm5c4n7SQqeeKg=
	=
X-Received: by 2002:a17:902:f54e:b0:220:c63b:d93c with SMTP id d9443c01a7336-221040d75a0mr399578255ad.44.1740064706865;
        Thu, 20 Feb 2025 07:18:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRuCuRj5I/H6dKxpVvuX1bbiDAhyHGQI8dPrQ1MVrrYoRNze6OQUGFftyobfkpahCEox2BVQ==
X-Received: by 2002:a17:902:f54e:b0:220:c63b:d93c with SMTP id d9443c01a7336-221040d75a0mr399577855ad.44.1740064706451;
        Thu, 20 Feb 2025 07:18:26 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73250dd701bsm12547000b3a.131.2025.02.20.07.18.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 07:18:25 -0800 (PST)
Message-ID: <532a73b1-1a46-45b2-aa06-9696edad8c0e@oss.qualcomm.com>
Date: Thu, 20 Feb 2025 07:18:24 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fbx: Add missing htt_metadata flag in
 ath12k_dp_tx()
To: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250124113331.93476-1-nico.escande@gmail.com>
 <7e120d90-bbe6-47f5-bf72-c1ee681c97a0@oss.qualcomm.com>
 <D7WMZ4TCZKPB.2GBOWXBN8WKF9@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <D7WMZ4TCZKPB.2GBOWXBN8WKF9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: sZ2JxgrpenuqbLvZBLs_eUcBke9Rc1wE
X-Proofpoint-ORIG-GUID: sZ2JxgrpenuqbLvZBLs_eUcBke9Rc1wE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_06,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200109

On 2/19/2025 10:33 AM, Nicolas Escande wrote:
> On Wed Feb 19, 2025 at 6:58 PM CET, Jeff Johnson wrote:
>>
>> checkpatch complains:
>> WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '5e8a373c8699', maybe rebased or not pulled?
>>
>> And I don't see such a change in kernel.org
>>
>> Perhaps this is an out-of-tree change that should be referenced in a different
>> way?
>>
>> /jeff
> 
> Indeed I didn't realize that was not mainline, but just in our internal tree.
> My bad. Honestly surprised this has never been pushed upstream.
> 
> So the corresponding patch I was refering to is this one:
> https://git.codelinaro.org/clo/qsdk/oss/system/feeds/wlan-open/-/blob/win.wlan_host_opensource.3.0.r24/patches/ath11k/207-ath11k-Add-support-for-dynamic-vlan.patch
> 
> How would you like to proceed ? I can respin it without this wrong reference if
> need be. But if one of you guys has a better fix or something we can drop it too

Let me fix this up in the 'pending' branch

/jeff

