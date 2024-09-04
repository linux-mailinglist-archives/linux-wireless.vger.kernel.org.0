Return-Path: <linux-wireless+bounces-12451-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1044896AF7A
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 05:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACFD01F25AE0
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 03:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0513355C0A;
	Wed,  4 Sep 2024 03:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nUtyybbK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635224317B
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 03:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725420831; cv=none; b=RxMvuy8+Osp4tDJxT9PlGzMe0A8M4qjlALKvIkw/Ve3YmGxiNQic71+oqwJYXuaIgjkfU6etu/CTpGm6g/JM0kcqRXJORp895S1UyHO32JV+kiws1A4wTy9upv2D7AFxQYxBh2BBTuuDUGGKl1XzpY/DqbcNyQJ9zsFwP5X6ttY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725420831; c=relaxed/simple;
	bh=PbV+YnfUOCdRoOjL+kaUu8z9vT8q2y+wGxHFEZZc30s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ue2chg8wQmQWjedo/4A1Q4QAb8HL0u67hsEPcCjRSGK+ucxVnMpgUEnqbhWznaZy9xvFUe/HItvc52cNFNYXMJ+um86wb3BV1iKeDaFj1BnsY9XfXz11EyVAuJi5cGg6ROpoBpz2p8H57n4AekGFqhYL6dAew0TA+rR3v5Pcodk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nUtyybbK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483MHPN7009070;
	Wed, 4 Sep 2024 03:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/XOi+71l1suPEy2i4K6lysLNdTzQ7AvH3OMnUliGvf4=; b=nUtyybbK5Ely0/h9
	Spb9tu4rYPNU0VNwq0MaXczZY2erVeP/qQ8VLKc5nbwFGB7icA8UqhOuZS/daEHJ
	MGGR5vuIiEt/p5qnYzHiTIPcmFRdCwdM/JlH1jMiEnAQLoa4GjaCTK1MJNxwRcEA
	Lmmm93pgFg00tEDNWX+UMBwY+6Tmk6qVc8HxK6JpMdNkCbToWuMAoL3NNbnHe3D4
	l1aoLPDJub/6GRnmCtnHWP3MpbshH0p5o05i+i6LniPZByxKkoDrD+psqgjq4DZM
	pWfiHTyrhEAHomGlBKgJpb++J1rSeG49l1TXUJya2ynT77hbpE3Y0oIHduXF5OTn
	OwrjYg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41bu8ush0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 03:33:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4843XWnS004111
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 03:33:32 GMT
Received: from [10.216.27.52] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Sep 2024
 20:33:31 -0700
Message-ID: <6446af26-4605-4f76-9c09-2d40e3919e5b@quicinc.com>
Date: Wed, 4 Sep 2024 09:03:27 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/8] wifi: mac80211: handle ieee80211_radar_detected()
 for MLO
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240902064847.2506090-1-quic_adisi@quicinc.com>
 <20240902064847.2506090-9-quic_adisi@quicinc.com>
 <807fe0b60e727ea927cb12a75f874698a1798723.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <807fe0b60e727ea927cb12a75f874698a1798723.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AF05Mi0-VUjv18qpeJscIqGGprtvUF-M
X-Proofpoint-GUID: AF05Mi0-VUjv18qpeJscIqGGprtvUF-M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_01,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 mlxscore=0 spamscore=0
 mlxlogscore=557 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040025

On 9/3/24 15:34, Johannes Berg wrote:
> On Mon, 2024-09-02 at 12:18 +0530, Aditya Kumar Singh wrote:
>>
>> @@ -3482,7 +3487,18 @@ void ieee80211_dfs_cac_cancel(struct ieee80211_local *local)
>>   		     link_id++) {
>>   			link_data = sdata_dereference(sdata->link[link_id],
>>   						      sdata);
>> -			if (!link_data)
>> +			link_conf =
>> +				rcu_dereference(sdata->vif.link_conf[link_id]);
>> +			if (!link_data || !link_conf)
>> +				continue;
> 
> Can you not use link_data->conf?

Yeah, can use. Will do so in next version.

> 
>> +			chanctx_conf =
>> +				rcu_dereference_protected(link_conf->chanctx_conf,
>> +					  lockdep_is_held(&local->hw.wiphy->mtx));
> 
> sdata_dereference or wiphy_dereference or whatever, please don't open-
> code it.
> 

Sure.


>> +			if (!chanctx_conf)
>> +				continue;
> 
> This changes the previous behaviour, is that OK?

As in? The only behavior change is previously, cac_cancel() will cancel 
all CACs going on all sdata's. However, with MLO, if let's say link X on 
MLD A detects radar, why link B on MLD Y should also cancel the radar?

> 
>> +			if (ctx && &ctx->conf != chanctx_conf)
>>   				continue;
> 
> You don't even need the check if you have this though.

Sure. Will remove.

> 
>> @@ -3491,11 +3507,6 @@ void ieee80211_dfs_cac_cancel(struct ieee80211_local *local)
>>   			if (!sdata->wdev.links[link_id].cac_started)
>>   				continue;
>>   
>> -			link_conf =
>> -				rcu_dereference(sdata->vif.link_conf[link_id]);
>> -			if (!link_conf)
>> -				continue;
> 
> Actually link_data->conf comment already applies to an earlier patch
> then, and it might be better to just remove the link_conf entirely, and
> call the link_data just "link" like in more places. That's in patch 6
> already.

Sure, will edit patch 6 first and then this.

> 
>> +static void
>> +ieee80211_radar_mark_chan_ctx_iterator(struct ieee80211_hw *hw,
>> +				       struct ieee80211_chanctx_conf *chanctx_conf,
>> +				       void *data)
>> +{
>> +	struct ieee80211_chanctx *ctx =
>> +		container_of(chanctx_conf, struct ieee80211_chanctx,
>> +			     conf);
>> +	struct ieee80211_chanctx_conf *itr_data =
>> +		(struct ieee80211_chanctx_conf *)data;
> 
> The cast isn't needed. But you don't even really need the "itr_data"
> variable since you never dereference it.

That's true but we are using it to compare it. If we don't type cast 
then pointer comparison later would be problematic right?


-- 
Aditya


