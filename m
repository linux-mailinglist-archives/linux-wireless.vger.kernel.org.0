Return-Path: <linux-wireless+bounces-2814-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20427842673
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 14:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51AAC1C235C0
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 13:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8240E6D1B3;
	Tue, 30 Jan 2024 13:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LyJocDZD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C638C6773D
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 13:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706622653; cv=none; b=hXuSX894cMMJ/ePzq0bYW8yJA/VOZL+KY4Fs6vITLPMrDCKp8dK2aKsW/pzZV85nFlTd0Z4kWIn24ZdONpeL3foODyJzAh7GpnhQFmQNUgwCPepJebK4MfU7clbAhNSU7g7lak1lZp59a12EfUDKcPddmUNpN/pYFQtV3yNVjLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706622653; c=relaxed/simple;
	bh=ME/BkuwGbTDCUN4SGRKSqJkOMbUmI2Az00AzabOUqRY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=rXq+Nq79/TltZxtsMDSvxIFZcld7hKN8umH2T8eq4Mg0VhpjpeeYuIXwI/N3fWLbQdR1X7Oenb3nKq4NnBisWmPGwRt8r1E6nNC1ZzVf9W0zLmODtndTjw6oYxbJyXdtZg8wAfEvWJgoA8rnFFyydgm/kq8A/48Xwib9XLiXIuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LyJocDZD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U9S9qE013276;
	Tue, 30 Jan 2024 13:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=gcvI2OKg2OQAxx+/CmjyLsbgw12qphJLO9D1f4ZUWWU=; b=Ly
	JocDZDcav0MfDJhcQaVMbEc5qPDjKDkplyfjYduhtU2riHNZa2j9XB7qa4P41Vet
	2gpxMLY04iD/CBGe1J0Fx1fXdSFF7xqUKgWBywKgRfExKmNGEabpCGlyPWy4ipTU
	6nIQZKKDW4suA9D+2zqJg6WfjChCpUxYXwAH3sPImzRHKc/oOX5jYVUzP0P4T+p1
	6SATFaBAzuuk1I6yTkz+uSCbpRPYqUT32K9VjPQaaMGk1OiZYhg3A0kD4RH9jpmK
	MNlgviS/cfZdPLc6MkI/VzzDet2OCgAFdBov1LNe+f8Vkzr7fH2DJK6jDf6Qm+Xm
	D1c6lpsCdjMEg15QbTag==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxvve0rqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 13:50:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40UDojrm005824
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 13:50:45 GMT
Received: from [10.216.2.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 30 Jan
 2024 05:50:44 -0800
Message-ID: <3b37b302-aaf5-421c-af70-288aa8256685@quicinc.com>
Date: Tue, 30 Jan 2024 19:20:44 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/5] wifi: mac80211: handle set csa/after_csa beacon on
 per link basis
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240130043225.942202-1-quic_adisi@quicinc.com>
 <20240130043225.942202-4-quic_adisi@quicinc.com>
 <1e73c061653abf8e5f1671ae026e0905b2fb4ded.camel@sipsolutions.net>
 <55d1aea6-8721-4774-9f09-549245461ba8@quicinc.com>
In-Reply-To: <55d1aea6-8721-4774-9f09-549245461ba8@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jFU5lEOmVMmfXNfae1rRcl4rRPlZTAw4
X-Proofpoint-ORIG-GUID: jFU5lEOmVMmfXNfae1rRcl4rRPlZTAw4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_07,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxlogscore=712 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300101

On 1/30/24 16:13, Aditya Kumar Singh wrote:
> On 1/30/24 15:47, Johannes Berg wrote:
>> On Tue, 2024-01-30 at 10:02 +0530, Aditya Kumar Singh wrote:
>>> In order to support CSA with MLO, there is a need to handle the 
>>> functions
>>> ieee80211_set_csa_beacon() and ieee80211_set_after_csa_beacon() on per
>>> link basis.
>>
>> nit: "on a per link"
> 
> Will address in next version. Thanks.
> 
>>
>>> Add changes for the same.
>>
>> Is that some cultural thing?
>>
>> I always find this phrasing with "for the same" very odd, and would
>> rather say something useful such as "Implement this by passing the
>> correct link data"... but I see this a lot, hence the question.
>>
> 
> No idea :). Even I have seen these quite a few times and thought that 
> may be it is fine to use it that way. But I do agree that instead we 
> could put something useful instead. Thanks for pointing it out, I will 
> address this in next version.
> 
> 
>>> @@ -3658,7 +3659,7 @@ static int __ieee80211_csa_finalize(struct 
>>> ieee80211_link_data *link_data)
>>>       sdata->vif.bss_conf.csa_active = false;
>>> -    err = ieee80211_set_after_csa_beacon(sdata, &changed);
>>> +    err = ieee80211_set_after_csa_beacon(&sdata->deflink, &changed);
>>
>> weren't you just saying deflink shouldn't be used?
>>
> 
> Correct. This patch's aim is to form the base - basically modify the 
> helper function to accept the link data argument. But at this point, CSA 
> is not started on per link basis hence in order to keep CSA working 
> still as it is before this patch, have used deflink here. Functionality 
> wise, this patch is not bringing any change yet.
> 
> 
>>> @@ -3928,7 +3930,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, 
>>> struct net_device *dev,
>>>       if (sdata->vif.bss_conf.color_change_active)
>>>           ieee80211_color_change_abort(sdata);
>>> -    err = ieee80211_set_csa_beacon(sdata, params, &changed);
>>> +    err = ieee80211_set_csa_beacon(&sdata->deflink, params, &changed);
>>
>> dito
>>
> 
> Addressed above.
> 

Any other comments? So that I can address those and send v8

