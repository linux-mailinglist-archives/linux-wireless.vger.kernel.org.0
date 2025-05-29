Return-Path: <linux-wireless+bounces-23493-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF82AC7C61
	for <lists+linux-wireless@lfdr.de>; Thu, 29 May 2025 13:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBE5C7B223A
	for <lists+linux-wireless@lfdr.de>; Thu, 29 May 2025 11:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0AE28DF33;
	Thu, 29 May 2025 11:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ko6wU69T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756AB1E0DE2
	for <linux-wireless@vger.kernel.org>; Thu, 29 May 2025 11:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748516750; cv=none; b=F4Wk9gIzEkXm3fqCWjSvEm4wTzOFNM9a4sMKLJCJrrRd/oQWdYEhfFoxv8liiRoM3Jw62LG21FOGvvksGjeoq15b+IQeSWEEyl/cnt4D+hJQ5DFJ1VPPLssciQGWT0gExfKRwQxsveNONSR7g0idypEscgzbo1lvciac12WVN3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748516750; c=relaxed/simple;
	bh=SnuCuecYYjZlHcD7EFWvco/tqffrLjZZYQTtsRMqyM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rnk1AeppFclmooNd7WC/G/FximZ69mby3Qe673G+peoSnoequim5//dfosIRFs1YQDirvoczQSNlyZqjs+7l0UBsQ9vcmGUdiBtnoXAYmVeyxw0vk0d5qD0KGHI4/C4PBP6bj6URZ5tP2YvC3cTs5hUzgY28wnhDOYKO30ELLpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ko6wU69T; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54T5tCRc001582;
	Thu, 29 May 2025 11:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8ZhNp2aWmqm9A1rMuB6bOOaeWn7iuTImX6GQxZTf3bY=; b=Ko6wU69Tt/2P3Uij
	hLu0Tnh0XrJDaZg7Zi6gDFasNGFJHELL1opCFI+qCIdp+jMA7EXp3X7A9fyyssa8
	udAmKofvH3ndZ1IGbM748KtreLLLKAT7UBYZEJyr2LDdlEFOgbk2XztBquf/vfCp
	mJs2wF3SWbSJXGlrgDi9Xb9FAmzwhPC5OqH8Ubnh6fVpcxzDMrtRMNpp6UnMYzZU
	QTmOheLkLET7Dbc+rzhjs02n/2AGkpT1cwGetvDDrIgMWSecxJNzw2zjW9qTWXbd
	HvPBsBIxOn9hsKFJz2+1PqqDEvbH1M9A4bxPAvTGkeQ0yA9sVLpGTMltinDavVOt
	7IYIdg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46wavky9ef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 11:05:43 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54TB5glT004480
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 11:05:42 GMT
Received: from [10.152.206.29] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 29 May
 2025 04:05:41 -0700
Message-ID: <35bb7387-6f58-4803-91b6-6b14fc07b822@quicinc.com>
Date: Thu, 29 May 2025 16:35:38 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v11 1/3] wifi: cfg80211: Add Support to Set
 RTS Threshold for each Radio
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250522053326.4139256-1-quic_rdevanat@quicinc.com>
 <20250522053326.4139256-2-quic_rdevanat@quicinc.com>
 <223cec63-39f1-47d3-8488-e3a3fbbb35de@oss.qualcomm.com>
Content-Language: en-US
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
In-Reply-To: <223cec63-39f1-47d3-8488-e3a3fbbb35de@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CpLqZxPQby1VTrwnJMzqPgk77yansUcC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDEwNyBTYWx0ZWRfX0RTKm0cuMxqp
 lVvpMlUAgQ2KKogECGJDUGhliX40qHXTgWw2aigItHXyCUHThhzLFX+n6/FYK55nt1/bnxH+KSp
 mvUSlTbqS1zd+yV9RTC6HvJ5/thk2X49qlMmCqoVlclyfe5EQTpE83QMcqsqlZSe0mm9aZCGul3
 JcL3djCXLh+nB9LQ7wKhYHfn3GC9g2hnsmA8OqJsEN44TRqLbcHzUwmimMlVHy/CEEBOZh5Tphh
 61iC7U8mk9hM+9B/O4AelmWVthGJonur5t8VZdw/upZkWQnvcdGj0+dfI/dZh+Qj8EcssRCY4DI
 SBsvlyreDVy99K/z9Rrew3TB9WVKiUP5hJlF0KballLPvAe5OBjRTrE7Qm5LpPfIyLUGfARb5u6
 7ZXDZB7IAxSji6n1Nu+C5EqMeP1qKKewk35/YhkFmIChZPHpHjR+mSPSmyB7ZF5EH2F2ELW3
X-Authority-Analysis: v=2.4 cv=fMk53Yae c=1 sm=1 tr=0 ts=68383f87 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=pcaonGjxsj-qAXlXFPIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: CpLqZxPQby1VTrwnJMzqPgk77yansUcC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_05,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 phishscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505290107



On 5/28/2025 11:17 PM, Jeff Johnson wrote:
> On 5/21/2025 10:33 PM, Roopni Devanathan wrote:
> ...
>> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
>> index fd5f79266471..4e8507649d15 100644
>> --- a/net/wireless/nl80211.c
>> +++ b/net/wireless/nl80211.c
>> @@ -854,6 +854,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
>>  	[NL80211_ATTR_MLO_RECONF_REM_LINKS] = { .type = NLA_U16 },
>>  	[NL80211_ATTR_EPCS] = { .type = NLA_FLAG },
>>  	[NL80211_ATTR_ASSOC_MLD_EXT_CAPA_OPS] = { .type = NLA_U16 },
>> +	[NL80211_ATTR_WIPHY_RADIO_INDEX] = { .type = NLA_U8 },
>>  };
>>  
>>  /* policy for the key attributes */
>> @@ -3608,6 +3609,33 @@ static int nl80211_set_channel(struct sk_buff *skb, struct genl_info *info)
>>  	return __nl80211_set_channel(rdev, netdev, info, link_id);
>>  }
>>  
>> +static int nl80211_set_wiphy_radio(struct genl_info *info,
>> +				   struct cfg80211_registered_device *rdev,
>> +				   int radio_id)
> 
> refer to prior comment about s/radio_id/radio_idx/g
> 
Noted.

>> +{
>> +	u32 rts_threshold = 0, old_rts, changed = 0;
>> +	int result;
>> +
>> +	if (!rdev->ops->set_wiphy_params)
>> +		return -EOPNOTSUPP;
>> +
>> +	if (info->attrs[NL80211_ATTR_WIPHY_RTS_THRESHOLD]) {
>> +		rts_threshold = nla_get_u32(
>> +				info->attrs[NL80211_ATTR_WIPHY_RTS_THRESHOLD]);
>> +		changed |= WIPHY_PARAM_RTS_THRESHOLD;
>> +	}
>> +
>> +	old_rts = rdev->wiphy.radio_cfg[radio_id].rts_threshold;
>> +
>> +	rdev->wiphy.radio_cfg[radio_id].rts_threshold = rts_threshold;
>> +
>> +	result = rdev_set_wiphy_params(rdev, radio_id, changed);
>> +	if (result)
>> +		rdev->wiphy.radio_cfg[radio_id].rts_threshold = old_rts;
>> +
>> +	return 0;
>> +}
>> +
>>  static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
>>  {
>>  	struct cfg80211_registered_device *rdev = NULL;
>> @@ -3617,6 +3645,7 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
>>  	struct nlattr *nl_txq_params;
>>  	u32 changed;
>>  	u8 retry_short = 0, retry_long = 0;
>> +	int radio_id = -1;
>>  	u32 frag_threshold = 0, rts_threshold = 0;
>>  	u8 coverage_class = 0;
>>  	u32 txq_limit = 0, txq_memory_limit = 0, txq_quantum = 0;
>> @@ -3670,6 +3699,19 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
>>  	if (result)
>>  		return result;
>>  
>> +	if (info->attrs[NL80211_ATTR_WIPHY_RADIO_INDEX]) {
>> +		/* Radio idx is not expected for non-multi radio wiphy */
>> +		if (rdev->wiphy.n_radio <= 0)
>> +			return -EINVAL;
>> +
>> +		radio_id = nla_get_u8(
>> +				info->attrs[NL80211_ATTR_WIPHY_RADIO_INDEX]);
>> +		if (radio_id >= rdev->wiphy.n_radio)
>> +			return -EINVAL;
>> +		else
>> +			return nl80211_set_wiphy_radio(info, rdev, radio_id);
> 
> nit: no need for else after return, so the above two lines should be just:
> 
> 		return nl80211_set_wiphy_radio(info, rdev, radio_id);
> 
Noted. Will change this in next revision.

>> +	}
>> +
>>  	if (info->attrs[NL80211_ATTR_WIPHY_TXQ_PARAMS]) {
>>  		struct ieee80211_txq_params txq_params;
>>  		struct nlattr *tb[NL80211_TXQ_ATTR_MAX + 1];
>> @@ -3879,16 +3921,26 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
>>  	if (changed) {
>>  		u8 old_retry_short, old_retry_long;
>>  		u32 old_frag_threshold, old_rts_threshold;
>> -		u8 old_coverage_class;
>> +		u8 old_coverage_class, i;
>>  		u32 old_txq_limit, old_txq_memory_limit, old_txq_quantum;
>> +		u32 *old_radio_rts_threshold;
>>  
>>  		if (!rdev->ops->set_wiphy_params)
>>  			return -EOPNOTSUPP;
>>  
>> +		old_radio_rts_threshold = kcalloc(rdev->wiphy.n_radio,
>> +						  sizeof(u32),
>> +						  GFP_KERNEL);
> 
> can't n_radio be 0 for legacy drivers, and hence this will attempt to allocate
> a zero-sized block of memory?
> 
> seems the allocation and references need to be guarded by:
> 		if (rdev->wiphy.n_radio)
> 
I agree. Will change this in next version.

>> +		if (!old_radio_rts_threshold)
>> +			return -ENOMEM;
>> +
>>  		old_retry_short = rdev->wiphy.retry_short;
>>  		old_retry_long = rdev->wiphy.retry_long;
>>  		old_frag_threshold = rdev->wiphy.frag_threshold;
>>  		old_rts_threshold = rdev->wiphy.rts_threshold;
>> +		for (i = 0 ; i < rdev->wiphy.n_radio; i++)
>> +			old_radio_rts_threshold[i] =
>> +				rdev->wiphy.radio_cfg[i].rts_threshold;
>>  		old_coverage_class = rdev->wiphy.coverage_class;
>>  		old_txq_limit = rdev->wiphy.txq_limit;
>>  		old_txq_memory_limit = rdev->wiphy.txq_memory_limit;
>> @@ -3900,8 +3952,12 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
>>  			rdev->wiphy.retry_long = retry_long;
>>  		if (changed & WIPHY_PARAM_FRAG_THRESHOLD)
>>  			rdev->wiphy.frag_threshold = frag_threshold;
>> -		if (changed & WIPHY_PARAM_RTS_THRESHOLD)
>> +		if (changed & WIPHY_PARAM_RTS_THRESHOLD) {
>>  			rdev->wiphy.rts_threshold = rts_threshold;
>> +			for (i = 0 ; i < rdev->wiphy.n_radio; i++)
>> +				rdev->wiphy.radio_cfg[i].rts_threshold =
>> +					rdev->wiphy.rts_threshold;
>> +		}
>>  		if (changed & WIPHY_PARAM_COVERAGE_CLASS)
>>  			rdev->wiphy.coverage_class = coverage_class;
>>  		if (changed & WIPHY_PARAM_TXQ_LIMIT)
>> @@ -3911,18 +3967,23 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
>>  		if (changed & WIPHY_PARAM_TXQ_QUANTUM)
>>  			rdev->wiphy.txq_quantum = txq_quantum;
>>  
>> -		result = rdev_set_wiphy_params(rdev, changed);
>> +		result = rdev_set_wiphy_params(rdev, radio_id, changed);
>>  		if (result) {
>>  			rdev->wiphy.retry_short = old_retry_short;
>>  			rdev->wiphy.retry_long = old_retry_long;
>>  			rdev->wiphy.frag_threshold = old_frag_threshold;
>>  			rdev->wiphy.rts_threshold = old_rts_threshold;
>> +			for (i = 0 ; i < rdev->wiphy.n_radio; i++)
>> +				rdev->wiphy.radio_cfg[i].rts_threshold =
>> +					old_radio_rts_threshold[i];
>>  			rdev->wiphy.coverage_class = old_coverage_class;
>>  			rdev->wiphy.txq_limit = old_txq_limit;
>>  			rdev->wiphy.txq_memory_limit = old_txq_memory_limit;
>>  			rdev->wiphy.txq_quantum = old_txq_quantum;
>> -			return result;
>>  		}
>> +
>> +		kfree(old_radio_rts_threshold);
>> +		return result;
>>  	}
>>  
>>  	return 0;

