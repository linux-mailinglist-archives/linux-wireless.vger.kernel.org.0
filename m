Return-Path: <linux-wireless+bounces-33615-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vqvkJsKXvWl7/QIAu9opvQ
	(envelope-from <linux-wireless+bounces-33615-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:53:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9AE2DF97D
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 49E69300B9FD
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 18:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2442D3AA1A2;
	Fri, 20 Mar 2026 18:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YdipgQYf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PzCpevmS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05BB305047
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774032830; cv=none; b=nDtoLpSUX7WvxQ8mqAniYxC2xpwxK64uI4FSm8DBYryinyea2hjtx5cMWhwNO7sEaU492wH3NW+wqczqgCMj7vN6tw+CnF0O3X3ez7rKgJu1lBE2zTwC7EWFcm7bOb4DHP2dyq7wpkcamBUa+9A/YtwgS2QzN7cvE+5aqJbCbtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774032830; c=relaxed/simple;
	bh=RI5kUDUvez5nd42xzXV4nNyTj1c/uaPhIpm2OvDACi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qEDB6Qq/TgK+eD02J+KFn8HUP6/KtpV6OlBHhct5ArkCCzDgh6V31zCUi7wAsRlZ1xI8TH1Zo0kggbqxtU6Yg2Ic4cGoNJPFNqp/StlBzfgA1OHNGOIZA3YE1Tb9C4/DrfUFTpeD78Ppssqvxv4l9aa5ZAWRsRixHEXy9Pli++U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YdipgQYf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PzCpevmS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62KBshPh3876222
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:53:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nvggQAxhcXLCxg8nDzBaM0RXeWq3+JBxMdBPvbElXmo=; b=YdipgQYfL39rm50P
	e/HgmPbpungD9QpmOzvWhxBUgXllsgoIRnpDjiTk3RsaW6dYugQEDrOAvjlAXXdA
	H9YgaE/gh/SgUcKrmLgrQLrEVlkp/NGC+Xpq7UZNvLEYvUMOlcKmTmJs2YzMZhsE
	Wj520VFrvzRWy7SGJuyw8NCXG08cdT+5Pn40wYAc8Bm92/OZrMDTsHYLpAUWf68s
	rgmn3CsU9+JWU3/kUtOR/ZlO77sdAtrIhMXtnpCXViAG3eKeQ65C6RlFVD4D967t
	CXY0sveWcSin8+tZjcJ4wRy0/NWS2WJrKu8I0+4jwkW8g4HPh1BEss7eop5ho3rJ
	j6PX6A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d15s091e0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:53:47 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82a8203055bso1330364b3a.1
        for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 11:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774032826; x=1774637626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nvggQAxhcXLCxg8nDzBaM0RXeWq3+JBxMdBPvbElXmo=;
        b=PzCpevmSI1h4VHjjJPZly20kDa4tYb5nVUTLuFxKqOCs8kQsIjhHLxxC95S27Danlb
         RQekkTFOvIGGIVJPDsEIxYHzAol+g2WXEYoyDF1ezDmYo15H3GWTalWn7F4bqbpCuxEM
         iMBa+CNMGEIJ1vJYZKKQ427SSAIpiW0s6as4ANt3frcXGtXnDULg9dOBhpLg7rgi02N8
         B8dzfqVlBpX0M/5AAX04BabLNSlfnJS7sXhvic73biHKWYEGDP3sJJGG2UrXbNrbnsvY
         KP4iJ02Iau6xWHrxheUXShfpRhqHYldoT+chFJHKMf7UmFQq3x5GdGd8WT7zrM9lEokF
         vQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774032826; x=1774637626;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nvggQAxhcXLCxg8nDzBaM0RXeWq3+JBxMdBPvbElXmo=;
        b=K32M1M3WTUZJLrgTxZGZhTLrKcZJ3XCRttEWQuPEnVI9W1FA/yI+d7rajz4/nU2hPq
         0MTpRFhWEHkDCx4AAuj4WrEbrDKO6qx4NRp1uoSiJPEskUwEYBuC7k6FLc6Ii+smJmKv
         1+7IoQdUqxPnk6FTpQa7JGZ9M0/TsVBjXQTM5gCvIpIvSTRtA94z5Zc2VUl/zp1khJDR
         HLRdUsCBX35uquF8Y9ZrSI+OhnbPYVpng2QRTh2WZhNH9Dg2xxOQJL+LTwnhTM7pnlpy
         Iz3Jcm0fz+epAsWFTWYcYbeuVD6gUYe9BCwSdA4nv6HoQEStt1o+T6yLXpX8OPpmJe36
         lBcw==
X-Gm-Message-State: AOJu0YwQsPzOz+634WdtfoMEH4XE2bkTXC2CYG7WeKXNfJ7hW7SxXO8j
	t96IbBcI1gWWHeDzlfQ1DWeZmK0tZ1DW9V1lsbJU7uzJqIKOsRSX57A84JUFDCI0uIsv+C1rQ5J
	eMlql0uCGcV+JXjb5JtK/2HyVHLYa2IoENWc8Q0m/j9pAxy+mv7XFp+uhCqTU3TOo7Pj9
X-Gm-Gg: ATEYQzzHThUJX0BCgxmfw8/MtAw+MXTuPxGxiofcMbya9bgM9/el0biMaQb0me6JWZP
	4as4fsZZKfpRJOXT0e/3X8EC2OIHBxNYGhHYkXPshMWxd5KcPa8jQajSr6Q5FIZbYSbOndmR4++
	oYjYg5fbwGvZkuYwiBvoZ8ngD1EtmMByIhbUUgpoNGrx8Hx6nbX2ekFOhUtAHRb9Chohgj0sjly
	c408nVwRK9uYy5Aj5uJWIsp+RIhf37fo0Xe3nu5L/z8JT/W3lhN483zw+KS/aytjdESPbDePoXX
	25b85t4cPAebvwLOcTAt+RVyXo4VdY1bqsdFRSTFG69sdZTEtJ6p3pu+ujtFHlG4NQGAetlnXgP
	7Ws/YG9nGXvKH3Ft4Q03bGP0Y8CMJBd7Bk/5bbOLDOfdyTLCXEqjmIfU=
X-Received: by 2002:a05:6a00:4b03:b0:823:b1f:892e with SMTP id d2e1a72fcca58-82a8c38995bmr3096921b3a.43.1774032826580;
        Fri, 20 Mar 2026 11:53:46 -0700 (PDT)
X-Received: by 2002:a05:6a00:4b03:b0:823:b1f:892e with SMTP id d2e1a72fcca58-82a8c38995bmr3096902b3a.43.1774032826049;
        Fri, 20 Mar 2026 11:53:46 -0700 (PDT)
Received: from [192.168.0.109] ([103.88.239.214])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0421df0esm3310452b3a.58.2026.03.20.11.53.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 11:53:45 -0700 (PDT)
Message-ID: <6884a77d-55eb-4f9e-b0ec-575b408103af@oss.qualcomm.com>
Date: Sat, 21 Mar 2026 00:23:42 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v3 07/15] wifi: cfg80211: add continuous
 ranging and PD request support
To: "Stern, Avraham" <avraham.stern@intel.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kavita.kavita@oss.qualcomm.com" <kavita.kavita@oss.qualcomm.com>
References: <20260305160712.1263829-1-peddolla.reddy@oss.qualcomm.com>
 <20260305160712.1263829-8-peddolla.reddy@oss.qualcomm.com>
 <CH3PR11MB8383BA2E902BF1359F4E050BFF44A@CH3PR11MB8383.namprd11.prod.outlook.com>
Content-Language: en-US
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
In-Reply-To: <CH3PR11MB8383BA2E902BF1359F4E050BFF44A@CH3PR11MB8383.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 0wXSCnvmbaxlX9L9fiSsryh0A6WKa0-d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE1MyBTYWx0ZWRfXwZo5Wy6PJIR0
 mbgeKdO9zLoy0rU0QtMW4Bd9Vt9Eiq6CLKlioZ8dkqxmNoYvHbOfpsfEogoPKm1nJjWpsJFOS8N
 r7b679x1yJzhUfQphbdeJU4a+0XcFQOs4JA6ltEgS2CUL65qUR+ufYo5lh5ll7Bi0soYH+mTk4H
 W5hwsW/83FHF6lWH2dMLi8TmAtczDxbknDiAPwVAMRgAvLCRtCvku8dbphzcKLkN/V651a8akCQ
 bdXAPE5Dp/JnW6ERRnpKF6AIyK1Fz4S/j44RmLbVFvyWpfzCfgEBtg/IIz7anFGcUsGzeRoEM3g
 1cT5yyR8zkDlGYo4/moOgLWXWVS2TwAcgNpLkfbhkPkDfiQ5bFa0nCbO6NIFCGTGFu5UGeMRUnR
 3N0i296HgSTxdK5U68oUe2GJRYYSOPrQhhw+I2FU9/XzjErfnSAIdiofXouo5ed6pHe8nr50SLU
 exvzjSjqpWGXXP0nUoQ==
X-Proofpoint-GUID: 0wXSCnvmbaxlX9L9fiSsryh0A6WKa0-d
X-Authority-Analysis: v=2.4 cv=KORXzVFo c=1 sm=1 tr=0 ts=69bd97bb cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=VSCeRQfBNntvLL3gq5i/+A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=stkexhm8AAAA:8 a=VwQbUJbxAAAA:8 a=0cxfQOyXmrgczWEH8QAA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22 a=pIW3pCRaVxJDc-hWtpF8:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200153
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33615-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2B9AE2DF97D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 13-Mar-26 2:41 AM, Stern, Avraham wrote:
>
>> From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
>> Sent: Thursday, March 5, 2026 6:07 PM
>> To: johannes@sipsolutions.net
>> Cc: linux-wireless@vger.kernel.org; kavita.kavita@oss.qualcomm.com
>> Subject: [PATCH wireless-next v3 07/15] wifi: cfg80211: add continuous ranging and PD request support
>> Proximity detection (PD) applications require sustained measurement sessions without repeated FTM negotiation overhead. Currently, each ranging session requires separate negotiation.
> There are already NL80211_PMSR_FTM_REQ_ATTR_BURST_PERIOD, NL80211_PMSR_FTM_REQ_ATTR_BURST_DURATION and NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST, which are practically the same as nominal_time, availability_window and measurements_per_aw, respectively. These are used for pd_request with EDCA.
> Maybe these can be reused for pd_request with NTB as well (with clarifying the usage in their description?)


These need to be different as they are different size w.r.t EDCA params as per specification and are of different units and have very different Max values.

>
>
>> + * @min_time_between_measurements: minimum time between two consecutive range
>> + *	measurements in units of 100 micro seconds, applicable for
>> + *	non trigger based ranging. Only valid if @non_trigger_based is set.
>> + * @max_time_between_measurements: maximum time between two consecutive range
>> + *	measurements in units of 10 milli seconds, to avoid FTM negotiation
>> + *	applicable for non trigger based ranging. Only valid
>> + *	if @non_trigger_based is set.
> The user doesn't need to control these. Only the periodicity parameters below.


These below parameters could be optional based on these.

>
>> + * @availability_window: duration of the availability window (AW) in units of
>> + *	1 millisecond (0-255 ms). Only valid if @non_trigger_based is set.
>> + * @nominal_time: Nominal duration between adjacent availability windows
>> + *	in units of milli seconds. Only valid if @non_trigger_based is set.
>> + * @measurements_per_aw: number of measurement attempts per availability window
>> + *	with a maximum value of 4. Only valid if @non_trigger_based is set.
> All these should be valid only if repeated periodic measurements are requested. But there is no indication for that...
> Need to add number_of_measurements (similar to NL80211_PMSR_FTM_REQ_ATTR_NUM_BURSTS_EXP) to indicate how many repetitions are requested.


We added this parameter in the new version.

>
>> +	u32 availability_window;
> u8 will keep the 255 limit.
>
>> +	u32 measurements_per_aw;
> u8 is enough for a maximum of 4.
>  
>> +	   pd_request:1;
>>  	struct cfg80211_pmsr_ftm_request_peer ftm;  };
> Should be part of the ftm data. Not really needed. The device only cares if multi repetitions are requested.


Moved this, pd_request flag would be really helpful to driver/Firmware to distinguish the type of request.

>  
>
>> +	if (!out->ftm.trigger_based && !out->ftm.non_trigger_based &&
>> +	    capa->ftm.max_ftms_per_burst &&
>> +	    (out->ftm.ftms_per_burst > capa->ftm.max_ftms_per_burst ||
>> +	     out->ftm.ftms_per_burst == 0)) {
>> +		NL_SET_ERR_MSG_ATTR(info->extack,
>> +				    tb[NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST],
>> +				    "FTM: FTMs per burst must be set lower than the device limit but non-zero");
>> +		return -EINVAL;
> If ftms_per_burst is not applicable for trigger_based and non_trigger_based, they must not be set together, not ignored.


Yes, updated in next version.

>
>
>> +	if (out->pd_request && out->ftm.non_trigger_based && !out->ftm.rsta &&
>> +	    out->ftm.measurements_per_aw == 0) {
>> +		NL_SET_ERR_MSG_ATTR(info->extack,
>> +				    ftmreq,
>> +				    "FTM: Invalid parameters:measurements per avail window is zero for NTB PD request");
>> +		return -EINVAL;
> measurement_per_aw is required for rsta as well.


made it as optional, if this attribute is not present or set to zero then let Firmware/driver choose the value.

>
>
>
> ---------------------------------------------------------------------
> A member of the Intel Corporation group of companies
>
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
>

