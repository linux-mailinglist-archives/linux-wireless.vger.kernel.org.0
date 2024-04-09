Return-Path: <linux-wireless+bounces-5989-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9B789D15E
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 05:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FB41281567
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 03:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A276A54FAB;
	Tue,  9 Apr 2024 03:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YYWX3xr2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF40F54F95
	for <linux-wireless@vger.kernel.org>; Tue,  9 Apr 2024 03:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712635053; cv=none; b=PnRZsot5QZ2rWPw1B8CtUJkKgNiMzZzqN0+qFQ+SJpWvdFiWMkeT1sbDhSIlrVatfpWvgd1X7IQNWYP9g0UxvQXQeejbSMWFzv/0Wx2+Azl8Av/pNvgYrHXolc2oqvqNLnUbunXbZYOlKNIk0Aah6IAYAyqw17VNfJXTSCdnjK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712635053; c=relaxed/simple;
	bh=IMDHV5KRTrbzqE5SwgGsDAx0d2O+vkhJ0tIQFQH65z8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UVI6sLY/V6K8rD6FJpT42cf6v+Iv1LfBjpYAy7koQTiPNki/F/kdDBXtQXkUFjTpg20lR1+9bezWYHP0SmA4vSahIyr8lwVtDCP+XWIMl1rQoIl9QnQEhLUolBFpkzO7F6zKYYXdKEDIScpNBPX8h7L1y2Z8fxzJfrzyOTDtGM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YYWX3xr2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4390l9D8032535;
	Tue, 9 Apr 2024 03:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=+we+/wESv/0HibPrl5dUw7ZLp/mpcF0Mls0N3rvfpkA=; b=YY
	WX3xr2VgqxhKpQ/tl3ux8vr0ElZtCmpQl4jkXDISYB5EwIlZi2E3vtIW34PL/G+P
	/djOmrjcJc065p8cvX0/Evy41H0GIOqfghSXAjJFFSDp1qkbwIPvfJfjyoo49dCH
	Hj7DvHvSPg0nzK/mWoxPu024O/BJDrtlkR1DYuKGAjNeyIhLHM5Ggh9wyYtWyZHR
	bS0d/8SdXfz1N7NIpggVdq47NB4sxSdYwipsMFmbOl7DleLT3Q2MTD5mjasPZZwg
	Uf03Pg34nxVEdTpz3DCVI+6WDArf7VyQ1F8G7oGlTT/XocjDz/tb1cgSYjz3Sh6G
	p9iZ4PsllVwgaQA88dVw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xcbg0adyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 03:57:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4393vLgZ026345
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Apr 2024 03:57:21 GMT
Received: from [10.216.45.2] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Apr 2024
 20:57:20 -0700
Message-ID: <15bc7705-5da9-4c56-aa45-81972bad5e01@quicinc.com>
Date: Tue, 9 Apr 2024 09:27:16 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: handle sdata->u.ap.active flag with MLO
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240326151141.3824454-1-quic_adisi@quicinc.com>
 <bae1e71edcc13e73e8ef7f24d30140a4a6aefb98.camel@sipsolutions.net>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <bae1e71edcc13e73e8ef7f24d30140a4a6aefb98.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JYxyBKCZ0RMQ2D_d1Z6MOkeFj_mhxfKN
X-Proofpoint-ORIG-GUID: JYxyBKCZ0RMQ2D_d1Z6MOkeFj_mhxfKN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_19,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxlogscore=877 clxscore=1015 spamscore=0 impostorscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404090022

On 4/8/24 23:55, Johannes Berg wrote:
> On Tue, 2024-03-26 at 20:41 +0530, Aditya Kumar Singh wrote:
> 
>> @@ -1232,7 +1256,9 @@ ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
>>   	}
>>   
>>   	rcu_assign_pointer(link->u.ap.beacon, new);
>> -	sdata->u.ap.active = true;
>> +
>> +	if (ieee80211_num_beaconing_links(sdata) <= 1)
>> +		sdata->u.ap.active = true;
> 
> I don't understand this change. Neither the <= 1 really, nor the fact
> that you actually _make_ this change.
> 

The place above where we are checking number of beaconing links, at that 
point at least 1 should be active. Since before checking, we have done 
rcu_assign_pointer() so at least 1 should be there. That is why that 
condition.

If it is more than 1, then this is not the first link which is going to 
come up and hence there is no need to set the flag again.

>> @@ -1486,7 +1488,10 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
>>   		if (old)
>>   			kfree_rcu(old, rcu_head);
>>   		RCU_INIT_POINTER(link->u.ap.beacon, NULL);
>> -		sdata->u.ap.active = false;
>> +
>> +		if (!ieee80211_num_beaconing_links(sdata))
>> +			sdata->u.ap.active = false;
> 
> == 0 maybe?
> 

Yeah can do. I prefer "!expr" over "expr == 0". Do you have any preference?

> Or maybe we should just save/restore the value instead?
> 
>>   	list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list)
>>   		netif_carrier_off(vlan->dev);
>>   
>> -	if (ieee80211_num_beaconing_links(sdata) <= 1)
> 
> Unrelated, but it looks like the VLAN netif_carrier_off() handling above
> is also wrong and should really go into this if block as well.
> 

Yeah MLO VLAN changes would do that? The previous change was focusing on 
the AP mode alone and I did not want to break anything in VLAN so did 
not touch it there.


