Return-Path: <linux-wireless+bounces-27728-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF796BABA7C
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 08:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76A74164D80
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 06:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2561A5B8D;
	Tue, 30 Sep 2025 06:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mNOYPIIv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6F4145B16
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 06:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759213436; cv=none; b=TofbtYyIxTO00jYvNxuEuZdvW0iHggnB7E09oS75ne+vYxxQuoG39QwXlg8MwhkXtWywOZqXSI4Oz8lE5kwPAU6ZU4+uDfudXTwlZYCksPCDKV59Vu2cm7xUzYJ8XMAGho8PtyPU9JP0FKGasTB1WsBnUbzsxWN6gjt2H/uRSBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759213436; c=relaxed/simple;
	bh=hQ8H2SQbtIyK7icdTma4E2Zcg5y2mTM8iK6d9IElX7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZQ0LEMsR28CMl/ekVQ74ZQLJLtEYkG8J+XJ/V1EwMdwtdcaJbM3B+lqYWhEo/gzpF6XTA4+9WbwXUFVCXRySE1IAz8lni9q/4BD1NdvIcpX55oJUC0ofIa7SGWi8EXeWr/Lz+hSGhTotIE7ARYtrvV8cOjkkr2Bf+HRbuT22fSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mNOYPIIv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4HS8O020349;
	Tue, 30 Sep 2025 06:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	98fQrKMhC9zb4gTQxdjCLvB5WTJI8hwI+PE6R/OU+8M=; b=mNOYPIIv7kMC18hA
	yP6ySZp7VMFdb8ApCkwSqZ69+V07ro47vqnw2oIjtY1Zul4AOPWFqUU2K0kbKP33
	ZLD/zH3Lx3Lbk5uR+nu8oX69xiqh9RYToXv9ZAmmZH3uUQ5tssgXC09VKHw2svwR
	W5mzqchLg0GoiC519wltLSpdS7b7vrc8+y4ujemYnCZ6fnkp3++HCmtETPJEGlff
	2+N+lJqbiUimTyTrWABfV5NFdLO71s6iwqhEx4nIn/+pNWNzes+WFsyQpqSSKBzd
	7tNyv8ZpJvMT4k0h/3fJ1AhOZS811Gx5Q2RfajpUBRWCbk8w61bBQSqgORMt32FD
	rqRqmg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6x5qxf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 06:23:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58U6NOvn027492
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 06:23:24 GMT
Received: from [10.79.196.122] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Mon, 29 Sep
 2025 23:23:23 -0700
Message-ID: <63bc74ae-46fd-4fed-bb2c-92df1e363815@quicinc.com>
Date: Tue, 30 Sep 2025 11:53:11 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v3 0/3] wifi: cfg80211/mac80211: add support
 to handle incumbent signal detected event
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250923073554.3438429-1-quic_amitajit@quicinc.com>
 <24cf2002d234a80590ad1cf9670729db1977bbdf.camel@sipsolutions.net>
Content-Language: en-US
From: Amith A <quic_amitajit@quicinc.com>
In-Reply-To: <24cf2002d234a80590ad1cf9670729db1977bbdf.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _WrlEslXBlbxcl5tXfggzKCP52rOhqA9
X-Proofpoint-ORIG-GUID: _WrlEslXBlbxcl5tXfggzKCP52rOhqA9
X-Authority-Analysis: v=2.4 cv=ZtPg6t7G c=1 sm=1 tr=0 ts=68db775d cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=VRcdiIHQEsGEBkwsYAsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxOCBTYWx0ZWRfX/JaN0fow2m4B
 5fgY06kcAfI4vgHFU3rCmViOVKZXXTGzTZ5x+1D25NjE7s8mIuSHlutZj8gzx3oKY/FkN4Bwnnn
 58R5ia7N8RFz7KvrOOI8XmWw0kHi7A6qMK5XVWSdVhgfckKcd5aXC1stAUCyX7FN6RkMNnF8t0s
 0XDKRoTo0jiKs82iA+eD9PlYmTR1HcFNYrOvP7l1zXVYdtB6GloGeM2yKsBb4jX7W1sGcYHXJo4
 fNwZ3oOFZlLN3hIc4SXsIR4G1yFIk8MwUgsGVoqTtAKvbI72+t8Vb/FfCQjnGX7fopBw5DxSSIE
 FAZkrzzcgHD3NDIzS6Kh255ZgysUq+E3rDGm0hXQ1yzDnN1Hw92IHFdIryU/2hTwEElcdJw9tLk
 gullSo7STpixr/uUy+/CEJsm2uWnQw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270018



On 9/23/2025 1:10 PM, Johannes Berg wrote:
> On Tue, 2025-09-23 at 13:05 +0530, Amith A wrote:
>>   - Renamed nl80211_incumbent_signal_notify() to
>>     cfg80211_incumbent_signal_notify() and removed the gfp argument from it.
> I'm not sure why you removed the context (gfp_t) argument, are you
> expecting all drivers to call it in a workqueue or other process context
> (like hwsim does in debugfs)? That would seem odd to me, say you have
> ath12k handling a WMI event (surely this is reported from firmware),
> then you need GFP_ATOMIC?
>
> Anyway ... we can add it back later if needed, but please document this
> carefully.
>
> johannes
I misunderstood your suggestion and assumed the context argument could be
removed since there are currently no other callers to the function.
I thought it could be extended later by reintroducing the argument when 
needed.
To maintain scalability and flexibility, I’ll add the |gfp_t| argument back
in the next version.


