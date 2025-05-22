Return-Path: <linux-wireless+bounces-23294-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E03AC087E
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 11:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C1E34E670F
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 09:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCFF26157D;
	Thu, 22 May 2025 09:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Mtebbu5b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158F024E4C6;
	Thu, 22 May 2025 09:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747905660; cv=none; b=n/fC9lPfJTWaFLFoCsy0BUjWeYhfgZ7hrV8T6kPnXDN5m0pdWDvgzE/Za9HgkBETGODAai86QCBdeJdGgRagO6dq2cHfDPFz5rE1jR+0OKksk9nmtqGGFXkYSQywFBacpBEx2qldepjZ1r/ZC4cY262hGBBF4xr3LXO2QcCpv+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747905660; c=relaxed/simple;
	bh=OHuTzozB28U0rVjjpAMS47dCePezCM3FiUHABLCIx34=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OV/Au7otI604NYfAzzr50QkU8o0l6w77WXkCzUAtDGv3LLFuNTvoLwYrdz9nGWa3O8qvx+snHjQwlVc2Sl5IaCMjOjiS4xBA11UnDJmp74lmxxh3TKgLjHW5a5HZiXe9h8rZZnbXzc8sJEJqi9GWNk75NjnDLIw3zvd3L7D6uHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Mtebbu5b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M8J27M011346;
	Thu, 22 May 2025 09:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hFT9iB//ZHy0uI5WBf1CwIGoaJWxrUUBWcV/HfJXa3g=; b=Mtebbu5bMHzFlIJT
	qomMl2XLov1kL3m4Q5dNdXyJFmkiA4Qr4eIuLBxt6qoPS2myYtvxCb/DS5fyNreU
	43o8R+cteGU7YFdhL/iSXpSWCMX47AytydHAjKd4tTT9nDL8pjLwgXjYgky+oyrA
	qQy8Ych5zAjbTQNmzvd1JO/8CuFIho1cCMG80FVxUtcd4Udi+zEQBhlwXN8YW3VU
	I0L+Y/uzAZYt3GUXjTjuuPcG9r98caAml6G2vPCoVtGimTmJqU5I/6Q807HiTUlH
	FX2qYRuZcG4SjpX8kfFRQje9sqNpgn6cEGxOivAQDiL7vD6Yo+28o1AgRCjUSmu0
	3dw8VA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwfb5qey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 09:20:55 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54M9KsXg014630
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 09:20:54 GMT
Received: from [10.152.207.135] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 22 May
 2025 02:20:52 -0700
Message-ID: <d2fa7aba-b038-4d5b-877e-30362336016b@quicinc.com>
Date: Thu, 22 May 2025 14:50:40 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 1/3] wifi: cfg80211: Add utility API to get
 radio index from channel
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
References: <20250514-mlo-dfs-acs-v1-0-74e42a5583c6@quicinc.com>
 <20250514-mlo-dfs-acs-v1-1-74e42a5583c6@quicinc.com>
 <37f00d636e1ffb68e383e0784b30e7e5cf48b4dd.camel@sipsolutions.net>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <37f00d636e1ffb68e383e0784b30e7e5cf48b4dd.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yGvZ9AaIKHuMzu6FJlluQlh6WcBB8bJV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA5MyBTYWx0ZWRfXzFuZ/NushvvK
 So4H3dJOpg6RB8VS4mR3AViq6aAbSzHSXk6yBgoA5egduBHLDgQzqvxP5Mi3IQxatfN92aiTZI0
 pwib43IUtC0sRSSdPrpyuNe7UnvxpL52Qkf52iibvhmTcDa/ljZgCkOi6aigu/0c2bdg4tI9YV+
 w4yp1eRa+Dgt3SlwLIK2JYyxYJdJaqpACPNUGtuLSy9NCUJkceS8hqgNGzlnvmcup1LThR0+iPd
 BgvPrwrYYVD83qReAh3UPsiN9r3uA9CeyFZJi/ujvtDZZygk/OPMfxqXYkJOgCw3SOOf14nIIGI
 Z+89uw8nbMtz74OA7yEEb/gfGqmpOBDSb9IXe+AivbtLr8UNgUuOodIjoZ45YUqc9bK63SRJQEC
 sdjmZ1nTh/xCyZ1afwe0VIUVhqx01ZhqSAJ8h/81XNfgRZZ3m/S6C9RcpGv19AlpdQdiaWUC
X-Proofpoint-GUID: yGvZ9AaIKHuMzu6FJlluQlh6WcBB8bJV
X-Authority-Analysis: v=2.4 cv=dLCmmPZb c=1 sm=1 tr=0 ts=682eec77 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=j3GVlB5bJCIp35TESxEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_04,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505220093

On 5/16/2025 1:21 PM, Johannes Berg wrote:
> On Wed, 2025-05-14 at 16:58 +0530, Raj Kumar Bhagat wrote:
>>
>> +int cfg80211_get_radio_idx_by_chan(struct wiphy *wiphy,
>> +				   const struct ieee80211_channel *chan)
>> +{
>> +	const struct wiphy_radio *radio;
>> +	int i, j;
>> +	u32 freq;
>> +
>> +	if (!chan)
>> +		return -EINVAL;
>> +
>> +	freq = ieee80211_channel_to_khz(chan);
>> +	for (i = 0; i < wiphy->n_radio; i++) {
>> +		radio = &wiphy->radio[i];
>> +		for (j = 0; j < radio->n_freq_range; j++) {
>> +			if (freq >= radio->freq_range[j].start_freq &&
>> +			    freq <= radio->freq_range[j].end_freq)
>> +				return i;
>>
> 
> I believe we also discussed this in the past elsewhere, but I don't
> think the the >= and <= can simultaneously be wrong. If the frequency
> ranges for radios are adjacent, then the intervals here need to be half
> open. I _think_ it should be < instead of <=, and therefore a half-open
> interval of "[start, end[" (or "[start, end)" depending on your
> preferred notation.)
> 

Sure, will use half-open interval ([start, end[) in next version.

