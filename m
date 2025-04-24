Return-Path: <linux-wireless+bounces-21965-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97ADCA9AAD3
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 12:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C80404A1240
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 10:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF801F8721;
	Thu, 24 Apr 2025 10:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Sqbme87S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911BB1C5D55
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 10:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745491525; cv=none; b=jZtJsvEk9TKDHQyWS7fXPG+DT8PNAoK5b4Nv9DS986h+UguKkD5iyy3ar3vmt3a/gvl2IozC+ukbEHKgiP3PSc0T9DV+jH3LFdFWtC2TTtEEhCF7CkuW3kzX1wRtXKzJeblPpLYI436rjUnx3D0AqfDnx6FH73NjLegRcXGegGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745491525; c=relaxed/simple;
	bh=8vTlvfyWKf6xrayBH3qesTWR29ycEXBauBYTPPByuaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kQFRnMGZ6qGTfruFJ93fyetOp2SOA0Iw8R2/CgLBMn/KHdMx9DC10vgTBkp3eP4zoQn+LxJThd5wNd/pBK1EpvxyHJeqZ2koJARk3mO30KfvejqCQAQgqj0biE4K0D6jrW8Kp9BksAVQBqlSNXIU4EpClMkryfvHojPM319frts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Sqbme87S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OAb53A011207;
	Thu, 24 Apr 2025 10:45:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4CILdzKcee1/pA4osU26Vv+K3t+hnGDCIxzPM5Zy9Rk=; b=Sqbme87SXwER65BX
	laDpLGPsq062fhxIY2VWr4CyzUWvvJjY3Nd0nZVwYjO3MwXicCmI9BfxTDSaotA5
	i2GQ6VTnksmF3hnkmO8PiEqkB76T4xZDzWHR/T27eAHn7VQa52ZEbcWD+AO4vT7a
	H/lBLOpyriRINYqsM4DHNVgaqADgB74F47cO3xd4NPfmyrl7/v/jHXwI1qo6yuBc
	CVQEXruitHZ/bF7Zjk6EI7ZMcD3+GVGTXQacX8tXJMP9qScSUsEwWkWBulUJjlNw
	7Ci0notO7msuyLJu8d7KjDr7DLReK8g3dTd7eTDgYSQmraDSw1HIXapkPlRHMFWK
	hgpZVQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh3d77j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 10:45:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53OAjGUn020200
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 10:45:16 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 24 Apr
 2025 03:45:14 -0700
Message-ID: <3660fcfb-be29-422b-a352-3996ad3fc41f@quicinc.com>
Date: Thu, 24 Apr 2025 18:45:11 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: pci: Fix msi_irq crash on driver unload
 with QCN9074 PCIe WiFi 6 modules
To: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
        Balsam Chihi
	<balsam.chihi@moment.tech>
CC: <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>
References: <20250416100939.282481-1-balsam.chihi@moment.tech>
 <0e129e2a-67fc-48cc-9773-efbea3f7391d@quicinc.com>
 <fa16bad6-305f-77c1-3f56-703564e2dfee@quicinc.com>
 <CAONkfw6m9O_6FZHBrPYdpv+=AxSgsbh1T7+GaS+U+bnjyVVJvQ@mail.gmail.com>
 <3da5d47b-993c-405e-841f-1d16d8715610@quicinc.com>
 <1d0682c0-ee5d-f2d4-199d-4ebc4e71f9ef@quicinc.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <1d0682c0-ee5d-f2d4-199d-4ebc4e71f9ef@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pQJvlji3CEgbA1ygQrA-qvhL5qx8U9LO
X-Proofpoint-GUID: pQJvlji3CEgbA1ygQrA-qvhL5qx8U9LO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA3MSBTYWx0ZWRfX2VIuBsLZH7cv sf6TucjYwB4UESRYfZKXSEL1WNvaFlaU7N3bDhf/9T4kzk950gJ+HEmVnSRDEErNjkfKVFt9ZH0 4TFKlo1wMNXje3nG96gBql3HWeYwYL7glHb3LifFTpaZagUaotwvmhXOYUmxTyf8kPMEEfAU3lV
 tnsg4gQfTKGCtUHYjKM1yRbk33BFBOxsE3kMwvweKwWWiIl979oywqeKhnTIjE0c9I4IpoYdmkE 4FoM3DOb7Q5DBBKiZBk41eTQRBf2a59yi25lJp4PfgoDncg7CL4nNcyrNUYfX47O8yPkTcxPIIL dIg3P6/7h3CBISNdR0gfyuB70S/J7w74+ttl35rHt528qW/j/6965WpDNziDgtOarpkpV9g7niG
 3vC/Ltx4zqX7cIEMki+1PU4Q8KBC6v5LWEkgaicloIeYlpBqMYupd9k+HYuiOJH5bQxCBlg1
X-Authority-Analysis: v=2.4 cv=Mepsu4/f c=1 sm=1 tr=0 ts=680a163c cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VSmY6pKNb7jb4yXACBMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_05,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=949 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240071



On 4/24/2025 6:36 PM, Vasanthakumar Thiagarajan wrote:
> 
> 
> On 4/24/2025 3:19 PM, Baochen Qiang wrote:
>>
>>
>> On 4/24/2025 5:25 PM, Balsam Chihi wrote:
>>> Hello,
>>>
>>> @Baochen Qiang,
>>> Thank you for your feedback.
>>> I tested unloading and reloading the driver and it is enumerated,
>>> detected and operating correctly.
>>
>> Different hardware platforms may have different behaviors ...
>>
>>> And I understand your concern about other chips, and certainly it is
>>> not the best way to implement such a fix.
>>> I will continue debugging to determine the root cause of the
>>> synchronous external abort.
>>> So this patch is now just a workaround to fix the kernel crash when
>>> rmmod the driver and reboot the system,
>>> that i wanted to share with you to attract your attention to the
>>> problem, and seek for help.
>>>
>>> @Vasanthakumar Thiagarajan,
>>> Thank you too for your feedback.
>>> Yes, I understand.
>>> I will enable the debug_mask and check the logs, like you said.
>>>
>>> I'm wondering if anyone else has the same problem with ath11k_pci.a
>>
>> There is another issue report with the soc_global_reset register, although it is reported
>> on another hardware.
>>
>> Vasanth, could you check if the register address is correctly defined for QCN9074?
>>
>> #define PCIE_SOC_GLOBAL_RESET            0x3008
> 
> That offset for global_reset is correct.

Okay, then it should not be global_reset causing this.

Balsam, could you help debug further to check which specific register access is causing
this issue? We can then check if the register is defined correctly or not.


