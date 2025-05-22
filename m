Return-Path: <linux-wireless+bounces-23270-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C52AC043A
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 07:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 345709E7514
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 05:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DF31ADC8D;
	Thu, 22 May 2025 05:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EVJhYH+3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA031AA1F4
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 05:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747893035; cv=none; b=sNv3PViY2EyRvfAIdNiS1eXs7DYDG+YKFw4Hl/xFTfVLxITYNjAHlO/1iG2xpLyAbidsf2L7vB3xMMva4pFaTYcGuw1tUKMIIo/iYK9+c8sv7UAsqorvxSc3QQk+F13IAcpCSM6x6Jd7DIp6k/RBp/zAIGokO/fYKeEjkbpJMNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747893035; c=relaxed/simple;
	bh=GzLT0FoOCA1J0zMGfzpMkiml/aeU70YMZEkb+Y8+ejY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=moG+rrWSdal0Tc4QsZdn2e88Hsb5YrbHQ4YgR/bkR1+R+wvxNB8rhshhpY+Z0NYsVpP/t1RLSzz+uztHMWvizf+mn5fvUy1RgZ5u7OTeESXyvV0qdUe+4caUa81ROMIydiE3Rp5Bv9ufepHEqhZ2AQ9fLdgx7J0gXAGo3YPyVXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EVJhYH+3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LIeq7i000873;
	Thu, 22 May 2025 05:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YNKc9PSRYtF24wqveUXSUjmktMWyUIerXJDRefqhwmo=; b=EVJhYH+3VvO6xfYY
	dS+P/dgPVnfvcph6Aa3QiZqumh1FMBSwDa+nHfJfEelZTPlNfYatZ47hzfZAA+Sr
	FykR2kYOdk76cTPNHlW48PvfVPTWB+YzoCY+vNoMzeq/2uI2NItbNHRquDy93/yb
	WLqNRheeIJMXpkI9VSa4wt/Hgm7em94XngKdK5P1Gc+GblP77h13cIVZam8MeD36
	PAAj/E+hU1YNKrt6LkWJgYLlYVd/XEKNeD60fniZu2RgvRR5+8+9o5btFqGOuSgt
	xBs00gWWcaSQFLSra6Wv88EnenwV8ujQDb50y4H+vJ54OFUWniQJ3I5qQLhMl+x3
	yH96FQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf6w44x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 05:50:29 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54M5oSBK021835
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 05:50:28 GMT
Received: from [10.152.201.120] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 21 May
 2025 22:50:27 -0700
Message-ID: <3e19960a-4809-4215-b6ef-d66d6dcd87df@quicinc.com>
Date: Thu, 22 May 2025 11:20:24 +0530
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
 <4bf37331-5989-4b60-8981-ed20cd79969b@quicinc.com>
 <df3d08425fc7d5db127ccf2e84c258b7c728b751.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <df3d08425fc7d5db127ccf2e84c258b7c728b751.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vxyhp8uDCpZz9n6DZ0MqB9h6zyNxRZ2i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA1NiBTYWx0ZWRfX6VfU4Qramz2E
 YLK+c6CxYp2PRKGXfe3+S4fgsU7QFqhDJS15XX0+TSRLfLApmB3+7xQ/Puf41xBqd36HJSxMgBu
 KXwlEvps/fF6msxZpsB++HED/U1m/EfoKbU6q72+gEplkrIZfqBZt+A5vxeJpVy1UtNnJchVj4N
 YuwKxwuo1yfFEFxVAgPerj/f9XDB1ZxV2RaTUL26wNOpQpAxV7Q0W0JyQiK+RpG2wEA4V7jOjHW
 ug7gUSehMby/iIJBEdFf4nBxCe4ZA/gF74Z3ZoVsYuVSOpPc1SNUq0datMw97DutNiWuEVzHvpr
 qZQBn0LYGeYC++c1rMrd1QXKAQXT1K8Mb8545MnfMvdW1XNZlKHsxCNum/8vmeHNQzAksfEPov6
 QrcSsYW+X7zc1gXuY3QY0/EsvyRE9ieHB+AolOF5h8jK2m3d+vmMaz8WARLTwyF92atoSumL
X-Authority-Analysis: v=2.4 cv=fZOty1QF c=1 sm=1 tr=0 ts=682ebb25 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=rps9iH3sMmB2SGccBB0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: vxyhp8uDCpZz9n6DZ0MqB9h6zyNxRZ2i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_03,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 mlxlogscore=948
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505220056

On 5/22/2025 10:33 AM, Johannes Berg wrote:
> On Thu, 2025-05-22 at 10:13 +0530, Sarika Sharma wrote:
>>
>>> Indeed, weird, why do we even bother counting them per AC?
>>>
>>
>> Currently, tx_packets and tx_bytes are maintained per AC only in mac80211.
>> I'm not entirely sure why this per-AC tracking was introduced, as I
>> haven't come across a specific use case that justifies maintaining these
>> metrics separately per AC.
>>
>> I also checked to see if there are any other parameters tracking
>> tx_packets and tx_bytes, but couldn't find any.
>>
>> Would you like me to consolidate tx_packets and tx_bytes instead of
>> maintaining them per AC?
>> Or should we consider this change separately as different patch?
> 
> Let's say that's different and unrelated, maybe we had something
> accessing it in the past.
> 

Yes, there might be chances it was used before.

Shall I do this cleanup before this series something like cleanup to 
maintain consolidate data for tx_packets and tx_bytes as nowhere it is 
used per AC?

> johannes


