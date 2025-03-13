Return-Path: <linux-wireless+bounces-20356-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4FFA604E7
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 23:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2946E189D910
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 22:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41C81F8AD7;
	Thu, 13 Mar 2025 22:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b8CMSaYB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0FF1F03C7
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 22:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741906763; cv=none; b=ixZID7/JUlmPsLYU7thhk3qAMRRoHZXUG2xNnHNis0UHMafOgcsLSnJsMQZTWRmy2MP/lENAS21sI3Ytm0bUi+UPU9KO/zeDi5EkovIpUoX//GtZ0rjH8/h0XFVxHG6b5B3/rsz384EV0fUVxUxcA/BAqc7ES/G/NMm38pTwVQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741906763; c=relaxed/simple;
	bh=zTHADoDUZPfGql6VN26E3TGY4wawt8L83GfO6E1MRUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=apWeEGlPAK0V+jTfuMOOGp65Qp09blZI8c+McR5sW8zahywiDtV/yHyCwG5LsiXt/DGNEku6yZ56IFcJ/X2AxAUzEWx1I43lyYdYtHoDGsOjbm3rXSt9WcM1dIi+gLIBV2x5nGfux75/XQ/8ucOJR9qqdR35gKDrAkISfF1qLbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b8CMSaYB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DAa0RF003492
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 22:59:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DlscsM8kt3jhJKPPI6WK1DrD4tGRZlDapuFyYmG6mcg=; b=b8CMSaYBktavQErc
	gzusZSPvMwScqKoW3tctXMTYLyd4gcn2OOieGcI6SL/mRyT4xG0+Slv54X9a10/b
	/N8QcUdtGMV9bnNoc8pSRuXMP6enZu4Be9umNz3O4+xit/f5KIff4kRw+HWSe0Fh
	TBalFKphubh2sVN72QtDCdJ/7cKOWqd64OSdazkE35xxo9adt5J5BdlTL7K+Uoau
	Ow8regM880z1csbIkMIaKIAdKhQaTTR/XDChREwF2P1mZjNF06ncWPFD3ZHV7UOG
	aQ4m2bRbKj3OOnWIK8LQiH4/IBvVc6h1ZB3peYTO6UvIglweINVPtJJsawIptu+t
	h/Lg/Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45b96yda50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 22:59:20 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2240c997059so32950065ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 15:59:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741906759; x=1742511559;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DlscsM8kt3jhJKPPI6WK1DrD4tGRZlDapuFyYmG6mcg=;
        b=aatVOPZSIQo1IfoaV7bLQbYzzCWnLRi/7pSSUfHDQwxm/Ia4mghABllskEhbUtAVWW
         Sj1yLo+YI+kjwdQe4RRvbDxq23Bh1Ula1xW7MGYMxxGPs+h7T8L9eHA1WbwXIF6v56YY
         SD+I9meX7mayEqmtt/rvd6x318tTVM0hH/Ypz4lCClg8JG62ggWnL7ZVs+GdWjyrVlSs
         snEwDBeleQCpcv8kYO6yRv7clSpt5VcFT7KwJ5guhVmv2DQaIoLbwTWsINH8aDxmRzWL
         4BWljYs/6P8KAqzSZeWhA2ZBaitt37j4kMdauYvr6FErywBjNTSzFlTBAkQvG5QcVni2
         l68A==
X-Forwarded-Encrypted: i=1; AJvYcCWhL6EjKHHwb91Io6bqCIJtB5C35UV+UZeOh9qARovQ8xX5HAhz/xP7Qbm48iytst5iG5gzAwUM3aL9SuIC5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzARL7xXVmTIznuqUsbYf0bIUdKbuqBFD6EXl4vRpj/QUYK00co
	gbmQkVTYwBDcB71SzlRGZvAdeMEWFsaGkVCTqkZj/w6dX4SBTbE82Ivr0ogCzXX6CsrJJJbycZe
	1ChuJlQ7xX3AOV7X7+GZh02qeCQLxyq1NFhQwCvwnlBteLG3yK9e/MX6ddvtz/M0H5jcV6745sQ
	==
X-Gm-Gg: ASbGnct+WcgNEEO8/yF9ONNTAKZdDavfmp2TnPnYppI0AOmsY1A5lAZAQhSS96ToHTc
	El78pWzwSFwRo50FLd4OEAEcH0V+ubL6C8qQt+8kzEHwKEUVdKo4EEe9cM8jv3iknSIugWHgWjT
	GKyaagrC62iLW3L2WXLdxAdJyPLzq16kHVImSP7g2wyeYIwmiIXxnTNhNBUw/nMMNlmSHaTP+HJ
	Ici9Gcjitj5jOP9FsrdD1Ev47cZSU3Q8WzhSZykC8xfAXiVwD5YTCvrMnqUvDVE3NWSZ1KWK5+v
	Lu8XIstqxeSXCGzYp134qsUKh4+q6ToGEZPx7C4fkRfRPum578eCXc7ESu1Z/P7/++Inmjk+
X-Received: by 2002:a05:6a00:a27:b0:736:4644:86ee with SMTP id d2e1a72fcca58-7372235af19mr315817b3a.14.1741906759460;
        Thu, 13 Mar 2025 15:59:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFy3xVoqb3anhbGk6RmIqiQdZbFPhRI7ciTb9mdlxU62/8hh2eKyhDOtWNxtwvEg4Z7wcZKAA==
X-Received: by 2002:a05:6a00:a27:b0:736:4644:86ee with SMTP id d2e1a72fcca58-7372235af19mr315798b3a.14.1741906759009;
        Thu, 13 Mar 2025 15:59:19 -0700 (PDT)
Received: from [10.227.89.219] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371155077fsm1897725b3a.37.2025.03.13.15.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 15:59:18 -0700 (PDT)
Message-ID: <4e4e4737-6040-4ec2-a3be-3fe1aba7b7cf@oss.qualcomm.com>
Date: Thu, 13 Mar 2025 15:59:17 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] wifi: nl80211: add link id of transmitted profile
 for MLO MBSSID
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, ath11k@lists.infradead.org
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Muna Sinada <muna.sinada@oss.qualcomm.com>
References: <20250310200237.652950-1-aloka.dixit@oss.qualcomm.com>
 <20250310200237.652950-2-aloka.dixit@oss.qualcomm.com>
 <52beaa2c05c91590797cc1f53b779fca085c8850.camel@sipsolutions.net>
Content-Language: en-US
From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
In-Reply-To: <52beaa2c05c91590797cc1f53b779fca085c8850.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: v0UN9W4yTQl5nJ-_B7xP0c9ZlBVDeWnV
X-Authority-Analysis: v=2.4 cv=I+llRMgg c=1 sm=1 tr=0 ts=67d36348 cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=0-u4nmc4IinrO2lHwEAA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: v0UN9W4yTQl5nJ-_B7xP0c9ZlBVDeWnV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_10,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130175

On 3/12/2025 1:55 AM, Johannes Berg wrote:
> Hi Aloka, all,
> 
>> + * @NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID: Link ID of the transmitted profile.
>> + *	This parameter is mandatory if the transmitted profile is part of an MLD
>> + *	and the interface getting configured is a non-transmitted profile. For all
>> + *	other cases it will be ignored.
> 
> So I guess it's a question of what "the interface getting configured"
> means, but I guess you could set up the transmitting interface?
> 
Right, if the interface getting configured is the transmitted profile 
the link_id is ignored.

>> @@ -5561,6 +5563,18 @@ static int nl80211_parse_mbssid_config(struct wiphy *wiphy,
>>   			}
>>   
>>   			config->tx_wdev = tx_netdev->ieee80211_ptr;
>> +
>> +			if (config->tx_wdev->valid_links) {
>> +				if (!tb[NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID])
>> +					return -ENOLINK;
>> +
>> +				config->tx_link_id =
>> +					nla_get_u8(tb[NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID]);
>> +
>> +				if (!(config->tx_wdev->valid_links &
>> +				      BIT(config->tx_link_id)))
>> +					return -ENOLINK;
>> +			}
>>   		} else {
>>   			config->tx_wdev = dev->ieee80211_ptr;
>>   		}
> 
> So shouldn't that be one layer out, so the link ID can also apply if no
> interface index was given, i.e. we took the else branch? Seems like that
> should be applicable, or is there a specific reason not to apply in that
> case?

The 'else' case in the highlighted snippet above is the same scenario as 
the 'else' case you referred to, which is one layer out: "else if 
(!config->index) {".

Both are executed when the interface getting configured is the 
transmitting interface. The difference between these two 'else's is that 
in one case userspace explicitly provides 
"NL80211_MBSSID_CONFIG_ATTR_TX_IFINDEX" and in other it hasn't.

Similarly, for MLO, mac80211 does not need the link_id of the tx 
interface because it already has the link_conf for it as part of basic 
AP configuration parameters, hence link_id is ignored in both 'else's.

Thanks.

