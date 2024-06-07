Return-Path: <linux-wireless+bounces-8657-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 573C58FFB06
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 06:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088891F217BB
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 04:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116DB25761;
	Fri,  7 Jun 2024 04:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hGW5+c0F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E296A33F
	for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2024 04:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717735540; cv=none; b=rq/8ndhtx5oSqFoOwIwf1By6ROT8pRCCawW8XG7VNaaH9ZJfzfiHp8BrYZCg7hkn2HhDgi6+N8wHMJ99kCzWdQJkuHc7QCK25FGrlFv13ZY2J/jrN31+86amxnpPS5FFu+/fX1WPpiyTCcxCIoelKMVipDW/7TRy5WBLXbF85NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717735540; c=relaxed/simple;
	bh=n9PeKLAvFT3eF87KBxJhu45RaH+BPQh4ljyXTnU0ShM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aymCrVAQiFXxaXJlIVaC1rZ1w8SImcCKa2kk+tQ+FXvUwasEvCIDEdh6sgShOcGXry9x+wZfqh4Vt1hhHXK8F05c7oVheuFEjQ503J/ZaYxFBDG2CNu1H0GqgmNpdByFOw0g38I2ZusdLV1SwOQ2tkCU3vcrl0Wq2EnEYQAZj2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hGW5+c0F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4570ZdGZ010981;
	Fri, 7 Jun 2024 04:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5PEyAq+BdU4nHnqAi1NmEDH0ouwrDiB2rCOjFHclR5M=; b=hGW5+c0FgQyVwIkF
	DmZdJLqjVLEpXobCYHzII0ionk6VjNB3iHlzehD8Ime/N10LrqY9Lo5RgyrQXaNI
	kYhv9IgV+WfsV+vFUGtKnXfYSaX3/ysumdM4SVEbFPKni+VsXcrAoK4C3lALMPzX
	gqaGnrbYABDK/VvAGbAQnsmCBix0Hvtrc2PQ9HmOWdpxaXq0LWBb2QGvRQkxy5Yz
	iMGFgv6AfWmVdUN6Pmp9GWenWqD9r3Fw/5Ht/WTaI8sZ86S6WtGW4p30mBNExw1b
	WPtO2+IkqwQR8mQDUzYvsGEZa4qvwAX1dVEGQGCXQl+6z3J/zqTthwmV7SCoqbk2
	smoWYA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yjhw0wjte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 04:45:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4574jT21028927
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Jun 2024 04:45:29 GMT
Received: from [10.152.205.142] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 6 Jun 2024
 21:45:27 -0700
Message-ID: <cc9a3955-fd59-ff9b-c96b-560e620b916d@quicinc.com>
Date: Fri, 7 Jun 2024 10:15:24 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC v3 6/8] wifi: mac80211: extend ifcomb check functions for
 multi-radio
Content-Language: en-US
To: Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC: <johannes@sipsolutions.net>, <quic_adisi@quicinc.com>,
        <ath12k@lists.infradead.org>
References: <cover.386a66ec6a89750d4890f63f0d28582a52b838b5.1717696995.git-series.nbd@nbd.name>
 <bc603fc671010bb720e75881ef0e22d81ec6e2eb.1717696995.git-series.nbd@nbd.name>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <bc603fc671010bb720e75881ef0e22d81ec6e2eb.1717696995.git-series.nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6ItY3x_ooy74lsn3WaQcf7jR7Qv2Q7Uq
X-Proofpoint-GUID: 6ItY3x_ooy74lsn3WaQcf7jR7Qv2Q7Uq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_20,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=741
 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406070032



On 6/6/2024 11:37 PM, Felix Fietkau wrote:
> Add support for counting global and per-radio max/current number of
> channels, as well as checking radio-specific interface combinations.
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>   net/mac80211/cfg.c         |   7 +-
>   net/mac80211/chan.c        |  17 +++--
>   net/mac80211/ibss.c        |   2 +-
>   net/mac80211/ieee80211_i.h |   6 +-
>   net/mac80211/iface.c       |   2 +-
>   net/mac80211/util.c        | 131 +++++++++++++++++++++++++++-----------
>   6 files changed, 116 insertions(+), 49 deletions(-)
> 

...

>   
> +static u32
> +__ieee80211_get_radio_mask(struct ieee80211_sub_if_data *sdata)
> +{
> +	struct ieee80211_local *local = sdata->local;
> +	struct ieee80211_chanctx_conf *conf;
> +	struct ieee80211_link_data *link;
> +	u32 mask = 0;
> +
> +	for_each_sdata_link(local, link) {
> +		conf = rcu_dereference(link->conf->chanctx_conf);
> +		if (!conf || conf->radio_idx < 0)
> +			continue;
> +
> +		mask |= BIT(conf->radio_idx);
> +	}
> +
> +	return mask;
> +}
> +

I believe __ieee80211_get_radio_mask(sdata) should return the radio mask
used by this sdata right ?

if so, then you should not use "for_each_sdata_link(local, link)" 
because it iterate for all the sdata in the given local and give the 
radio mask. So always return all the radio (bitmap mask) used by the 
wiphy currently.

You can use either of below one

for_each_vif_active_link()

  or

for (link_id = 0; link_id < ARRAY_SIZE(sdata->link); link_id++)


> +int ieee80211_get_radio_mask(struct wiphy *wiphy, struct net_device *dev,
> +			     u32 *mask)
> +{
> +	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
> +
> +	*mask = __ieee80211_get_radio_mask(sdata);
> +
> +	return 0;
> +}
> +
> +static bool
> +ieee80211_sdata_uses_radio(struct ieee80211_sub_if_data *sdata, int radio_idx)
> +{
> +	if (radio_idx < 0)
> +		return true;
> +
> +	return __ieee80211_get_radio_mask(sdata) & BIT(radio_idx);

same here __ieee80211_get_radio_mask(sdata) usage

> +}
> +
-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

