Return-Path: <linux-wireless+bounces-8337-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9FB8D5926
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 05:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77801287DE7
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 03:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1597EEBA;
	Fri, 31 May 2024 03:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R2v7YZ/o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CC5D51E
	for <linux-wireless@vger.kernel.org>; Fri, 31 May 2024 03:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717127407; cv=none; b=MJApP9Y2XGCA7fL27hrCLiI2/69PTy7RUjvqqCYKVxPik5vfp6WUGyR9trbK4ihk0gCk7ojdKIqJnfYxipymdrtBlXV6P7rtvGAIPnN58lQWHRgAWDkPL1KTwcZbghAHEQuUbHxX6J//v2gKT1ShnnY2xIbxlKSL9A0ZL6ujA0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717127407; c=relaxed/simple;
	bh=L8NgzMntyh1jFKK9OV2AsJh0ukdtoLcCo+maqPycnpg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=KTz1lUabY52pH5us3kznpRheQ1skLxqZ1lPZxoqtvhBNKSGc3U+xiT0kS7ppshwfDpMnzH/38q5s/kkMkKNhLhL6GiJtJz71auee9xjndzZ4Ef8r7VCaCyI8c09eSz7Ukmh1tcoeUXn1N+17ipD/65Q7Q2tkd7r5KDx6KHiQ3Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R2v7YZ/o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44ULgfUj026579;
	Fri, 31 May 2024 03:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QjVXWs3TMk0YZ7HwrH6kSwG++1DjIPs5r4spHdo7hjo=; b=R2v7YZ/ogx4758OD
	1JT6mZ+Tderu80vEw9xlgOSGOjiIdSNpdeEvhngSaLWmx6hWoE0BNPlGFEBX5UXH
	1+xp73+qvxyPuKPZJdoI6NhAFPadftPZznaHa+ShANloT+A0J7/8zTzgv1TuXbC7
	mdIHsWqZ8paJFYhzLBpYOU1LiWTimToWMf+VaGuyl1ovH8GQUgD+onwo/E06FcSU
	DM4OAXjdYtAb445PHufVy1rN8UNtMX2Ad0Tee04KH2YgMdgUS9BteyDOzkZDLTQL
	B8cdeV2CXyvkpSSsVEYyY5o1Hx3seEoHcRVvkqu7Wpk42sUKbKPHvtZm6FmxUQaQ
	D2OPCg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba0qnqq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 03:50:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44V3nfC3009174
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 03:49:41 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 30 May
 2024 20:49:40 -0700
Message-ID: <a50aa1fd-14e9-469a-a98e-2475ac682f29@quicinc.com>
Date: Fri, 31 May 2024 11:49:38 +0800
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
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KXgYPZs5kYG_un0OronMHl0Sz5rMjxWZ
X-Proofpoint-ORIG-GUID: KXgYPZs5kYG_un0OronMHl0Sz5rMjxWZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_21,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=785 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310028



On 5/31/2024 11:42 AM, Baochen Qiang wrote:
>> as noted above does it make more sense to get the netdev associated with the
>> arvif and then use in6_dev_get(net_device) to get the inet6_dev rather than
>> caching the pointer from the ipv6_addr_changed() callback?
> Ah.. I didn't note that we can get inet6_dev in such a way, just thought the only way is to cache it in ipv6_changed() callback.
> 
> will get it using the following in next version:
> 	struct ieee80211_vif *vif = container_of(arvif)
sorry, should be:
	struct ieee80211_vif *vif = arvif->vif

> 	struct ieee80211_sub_if_data *sub_if_data = container_of(vif)
> 	struct net_dev *ndev = sub_if_data->dev
> 	struct inet6_dev *idev = in6_dev_get(ndev)

