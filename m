Return-Path: <linux-wireless+bounces-20114-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67584A59BB8
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 17:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F8A01634DF
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 16:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1506D230BEE;
	Mon, 10 Mar 2025 16:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oxyJ79Wj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355A3231A3B
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 16:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741625611; cv=none; b=WJzA4MKKhY6Psc3qIPkEM0SkxjXd0rqdfLDZ4wrObEUzU5a4fVCsCBF77LPtSYyfWr+poqSK+SOlQ8pWheoYS0u/q5j06hUwL/JYAiBiGHhYRcmFcyJaqjzf+kIPAS9H05/FFonmnudFm43zoTNgeKuEt/cZWt82zJmN90L8Uaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741625611; c=relaxed/simple;
	bh=TqaqVoR0yQMyZCi6pp7QgxhMv9fl3Dr7orlLjkqC0Mw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l9ZaX34d7NPZVsG6UJPId9N/hHqxVHrJ98RRoHykdXOqfrf4ZskyJkKH4h+LLpEY1MVaae930JpX6ntwetcqZ9MsnLQonBKI9Y+hRU1ROhD/gtUw8cRhXTCjX2aZH3iim5nLQGXrPDD1hGDxA8hjY7Qb1qlW0mJmGhC2sq+vjs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oxyJ79Wj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A9w7qF010520
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 16:53:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UMzO/W54irt6BMAoLfHsHygD54EgGBplvwJofmVqwJY=; b=oxyJ79WjzPPYBC/b
	Z+idKAFcWixmhQF5lavAdWz5lvvAOpRdoMs/xChDf3lg/tLuTye0Z30wO4kjdBAt
	bFbEoxj0HYOCiL8DKV1hPFXCQoXzi47Xd9GHrJBtzJvYYZQwYrzBezlCjPqz/adF
	n3Kcd7vdDoD1tvmoyYx3kovqJOlVwVDotVNsoaKFLfWMbovEQXs5lhWnZBI/ym/r
	cOK4EaUVmMiXAq+SQgBanB3DYqfwgnQGnC7GZ/dEWNHbBreupYBmF30XVw6BFwuS
	QFA8dfqMgyqipeDBObdvIdkEsNenE0LoUkaJLbPOjsYk0WoGFi1LurOgezWrvFo0
	a96ENg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458f0pwh5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 16:53:27 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2254e500a73so28262395ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 09:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741625606; x=1742230406;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UMzO/W54irt6BMAoLfHsHygD54EgGBplvwJofmVqwJY=;
        b=dYGQZ32Cz6mNgjvjEPh3EAM2cG9zM/GPw6Lde6rp+1GQMGa2jZnfKF7fdW15ItGFYZ
         mBRD9cyfOLeXd7ZmxBkPEpTIJk8gkybBxFTswiT6jp0ZV35YgXNOCXJAXhO4EsQ8+mHj
         26uuTYRc6FK1mNHxgc8qLcrRu10rnwDP/ZEePjqtpBB7YJlaf+hDlJ/Tn1TiYMkqdWJM
         z0qOjo8+6TeQeXxPrA3HRg3vg5i/GPSAcU8ry150z+nF9Ok42N3Cwr56c8ofpOxMVh8A
         SswyG7LdbDVJlRHtgnVblNQpJpDjrjk0p8SWVxRaKl13oWa5rv0u0CFN3x5t67il7DYk
         KNuA==
X-Gm-Message-State: AOJu0Yxyw7hXaQN+R3dL7XMxb76iQhLwMx+hWSanAvqQDumcIg9H3ZND
	WYquic7QM80SNSXpPHiQwoDEAbZpTs6yQHik0GbljGlxG57tA9i0FFbv7OIrOw1bBBhRsYvnESY
	MwGqseFfnC8HCQolxp5GGNIphXGaNpt6KZuxLpnEXLNCjmNq6wEN3g8s8XxK7BxEUPg==
X-Gm-Gg: ASbGncscJlLiuH6556REIa9Z+GtaKKi+m/C/SnX5jB5Dn5lN4PyZ6wiNJZ55EqH+PGZ
	4CEvsHLxBEuzAdWK82DpsG1gucc/UkI+MFxNbeHZuRCQpp7FJTxILJdrpbOz/E/075ALKoJGmOq
	2sK28T/KLc7ZmUNO3V6JXKP4e5Kn77wWQuM3ovHBrFqsAoghtVtELlygHXHwg1F7MWuUJW7yEI8
	NCKvT/uBPqzXRT8DpDAX6rl1KT4gHdsJbNi6GlikGhuTSvbmubMs0Jq0vwWMMLVqEJB818mhKrI
	a4vJ7b5CZuSOBak/rk88Fl3jDjJhS5x8nxXZ6w1/J9itDSxm/z40ts3YNP1dGNLhgdYRKJ4=
X-Received: by 2002:a05:6a00:929e:b0:730:927c:d451 with SMTP id d2e1a72fcca58-736eb87768emr843652b3a.20.1741625605991;
        Mon, 10 Mar 2025 09:53:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHD5y6Z0edtCg0WmGRGytdKjTR0qif7TNYcYT6Acr0XTOksAPWDzwGf9nEoj66lm137aXMhzA==
X-Received: by 2002:a05:6a00:929e:b0:730:927c:d451 with SMTP id d2e1a72fcca58-736eb87768emr843622b3a.20.1741625605590;
        Mon, 10 Mar 2025 09:53:25 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736b9232b72sm5802482b3a.95.2025.03.10.09.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 09:53:25 -0700 (PDT)
Message-ID: <e90b62d7-a239-4bda-93ee-686f792ff793@oss.qualcomm.com>
Date: Mon, 10 Mar 2025 09:53:23 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 04/15] wifi: cfg80211: allow AP operations
 in 20 MHz configuration
To: Johannes Berg <johannes@sipsolutions.net>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org,
        Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
        Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>
References: <20250306104326.4105722-1-miriam.rachel.korenblit@intel.com>
 <20250306124057.a7b909d23df2.I8a8f79e1c9eb74936929463960ee2a324712fe51@changeid>
 <408de5a4-2948-45e9-a60e-81e2bb837331@oss.qualcomm.com>
 <b0a6d7d7e9a4f2bf6e93529a9f974f7d8509759d.camel@sipsolutions.net>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <b0a6d7d7e9a4f2bf6e93529a9f974f7d8509759d.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: La4vU9a12s_AgbQYKG_G9Xy1R-b2awPV
X-Authority-Analysis: v=2.4 cv=KK2gDEFo c=1 sm=1 tr=0 ts=67cf1907 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=nuJH0XAzOGxHcl4x-rsA:9 a=QEXdDO2ut3YA:10 a=0lgtpPvCYYIA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: La4vU9a12s_AgbQYKG_G9Xy1R-b2awPV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_06,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=748
 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100132

On 3/6/2025 11:29 PM, Johannes Berg wrote:
> On Thu, 2025-03-06 at 07:27 -0800, Jeff Johnson wrote:
>>
>>> +	NL80211_RRF_ALLOW_6GHZ_VLP_AP       = 1 << 24,
>>> +	NL80211_RRF_ALLOW_20MHZ_ACTIVITY    = 1 << 25,
>>
>> if you are modifying, why not use BIT()
> 
> Can we even do that in uapi/ ?
> 
> I see that there *are* users of BIT() there, but I don't actually see
> that it's *defined* anywhere, and I don't think it's really macro that
> the standard library *must* provide?

fair enough

