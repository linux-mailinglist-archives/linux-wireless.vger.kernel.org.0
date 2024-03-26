Return-Path: <linux-wireless+bounces-5266-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9201388B96E
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 05:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46FEE2C55DF
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 04:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D611E12A17C;
	Tue, 26 Mar 2024 04:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NannLI8h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1167F12A176
	for <linux-wireless@vger.kernel.org>; Tue, 26 Mar 2024 04:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711427317; cv=none; b=oz5onEky9IOPsjVUG3KzVjTmcbCPUN4/+KWRKVt79I9AgbpIs6naRGm2vlfjY0P2UKX3hVXncCVCNiQJxu3R83bJDfqDIzCEQ+NJd++7VFBFTfpBtNGKDgvNd0vwqGwNBHypY19b9QxITqxnDMnVoNdnzQGPuMKeQbi2UsYv6lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711427317; c=relaxed/simple;
	bh=Q9lbvvsGG8ICHxRoY7ubaSzLweqCnah3UyBJRR+ssNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t9iHWwWuktgCwZUJ0cJ/i4An6jldP75WZFWsWTyfi/hWqI5rV9nz1F1LSC3M1VKkqhM5xWdbb4bsw588UsuAhlkJjcg883uUd1aFWC9PXW5Fet5ub5QryA3si2Az+tFEE3X7JVmToVv/PFjdLPSLANH/hVm98jJ1l9L/90BZpAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NannLI8h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42Q2UFAT012048;
	Tue, 26 Mar 2024 04:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=y4UiPwRQVrkpjEqsahBn2ln2Ut3E0AW0TZmt9G4zYRs=; b=Na
	nnLI8hklHQf04FqCsCljaQ/RtELzve44DLoR4LsTPWa8L/B8tcN5RGJu38MkciIG
	sAfAl4k+j6l/+DF+jbMEo+dDTMoPWcdhQ91jzph0H9OaUiU20MUmHiejM4ounqMI
	6HXza7uViW0q12P2X4dugU4zkKvc3QvqYOTbNEsM6aZp5Jv26o+zgNyWHeZczr1B
	7C0DMGPeUXYG8cHj0UTAiPXCeorDt2gkzFP+Amta53lHklBkgXal1q+YQ9dgD9es
	wTJ+DUxCG7yBudeYLbOxV6eW26UFV2dFySo+EKXLuZZBDYsziOSCjEU7bb4t8hKk
	uONbs4O8lVplvm1xEjcw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x3huu0hyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 04:28:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42Q4SUSU021985
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 04:28:30 GMT
Received: from [10.201.207.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 25 Mar
 2024 21:28:29 -0700
Message-ID: <bc2422eb-efae-423e-b60a-2aa0a3ea94fb@quicinc.com>
Date: Tue, 26 Mar 2024 09:58:26 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: validate link status before deciding on
 off channel Tx
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240312154620.242773-1-quic_adisi@quicinc.com>
 <2c8338a29d3c42ebbf1fd5efd348c14471fa5004.camel@sipsolutions.net>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <2c8338a29d3c42ebbf1fd5efd348c14471fa5004.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3YQIURxSopapfWr0YGW-oy5QBmm0Z3XY
X-Proofpoint-ORIG-GUID: 3YQIURxSopapfWr0YGW-oy5QBmm0Z3XY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_02,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 mlxscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=902 impostorscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403260026

On 3/25/24 20:51, Johannes Berg wrote:
> On Tue, 2024-03-12 at 21:16 +0530, Aditya Kumar Singh wrote:
> 
>> In such cases, the bss active flag might not provide the exact
>> status of the MLD links.
> 
> That's ... true I guess, but then I'm suspicious, why are you sending
> this patch? Does that mean 'active' is managed incorrectly and actually
> becomes false when one link is removed, rather than all?

Yes I believe. I would say it is managing the pre-MLO time data 
structures. As of today, the active flag is set at assign beacon. But 
since it is maintained at sdata level, as soon as first link is assigned 
beacon, the flag would be set. Similarly, at stop_ap() it is set to 
false, so as soon as first link is brought down, it is set to false.

Hence checking that sdata level flag during MLO scenario might be 
misleading.

> Can you fix
> that too? And if you fix that ... yeah we probably still should have
> this patch but ... _without_ this:
> 

Sure let me try to fix that as well. So here's what Im planning -
1. Separate the ether_addr changes into a separate independent patch.
2. Patch series to fix the active flag handling at link level.


>> +	/* This is consolidated status of the MLD or non ML bss */
>> +	if (sdata->bss->active)
>> +		return true;
> 
> I'd think?

Yes :)

> 
>> While at it, when source address is same as the link conf's address and
>> if userspace requested Tx on a specific link, add changes to use the same
>> link id if the link bss is matching the requested channel.
> 
> Why not separate that? It's really not related much?

Yeah will put this in separate patch. Thanks.

> 
>> +	if (link_id < 0)
>> +		return false;
>> +
>> +	if (!sdata->vif.valid_links)
>> +		return false;
>> +
>> +	if (!(sdata->vif.valid_links & BIT(link_id)))
>> +		return false;
> 
> The second condition seems useless then?

Yeah. I would say "if (!sdata->vif.valid_links)" this check can be 
removed. Will remove it.
> But probably better to check *active* links, and then might as well use
> ieee80211_vif_link_active()?

Sure, I will see what I can do here. Thanks for the suggestion.

> 
>> +	link = sdata_dereference(sdata->link[link_id], sdata);
>> +	if (!link)
>> +		return false;
> 
> That might be a WARN_ON()? After all, if links are valid (or active per
> above) that really should be there?
> 

Sure, will do.

>>   int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
>>   		      struct cfg80211_mgmt_tx_params *params, u64 *cookie)
>>   {
>> @@ -817,7 +850,7 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
>>   	case NL80211_IFTYPE_P2P_GO:
>>   		if (sdata->vif.type != NL80211_IFTYPE_ADHOC &&
>>   		    !ieee80211_vif_is_mesh(&sdata->vif) &&
>> -		    !sdata->bss->active)
>> +		    !ieee80211_is_link_bss_active(sdata, params->link_id))
>>   			need_offchan = true;
>>   
>>   		rcu_read_lock();
>> @@ -897,8 +930,17 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
>>   				break;
>>   			}
>>   
>> -			if (ether_addr_equal(conf->addr, mgmt->sa))
>> +			if (ether_addr_equal(conf->addr, mgmt->sa)) {
>> +				/* If userspace requested Tx on a specific link
>> +				 * use the same link id if the link bss is matching
>> +				 * the requested chan.
>> +				 */
>> +				if (sdata->vif.valid_links &&
>> +				    params->link_id >= 0 && params->link_id == i &&
>> +				    params->chan == chanctx_conf->def.chan)
>> +					link_id = i;
>>   				break;
>> +			}
>>   
>>   			chanctx_conf = NULL;
>>   		}
>>
>> base-commit: c2b25092864a16c7865e406badedece5cc25fc2b
>

