Return-Path: <linux-wireless+bounces-19298-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 532D0A3FEE4
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 19:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B41C3B56D7
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 18:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0821F7561;
	Fri, 21 Feb 2025 18:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JKPOhH0a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB3D1F03F2
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 18:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162725; cv=none; b=QUG+MVFTM9wRe3Q6qXdd+hrRELFquP8ZQNHjiIe9Yx2yLibTvLzhYZEueFgBTq3GoH/oCP1X3VWH7550vBs0bd7BAO7HC+hzvcjNu22e36MD1rauB9T+QG8L9/4KURsiM5T3wBEvksoJD8sWXVxPUKaVfkna4vWiJsMEKmB1JUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162725; c=relaxed/simple;
	bh=0JXu8xC+o3WRG0/ovetoaqq1qinilGdOO9j3DG5iDU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n4kfTlOaIbGI8Kz3QJkXlqDRMqa+hFdD48lX6uz3kB0h5qI+ozx5AXWMVqJrGTlWqSkEcbVpOb93I8XCMXsg6HhZ4IKHm4LxCEIOv5TkJYXzhZEu0wvxxgdNSIeFt3pC9ydW3LAyXsyYrfoDRqkoHsEHiNKhLrLhDc/GrjPFBKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JKPOhH0a; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LCSwtq014987
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 18:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rhC3bwMh1zSJjESMPaEPiau2/0hZQf2QwnREzFhtQhA=; b=JKPOhH0acMgfA8uu
	xIMHOO3r2bgQvTpdwnuHVBJVd0JnX4DpWj8xKRn2lPSK0wkhoNMTIEoDT3hvdtAi
	028irxGp5ouqyMeusdMhlE9A6r3FvsSLcJn0auVLzURJxIDno471/kFsVHiUD3bv
	APGkTWUw/UqgIAdoMkifl0pAY23Wbh875g/V/Uf2jffsRty8ctiEnKKTUqYuUMVz
	Ldm4LPSEHhV6xCQRifgUtjv8y/KMsmH3oSrAE9TORgskuTKThAbplKK0aqdhJgx4
	D2gRkV2U6GUM1CWqfyG0jc47rxX7MvxpmNKcWX6l1H48byuIDWHJMys/19kkL9yc
	SQ4c/Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy1avyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 18:32:02 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fc2b258e82so5365246a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 10:32:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740162721; x=1740767521;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rhC3bwMh1zSJjESMPaEPiau2/0hZQf2QwnREzFhtQhA=;
        b=sEl/P5x3nqb0VLXe5HHc4j4igyRZe4gu1jWg1jzLSf6OviFMa9zQqOQedr/ct5wSep
         /HKOnNnT70lq+LNBg3Dxs+YykwairCoSg21B31+jBZnNyXJ/lO3FaIHQFwj/4Jx5wPAb
         GmmRtRwoJBpvixwaG5bG9beDgILI6EhO/cT9x8mZmN4GeBSBxmUAhWzF1zhaLKufSp+g
         wmYcQ1VokETRKpWgWhcuUdUW91p1j2LaRA+E1qIa/Cq4kvIBuj7cpVd+hCqDUoSeuoPN
         FLRyruxUxheXG1Uu4r49GqA3U/zCzIM0EllM3ysi1nUMif6adKah4QcTBLHUCbFb1bDJ
         4CQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV75x3EyFRQUMwIhzrpL1COZymBRby3xKhMwNV+EDlBnGVwpvB3vfl975wmXkHnaM1z3e9SOuB0BD5fLNulmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCbS3TKN5hhJ2dUY2Cq7mC8ypGnegG9kcr5EznBAOUrVsTdX1e
	6NORbPCCTU51pyte/OvAg8/zawXkbfO5tYOnge/ippLtVAMqB5hkpOrWTc2+MaeWKL8522fVu/d
	vqwBtuHNBrp4in5/BvxOpYqBTn2XD7hIGrHletIktDV0ZOrEsKRcHB2kgrfkmfAQgsg==
X-Gm-Gg: ASbGncv0egndU88B6tTBeNMZV3lOYihe9UQvm3EF7uqgb1uX/5zTBbGgaTUku5f2fdj
	tsEPMtFhpMCkkHU9JCoLv7tOLT39/C/OdHxyPEChHTJnCbXvDU4xB3gCGRolC5YZIXdBBnZ0peo
	CX2XNtowlZloeD2ntq12vnla7r8EU6atcU+gOkTfYJ2zbCsVn9Ph66/TmoSTP9x8txGvPyc+B0O
	pfQ8MeUC4y5iMontFV69sv6Sw562xHZhMwvTcCGwh/IhOnAVZA0If5FjCLcllcBAzhQ87z/k86/
	+yXbha7rgSqbCrxDgDUI7/aFmH9pw5Gji1krKuqlzkgyXzJxcJaaQrGsrQGh9K/CDKL38IuacgB
	1ntAshA6+
X-Received: by 2002:a05:6a00:17a2:b0:732:24ad:8e08 with SMTP id d2e1a72fcca58-73426c8555cmr6050361b3a.1.1740162721391;
        Fri, 21 Feb 2025 10:32:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEf5f09al3rVnKIctUkaNJwh9uBNopYGAdJw5I3zqswOJYkgGrLDlJasRb3swANLFbBEi51Kw==
X-Received: by 2002:a05:6a00:17a2:b0:732:24ad:8e08 with SMTP id d2e1a72fcca58-73426c8555cmr6050323b3a.1.1740162720927;
        Fri, 21 Feb 2025 10:32:00 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324275bd28sm15883247b3a.122.2025.02.21.10.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 10:32:00 -0800 (PST)
Message-ID: <2e55eb5b-9df3-48e2-8e93-511249672b05@oss.qualcomm.com>
Date: Fri, 21 Feb 2025 10:31:59 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: cfg80211: convert timeouts to secs_to_jiffies()
To: Easwar Hariharan <eahariha@linux.microsoft.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "open list:802.11 (including CFG80211/NL80211)"
 <linux-wireless@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20250219203240.141272-1-eahariha@linux.microsoft.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250219203240.141272-1-eahariha@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: OI5GNb6hQPHYktusuN60W7pq7VPRAPpY
X-Proofpoint-ORIG-GUID: OI5GNb6hQPHYktusuN60W7pq7VPRAPpY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015
 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502210128

On 2/19/2025 12:32 PM, Easwar Hariharan wrote:
> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies().  As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.
> 
> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
> the following Coccinelle rules:
> 
> @depends on patch@
> expression E;
> @@
> 
> -msecs_to_jiffies(E * 1000)
> +secs_to_jiffies(E)
> 
> -msecs_to_jiffies(E * MSEC_PER_SEC)
> +secs_to_jiffies(E)
> 
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>  net/wireless/scan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/wireless/scan.c b/net/wireless/scan.c
> index cd2124329521..1de25e9763cb 100644
> --- a/net/wireless/scan.c
> +++ b/net/wireless/scan.c
> @@ -1365,7 +1365,7 @@ void cfg80211_bss_age(struct cfg80211_registered_device *rdev,
>                        unsigned long age_secs)
>  {
>  	struct cfg80211_internal_bss *bss;
> -	unsigned long age_jiffies = msecs_to_jiffies(age_secs * MSEC_PER_SEC);
> +	unsigned long age_jiffies = secs_to_jiffies(age_secs);
>  
>  	spin_lock_bh(&rdev->bss_lock);
>  	list_for_each_entry(bss, &rdev->bss_list, list)

Reviewed-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>


