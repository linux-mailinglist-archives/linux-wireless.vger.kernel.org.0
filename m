Return-Path: <linux-wireless+bounces-14643-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 261869B4E1E
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 16:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CD55B2550F
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 15:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A328193074;
	Tue, 29 Oct 2024 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V6vbtQrr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E825CA23
	for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2024 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730216112; cv=none; b=TogJX4i8XrtVT7cePSc5+t07jimRlLAJJ/ISuyYs9NxazzySMBrbdx7QuwGFS7pnVw7HGU62HbQosHeBLtKO/vDhz6hgNWzU3itHaU0IZBoeNN16CZLjCMpbDytBXrYLzRKmLQZRopeyYskBJOz8K9Bc0n366jX1kdZHqOaiLdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730216112; c=relaxed/simple;
	bh=mTUyesUkZ8viAU3gn2RcFYJdeNLoaMdiGphwiNRel9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LP6s3Z0+dIfxbvtD7f9+iMC1qasZzNCqQratKDk3ZrbbDn9RGVB8sn2hJ9XTar7IxMGiFqCUpGFcKy4EXSBb0vCl5mQxYtrhhaPJlC8KbUZb6mRK7rzQ0DYNVbPkfRYsovsvPKHM3tG+1bkKG3k8GxMWXra9HI4sI4kR1eq49Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V6vbtQrr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TAOFh6003314;
	Tue, 29 Oct 2024 15:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MxkziMdButawcZkqtzPI7sGwoRWjAJgXrIjuGYZPriQ=; b=V6vbtQrrZ1Lg9uuP
	YE/cY8QBUjv/SOXC/sIN9BCVmt5Pxb+6nNu3OrG83mAqjfOCh7JVwmVEKRtmxse0
	CUHU5/ypafCxsN86Y1zPDtCgje61SgH25rvhwC1ea8sYbNk6RsxNMsjV8mZgpeKn
	h+3JZPJaD8L8KQDpRVgzWhVPLZLPB+R8VjeKo03GfbZQA+Qoj5sXFFJgw/SYUCbF
	pHZmPEqtnL1OQp3zHhFi98g9LyqwrOwiteODOGm6X4W+xA9J5tnQxB0WGOdOQd+B
	Eawg4Qe1psegSbbEz3cLim39UV48XPQvKKXSn11EVtta/NjbpGrqwLzDTHFBJg1V
	XLerQg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gqrgrt5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 15:35:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49TFZ21t009083
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 15:35:02 GMT
Received: from [10.48.242.156] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 29 Oct
 2024 08:35:01 -0700
Message-ID: <a792514d-a6b7-43a1-b1bd-f3bde2c38dcd@quicinc.com>
Date: Tue, 29 Oct 2024 08:35:01 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] wifi: ath12k: Refactor sta state machine
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20241023133004.2253830-1-kvalo@kernel.org>
 <20241023133004.2253830-4-kvalo@kernel.org>
 <a4b92b80-ec57-4db3-acd7-9c6c7644d7c9@quicinc.com>
 <87a5engc6a.fsf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <87a5engc6a.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7qbdcIc09k_5SQLG4iR9qP_jkXdnVaYU
X-Proofpoint-GUID: 7qbdcIc09k_5SQLG4iR9qP_jkXdnVaYU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410290119

On 10/29/2024 8:29 AM, Kalle Valo wrote:
> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
> 
>> On 10/23/2024 6:29 AM, Kalle Valo wrote:
>>
>>> +static void ath12k_mac_station_post_remove(struct ath12k *ar,
>>> +					   struct ath12k_link_vif *arvif,
>>> +					   struct ath12k_link_sta *arsta)
>>> +{
>>> +	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
>>> +	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
>>> +	struct ath12k_sta *ahsta = arsta->ahsta;
>>> +	struct ath12k_peer *peer;
>>> +
>>> +	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
>>> +
>>> +	ath12k_mac_dec_num_stations(arvif, arsta);
>>> +
>>> +	spin_lock_bh(&ar->ab->base_lock);
>>> +
>>> +	peer = ath12k_peer_find(ar->ab, arvif->vdev_id, sta->addr);
>>> +	if (peer && peer->sta == sta) {
>>> +		ath12k_warn(ar->ab, "Found peer entry %pM n vdev %i after it was supposedly removed\n",
>>> +			    vif->addr, arvif->vdev_id);
>>> +		peer->sta = NULL;
>>> +		list_del(&peer->list);
>>> +		kfree(peer);
>>> +		ar->num_peers--;
>>> +	}
>>> +
>>> +	spin_unlock_bh(&ar->ab->base_lock);
>>> +
>>> +	kfree(arsta->rx_stats);
>>> +	arsta->rx_stats = NULL;
>>> +
>>> +	if (arsta->link_id < IEEE80211_MLD_MAX_NUM_LINKS) {
>>> +		rcu_assign_pointer(ahsta->link[arsta->link_id], NULL);
>>> +		synchronize_rcu();
>>
>> I've mentioned this in the past in some internal discussion and seems now is a
>> good time to bring this to light.
>>
>> It concerns me that this happens so late in the process. In theory another
>> thread could already have a valid arsta pointer and could be trying to
>> dereference that pointer while the code above is destroying underlying data
>> (i.e. arsta->rx_stats).
>>
>> Should we set this to NULL and synchronize RCU at the beginning of the process
>> so that we know all access to the struct has finished before we start
>> destroying the data?
>>
>> Or can this not actually happen in practice due to other synchronization
>> mechansims? And if so, should we document that somewhere?
> 
> I think you are correct, AFAICS the kfree(arsta->rx_stats) should be
> after synchronize_rcu(). But this race was already in the code before
> this patch so we need to fix in a separate patch. I have added this to
> my todo list.
> 

Sounds reasonable to me


