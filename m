Return-Path: <linux-wireless+bounces-21964-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E8CA9AA97
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 12:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 875F71941B96
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 10:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6CF226D11;
	Thu, 24 Apr 2025 10:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DXO76vU2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D0123370F
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 10:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745490996; cv=none; b=eAAvsUkzoZnatLRQuaOTMrDUdJ6iNAwnAUrXcIqzjzPB2JTD8g1k/5xNX6bKuiPXMhHrePAIVk0tmgaO9Ac2vky6S9clEMjX9Xki01zoUtRMRuwQ3lylrJxzlGqaoTjy6CzIM01WXQUaBnnBNaNWed0aVmGbOMgBQOIV/+hQnms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745490996; c=relaxed/simple;
	bh=8cmoKTB2RJ55VhVTFJnKVGEK3ux4xgm47lpFA9M43Uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=prtPwqPpWozFHghtJ+UWdzRJvd7d0oC+tVIBLDA2EU2GcPqw71B/Fa5woFlN4r6T50vn8ylcs24SgoOblgR3hsaTGEtZgn2CFSXGygFpe5QVtP3jc91o+2kQghUKWRJXEH9bSpZkCsAtNdrkazs65LXGw8F5JDNmJD4XmLGniEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DXO76vU2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OAKLn6032238;
	Thu, 24 Apr 2025 10:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x0rlgd8yitypOaqd4VMzlAqB/a09o692Q+3P1d8jspQ=; b=DXO76vU2AO45uAWN
	GInpcBcMMnoeth4TVmVR2QmOpSZ5+gwoNH/JNTpMGfSm43/teEEREpQ68Kj4TMGA
	eufe8swojUzlXqUHZ61KOsewgvvAJcA8xsjyOfK9QP4okd19uW1dT85sS4Lk0dnX
	/IkjPq8rqPqqS+5l/LFlB9RjnyIMOICEgWDIQbJImZvXsa1hwqmSGCixPgjWStHs
	yfYyimW0HX2egcfDKEtZmY//LbdcAKiDAZYr/YNWQfR6kaCeFs0quspCtmtjOCy8
	yEYyj+H7sKyo/V4cYkGs6cN0NcihsHQLccQbFuEizPip6WO48foEEkfxJem7IsY/
	ltgkaQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh5d6ss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 10:36:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53OAaRr3023044
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 10:36:27 GMT
Received: from [10.216.33.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 24 Apr
 2025 03:36:24 -0700
Message-ID: <1d0682c0-ee5d-f2d4-199d-4ebc4e71f9ef@quicinc.com>
Date: Thu, 24 Apr 2025 16:06:21 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] wifi: ath11k: pci: Fix msi_irq crash on driver unload
 with QCN9074 PCIe WiFi 6 modules
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>,
        Balsam Chihi
	<balsam.chihi@moment.tech>
CC: <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>
References: <20250416100939.282481-1-balsam.chihi@moment.tech>
 <0e129e2a-67fc-48cc-9773-efbea3f7391d@quicinc.com>
 <fa16bad6-305f-77c1-3f56-703564e2dfee@quicinc.com>
 <CAONkfw6m9O_6FZHBrPYdpv+=AxSgsbh1T7+GaS+U+bnjyVVJvQ@mail.gmail.com>
 <3da5d47b-993c-405e-841f-1d16d8715610@quicinc.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <3da5d47b-993c-405e-841f-1d16d8715610@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA3MCBTYWx0ZWRfX8tNINtfeH3dV 8ZfrIwFdJlLXwxpLWGqmnAh9HhMV4MgsdqcOV75SLG1B2hFt6/F0AedrrMApA8VaWQtWwAwLq67 B733M+LTSmTFhP9FzJWPPb04+MpI3Fp3BBzf6sPNnlWg0JFKsQ5nRdda4xxlgcqg9HxKxj38k1/
 0p04XcpMCxsEmes0b2xnT+WpEsqfTzHak4i30rt0q1z6d6S1uoH2HDjzU3i+7/9prG9pf8/+HwJ pu7OqZdXa40r35EgVPxzsYwTLZbYFU3nt8cWbVquYozSO28E7lWYNw2DUyfwbikn8n0jZIxXe5W GzjeKXGlRkHS5EQlQTmMCKzQblj+UwdOR3bKogaBmaGARUp53cUMR/PPeIP4jQmiXSrBbsYZTt8
 0BHZX/ktx9IHCSKvddJPkXtiNZLaa3rbkOjptTAzDKtwcI6hKayd1C2xyfDS2CXI4Y00nKYV
X-Proofpoint-GUID: MMannsizmZHMSMmb5TUXedygDYgqz9AC
X-Authority-Analysis: v=2.4 cv=B/S50PtM c=1 sm=1 tr=0 ts=680a142c cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=IQanQaj2lkx_2isDzOwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: MMannsizmZHMSMmb5TUXedygDYgqz9AC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_05,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240070



On 4/24/2025 3:19 PM, Baochen Qiang wrote:
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
> 
> Vasanth, could you check if the register address is correctly defined for QCN9074?
> 
> #define PCIE_SOC_GLOBAL_RESET			0x3008

That offset for global_reset is correct.

