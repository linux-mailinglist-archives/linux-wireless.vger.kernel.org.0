Return-Path: <linux-wireless+bounces-23264-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A411AC036A
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 06:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D40F04E2996
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 04:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F670189F3F;
	Thu, 22 May 2025 04:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CToADqiT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543ED7482
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 04:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747889028; cv=none; b=rh9Q9VSHjDOY5+JKGMjV+GJyTSe6NFvhevMyQvwCuvKUpUEjRzwrQRBPobhv2atEG7LB5L6GjaHxfzoSc0BiUdRlTJpTqDaIEPImw4Bod8UcScFaOFQvEOu9wMhJryxpVxuNIlf3g0ZJrmaIeDp6P95ebQyptodHt/np+6vZr98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747889028; c=relaxed/simple;
	bh=L9kACk+n5tob+SxJwyYwcgPMj3NsynmW5BCwr5zG7Uw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Wxh5ZGFtgHc2NVWMqzphMru2j9BDMfmJmoVN8+PMO51J0Mt7dKesp2tqqBBiLFgW0iTOxS9vvDl2UpmbRG1eHoiCC88wlBE5u4N2AG/ZrRkAuXk4yicTBX/HjouCIqmgbZ80WZejd37AV7vsnvSgfVREqyyL+GdnJGDut+Z1bhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CToADqiT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LHVTG0016898;
	Thu, 22 May 2025 04:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mpt39vB5W9JiunnAWmUnxtrSbWbLZS2TH3QaOAOHuKM=; b=CToADqiTfJEIQzpv
	UOK8ICNq9Ze6+1JWbn4QDvfrYNJYqDoexaBjHRwE7sfFUq4/OjjaA5Dbk8iXlKSt
	q/YBcr96ZufuJapwcsksOG6rCuSuH+yxW+UfUXyiBYeVE7QBk9LW1PX8apWXDysh
	Y3AQHHKNE7+vWQMRKbjTi9o5K6igLkcBtj4Xc8HD/7CgAWF/wlPVS2128j0Cmdl3
	jypbDatJLPAAg9eMUI2JZiUd+pKvQ+XWltKWAh+50SnWUgdbOSzBaPDuHe8etMj4
	1wVKOUiOd3nRxZi7DyEMfDhPPDgoCIImd7BkgtnaJx+TMXbiXDRZaA48lLXPi3fG
	MU5a4g==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf9w1eu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 04:43:39 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54M4hc2N023740
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 04:43:38 GMT
Received: from [10.152.201.120] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 21 May
 2025 21:43:37 -0700
Message-ID: <4bf37331-5989-4b60-8981-ed20cd79969b@quicinc.com>
Date: Thu, 22 May 2025 10:13:34 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v8 06/10] wifi: mac80211: add support to
 accumulate removed link statistics
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
 <20250515054904.1214096-7-quic_sarishar@quicinc.com>
 <7930179174c97d598a40b789abc43cb36c947dde.camel@sipsolutions.net>
 <6aca52d3-b8d1-4e71-a51c-1fb6250859c3@quicinc.com>
 <45ce63e59fbf1c49ca295f23f802c2a6eebfdfaf.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <45ce63e59fbf1c49ca295f23f802c2a6eebfdfaf.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=V9990fni c=1 sm=1 tr=0 ts=682eab7b cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=PHgHO8NltkKbnFVVFvwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: XvHmUG_dFVrMI1sE6l9QGJSdwK5Xds-E
X-Proofpoint-GUID: XvHmUG_dFVrMI1sE6l9QGJSdwK5Xds-E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA0NSBTYWx0ZWRfX27uKguFO4EMf
 gFLnX44okYu4rG5OSL7cfQGtzCZXmsU1KvfU2DoqRc1/mgJpYRpi8xJxeS1Ibio9Qg4svF1//Lh
 sz7FZ3qjjWPqzjMvfHYYIjuYMLtcjXDOknBacfwqYdFBqrxscvAdioAD1nNBpDx9YMm/IHAV6E4
 EwT923mdZnbBRKHaF4r2y/AFv92s1RskL/Ll8TNlxGl1pvNwv8DENkuxpPo2hV2XoI/nDZy/+Hk
 hJ096xNUJvJ1m4raHfo0uTJ0odbXdEyH7uEGiLrEZSPEEJuLCh+KGBFnDrasDWEXWK+6z1/ZjN8
 Eflmff3iTDZQBkZ3bvUBzAHh2RhKZ3TTDLzUH2+zNZ0INe7kZaAgt7dTZPHWyijfXTEn5lb7A79
 /YmtkQk9ix4VtoWJvyAkZktb24Nh8JAjchqqbPcWf+eT/OVk8HtclMbUbHsM6N5nH6ilvPwH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_02,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=867 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505220045

On 5/20/2025 2:10 PM, Johannes Berg wrote:
> On Thu, 2025-05-15 at 23:17 +0530, Sarika Sharma wrote:
>>
>> Looks like we can flatten them. In existing code as well we have
>> flattened and use, during sta_set_sinfo()
>>
>>           "if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_PACKETS))) {
>>                   sinfo->tx_packets = 0;
>>                   for (ac = 0; ac < IEEE80211_NUM_ACS; ac++)
>>                           sinfo->tx_packets +=
>> sta->deflink.tx_stats.packets[ac];
>>                   sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_PACKETS);
>>           } "
>>
> 
> Indeed, weird, why do we even bother counting them per AC?
> 

Currently, tx_packets and tx_bytes are maintained per AC only in mac80211.
I'm not entirely sure why this per-AC tracking was introduced, as I 
haven't come across a specific use case that justifies maintaining these 
metrics separately per AC.

I also checked to see if there are any other parameters tracking 
tx_packets and tx_bytes, but couldn't find any.

Would you like me to consolidate tx_packets and tx_bytes instead of 
maintaining them per AC?
Or should we consider this change separately as different patch?

> johannes


