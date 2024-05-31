Return-Path: <linux-wireless+bounces-8338-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3547C8D59BD
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 07:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EF3B1C21A83
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 05:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461281C6A7;
	Fri, 31 May 2024 05:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bYD9a9w0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9523A5695
	for <linux-wireless@vger.kernel.org>; Fri, 31 May 2024 05:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717132277; cv=none; b=pVOY46jC+AsXljypOlEaCr6D1a3b569JAbTkI0Rqo7MGoxlcJn4+AIMuXms7GBtYZCqUYhq2hLt2z950ySnhAPNJeTRvh3Bq4jsk2rUFRELuIXMrnwCvO/JZxtpc5z9VwVhDIf2ZGn1ek3geWySQ0A5idzYKvcx+SAoewF232VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717132277; c=relaxed/simple;
	bh=bR5s/zpkMMJW3BT+6NgINCPe4/lV55B4zsYb5/z/5Ec=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=djHRRya/jifu9EaIyTrwfwNiRP9Ey3sajVETheg6fJ7QcP1pRBbOmadTYwI4Z8obczx2HbDN3kL4RvE7fmDM1Jg9Ai1qGjIzQqW98/IZ3r+uwMZhy3CsbAlzsHW66cOwZ+kLzD+MdgRWbNSOguWJlRZHIDPNHDJ/eH7T7xjMCyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bYD9a9w0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44UMGJlC015861;
	Fri, 31 May 2024 05:11:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bGyszgCXocncdDXygI9xiaUAxlOXQcXtacPXeoOi/i8=; b=bYD9a9w0+SMrIbvE
	/LXsF2DAIWZ4ulV6NdUUwjUFnyVo00LJeX8RVNl15R2pL2ClNqsreGy/sSVXxEgd
	VVIgClyf51f6ZwEy+O+HIfyrEIxYfWDBXhL4Cd4Me8Xnx4VnznfKwmED34TKFPBB
	oK+hdox5lNm+CQhQsCIIKtF0RysN7NW+xJOSlKp5ZVa5luLGLe/ah3zYeZyRgO8O
	VjAZ6ujtleu86f1kVX/2JfsXBGRbJuBjfnn0MzzHuZSAwgGAGIsR+Y5eZrZ5NdPz
	02czFWb1HaEnntM8Rkqt5mEzUnJZ/hSZqfYnoDMZnU2kSu04wIvKsk2BpKPn9zNa
	G3r5Jw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yf23srnwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 05:11:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44V5BAs2022628
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 05:11:10 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 30 May
 2024 22:11:08 -0700
Message-ID: <af326e49-df6e-4574-9562-44b6aee10abd@quicinc.com>
Date: Fri, 31 May 2024 13:11:07 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] wifi: ath12k: support ARP and NS offload
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240530072714.25671-1-quic_bqiang@quicinc.com>
 <20240530072714.25671-7-quic_bqiang@quicinc.com>
 <ccf9791b-e050-4844-8c37-35873fb3fcaf@quicinc.com>
 <17721436-19fb-4337-9058-b20f4df2792c@quicinc.com>
Content-Language: en-US
In-Reply-To: <17721436-19fb-4337-9058-b20f4df2792c@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5B30odrmLO89knAp3LjqpGLKlYrgBSDq
X-Proofpoint-GUID: 5B30odrmLO89knAp3LjqpGLKlYrgBSDq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_02,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxlogscore=848 bulkscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310038



On 5/31/2024 11:42 AM, Baochen Qiang wrote:
>>> +static void ath12k_wow_prepare_ns_offload(struct ath12k_vif *arvif,
>>> +					  struct wmi_arp_ns_offload_arg *offload)
>>> +{
>>> +	struct inet6_dev *idev = arvif->idev;
>> as noted above does it make more sense to get the netdev associated with the
>> arvif and then use in6_dev_get(net_device) to get the inet6_dev rather than
>> caching the pointer from the ipv6_addr_changed() callback?
> Ah.. I didn't note that we can get inet6_dev in such a way, just thought the only way is to cache it in ipv6_changed() callback.
> 
> will get it using the following in next version:
> 	struct ieee80211_vif *vif = container_of(arvif)
> 	struct ieee80211_sub_if_data *sub_if_data = container_of(vif)
> 	struct net_dev *ndev = sub_if_data->dev
> 	struct inet6_dev *idev = in6_dev_get(ndev)
Just found that ieee80211_sub_if_data is internal to mac80211, so not possible to get netdev in this way.

any other ideas on how to get netdev?

