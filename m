Return-Path: <linux-wireless+bounces-24516-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E541AE9646
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 08:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B2F37A3695
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 06:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A8822D790;
	Thu, 26 Jun 2025 06:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FAt2+qbE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F2722F74A
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 06:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750919335; cv=none; b=DqJ5iOiQeui4gxWzd/apfJlKKiXdOLZKSwFUDG+vcBAtaP3pD2FyBLp5A35iQnghzPQ/AJJi2XNy5XgCDv8a1hta4zpR85CIlsbrg7kY1ADhenksUNpQyt8j1R3Na/V95s2pOWUjNH32Q9omO/N3Cd+JAR5xrMCQXueY2IICIPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750919335; c=relaxed/simple;
	bh=d8OAKH0v1j/comgryVLJo1ChKV6OfDXO2jQGDMuUY+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=r9TMuKiBGRB1AL15fvkOsAjSTRA9h4IXGITmyd79PEGriaQqGpDQgDUsb5rMg1zrcxYouErGw2RU0mghz72EAz1UWbsFWkV+Mb5N0Ct0cnhE+eJTC16WihCOvWaazZTGr0QFq+vOobKAdP+nqLG950aX4CV32ISn4SfiU+RtiAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FAt2+qbE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q0DlUr021532;
	Thu, 26 Jun 2025 06:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	58KOtDLRBcUY7cLGsKIrksz/Kzm7DQ504/bMvnS+NzI=; b=FAt2+qbEGSgEpN0j
	FG3n4yEdexy6zPQ2CVH0uCapdBMKdRmlWzPq0pFhVqzMNc0KZLh7Wk/4OoELnR0i
	A1ygxuLG14fDLzOpxGOkyrojltQ+nqfpesKw4ph/A/6Td7CRS9YAnrTslGUcXIC9
	ol22ZyzJlfJVmh/Jw3Bi+jMDwmEjD8BQ4+BW6yDEREnrFEXXSSZF4caOa2A+HsPb
	FG019fQuKp958wDJkjRubWhCDBPRlIHLQk7XRYE1iUgMVDy9FjMpKwEd+5j/Q3i4
	zLs0WZsBBaSYjG6aqIAGdd6DvUYMNC12u2u2vvmcHlbQLD67Uk0xXhq3WVHlIKkc
	pBwsMQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47fdfx0gdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 06:28:45 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55Q6SiZ4030295
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 06:28:44 GMT
Received: from [10.152.194.132] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 25 Jun
 2025 23:28:42 -0700
Message-ID: <a014dac2-8cf4-485f-917f-28b17611e2fa@quicinc.com>
Date: Thu, 26 Jun 2025 11:58:38 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iw: add support to parse 6 GHz channel
To: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
CC: <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>,
        <quic_pradeepc@quicinc.com>
References: <20250620073240.2770468-1-quic_surapk@quicinc.com>
 <fa22feaa-497e-4349-bd20-fd8b75bf4e9f@freebox.fr>
Content-Language: en-US
From: Suraj P Kizhakkethil <quic_surapk@quicinc.com>
In-Reply-To: <fa22feaa-497e-4349-bd20-fd8b75bf4e9f@freebox.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JR1nFYH7o5spLIidsV14RKl0B58YPSh4
X-Proofpoint-ORIG-GUID: JR1nFYH7o5spLIidsV14RKl0B58YPSh4
X-Authority-Analysis: v=2.4 cv=MtZS63ae c=1 sm=1 tr=0 ts=685ce89d cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8
 a=7xJHNXlQ_Yn2oDr9iNoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA1MCBTYWx0ZWRfX+vFN1/V3w3lw
 IWF7DvGjJuoIePM/GT8+fAAs4rxBAOBFfR4DKkiLvrk31KWxhzGdf7Si+2KaCM0zlcixMQDZqiU
 BRZPng44fOU6Uw+DAdgotx+b466MLOjF0G0jDuOPCpso1fuE2SZ1e4XUd7bFwVax0cPDYSq0NeC
 UlVkI0UK7dQGGJCB1Hk0pQyHIh5WMj+lmEaivj8B7UEaS38vUetm847aYUsaAtmQZi3oohgYarH
 9a81bJAd89ZumUpvhds6hqrIUNW3P1xn2ONELmgjM3KyGVlPX2apE3mxAPmFKRyr3t/AbNHBk5/
 7Z9olLQ0lZd9H3dGdyjwsLpSbpmm1gdtMbl0jPIc61UtDQWZsEmySfRzubumBTgLByqLPuopf6H
 SNLm/rc+6OSL9hixw1U8kO1IlyJivxRWowTgWLUYGsIUQlgAEnp+8c4SdZTqb4fHwyeoo+uW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_03,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506260050



On 20-Jun-25 4:14 PM, Pablo MARTIN-GOMEZ wrote:
> Hi,
> 
> On 20/06/2025 09:33, Suraj P Kizhakkethil wrote:
> 
>> [PATCH] iw: add support to parse 6 GHz channel
>> From: Pradeep Kumar Chitrapu<quic_pradeepc@quicinc.com>
>>
>> Currently, 6 GHz band channel parsing is not supported for
>> set/switch channel commands. Channel numbers of 6 GHz band
>> overlaps with those of 2 GHz or 5 GHz bands and therefore needs
>> additional argument to indicate 6 GHz band. Add support to
>> parse 6 GHz channels for set/switch channel commands by an
>> optional argument "6GHz" in the set/switch channel commands.
>>
>> Examples:
>>
>> For 6 GHz band,
>> iw dev wlan0 set channel 49 6GHz 80MHz
> I'm not sure this is the best course of action to implement the 6GHz 
> support (but I admit it is the simplest). iw also supports the S1G and 
> 60GHz bands and both bands have channel set numbers that overlap the 
> ones of the 2.4GHz and 5GHz bands. The most future proof solution would 
> be to pass the global operating class alongside the channel.

I believe that, from a user’s perspective, using the operating class may 
not be convenient. Instead, specifying the band and bandwidth would be 
easier for users. The 6GHz parameter could be extended to support other 
bands as well.

>> For 5 GHz band,
>> iw dev wlan0 set channel 36 80MHz
> 
> Pablo MG
> 
> 


