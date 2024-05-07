Return-Path: <linux-wireless+bounces-7297-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7068BEAB4
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 19:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCFB52853AC
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 17:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7793940BE2;
	Tue,  7 May 2024 17:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JkT4v/39"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B150E15B12E
	for <linux-wireless@vger.kernel.org>; Tue,  7 May 2024 17:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715103687; cv=none; b=b0olzbMGXw6lNW/b76FrZtbpqEyE8JaG7ECy/nrYZ2Fz9QOXco6Jz444rIevWJzSlqz3C47+OExVh2Fraq2ZeXuNdj9i7cY7WoyfI9nX0zDpMC02Szti5+afZVjBN/z8NJdpb9aLV1S3lJRM8heSMyYuTUB5Fco5PeC1uPjs1x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715103687; c=relaxed/simple;
	bh=sJ5SP2s99IJ5iYO2zEuudkqfQEYjcTYSC+LG+C3laMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gV1H2eYdK2Jw7KGNkxFSzrxTpZTaDHXgy0PHTmCDzVIHXaz+UsVxUotXgwoxPEx34GLX6Tmz/PbDE6SKSg2s+mbE5SqDOADFel6rU23PFyXbVhMByFmijq1R7+f2S+bOBG9FrxP9rINpv27XALTrHuWpIi8e7WPmkiuNg7OMAE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JkT4v/39; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4479P4WJ012911;
	Tue, 7 May 2024 17:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=OLPoy15YP0uYtalQJN/5cYg0t4TZgW+mxfsdwSS7O6A=; b=Jk
	T4v/39E2RnQKDsPBfCfRmfAfw6QimqQf/gDC/SoIGkzfThc786X4e0Bzvp74hN+G
	cCdW4LM3xsRhzk2jl7Od4NoS64eizsr2PCBVq0g2sV+pLMFVUatPNPw2Szov1slb
	d8mZcAtEMxmcq3voK81TpdTBrwKBLP8S5tfNYDM8MjGCnpTksNtm00t38rD9HPC7
	3Oql1uPkp7aqN9BIsQ36RgTAHBnfHd123Qu28uQ+d+J7zSkPMjqtm86eVdE7NZLJ
	Nu5ozkjGtg+k3PU1k9pkga/JKIXgR1tFCjS2SoXKkyg11jbP8H+0CToL7pOvPc0M
	JvZKuFTNkDrtBQsZXLfA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xyf9ghqhc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 17:41:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 447HfJHG006206
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 May 2024 17:41:19 GMT
Received: from [10.50.36.33] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 7 May 2024
 10:41:18 -0700
Message-ID: <73eac931-3090-3e65-e7db-8649231e8ede@quicinc.com>
Date: Tue, 7 May 2024 23:11:14 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RFC] wifi: cfg80211: Refactor interface combination input
 parameter
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240427031503.22870-1-quic_periyasa@quicinc.com>
 <3f8e4d6d0f2facde80ad82b5b3060eb0af0958a4.camel@sipsolutions.net>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <3f8e4d6d0f2facde80ad82b5b3060eb0af0958a4.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lm6kRj52t8JTeVqMA3JddcQXi5lp42Z3
X-Proofpoint-GUID: lm6kRj52t8JTeVqMA3JddcQXi5lp42Z3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_10,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405070122



On 5/7/2024 3:17 PM, Johannes Berg wrote:
> On Sat, 2024-04-27 at 08:45 +0530, Karthikeyan Periyasamy wrote:
>> Currently, the interface combination input parameter num_different_channels
>> and iftype_num are directly filled in by the caller under the assumption
>> that all channels and interfaces belong to a single hardware device. This
>> assumption is incorrect for multi-device interface combinations because
>> each device supports a different set of channels and interfaces. As
>> discussed in [1], need to refactor the input parameters to encode enough
>> data to handle both single and multiple device interface combinations.
>> This can be achieved by encoding the frequency and interface type under
>> the interface entity itself. With this new input parameter structure, the
>> cfg80211 can classify and construct the device parameters, then verify them
>> against the device specific interface combinations.

...


> 
>> - * @num_different_channels: the number of different channels we want
>> - *	to use for verification
>>    * @radar_detect: a bitmap where each bit corresponds to a channel
>>    *	width where radar detection is needed, as in the definition of
>>    *	&struct ieee80211_iface_combination.@radar_detect_widths
>> - * @iftype_num: array with the number of interfaces of each interface
>> - *	type.  The index is the interface type as specified in &enum
>> - *	nl80211_iftype.
>>    * @new_beacon_int: set this to the beacon interval of a new interface
>>    *	that's not operating yet, if such is to be checked as part of
>>    *	the verification
>> + * @ifaces: array with the number of interface parameter use for verification
>> + * @num_iface: the length of the @ifaces interface parameter
>>    */
>>   struct iface_combination_params {
>> -	int num_different_channels;
>>   	u8 radar_detect;
>> -	int iftype_num[NUM_NL80211_IFTYPES];
>>   	u32 new_beacon_int;
>> +	const struct iface_combination_interface *ifaces;
>> +	u16 num_iface;
> 
> The "new_beacon_int" also needs to be for a specific link, witha a
> specific freq, so you can check for *that* part of the wiphy? Similarly
> for radar_detect?

Make sense, will address this comment in the next version.

> 
>> +	if (iftype != NL80211_IFTYPE_UNSPECIFIED || chandef) {
>> +		struct iface_combination_interface *iface;
>> +
>> +		iface = &ifaces[params.num_iface];
>> +		iface->iftype = iftype;
>> +
>> +		if (chandef && cfg80211_chandef_valid(chandef)) {
>> +			iface->links[0].freq = chandef->chan->center_freq;
>> +			iface->num_link++;
>>   		}
> 
> Not sure I understand this.


Previously both channel and interface creation are validated by 
independent parameter as below

        if (chandef)
                params.num_different_channels = 1;

        if (iftype != NL80211_IFTYPE_UNSPECIFIED)
                params.iftype_num[iftype] = 1;


But in the new input parameter num_different_channels is replace by link 
specific freq parameter again this is tied within interface entity.
So in either of the above scenario, we have to fill interface entity and 
the link entity is populate only for valid chandef.



> 
>> @@ -4009,14 +4029,37 @@ int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
>>   					    wdev_iter->iftype, 0, 1))
>>   			continue;
>>   
>> -		params.iftype_num[wdev_iter->iftype]++;
>> +		iface = &ifaces[params.num_iface];
>> +		iface->iftype = wdev_iter->iftype;
>> +
>> +		rcu_read_lock();
>> +		for_each_vif_active_link(&sdata_iter->vif, link_conf, link_id) {
>> +			struct ieee80211_chanctx_conf *chanctx_conf;
>> +			struct iface_combination_iface_link *link;
>> +
>> +			chanctx_conf = rcu_dereference(link_conf->chanctx_conf);
>> +			if (chanctx_conf &&
>> +			    cfg80211_chandef_valid(&chanctx_conf->def)) {
> 
> Why the valid check, btw? How could that possibly *not* be valid?
> 

Only added for the precaution before accessing "chanctx_conf->def.chan" 
pointer.

what do you think ?

>> +				link = &iface->links[iface->num_link];
>> +				link->freq = chanctx_conf->def.chan->center_freq;
>> +				iface->num_link++;
>> +			}
>> +		}
>> +		rcu_read_unlock();
> 
> when you also have this?
> 
> But maybe separating out actual logic changes in mac80211 to a separate
> patch would be good.
> 

Previously the concurrent channel populated from chanctx list as below.

         list_for_each_entry(ctx, &local->chanctx_list, list) {
                 if (ctx->replace_state == 
IEEE80211_CHANCTX_WILL_BE_REPLACED)
                         continue;
                 params.radar_detect |=
                         ieee80211_chanctx_radar_detect(local, ctx);
                if (ctx->mode == IEEE80211_CHANCTX_EXCLUSIVE) {
                        params.num_different_channels++;
                        continue;
        }

You want to have the below change of populating concurrent channel 
populate logic from the active links in a separate patch first ?

+               rcu_read_lock();
+               for_each_vif_active_link(&sdata_iter->vif, link_conf, 
link_id) {
+                       struct ieee80211_chanctx_conf *chanctx_conf;
+                       struct iface_combination_iface_link *link;
+
+                       chanctx_conf = 
rcu_dereference(link_conf->chanctx_conf);
+                       if (chanctx_conf &&
+                           cfg80211_chandef_valid(&chanctx_conf->def)) {
+                               params.num_different_channels++;
+                       }
+               }
+               rcu_read_unlock();


>>   	list_for_each_entry_rcu(sdata, &local->interfaces, list)
>> -		params.iftype_num[sdata->wdev.iftype]++;
>> +		total_iface++;
>> +
>> +	if (!total_iface)
>> +		goto skip;
>> +
>> +	ifaces = kcalloc(total_iface, sizeof(*ifaces), GFP_KERNEL);
>> +	if (!ifaces)
>> +		return -ENOMEM;
>> +
>> +	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
>> +		struct iface_combination_interface *iface;
>> +
>> +		if (params.num_iface >= total_iface)
>> +			continue;
>> +
>> +		iface = &ifaces[params.num_iface];
>> +		iface->iftype = sdata->wdev.iftype;
>> +
>> +		rcu_read_lock();
>> +		for_each_vif_active_link(&sdata->vif, link_conf, link_id) {
>> +			struct ieee80211_chanctx_conf *chanctx_conf;
>> +			struct iface_combination_iface_link *link;
>> +
>> +			chanctx_conf = rcu_dereference(link_conf->chanctx_conf);
>> +			if (chanctx_conf &&
>> +			    cfg80211_chandef_valid(&chanctx_conf->def)) {
>> +				link = &iface->links[iface->num_link];
>> +				link->freq = chanctx_conf->def.chan->center_freq;
>> +				iface->num_link++;
>> +			}
>> +		}
>> +		rcu_read_unlock();
>> +
>> +		params.num_iface++;
>> +	}
> 
> Please don't add the same code twice.

Will make a helper function and reuse in the needed area o avoid 
redundant code.

Will address this comment in the next version.


-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

