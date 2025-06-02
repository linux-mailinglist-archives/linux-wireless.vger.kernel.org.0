Return-Path: <linux-wireless+bounces-23532-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 073A1ACAC35
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jun 2025 12:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A38F7A4A16
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jun 2025 10:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F198519E98B;
	Mon,  2 Jun 2025 10:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OxzGHGBg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2694019049A
	for <linux-wireless@vger.kernel.org>; Mon,  2 Jun 2025 10:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748858599; cv=none; b=inl7NQjjlac0b4A3koDSWPpKrDxjD5RVzGHrPWGTE2VHWUE94xKUItpQsvp7UPHSNplO1A3kreivYhHQhHf09RBbntT0GF6aHvAOAP6iGBop0Wza9/frITXuJd9U9BjeqHoigJdJa07kdIKxsLLmOeQgJBCxBzCjKb3QOW8jto0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748858599; c=relaxed/simple;
	bh=7JCuKvJVNnpwE/ZDfSpVWtp67tYGdz1/7SQA50qH3vA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XVQt2A6rZInNm/A3o6Esnp8YoGlUjFAPV9MwEcUbkKp9uizaJeBXd4ttlWbD40I/Ocl9OFh8/M+T0gHFbIdSkEHdZzP9ZLU/MUhZF/8zOm1N7JbXgpVKmpwFseofQRO2Zp+UFWys5LlTB3nBkNAranvHcZMWHQ84++81m6Ae9hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OxzGHGBg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 551NL62e010849;
	Mon, 2 Jun 2025 10:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N94FABBWHa8jnXHSXpPmu/Zeep0hBLF6sqllvR2OVrA=; b=OxzGHGBgOVVYZOCp
	gVHU96JO+fTDvDTobsVyfqTCSBguj9oU+r6DWOun1N4A98Y3R41fIcVQqisWns04
	30e3w1wMFYSZvu3SgXzquxYKeCrSfhM4BOqLFxzvZvXC+xrmFFEOwGVE1KbDNtof
	85ks+xTlXk6YrKFPaXq0hvhxodKm7fWQ+AQEP+JgbSRwzUsU531xd+glnHmPhhd0
	SUkO78e7jInDDnzsBrxAKfa41qgFp6d+z6g2H4M/k9qHfMRYckV4KQrlrFlC2LdQ
	W9ks4n+mpi52KMIvIEN5PtlWEv4b+FL2zf7iDn3hIY339j6BGR2LwyUgvHGc41l/
	PqFV7w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46ytkr44nb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Jun 2025 10:03:13 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 552A3DqW007833
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 2 Jun 2025 10:03:13 GMT
Received: from [10.152.206.29] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 2 Jun 2025
 03:03:11 -0700
Message-ID: <188b5666-d011-4fe1-9bf4-687a3786b099@quicinc.com>
Date: Mon, 2 Jun 2025 15:33:03 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v11 3/3] wifi: mac80211: Set RTS threshold
 on per-radio basis
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>
CC: <linux-wireless@vger.kernel.org>
References: <20250522053326.4139256-1-quic_rdevanat@quicinc.com>
 <20250522053326.4139256-4-quic_rdevanat@quicinc.com>
 <e5c0fa7c-598f-40d8-b258-f935af069ff3@oss.qualcomm.com>
 <b37db169-22a6-48fb-9183-f2ed970bdd32@quicinc.com>
 <908067d3-87cf-4477-959e-0dd738244d88@oss.qualcomm.com>
 <27f4b77b27b42c5eb50fadc2c8b425e5236bf118.camel@sipsolutions.net>
Content-Language: en-US
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
In-Reply-To: <27f4b77b27b42c5eb50fadc2c8b425e5236bf118.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5ExpwwifXbPOwfPmWVkRKgCeY6l3z7DU
X-Authority-Analysis: v=2.4 cv=OMMn3TaB c=1 sm=1 tr=0 ts=683d76e1 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=6EFCf6l0sE7b6PTA_-cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 5ExpwwifXbPOwfPmWVkRKgCeY6l3z7DU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDA4NSBTYWx0ZWRfX4CM/MDyzUFRf
 YdDaeCpX71DrnEjIM1heyU9PMF3lZLDMBtf+ffQGZR53jrKQtOceWYSJTv4QOYTiFe1Pv93puVF
 KHe1bjSD5+XM0UB3bprE6UaFh2FlmXA6lunxtMpMNi6CR+9DWg0UZ6PqS8A5XIX8wpEVN/5kTRc
 hzow9/NgafS6HnOMNNcPmfG+DiOu7KZCYuhIdvd4LRXLjfJX3USOaQSTyySGDClHpzqkwMou4+/
 EgTsou6J0sncr1wwg0CM1BR1SdePFsBqslRCuijz88/xMBZfNEyzaP9orCM4q4+U2XjZp0epwSo
 qFCPUPm7u7V6PcZA18OLP1kepTbMjkeoqpCBfP3XjjQ33EsJOoLm3UeztZxUDCmn2avZCV5BQ4Z
 5WXruCo8f+nP/WIYVq5tLI1Tp5hA3govxq2yPbuoe+fBvLwVPfpoCIGkQIY/2LagDqeu0ZlK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_04,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2506020085



On 6/2/2025 1:25 PM, Johannes Berg wrote:
> On Thu, 2025-05-29 at 08:36 -0700, Jeff Johnson wrote:
>>
>>>>> +++ b/include/net/mac80211.h
>>>>> @@ -4572,7 +4572,8 @@ struct ieee80211_ops {
>>>>>  			    struct ieee80211_key_conf *key,
>>>>>  			    struct ieee80211_key_seq *seq);
>>>>>  	int (*set_frag_threshold)(struct ieee80211_hw *hw, u32 value);
>>>>> -	int (*set_rts_threshold)(struct ieee80211_hw *hw, u32 value);
>>>>> +	int (*set_rts_threshold)(struct ieee80211_hw *hw, int radio_id,
>>>>> +				 u32 value);
>>>>>  	int (*sta_add)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>>>>>  		       struct ieee80211_sta *sta);
>>>>>  	int (*sta_remove)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>>>>
>>>> rather than have one patch that modifies the get_rts_threshold API, another
>>>> that modifies the set_rts_threshold API, and future ones that will modify
>>>> others, should we put these interface changes that affect all drivers in a
>>>> single patch so that the individual driver maintainers only have to deal with
>>>> this disruption once rather than for each attribute?
> 
> 
>>> If we are going to change the interfaces of all the handlers of these
>>> attributes, I can assign a default radio_idx (-1) to all the APIs. Can I go
>>> ahead implementing this?
>>
>> That makes sense to me. Johannes?
> 
> I don't really see a huge advantage, given that I'm going to apply those
> patches either way? Do you think conflicts are likely? But if you prefer
> we can do it that way, then just should separate out those changes to
> completely non-functional patch (i.e. please don't mix actually changing
> the RTS threshold in this patch with API updates for the others, do API
> updates for all beforehand.)
> 
Sure. I'll introduce radio index attribute and change all the related APIs
in a patch. Post this, I'll bring in the changes in the series. So I'll be
sending out a v12 with 4 patches:
1/4 - radio index and API changes
2/4 - replica of [PATCH wireless-next v11 1/3] wifi: cfg80211: Add Support to Set RTS Threshold for each Radio
3/4 - replica of [PATCH wireless-next v11 2/3] wifi: cfg80211: Report per-radio RTS threshold to userspace
4/4 - replica of [PATCH wireless-next v11 3/3] wifi: mac80211: Set RTS threshold on per-radio basis

Hope this is okay.

> johannes

