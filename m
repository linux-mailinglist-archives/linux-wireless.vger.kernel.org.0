Return-Path: <linux-wireless+bounces-11229-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD4D94D5F1
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 20:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8072281720
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 18:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B19623DE;
	Fri,  9 Aug 2024 18:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bWr3CiOr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C8C8F6E
	for <linux-wireless@vger.kernel.org>; Fri,  9 Aug 2024 18:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723226446; cv=none; b=ID7xU3wrBusWI9pVBe1zGJ5JNkXEIGKsrlw+ZI/uSdRII/AckkUEuP+D03iDYKGU0DyoAa9o3zFxefU6mAnso2vVZKK7/6+OL5LQl3aqJWfpmiJmSrHN3yymVOuw/Sr7ZATQbQ+9XjJWKhZwnR50Lbh0MeWQEzR+4IWhm7WqpBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723226446; c=relaxed/simple;
	bh=AlfDmaHw9uTl/JKgmb9+gkqeV629oPGyAXaHTFtc4lU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RgD033ydq28ha3GlQcFJVIEzLq2KN0uVyjkVfR9BFlNXH/eUnaG5PbbnsFvZqFupgEe/jO1gGDCmyluZiL0hnUfqgiaUPaFIhBVrjKuDteoAZdrvX2mf6T5N+49Ha5xPqmxlJg9sPCC4MPYS303Gfek/5CMMMYZhsw1au2I+sMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bWr3CiOr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 479B8ExV027746;
	Fri, 9 Aug 2024 18:00:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rethE07LdlaRH8QRH6BeDEcYckNyp+a4hcbPzapn6Js=; b=bWr3CiOrQEF2tcEB
	q02zMhBMOPc4IC9TZT8girqaBnLiKue+i5WQHtgG5hJy815qcwB3cu/wOQymTi/6
	wuVIy4P2xJcLD2XHMgaX64irLT6MUI2oEpWrmTVDd/uN3vUMuuWR3kHuX3wRy6Lv
	udN5EzcOGo/behAPIDDHBvBR7qRYxB3Gk/DzDTNrRmuTmA73xkIS0OX9IIsM5IQB
	DTQycPeNy6VV2j9YGJbCo/RdMmHmor6Wjb4Ufr40q4yLZmsGD81rcVcygVBzfQ+b
	eMYpnL8hir9WBqunqXZtyIMA8UIVcpPQ2I5dvYMiurzyf3+YN+WT2MCu6BmcP3S5
	/x0c1g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40sc4yhp5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 18:00:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 479I0Qw5025857
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 Aug 2024 18:00:26 GMT
Received: from [10.216.6.228] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 9 Aug 2024
 11:00:24 -0700
Message-ID: <9287d484-50d0-4044-88c5-5509b6f41d99@quicinc.com>
Date: Fri, 9 Aug 2024 23:30:21 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] wifi: ath12k: prepare vif data structure for MLO
 handling
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Sriram R
	<quic_srirrama@quicinc.com>
References: <20240711165511.3100433-1-quic_ramess@quicinc.com>
 <20240711165511.3100433-2-quic_ramess@quicinc.com>
 <87frrj70nz.fsf@kernel.org> <87sevf2seg.fsf@kernel.org>
 <2b78c227-ef2e-4d98-baf3-762e4f5bd155@quicinc.com>
 <87bk213h3i.fsf@kernel.org>
Content-Language: en-US
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
In-Reply-To: <87bk213h3i.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lXQaR3ySLV0yj-EP60YMjLQBUT6LecXB
X-Proofpoint-GUID: lXQaR3ySLV0yj-EP60YMjLQBUT6LecXB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_14,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408090130



On 8/9/2024 7:59 PM, Kalle Valo wrote:
> Rameshkumar Sundaram <quic_ramess@quicinc.com> writes:
> 
>> On 8/8/2024 4:27 PM, Kalle Valo wrote:
>>> Kalle Valo <kvalo@kernel.org> writes:
>>>
>>>> Rameshkumar Sundaram <quic_ramess@quicinc.com> writes:
>>>>
>>>>> Locking:
>>>>>    Currently modifications to members of arvif and arsta are
>>>>> protected by ar->conf_mutex
>>>>>    and it stays as such.
>>>>>    Now with these hw level structure (ahvif) being introduced, any modifications
>>>>>    to its members and link objects (i.e., arvifs[] which are dynamically allocated)
>>>>>    needs to be protected for writing and ah->conf_mutex is used for the same.
>>>>>    Also, atomic contexts(say WMI events and certain mac_ops) that
>>>>> we currently have in driver
>>>>>    will not(shouldn't be allowed) do any modifications but can read them and
>>>>>    rcu_read_lock() is used for the same.
>>>>
>>>> Please elaborate more about your locking design. Because of past bad
>>>> contributions from Qualcomm the bar is really high for adding any new
>>>> locks. I'm doing the locking analysis right now but it would help a lot
>>>> if you could provide your own analysis.
>>
>> The new ah->conf_mutex is particularly introduced to protect the
>> members and dynamically allocated link objects of ahvif and ahsta
>> (ahvif/sta->links[]) in process context (i.e. between call backs from
>> mac80211 and ath12k's workers)
>> The same is protected by rcu in case of atomic contexts(tasklets of
>> WMI and in datapath)
> 
> I need more info than that. I can't understand which conf_mutex protects
> what data exactly, currently it just looks random to me.
> 
> Let's take an example:
> 
> static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
> ...
> 	mutex_lock(&ah->conf_mutex);
> 	arvif = &ahvif->deflink;

Note that currently only deflink is referred here, but when MLO is 
enabled, info->link_id will be used to de-refer corresponding link
i.e, arvif = rcu_dereference(ahvif->link[info->link_id]);

> 	ar = ath12k_get_ar_by_vif(hw, vif > 	if (!ar) {
> 		cache = ath12k_arvif_get_cache(arvif);
> ...
> 
> 	mutex_lock(&ar->conf_mutex);
> 
> 	ath12k_mac_bss_info_changed(ar, arvif, info, changed);
> 
> So first mac80211 calls ath12k_mac_op_bss_info_changed() with wiphy
> mutex held. Then ath12k takes ah->conf_mutex and soon after also
ah->conf_mutex is taken since link object is referenced, and yes 
currently only deflink is referred, but once MLO is enabled, 
info->link_id from mac80211 is used to refer the corresponding link[] arvif.
> ar->conf_mutex. 
ar conf_mutex is existing lock which is taken for synchronization of 
configuration between this mac80211 callback and workers of the same ar 
(say ath12k_sta_rc_update_wk()) since this config is applied on an arvif 
belonging to that ar.
So we are basically holding three locks and it's not
> clear for me the difference between ah and ar mutexes. For example, do
> ath12k_get_ar_by_vif() & ath12k_arvif_get_cache() require ah->conf_mutex
> to be held? Or why are we taking it here?
No, above two functions doesn't really need ah->conf_mutex at this 
point, but ath12k_arvif_get_cache() is being modified for MLO (check 
[v2] wifi: ath12k: prepare vif config caching for MLO) where caching is 
done in ahvif and there it will be needed.
> 
> I guess ahvif->deflink access does not require any protection because in
> ath12k_mac_op_tx() we access ahvif->deflink without any protection:
> 
> 	struct ath12k_link_vif *arvif = &ahvif->deflink;
> 
ath12k_mac_op_tx() will always be in atomic context as mac80211 ensures 
it to be under rcu_read_lock() hence referring and reading link objects 
of ahvif is safe, but cannot modify it.

> Anyway, I just could not understand this locking design and besides it
> just looks uncessarily complex. I propose dropping the new conf_mutex in
> this patchset altogether and handle the locking in a separate patchset
> later on.
> 
> AFAICS removing ah->conf_mutex from this patchset should be safe as
> mac80211 is holding the wiphy mutex already. Of course I might have
> missed something but at least that's what it looks like.
You're right wiphy/sdata lock is held on all callbacks from mac80211 and
synchronized naturally, but these callbacks running along with workers 
which will be referring link objects of ahvif (e.g, 
ath12k_mgmt_over_wmi_tx_work() referring deflink as of now will use 
skb_cb->link_id to fetch corresponding link arvif) will still need some 
sort of synchronization.
> 

