Return-Path: <linux-wireless+bounces-2458-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD77E83B854
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 04:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BD8D1C22EB4
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 03:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A041863B1;
	Thu, 25 Jan 2024 03:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="p5FFaolk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38B563AE
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jan 2024 03:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706153557; cv=none; b=sNTVegon9uxTzgoTuLwdhQQYb3Mqf2tI/xKgn8tmIGEFUbrNwDzhQPdAJYpwDcT5GDPxCRXA8m0XXfaJolX3KEM2pVhB40ku3WX/9nGvQXa1JaQv2SCpnh6jeu+nVY8RKHK5pkiHtUGEogIII/1cDFsMjLHiY/LktMtkf7uqp2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706153557; c=relaxed/simple;
	bh=Eby3zShUKexlE65u7PBm+vm1FuqGHqkUGXxjp3ikKKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YMAFitlmKwxt/aJ0rlBdJOTdpSleSfmMY88TzdLCs6WGaGg8Iioy2uFQ80rwZTqOLXhnZ5PN07v9u5aKLPOpLk3Kjr59IH642uQqwunJTDTefgTqmaCw7NPM9lz2qOGfAQaVqSAQHQo4y7WRnmtyc+sT+nYINe1mkXxzZyhd7jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=p5FFaolk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P2gcbZ007140;
	Thu, 25 Jan 2024 03:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=5yFji1GUglsu6sJmNzqNy6f/icCXhBxjlIEySdegyYo=; b=p5
	FFaolkpAUIXDhjUJ++u+u1/pZAvvAojyJajKVk5m+A4w1rqPKqjvznMtsyFl3j4S
	BK38irsUVZP40iI9ApTDSYFVrdMb7OrbN1kl54wWrrRO+0VlDbyh4/jtC4HuVLol
	igM9Q8K3vrPWv7F6xb2ul4XIHkEmrBPGucyU8MpDYz2y9q06IcT/8/cKBvhFDt65
	qzTKaQUinCOj/bBrHsPVnV/bXXcwvvcYecwB7iWnakeL0TMAnL4N/SEkF8UELg5u
	5RmyRBaUCK/moojQruaGyHUebsWmkx4/SA/6+UeHkH2sn20VylaB6vqXMB4v0O2H
	4yeKMnRwAMxMEP3XusMQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vtyxyt7m4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 03:32:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40P3WUgL026143
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 03:32:30 GMT
Received: from [10.201.207.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 24 Jan
 2024 19:32:29 -0800
Message-ID: <18811964-217f-414c-8127-80663af94402@quicinc.com>
Date: Thu, 25 Jan 2024 09:02:26 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] wifi: cfg80211: add support for link id attribute in
 NL80211_CMD_DEL_STATION
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240124132814.802018-1-quic_adisi@quicinc.com>
 <20240124132814.802018-2-quic_adisi@quicinc.com>
 <a12579b4-7596-4b1d-aa3c-133e635b7ec9@quicinc.com>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <a12579b4-7596-4b1d-aa3c-133e635b7ec9@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BNQ1xt3BNEyyHzjgY1MsGi9cv53KdZjC
X-Proofpoint-GUID: BNQ1xt3BNEyyHzjgY1MsGi9cv53KdZjC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_12,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0 mlxlogscore=759
 bulkscore=0 spamscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401250023

On 1/25/24 05:10, Jeff Johnson wrote:
> On 1/24/2024 5:28 AM, Aditya Kumar Singh wrote:
>> Currently whenever NL80211_CMD_DEL_STATION command is called without any
>> MAC address, all stations present on that interface are flushed.
>> However with MLO there is a need to flush the stations from a particular
>> link in the interface, and not from all the links associated with the MLD
>> interface.
>>
>> For example - 2 GHz and 5 GHz are part of an AP MLD. When 2 GHz BSS is
>> brought up, it sends flush command on the interface (MLD). Then eventually
> 
> "it sends": can you please clarify what "it" is
> 

Hostapd. During any BSS bring up, it sends NL80211_CMD_DEL_STATION 
without any mac address (since at that point expectation is to delete 
any stale station entries on that interface). But now with MLO, need is 
there to handle this on link basis.

>> 5 GHZ links comes up and that also sends the command on the same interface.
> 
> "that also sends": likewise what is "that"
> 

Same hostapd.

>> Now by the time 5 GHz link comes up, if any station gets connected to 2 GHz
>> link, it would be flushed while 5 GHz link is started which is wrong.
>>
>> Hence, add an option to pass link ID as well in the command so that if link
>> ID is passed, station using that passed link ID alone would be deleted
>> and others will not be removed.
>>
>> A subsequent patch would add logic to delete only the station using the
>> passed link ID.
>>
>> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
> Actual code change LGTM
Even though the current example is hostapd but the use case is at any 
time and by any user space application. If there is need to flush all 
stations (from a link), just sending NL80211_CMD_DEL_STATION  would not 
work in case of MLO.

