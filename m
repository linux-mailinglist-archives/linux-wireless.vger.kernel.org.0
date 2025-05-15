Return-Path: <linux-wireless+bounces-23026-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A95AB8DF7
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 19:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0839B17D427
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 17:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AE61F3FE3;
	Thu, 15 May 2025 17:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="P8AH9c61"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59F3146593
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747330765; cv=none; b=bEFZTW+CFG5SiWbe4pf3RHKxEVEEbAWiWr24Z0AmvqjwY6g2fTIovyBalRC+9emIMj7SrT6FCfqItYnMz71d8sIj/6ez++GbejnUYcVHGCqvpWLbMrpoxWZref4v3Mnndogx35e+yOB9GJR0Z80vQvTFo7xmDF5N33YpTOZwudQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747330765; c=relaxed/simple;
	bh=N/LZeSndkZRr/nfweo5ofIY4PsAtlp5mw+r92SzabGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cqbyL4IOhjLbL01FxEZzZmxydlvzk8ptUGPRsIOAh3uGslJr17HFzhZXQYAumqusJjcXXvvClPRB8YsBuDot8awx08JZdiheuesxhX3+/bXvolyp19uMv9dBXWKjW6QYD1a57ER9D9z9dQzwrIUL8IHQdCLYEXhPXCYIZAyqeSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=P8AH9c61; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEFTge025630;
	Thu, 15 May 2025 17:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DY5Dh3e9eRZRq6GSzQPaj8nhKpX2nsdYwvruyPUuS0U=; b=P8AH9c61xV7UBxV3
	GNoixuJrDQxEBdedfv7B121JIIG4xfy/Qjsuikz5GDhZa9VY3f2ztO4kFNcu829r
	GU6QEanNehgbyrwOw1k1Hg/TpS8G1HTsFUlmMdlTx3ld931jFx7vAy5ewGfwsrL2
	rtUajFt/BsG5SvZH066dbfTYpi1tT3sif4QBQpl3i82IxjptuXNxMQkwyvubpWBD
	MRDZf7Iu33+W7qwilgOBkX/rG76P0U+P0n/lqLidarheFWJbi953KDdGWAOiFUkp
	dHYqQZO1tzHlYUuiydVtqXSblGwNu7uYYaaUUU4gJJRzU4JV4xaMPM4W6xHqBjAZ
	48gX7Q==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcny57u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 17:39:18 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54FHdHxw020510
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 17:39:17 GMT
Received: from [10.50.45.88] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 15 May
 2025 10:39:16 -0700
Message-ID: <c1e9cc95-8139-4b76-b12d-6666e5a49aea@quicinc.com>
Date: Thu, 15 May 2025 23:09:13 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v8 07/10] wifi: cfg80211: reset
 sinfo->filled for MLO station statistics
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
 <20250515054904.1214096-8-quic_sarishar@quicinc.com>
 <b6aa1823646f6911c6dab8db973398bda8526a9a.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <b6aa1823646f6911c6dab8db973398bda8526a9a.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gi7WiXoNrQJ0xDsVM-lDzOf83QNAaWni
X-Authority-Analysis: v=2.4 cv=D8dHKuRj c=1 sm=1 tr=0 ts=682626c6 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=AQnfCzUfGodVWXXiQbYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE3NCBTYWx0ZWRfX35c/gS66OQZ8
 CvpGFrREJCihyqJA2ECW3k+fQ64lnNghYW6oaK4RSvdhKdh/K4LncNAK+koRRnrwhuI3cqS+PSW
 sNaOHdsO3N+oCn/p1XwryGH3KTgXsDkYvXWefSv9Un/kEJ8Ortpgc3K3UQFXVqEPxf53v7u4jRy
 TzOfSWEYsGPaMSNnoQqOmgSlwokrX8JfTY1orM4HjVH/VucyQwRNSDVAhoTmUpJ0B2TcGs8carb
 ZGXrlc+l3IGtNZVJ3KCbo0JSnQcrRcyyFdNKzjIsBxIMvD00EjQ565MA9Kgy5cOLlTiPBT3AqOv
 iHMUFQAa4q1AQ34sK1XO+2vRKuCG3bnYqaVExaxBl/dYXJyN0pTdbLjlKmzH2gJqOAM5hnIEwto
 yKFXIWIe3wwaX4iP/Clui0pP74BB/2KNvPkPQD4J/vk7twufbi5ZhrLDXnWAx/nmBsAwWWN6
X-Proofpoint-GUID: gi7WiXoNrQJ0xDsVM-lDzOf83QNAaWni
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=821 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505150174

On 5/15/2025 5:06 PM, Johannes Berg wrote:
> On Thu, 2025-05-15 at 11:19 +0530, Sarika Sharma wrote:
>> Currently, sinfo->filled is for set in sta_set_sinfo() after filling
>> the corresponding fields in station_info structure for station statistics.
>>
>> For non-ML stations, the fields are correctly filled from sta->deflink
>> and corresponding sinfo->filled bit are set, but for MLO any one of
>> link's data is filled and corresponding sinfo->filled bit is set.
>>
>> For MLO before embed NL message, fields of sinfo structure like
>> bytes, packets, signal are updated with accumulated, best, least of all
>> links data. But some of fields like rssi, pertid don't make much sense
>> at MLO level.
>>
>> Hence, to prevent misinterpretation, reset sinfo->filled for fields
> 
>                                         ^^^^^ clear?

sure.

> 
>> which don't make much sense at MLO level. This will prevent filling the
>> unnecessary values in NL message.
> 
> Not sure I'd say "unnecessary" but perhaps misleading? I'm also not sure
> this shouldn't be WARN_ON, we're throwing away data that was provided.
> In mac80211 it even allocates tidstats memory for nothing, in this case,
> that's super weird?
> 

Yes, that why I initially came up with the other design.
Some of fields, that are getting filled in mac80211 for sinfo are from 
sta->deflink, i.e one of the links for MLO.

Now either we have to split the sta_set_sinfo(), such a way that some of 
fields applicable at station level is only filled by mac80211 in 
station_info structure for both non-ML and MLO and others which are not 
applicable or filled from sta->deflink, need not be filled during MLO 
case or if filled it need to be free.

> johannes


