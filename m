Return-Path: <linux-wireless+bounces-9920-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8A89257E1
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 12:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20BBF1F276F9
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 10:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B862C142629;
	Wed,  3 Jul 2024 10:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A7FLrIFG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A55142E77
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 10:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001229; cv=none; b=nIAsWWaylRd5uJb7UCXfDCn6FSPbKQlvYNGirSrZedrdtP/ggCl/XnFjkpIVxIqRaVkkDQdMa5Ho8z5qBvwpKJTuzqb5FkqdR+TAf7+xkIox0/B3Phx79pulqiJ4UqWhki0ytURLdHcU5f0TzxaHowJ/kd+SLv4ILkMmEdqiQAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001229; c=relaxed/simple;
	bh=IKDrn/SWUSDUDlJDwTID7+2kMgRhDeZ5zii/36U4qAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WUV1gKjjVPpRKDwTXPxo0YHdEXRKjVH+4cb0TySort/YfViq84v8ihw0gFuTeF9fKw41U84dLBUzHQMgVcqH2WvDeubpA6OzsazHguk8cFPt9ZLG2jx2+WhRz3pReXld0mf8U+dxKC/XYSRKVGHNRaG3KfUp0+81XoQq3a9HxqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A7FLrIFG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4637g60Y030481;
	Wed, 3 Jul 2024 10:07:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	up9cGyJgIOYnFm2uIR2GehjqV3WN8z0huK0KQoRNmmQ=; b=A7FLrIFGCxBs1hSe
	TBE4rt4dvildCLPYZnBOli/BBsJJ/grIA0+1y62amejArUK2hXhf36bdu6QDDOrE
	OO5zS1/UVWlz2W+KLOWJCKh65lJj82JHZa2mUbBXPaSFrkK3aNJjJUDOTE+LsG5x
	jpMKx9AyLyqkgPcUNyZEB+e9LHw7NH+H1OleqHcaYM9WbsNjPCEy84ACYyyKK8Ll
	5yJFEPzB5MMgto59d3Xe9MdT2rV95EpUcgyRgOR4ssI23URZMbFTI41xdsVVrXlF
	0wE5rI+2LVdTULJv/q/KAquWEV01Pef5DCjQUzURK0X+VizMRvXipdJF3k4pri9m
	i2amBQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4029uxge62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 10:07:03 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 463A72SL032140
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jul 2024 10:07:02 GMT
Received: from [10.152.203.89] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 3 Jul 2024
 03:07:01 -0700
Message-ID: <42e9e131-bf25-4a49-b0d9-007a1a318861@quicinc.com>
Date: Wed, 3 Jul 2024 15:36:43 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 1/2] wifi: cfg80211/mac80211: Introduce nl80211 commands
 to support MLD link removal offload
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240404185950.776062-1-quic_mdharane@quicinc.com>
 <20240404185950.776062-2-quic_mdharane@quicinc.com>
 <84c53b0d02282c1d26a06b1c2946ed82d109bc3e.camel@sipsolutions.net>
From: Manish Dharanenthiran <quic_mdharane@quicinc.com>
In-Reply-To: <84c53b0d02282c1d26a06b1c2946ed82d109bc3e.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mvMYgwmxzSkCwbtvhlOEEyaUvGDoP4fn
X-Proofpoint-ORIG-GUID: mvMYgwmxzSkCwbtvhlOEEyaUvGDoP4fn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_06,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 mlxscore=0
 clxscore=1011 phishscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407030074



On 6/26/2024 2:58 PM, Johannes Berg wrote:
> On Fri, 2024-04-05 at 00:29 +0530, Manish Dharanenthiran wrote:
>> This is a preparation for supporting Multi-Link reconfigure link removal
>> procedure[IEEE P802.11be/D5.0 - 35.3.6.3 Removing affiliated APs] for
>> driver which supports offloaded Multi-Link reconfigure link removal.
>>
>> Multi-Link reconfigure link removal offloaded drivers will take care of
>> updating the reconfiguration MLE in self and partner beacons. It also
>> updates the AP removal timer automatically and notifies once the counter
>> is expired.
> 
> How do we distinguish those drivers from others that won't (be able to)
> do this as we had discussed also for the CSA flows?

Similar to CSA, where the beacon synchronization between partner links 
will be handled in the respective firmware, updating the reconfiguration 
element in the partner link gets handled by the firmware as well, so the 
driver needs to send only the reconfiguration element to the affected 
link. To do this, in the other discussion we were leaning on introducing 
a new feature flag like "FW_HANDLES_PARTNER_LINK_CSA" or 
"BEACON_OFFLOADED_DRIVER" which indicates that beacon synchronization 
will be handled in the respective firmware itself. To achieve that in 
this RFC, we have added a feature flag named 
[%NL80211_EXT_FEATURE_MLD_LINK_REMOVAL_OFFLOAD] in wiphy level. If its 
set, reconfiguration element will be sent to driver and only when the 
driver sends the signal back to userspace to start BTM or the actual 
link termination, hostapd will take actions. Whereas, in other drivers, 
hostapd would ideally run a decrementing timer based on the count given 
and once it reaches zero, that particular link will be terminated.

Also, probe response and assoc response gets handled in the userspace 
even in the offloaded drivers. To update the latest AP removal 
timer(TBTT) firmware will send the latest count and the tsf value of the 
beacon to driver which will eventually pass to hostapd, so the hostapd 
can take care of adding the reconfiguration element while sending the 
response.

> 
>> +/**
>> + * struct cfg80211_link_reconfig_removal_params - Contains params needed for
>> + * link reconfig removal
> 
> nit: maybe indent the second line with a tab? is that possible? it's a
> bit confusing to go into the parameters right away without any visual
> separation, IMHO.
> 
Sure, will address this. Thought aligning with the other API(s) in this 
file.

>> + * @link_removal_cntdown: TBTT countdown value until which the beacon with ML
>> + *	reconfigure element will be sent.
>> + * @reconfigure_elem: ML reconfigure element to be updated in beacon in the link going to be
>> + *	removed and in all affiliated links.
>> + * @elem_len: ML reconfigure element length
>> + * @link_id: Link id of the link to be removed.
>> + */
>> +struct cfg80211_link_reconfig_removal_params {
>> +	u16 link_removal_cntdown;
>> +	const u8 *reconfigure_elem;
>> +	size_t elem_len;
>> +	unsigned int link_id;
> 
> nit: I guess the size of this doesn't really matter, but putting a
> pointer after a u16 always feels wrong because it adds 6 bytes of
> padding on 64-bit :)
> 
size of this is to send the reconfigure_elem length. Will check, if it 
can be removed or modified accordingly without affecting much on the 
padding.

>> +/**
>> + * cfg80211_update_link_reconfig_remove_update - Inform userspace about
>> + *	the removal status of link which is scheduled for removal
> 
> here you did a tab btw :)
Will change in the above line as well :)
> 
>> + * This function is used to inform userspace about the ongoing link removal
>> + * status. 'NL80211_CMD_LINK_REMOVAL_STARTED' is issued when the first beacon with
> 
> Please use %NL80211_CMD_LINK_REMOVAL_STARTED which would print it as a
> constant, instead of '...'.
> 
>> + * ML reconfigure element is sent out. This event can be used by userspace to start
>> + * the BTM in case of AP mode. And, NL80211_CMD_LINK_REMOVAL_COMPLETED is issued
> 
> same here
> 
Sure, will address in both the places.

>> + * when the last beacon is sent with ML reconfigure element. This is used to
>> + * initiate the deletion of that link, also to trigger deauth/disassoc for the
>> + * associated peer(s).
>> + *
>> + * Note: This API is currently used by drivers which supports offloaded
>> + * Multi-Link reconfigure link removal. Returns failure if FEATURE FLAG is not
> 
> "FEATURE FLAG" was ... some kind of placeholder?
> 
> Should this even return a value? What are you going to do with it?
> 
Yes, initially thought that if we have a return driver using this will 
take necessary action with this. Kindly let me know, if you prefer a 
void API and do those validation prior calling this API.

> You should also document the context this can be called in.
> 
Yeah initially it was put as a placeholder but I should have updated 
after introducing the actual flag. Missed to do that. Will update in 
next version, also document the context.
> 
>> + * @NL80211_ATTR_TSF: (u64) TSF value when the first beacon with reconfiguration
>> + *	MLE is sent.
> 
> What's that needed for, btw?
>
This TSF will be used to calculate the BTM message. When the first 
beacon with reconfiguration element is sent out, we will receive this 
from firmware with the timestamp of the first beacon, once that is sent 
to userspace, hostapd will then calculate the BSS termination timestamp 
from this.

>> +++ b/net/wireless/nl80211.c
>> @@ -826,6 +826,8 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
>>   	[NL80211_ATTR_MLO_TTLM_DLINK] = NLA_POLICY_EXACT_LEN(sizeof(u16) * 8),
>>   	[NL80211_ATTR_MLO_TTLM_ULINK] = NLA_POLICY_EXACT_LEN(sizeof(u16) * 8),
>>   	[NL80211_ATTR_ASSOC_SPP_AMSDU] = { .type = NLA_FLAG },
>> +	[NL80211_ATTR_AP_REMOVAL_COUNT] = { .type = NLA_U8 },
> 
> No range? I guess 0 might be an issue?
0 will not be actually used, but it won't harm as well. Hence, didn't 
add any range for this.
> 
>> +	[NL80211_ATTR_TSF] = { .type = NLA_U64 },
> 
> If the TSF is output only maybe it should not have a policy for input?

> 
>> @@ -16103,6 +16105,7 @@ static int nl80211_remove_link(struct sk_buff *skb, struct genl_info *info)
>>   	unsigned int link_id = nl80211_link_id(info->attrs);
>>   	struct net_device *dev = info->user_ptr[1];
>>   	struct wireless_dev *wdev = dev->ieee80211_ptr;
>> +	struct cfg80211_link_reconfig_removal_params params = {};
> 
> that can move into the if
Sure. will address in next version.
> 
>> @@ -16115,6 +16118,30 @@ static int nl80211_remove_link(struct sk_buff *skb, struct genl_info *info)
>>   		return -EINVAL;
>>   	}
>>   
>> +	if (info->attrs[NL80211_ATTR_AP_REMOVAL_COUNT]) {
>> +		/* Parsing and sending information to driver about ML
>> +		 * reconfiguration is supported only when
>> +		 * NL80211_EXT_FEATURE_MLD_LINK_REMOVAL_OFFLOAD is set
>> +		 */
>> +		if (!wiphy_ext_feature_isset(wdev->wiphy,
>> +					     NL80211_EXT_FEATURE_MLD_LINK_REMOVAL_OFFLOAD))
>> +			return -EOPNOTSUPP;
>> +
>> +		/* If AP removal count is present, it is mandatory to have IE
>> +		 * attribute as well, return error if not present
>> +		 */
>> +		if (!info->attrs[NL80211_ATTR_IE])
>> +			return -EINVAL;
>> +
>> +		params.reconfigure_elem = nla_data(info->attrs[NL80211_ATTR_IE]);
>> +		params.elem_len = nla_len(info->attrs[NL80211_ATTR_IE]);
>> +		params.link_removal_cntdown =
>> +			nla_get_u16(info->attrs[NL80211_ATTR_AP_REMOVAL_COUNT]);
> 
> doesn't match the policy ... but policy also doesn't match
> documentation, so I think policy is wrong?
> 
oh sorry! Should have updated the policy accordingly. Missed while 
updating the patch. Will address this in next version.
>> +int
>> +cfg80211_update_link_reconfig_remove_update(struct net_device *netdev,
>> +					    unsigned int link_id,
>> +					    u8 tbtt_count, u64 tsf,
>> +					    enum nl80211_commands cmd)
>> +{
> 
> [...]
> 
>> + nla_put_failure:
>> +	genlmsg_cancel(msg, hdr);
>> +	nlmsg_free(msg);
> 
> nit: no need to cancel before free
> 
Sure, will address.

>> +TRACE_EVENT(rdev_link_reconfig_remove,
>> +	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
>> +		 const struct cfg80211_link_reconfig_removal_params *params),
>> +
>> +	TP_ARGS(wiphy, netdev, params),
>> +
>> +	TP_STRUCT__entry(
>> +		WIPHY_ENTRY
>> +		NETDEV_ENTRY
>> +		__field(u32, link_id)
>> +		__field(u16, count)
>> +		__dynamic_array(u8, frame, params->elem_len)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		WIPHY_ASSIGN;
>> +		NETDEV_ASSIGN;
>> +		__entry->link_id = params->link_id;
>> +		__entry->count = params->link_removal_cntdown;
>> +		memcpy(__get_dynamic_array(frame), params->reconfigure_elem,
>> +		       params->elem_len);
>> +	),
>> +
>> +	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", link_id: %u frame:0x%.2x count:%d",
>> +		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->link_id,
>> +		  le16_to_cpup((__le16 *)__get_dynamic_array(frame)), __entry->count)
> 
> What's that frame argument?! Need to check it's long enough? But ... is
> that worth it at all to try to print it here in this way? Maybe with
> %*pH but then you don't get all of it either? Or just leave it, and
> write a small plugin if needed?
> 
I didn't had much insight while writing the trace API. But, once i gone 
through the code, the dynamic array was used in places where there is a 
need to print IE(s) and few other similar things.

>> +int cfg80211_link_reconfig_remove(struct wireless_dev *wdev,
>> +				  const struct cfg80211_link_reconfig_removal_params *params)
>> +{
>> +	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
>> +
>> +	lockdep_assert_wiphy(wdev->wiphy);
>> +
>> +	/* Currently, removal of link from MLD is supported for AP BSS only, it
>> +	 * can be extended for non-AP/STA MLD as well but that shall use
>> +	 * action frame to update about its link reconfiguration.
>> +	 */
>> +	if (wdev->iftype == NL80211_IFTYPE_AP)
>> +		return rdev_link_reconfig_remove(rdev, wdev->netdev, params);
>> +
>> +	return -EINVAL;
> 
> 
> Would kind of feel to better be
> 
>   if (iftype != ...) return -EINVAL;
> 
>   ... normal flow
> 
Sure, will correct this.
> johannes

Thanks Johannes for the review, will address the comments and update the 
next version.

Regards
Manish Dharanenthiran.

