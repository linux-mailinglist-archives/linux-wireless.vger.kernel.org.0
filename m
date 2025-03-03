Return-Path: <linux-wireless+bounces-19698-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8038A4BBFA
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 11:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F253A4076
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 10:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0761EC01D;
	Mon,  3 Mar 2025 10:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A3irDLBq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C88C1D63F7
	for <linux-wireless@vger.kernel.org>; Mon,  3 Mar 2025 10:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997460; cv=none; b=Br79/W47SM1+g8g/n05df57yjcaesCXHO/JMy3DC0epCdkkYbY6eG9tVlhuhCNV29kaGaEkPgpTPKUwte1DsCvF8PVCRYIsHorwRT6jI7Jh+WHr9mHPwNpIUH9TMlVCfGe+GiQDw9Psc0NPVFPWwVdDy6RgCxzx6bzlFt89fCVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997460; c=relaxed/simple;
	bh=EXFAWAFP7tdrnBA3JzG/ENTLcg6j9hCoisKfEZ/Z23k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=flobYYNX0sJnqK173+qqLkDyirD1OtCLyZebbfJ3LmBKojwTi1oBx70dIhf4KxkF9JJZdv/dpEYU/bTsQ0P8x34pQSmVZ9g3pe4lJN5pwCfZ6YBrRZOFs4UFcXIfKGmLAnAcyPRsTOqtk3clU3ssTUi+0SmwfBuu6oW2ZseY7ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A3irDLBq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5237ixiP025927;
	Mon, 3 Mar 2025 10:24:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N85azqh93dvj+Fk5x5/kBg+T8FsPeFjIVgTTvJyWCBw=; b=A3irDLBq//MUAW0p
	eiKChrboyLC248rhr1YaXI5lxkCYxXOIMiwE6Dd9R1VcAOtSKJGw4iUyHY9OSsHt
	Gvw217PP2426G+BMqiO14SHsqQgW9LJcV5/ByGVD3NRi3vVpe1SVEVz7VlA1Gtja
	iDt6aA5Q09q+5JBWvqWy+iwIMwhXSPAUujL4SaQIg1UHdOmSD0Pb6Z0/fFlAh4NS
	BYPbL6RwN6kf1XkAgwhr4Sso9fYgNDIEse8pY+cR+qK7KJ1SIR+jZv8APBJbta1w
	iB+0QJpbjZxssVD4b769op5RYbi6XF+Ur72heDLGAJS1yM+A35v9FawQAJ/8yule
	nl6Yng==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4558a60jdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 10:24:13 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 523AODuI019317
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Mar 2025 10:24:13 GMT
Received: from [10.152.206.29] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Mar 2025
 02:24:11 -0800
Message-ID: <3835fb7b-255f-48e6-a7c6-dbcf5be43e30@quicinc.com>
Date: Mon, 3 Mar 2025 15:54:08 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] wifi: mac80211: Set RTS threshold on per-radio
 basis
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250129155246.155587-1-quic_rdevanat@quicinc.com>
 <20250129155246.155587-4-quic_rdevanat@quicinc.com>
 <497038580b4a41221616070dfe0f42a69ce47b75.camel@sipsolutions.net>
Content-Language: en-US
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
In-Reply-To: <497038580b4a41221616070dfe0f42a69ce47b75.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CTQ9njzFZ5W9VB2el12-hku_QaAO3cpw
X-Proofpoint-ORIG-GUID: CTQ9njzFZ5W9VB2el12-hku_QaAO3cpw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_04,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 phishscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030080



On 2/28/2025 6:37 PM, Johannes Berg wrote:
> On Wed, 2025-01-29 at 21:22 +0530, Roopni Devanathan wrote:
>>
>> --- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
>> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
>> @@ -126,7 +126,7 @@ struct iwl_mvm_time_event_data {
>>   /* Power management */
>>  
>>  /**
>> - * enum iwl_power_scheme
>> + * enum iwl_power_scheme - enum iwl power sceme set by debugfs
> 
> How does that belong here?!
> 
There was a warning reported that the documentation is not carrying 
description. Added this to remove that warning. I'll remove this in
my next version.

>> +++ b/net/mac80211/cfg.c
>> @@ -3038,7 +3038,13 @@ static int ieee80211_set_wiphy_params(struct wiphy *wiphy, u8 radio_id, u32 chan
>>  	}
>>  
>>  	if (changed & WIPHY_PARAM_RTS_THRESHOLD) {
>> -		err = drv_set_rts_threshold(local, wiphy->rts_threshold);
>> +		u32 rts_threshold;
>> +
>> +		if (radio_id >= wiphy->n_radio)
>> +			rts_threshold = wiphy->rts_threshold;
>> +		else
>> +			rts_threshold = wiphy->radio_cfg[radio_id].rts_threshold;
>> +		err = drv_set_rts_threshold(local, radio_id, rts_threshold);
> 
> Should we really just leave it all up to the driver, or perhaps call it
> multiple times for each radio? Dunno.
> 
Each time RTS threshold for a particular radio is changed, calling the function
with just that RTS threshold is beneficial, because the other radios will already
have their own data and we will be just rewriting the same values if we call the
function multiple times for each radio. Can we just stick to this method where we
are checking the number of radios and calling accordingly?

>> @@ -715,8 +716,14 @@ ieee80211_tx_h_rate_ctrl(struct ieee80211_tx_data *tx)
>>  		    tx->sdata->vif.type == NL80211_IFTYPE_OCB);
>>  
>>  	/* set up RTS protection if desired */
>> -	if (len > tx->local->hw.wiphy->rts_threshold) {
>> -		txrc.rts = true;
>> +	if (tx->local->hw.wiphy->n_radio) {
>> +		for (i = 0; i < tx->local->hw.wiphy->n_radio; i++) {
>> +			if (len > tx->local->hw.wiphy->radio_cfg[i].rts_threshold)
>> +				txrc.rts = true;
>> +		}
>> +	} else {
>> +		if (len > tx->local->hw.wiphy->rts_threshold)
>> +			txrc.rts = true;
>>  	}
> 
> Are you sure you need this? Seems odd to me.
> 
I'll remove thsi in my next version.

>> +static ssize_t rts_threshold_read(struct file *file, char __user *user_buf,
>> +				  size_t count, loff_t *ppos)
> 
> I'm not convinced it's worth keeping this at all since you can retrieve
> it via nl80211?
> 
Sure, I'll remove this in my next version.

> johannes

