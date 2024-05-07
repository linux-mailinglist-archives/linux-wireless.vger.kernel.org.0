Return-Path: <linux-wireless+bounces-7296-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A348BEA86
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 19:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3F3428503E
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 17:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B52415F40C;
	Tue,  7 May 2024 17:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="b65Rx6Rf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CA510E6
	for <linux-wireless@vger.kernel.org>; Tue,  7 May 2024 17:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715102774; cv=none; b=VTKsOQ5xASb3E3G03Bxa/sCWu8o6ttxqM6NOM//PITxeroi9HDc7RS05pWK5mikG9ag+C4fozTlIjndLoBX6KfEcHfxXzPReTv0BVLYNgPNEth6/Fz5vbxKNqbKJan0zHicyU+v5a4sAaFtU3F9bi4ORT+FUg5V9jFZGFytQubY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715102774; c=relaxed/simple;
	bh=qzn19EfhwkqCAaf4N+r3etPjFzEa86J/goUtzGl+m5Y=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:To:CC:
	 In-Reply-To:Content-Type; b=t/EsH4HbFXi2yfXniazGUjFcmgMb2GRvHs2+oqHDk8wy3YGrtRpE6wAbQxk5oZg27XfTVdvGM1MkWQuUX2IF519IYwNrJ3zkQnDZoJaHx/Bo/OfOTdNiEGeCUGYd28NV6Jv9dXeOtN+ThrsLEbcfhzNbvMZDTv1Yoqw9dstowXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=b65Rx6Rf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 447Fuj9m026465;
	Tue, 7 May 2024 17:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:references:from:to:cc
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=WMZcKaJ4TXcrpgjByjaEuDrj9Sgaym0AFTXxwoze/ng=; b=b6
	5Rx6Rfmmc2bMfaAk+YA+ku3R939LgDhnRpohplqD93a8ZWYsqOYlsO1NRPSRf72C
	sCbz+g953PSDA2wtv9hKGmZvEL64pFnJhIBltzgL3ooldiwWSVxCS9XjU2XLLrbG
	HnPFanR93xBwCBlx+cvt2bG59Fp0y3udNyQ+229IQAM2llC2xs1IYPzwd0ANu19i
	t9PnLtJJpCFEsH1KX0klmIO6qM8UEUozAAs6bv5iVAjWosIRabMmWHBfGsPPLruB
	ZZUBB27S3LjuUWbyvVY/D60M8ZBygjsikGy1ueJzeSIA2gxaKJpZgHluBxHgSua8
	EJ3rKvY4a1Iy3FYyWD/g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xyf9ghpgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 17:26:07 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 447HQ653020548
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 May 2024 17:26:06 GMT
Received: from [10.216.56.31] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 7 May 2024
 10:26:04 -0700
Message-ID: <45e98a80-9a32-fe1a-2780-ae704b95082a@quicinc.com>
Date: Tue, 7 May 2024 22:55:50 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC v2 1/2] wifi: nl80211: Add attribute to send critical update
 parameters
References: <20240403162225.3096228-1-quic_rrchinan@quicinc.com>
 <20240403162225.3096228-2-quic_rrchinan@quicinc.com>
 <292247f4b838356b0c4e3ded2ff9fdbabd682040.camel@sipsolutions.net>
Content-Language: en-US
From: Rathees Kumar R Chinannan <quic_rrchinan@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
In-Reply-To: <292247f4b838356b0c4e3ded2ff9fdbabd682040.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hcr9V-p_IhOS2N5lQHkyL5sMJtjsYEAb
X-Proofpoint-GUID: hcr9V-p_IhOS2N5lQHkyL5sMJtjsYEAb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_10,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405070120



On 5/3/2024 2:42 PM, Johannes Berg wrote:
> On Wed, 2024-04-03 at 21:52 +0530, Rathees Kumar R Chinannan wrote:
>> Add NL80211_ATTR_RXMGMT_CRITICAL_UPDATE attribute to send critical
>> update parameters to hostapd on NL80211_CMD_FRAME.
>>
>> User space application requires these CU params to update fields on probe
>> and assoc response frame. So, during probe or assoc request frame receive,
>> send these params as a new attribute on existing NL80211_CMD_FRAME for
>> AP MLD.
>>
>> Change in CU parameters should be sent to user space either before or
>> along with probe or assoc request frame receive to ensure that user space
>> uses latest CU values and BPCC while generating response to the received
>> frames. So, add the critical update parameters as a new attribute to
>> existing NL80211_CMD_FRAME command instead of sending this on a separate
>> NL80211 event.
>>
>> Based on the suggestion received on below link, add extended feature
>> NL80211_EXT_FEATURE_CRITICAL_UPDATE_OFFLOAD flag if driver handles
>> synchronization among all the links and update critical information on
>> partner link beacon for AP MLD and user space can update critical
>> information only on impacted link beacon template. Add this critical
>> update attribute on NL80211_CMD_FRAME only when this flag is set
>> by driver.
>>
>> Link: https://lore.kernel.org/all/df711a5978b84856a54953a32e4b05923b48870a.camel@sipsolutions.net/
> 
> I'm not sure we're interpreting this the same way ;-)
> 
> At least now that I'm reading it again, I was thinking in that thread
> about how beacons on partner links are updated. That whole thread was
> about handling that?
>
yes, it is about beacon update on partner links.

>> Suggested-by: Johannes Berg <johannes@sipsolutions.net>
>> Signed-off-by: Rathees Kumar R Chinannan <quic_rrchinan@quicinc.com>
>> ---
>>   include/net/cfg80211.h       |  10 +++
>>   include/uapi/linux/nl80211.h | 104 +++++++++++++++++++++++++++++
>>   net/wireless/nl80211.c       | 123 ++++++++++++++++++++++++++++++++++-
>>   3 files changed, 236 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
>> index 2e2be4fd2bb6..496a9d4956de 100644
>> --- a/include/net/cfg80211.h
>> +++ b/include/net/cfg80211.h
>> @@ -6142,7 +6142,11 @@ void wiphy_delayed_work_flush(struct wiphy *wiphy,
>>    *	unprotected beacon report
>>    * @links: array of %IEEE80211_MLD_MAX_NUM_LINKS elements containing @addr
>>    *	@ap and @client for each link
>> + * @links.ap.bpcc: Bss param change count value for each link
> 
> BSS
> 
Sure, will correct this.

>> + * @links.ap.switch_count: CSA/BCCA count for each link
> 
> Had to think about BCCA a bit too much ... maybe explain it? :)
> 
> Also can someone actually be trying to do channel switch and color
> change at the same time?
>
Currently kernel doesn't allow another color change if one is already 
active or if CSA is active. Similarly, during channel switch if there is 
a color change in progress, it will get aborted.

>> + * @links.ap.critical_flag: Critical update flag for each link
>>    * @valid_links: bitmap describing what elements of @links are valid
>> + * @critical_update: critical params updated on any wdev link
> 
> Why have two critical indications? And they're even named differently?
> I'd probably rename the inner to 'critical_update' and remove the outer,
> it's easy to loop over (valid) links?
> 
Sure, will remove the second one and iterate valid links for the same.

>>   static inline const u8 *wdev_address(struct wireless_dev *wdev)
>> @@ -8340,6 +8348,7 @@ void cfg80211_conn_failed(struct net_device *dev, const u8 *mac_addr,
>>    * @flags: flags, as defined in &enum nl80211_rxmgmt_flags
>>    * @rx_tstamp: Hardware timestamp of frame RX in nanoseconds
>>    * @ack_tstamp: Hardware timestamp of ack TX in nanoseconds
>> + * @critical_update: critical params updated for the received frame
>>    */
>>   struct cfg80211_rx_info {
>>   	int freq;
>> @@ -8351,6 +8360,7 @@ struct cfg80211_rx_info {
>>   	u32 flags;
>>   	u64 rx_tstamp;
>>   	u64 ack_tstamp;
>> +	bool critical_update;
> 
> Not sure what this means?
> 
This flag will be set on mac80211 when critical parameters are received 
on driver along with probe/assoc request frame receive.
>> + * @NL80211_ATTR_RXMGMT_CRITICAL_UPDATE: This is a nested attribute for driver
>> + *	supporting critical update feature for AP MLD. When used with
>> + *	%NL80211_CMD_FRAME it contains attribute defined in &enum nl80211_cu_attrs
>> + *	to send critical update params for list of MLDs. Driver adds this attribute
>> + *	only for probe, assoc and reassoc request frame. User-space can use these
>> + *	params to update CU fields on corresponding response frame. This attribute
>> + *	is needed only on beacon offload case and it is not needed on beacon
>> + *	non-offload case since user space itself has these data.
> 
> The wording of "beacon offload" vs. "beacon non-offload" seems, at best,
> imprecise? This should be about offloading partner link updates, or
> something like that?
> 
Sure, will update this.

> Also I find this API a bit confusing, why is this sent in an RX frame
> notification, which is stateless today, but you only send it once on the
> first RX notification after it was set. Is that some kind of
> optimisation?
>
Yes, it is sent not only on first RX notification, it is sent later as 
well if there is a change in the value received from driver when 
compared to previous values.

> I'd think it would make more sense to send a separate notification of
> the data, and then you don't even need to store the data in the wdev.
> 
> Maybe then if we find out that it updates too frequently, we can defer
> that separate notification (e.g. create the SKB for it, store a pointer
> to that, and send it only on the first frame RX).
> 
CU parameters should be sent to user space either before or
along with probe or assoc request frame receive to ensure that user 
space uses latest CU values and BPCC while generating response to the 
received frames.
Do you recommend to send it as separate NL80211 command before handling 
these management frame RX ? Please suggest.

>> @@ -3401,6 +3410,7 @@ enum nl80211_attrs {
>>   
>>   	NL80211_ATTR_ASSOC_SPP_AMSDU,
>>   
>> +	NL80211_ATTR_RXMGMT_CRITICAL_UPDATE,
>>   	/* add attributes here, update the policy in nl80211.c */
> 
> nit: blank line
>
Sure, will correct this.

>> + * @NL80211_EXT_FEATURE_CRITICAL_UPDATE_OFFLOAD: User space sets critical
>> + *	information only on impacted link through @NL80211_CMD_SET_BEACON.
>> + *	Driver/Device handles synchronization among all the links and update
>> + *	critical information on partner link beacon in case of MLD.
> 
> That's not really _quite_ what this implies today.
> 
> I mean, yeah, that's the idea, but you're actually using it for
> something else. I don't even mind, but maybe it'd make sense to put this
> into a separate patch, that starts building out the infrastructure for
> handling all of this, simply with this for starters to say "not needed
> in this case"?
> 
> (I think maybe I'm missing the broader picture a bit in these patches)
> 
ok, will raise a separate patch for this feature flag.
And patch to add critical update information on impacted link during set 
beacon template is still under review.

>> +/*
>> + * Critical update attribute length for a MLD list with two nested
>> + * attributes. Each nla_nest_start() reserves four bytes.
>> + */
>> +#define NL80211_CU_ATTR_MLDS_LEN	8
> ...
>> +#define NL80211_CU_ATTR_MLD_LEN		16
> ...
>> +#define NL80211_CU_ATTR_LINK_LEN	32
> 
> Please don't do that, use nla_attr_size() or something?
> 
> But maybe anyway we can find a better representation.
> 
Sure, will check this.

>> +/**
>> + * nl80211_cu_attrs - critical update attributes
>> + *
>> + *
> 
> nit: double blank line
> 
Ok

>> + * @__NL80211_CU_ATTR_INVALID: invalid
>> + * @NL80211_CU_ATTR_MLDS: nested attribute specifying list of MLDs,
>> + * see &enum nl80211_cu_mld_attrs
>> + * @__NL80211_CU_ATTR_LAST: internal use
>> + * @NL80211_CU_ATTR_MAX: maximum critical update attribute
>> + */
>> +enum nl80211_cu_attrs {
>> +	__NL80211_CU_ATTR_INVALID,
>> +
>> +	NL80211_CU_ATTR_MLDS,
>> +
>> +	/* keep last */
>> +	__NL80211_CU_ATTR_LAST,
>> +	NL80211_CU_ATTR_MAX = __NL80211_CU_ATTR_LAST - 1
>> +};
> 
> But I'm not sure why you need this level anyway?
> 
> Why would you need to represent multiple MLDs for a single interface?
> You've tagged it to RX (see above for comments on that) but that's per
> interface anyway, so certainly per MLD?
>
If multiple vaps are created on a radio, then on MBSSID IE for each Non 
TX BSSID profile, we have to update CU bits & BPCC on Multi link 
element. These non-TX vaps can be part of different MLDs, so we need to 
pass the critical information for all MLDs instead of single MLD.

>> +++ b/net/wireless/nl80211.c
>> @@ -468,6 +468,25 @@ static const struct netlink_range_validation nl80211_punct_bitmap_range = {
>>   	.max = 0xffff,
>>   };
>>   
>> +static const struct nla_policy
>> +link_policy[NL80211_CU_MLD_LINK_ATTR_MAX + 1] = {
>> +	[NL80211_CU_MLD_LINK_ATTR_ID] = { .type = NLA_U8 },
>> +	[NL80211_CU_MLD_LINK_ATTR_CRITICAL_FLAG] = { .type = NLA_FLAG },
>> +	[NL80211_CU_MLD_LINK_ATTR_BPCC] = { .type = NLA_U8 },
>> +	[NL80211_CU_MLD_LINK_ATTR_SWITCH_COUNT] = { .type = NLA_U8 },
>> +};
>> +
>> +static const struct nla_policy
>> +mld_policy[NL80211_CU_MLD_ATTR_MAX + 1] = {
>> +	[NL80211_CU_MLD_ATTR_IFINDEX] = { .type = NLA_U32 },
>> +	[NL80211_CU_MLD_ATTR_LINKS] = NLA_POLICY_NESTED(link_policy),
>> +};
>> +
>> +static const struct nla_policy
>> +cu_policy[NL80211_CU_ATTR_MAX + 1] = {
>> +	[NL80211_CU_ATTR_MLDS] = NLA_POLICY_NESTED(mld_policy),
>> +};
>> +
>>   static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
>>   	[0] = { .strict_start_type = NL80211_ATTR_HE_OBSS_PD },
>>   	[NL80211_ATTR_WIPHY] = { .type = NLA_U32 },
>> @@ -826,6 +845,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
>>   	[NL80211_ATTR_MLO_TTLM_DLINK] = NLA_POLICY_EXACT_LEN(sizeof(u16) * 8),
>>   	[NL80211_ATTR_MLO_TTLM_ULINK] = NLA_POLICY_EXACT_LEN(sizeof(u16) * 8),
>>   	[NL80211_ATTR_ASSOC_SPP_AMSDU] = { .type = NLA_FLAG },
>> +	[NL80211_ATTR_RXMGMT_CRITICAL_UPDATE] = NLA_POLICY_NESTED(cu_policy),
> 
> All of these are outgoing though, so probably shouldn't even have a
> policy (which implies NLA_REJECT, i.e. not used incoming)?
> 
Sure, will remove this change.

>> -	msg = nlmsg_new(100 + info->len, gfp);
>> +	if (wiphy_ext_feature_isset(
>> +		    wdev->wiphy,
>> +		    NL80211_EXT_FEATURE_CRITICAL_UPDATE_OFFLOAD) &&
>> +	    info->critical_update)
> 
> I don't even see how the flag check is needed here, since it relies on
> the driver setting info->critical_update?
> 
> johannes

Sure, will remove this flag check.

