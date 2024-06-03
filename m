Return-Path: <linux-wireless+bounces-8427-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5819D8D84D1
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 16:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13DFF286349
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 14:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500AE12E1DC;
	Mon,  3 Jun 2024 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FrEL90mE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCE0757E0
	for <linux-wireless@vger.kernel.org>; Mon,  3 Jun 2024 14:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717424534; cv=none; b=n8WyswVjMPQU9nLkfo0TmOiWlnp6uWc5NkqFCqUn0KSOWjgqTUT8o4rGBFBWNMkLNoG+JYlCC3fq8C1rnZyVpjs8goZdEjsB0Mx0DhfjIje3O/wPG1pq0uhBNDQCOslAOxUdwN50L+WflyoiAhgM4qZmt2Y8lYNPoaV+6Wmnw7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717424534; c=relaxed/simple;
	bh=HZWgof5CsfkK2aLzr232MvhJHg2SD0m34sJgyXQ3664=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oHqaNj8Fd4tMW7EOzlVuet8/nF5ohH7ImnVS17lEvVGyJOZ6/bt2lGliZWC+vOmUWNuGEn4lmwQ/g4jG1lrIRw7tct5QLpAEZyF7q5DW6qwYNzR4EAIfpTY9KPO1atp9QH7+UdeTLkxtX289LeCdPRfOQgRozbzYllrF+uNKIjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FrEL90mE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 453AL2Hx001255;
	Mon, 3 Jun 2024 14:22:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	deGssg183ZCrpccPm/B9J68lLaxpGMT56NuhV3wYCVM=; b=FrEL90mEx5JAG4hq
	JIUXEq0fXb2Ym5MGbPnGk9zdiNyi8ymNeoNSsuiFhGzvvzv9azW0wGI4kxZdaP2e
	jfOBZ7kSi4j7n4bWk8hpY6oWiofz/AnyDW93QYZb+01YEBpDyDYN3mgp4AAcOtZ8
	1asMBzW8cWskMXZf5e0mrAXQUCkY79IhGSm4lx77Hp72a0lObLoAERar+2iQZYrF
	HR9fFo0G6iVrZ61M4g8O6Ek9W01klnuWn1k1dPb428frweeDhllrNFyHLQcheBF6
	E7/u8JFo0hxss6rqZpd5vei5B0eWxmY0ygEwr+u2rdnh9LYSnRQxbAdek5t6n1MX
	Lqi97A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw5wm434-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 14:22:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 453EM8Xv029402
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Jun 2024 14:22:08 GMT
Received: from [10.48.241.139] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Jun 2024
 07:22:07 -0700
Message-ID: <991e7861-0c6e-4c77-a866-4295d775df35@quicinc.com>
Date: Mon, 3 Jun 2024 07:22:06 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] wifi: ath12k: support ARP and NS offload
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240530072714.25671-1-quic_bqiang@quicinc.com>
 <20240530072714.25671-7-quic_bqiang@quicinc.com>
 <ccf9791b-e050-4844-8c37-35873fb3fcaf@quicinc.com>
 <17721436-19fb-4337-9058-b20f4df2792c@quicinc.com>
 <af326e49-df6e-4574-9562-44b6aee10abd@quicinc.com>
 <29f1a482-2ead-474a-93a1-00616bcf06f8@quicinc.com>
 <0a386734-5796-4d99-ad4b-ee0a5653a25e@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <0a386734-5796-4d99-ad4b-ee0a5653a25e@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HjqLcgd7FzlruVjyGB9-JypXonw18dNB
X-Proofpoint-ORIG-GUID: HjqLcgd7FzlruVjyGB9-JypXonw18dNB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_11,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 mlxlogscore=940 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406030119

On 6/2/2024 7:48 PM, Baochen Qiang wrote:
> 
> 
> On 6/1/2024 1:26 AM, Jeff Johnson wrote:
>> On 5/30/2024 10:11 PM, Baochen Qiang wrote:
>>>
>>>
>>> On 5/31/2024 11:42 AM, Baochen Qiang wrote:
>>>>>> +static void ath12k_wow_prepare_ns_offload(struct ath12k_vif *arvif,
>>>>>> +					  struct wmi_arp_ns_offload_arg *offload)
>>>>>> +{
>>>>>> +	struct inet6_dev *idev = arvif->idev;
>>>>> as noted above does it make more sense to get the netdev associated with the
>>>>> arvif and then use in6_dev_get(net_device) to get the inet6_dev rather than
>>>>> caching the pointer from the ipv6_addr_changed() callback?
>>>> Ah.. I didn't note that we can get inet6_dev in such a way, just thought the only way is to cache it in ipv6_changed() callback.
>>>>
>>>> will get it using the following in next version:
>>>> 	struct ieee80211_vif *vif = container_of(arvif)
>>>> 	struct ieee80211_sub_if_data *sub_if_data = container_of(vif)
>>>> 	struct net_dev *ndev = sub_if_data->dev
>>>> 	struct inet6_dev *idev = in6_dev_get(ndev)
>>> Just found that ieee80211_sub_if_data is internal to mac80211, so not possible to get netdev in this way.
>>>
>>> any other ideas on how to get netdev?
>>
>> Thinking about this some more, it seems like you'd want to send these down to
>> firmware immediately so that they'd be available for NS offload. Does firmware
>> support NS offload even when host is awake (I think the downstream Android
>> driver supports that)?
> And really curious about the use case in Android scenario.

It's all about saving power. The application processor consumes way more power
than the firmware processors, so any work that can be performed by firmware
extends battery life.

A laptop running on battery would presumably benefit from this as well.

But let's get basic functionality in place using ieee80211_vif_to_wdev()

