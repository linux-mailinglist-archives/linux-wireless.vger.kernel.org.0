Return-Path: <linux-wireless+bounces-19995-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D72BAA56648
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 12:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C9FE164631
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 11:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDFE2153D4;
	Fri,  7 Mar 2025 11:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nJ7UdORU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116142153D3;
	Fri,  7 Mar 2025 11:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345709; cv=none; b=nLlwFVyO5pWpfAkZmbi6U4l6EpB2QlQNgLc/420APbz3bljWWvcDeHiaD4AX/lp2zToFfFyobONfthAmHPZiJ5N5Nw/1QStqP3G/H4b2Rg8w9mAoIaf5VwVyiHqoipxMlrcMwi0Vao1pHfl+rysSlnMQW0eoMACIV4kA/g8vy6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345709; c=relaxed/simple;
	bh=VgW3oYvxnD57zUq6xnI82C8naLB3ZHqDjGh+sNjydUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GiboeWvuLnLTyKUCgRQeOyzWZsE5JeqTdSIG/ybk91ZyI5Ez6wNZ1jvjxskNYQgWFMh9Am6XCmx+cf+7Zl+BHYweMdDrrNPhuudFWU/D/3ZE0UbmqsV0VwzIyAstvzr+4/yrWj9E/ujVfaRSrM1rOzyfid7SdnvB2gwlpSIJCtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nJ7UdORU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526LPifB005558;
	Fri, 7 Mar 2025 11:08:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+go61785zjwrUQrxqmEcs32W7+BvfgTwGw5PZ1AAdu4=; b=nJ7UdORUEbS/hC5C
	vmFC6+ZDnVy74QonukOIg6tFfkSqS+VFE3vmDBzFZU92dDhMbg/0DPMXtxlKR453
	jmZ7TthQd/ucb78guzkoe6IDf5RYRsGIsDVStmgM9Ch3nA7aEzf25OyyD38CBwwD
	06ddA35CYTfvDW3+r79cM5awtS4ejrEV/vHzhdspdTs2+uOTwY/XdxOI8Tsj3Cov
	4+1k/cY0V4W9msRHY5jmxUJWlQrf+HCHh6JphCpPLdKCgIPsljK7vnhicvehmZ9B
	njA/9YFcPpg7MJMHhdpDKZRiVh8aRi6PpKbew7AN5u1HluWOnLl4s+Qcj0XJaOvN
	/tn/iw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4571sdcvx0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 11:08:21 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 527B8Lts016953
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Mar 2025 11:08:21 GMT
Received: from [10.253.12.50] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 7 Mar 2025
 03:08:19 -0800
Message-ID: <bc187777-588c-4fa0-ba8c-847e91c78d43@quicinc.com>
Date: Fri, 7 Mar 2025 19:08:16 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 2/2] wifi: ath11k: fix HTC rx insufficient length
To: Johan Hovold <johan@kernel.org>
CC: <quic_jjohnson@quicinc.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250307040848.3822788-1-quic_miaoqing@quicinc.com>
 <20250307040848.3822788-3-quic_miaoqing@quicinc.com>
 <Z8qzjeUE1L5GxFq_@hovoldconsulting.com>
Content-Language: en-US
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
In-Reply-To: <Z8qzjeUE1L5GxFq_@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HTFPGlBMDjDbhu9lqYcd18_wn5AVqmjS
X-Authority-Analysis: v=2.4 cv=W6PCVQWk c=1 sm=1 tr=0 ts=67cad3a5 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=ljC56ufXeZy0Try5qlsA:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: HTFPGlBMDjDbhu9lqYcd18_wn5AVqmjS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_04,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1011 impostorscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503070080



On 3/7/2025 4:51 PM, Johan Hovold wrote:
> Hi Miaoqing,
> 
> and thanks a lot for looking into this.
> 
> On Fri, Mar 07, 2025 at 12:08:48PM +0800, Miaoqing Pan wrote:
>> A relatively unusual race condition occurs between host software
>> and hardware, where the host sees the updated destination ring head
>> pointer before the hardware updates the corresponding descriptor.
>> When this situation occurs, the length of the descriptor returns 0.
> 
> Can you explain how this race comes about?
> 
> I worry that you may just be papering over a driver or firmware bug here
> so it would be good to understand how the host can see the updated
> pointer before the descriptor.
> 
The entire process is handled by hardware, and host software just to 
read the status, so it should be a limitation of the hardware.

> Also do you have any suggestions for how to reproduce this more easily?
> Some users of the X13s (aarch64) hit this very frequently, while I've
> only seen it a few times. At least one user hit this consistently when
> roaming, and another mentioned seeing this while driving his car with
> the laptop on (and presumably seeing a lot of APs go by).
> 

We reproduced with below setup on IoT device, usually takes a few hours 
to several days to reproduce it.
  - Run TCP downlink traffic (iperf)
  - Run bluetooth bredr scan (bluetoothctl/power on/scan bredr)


>> The current error handling method is to increment descriptor tail
>> pointer by 1, but 'sw_index' is not updated, causing descriptor and
>> skb to not correspond one-to-one, resulting in the following error:
>>
>> ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1488, expected 1492
>> ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1460, expected 1484
>>
>> To address this problem, temporarily skip processing the current
>> descriptor and handle it again next time. However, to prevent this
>> descriptor from continuously returning 0, use skb cb to set a flag.
>> If the length returns 0 again, this descriptor will be discarded.
>>
>> Tested-on: QCA6698AQ hw2.1 PCI WLAN.HSP.1.1-04546-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
> 
> Please also include:
> 
> Reported-by: Johan Hovold <johan+linaro@kernel.org>
> 
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218623
>> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
> 
> Johan

Thanks for reporting, will update in next version.



