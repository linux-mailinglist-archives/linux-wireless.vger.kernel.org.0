Return-Path: <linux-wireless+bounces-8417-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4B18D7EFD
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 11:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4486B23078
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 09:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29E577A1E;
	Mon,  3 Jun 2024 09:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GMVFAHb8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E2683CDB
	for <linux-wireless@vger.kernel.org>; Mon,  3 Jun 2024 09:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407175; cv=none; b=ogpsIyweZk6cWrK4wh4ta0avxt61eurMwbnonSRWXBwuf/swpUYzHN5qwxSCSR8sKR2XntFNRJ7hSLyrrwELt/yS/x7A8dBXTojYpiOiWCU7vz8rprIJkHmq9HOhsz06JqQu2sC2rbDIhrUjSuLRL7SDK1shmcTOpNpioNYHGoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407175; c=relaxed/simple;
	bh=7pkcOTh0EnU51ydC40w/EaRcRnViQqixQofKQsW/qL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ftqMado7AN6S1vW28s7jBGFjpn1M3JEKkixBZZt9ecXQjdlMkVCnDDuLKodlxE4lq7YPqIhsnb/lmh4OTxwASJjj5PLY/q3xSZ6vUmorGMSgldQi+Jb6JDuOJrxfcq7uyr1GwKSEux9ALTJ4qYPrJKA99QlmckaXgqD2H7rpeTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GMVFAHb8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 452N0kIx031648;
	Mon, 3 Jun 2024 09:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PVG4j7jmJh0NMWVfBzTI9QsJzzhEVI1IdI5oKA4YmaA=; b=GMVFAHb8LJKT4ZaI
	4yTPFYYqZmbCltBWVaw0z+EIpX+DE2o/70/waS9UQ0tAvROfYnuR9VX81OCC2rSu
	ykXZhkdpq3HPNhSdblIoYx13ZSRJPgAP1beN1O23fpzB9w6sdN/N1FjfIDSI09nE
	jJF1gTHgjyHreFR4hdEHYVk93n9k8v35gJ9OW2vkAAZ3Gh7uFc33TAFWE2ODKvqR
	i2hBKLAuT37dWAV4eJf7h1iQo+09PPiojMMTKbOr2GhUBL1DpmRc+1JHf/ycHehh
	dexnOHlMXdwxCTnnUlWkcYbMqqOVIN1bNWEpviDt9QhprlG55l2xZUHy9FiQ2T3e
	UsUzIg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw7dkgh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 09:32:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4539WjpI007610
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Jun 2024 09:32:45 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Jun 2024
 02:32:45 -0700
Message-ID: <226e1406-bca9-4d4a-90f0-65084b06fd2f@quicinc.com>
Date: Mon, 3 Jun 2024 17:32:42 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] wifi: ath12k: support ARP and NS offload
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240530072714.25671-1-quic_bqiang@quicinc.com>
 <20240530072714.25671-7-quic_bqiang@quicinc.com>
 <ccf9791b-e050-4844-8c37-35873fb3fcaf@quicinc.com>
 <17721436-19fb-4337-9058-b20f4df2792c@quicinc.com>
 <af326e49-df6e-4574-9562-44b6aee10abd@quicinc.com>
 <29f1a482-2ead-474a-93a1-00616bcf06f8@quicinc.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <29f1a482-2ead-474a-93a1-00616bcf06f8@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BSEBTYPGv432UJixaFs3WXelUtCPxKsC
X-Proofpoint-GUID: BSEBTYPGv432UJixaFs3WXelUtCPxKsC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_05,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406030078



On 6/1/2024 1:26 AM, Jeff Johnson wrote:
> On 5/30/2024 10:11 PM, Baochen Qiang wrote:
>>
>>
>> On 5/31/2024 11:42 AM, Baochen Qiang wrote:
>>>>> +static void ath12k_wow_prepare_ns_offload(struct ath12k_vif *arvif,
>>>>> +					  struct wmi_arp_ns_offload_arg *offload)
>>>>> +{
>>>>> +	struct inet6_dev *idev = arvif->idev;
>>>> as noted above does it make more sense to get the netdev associated with the
>>>> arvif and then use in6_dev_get(net_device) to get the inet6_dev rather than
>>>> caching the pointer from the ipv6_addr_changed() callback?
>>> Ah.. I didn't note that we can get inet6_dev in such a way, just thought the only way is to cache it in ipv6_changed() callback.
>>>
>>> will get it using the following in next version:
>>> 	struct ieee80211_vif *vif = container_of(arvif)
>>> 	struct ieee80211_sub_if_data *sub_if_data = container_of(vif)
>>> 	struct net_dev *ndev = sub_if_data->dev
>>> 	struct inet6_dev *idev = in6_dev_get(ndev)
>> Just found that ieee80211_sub_if_data is internal to mac80211, so not possible to get netdev in this way.
>>
>> any other ideas on how to get netdev?
> 
> Thinking about this some more, it seems like you'd want to send these down to
> firmware immediately so that they'd be available for NS offload. Does firmware
> support NS offload even when host is awake (I think the downstream Android
> driver supports that)?
> 
> So perhaps an alternative approach is to collect the information you need from
> the notification and then schedule a workqueue to actually send the
> information to firmware?
As is pointed out by johannes in another reply, if you are OK with original proposal I can go getting ieee80211_vif_to_wdev(arvif->vif)->netdev in ath12k_wow_prepare_ns_offloa().

