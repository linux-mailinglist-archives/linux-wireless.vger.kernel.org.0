Return-Path: <linux-wireless+bounces-14106-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 124529A12F2
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 21:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0971C23890
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 19:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079C11B6D0C;
	Wed, 16 Oct 2024 19:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XtaaoLq8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA4D2141A1
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 19:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729108261; cv=none; b=cju/19UCnqYK8uEZB7S3hs2nCrl1dKyfiJm8EEu95XvrE1ZLyz5ZD3znIpELCbI9cucQb9GWoYfdwQi8pZbvBtq1M4X02ylJW8KVyE3n06nErNv859pqfWOEjS2W3Tt69GF0bHaaqixLxVM3ZAnP5F2TtpACJlixXsy0P54SZZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729108261; c=relaxed/simple;
	bh=1cZZk+X7VKmRM+L9OFTzLLhDM09vGTvDB25tOAxG7b8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FWhyGZGIemCRu99Nwj0hdcTzToF5kWqTO/bA/auXBAtJMZqp9jjx/lMVk0AbvytTtAAfsmCjh8XfxAfdbupvUMOGvt7oVoP0CQvSlotjlPozOK8vwNIG/PPjzUPHC+ty+hAKJz3Zz7Rr4brKlrA6PKniAwu7hCxkkMe9FHoufgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XtaaoLq8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GGIojX015580;
	Wed, 16 Oct 2024 19:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b5P7jFx6vlCx4x+7QmNcxFyDbKAkYvKINxSpzc59pwk=; b=XtaaoLq8mXcBPZyn
	Grj2oqCeO89iDix+frfS6hO6CPBtcOEUSD5VSidy1qx2QOMwlJ98j+yai7E3FQeu
	FgxeuLqhjbsEJCxynPUoWqJ3xB5QP5f6Q0PaCqMfzCdr25mzfY4LSPROfWF2CjrA
	OvdIr9JeL1nKSKOUuCaVzV2avxgwc7rHciit8pFkhheld3TqAplI0/f0ZrWOfNvf
	2kv3boLocpp0/Cab3dEn7CsyAfwvSVGDSJ/MIIh4CzWM/eafyhXxgTMGnyM4FH5U
	yGFjtNdLZJSeQwp58IHdn3gjyh57Ao6SQ9EfhWpoC01u0vVCxDWGrqQCrdOBPpt2
	VkdIEg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42a79hafmm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 19:50:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49GJorND011731
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 19:50:53 GMT
Received: from [10.110.80.27] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 16 Oct
 2024 12:50:53 -0700
Message-ID: <559c2b6e-23d8-41d5-ba4d-262ab996dad6@quicinc.com>
Date: Wed, 16 Oct 2024 12:50:35 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: nl80211: add link id of transmitted profile for
 MLO MBSSID
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>,
        Aloka Dixit <quic_alokad@quicinc.com>
References: <20240910204538.4077640-1-quic_msinada@quicinc.com>
 <20240910204538.4077640-2-quic_msinada@quicinc.com>
 <5673aab17fa4e6bbba5b286f29b0558726305155.camel@sipsolutions.net>
Content-Language: en-GB
From: Muna Sinada <quic_msinada@quicinc.com>
In-Reply-To: <5673aab17fa4e6bbba5b286f29b0558726305155.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iOU0odqduEkEC1Irr4gq-5XuPVQcbCib
X-Proofpoint-ORIG-GUID: iOU0odqduEkEC1Irr4gq-5XuPVQcbCib
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=975 suspectscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410160125

On 9/11/2024 2:36 AM, Johannes Berg wrote:
> On Tue, 2024-09-10 at 13:45 -0700, Muna Sinada wrote:
>>  	if (!wiphy->mbssid_max_interfaces)
>>  		return -EOPNOTSUPP;
>> @@ -5509,9 +5513,7 @@ static int nl80211_parse_mbssid_config(struct wiphy *wiphy,
>>  			return -EINVAL;
>>  
>>  		if (tx_ifindex != dev->ifindex) {
>> -			struct net_device *tx_netdev =
>> -				dev_get_by_index(wiphy_net(wiphy), tx_ifindex);
>> -
>> +			tx_netdev = dev_get_by_index(wiphy_net(wiphy), tx_ifindex);
>>  			if (!tx_netdev || !tx_netdev->ieee80211_ptr ||
>>  			    tx_netdev->ieee80211_ptr->wiphy != wiphy ||
>>  			    tx_netdev->ieee80211_ptr->iftype !=
>> @@ -5530,7 +5532,28 @@ static int nl80211_parse_mbssid_config(struct wiphy *wiphy,
>>  		return -EINVAL;
>>  	}
>>  
>> +	config->tx_link_id = 0;
>> +	if (config->tx_wdev->valid_links) {
>> +		if (!tb[NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID])
>> +			goto err;
>> +
>> +		config->tx_link_id = nla_get_u8(tb[NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID]);
>> +		if (!(config->tx_wdev->valid_links & BIT(config->tx_link_id))) {
>> +			err = -ENOLINK;
>> +			goto err;
>> +		}
>> +	} else if (tb[NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID]) {
>> +		goto err;
>> +	}
>> +
>>  	return 0;
>> +
>> +err:
>> +	if (tx_netdev) {
>> +		config->tx_wdev = NULL;
>> +		dev_put(tx_netdev);
>> +	}
> 
> Why not use config->tx_wdev and avoid changes around tx_netdev?

tx_netdev instance is being utilized on exisiting code to perform checks and grab its ieee80211_ptr. W are not making changes to tx_netdev itself. In this specific patch we are making changes to config->tx_wdev. I was wondering if I could get clarification on this. 

> 
> There's also an existing error path that does dev_put(), so you should
> unify that.
> 
> johannes

Thank you,
Muna

