Return-Path: <linux-wireless+bounces-19960-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BF1A55986
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 23:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32E641898CB3
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 22:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B51205AC0;
	Thu,  6 Mar 2025 22:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q+LxRUoE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE162046B1
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 22:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741299434; cv=none; b=X3ZZbFwwam8q3i24OL22CGVHyVkEn38GoFwxR6VxDOFrJlL2VGr4aAXRAiexnpiv/pUYCSOaIaYDMUmpMm8d80m+eNEAjVwFBsxoyNwjWmyGGyDQm47AyYOx1L8jJBhxtg0tr6tKFBHkMBEZx3c663WBtibWtb2nUJhFwv0zX/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741299434; c=relaxed/simple;
	bh=ygUHcNFeTeISWy5b3kddHrotso3qarkSxVsa46XeKCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UFOiKpbfHOOta2XugfCDrCcSUusiKOXrwlauwgUfOtQWOirwAav+ibGaWI1iA3NAcQgoPGKZ1hfiMW3WAAPkqIRMKsL/II8KwzI8IjBp9+e42eCDREJaNHt/s1qX74OgFWfAYO4p3H1UaLBdDsf+U8CgtqGWbNTAC8h8+9lcYvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q+LxRUoE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526B3jc8032020
	for <linux-wireless@vger.kernel.org>; Thu, 6 Mar 2025 22:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eJoVHMvkUj5xlh5KCzsA1rdiyBq7K2TFf8c2dlVJ0Hw=; b=Q+LxRUoEO7Ffy+bk
	fVVQ0zo4/h+K5Ey7RCGXBWq129WX1oRM51bYdHwa2hWihiv7KlN88W4MwDY4xbdO
	64yIxJyrDbjC7nGKCWOguwZzMKd9wF/9FZv1292dBNNQtnddToUVu13LYDEoSogv
	Uy/FblthK1vYjjgjypRxu77GeAMUdMtQKzO309R8qACELMQqRt64scD6jFjj3nOv
	BV+dUNLg9N8XyyIZK208euv1AXy8raRBZ7bVsdMsqzvzikV7qb4xxPUmrMqSCuUn
	iAfdD2INCXm6s1MuB6uDM8n5PQHutJE4utnKJJiE448FaatCQoceVQWBKEaesIYA
	DhsB7g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 457aghhts5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 06 Mar 2025 22:17:11 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2f816a85facso2113052a91.3
        for <linux-wireless@vger.kernel.org>; Thu, 06 Mar 2025 14:17:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741299430; x=1741904230;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJoVHMvkUj5xlh5KCzsA1rdiyBq7K2TFf8c2dlVJ0Hw=;
        b=iq3M12fPx8GKDzCHmJupkK63C29N/mAODTcsaJ9+9jCrZ4+0n9OH44IR182cprovi3
         233X9RbneUa4ev7ftE6ffpb0JWpLfM05kkrqTEdB1BPXw2w5wMA1/YmnGenJRWKXZ59k
         0B1uE9SdVvNOfMW0AibzdVUX1L6HqEpi0f5hZGbYG6LKOv1/HoBWgC5+bQoEgXEO7QpE
         6cdXXm39oVSFxpBWoenFLPSM5Q7e/8X6XUkD+zTwLV9jFpsC0AA+5gHgMCIqmQFCnuKw
         8w2x83wO4Oawk031OEinwYYaJtPTbGo7pKq4OFSMtoaWo0CNa6WHSY025WnAwHKZRe+V
         GqVw==
X-Gm-Message-State: AOJu0YyhCmveOTDGxdA7Di8bURQNnBS7hmeVmKw7YkpybKSC49117QF5
	pbk7bMnupoNZi2EWOuioUWR/oCa3sjC/+EMryQ+x6cAdGi9x2kN+dm8+9C82aIbFls7hzsyBZFB
	JtHrEuLPc2Yha255p3vwrsG3PIOu2yzJAlDkQV+9KkvtanisXs1LgmbkOuyOee5yVuQ==
X-Gm-Gg: ASbGncsAnOE+iyp83E8yOPeYxcZFnxB+RFNUKcQTAOyPemfu7WKqjSxD6qxVlYX/Tf8
	rnB7K/oqO7/Ut6E2kivkWStFh2HB/YyuprD/L8WP5tHDj3v0eJn5wLZ+zfgaUhH3jNYR1w9z8KA
	PtTdM1gabYS+zQ3aNz4Bxfo2pT2o98BqvnO2EmZxaCAq6MbYF8iYF5a+5P7s1Ebyo3YM+WXKlzL
	+/xErK5KQ0wxxnahqlAzmQPEqOdpTkP6yxDnZwn2RNeKZMk4t0YO4gfx8DTj7j2qQV76mvjVr+i
	pCpIXm4ZNeu8v3R8CopSvo94wskEoiP0ScQz6IK9R4Tgs+aNCHV8FqY5436hLKag0iQ/Sbynq1A
	vnThHsz9j
X-Received: by 2002:a05:6a21:3394:b0:1f3:3da7:e7dc with SMTP id adf61e73a8af0-1f544ad882amr1480685637.9.1741299430580;
        Thu, 06 Mar 2025 14:17:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxvKrqgUh7WanqKPKT+aKjTalQWqsTAW25j/DuonljCYPdTl7tc6IBs982w/jwZnFw8sKxww==
X-Received: by 2002:a05:6a21:3394:b0:1f3:3da7:e7dc with SMTP id adf61e73a8af0-1f544ad882amr1480662637.9.1741299430154;
        Thu, 06 Mar 2025 14:17:10 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af28b766ce4sm641085a12.72.2025.03.06.14.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 14:17:09 -0800 (PST)
Message-ID: <6708cd67-d944-4fc0-a9b7-1180c1e6107e@oss.qualcomm.com>
Date: Thu, 6 Mar 2025 14:17:08 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 wireless-next 04/15] wifi: cfg80211: allow IR in 20 MHz
 configurations
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
        Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>
References: <20250306234939.fe65d7888206.I8a8f79e1c9eb74936929463960ee2a324712fe51@changeid>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250306234939.fe65d7888206.I8a8f79e1c9eb74936929463960ee2a324712fe51@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: c4M32i6o7QrdZZAOir_GJwp2P_xm09dN
X-Authority-Analysis: v=2.4 cv=R5D5GcRX c=1 sm=1 tr=0 ts=67ca1ee7 cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=QyXUC8HyAAAA:8 a=NTfEBhTFy7t0cwDD6JkA:9 a=QEXdDO2ut3YA:10
 a=bK4U8n-rULbcVNSXfz1l:22 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: c4M32i6o7QrdZZAOir_GJwp2P_xm09dN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_08,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 mlxlogscore=994 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503060171

On 3/6/2025 1:51 PM, Miri Korenblit wrote:
> From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
> 
> Some regulatory bodies doesn't allow IR (initiate radioation) on a
> specific subband, but allows it for channels with a bandwidth of 20 MHz.
> Add a channel flag that indicates that, and consider it in
> cfg80211_reg_check_beaconing.
> 
> While on it, fix the indentation and kernel doc of enum
> nl80211_reg_rule_flags.
> 
> Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

S-O-B still doesn't match From:

> Co-developed-by: Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>

I missed this in the last review. Missing S-O-B of the co-developer

> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> ---
>  include/net/cfg80211.h       |  4 +++
>  include/uapi/linux/nl80211.h | 52 ++++++++++++++++++++----------------
>  net/wireless/chan.c          |  8 +++++-
>  net/wireless/nl80211.c       |  4 +++
>  net/wireless/reg.c           |  4 ++-
>  5 files changed, 47 insertions(+), 25 deletions(-)
> ---
> v2: rephrase the commit message
> 
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 29b9cf0fe6c8..9a4a5c20b568 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -127,6 +127,9 @@ struct wiphy;
>   *	even if it is otherwise disabled.
>   * @IEEE80211_CHAN_ALLOW_6GHZ_VLP_AP: Allow using this channel for AP operation
>   *	with very low power (VLP), even if otherwise set to NO_IR.
> + * @IEEE80211_CHAN_ALLOW_20MHZ_ACTIVITY: Allow using this channel for
> + *	soft AP operations and active scan in 20 MHz bandwidth,

note this patch still uses the term "soft AP" in multiple places.


