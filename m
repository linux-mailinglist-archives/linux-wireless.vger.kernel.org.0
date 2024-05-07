Return-Path: <linux-wireless+bounces-7298-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DDF8BEAD2
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 19:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B2B9285BB1
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 17:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96122E570;
	Tue,  7 May 2024 17:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NFIHYhft"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B837462
	for <linux-wireless@vger.kernel.org>; Tue,  7 May 2024 17:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715104201; cv=none; b=ur+AGIGHldshnQ8bYAuZRnt2Ymt3u2U2xSiXsLQVL9/RVLPBbvQa0KFSEQNrZHvtMUklcM+ytc0EhGRjJ5vUh6PKMv25TA6lt+f/I3bXn+o+1sMUGJ/auUjo7F4Ie9woiJiKlMhLKEB2Htv1AMbwhzIoGKPfxCI8mUSRvKcltVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715104201; c=relaxed/simple;
	bh=CU+pdJj2x1GnxLNKndOBCjeUEScMYfjaV2/y0gDeYu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QZp6TZ0OgLSunpL+IMhrn3eaVivFHlzYX6nP9FsFCmmpwptyxC8NbKzq5UtjYcmFcACUOBK/iJW9pu3WUKH2NuluQt4cDKI322LUUPaUWjhIypY9dWH985yN7Qe02kd84nLJosA8c9iyaI/ejHZrMuwH0daBxhNYbpSlUTI1RrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NFIHYhft; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 447EQp0n025144;
	Tue, 7 May 2024 17:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=OBkfIof8ByzTgdHLZRwZMDneNRnZ7I14Vjy/IR4YdKA=; b=NF
	IHYhftFdyh+qNmyt/9yyQw+guYaybXNHdAj4INyJb6bflRxMxbOWkYy7v0GQXPCE
	RvX58+3aayTvmutG1O9GHR+ESrZ+pJi//3ABoXwdZCESamJkcsxOhAeocbnqsua+
	Jlyg2GzV+DbFirwGrHTvW9UY3OUvoc4xiwX/mg7GogKBNrlHL9PaHH/jEI26cWHm
	BjR4UwwuH1Foo5uyuU4WREkIR2Zt6PwUgrmVCefYOxiuvmCTCZOX1jz2K9LNCgXJ
	F33cdUwD0I7n1GXf/AR9zZAjs5E0PsG9P7Hc7j5uYSgmmqHpvs/17vEcLVWQvL4c
	3czAm46o+QeVpImp0cKw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xyp2frjq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 17:49:55 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 447Hnsar008787
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 May 2024 17:49:54 GMT
Received: from [10.216.56.31] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 7 May 2024
 10:49:53 -0700
Message-ID: <3e40056e-4e32-86dd-4d1c-ab5d6c19d94f@quicinc.com>
Date: Tue, 7 May 2024 23:19:48 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC v2 0/2] wifi: nl80211/mac80211 Handle BSS critical update
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240403162225.3096228-1-quic_rrchinan@quicinc.com>
 <226dad2f0736d9b5c3313943dce93f57cb6f4b2a.camel@sipsolutions.net>
From: Rathees Kumar R Chinannan <quic_rrchinan@quicinc.com>
In-Reply-To: <226dad2f0736d9b5c3313943dce93f57cb6f4b2a.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UWGd4gh8dS1LEroaJH8vhek2Zz9ieoX8
X-Proofpoint-ORIG-GUID: UWGd4gh8dS1LEroaJH8vhek2Zz9ieoX8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_10,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2405070123



On 5/3/2024 2:57 PM, Johannes Berg wrote:
> On Wed, 2024-04-03 at 21:52 +0530, Rathees Kumar R Chinannan wrote:
>> When a critical update occurs to any of elements inside beacon frame, AP
>> shall increment BSS Parameters Change Count(BPCC) subfield and set the
>> Critical Update flag subfield of the Capability Information to notify
>> client that the critical update occurred on AP. Refer section "35.3.10
>> BSS parameter critical update procedure" on IEEE P802.11be D4.0 for
>> details.
>>
>> On beacon offload case, change in CU parameters should be sent to user
>> space either before or along with probe or assoc request frame receive
>> to ensure that user space uses latest CU values and BPCC while generating
>> response to the received frames. So, add the critical update parameters
>> as a new attribute to existing NL80211_CMD_FRAME command instead of
>> sending this on a separate NL80211 event.
>>
>> Add an ieee80211_critical_update() API to send the parameters to cfg80211
>> and call it when event received from firmware to update critical
>> parameters to user space.
> 
> Somewhat more conceptually, I wonder if we should really handle this
> hybrid approach? You're offloading the beacon updates, why not offload
> the probe/assoc response cases as well? Are they really _that_ much more
> complex? What does the hostapd code for this look like?
> 
> 
> Also, as we already discussed, this is fundamentally racy today, and
> that cannot be fixed unless you really put it all into the firmware,
> directly in the TX path, which is probably never going to happen.
> 
> So under the assumption that it already *is* racy, I'm not entirely sure
> I see where this is needed at all?
> 
> You're basically handling two (kinds of) values here:
> 
>   1a) CSA counters: these are today handled in mac80211, and we've
>       already decided that we need to handle them also in mac80211 (and
>       get offsets to the partner links from hostapd a la
>       NL80211_ATTR_CSA_C_OFFSETS_TX).
>       Yeah this is still racy, but you can't fix that without offloading
>       it all anyway.
> 
>   1b) BCCA counters: these are missing today, but that should be fixed,
>       and then it's just the same as 1a.
> 
>   2) BSS parameter change count and critical update flag: are these
>      really actually completely by the firmware? I'm not sure how that's
>      necessary, since hostapd initiates all the relevant operations? So
>      not sure why you need these at all, couldn't hostapd track this and
>      you just copy it across to the other links?
> 
> So for 1a/1b I don't even think we should push this to hostapd, it's not
> necessary and it will just cause more API fragmentation, because already
> *know* that we have to do things like NL80211_ATTR_CSA_C_OFFSETS_TX for
> other devices (and hwsim) for this, just more complex.
> 
> Thus, I don't think this is right. We can handle your case the same way,
> and you don't even need the NL80211_EXT_FEATURE_CRITICAL_UPDATE_OFFLOAD
> flag right now, by just pushing the offsets into the kernel and handling
> the values coming from the firmware by filling in at the right offsets.
> Could perhaps get the offsets down into the driver and do it there, or
> just handle it in mac80211, not sure.
> 
> But this then doesn't fragment the API here, because hostapd will just
> give all the offsets, and the below stack (mac80211/driver/fw/hwsim)
> will fill the values.
>
In case of MBSSID configuration, hostapd has to provide multiple offsets 
to update these counters on BMLE per-STA profile for each non-TX MBSSID 
profile when CSA/BCCA triggered on any of partner links.

To avoid providing multiple offsets, this approach is used to pass the 
counter values to hostapd and use it while generating the probe/assoc 
response frame.

> Not sure about the BPCC and critical update flag, but let's think about
> how that would be handled on other hardware? It feels to me right now
> that hostapd should already be in control and know this, and not need
> any indications (it does control all links), but maybe I'm wrong (or
> there's just some extra case the firmware might do) and it doesn't, but
Yes, firmware is handling some extra cases and maintain synchronization 
among partner links and it maintains BPCC value and set/clear critical 
flag based on TBTT timer. Hence we are passing these values also to user 
space.

> then let's also consider how that would be handled in other hardware (or
> think about hwsim instead), and find API that doesn't fragment so much.
>


Sure, will check this.

> Yes we'll always fragment whether or not the partner link beacons need
> updating, but it shouldn't need all those different paths for everything
> else too.
>


> johannes

