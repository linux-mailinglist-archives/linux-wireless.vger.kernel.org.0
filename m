Return-Path: <linux-wireless+bounces-21959-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8999BA9A90A
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 11:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 604857B5F95
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 09:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF9D224B06;
	Thu, 24 Apr 2025 09:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Gx3EoXOi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2299619F40B
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 09:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745488182; cv=none; b=DHVXPYSKpIzLVp6tpOJOunHIK3SvScpOE/1r8+wJMR19cFbwfz22GHWHdjoi1ZJfJrGoZamZT6lPWW0jMnXBVpPMWgOZNmgY6w1XdvfHkeqiw3ou+0C1zaq34KInpurgxKDbczF9PWxKgwrEEHyrHIbvlG/h67YVfPN0PJ6QRag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745488182; c=relaxed/simple;
	bh=jYpqwv8kE1GiEBjOhobgWMxcSxlK4HAmn4YSVEfaTxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qi55YpVPqtVu5O2PSWzfT2UBtLuPQUuvEEiR57KUawke46YgxYGQRW3Zsy6X9uNEB0BuQIg6w5h+XO0jGsQSFmQ7i9OZpX34oEbH2umjWcBixX53HivM6PN6SCBsy4rXYge8EwWvybMFpiqsS8tZwrC6nikO147WoQ+5KMIKxcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Gx3EoXOi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O0F90V013300;
	Thu, 24 Apr 2025 09:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FG7sJkBzocTiQ4OOp3onmbz2e854K/0c4f9+3HvFEkM=; b=Gx3EoXOize/vjkU+
	gwjjVtW84gmdCsOefR15xpaEoiujYeK7MdXs4ztlQ5ZM6pKFoerRGj7OIHqgRHfz
	82cQ6RJAP6qym9P2cvsKjDG001tV4v8XgN98aSfOXuDEMqu/gx6QZOr9mcVClGXl
	PC4wjPvykE3jg7TPGAIbxGiBodfWD5PLL2fT71GR3Vz6xQsQxncYLl0qxK9DPfRz
	dxUDw1wRT1VRQlAikEbSW0+ywcXRuLqU8CbLD9g0JdHvAb30JvOYOSCHS2UueCUg
	PVmyU7OoNa9PyjH/gPkzM0rto3uZ9VVwgmntiBzAOFlyM62l3457Dg+3ZufCcV06
	qMnvxw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh2d2gn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 09:49:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53O9nU7P023791
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 09:49:30 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 24 Apr
 2025 02:49:28 -0700
Message-ID: <3da5d47b-993c-405e-841f-1d16d8715610@quicinc.com>
Date: Thu, 24 Apr 2025 17:49:25 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: pci: Fix msi_irq crash on driver unload
 with QCN9074 PCIe WiFi 6 modules
To: Balsam Chihi <balsam.chihi@moment.tech>,
        Vasanthakumar Thiagarajan
	<quic_vthiagar@quicinc.com>
CC: <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>
References: <20250416100939.282481-1-balsam.chihi@moment.tech>
 <0e129e2a-67fc-48cc-9773-efbea3f7391d@quicinc.com>
 <fa16bad6-305f-77c1-3f56-703564e2dfee@quicinc.com>
 <CAONkfw6m9O_6FZHBrPYdpv+=AxSgsbh1T7+GaS+U+bnjyVVJvQ@mail.gmail.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <CAONkfw6m9O_6FZHBrPYdpv+=AxSgsbh1T7+GaS+U+bnjyVVJvQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pVT4jaqWBTYWharFM4dJoMlKlvq3IpTR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA2NCBTYWx0ZWRfX/OLlmc+j7/6/ eQC+BltmfA7vFlbW4oFIcYAa80rcGlQbtAnYSXbSnuSJO72rOIE8MThlQvtLCk+KeAPaF9dNZvS 74/0IThUcae3bPmyCwGrR4sOD9Uefto2nK3xIwvN3exen/7IPqoRaGZyg0Z7I8EZyqkDsSR5IMQ
 DINNoF7rykGlHA4CxOKOtQ3Zh+meIT8Uwqu9KLXgc0MQilHcSgki2po1n1XZz5qnGjXHPUxLDBM 0n7rP59FVgMIx0hOJlw5x0UiMNKM9rtWyoKABoZcceTmhYh3NyFzmwb6CEyY8AZw/paR1Hrdbun i9V1AXcFc0YoclJjD+cd3Ei4p3TvschhUGuhJTzBbsN1UIBiiJtNE4ytBje3YDPYvAukGAT3fqV
 cIUBwRgLTgD2R3JeM7Re4yHRe07t42PQv5qyQCDTGkwhtjhz54DU2SI0zb45vXZ69BKSFHWM
X-Authority-Analysis: v=2.4 cv=Tu/mhCXh c=1 sm=1 tr=0 ts=680a092b cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=Jt5UVSROhpSF5wDWJdoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: pVT4jaqWBTYWharFM4dJoMlKlvq3IpTR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_04,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240064



On 4/24/2025 5:25 PM, Balsam Chihi wrote:
> Hello,
> 
> @Baochen Qiang,
> Thank you for your feedback.
> I tested unloading and reloading the driver and it is enumerated,
> detected and operating correctly.

Different hardware platforms may have different behaviors ...

> And I understand your concern about other chips, and certainly it is
> not the best way to implement such a fix.
> I will continue debugging to determine the root cause of the
> synchronous external abort.
> So this patch is now just a workaround to fix the kernel crash when
> rmmod the driver and reboot the system,
> that i wanted to share with you to attract your attention to the
> problem, and seek for help.
> 
> @Vasanthakumar Thiagarajan,
> Thank you too for your feedback.
> Yes, I understand.
> I will enable the debug_mask and check the logs, like you said.
> 
> I'm wondering if anyone else has the same problem with ath11k_pci.a

There is another issue report with the soc_global_reset register, although it is reported
on another hardware.

Vasanth, could you check if the register address is correctly defined for QCN9074?

#define PCIE_SOC_GLOBAL_RESET			0x3008

> 
> I will keep you updated.
> 
> Balsam.


