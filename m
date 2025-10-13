Return-Path: <linux-wireless+bounces-27957-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CEFBD4CD8
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Oct 2025 18:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 304E65440F9
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Oct 2025 15:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E9830DEB1;
	Mon, 13 Oct 2025 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F9j/NwLm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FBA30DD3F
	for <linux-wireless@vger.kernel.org>; Mon, 13 Oct 2025 15:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369983; cv=none; b=IsAcZGBfEdiXpp/5tAHwGwQK3ObTgkVgGzLJbab6hnCA6DhOBlJkDwZrU3y6pE8ojXmq6nCgFTBdpEmZp0F4w2xgozFZ0I2aMROR07Etk8+ye91+KTVPv7cxQFkc8Om6L5S9acHXcKwYa6ed/8+IDUc82ySHdaKy9Z97oavl2j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369983; c=relaxed/simple;
	bh=DJZv9XO6AMW5Pzu4cX/CNpbhe388sE5sJYjo7HG2UiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hb1CWYFP59JcGY2JTFiWiW+NMNJibwFrzq6u7E5M4cJKqx+MppVTYoSTESUVxAmBLX1Y+0+N3IZb1hkubBzsFzlPoM+wijbCwM8W1m/ODjAjgyKZ37H5vKEmzEBZQPV1ZwhMdA9Q/ZgTh8VYvtKA7sVw530+Sni4iLII05jpqBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F9j/NwLm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DEhJOd013013
	for <linux-wireless@vger.kernel.org>; Mon, 13 Oct 2025 15:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gFxfNALQj0kVo1nFaR/pZdz97+/8Uqorpj5QRkTfdsg=; b=F9j/NwLmz4Fbf0Lv
	A2kJotKX+VXn1eUmSlYnDhzKxqBC5XE48IsCjtZZ30/XWpM4dyMHBANlJqygJZxm
	gu99K5aLjf21rYg/CvZVnZMX4jvZ54cJgny4UL1GtuGXydsFOtPS8Bl2f17j08/R
	ruDr6Iw/B4PZhn9Zu/e0foTZFg6lahdYJnZXUjgkBJCpyjjv6Z+iFEUkAc0wwXHT
	CFuP6WPWHMrP3yjLWdjZIXOoi/8od7s1gKZ+ohioK7tbKwZrpN5sxlHlAUXqAvTA
	aWDSbeXWJab8h5N3iBRWivo0ajVM4zJ8IqMg8BCG3k7EPULC8bQVys1kWFs/aP0U
	MLo1fA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rw1a9guk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Oct 2025 15:39:40 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-780f82484faso5307050b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 13 Oct 2025 08:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760369979; x=1760974779;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gFxfNALQj0kVo1nFaR/pZdz97+/8Uqorpj5QRkTfdsg=;
        b=JC7Bj2UhulNFD08aKwtr8+6B77V9KDSe4tVfX7K8wsAK6t69+dAKtpkwaFSdSbCJRI
         feRrzkGMDBIE8sX1l7uIUVYjex3d3pqc+4jnP7FKcB8Lrgdn01wfOrsXb8phup6m7T1D
         HP/55x2R7N1UbOncqLiLKnGDt9CIV8o8y1KF0Tut1vDozf6pCAdHqKOJzVVGFv2ODQf/
         2LWWoGPNbuBNBUlvpaJL4IPexaZsBXwWkGk+qaKB8s0QRu7Az16Pl/oxIebS+jLqmx9a
         RYRZwD5gNUT6DcSHB2IbdN4Mad8IXDrCkh1eYGVw7IqLv1XhO9eDI3OpPhQZhUd4KSHd
         kM2g==
X-Gm-Message-State: AOJu0YzD5U3+5hHVXt19Gia4PBmlGjWLmBi2EBQtpGCvlThi6Rp15u2d
	0jiptMGYjvG0ZVTXAkylIqoLIcR9KphUl23LjDk+ftyypHNFxqvgDRYxiRtfRmnTMJFH1f50I5K
	od+23eIliBshWVfYRzMaG4fTKOekQ862fOPSYXFfWY1XdoEFj0/HZTNPKUvWPYnwlx9gtFJM0MB
	rArQ==
X-Gm-Gg: ASbGncsN1mVYtAKnPujYWdFfhbZEpDqnkrPuz/sJ7XWyZ3Qy/JYL67ZCbAV39LmXxLQ
	LwlB/6jA04uzZRVX9+M9xnaz3PCNqALA4Ka3Fj3xVx9Mwn+n+sC0mY9oB59vPiaHhwIiEcCZi+g
	VwOpsYNXlXJPwhS1LnS7z03ihj+UCT4KbPy3Q+GKt93sL8JcsugGQ57W8GTC6FkqLQZbN2RfS8H
	8eqbr9blDjuRa0lhOGc3ry5fvW7InNYoLg59ujtF82iVehpTCoafR+xE9RvSoUjmXa9ovAQvPK2
	WMEEy4C7EKxhD387Nfq+0Si5fCN0YHKesuFyy4ffZAycNs/fmx+go3mN1SLJd0xAb6teYGWdrb/
	xpukvx8pdF/WJgVkUkun9WHPM
X-Received: by 2002:a05:6a00:2389:b0:77f:68a4:a88 with SMTP id d2e1a72fcca58-7938762f6cdmr23218485b3a.21.1760369979396;
        Mon, 13 Oct 2025 08:39:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4kxqkpVz9sQusAyfzIDLIVnk2b1584b0w/ts/XE/aPdVbk1/Yuuxpe1N910zi6UxYAFwSQQ==
X-Received: by 2002:a05:6a00:2389:b0:77f:68a4:a88 with SMTP id d2e1a72fcca58-7938762f6cdmr23218460b3a.21.1760369978948;
        Mon, 13 Oct 2025 08:39:38 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d096527sm11927416b3a.44.2025.10.13.08.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 08:39:38 -0700 (PDT)
Message-ID: <1f47148e-30cd-4698-8b1b-3a22a6c1fefe@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 08:39:37 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pull-request: ath-current-20251006
To: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
Cc: ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, jjohnson@kernel.org
References: <45843a5f-011f-4751-b9bc-004768b1454e@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <45843a5f-011f-4751-b9bc-004768b1454e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=K88v3iWI c=1 sm=1 tr=0 ts=68ed1d3c cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=WHy267Qvh4jMVSjEg6QA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: Dd4YEzsd1_SSQ3TqZ_lyQ7kWO_pyyY-h
X-Proofpoint-ORIG-GUID: Dd4YEzsd1_SSQ3TqZ_lyQ7kWO_pyyY-h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAzNSBTYWx0ZWRfXyCkSZ0H7Oqpz
 Nf+iA6LY90/URHm/It5I9/4VIgoqkRT9y3PqMZjU3r8UVese+bKh+cG2fgvTBjS1HAYBphHRnKr
 1cE+5ndpZ+T2kzaNcJZs/9q94Hx5llg8jIuiewOY38kElSPWIYPmtFYgvLRy9385TvSJhGER6tQ
 Hat6h9j1nSd9pPz1ckOBjvTUmZpxmi8anAR9lEb8o081wq7d4JhOx19l4Y4UDt9v3k4FbWw56ez
 98NFojdQWBuUg0C/vtgK8AMLjzKqgbhwKRO88xYqEFjZXUWkbq6+bfBI0lOrCJwMuC17I92aJLP
 8K3UTQHTa0rEsONL011k4e1HQ5H/rpv8hKxdGTnK9pX6yhGGKn4qHuvgzBccLB7gD855difd2pT
 BmnQrtLfuXULmQro0eMQ58dzD7inZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130035

On 10/6/2025 10:12 AM, Jeff Johnson wrote:
> The following changes since commit 4ff71af020ae59ae2d83b174646fc2ad9fcd4dc4:
> 
>   Merge tag 'net-6.17-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-09-25 08:23:52 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-current-20251006
> 
> for you to fetch changes up to 9c78e747dd4fee6c36fcc926212e20032055cf9d:
> 
>   wifi: ath11k: avoid bit operation on key flags (2025-10-06 09:48:55 -0700)
> 
> ----------------------------------------------------------------
> ath.git update for v6.18-rc1
> 
> Fix memory leaks in both ath10k and ath12k.
> Fix a sparse issue in ath11k.
> Allow ath11k suspend/resume to work on more Lenovo laptops.
> 
> ----------------------------------------------------------------
> Karthik M (1):
>       wifi: ath12k: free skb during idr cleanup callback
> 
> Loic Poulain (1):
>       wifi: ath10k: Fix memory leak on unsupported WMI command
> 
> Mark Pearson (1):
>       wifi: ath11k: Add missing platform IDs for quirk table
> 
> Rameshkumar Sundaram (1):
>       wifi: ath11k: avoid bit operation on key flags
> 
>  drivers/net/wireless/ath/ath10k/wmi.c  |  1 +
>  drivers/net/wireless/ath/ath11k/core.c | 54 ++++++++++++++++++++++++++++++----
>  drivers/net/wireless/ath/ath11k/mac.c  | 10 +++----
>  drivers/net/wireless/ath/ath12k/mac.c  | 34 +++++++++++----------
>  4 files changed, 72 insertions(+), 27 deletions(-)

Johannes,
Hopefully this can get picked up for -rc2?

/jeff

