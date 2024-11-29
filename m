Return-Path: <linux-wireless+bounces-15794-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CBB9DBE67
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2024 02:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5129281A3A
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2024 01:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B394F23CB;
	Fri, 29 Nov 2024 01:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SbdQup5O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195261EA65
	for <linux-wireless@vger.kernel.org>; Fri, 29 Nov 2024 01:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732844422; cv=none; b=XM+lr9vRoil0ncuLmB9Ktu3dW4hXUmBIsX4gKtbWdK0SwcK6RojtTzzWl9J47jucx4xEMyooQbzmlR2mEi2r6oUYa/sFpCPd8D/16onK8wTzwslopYShY1N7cTqv1VMHqS3AGUbS+rx9npWLapJ46d6OX8aCMdpzQHbkn6UzEwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732844422; c=relaxed/simple;
	bh=y4yZ6wohfOKtEDDITqRC4yUeDp0kD5FAfP/e7wM057c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VUDfnGSIdmSlVlzPPO1w0shi7NH4kg15SThEZ+rTt/jELLWqxqwZPsMuP7gnNTUGrkVfRIPZiBSxnjpiFmkLIalJwUOjZ164fjXi0XDEqoBejaks9FsqB/inSmKM34cZ3jauHgUsX9W23kzEI2wJwyyw8Qg41RRsKJZySx3lCKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SbdQup5O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ASNRnV8026932;
	Fri, 29 Nov 2024 01:40:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BI0nDHVN2YG8aqCX9puolvFRLtBz+BMZe+/WOT6AGQs=; b=SbdQup5OUczSpKQi
	y1gxtna7lIM+lD/nSF0DPYLlqmpsJVwadnjaAy8cjkX01ZgBdI7tmet9kq6mVkYo
	7rEt2V45II6P+FZMGqU2XAmMpNiBkosb/g/XFZXL216SlA3AhecKWUFjvZbef4+2
	LmOTn61w37Zahk4nuVBXjEiD8eHhwOEOUIK4PVP7sVQoDuAx23UehBPB7lKk9pPy
	ejpK2ayAh9ehOJGg/7jv4PLrpP21q4ylRMFkv5wSQI4j0DXDCt+PUsz8+O1d73Za
	o+VcRRFmyBUJI8DtGc1TafTs+RupF63nGjQE4HZsf57lhCzafzMaAjo8PeGMsmiW
	8RjV6Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43671ec195-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 01:40:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AT1eBTi012714
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 01:40:11 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 28 Nov
 2024 17:40:09 -0800
Message-ID: <c7fe0222-9dea-4a57-8bd3-f51b11eb5f21@quicinc.com>
Date: Fri, 29 Nov 2024 09:40:08 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] wifi: ath12k: convert struct
 ath12k::wmi_mgmt_tx_work to struct wiphy_work
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20241126171139.2350704-1-kvalo@kernel.org>
 <20241126171139.2350704-2-kvalo@kernel.org>
 <83b2325e-4d98-49a1-ae32-a69d7962e4a3@quicinc.com>
 <87y113v9uy.fsf@kernel.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <87y113v9uy.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: g_zypTBwZJ8WR6eo2J3bp7eaRULO1-U2
X-Proofpoint-GUID: g_zypTBwZJ8WR6eo2J3bp7eaRULO1-U2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 impostorscore=0 mlxscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 mlxlogscore=897
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2411290011



On 11/28/2024 8:08 PM, Kalle Valo wrote:
> Baochen Qiang <quic_bqiang@quicinc.com> writes:
> 
>> On 11/27/2024 1:11 AM, Kalle Valo wrote:
>>> From: Kalle Valo <quic_kvalo@quicinc.com>
>>>
>>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>>> @@ -6726,6 +6726,8 @@ static void ath12k_mgmt_over_wmi_tx_drop(struct ath12k *ar, struct sk_buff *skb)
>>>  {
>>>  	int num_mgmt;
>>>  
>>> +	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
>>
>> why would we need wiphy lock protect here? I don;t see anything in this function need it.
>>
>>> +
>>>  	ieee80211_free_txskb(ath12k_ar_to_hw(ar), skb);
>>>  
>>>  	num_mgmt = atomic_dec_if_positive(&ar->num_pending_mgmt_tx);
>>> @@ -6787,6 +6789,8 @@ static int ath12k_mac_mgmt_tx_wmi(struct ath12k *ar, struct ath12k_link_vif *arv
>>>  	int buf_id;
>>>  	int ret;
>>>  
>>> +	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
>>
>> and here the same question as above. I know this function is only called from
>> ath12k_mgmt_over_wmi_tx_work() which is under wiphy lock protection. But the function
>> itself doesn't need to assert it if the function does not need its protection.
>>
>>> +
>>>  	ATH12K_SKB_CB(skb)->ar = ar;
>>>  	spin_lock_bh(&ar->txmgmt_idr_lock);
>>>  	buf_id = idr_alloc(&ar->txmgmt_idr, skb, 0,
>>> @@ -6841,7 +6845,7 @@ static void ath12k_mgmt_over_wmi_tx_purge(struct ath12k *ar)
>>>  		ath12k_mgmt_over_wmi_tx_drop(ar, skb);
>>>  }
>>>  
>>> -static void ath12k_mgmt_over_wmi_tx_work(struct work_struct *work)
>>> +static void ath12k_mgmt_over_wmi_tx_work(struct wiphy *wiphy, struct wiphy_work *work)
>>>  {
>>>  	struct ath12k *ar = container_of(work, struct ath12k, wmi_mgmt_tx_work);
>>>  	struct ath12k_skb_cb *skb_cb;
>>> @@ -6850,6 +6854,8 @@ static void ath12k_mgmt_over_wmi_tx_work(struct work_struct *work)
>>>  	struct sk_buff *skb;
>>>  	int ret;
>>>  
>>> +	lockdep_assert_wiphy(wiphy);
>>
>> we are definitely under wiphy lock protection since this is a wiphy_work item, hence no
>> need to assert it explicitly. see also
>>
>> ieee80211_sta_monitor_work()
>> ieee80211_beacon_connection_loss_work()
>> ieee80211_csa_connection_drop_work()
>> ieee80211_teardown_ttlm_work()
> 
> I have deliberately added all these lockdep_assert_wiphy() calls to
> document which functions are called with wiphy_lock() held, otherwise
> doing any locking analysis is much harder. My plan is that once MLO
> support has landed to ath-next my plan is to document ath12k locking
> design properly in the code. I think at that point we can also discuss
> how we should use lockdep_assert_wiphy() in ath12k and should we drop
> the extra calls.
Ah, good to know. thanks for sharing the plan.

> 


