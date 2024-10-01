Return-Path: <linux-wireless+bounces-13358-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F2F98B5DF
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 09:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82481F22014
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 07:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA9F1BE239;
	Tue,  1 Oct 2024 07:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a5IPkuJX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6F11BE87D
	for <linux-wireless@vger.kernel.org>; Tue,  1 Oct 2024 07:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727768268; cv=none; b=iaTngAEqm9rYEee7eEJ1BLzERheMh11w0399nzO8A6WpOtNjo3BhV47+yncPJp9kg9V3idjqUgZ4MDStwNiWlEQSVJm22iwakzuKXTDVOd1VgDy03ih7PQgitmrDAih2DtC0w4dG6Iy9q0fDRlYov6OGyEDssYnkfNEYJAzDkGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727768268; c=relaxed/simple;
	bh=iJmhxEzTmS87nu971FcnGbNo8hKIic6Y07LX8sDt3rQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JnnWLUiiZL3kXn1gZinzHr/u0VxoVLaztxk5fZciHA8ki+eL1EKXNhSTSuOADgRtc1k2dlDvkgXGVvctPsr+lAVRX4JVzuLXrDU9wzUZXp/StENXIZwo1mCUE9A95B3Sj5FCXWHGx/ThJBNQiYhL3MbrWHO4SgZYuHShpLSWiB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a5IPkuJX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4911Qi7B001965;
	Tue, 1 Oct 2024 07:37:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U1L6zDyJJ5aRxsDPMlRN5N+LdZjElwdZMnDh218SWhU=; b=a5IPkuJXez6QWsPt
	AkO7H6wwkGIxhMM21hGbbsTMs/WiO6CNoPw9Vh5W/BVr71UXC+a4ezy32RL61m6W
	l3L3JWdwlmltHsn6B006dByrL6JhM5cM6gOQRI/zwd4uQew/eWQHiy30S2rzny49
	CWUcu7fk9tUkJJUK1pC1ow35EMD3AYw2kx+lS77vzbLm40WPQjmcbpuaGh9vW7d6
	1JGebOFENQLAkqFNH1dic5bZBclggWpoo14SQVaABcnKjENlSiX51bcC2nYECYy8
	pMt/48c4Wuir/tQ8SQqa+iGgMV2bLtSb+KlR+Gk1JuzA2pWHMpfgiItQrqp04uns
	/Wk2fA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41x7ge7jyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 07:37:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4917bdov029736
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Oct 2024 07:37:39 GMT
Received: from [10.152.202.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 1 Oct 2024
 00:37:37 -0700
Message-ID: <5fe9fdf2-ae5c-4d15-a095-0203a814e4ba@quicinc.com>
Date: Tue, 1 Oct 2024 13:07:34 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: fix assigning channel in activate links
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>
References: <20241001041518.2236297-1-quic_adisi@quicinc.com>
 <0353d31db76afbd5d9bb2e7d42246ae3c8e14044.camel@sipsolutions.net>
 <fd731cac-7182-4de3-afd4-0fc5892a9440@quicinc.com>
 <c103db90ed53a75cae10baba0ae52dae85bf1c3f.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <c103db90ed53a75cae10baba0ae52dae85bf1c3f.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PQJwDVaSsyHlzYqx2dKvA8WamPyLlSsg
X-Proofpoint-GUID: PQJwDVaSsyHlzYqx2dKvA8WamPyLlSsg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010051

On 10/1/24 12:52, Johannes Berg wrote:
> But that doesn't explain the*comment*, which literally says:
> 
>     inform about the link info changed parameters after all stations are
>     also added
> 
> but you
>   (a) don't add stations here
>   (b) if you're thinking about link stations, the link stations are
>       only added_after_  this comment and the link info change ...
> 

Oops! my bad. Previously I was thinking like this -

First iterate and do only _ieee80211_link_use_channel() this part. Then 
let the flow as usual and after stations are added, do the 
link_info_changed() part.


> 
>> Later, in the loop for_each_set_bit(link_id, &add,
>> IEEE80211_MLD_MAX_NUM_LINKS), channels are added. At this stage, the
>> driver will actually create the link on the interface at its own level.
>> Since here using the channel information, appropriate firmware can be
>> picked. For example 2 GHz or 5 GHz or 6 GHz firmware.
> Picking "firmware" sounds very odd here, I'd say you mean "which device
> to pick"?

:) Yeah.

> 
>> hmm... yeah true that. May be I will move this once the old links are
>> removed?
>>
> I'd think at least that?
> 
> But also this seems to break out driver for other reasons, because it
> initializes rate control somewhere here and needs a station for that.
> Didn't look deeply into that yet though.

Okay so doing as I said above could work -

if (add) {
	...
}

for_each_set_bit(link_id, &rem, ..) {
	...
}

for_each_set_bit(link_id, &add ...) {
	_ieee80211_link_use_channel()
}

list_for_each_entry(sta, &local->sta_list, list) {
	...
}

...

for_each_set_bit(link_id, &add ....) {
	now call
	ieee80211_mgd_set_link_qos_params()
	ieee80211_link_info_change_notify()
}

...


At least I tried both of these ways in hwsim. I dont see any failures. 
Hence I thought why not move whole for loop to top instead.


-- 
Aditya


