Return-Path: <linux-wireless+bounces-4877-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA6387F66D
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 05:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A470E1F2256B
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 04:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E91533C8;
	Tue, 19 Mar 2024 04:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kRAzdEQd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF1A1FBA
	for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 04:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710823057; cv=none; b=FbFSCOGuvHTsBm9nV4RMwQT7tfsEJFk6ZkjMjzBQvwR8E3k5KMEcb942SEvtAHFpcGoyxkoN+OrwxPyrpELKZlNtklwAaNomdgahycYQXhf+o5VyYIcoWGRjds/5FCyvKxuH/7BgP733ZERfQgU1YCxOhsT7aKH2jihXpYBFBUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710823057; c=relaxed/simple;
	bh=XzRdZj2y+bADRs0uX0NWC0in6m8QfLDTrLsVoslIf2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ufMQifVbOb8Aw4aPh5IKvg61qmvexkPY5PzMzzheD4V85fUKfMeAMBZqpGW9rKepqbNE32rMWGIYRqMugyKTk8IgEnQ8QHBA/EVfdw+fZUhBt/XhzRvVf4KTXjBVrhd9+U5oRNUKPTsFt0SPg5eXQz1CqlQXUBhAb+19xBpOV8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kRAzdEQd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42J4MjrV015928;
	Tue, 19 Mar 2024 04:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=TQyjeqxNqBW74wMkotCXhIyLWhu7xOqMZ3jH4L2wZTo=; b=kR
	AzdEQdCzAfPhTWo2CI67LF+6pjGrE1y3c+jgjdZl1AauGtI08TbElbGkQtGApeoF
	ZvJBD4ObvCkqgf3he5F/T5xLqxBUsbslzIQVet6bIG+riSBmIBQ9Wrt+pKxx7s0p
	Okvp6uUyn/sqR8NWlt3DJ9IIqA5uva7fShkPz420l91jbaKYq1ou9nmFzTyVuAbk
	v2gjMIMpVgrjlXzMLL2c2eQyxw+vxRit0b2oLUfj4vIhok05j+SuvXrhqznIXSl5
	LDkSX7N4u2CPqI39w7r/mIbZKK7wtJzTfwTCY/q91EvpPyqitIg4HK+5VnnVgVWW
	kbwcVaK9Fn3VlZwYJb1Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wxq7p1mfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 04:37:30 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42J4bT8E025900
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 04:37:29 GMT
Received: from [10.201.203.121] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 18 Mar
 2024 21:37:28 -0700
Message-ID: <804e3864-5782-ebff-54ad-df9dacf1a400@quicinc.com>
Date: Tue, 19 Mar 2024 10:07:16 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC 0/2] Handle BSS critical update procedure for probe
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240318053607.1056739-1-quic_rrchinan@quicinc.com>
 <5cf776357daf3a612b40a38cfe0328438c90451b.camel@sipsolutions.net>
Content-Language: en-US
From: Rathees Kumar R Chinannan <quic_rrchinan@quicinc.com>
In-Reply-To: <5cf776357daf3a612b40a38cfe0328438c90451b.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cS-6kAC89YDSRzeFjeYcQPWj5tn0jOhO
X-Proofpoint-ORIG-GUID: cS-6kAC89YDSRzeFjeYcQPWj5tn0jOhO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 mlxlogscore=949 lowpriorityscore=0 suspectscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190034

Hi Johannes,

FW is doing the below additional changes on beacon, that requires to get 
the critical and BPCC values from FW.

1. Host driver sets critical bit on beacon template WMI command in 
impacted link, but FW is taking care of synchronization among partner 
links like updating critical bits and BPCC on partner link BMLE perSTA 
profile.
If hostapd and mac80211 does CU and BPCC count changes on beacons,
then synchronization of the same across links is cumbersome since FW 
knows when next beacon on partner link will be sent.
After sending beacon template, host is not aware of when actually the 
beacon sent out with updated critical/BPCC values on all links
and if probe/assoc request frame received in between time,  hostapd 
generated probe/assoc response frame could have different
values compared to that of values in beacon. To avoid this issue, these 
values are obtained from FW.

2. In some cases like Target Wake Time (TWT), FW will add TWT element IE 
on beacon and it is a critical update that hostapd is not aware of.

3. Critical bit should be cleared after DTIM interval and currently 
hostapd is not running any timer for DTIM period to clear these flags.

4. In case of Channel switch /BSS color code change, kernel should have 
switch counts, but hostapd has to provide multiple offsets to update
the count on CSA/BCCA element added on BMLE perSTA profile of partner 
links and RNR element. To avoid adding multiple offsets , these values
are passed to hostapd.

Thanks,
Rathees Kumar

On 3/18/2024 3:25 PM, Johannes Berg wrote:
> On Mon, 2024-03-18 at 11:06 +0530, Rathees Kumar R Chinannan wrote:
>>
>> Add an ieee80211_critical_update() API to send the parameters to cfg80211
>> and call it when event received from firmware to update critical
>> parameters to user space.
>>
> 
> I'm confused, _why_? What does the firmware do that changes the beacon
> that doesn't _already_ need hostapd to know about it?!
> 
> johannes

