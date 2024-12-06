Return-Path: <linux-wireless+bounces-15944-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8609E640D
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 03:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C84D284524
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 02:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335F314A4F9;
	Fri,  6 Dec 2024 02:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O3uuBNW0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A70620309;
	Fri,  6 Dec 2024 02:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733451890; cv=none; b=CTu0eWFVY7LxKumeOcFgeEXfSWSZ1hsdI0aEeqXprn4Q/0caWAefor7Pi+7+8evShC/rCHJcxzRUtD89M6FPpYQmSw6Z5RxLUzf8MRg6sT86PAN8BVoXm2ziGpXSdrG5SSogjPz8sQPzgph18WfeYQ3gPYrkH7Y1RhmNPdxemcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733451890; c=relaxed/simple;
	bh=RrREZe65T84WvRHTg/6vCTDQdA2gs4m9WlVmbcg0u1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CvNirmZL+zkQU32m3qwzsTc+UbKncsvfHK8C1HFustNj8mmTdMeZa7CU/m7V6+YIrralaXu4TDzfI07zvagX+nRHZz8ioCxUkpPQh4UIheQkYl01UclbYBoS3RQgyySPoiHvmhdL/e0LB81j5Gh53RJo4lv2ruboacaxGVChLsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O3uuBNW0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5JjJVV020526;
	Fri, 6 Dec 2024 02:24:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xns2EYKDJ8I5Ule8x5i/zuXDCSxmsS05blIyYLVrRr0=; b=O3uuBNW0VE8QDIqY
	czgMoEvWY5AxVDDCk8ZLwO/ejLv/S5DhSOzYLxFL4LdluXPzZjgT4ZWW6gTGSpQx
	tM+80fuN1zCHdpXTUD9Bnfen39esPchgErF/2SLfL3ITW7OO9NemJZbUEzgRwEZ0
	mGFgmjP3/cpNshgc1GoS1YKPHVbeEd8uAzcZ7UsXADIFCUu5vhB2CIsvHfBA6F6J
	yNEcDhQzO5eD8fAHl99dRnyiLvVFaDgao6ZcUD4ZvUAIVKglptwuvKHnpiZhYg/K
	fwUb7/yj7HF57vkADckiyMwBj39dv+Dn41krOF+WZCRU+vW5u2M2AJjYYKFd7gPQ
	S56CSw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43bjk8rqrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 02:24:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B62Oc46025525
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Dec 2024 02:24:38 GMT
Received: from [10.231.194.79] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Dec 2024
 18:24:35 -0800
Message-ID: <0f24e115-e76d-4c8a-8a1b-591a157ee78e@quicinc.com>
Date: Fri, 6 Dec 2024 10:24:32 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: allow APs combination when dual stations
 are supported
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
CC: <ath11k@lists.infradead.org>, <jjohnson@kernel.org>, <kvalo@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <quic_cjhuang@quicinc.com>, <vbenes@redhat.com>
References: <f75a1655-fa5d-4675-85d0-b9b97dceba6f@quicinc.com>
 <20241205110704.232725-1-jtornosm@redhat.com>
Content-Language: en-US
From: "Yu Zhang (Yuriy)" <quic_yuzha@quicinc.com>
In-Reply-To: <20241205110704.232725-1-jtornosm@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VigsKiCRULIKKvcJmXWaueZ37fg3Bh-c
X-Proofpoint-GUID: VigsKiCRULIKKvcJmXWaueZ37fg3Bh-c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412060016



On 12/5/2024 7:07 PM, Jose Ignacio Tornos Martinez wrote:
>> But I see your interfaces all be added with managed， right?
> Yes
> 
My point is that you can try setup with ap type interface, now 
combination limits not allow up 3 inferfaces with managed interface.
>> Test steps:
>> ...
> Ok, I am using a bridge with the AP interfaces in addition but it is
> the same.
> Indeed I have tested in the same way as you too (even using your
> hostapd.conf with the suitable name for the interfaces).
> So I have started to debug (current upstream linux +
> https://lore.kernel.org/all/20241127022742.4016870-1-quic_yuzha@quicinc.com/ +
> dump_stack() in ath11k_mac_op_add_interface, enabling ath11k_dbg),
> let me show you this:
> [    5.703295] ath11k_pci 0000:01:00.0: vdev a2:d8:da:c5:7b:79 created, vdev_id 0
> [    5.703304] CPU: 4 UID: 0 PID: 945 Comm: NetworkManager Tainted: G        W          6.12.0+ #104
> [    5.703315] Tainted: [W]=WARN
> [    5.703317] Hardware name: ASUS System Product Name/PRIME B660-PLUS D4, BIOS 1620 08/12/2022
> [    5.703320] Call Trace:
> [    5.703325]  <TASK>
> [    5.703330]  dump_stack_lvl+0x5d/0x80
> [    5.703344]  ath11k_mac_op_add_interface.cold+0x4ed/0xa92 [ath11k]
> [    5.703399]  drv_add_interface+0x4f/0x230 [mac80211]
> [    5.703512]  ieee80211_do_open+0x4b3/0x770 [mac80211]
> [    5.703669]  ieee80211_open+0x8a/0x90 [mac80211]
> ...
> [    5.804755] ath11k_pci 0000:01:00.0: vdev c8:94:02:b5:fe:fb created, vdev_id 1
> [    5.804759] CPU: 1 UID: 0 PID: 1011 Comm: wpa_supplicant Tainted: G        W          6.12.0+ #104
> [    5.804763] Tainted: [W]=WARN
> [    5.804765] Hardware name: ASUS System Product Name/PRIME B660-PLUS D4, BIOS 1620 08/12/2022
> [    5.804766] Call Trace:
> [    5.804770]  <TASK>
> [    5.804773]  dump_stack_lvl+0x5d/0x80
> [    5.804783]  ath11k_mac_op_add_interface.cold+0x4ed/0xa92 [ath11k]
> [    5.804809]  drv_add_interface+0x4f/0x230 [mac80211]
> [    5.804868]  ieee80211_do_open+0x4b3/0x770 [mac80211]
> [    5.804934]  nl80211_start_p2p_device+0x8b/0x160 [cfg80211]
> ...
> So, since the normal sta interface and p2p interface are initialized,
> with your proposed interface combination, only one AP interface can be
> added for me (vdev limit is 3).
> I like your idea to have a common interface combination set for everything,
> but I think it is not possible here.
> My patch with the new parameter at least allow to select what to do, dual
> stations support or APs support for all the cases.
> 
> Thanks
> 
> Best regards
> Jose Ignacio
> 


