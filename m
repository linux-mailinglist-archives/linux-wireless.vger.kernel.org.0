Return-Path: <linux-wireless+bounces-28110-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD832BF2201
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 17:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B3474F75AC
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 15:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB11B19C553;
	Mon, 20 Oct 2025 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ki10cO8k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079BD21B9C5
	for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 15:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974181; cv=none; b=hs2nxqMwFB3tEvzBSHhZTnQjfil7Pe2ezt3UjKHv7FWkXNQgnO3HHiVZgK8IkitUoVBb/aKaJKiSJEC/bDsuGgTRSufv7REKYwOiE7Q6caOtkjQ+XuUy+88gxgfoYWSP3xgELwQ/HGCD4gdAkx7gcb6EfWd5FRauoxYtcN7mdJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974181; c=relaxed/simple;
	bh=4vkUUk/DBrt3zmxojLq3GEdmCqyCGYcOPpJHXq9TiRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bzqVaQzJmAwgxea8PCLxnp4SIEAQJq0Ro8FNsA4fQHpSvsl+cCbCDOrnKoOiYhD1pIhV63JzTroUqTIDou+L694/+liUFpF4Sy7oc6Zc2mmxwb+xnHUyMpe8z1CoG4G1Y1QV/sHixHcW0KKt14AaLZCcRK+3YzNljAXFd67g4Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ki10cO8k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KB82TA009814
	for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 15:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X4sN8T30xc/RQbLwWdxZHlaymUFdFC7QPKQaa26lG0Q=; b=Ki10cO8kiIopBdnh
	YLzQLQ3bFNOg9EAcdwIGRidoNQbPsaqiWpBVAgDcEWQNAFXNMIuib8uAbDzi3XcP
	8oYUN0wobxSzm5J2bOb56hXO76Y1QH2JCd4ifIGoGsgX/G7QVsfvlZo75DL42rHC
	7erO/SCKF2wQVgDyrDdGKceOqO3lfpL5+kTYN1nzYFh6S4mqzfgKAaZl0HGsnfUL
	l4EnIaOUJOoBgFu61AWxXOSlvLzINEgq9zybtIWoh1FKX9CeaU1OvKHV4dD/vueX
	k8z1gw+1G2Uf8N1cBSlWaw1l24lhn7nrxFtCixcoSWFmR9cqKYRfb9b+5fzevKTW
	mF42sA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2yv54jm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 15:29:38 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7810e5a22f3so9624767b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 08:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760974177; x=1761578977;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X4sN8T30xc/RQbLwWdxZHlaymUFdFC7QPKQaa26lG0Q=;
        b=skJ0aIocmnGuss42+HsgJbeHK84xjh8XCwn8exHnQK+bEpYWrnr+UV49Tmadp9BZ37
         kdUTi9mta6WUhUMdMCf9BOFuIqVYcFKz53FbmEcMQEFQfnY0vKEOw2a1gKuCEttz8bfJ
         nmY3shY776aW8T/645CRinT3burl77yQgOjmgu1wfpBIh2q1Najwy/UC5H3/lu7ORnjG
         Vh64VfzjNYgL6T7dF9xCF8vfxLaUsvlGfU3eIkQZABEDBe65Mjg6Nx8T24uNOfJOdfAe
         6lhB0fUrjvbsXHejv4k4esSh8weLskUXvvO+6me+j4vzOTut7ewX+CjLRSPkgs4pzjEx
         4wZw==
X-Gm-Message-State: AOJu0YyEXpSi9Q+dTBmyCbyro+lRRTt2viq1G3Xy5zRwzm7ZZun9rur7
	EsoFkLXSoD//LbeFb9nvLQSBOPMATkVZAraavyc4/pTnI/feeHohYPuD2qVvdHDSEX3SDszHLSn
	+EX0VTA3POvL4FgBpgIQcSGpp90Pqt/6jU0SPFkYGDUaQW6DrIWf612Zu03aZott7r9LHOA==
X-Gm-Gg: ASbGncvLGz3BKFTopalfYFo6z2dDCninjqDIG2wtpFbNcxsk41tk2nCUdYAPzySABbl
	l3NZaXx0Hd6a5KeFmkvYBq7D8enPFyHNPGHsgoQcNEiYYQSr5uP/cfA6hSjfqRpKB+TJiNT/5vC
	/ZYzaiIID4SqvoTANFm+vINtmoFZ+136CJ0TKTIUUTEapLwFKzOjAgtCVxd4gSF8I3Vu8+XDCZ2
	AMlwnwjsWNTW5ofhbx/4iRsVOSeRS8ERHdxAE+n293GzRcxtOQf8XW5CeuMytYOHmARseFGTVdQ
	GCuK1J9KFZKuTUehLaFpx6ZrHcyUs5lQqQkgsd83KjFaHRLTKIoF0z9aOEghGmX7k4GpODyFLA6
	acr/2qVR7Tdc1NVUxu9y76nnQFPJIqbkjNwiE0wDYjlG4z0rYLdldDIn89/0=
X-Received: by 2002:a05:6a20:914b:b0:2be:81e3:1124 with SMTP id adf61e73a8af0-334a8534446mr18920921637.2.1760974177013;
        Mon, 20 Oct 2025 08:29:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlq9wz0QKaxA9lhf/BcjYQRMsIejYG8tH0TOshcnC6ud10bJurWVR3dilHOvO/9lpEHXYNUg==
X-Received: by 2002:a05:6a20:914b:b0:2be:81e3:1124 with SMTP id adf61e73a8af0-334a8534446mr18920890637.2.1760974176495;
        Mon, 20 Oct 2025 08:29:36 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2300f2606sm8576369b3a.36.2025.10.20.08.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 08:29:35 -0700 (PDT)
Message-ID: <6fdfce66-d9af-49f4-8354-a620844c9d62@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 08:29:34 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v2 0/4] wifi: cfg80211/mac80211: add an
 hrtimer based delayed work item
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
References: <20251019084951.2572582-1-miriam.rachel.korenblit@intel.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251019084951.2572582-1-miriam.rachel.korenblit@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: koKVX80jlHpRY6wOvfqvDY6iDx9ECktS
X-Proofpoint-GUID: koKVX80jlHpRY6wOvfqvDY6iDx9ECktS
X-Authority-Analysis: v=2.4 cv=f+5FxeyM c=1 sm=1 tr=0 ts=68f65562 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=18k0gBm7H-EirTVSqowA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX+1RDi+V4xqtt
 7AgW8EFtuyReUipjhGKjxpqQ2jkfdqgBeNak2dowwhF+9uL4y6w1Qs/OvH4IPKMXbFGquO1JEXq
 zcH1lH2lypfiV0TNGvGWHwMb14MLnP9qFANPXlnrLdHnGplZw64wIFf4oKG2Hpn9RTtGq3MW0KC
 TCk+J1no2bVLlE1jTXsrD9mwLuh9m1oCDy/9RRdw9wo/MpxpOH8mGMAZWNHxgXAgAw3Nv4bHi8y
 LqSwXnwA5tPYoGK9JmhTKu0rG5uWrUqoyGWqVxJq/QcwN8UhyaXu/1GBf1LPeq7myzAseErANM/
 +N5s8ebuBvvHhzdtHgvysgdekofmoITnZs57AZ8btJ9zRU0Aa6QNxInTuqwe8pTpIs4lVF1TXVe
 bGz3aY9TE2losAxSdld9+wEenZ6hJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180023

On 10/19/2025 1:49 AM, Miri Korenblit wrote:
> Apparently, the existing wiphy delayed work, based on a regular timer,
> is not accurate enough.

We have also observed this, and we have a patch under internal review for CAC
timeout that also moves to using hrtimers. Now that this infrastructure is
being added, we can use that rather than having a CAC-specific hrtimer.

In our patch we have the following observation...
As a result of commit 500462a9d ("timers: Switch to a non-cascading wheel"),
timeouts with long delays have a loss of accuracy, with a reported
worst-case of up to 12.5%. This inherent delay is resulting in the delay
observed in CAC timeout.

That explains why regular timers are not accurate enough for our purposes.

/jeff

> This series adds an hrtimer-based delayed wiphy work and uses it for
> several wiphy tasks.
> 
> Thanks,
> Miri
> ---
> 
> Benjamin Berg (4):
>   wifi: cfg80211: add an hrtimer based delayed work item
>   wifi: mac80211: use wiphy_hrtimer_work for ttlm_work
>   wifi: mac80211: use wiphy_hrtimer_work for ml_reconf_work
>   wifi: mac80211: use wiphy_hrtimer_work for csa.switch_work
> 
>  include/net/cfg80211.h     | 78 ++++++++++++++++++++++++++++++++++++++
>  net/mac80211/chan.c        |  2 +-
>  net/mac80211/ieee80211_i.h |  8 ++--
>  net/mac80211/link.c        |  4 +-
>  net/mac80211/mlme.c        | 52 ++++++++++++-------------
>  net/wireless/core.c        | 56 +++++++++++++++++++++++++++
>  net/wireless/trace.h       | 21 ++++++++++
>  7 files changed, 188 insertions(+), 33 deletions(-)
> 
> ---
> v2: add the destination tree, wireless-next, to the subject


