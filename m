Return-Path: <linux-wireless+bounces-8350-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C3E8D6822
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 19:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 960E0B21616
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 17:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A4915DBC4;
	Fri, 31 May 2024 17:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nVKfI3AF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC85A55E4C
	for <linux-wireless@vger.kernel.org>; Fri, 31 May 2024 17:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717176416; cv=none; b=S9fzhD0xpMeyVFHeR8F5GD4/0VrXcBy37UCMMBZ1Eh7ZTzhoenIqqJMHE/fI5mEJpw4pXnNnufEzJdwHKHdqYM95pab9a1Sl1Svmf4JmzKhbuyIDpYvDXeIY9ztL5dG6ssKgTJBqojnF6N59I5T92ZpK2piPLYboyVmL5mYoom4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717176416; c=relaxed/simple;
	bh=D4iuDm6VOlm5ADnTjz6uHtdAGtAs1bBoV9kEhxgO7Yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P5bGgn7xCcKc2GL3RZ4w9+tI5m8ubKht5dA0m9YXUBCbGea2wtYLD+ResCLZh2dS3lz796W+Zy+pbiafUoRW2H8C0kafVmGM6O7AGUr3F40JgnrnWgtfqfFkVSGZ2Js3X00njkL/ZjNnxhM5CKLfe2mWGNKD5JPbZjTr53Jw7MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nVKfI3AF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44VFK0KO031709;
	Fri, 31 May 2024 17:26:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Kb+iaUW6DdlJnSDpiN1YqPO1vDQ8v64dWbqzF7/lRd0=; b=nVKfI3AFYRtZ3hhP
	ytOauIc97cV6++YlMC5O6FFP15/mJx+m/JwKpTAnlN7JlvY8C4Al8hEzwAhMTza9
	i1h3OltXFVqH9WPBhWy0+WCDorRsU9Syp+m2d61YLVyCa0WrnQuIOcqdit2GSXlV
	8qmrfLt2L2S1/9uHVfLDcWNc19QItZr850vL+2SQHLBwMluKBmg/dNNJj6cNvg4f
	BBwHpX14HLSArWTnEJUM9eX0Nkf5Cw1nNkczoKwDCMWzYDn0x8IUqS43Rc2pr3H8
	E1im3fhHrb4Jyxvygi1JhWtvtLIxkVgtlrhyWgA9NLWgGB9cIyvF+OjCsmFWCL2E
	hpU9AQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yf8xa1q1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 17:26:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44VHQp5R030498
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 17:26:51 GMT
Received: from [10.110.11.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 31 May
 2024 10:26:50 -0700
Message-ID: <29f1a482-2ead-474a-93a1-00616bcf06f8@quicinc.com>
Date: Fri, 31 May 2024 10:26:49 -0700
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
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <af326e49-df6e-4574-9562-44b6aee10abd@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xwQXDhSs0_3H9RE0iaMZbX2RQMZHyxvk
X-Proofpoint-ORIG-GUID: xwQXDhSs0_3H9RE0iaMZbX2RQMZHyxvk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_12,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310132

On 5/30/2024 10:11 PM, Baochen Qiang wrote:
> 
> 
> On 5/31/2024 11:42 AM, Baochen Qiang wrote:
>>>> +static void ath12k_wow_prepare_ns_offload(struct ath12k_vif *arvif,
>>>> +					  struct wmi_arp_ns_offload_arg *offload)
>>>> +{
>>>> +	struct inet6_dev *idev = arvif->idev;
>>> as noted above does it make more sense to get the netdev associated with the
>>> arvif and then use in6_dev_get(net_device) to get the inet6_dev rather than
>>> caching the pointer from the ipv6_addr_changed() callback?
>> Ah.. I didn't note that we can get inet6_dev in such a way, just thought the only way is to cache it in ipv6_changed() callback.
>>
>> will get it using the following in next version:
>> 	struct ieee80211_vif *vif = container_of(arvif)
>> 	struct ieee80211_sub_if_data *sub_if_data = container_of(vif)
>> 	struct net_dev *ndev = sub_if_data->dev
>> 	struct inet6_dev *idev = in6_dev_get(ndev)
> Just found that ieee80211_sub_if_data is internal to mac80211, so not possible to get netdev in this way.
> 
> any other ideas on how to get netdev?

Thinking about this some more, it seems like you'd want to send these down to
firmware immediately so that they'd be available for NS offload. Does firmware
support NS offload even when host is awake (I think the downstream Android
driver supports that)?

So perhaps an alternative approach is to collect the information you need from
the notification and then schedule a workqueue to actually send the
information to firmware?

