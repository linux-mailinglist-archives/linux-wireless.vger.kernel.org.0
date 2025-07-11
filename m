Return-Path: <linux-wireless+bounces-25243-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1226B011E4
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 06:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BD3D760A02
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 04:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF291991C9;
	Fri, 11 Jul 2025 04:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="enQ9jR4B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6648F7D
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 04:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752206608; cv=none; b=YPdzy4TvdJGXxZKAfMDfDOBe9mbO05hDUgpkMFa3cpgbn9zYtujnOqEFBW0bStI1zi7BJfaCnmWMuQU85RTRWRkaTMkIkz+gDeTxqtQ3RVnce03hrrk/SuBvwu/5/ogBK4latYV6kmyHBBqyr30e+8C/ASowXEr8gf85akZgOgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752206608; c=relaxed/simple;
	bh=bg3+ixo8kmdZTcBL//HGDfnvYGp7B3I1QVHnjVoV0NQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZeU2UESpwzn90lRE0b7iGXXj79baUxp1veKMRub5udu6hWpMzBve4AIywXNifVhvI1VTJHRwIvH+IP0KSIKYgjktjbG7RP63QS1E4NakNa/PSVIqO79WuP9WKtfUG6BmIOj0bS4Cx0wUnICXsxOamg8JEp/oeEY/VDUzafHPo2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=enQ9jR4B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B1XBYv011654;
	Fri, 11 Jul 2025 04:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	32VWJM5KtexjnkgFNztQ/NaefR/CF0+QSIwYfLbx0ho=; b=enQ9jR4BdxBxZ++W
	caJwFggb1pLXGIQGHw8E5KHYG5q2Nd7SD8b0J0k2CRT//OlnXszv7oMhA0dIIZoJ
	W/LXQKf79fKFaNCx2z3lJK4uoeGh24HMed763Ly81YQlfeIzoTSJqMplFewAvLCx
	emmX/gi3859G5GTXV97mEvos6VR65ioOS+6R3srlhGK6yjGH+pxGRyiC5UUjRNz5
	aVDsRLdQehaFFtVO/NxBrilk9ozcPFgx21raaT4cO5A9a7puqH8cRhoUykjfNHm5
	ffuPgxugZjtkW62Ke0RUHlJ2O87lzhwkhB/jcg8EHo52u+exzG8bDYxspuiVkUJl
	och78g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smafq3f4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 04:03:12 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56B43BrX028004
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 04:03:11 GMT
Received: from [10.50.4.247] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 10 Jul
 2025 21:03:09 -0700
Message-ID: <447d669a-a9e1-4aec-af1f-6c11bb0c27b9@quicinc.com>
Date: Fri, 11 Jul 2025 09:33:06 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next] wifi: cfg80211: fix off channel operation
 allowed check for MLO
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<aditya.kumar.singh@oss.qualcomm.com>
References: <20250701141308.733013-1-quic_amitajit@quicinc.com>
 <0616e6d71eed66c5aaaa526fdac31c3237d50680.camel@sipsolutions.net>
Content-Language: en-US
From: Amith A <quic_amitajit@quicinc.com>
In-Reply-To: <0616e6d71eed66c5aaaa526fdac31c3237d50680.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=ZJ/XmW7b c=1 sm=1 tr=0 ts=68708d00 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=KlxvSl_TSB1lbWfJtlIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: mJcGV9x_KN-EGi52RvqSQKTgMgoXSGBD
X-Proofpoint-GUID: mJcGV9x_KN-EGi52RvqSQKTgMgoXSGBD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDAyNiBTYWx0ZWRfX3Q+fxHBgb6h5
 NMGMeVRzwXGVfHasbtcZ7tKo5oM1JQfdEbdtxmLM4fOQHIaGgtYPCWAmTXKDHAJH8CuDfoQiGC3
 KFSmbNuuei0PAjpZkrcomRsiAJpnWJb90IseJ/piM2ReB/BenZTuOPGY9/j1hbFHvis7Zd5+zUw
 B1cHFtcWrVuOoEGqlNe9hcRMieJ5PDY05qurXqx41cGAl1dYPgfg4US/av0ZXixuJNLBHhVEqml
 bH/5pPrp+7zjIHTiPSHlyXdTAr9JlxMnzAXxSNL94jiqARYsgvK1BbspwMxel/TjTrSwRmaYB43
 bVHHjMz9E4tpEC//E0w66j4VTrbwkH+3nSYbaYk5t99AVXr7N21+OTvXvr52mBP5j0mJAzFVRS2
 HwtXE/NEtDoCFtFPFZ88zmqtfBENIYjhsvwu9Xrn9YLYLY1BqEg7P5Us25LMhtrqpvknUc7m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=721 impostorscore=0 spamscore=0 adultscore=0 clxscore=1015
 bulkscore=0 phishscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110026



On 7/8/2025 4:08 PM, Johannes Berg wrote:
> On Tue, 2025-07-01 at 19:43 +0530, Amith A wrote:
>> +++ b/net/wireless/nl80211.c
>> @@ -9758,6 +9758,7 @@ static bool cfg80211_off_channel_oper_allowed(struct wireless_dev *wdev,
>>   {
>>   	unsigned int link_id;
>>   	bool all_ok = true;
>> +	int radio_idx;
>>   
>>   	lockdep_assert_wiphy(wdev->wiphy);
>>   
>> @@ -9765,10 +9766,16 @@ static bool cfg80211_off_channel_oper_allowed(struct wireless_dev *wdev,
>>   		return false;
>>   
>>   	if (!cfg80211_beaconing_iface_active(wdev))
>> -		return true;
>> +		return all_ok;
>> +
>> +	if (wdev->valid_links) {
>> +		radio_idx = cfg80211_get_radio_idx_by_chan(wdev->wiphy, chan);
>> +		if (radio_idx < 0)
>> +			return !all_ok;
> Why? Do you have a code style that says "don't return constants" or
> something? I feel like I comment on this repeatedly - please don't use
> variables for constant (return) values, it just makes it harder to read
> and easier to modify the wrong way.
Thanks for the feedback. You're right, using a variable for a constant
return value in this case doesn't add clarity and could make the code
harder to follow. Will update this in the next patch
>
>
>> @@ -9777,20 +9784,33 @@ static bool cfg80211_off_channel_oper_allowed(struct wireless_dev *wdev,
>>   	/* we cannot leave radar channels */
>>   	for_each_valid_link(wdev, link_id) {
>>   		struct cfg80211_chan_def *chandef;
>> +		int link_radio_idx;
>>   
>>   		chandef = wdev_chandef(wdev, link_id);
>>   		if (!chandef || !chandef->chan)
>>   			continue;
>>   
>> +		if (!(chandef->chan->flags & IEEE80211_CHAN_RADAR))
>> +			continue;
>> +
>>   		/*
>> -		 * FIXME: don't require all_ok, but rather check only the
>> -		 *	  correct HW resource/link onto which 'chan' falls,
>> -		 *	  as only that link leaves the channel for doing
>> -		 *	  the off-channel operation.
>> +		 * chandef->chan is a radar channel. If the radio/link onto
>> +		 * which this radar channel falls is the same radio/link onto
>> +		 * which the input 'chan' falls, off-channel operation should
>> +		 * not be allowed. Hence, set 'all_ok' to false.
>>   		 */
>>   
>> -		if (chandef->chan->flags & IEEE80211_CHAN_RADAR)
>> +		if (wdev->valid_links) {
>> +			link_radio_idx = cfg80211_get_radio_idx_by_chan(wdev->wiphy,
>> +									chandef->chan);
>> +			if (link_radio_idx < 0 ||
>> +			    link_radio_idx == radio_idx) {
>> +				all_ok = false;
>> +				break;
>> +			}
>> +		} else {
>>   			all_ok = false;
>> +		}
> It seems you could simplify this a lot by just unconditionally assigning
> the "radio_idx", possibly to -1, and then if it matches you refuse?
>
> I don't see how link_radio_idx<0 could even happen, with a multi-radio
> interface that's _already operating_ on that chandef?
Working on this. Will update this as well in the next patch
>
> johannes


