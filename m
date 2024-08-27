Return-Path: <linux-wireless+bounces-12095-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB9B96173D
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 20:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47247B21155
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 18:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893CE45024;
	Tue, 27 Aug 2024 18:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Gfz7ewBl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD777132132
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 18:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724784523; cv=none; b=K4ytV8JvA6w3gQFvxasOG/XKs10lTuI7VxMt6Vb8KCt5796NuQ4iHqE2dNfW1fZw2zQK25Kl68PNKztdQbAvlBf+ZJG6se5z9IIqOs/D3CKNHWFLmjAk+2jFbcRjF0euL8+ZkMQ0PZ2nPMdeXscNGrlZZ+NhLJz28mm4shhxJbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724784523; c=relaxed/simple;
	bh=BrEpEOFknckpjCxEaj/ZzCi91hRh/me8XraHmxwy6wA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BjGO5fX+RAGI2mGsffoXr9wZRyF0wdZ4D/zLbwcVGjJLV50nwmzm8GWz0LNlguT1Lqt+54GGhy/IgUoivCxnlEcyjl8C88Flbei4h7sqA9JXh0YYScgznZ38MyPNfaXNIYeFa0bHuvmlc7SkBSjIV9P+C5Bfm0UKfEyA6cB0G9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Gfz7ewBl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RHX7UM023264;
	Tue, 27 Aug 2024 18:48:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gNU4rqliR5B7JxY5YTo6GdKCJv+31/fAmEb/+LN6pBE=; b=Gfz7ewBlEOy2i0hN
	88DTaEpqPYax+pGEn76M2+eYKF/PWYttGEkB5hCHKfHWQJE4raHAIAnWCvJYbhRY
	OHBrlQ1HqKH6mVrv7/NSZarW/yxHBqjUG+LjbgkcxlN3x47RlCHusHy6RMi43Ss3
	ApTOP3vKSqqrp4vMueCX8dxrQTs1DVAXY1n1UTFYCGFuSoZmsWYryFxoWAQjCe4u
	+jrEhHgGgoA8LDX2fB0AVl/kyUVav4Akk3jq1KTPjoEzXHCnFNFmtOTrxqxFUj4O
	OSFE+KTuLDE6mZowiDrGMm+U+FrPlIMDhLjwiz8b3k36TdofmXFkpgwTFkvTxKZd
	37lzUw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41798101fh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 18:48:37 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47RImaxE005313
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 18:48:36 GMT
Received: from [10.50.6.47] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 27 Aug
 2024 11:48:35 -0700
Message-ID: <72162987-a145-4295-a15f-b0bc2f05545a@quicinc.com>
Date: Wed, 28 Aug 2024 00:18:32 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 2/2] wifi: mac80211: Add support for link
 reconfigure removal
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240807034521.2091751-1-quic_mdharane@quicinc.com>
 <20240807034521.2091751-3-quic_mdharane@quicinc.com>
 <b188dadd82f72a2a8ef98b4d944d2b7fa87eebd6.camel@sipsolutions.net>
From: Manish Dharanenthiran <quic_mdharane@quicinc.com>
In-Reply-To: <b188dadd82f72a2a8ef98b4d944d2b7fa87eebd6.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FLz9Bdn0E2Xt5RUTS6ailFF201yahmBZ
X-Proofpoint-ORIG-GUID: FLz9Bdn0E2Xt5RUTS6ailFF201yahmBZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_10,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 mlxlogscore=768 spamscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 phishscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408270141



On 8/21/2024 2:28 PM, Johannes Berg wrote:
> On Wed, 2024-08-07 at 09:15 +0530, Manish Dharanenthiran wrote:
>>
>> +/* Defines for ML Reconfigure removal offload */
> 
> Not really "defines", but whatever? Is there value in this comment
> anyway though? Don't see how it adds much.
> 
Will modify accordingly in upcoming version.

>> +/**
>> + * ieee80211_update_link_reconfig_remove_update - Inform userspace about
>> + * the removal status of link which is scheduled for removal
>> + * @vif: interface in which reconfig removal status is received.
>> + * @link_id: Link which is undergoing removal
>> + * @tbtt_count: Current tbtt_count to be updated.
>> + * @tsf: Beacon's timestamp value
>> + * @cmd: Inform started or completed action to userspace
>> + *
>> + * For description, check cfg80211_link_reconfig_remove_update
>> + */
>> +int ieee80211_update_link_reconfig_remove_update(struct ieee80211_vif *vif,
>> +						 unsigned int link_id,
>> +						 u32 tbtt_count, u64 tsf,
>> +						 enum nl80211_commands cmd);
> 
> And anyway this is a trivial wrapper, why not make it so the cfg80211
> API takes the wdev, and then just call it directly in the driver with
> ieee80211_vif_to_wdev(), or have a trivial inline? No reason to have the
> iftype check in mac80211 either, that can be in cfg80211 and/or drivers?
> 
Sure, will address this in upcoming version.

> Other than that it looks OK I guess, but I do wonder if you've actually
> tested further than that?
> Yes, have tested this along with the driver changes. But, as you 
mentioned it needs further more changes to make this work in real time. 
Will update all the changes in next version as a patch series.

> It seems to me that ieee80211_del_link_station() is somewhat broken when
> you remove the deflink from the STA, since we'll continue using data
> from there?
> 
Yes, link sta delete has to be handled where we would move the deflink 
sta to next valid link, if its available.

> johannes

Thanks Johannes for the review. Will incorporate the comments given in 
this RFC, also add the other necessary changes which are tested and 
update them as patch series.

Regards
Manish Dharanenthiran

