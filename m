Return-Path: <linux-wireless+bounces-15795-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D87A39DBE6A
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2024 02:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99CF7281A73
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2024 01:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5815AC8F0;
	Fri, 29 Nov 2024 01:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZiafERQE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF8D749C
	for <linux-wireless@vger.kernel.org>; Fri, 29 Nov 2024 01:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732844713; cv=none; b=m6YZhKTF1a9f3IvuGzAqRXIYyDqxZPFyh75PfB4175S67VbbpZI/DrHdBpsEJkgM1rY6atJxkP3atp/9OxQcIvCk0RSw5+nQzJqPNo5Wy1oI792XJA90LDpzh6ceF4P68EDg0+f5yD1ZZ+VZWun2q/shK/4mROcCM1GBBp1EL8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732844713; c=relaxed/simple;
	bh=aZoH8D7hlE6M9r4yXSBGro4Qtwej+r4ESDEVnoR2QLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c8unry53G8vKvwAtRi9/PoUQYcaYdO/9wtdSUBink0vx3VCaWgRzQ4YvXqHkCfA4FxW1waZJ+FaseYm1PsiuYgj9HWjbxadZ1WwtUqzu2qZD+/ZFMbNRVCbxXkADakLKZ0CZYF6wyQsVC37p4A4mhQSdG9QgpPpmV2mEnzQhOZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZiafERQE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ASLZ9U6011887;
	Fri, 29 Nov 2024 01:45:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sVElr7IbIf0QnIfUpYRPia6I8P75pkU+MLI1xl3ZsAI=; b=ZiafERQEGGOEtheP
	0SNnj2QHA89OM971MVZADxWtnDToybDwf8kZavwsChGYOqLHu3IOX2/J3aHcWnqL
	jrtekR5WhxLaC6D0BgQZreJ8OrZFA1qN6AP54GhM7LPxesTsUQD8lsBYHNhSyZvn
	BC/fpoC/A9RZGajZyTqSdGZA2xsqnhYw7dNelkT2WE2Xk1onD5skrsPyXwWKzyOO
	fPBkw5IkRN0IgpsvHyfbRUxeNiKdQS/1PcJqfO6uk/j/aa6CWBRI+gfvYSRs9ayN
	Yf25G0cbv/mywGkTt7c2DI+rQSCFZErkAnQrC8gB5QuFnxzxpZXB+Vr5Fh6dw0bs
	kDw1QA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4366xxm54n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 01:45:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AT1j4lO025984
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 01:45:04 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 28 Nov
 2024 17:45:03 -0800
Message-ID: <8da34c5c-2a7b-436f-b9ed-2835396a7e65@quicinc.com>
Date: Fri, 29 Nov 2024 09:45:01 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] wifi: ath12k: ath12k_mac_op_tx(): MLO support
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20241126171139.2350704-1-kvalo@kernel.org>
 <20241126171139.2350704-3-kvalo@kernel.org>
 <28bdb726-a7cf-40e7-8bc4-f7602bba1e93@quicinc.com>
 <87ttbrv8rs.fsf@kernel.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <87ttbrv8rs.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IeIU6JNxGVNiLOjzbomTYu6QZl_3keRv
X-Proofpoint-ORIG-GUID: IeIU6JNxGVNiLOjzbomTYu6QZl_3keRv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 mlxlogscore=746 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2411290012



On 11/28/2024 8:32 PM, Kalle Valo wrote:
> Baochen Qiang <quic_bqiang@quicinc.com> writes:
> 
>> On 11/27/2024 1:11 AM, Kalle Valo wrote:
>>> From: Sriram R <quic_srirrama@quicinc.com>
>>>
>>> @@ -6848,6 +6848,7 @@ static void ath12k_mgmt_over_wmi_tx_purge(struct ath12k *ar)
>>>  static void ath12k_mgmt_over_wmi_tx_work(struct wiphy *wiphy, struct wiphy_work *work)
>>>  {
>>>  	struct ath12k *ar = container_of(work, struct ath12k, wmi_mgmt_tx_work);
>>> +	struct ath12k_hw *ah = ar->ah;
>>>  	struct ath12k_skb_cb *skb_cb;
>>>  	struct ath12k_vif *ahvif;
>>>  	struct ath12k_link_vif *arvif;
>>> @@ -6865,7 +6866,15 @@ static void ath12k_mgmt_over_wmi_tx_work(struct wiphy *wiphy, struct wiphy_work
>>>  		}
>>>  
>>>  		ahvif = ath12k_vif_to_ahvif(skb_cb->vif);
>>> -		arvif = &ahvif->deflink;
>>> +		if (!(ahvif->links_map & BIT(skb_cb->link_id))) {
>>> +			ath12k_warn(ar->ab,
>>> +				    "invalid linkid %u in mgmt over wmi tx with linkmap 0x%X\n",
>>
>> s/0x%X/0x%x/ ?
> 
> Fixed.
> 
>>
>>> +				    skb_cb->link_id, ahvif->links_map);
>>> +			ath12k_mgmt_over_wmi_tx_drop(ar, skb);
>>> +			continue;
>>> +		}
>>> +
>>> +		arvif = wiphy_dereference(ah->hw->wiphy, ahvif->link[skb_cb->link_id]);
>>>  		if (ar->allocated_vdev_map & (1LL << arvif->vdev_id)) {
>>>  			ret = ath12k_mac_mgmt_tx_wmi(ar, arvif, skb);
>>>  			if (ret) {
>>> @@ -6875,9 +6884,10 @@ static void ath12k_mgmt_over_wmi_tx_work(struct wiphy *wiphy, struct wiphy_work
>>>  			}
>>>  		} else {
>>>  			ath12k_warn(ar->ab,
>>> -				    "dropping mgmt frame for vdev %d, is_started %d\n",
>>> +				    "dropping mgmt frame for vdev %d link_id %u, is_started %d\n",
>>>  				    arvif->vdev_id,
>>> -				    arvif->is_started);
>>> +				    arvif->is_started,
>>> +				    skb_cb->link_id);
>>
>> swap 'arvif->is_started' and 'skb_cb->link_id'.
> 
> Good catch! Fixed as well.
> 
>>> +/* Note: called under rcu_read_lock() */
>>> +static u8 ath12k_mac_get_tx_link(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
>>> +				 u8 link, struct sk_buff *skb, u32 info_flags)
>>> +{
>>> +	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
>>> +	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
>>> +	struct ieee80211_link_sta *link_sta;
>>> +	struct ieee80211_bss_conf *bss_conf;
>>> +	struct ath12k_sta *ahsta;
>>
>> better to assert RCU read lock here?
> 
> You mean something like WARN_ON(!rcu_read_lock_held())? I'm not really a
> fan of that, I think it's better that we discuss this also once we
> document locking design properly.
> 
>>> +/* Note: called under rcu_read_lock() */
>>>  static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
>>>  			     struct ieee80211_tx_control *control,
>>>  			     struct sk_buff *skb)
>>> @@ -6945,13 +7054,16 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
>>>  	struct ieee80211_vif *vif = info->control.vif;
>>>  	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
>>>  	struct ath12k_link_vif *arvif = &ahvif->deflink;
>>> -	struct ath12k *ar = arvif->ar;
>>>  	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
>>>  	struct ieee80211_key_conf *key = info->control.hw_key;
>>> +	struct ieee80211_sta *sta = control->sta;
>>>  	u32 info_flags = info->flags;
>>> +	struct ath12k *ar;
>>>  	bool is_prb_rsp;
>>> +	u8 link_id;
>>>  	int ret;
>>>  
>> better to assert RCU read lock here?
> 
> Same comment here as above.
> 
>>
>>> +	link_id = u32_get_bits(info->control.flags, IEEE80211_TX_CTRL_MLO_LINK);
>>>  	memset(skb_cb, 0, sizeof(*skb_cb));
>>>  	skb_cb->vif = vif;
>>>  
>>> @@ -6960,6 +7072,27 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
>>>  		skb_cb->flags |= ATH12K_SKB_CIPHER_SET;
>>>  	}
>>>  
>>> +	/* handle only for MLO case, use deflink for non MLO case */
>>> +	if (vif->valid_links) {
>>
>> better to use ieee80211_vif_is_mld() helper?
> 
> Indeed, fixed.
> 
> I did all the changes directly in the pending branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=57ee27f3b3aa13c63978f03ce544c2f4210a9cd7

LGTM

> 
> BTW when you reply please include an empty line between the quote and
> your reply, this improves readability.

sure, will keep in mind.

> 


