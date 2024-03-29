Return-Path: <linux-wireless+bounces-5592-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D58EF89227B
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 18:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7343B285104
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 17:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736A14A0A;
	Fri, 29 Mar 2024 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y/ozNOxn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D05364D8
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 17:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711732434; cv=none; b=elV1qeLiru/hVoydv8V04kGtaDzzr4USGuUxDvFdSPW3tZwoeKzB0C7p4Y/DoZC1f74lGirACcn+HA9i8lnQXtdnMUM2GlLgcL4D1HtL/v6ZFm2LkzfK8uf2wq+H3Twr8twQ72vAeP8j5hl3A15YpOGQmeqwoEmwv11Ee9RJHnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711732434; c=relaxed/simple;
	bh=PZl1wI8Xk5t9LFkN+BiXjbl0I8OepkcGtipXul3PDP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ndOFFdZ9m/oIcU4K7+ydafChV3UaKBiY82S5JmBscAaK8HG6bnCYtyLckCld8L/pJ9sO9naeisp1rd8Z/yougH1EaPuvswu+XqaOl6wA3jgplnU97adSfDiqIMsaxOEnrHk9IwbF/FXLp7nATLZUUVHSabcnKpzgFxlu3fWYSIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Y/ozNOxn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TGO7hr000565;
	Fri, 29 Mar 2024 17:13:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=mn27zUUvmp0dqeA6goLLsroxqQjSpJRUSiBfcpUAMn4=; b=Y/
	ozNOxn53kx1e3pRuwGUTxZ5XiZobVhpLtEdkX0HUCCx7TmPK1DF7kyXFCb/T5sp9
	uI4qE3UAAfoq09GZ+IvPXtQMGBzrH+cf24maMjd+6jAbpqOth5M1e0doeflKsWrF
	VYk0LvL89CyJ5PSjPgGXgFwpLu7mFp25T5HqC4emMJnhrX5E8GVbTtdwF75ZrwJl
	TGOGS3QrwL8QCmHH37qNXHncBdazHvckF6XNhZfwrcj4rFhQtsiL6VpDWd0CjeL8
	vpYaveDcTpZqfiz3rrquVvxRK4x1rMlvNuBqkw47X4+T/d/pOAD1cU3eFOZ7M4Sq
	7OyAqdnv6+xi1g4wAdXw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5vn98s4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 17:13:47 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42THDk9r005890
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 17:13:46 GMT
Received: from [10.50.15.209] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 29 Mar
 2024 10:13:45 -0700
Message-ID: <70d9c885-d528-4892-8cc8-3450dfca6ac4@quicinc.com>
Date: Fri, 29 Mar 2024 22:43:41 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] wifi: cfg80211/mac80211: Introduce nl80211 commands to
 support MLD link removal offload
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>
References: <20240328055235.3034174-1-quic_mdharane@quicinc.com>
 <20240328055235.3034174-2-quic_mdharane@quicinc.com>
 <5d723170644d147bebe8a1232fb7a20c3c6d41c7.camel@sipsolutions.net>
From: Manish Dharanenthiran <quic_mdharane@quicinc.com>
In-Reply-To: <5d723170644d147bebe8a1232fb7a20c3c6d41c7.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: b7ai0VC_f44nzUtJhk35AMr-qZugzSIK
X-Proofpoint-GUID: b7ai0VC_f44nzUtJhk35AMr-qZugzSIK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxscore=0 clxscore=1015 adultscore=0 priorityscore=1501 mlxlogscore=999
 phishscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403290152



On 3/28/2024 11:48 PM, Johannes Berg wrote:
> On Thu, 2024-03-28 at 11:22 +0530, Manish Dharanenthiran wrote:
>>
>> + * @ie: ML reconfigure IE to be updated in beacon in the link going to be
>> + *	removed and in all affiliated links.
>> + * @ie_len: ML reconfigure IE length
> 
> Given the spec having moved away from "Information Element" in favour of
> just "Element", I'd prefer to do the same in the code. Not that we
> really want to rename all the "ie" stuff in the code now, but for new
> code.
> 
>> + * @link_reconfig_remove: Notifies the driver about the link to be
>> + *	scheduled for removal with ML reconfigure IE built for that particular
>> + *	link along with the TBTT count until which the beacon with ML
>> + *	reconfigure IE should be sent.
> 
> Same here.
> 
Sure, will address in all the places
>> +/**
>> + * cfg80211_update_link_reconfig_remove_status - Inform userspace about
>> + *	the removal status of link which is scheduled for removal
>> + * @dev: the device on which the operation is requested
>> + * @link_id: Link which is undergoing removal
>> + * @tbtt_count: Current tbtt_count to be updated.
>> + * @tsf: Beacon's timestamp value
>> + * @status: Inform started or completed action to userspace based on the value
>> + *	received,
>> + *	i) 0 (IEEE80211_LINK_RECONFIG_START) - Send
>> + *		NL80211_CMD_LINK_REMOVAL_STARTED
>> + *	ii) 1 (IEEE80211_LINK_RECONFIG_COMPLETE) - Send
>> + *		NL80211_CMD_LINK_REMOVAL_COMPLETED
> 
> I wouldn't list the values "0" and "1"? They're really quite
> unimportant.
> 
> Also we've sometimes used just the nl80211 cmd value as a parameter,
> could do that here too instead of adding IEEE80211_LINK_RECONFIG_START
> and IEEE80211_LINK_RECONFIG_COMPLETE?
> 
I thought to add these in the description so that the action taken in 
these API is more clear, but it worked in other way. Will address this 
in next version.

>> + * This function is used to inform userspace about the ongoing link removal
>> + * status. 'IEEE80211_LINK_RECONFIG_START' is issued when the first beacon with
>> + * ML reconfigure IE is sent out. This event can be used by userspace to start
>> + * the BTM in case of AP mode. And, IEEE80211_LINK_RECONFIG_COMPLETE is issued
>> + * when the last beacon is sent with ML reconfigure IE. This is used to
>> + * initiate the deletion of that link, also to trigger deauth/disassoc for the
>> + * associated peer(s).
> 
> I'm not fully sure I understand this - the way I read it, userspace
> actually request link removal with NL80211_CMD_REMOVE_LINK (at least
> right now, will comment separately), why does it need an event too?
> 

>> + * Note: This API is currently used by drivers which supports offloaded
>> + * Multi-Link reconfigure link removal. Returns failure if FEATURE FLAG is not
>> + * set or success if NL message is sent.
> 
> What would be "non-offloaded ML reconfiguration link removal"? What does
> offloaded even mean here? It's only counting down and then removing the
> link, no? Isn't that fundamentally an operation that has to happen in
> kernel or device space, since that's sending beacons? I don't see you'd
> really want to time the updates to each beacon from userspace?
> 
By offloaded, we tried to convey that the synchronization of the 
reconfiguration IE(TBTT count) between partner links is taken care by 
the firmware instead of hostap/kernel.

Yeah as you mentioned it is actually counting down and then removing but 
the thing here is, since the synchronization is done on the firmware 
side, this event is used to send the timestamp value of the first beacon 
sent with reconfiguration element and as well as the current the TBTT 
count. This timestamp of the first beacon is needed to start the BTM 
request/disassoc timer along with the value received from the driver.


>> +++ b/include/uapi/linux/nl80211.h
>> @@ -1304,6 +1304,10 @@
>>    * @NL80211_CMD_REMOVE_LINK: Remove a link from an interface. This may come
>>    *	without %NL80211_ATTR_MLO_LINK_ID as an easy way to remove all links
>>    *	in preparation for e.g. roaming to a regular (non-MLO) AP.
>> + *	To initiate link removal procedure, set below attributes,
>> + *	%NL80211_ATTR_AP_REMOVAL_COUNT - AP removal timer count(TBTT)
>> + *	%NL80211_ATTR_IE - ML reconfigure Information element
>> + *	Can be extended to update multiple TBTT & IE(s).
> 
> I'm wondering if this really is the right API? For example, older
> kernels would ignore all the other attributes and immediately delete the
> link, is that what you want? Seems you might want to at least _know_
> about the availability of (graceful) link removal.
> 
> Also, if it should piggy-back on an existing API, maybe better would be
> STOP_AP? That's the operation that normally stops beaconing, although if
> you just delete the link the kernel does have to clean that up ...
> 
> Or maybe it should just be a whole new operation? You're already adding
> new commands for the events anyway, could use _START (dropping the "ED")
> for both a command and an event. Though see above, not sure why you need
> the event anyway.
> 
> So just not sure about this, any arguments either way? I guess if it
> were part of STOP_AP you'd expect the link to stay around and just be
> inactive, and then require it to be removed by userspace with
> NL80211_CMD_REMOVE_LINK after it stops, so perhaps in some way doing it
> via NL80211_CMD_REMOVE_LINK makes more sense so it will actually be
> removed entirely.
With the new reconfiguration procedure, we are not stopping the beacon 
or putting the BSS to inactive or such, we still continue to operate and 
serve the peers connected to the AP MLD, rather we are trying to 
intimate that this link is going to removed 'after this' many count just 
like CSA. Station associated to this might take action based on its 
capabilities or just ignore this element. That's the reason we went with 
piggy-backing the existing remove link API but instead of removing 
immediately we just by-passing when TBTT & IE attributes are present.
> 
>>    * @NL80211_CMD_ADD_LINK_STA: Add a link to an MLD station
>>    * @NL80211_CMD_MODIFY_LINK_STA: Modify a link of an MLD station
>> @@ -1329,6 +1333,14 @@
>>    *      %NL80211_ATTR_MLO_TTLM_ULINK attributes are used to specify the
>>    *      TID to Link mapping for downlink/uplink traffic.
>>    *
>> + * @NL80211_CMD_LINK_REMOVAL_STARTED: Once first beacon with reconfiguration MLE
>> + *	is sent, userspace is notified with the TBTT and TSF value to indicate
>> + *	timestamp of that beacon using %NL80211_ATTR_AP_REMOVAL_COUNT and
>> + *	%NL80211_ATTR_TSF respectively.
>> + *
>> + * @NL80211_CMD_LINK_REMOVAL_COMPLETED: Once last beacon with reconfiguration
>> + *	MLE is sent, userspace is notified with completion.
> 
> We already have NL80211_CMD_LINKS_REMOVED for the station side of this,
> maybe we should just reuse that event also here?
> 
This has other functionality as well similar to "cfg80211_remove_link", 
can I add case similar to how I extended the "NL80211_CMD_REMOVE_LINK" 
handler?
>> + * @NL80211_ATTR_AP_REMOVAL_COUNT: (u16) TBTT count up-to which reconfiguration
>> + *	MLE is sent. Also, userspace will be notified with this count once the
>> + *	first beacon with reconfiguration MLE is sent.
> 
> I'm not sure how that notification thing all makes sense when it's
> something requested by userspace in the first place? Are you expecting
> the underlying driver to actually _change_ it?
> 
>> + * @NL80211_ATTR_TSF: (u64) TSF value when the first beacon with reconfiguration
>> + *	MLE is sent.
> 
> Why is that needed? But also the name is very generic, which I don't
> mind, but perhaps then the documentation should reflect that this use is
> when it's used with that event etc.
> 
Sure, will update the documentation.
>> + * @NL80211_EXT_FEATURE_MLD_LINK_REMOVAL_OFFLOAD: Driver/device which supports
>> + *	ML reconfig link removal offload.
> 
> Ah, I guess that addresses the whole "can the driver do it" part.
> 
> Though like I said above I'm not sure why you call this offloaded, I'm
> not convinced you'd ever want to do it in a non-offloaded way?
> 
>> +	[NL80211_ATTR_TSF] = { .type = NLA_U64 },
> 
> Not sure that makes sense, it's not used for input?
> 
We are using this attribute to notify the timestamp to userspace, so 
thought adding a policy would be good.

>>   	struct wireless_dev *wdev = dev->ieee80211_ptr;
>> +	struct cfg80211_link_reconfig_removal_params params = {};
>> +	bool is_ml_reconfig = false;
>> +	int ret = 0;
> 
> You can remove ret, just rewrite the code below a bit better.
> 
>> +int
>> +cfg80211_update_link_reconfig_remove_status(struct net_device *netdev,
>> +					    unsigned int link_id,
> 
> I feel like this should check the link_id against valid_links?
> 
>> +					    u8 tbtt_count, u64 tsf,
>> +					    enum ieee80211_link_reconfig_remove_state action)
>> +{
>> +	struct wiphy *wiphy = netdev->ieee80211_ptr->wiphy;
>> +	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
>> +	struct sk_buff *msg;
>> +	void *hdr = NULL;
>> +	int ret = 0;
> 
> Please read
> https://staticthinking.wordpress.com/2024/02/28/return-0-is-better-than-return-ret/
> 
> I really do agree with him a lot here :-)
> 
> So please don't init ret = 0, and "return 0" on the success path.
>
Thanks for sharing this! Will address all the return variable 
discrepancy here and in other places as well.

>> +	/* Only for ML reconfigure link removal offloaded driver, need to
>> +	 * update the status about the ongoing link removal to userspace.
>> +	 */
>> +	if (!wiphy_ext_feature_isset(wiphy,
>> +				     NL80211_EXT_FEATURE_MLD_LINK_REMOVAL_OFFLOAD))
>> +		return -EOPNOTSUPP;
>> +
>> +	trace_cfg80211_update_link_reconfig_remove_status(wiphy, netdev,
>> +							  link_id, tbtt_count,
>> +							  tsf, action);
>> +
>> +	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_ATOMIC);
>> +	if (!msg)
>> +		return -ENOMEM;
>> +
>> +	if (action == IEEE80211_LINK_RECONFIG_START)
>> +		hdr = nl80211hdr_put(msg, 0, 0, 0, NL80211_CMD_LINK_REMOVAL_STARTED);
>> +	else if (action == IEEE80211_LINK_RECONFIG_COMPLETE)
>> +		hdr = nl80211hdr_put(msg, 0, 0, 0, NL80211_CMD_LINK_REMOVAL_COMPLETED);
> 
> You can save this if you actually just have the driver pass the command
> ID. However, seems like the function should update valid_links, just
> like cfg80211_links_removed() does? Or maybe it should just become valid
> to call cfg80211_links_removed() for AP interfaces in this context ...
> 
we are not yet deleting the link as such though we say completed. 
Complete here meant only for what the userspace has initiated. Its up to 
the userspace to decide on what would be the next step. Like, it may 
send broadcast BM, flush out all the peers connected and then remove the 
link completely. Hence, didn't do any changes on the valid_links part.
> 
>> +	    nla_put_u8(msg, NL80211_ATTR_AP_REMOVAL_COUNT, tbtt_count) ||
>> +	    nla_put_u64_64bit(msg, NL80211_ATTR_TSF, tsf,
>> +			      NL80211_ATTR_PAD)) {
> 
> Those don't make sense after removal completed, so they shouldn't be
> there. But again, perhaps that's just going to become
> cfg80211_links_removed() anyway.
> 
>> + nla_put_failure:
>> +	genlmsg_cancel(msg, hdr);
> 
> The cancel is pointless if you just free the message, and then you don't
> need to initialize hdr=NULL either.
> 
Since i had hdr allocation inside if else if block and then have check 
for NULL pointer, it made sense to initialize to NULL. But with changes 
to send the command id, I will update this code in the next version.

>> +	nlmsg_free(msg);
>>
>> +TRACE_EVENT(rdev_link_reconfig_remove,
>> +	    TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
>> +		     const struct cfg80211_link_reconfig_removal_params *params),
>> +
>> +	TP_ARGS(wiphy, netdev, params),
> 
> That's pretty inconsistent indentation, I'd prefer to do it like the
> other events, even if checkpatch complains a bit ...
> 
checkpatch had complained this and I though the expectation here is to 
have similar indentation as well. Will update the trace.h in this and in 
the next 2/2 patch as well.

>> +	TP_STRUCT__entry(WIPHY_ENTRY
>> +			 NETDEV_ENTRY
>> +			 __field(u32, link_id)
>> +			 __field(u16, count)
>> +			 __dynamic_array(u8, frame, params->ie_len)
>> +	),
>> +
>> +	TP_fast_assign(WIPHY_ASSIGN;
>> +		       NETDEV_ASSIGN;
>> +		       __entry->link_id = params->link_id;
>> +		       __entry->count = params->link_removal_cntdown;
>> +		       memcpy(__get_dynamic_array(frame), params->ie,
>> +			      params->ie_len);
>> +	),
> 
> Same here, this might make checkpatch happier, but honestly, I much
> prefer the style that all the other events have ...
> 
>> +int cfg80211_link_reconfig_remove(struct wireless_dev *wdev,
>> +				  const struct cfg80211_link_reconfig_removal_params *params)
>> +{
>> +	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
>> +	int ret = -EINVAL;
>> +
>> +	lockdep_assert_wiphy(wdev->wiphy);
>> +
>> +	/* Currently, removal of link from MLD is supported for AP BSS only, it
>> +	 * can be extended for non-AP/STA MLD as well but that shall use
>> +	 * action frame to update about its link reconfiguration.
>> +	 */
>> +	if (wdev->iftype == NL80211_IFTYPE_AP)
>> +		ret = rdev_link_reconfig_remove(rdev, wdev->netdev, params);
>> +
>> +	return ret;
> 
> Oh come on, you don't even need the 'ret' variable.
> 
> johannes
Sure :) will address all the ret variable at once in the next version.

