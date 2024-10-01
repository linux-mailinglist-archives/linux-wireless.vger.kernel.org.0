Return-Path: <linux-wireless+bounces-13360-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A890898B6E5
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 10:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6680D2819EA
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 08:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F7719ABCE;
	Tue,  1 Oct 2024 08:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UkGooiqP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EA619A28B
	for <linux-wireless@vger.kernel.org>; Tue,  1 Oct 2024 08:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727771227; cv=none; b=fhmiC05m/ySn7JTFSBBVGUwM9GwaTNFwXQJPpqNGNPCy7PaVmZ0gGxTZEo105iNEpiQQsryofRGjAHHn98r8HhbGHqZrqzAyR26YIC4vqi2Kb3OnCuM8Qi0NfzS/OQ5pkh8qdrkEiX0KwjDZaFxUWYwFGMxoc/U0qWzVaCZMxOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727771227; c=relaxed/simple;
	bh=VocEHIqqNoXYr8tL4D0vYg4LOsrqfMXwwWAHBJFjzOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Q+k4hdOxOgfCPeMm3q4BzA3kNqEDcSFyhaMin0n72O1PGefe+sTAbHgAUZ617+vE1jPd6o/PlUUxCGyC51Pt6+MdyZp25IrTe3uQgMnVPKQbK+A4edLnotWrC82lrdtpfElz6ICECLVBxmYt/oAIu7O3kRzqxJ9JnXwArG3j/o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UkGooiqP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4910uluh007631;
	Tue, 1 Oct 2024 08:26:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CH9GQIBOseXMnhdBvqdrX+NJ7xR1l+eRpKDwMcGeUc0=; b=UkGooiqPhK9uoaoy
	6KmiKe3IC3VkhkieebaN1I6VnbDdrB+EnZzV8qTkOek4MKaLYRU84e7WC01LD5c6
	6wnJuTQ97XGZwN9yAWEkqeuYPL1joK04hNS3vb3zHAteMu40fZ42U5+PRieJJYli
	jGcMPtZrJ/bFvog2o9OgZvJ6HzF7XitCaDZ1zAlH18gfwq9a8sbXJ9gaO8odL6Ty
	mUoMG86nr/GU6mj/sB8rNS2h1L5tCsLPxHJb6HMdfVruaxM0Rtcqy55ic/QazOEv
	uw+h0gj/Tzb1gR4MH18+P281TYe5pygGjNBRXB2odFuyaJf1/wsW2KS36agGHpoe
	Cx1mGA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41xte0x93n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 08:26:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4918QuGn024263
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Oct 2024 08:26:56 GMT
Received: from [10.152.202.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 1 Oct 2024
 01:26:54 -0700
Message-ID: <39b73ddd-5478-4599-a92b-00b274d2ce02@quicinc.com>
Date: Tue, 1 Oct 2024 13:56:51 +0530
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
 <5fe9fdf2-ae5c-4d15-a095-0203a814e4ba@quicinc.com>
 <16ad03533ab6aca65c3fe9db94ae53ad11fdb9d1.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <16ad03533ab6aca65c3fe9db94ae53ad11fdb9d1.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QTuo6sI6QPwfrMJpGGXh4z5zewrd4ILw
X-Proofpoint-GUID: QTuo6sI6QPwfrMJpGGXh4z5zewrd4ILw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010055

On 10/1/24 13:38, Johannes Berg wrote:
> On Tue, 2024-10-01 at 13:07 +0530, Aditya Kumar Singh wrote:
>>
>> First iterate and do only _ieee80211_link_use_channel() this part. Then
>> let the flow as usual and after stations are added, do the
>> link_info_changed() part.
> 
> That would seem to make sense, it also matches assoc flow better.
> Although not sure that matters too much, since this is necessarily very
> different as it's while associated anyway.
> 
>>> But also this seems to break out driver for other reasons, because it
> 
> type - I meant "our driver"
> 
>>> initializes rate control somewhere here and needs a station for that.
>>> Didn't look deeply into that yet though.
>>
>> Okay so doing as I said above could work -
>>
>> if (add) {
>> 	...
>> }
>>
>> for_each_set_bit(link_id, &rem, ..) {
>> 	...
>> }
>>
>> for_each_set_bit(link_id, &add ...) {
>> 	_ieee80211_link_use_channel()
>> }
>>
>> list_for_each_entry(sta, &local->sta_list, list) {
>> 	...
>> }
>>
>> ...
>>
>> for_each_set_bit(link_id, &add ....) {
>> 	now call
>> 	ieee80211_mgd_set_link_qos_params()
>> 	ieee80211_link_info_change_notify()
>> }
>>
>> ...
>>
>>
>> At least I tried both of these ways in hwsim. I dont see any failures.
>> Hence I thought why not move whole for loop to top instead.
> 
> Right, I don't know - I guess I should try with our driver?
> 

Yes please that would be of great help. Let me send a next version 
having the changes as discussed above and then you could pick that for 
testing and let us know whether it is working as expected by Intel driver?

It would be better if other MLO based drivers could also test this? I 
mean if possible they could also test and let us know if this breaks any 
of their expectations! Or if not test, at least ack this change?


-- 
Aditya


