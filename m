Return-Path: <linux-wireless+bounces-21961-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8184A9A936
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 11:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B58016FAE9
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 09:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235E58C11;
	Thu, 24 Apr 2025 09:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nf7OePWK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886E52701AA
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 09:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745488646; cv=none; b=B2HAKylreftnG+j9mEUkQcPmyRqh3MxFljOt/PXxVHcJ/lzg+Lnyi3nZJ2YLerrHqe2d7kPGqZPeuXlN+ZW7DV/d5ul0QjJcvJrOiq8CifbzzdXiY5Qf3c2E6aU86A7Zcj42/6dKMfME+ko+IO5pUjEEvWkxpCEGUd4YS+Q41YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745488646; c=relaxed/simple;
	bh=BMsAqY3C+5WNiJVlMxckyhDE4j7jav3wHupdnRz7azg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=q2/sJt1DspCnArIuEGCEBO36c03QfAWVIOqNQQCep0XWg6ORrPbm6uBFCJ/q+e4cvovOgsTKJFON7AG1l/2DlwrI5tgp5oPdukP3IqA093blSpou0nywcYPDK2+rnlfl60L0p7GJQ0trqOgZUfMp9abcn3fogiHlHF0gYe1vQ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nf7OePWK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O0F59m016949;
	Thu, 24 Apr 2025 09:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hVJzyADUJa9JCbxNjWk8+v6iGya/OGo4gF08eH2n2mk=; b=nf7OePWKLMW3sFID
	Opams83InocYA7eEQQJ0LAwvHLNqfHq0Q6btXjm/D7A+vye7Kop/rwlZt9Hm7fb1
	BCLS+fqRTQ4uQedGRunswBR4ocxXXvnQYHWFPahYyjFSOvwAzCpeO1cgP6JtAYdX
	CEudH5wafhDQrbVDvUjpjs0MsfXOzJyXRybiVV11BhuRi23N2DWWeRHZgYPu4QBE
	zpUKvscN1IoXWYIolv5Cf9cym3wqDCNzyNkB+9jKHCHtEv2PvZ6Lt0m6NfMj7qbM
	2FynyNsTrNk+G1TqKYXQySbWbukZeIkDoe+O3bQL6mq/HY1kvnk8nS+isGSWkU2S
	DMHTLg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh15240-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 09:57:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53O9vBIM009975
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 09:57:11 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 24 Apr
 2025 02:57:09 -0700
Message-ID: <d4089a58-d365-4360-b46d-3adf05569a85@quicinc.com>
Date: Thu, 24 Apr 2025 17:57:06 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: pci: Fix msi_irq crash on driver unload
 with QCN9074 PCIe WiFi 6 modules
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: Balsam Chihi <balsam.chihi@moment.tech>,
        Vasanthakumar Thiagarajan
	<quic_vthiagar@quicinc.com>
CC: <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>
References: <20250416100939.282481-1-balsam.chihi@moment.tech>
 <0e129e2a-67fc-48cc-9773-efbea3f7391d@quicinc.com>
 <fa16bad6-305f-77c1-3f56-703564e2dfee@quicinc.com>
 <CAONkfw6m9O_6FZHBrPYdpv+=AxSgsbh1T7+GaS+U+bnjyVVJvQ@mail.gmail.com>
 <3da5d47b-993c-405e-841f-1d16d8715610@quicinc.com>
Content-Language: en-US
In-Reply-To: <3da5d47b-993c-405e-841f-1d16d8715610@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kuvsMtTxeb88E5zjGy4iT2gDdoY5U6nd
X-Authority-Analysis: v=2.4 cv=OY6YDgTY c=1 sm=1 tr=0 ts=680a0af9 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=JfrnYn6hAAAA:8 a=IQanQaj2lkx_2isDzOwA:9 a=QEXdDO2ut3YA:10
 a=grefteXnG18A:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: kuvsMtTxeb88E5zjGy4iT2gDdoY5U6nd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA2NiBTYWx0ZWRfXwMXGJ7ATQzGh IpCHtQOrBUiVpPqwjuT8zvIXJftrZdyGn+AnxBwko8tQRAyDb0A96L33Q2d07bf3YBJ+vPCNrC0 W7z0xvMC1Ll7LChc//SVifhoa2OFnoi5wm5psPapZvMmolt2CvyK9rBwd3tXEPkmeSLiTzZwd3u
 bQWoIu3FXro8LTWv8yTRYFg7PRkT2TqvetecfyhyIXlPCBIfD56dnkFGgbNmp7f0E3xPM8x3kMw 5x/8DMoJaZ9ZojU8U8z97S/wdTJGxqOwstYpIX8iXXQZOw4WKVGyDxlASX1w3zOwuwnLvdpteuJ kzEiL3AHEkZR6Gn8aEpdZcRb+bT6cpqeQ7il0ksK4Gm1a1fFZ/TYks+cEAy+Y+EyqalG9OUP3iF
 cH21EwSUTpq5fPeo5KefbxwVUCRbsWkB94O7cjvWz9LErJ3eJdYNsCxA4p5ZPVkow2trCiCn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_04,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240066



On 4/24/2025 5:49 PM, Baochen Qiang wrote:
> 
> 
> On 4/24/2025 5:25 PM, Balsam Chihi wrote:
>> Hello,
>>
>> @Baochen Qiang,
>> Thank you for your feedback.
>> I tested unloading and reloading the driver and it is enumerated,
>> detected and operating correctly.
> 
> Different hardware platforms may have different behaviors ...
> 
>> And I understand your concern about other chips, and certainly it is
>> not the best way to implement such a fix.
>> I will continue debugging to determine the root cause of the
>> synchronous external abort.
>> So this patch is now just a workaround to fix the kernel crash when
>> rmmod the driver and reboot the system,
>> that i wanted to share with you to attract your attention to the
>> problem, and seek for help.
>>
>> @Vasanthakumar Thiagarajan,
>> Thank you too for your feedback.
>> Yes, I understand.
>> I will enable the debug_mask and check the logs, like you said.
>>
>> I'm wondering if anyone else has the same problem with ath11k_pci.a
> 
> There is another issue report with the soc_global_reset register, although it is reported
> on another hardware.

forget the link:

https://lists.infradead.org/pipermail/ath12k/2025-January/005244.html

> 
> Vasanth, could you check if the register address is correctly defined for QCN9074?
> 
> #define PCIE_SOC_GLOBAL_RESET			0x3008
> 
>>
>> I will keep you updated.
>>
>> Balsam.
> 
> 


