Return-Path: <linux-wireless+bounces-15232-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B30409C675B
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 03:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77409284752
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 02:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104DE70800;
	Wed, 13 Nov 2024 02:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XBJbvMw4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57211762D0
	for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 02:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731465230; cv=none; b=Dm2tjVe6/v+Q+cnQqug0PPD83v/58KToj5bX+g3IOjaxViuAndd3Xknfb3silYi21xa6odNdRcYCg0tf5rAdP4WnzbL+f8rGxvHJi86li0hc5nDu1JvE2DDj3zytN/A/fGDLu8plZqse8SumW3/mgSwuvQ843rOCTTad5ciy0Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731465230; c=relaxed/simple;
	bh=iEZTjTmcpJIBBcGnvT4u3X2lZP03q4k4byGKAngMeys=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Xx8QoC01/AVqbYHo5XhvcN823RLCgCUdVHVOYLmboPv2cK5JqTWc5+TWTnsT3W5+6QB/4N71M9UOtNhuPnNf0uuuJIu3W9N76s8lecdv35WyR+YZQA0l0tdmHAWwDDYOUuZSarbyDLFaazDyO3PLswWDs80r+FIJHt8lobYKysE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XBJbvMw4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACMRqCo015276;
	Wed, 13 Nov 2024 02:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4dZ68sUjASBve/nu1HZkyHCc9jcE9aOR+f/w4xyAF3Y=; b=XBJbvMw4Zb+w8ToI
	S3QQ+n9KP9bCbiSBQe3LQjvet12KcWnJlaBOp0iY388fKcFqL8LVg9dSFJO4+fRo
	5zCQppHLMhNcJ3bcfFxd8+encJYcxDWJUCqlIGoTmh0sNtqkm81Zkkabo8Wz3Amn
	2eLhaFfkCyPy2pfcJmMZPd1rGVF4gnQgGfwNNjxxEvwahbPEqOW163bKjnTn0txq
	VUxf2AWdF6rb++xcopU9ldQl3Ik8cEJ5Rfg6K+J66FQctyZsd4mADuT3S/MyIEeG
	x1Z9Vf0q0cFAVLUuiMK/pOuTE2uUJXhmyqnl9ig12GyMGZwWJXomUKr/ebTBM3Be
	7U2WfA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42v1vftyvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 02:33:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AD2XfvB013027
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 02:33:41 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 12 Nov
 2024 18:33:40 -0800
Message-ID: <ffa411d1-89d3-4278-9f62-828c27c0afe0@quicinc.com>
Date: Wed, 13 Nov 2024 10:33:38 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] wifi: ath12k: Add MLO station state change handling
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20241106142617.660901-1-kvalo@kernel.org>
 <20241106142617.660901-2-kvalo@kernel.org>
 <f75d7222-514b-4c6f-985d-e6ffd67e317a@quicinc.com>
 <877c984eym.fsf@kernel.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <877c984eym.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sEhvNHcIUkmfGBAN67PA7MK2rGGekLve
X-Proofpoint-ORIG-GUID: sEhvNHcIUkmfGBAN67PA7MK2rGGekLve
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 mlxlogscore=867 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411130020



On 11/13/2024 12:03 AM, Kalle Valo wrote:
> Baochen Qiang <quic_bqiang@quicinc.com> writes:
> 
>> On 11/6/2024 10:26 PM, Kalle Valo wrote:
>>> +static int ath12k_mac_assign_link_sta(struct ath12k_hw *ah,
>>> +				      struct ath12k_sta *ahsta,
>>> +				      struct ath12k_link_sta *arsta,
>>> +				      struct ath12k_vif *ahvif,
>>> +				      u8 link_id)
>>> +{
>>> +	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(ahsta);
>>> +	struct ieee80211_link_sta *link_sta;
>>> +	struct ath12k_link_vif *arvif;
>>> +
>>> +	lockdep_assert_wiphy(ah->hw->wiphy);
>>> +
>>> +	if (!arsta || link_id >= IEEE80211_MLD_MAX_NUM_LINKS)
>>> +		return -EINVAL;
>>> +
>>> +	arvif = wiphy_dereference(ah->hw->wiphy, ahvif->link[link_id]);
>>> +	if (!arvif)
>>> +		return -EINVAL;
>>> +
>>> +	memset(arsta, 0, sizeof(*arsta));
>>> +
>>> +	link_sta = wiphy_dereference(ah->hw->wiphy, sta->link[link_id]);
>>> +	if (!link_sta)
>>> +		return -EINVAL;
>>> +
>>> +	ether_addr_copy(arsta->addr, link_sta->addr);
>>> +
>>> +	/* logical index of the link sta in order of creation */
>>> +	arsta->link_idx = ahsta->num_peer++;
>>> +
>>> +	arsta->link_id = link_id;
>>> +	ahsta->links_map |= BIT(arsta->link_id);
>>
>> would be better to put this after rcu_assign_pointer()?
> 
> My thinking is that it's racy anyway so it doesn't really matter.
> links_map is not really protected properly right now but luckily there's
> only one function which accesses outside of the wiphy lock. My plan is
> to fix that in a later patch.
> 
>>> +	arsta->arvif = arvif;
>>> +	arsta->ahsta = ahsta;
>>> +	arsta->state = IEEE80211_STA_NONE;
>>> +	wiphy_work_init(&arsta->update_wk, ath12k_sta_rc_update_wk);
>>> +
>>> +	rcu_assign_pointer(ahsta->link[link_id], arsta);
>>> +
>>> +	synchronize_rcu();
>>
>> what are we waiting for here?
> 
> That's a good question. I didn't analyse that thoroughly but I'm just
> making sure here that all readers have access to the new arsta before we
> return to mac80211. 
why would readers have to access arsta BEFORE returning to mac80211? any potential race conditions?

and even if it is necessary, how could synchronize_rcu() guarantee that? synchronize_rcu() is used to make sure all readers have exited from RCU read critical section, I don;t see how it could make sure a newly assigned entry get accessed.

> The delay shouldn't be that long anyway, I hope.
> 


