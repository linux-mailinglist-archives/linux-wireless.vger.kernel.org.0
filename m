Return-Path: <linux-wireless+bounces-23700-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FF2ACDFD6
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 16:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F6F77A37AA
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 14:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D17329008F;
	Wed,  4 Jun 2025 14:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mzEdI2Y9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D3128F53F
	for <linux-wireless@vger.kernel.org>; Wed,  4 Jun 2025 14:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749046013; cv=none; b=N6Wbu21CIjpMYdQMSmLnfdG5KBCXldUCQ8HVx8Wlb2cuFOSoypgvtts2S+yYbyQRaX3Ug/CrQC+V7aCdyeO8Y/1Ja0LiewP17TA079sr3Wiuedogr8SDaMjDSL51pCLGwMgUQv1SlF0/1UgMaHe4z8brsrQMC9xg0diuemXE6nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749046013; c=relaxed/simple;
	bh=LOo9ZQEz2NWZxk7/gOL/t1SfJFqG5AFEJZkaR+Yxe0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jfWZ2BMf8o4Zd3hVtfYaF6JAkotoHAIqBn528VoZAs3/wY/idTwqVSHSeXJd2oM+1BtNmQDEC+YfDkHqVI4R+bOATKhGoyqjsqv3ldnt7jT67PFVaquzCUPC0CIiPMICA8hjrenzMZqqqfwY5bEVeEyI8I7ftOqck+aop4LDkm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mzEdI2Y9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5548K9Yl027289
	for <linux-wireless@vger.kernel.org>; Wed, 4 Jun 2025 14:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5xGJcvc9WybfZJgw/bBO7SWLMjxjlq76pjlmBZ4c3T4=; b=mzEdI2Y9y/GluoPI
	y0/Rdrp4zurGeFx3oOJTo3QG18y3h2kRt20Or/x+dsYFABzthLpFm55uK3u2RORI
	j8ApaTVQzvvSX/45MM2o7C5iqVlWqYzQMHwf/OzsZcfNxY+66YxBm2l2RjtBLSMB
	Ncuviqo5hiVLhpn9m+UOiayvMTbouCNVYtFkb6kYNp8rqdCdPr2iS2xwrXCBDot8
	eWDQB24BF2jKO3LU5wGxdp7ok7tNqusOnyG+z6E8+uygdfyQkLiH5Ke//qOa5DCD
	MYB/U71HvjD2EqZ5ZjqPg7VuNc/bahSZMk4eQG8V9qaNJYvNWG7eP7k+Zj2m9IFe
	IrXPfQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8sx89f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 04 Jun 2025 14:06:50 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-234f1acc707so57042775ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 04 Jun 2025 07:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749046010; x=1749650810;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5xGJcvc9WybfZJgw/bBO7SWLMjxjlq76pjlmBZ4c3T4=;
        b=PjXmt8Fis9+M8R6NIl3nRQocWZABrANnH79OJRPJFZJoEDp2ELNQMlSLuKnS3vH9yz
         vFNZL7lhljJNRluGfue9lw0zbSfl+sXRmGOcrzOyNBN2Sf92KJX+KIBgF7kDxwvk2hv4
         jN6rLcqmLmLMM55Vu5TNBGPDyp6UJBh8lbQ6x7M4FY+AbWAnsGYPhKF1e/peDhKGEv9K
         PbWNUUsg/kdUpCvvZM8hEI4390jN6/ra5D7XnW6S/V8FcGxK2dQp01FXBo+XUCFcIfoX
         d+TikNiGCMWfKaxUuyYYsoPOQ7kksXJ6JHx1w2+UBlYSXq1jsANNU0RrYDXMFD/P8XJg
         BEgA==
X-Gm-Message-State: AOJu0Yz1l23f5VL+xZ/WiBZHROvqKKVaXDLjx6im06AbVVv75TcVqkXr
	7KQk8IB5Q5/Kp1QQCNzRv/e8hbZPR7Qafj2oSkdM8fb4xwD58guVVl6Chj4m02GQNquudge8rvv
	vZRatmwON4L/I4srTDp9jOIGyKLUbLJiYN0/1qPDaQjRO/nwTAnHT8PDQvwnJYraFyJ9ZYl1dKi
	lqCg==
X-Gm-Gg: ASbGncuO++bN13zPYxU6v9VlK2tf02gL/z9OlHRwZHwORGgzXjz1Rg0th1xqday4gFb
	cQKpiMLgzLI5HHhFl1JYWE1eOIj5P+gB7xCRic9SoJ4y6Q3Al3l+sDcObb2ouMknYC49rv+jSrz
	Sv25uGwWNK/PFkxzLz0tT6Hj/3uYheenyX/pVYsQaPAsRVAyRXlBQ9RjANl2JUXNjrnqKjk3WRU
	V9hqZTjMoGh1u9xFACd4LrX7oFXVrIeUDWxvAWu8q17x/tXQOX1hnpa8XLG3sbhseiVayasX9uX
	qZJamkQBDTTLAmiH6/OQ+FAMOojEhLcq0CO878FNsAjspq+lOWHl1cGsa1pKI5XZtJA=
X-Received: by 2002:a17:903:228a:b0:220:df73:b639 with SMTP id d9443c01a7336-235e11e74d0mr47249215ad.36.1749046009711;
        Wed, 04 Jun 2025 07:06:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGflRO9w76DKHbAxPNGfV+PyKTLHNhK10nzU7kGlFNAVVDrT2kDI9qtGLy2XLTX3EWJ4VEkVQ==
X-Received: by 2002:a17:903:228a:b0:220:df73:b639 with SMTP id d9443c01a7336-235e11e74d0mr47248775ad.36.1749046009289;
        Wed, 04 Jun 2025 07:06:49 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2ecebb5cf4sm8730238a12.63.2025.06.04.07.06.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 07:06:48 -0700 (PDT)
Message-ID: <926c66d7-91a6-4555-9c2e-6557400eb5ba@oss.qualcomm.com>
Date: Wed, 4 Jun 2025 07:06:47 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/4] wifi: nl80211: allow drivers to support subset of
 NL80211_CMD_SET_BSS
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev
References: <20250604085539.2803896-1-arend.vanspriel@broadcom.com>
 <20250604085539.2803896-2-arend.vanspriel@broadcom.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250604085539.2803896-2-arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RMizH5i+ c=1 sm=1 tr=0 ts=684052fa cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=ssMj3LTDSvaIlfdxBTsA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDEwOCBTYWx0ZWRfX+xR9SgHRPzU5
 GOPrFkNvbSomLIobr4otBbw6TXH1uwb3afJsPv43QsrtC0WGK1PZczRJ8wcoGagYyk3eOc+zRIr
 w9+LNKBZoH9COozhggCf7IxQv93pwAyePihwyEvScLoM7Dt640xmAqk0d3I+F72GboL+19yYtHA
 83ZwgjPFs2/yUsvOCZiTlAyLhGZr6IORxiptSD445XbW0cJkGVGDNNMpu89PUC09fgk5RsAIXUp
 YlljtStXJN5pnXWa8DQwjMp94QrrpgmXdApVdmqnddCs8e8p8HrDdUDYJPwmkeRqNdXUiOWUgQW
 LPaeFd7mATFQC9xYIAo951h1NXv9/0g7LInmTzpPLYn2fIh4M9Bli1RxhH4mBCbmDpYZR4I4mq5
 A+evPW+ad96jeW4d0diJSKdEfKc3VJ5rNgaksH/q3bDCdWqyKtxESqkZcQ7SJzuo1Hki09KG
X-Proofpoint-GUID: njKT_8tSs5igaqX2cIUxLjamJxYPfKoB
X-Proofpoint-ORIG-GUID: njKT_8tSs5igaqX2cIUxLjamJxYPfKoB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506040108

On 6/4/2025 1:55 AM, Arend van Spriel wrote:
> @@ -2899,6 +2899,9 @@ enum nl80211_commands {
>   *	APs Support". Drivers may set additional flags that they support
>   *	in the kernel or device.
>   *
> + * @NL80211_ATTR_BSS_PARAM: nested attribute used with %NL80211_CMD_GET_WIPHY
> + *	which indicates which BSS parameters can be modified.
> + *

Ideally this should describe what is contained in the nested attribute

> @@ -2996,6 +2996,40 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
>  			    rdev->wiphy.ext_features))
>  			goto nla_put_failure;
>  
> +		if (rdev->wiphy.bss_param_support) {
> +			struct nlattr *nested;
> +			u32 parsup = rdev->wiphy.bss_param_support;
> +
> +			nested = nla_nest_start(msg, NL80211_ATTR_BSS_PARAM);
> +			if (!nested)
> +				goto nla_put_failure;
> +
> +			if ((parsup & WIPHY_BSS_PARAM_CTS_PROT) &&
> +			    nla_put_flag(msg, NL80211_ATTR_BSS_CTS_PROT))
> +				goto nla_put_failure;
> +			if ((parsup & WIPHY_BSS_PARAM_SHORT_PREAMBLE) &&
> +			    nla_put_flag(msg, NL80211_ATTR_BSS_SHORT_PREAMBLE))
> +				goto nla_put_failure;
> +			if ((parsup & WIPHY_BSS_PARAM_SHORT_SLOT_TIME) &&
> +			    nla_put_flag(msg, NL80211_ATTR_BSS_SHORT_SLOT_TIME))
> +				goto nla_put_failure;
> +			if ((parsup & WIPHY_BSS_PARAM_BASIC_RATES) &&
> +			    nla_put_flag(msg, NL80211_ATTR_BSS_BASIC_RATES))
> +				goto nla_put_failure;
> +			if ((parsup & WIPHY_BSS_PARAM_AP_ISOLATE) &&
> +			    nla_put_flag(msg, NL80211_ATTR_AP_ISOLATE))
> +				goto nla_put_failure;
> +			if ((parsup & WIPHY_BSS_PARAM_HT_OPMODE) &&
> +			    nla_put_flag(msg, NL80211_ATTR_BSS_HT_OPMODE))
> +				goto nla_put_failure;
> +			if ((parsup & WIPHY_BSS_PARAM_P2P_CTWINDOW) &&
> +			    nla_put_flag(msg, NL80211_ATTR_P2P_CTWINDOW))
> +				goto nla_put_failure;
> +			if ((parsup & WIPHY_BSS_PARAM_P2P_OPPPS) &&
> +			    nla_put_flag(msg, NL80211_ATTR_P2P_OPPPS))
> +				goto nla_put_failure;
> +			nla_nest_end(msg, nested);

I'm personally not a fan of (ab)using attribute ids in this manner. This means
the receiver would need two different nla_parse policies, one that expects
these to be NLA_FLAG when parsing the new attribute, along with the existing
policy (such as the kernel's own nl80211_policy[NUM_NL80211_ATTR]) that is
currently used when parsing the actual attributes.

Does nl80211 have existing examples of using attribute ids like this?

/jeff

