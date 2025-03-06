Return-Path: <linux-wireless+bounces-19917-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3831A54F35
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 16:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 025451884BCF
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 15:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA4C1624F5;
	Thu,  6 Mar 2025 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FtW5Sg8Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868D1212D7D
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 15:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741274835; cv=none; b=eY9wbjQp+fZZ9LGdv5hmxZo3MjIRB5Q9737i9hrqtymxLb3xSF5ttWoOZ1sVoRgjVeiTxUVnbHfF5BNriIGYAdKjMmMgw+eVePVvGaMvxRRTKZHN+09c0SJs4dL5oQB4GID+nx6+3oPphJ6z4y+Bh68imoAHmfjphE/jpviAu3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741274835; c=relaxed/simple;
	bh=FF3bp7zEv2FuAlMMlML/OkeDdvX90+al5DTsuwdsxZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j0xf2NZBNgFI+fRe+0Pd2kHkygSQ3B0aOgCnMw0bfCZ8Ef92Om8fGU1jOAiRNk1kDI3W+4jyY/RW3qdLtW3AiNx8B6bhsv7zv81t5tAut1+L6o2SNr9chxrdrVeQe7pNa+ju/V9jalepcc0T0hnOox/Nb7ueF6OxUMM6FfaZFu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FtW5Sg8Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5268OBFV006385
	for <linux-wireless@vger.kernel.org>; Thu, 6 Mar 2025 15:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rwrlIDcxt9Ox09+wTaqKQ3rxi063FBx+RfOWY9VBYYc=; b=FtW5Sg8ZH3n9hw10
	s1THGRmnjDVVsZqiJxRLLPBSHUOQfFgioj6tGjKV9cwncNsiYZtRmq7EXMxTmAaI
	pWFvbnlt3EKKJO9MdXDYYJbfR2eauTiJ0oevEsDFhZy98JgPG9e5i7WgJ6h+SuXV
	ML/G4bKGsPjdVDlgGABzsex3uAqhBT/P+Chde5icqD0uLjq9W7j8lLGr1/IVuMTU
	6PXmWDzDKMbJ0hJWnh8HwkO1Q4RVswTrs6i5K2ApShfL5V75N8rVBoKNS9C4GyzA
	6mSXpSoFU0UcDG4iuE3NRd+kpW3SsDzfBFmD2LSr4AmjYLBP3rw38mYF9C/FbC0V
	TYUO1Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6tsheu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 06 Mar 2025 15:27:12 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-224191d9228so9339185ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 06 Mar 2025 07:27:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741274831; x=1741879631;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rwrlIDcxt9Ox09+wTaqKQ3rxi063FBx+RfOWY9VBYYc=;
        b=e2hu6ANnWnAhszSnaiJDXUl23tzMlPGkOC3cAKtzgwdjiYF+XQYcRdQOfGvuNGlJBU
         hXYKRf6QVD//a7fpmtX7ww5AWHUaL9Wi0VArqCZvgPPndc60AgEM8YOtphi8c5FUny5N
         njDzZl993p88eQc/1o4VPW41uM8zb72zbt+paKngxKL4bFoqI98dCX2KojWGQUK432D5
         gD68pe7Ohorct3txG+qsWjHds6u3O2QII2YmqusplEdNx5q2kDoHhL6KmolL/aXQmdpL
         +yVDD4FWe9lKPiptLRqaG/vgpR+0ZiDQZbSfSpsulnBnHK1l6xxiWi5JpXFthgEFEOOa
         Fktg==
X-Gm-Message-State: AOJu0YxxvtaSvFfGUKcrnmqroeNB91VmR46Me1A/wHopuPLljQwj9byw
	wH3cwcbf61Dk4xCManoE6ZHSuNC8YBf7dpHOEeIqvYGtMoo4KLCLaubHwLflwJmBAiaw0p6CK7c
	zeWd0FF+PLfGDyQ0xkRzKM7ufG43tahDEk5QMy8NzLFVckS1vAWCnJboflCfiWPuqhg==
X-Gm-Gg: ASbGncvhEFckBSnsKY2iT5fZkRDgdp5hm2z/q6B743Fq1hUJXBGMKMsmtYJDEya6LUE
	V5GjQrCIts7XmPrNrKH3iMozfcqyJpMF6RQkWDN1FwrNWopeQXCVUWR6ZHYFkTiMnPKhfh4yGxK
	vj/T2rmV1vGzn5uu3ABjDtSC7VuclDLhHp+TQTWNhBPYc/OD90FDQGquz1RFsQI0G4bhUWbtFym
	qFh8z0mZ/T015RO5iLq9NfFfaZMgt+F5MSLBd7mcSkmrgSsOuqYCvY3Sv0LDN6BcCLXJhAclSTj
	sTTjKj1kyeh3pu1k6xDQRmNnwoo/sS+Bdo6jZwMsq2Wbce1EkwwkI0AorEL8PblNNPzqhhDYK70
	fKO88QBec
X-Received: by 2002:a17:902:e541:b0:220:f449:7419 with SMTP id d9443c01a7336-223f1c66c97mr113416115ad.7.1741274830835;
        Thu, 06 Mar 2025 07:27:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFJYkpHDHHDf+3HvKs7DXSvMLatZ+NITAjdwU+XIVDK7BOSW0ADPQxphq1b+4FtrhjGLFTcg==
X-Received: by 2002:a17:902:e541:b0:220:f449:7419 with SMTP id d9443c01a7336-223f1c66c97mr113415725ad.7.1741274830431;
        Thu, 06 Mar 2025 07:27:10 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a91d4esm13605115ad.198.2025.03.06.07.27.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 07:27:10 -0800 (PST)
Message-ID: <408de5a4-2948-45e9-a60e-81e2bb837331@oss.qualcomm.com>
Date: Thu, 6 Mar 2025 07:27:08 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 04/15] wifi: cfg80211: allow AP operations
 in 20 MHz configuration
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
        Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>
References: <20250306104326.4105722-1-miriam.rachel.korenblit@intel.com>
 <20250306124057.a7b909d23df2.I8a8f79e1c9eb74936929463960ee2a324712fe51@changeid>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250306124057.a7b909d23df2.I8a8f79e1c9eb74936929463960ee2a324712fe51@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HZbuTjE8 c=1 sm=1 tr=0 ts=67c9bed0 cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=QyXUC8HyAAAA:8 a=-irPrbY82WrY6EDPz6QA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: fDe4bvo1-5jO7a3PIG0-xVl0FR8jbqrm
X-Proofpoint-ORIG-GUID: fDe4bvo1-5jO7a3PIG0-xVl0FR8jbqrm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503060117

On 3/6/2025 2:43 AM, Miri Korenblit wrote:
> From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
> 
> Implemented configuration option for channel properties to allow
> soft AP/active scan operations exclusively to 20 MHz bandwidth.

why "soft"? is this not applicable to "regular" APs? P2P GO?

would be better to first describe the actual problem, and then describe the
solution. and use imperative voice.

> While on it, fixed indentation and kernel doc for
> enum nl80211_reg_rule_flags.
> 
> Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

doesn't match "From:"

> Signed-off-by: Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>
> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>

...

>  enum nl80211_reg_rule_flags {
> -	NL80211_RRF_NO_OFDM		= 1<<0,
> -	NL80211_RRF_NO_CCK		= 1<<1,
> -	NL80211_RRF_NO_INDOOR		= 1<<2,
> -	NL80211_RRF_NO_OUTDOOR		= 1<<3,
> -	NL80211_RRF_DFS			= 1<<4,
> -	NL80211_RRF_PTP_ONLY		= 1<<5,
> -	NL80211_RRF_PTMP_ONLY		= 1<<6,
> -	NL80211_RRF_NO_IR		= 1<<7,
> -	__NL80211_RRF_NO_IBSS		= 1<<8,
> -	NL80211_RRF_AUTO_BW		= 1<<11,
> -	NL80211_RRF_IR_CONCURRENT	= 1<<12,
> -	NL80211_RRF_NO_HT40MINUS	= 1<<13,
> -	NL80211_RRF_NO_HT40PLUS		= 1<<14,
> -	NL80211_RRF_NO_80MHZ		= 1<<15,
> -	NL80211_RRF_NO_160MHZ		= 1<<16,
> -	NL80211_RRF_NO_HE		= 1<<17,
> -	NL80211_RRF_NO_320MHZ		= 1<<18,
> -	NL80211_RRF_NO_EHT		= 1<<19,
> -	NL80211_RRF_PSD			= 1<<20,
> -	NL80211_RRF_DFS_CONCURRENT	= 1<<21,
> -	NL80211_RRF_NO_6GHZ_VLP_CLIENT	= 1<<22,
> -	NL80211_RRF_NO_6GHZ_AFC_CLIENT	= 1<<23,
> -	NL80211_RRF_ALLOW_6GHZ_VLP_AP	= 1<<24,
> +	NL80211_RRF_NO_OFDM                 = 1 << 0,
> +	NL80211_RRF_NO_CCK                  = 1 << 1,
> +	NL80211_RRF_NO_INDOOR               = 1 << 2,
> +	NL80211_RRF_NO_OUTDOOR              = 1 << 3,
> +	NL80211_RRF_DFS                     = 1 << 4,
> +	NL80211_RRF_PTP_ONLY                = 1 << 5,
> +	NL80211_RRF_PTMP_ONLY               = 1 << 6,
> +	NL80211_RRF_NO_IR                   = 1 << 7,
> +	__NL80211_RRF_NO_IBSS               = 1 << 8,
> +	NL80211_RRF_AUTO_BW                 = 1 << 11,
> +	NL80211_RRF_IR_CONCURRENT           = 1 << 12,
> +	NL80211_RRF_NO_HT40MINUS            = 1 << 13,
> +	NL80211_RRF_NO_HT40PLUS             = 1 << 14,
> +	NL80211_RRF_NO_80MHZ                = 1 << 15,
> +	NL80211_RRF_NO_160MHZ               = 1 << 16,
> +	NL80211_RRF_NO_HE                   = 1 << 17,
> +	NL80211_RRF_NO_320MHZ               = 1 << 18,
> +	NL80211_RRF_NO_EHT                  = 1 << 19,
> +	NL80211_RRF_PSD                     = 1 << 20,
> +	NL80211_RRF_DFS_CONCURRENT          = 1 << 21,
> +	NL80211_RRF_NO_6GHZ_VLP_CLIENT      = 1 << 22,
> +	NL80211_RRF_NO_6GHZ_AFC_CLIENT      = 1 << 23,
> +	NL80211_RRF_ALLOW_6GHZ_VLP_AP       = 1 << 24,
> +	NL80211_RRF_ALLOW_20MHZ_ACTIVITY    = 1 << 25,

if you are modifying, why not use BIT()



