Return-Path: <linux-wireless+bounces-8389-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298FF8D7A29
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 04:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B6B31C209B4
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 02:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E19F9E9;
	Mon,  3 Jun 2024 02:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TdoyQ8FC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078B7F9E6
	for <linux-wireless@vger.kernel.org>; Mon,  3 Jun 2024 02:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717382855; cv=none; b=nSTBACr22VpmRqWxpLgKdKhYbFxNW5d9raO41g8Y3JYU2Aol5Hd2f/UoIkdjdZaTzefpA0HyefHDWJGext/V3/gKl3kg6/ZgnrIWWqgsVT9T0vg2WOGghPB9CZRpwsybDXkg3U1JQQHHLvvdHrhsh3UPpPtdEuSmLutK3HMVMDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717382855; c=relaxed/simple;
	bh=MV5/di/VX2af1s335wKKbMAmVjxNVlw1JGJ3Ba6/E7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=er925SVGoDKct/91OU0yLJkxEfjrhI5KlgorhEGNvu9VbSAARLf9+JsgiUVKaiJubOi8XzJ3LtRnDraeGq3AmjKCrVM/0Yb1u4MECNbzmijQXllWsErEdVKGchpsa9vrqglsc4VUpNjnf4YM0QvGlCBPTez0JT+cwGz0mK36HDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TdoyQ8FC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4530TiOU004549;
	Mon, 3 Jun 2024 02:47:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q4F8EDSKxCHWPtiAZk6DlscnSsk75S8hh8hQFs1rs8g=; b=TdoyQ8FCtxC7HWcO
	QjfL07EJll/W+IuEiEhKvPo0WHoT1FkXnZMr5ATT30jANDQEq1y+LDlCngLY0ch3
	8XHjsrgN+DOyWuaMUf8Qhi8PCaH1iu/9+tUoZ+XP+gUGJLXfY5zbzeoyPB7VtoXr
	TC7OIQSNioyfaLstgcYfQGsiMXwVee6cq+6ZRiGzvDhDmLDEg1QgI6VeJb59vPmB
	ctF1sDux6YE+lyRdiVZfUon840lxaY2t3YKnoAaGED33h/AQ45xB0ALPmV77+TyA
	kwNnL/u1MAe+AtbpbbyXGprZrTxS/18TzBdmgv8UkUi2vzvgm0bouGZCznRu8i1H
	Vc/yyQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw4ajypg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 02:47:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4532lKls020329
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Jun 2024 02:47:20 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 2 Jun 2024
 19:47:19 -0700
Message-ID: <8559ced4-cc59-4cbb-83c1-92bf7401cf0d@quicinc.com>
Date: Mon, 3 Jun 2024 10:47:16 +0800
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
X-Proofpoint-GUID: mYm0kOkM7P8dBvFc90U8jHw74peKibhY
X-Proofpoint-ORIG-GUID: mYm0kOkM7P8dBvFc90U8jHw74peKibhY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-02_15,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406030023



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
Checked with firmware team and they confirmed it is supported. But do we really want to do this? Any benefit from offloading when awake?

And won't there be any issues? at least it would make me confused if a arp/NS request/response pair are seen in sniffer but neither of them seen in host ...
> So perhaps an alternative approach is to collect the information you need from
> the notification and then schedule a workqueue to actually send the
> information to firmware?

