Return-Path: <linux-wireless+bounces-20648-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 942FFA6B87D
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 11:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1638D486EF9
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 10:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5DE1F2C34;
	Fri, 21 Mar 2025 10:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LhlkLEae"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AF51EBFF0;
	Fri, 21 Mar 2025 10:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742551687; cv=none; b=pHqZ0b4GsycK0WGP+Y/bqVWF0pTMw8zq0WBmLv2CwfgMSO4rBKwk01TWd/SJwkb35ABYqcxJpe41FGSEEbtrw1ZpGawvvftkep32pyAXh8gUn+hgQ562WXkFdtZ6Xyz0C48BrdDiYZExTX2SsYd/tC0UlWr9FXv0XuSMTqv+7IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742551687; c=relaxed/simple;
	bh=JUyYZgvHnMkO5Pzm34Kcy4R92KbnKob5xAR4ZC5hkhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A7DnwopBs6aUhtyS2YBCpDVmMjZInG+SbiNDUiH5Asw+EtGwWLIlZrCSXV5kGThZxQJ1+QToTzIEQqRHkZC70d23sYGMD6J1+2GCabBqzgW8INoUpmSzSop/Eq+gme9uaXGXuh5c5lJj+LvhUROCoq4+/5lREssRfnvyUVuFMXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LhlkLEae; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L8k5KD014152;
	Fri, 21 Mar 2025 10:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wohi0atRJyGxd3ZMz+5DEGmp/UcLqgSt0+cwzpEAn7Q=; b=LhlkLEaeYTL0lYbX
	OeJ0IIyA3TpDzoGu6JdBSEp0PgMN44rbc6EFIldxsYRSl4gwyopG7W9+N8uQCyGn
	htBBfvZZaDnQysgrvXSx36AeTfbdeUrMB/5pbp7ALpTdpyBF/BQNhLNYMOImYruU
	6gJnqDOgatxboTIRyROnDIoZLvDbKIa5mROtGfzuxNhitWd2bNRb2YqiDRvMNGvW
	7tTfFMrxM7REW3VzjT2dg+SYQyk3oWQBuCjFYmri6fDs/rP7Ryr1+lOGoNYUXieE
	cktD0/ROrJeqCdcfhudcH4TA1CoBber6d/3KuAYTupJXKJULnIrajREzN3W+MhFk
	HP35KA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45h4p1097v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 10:07:56 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52LA7tV3022850
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 10:07:55 GMT
Received: from [10.152.207.135] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 21 Mar
 2025 03:07:52 -0700
Message-ID: <10fd0006-8428-4bc6-9578-2a05dc1382e0@quicinc.com>
Date: Fri, 21 Mar 2025 15:37:49 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v11 00/13] wifi: ath12k: add Ath12k AHB driver
 support for IPQ5332
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <ath12k@lists.infradead.org>, Johannes Berg <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250317204639.1864742-1-quic_rajkbhag@quicinc.com>
 <20250318-splendid-sceptical-gazelle-8abbef@krzk-bin>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <20250318-splendid-sceptical-gazelle-8abbef@krzk-bin>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6M9rfQf7dbn492hdifADri3wc56cF0kc
X-Proofpoint-ORIG-GUID: 6M9rfQf7dbn492hdifADri3wc56cF0kc
X-Authority-Analysis: v=2.4 cv=NZjm13D4 c=1 sm=1 tr=0 ts=67dd3a7c cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8 a=bsUYDfnVGbR25cQxC6AA:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_04,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210074

On 3/18/2025 1:30 PM, Krzysztof Kozlowski wrote:
> On Tue, Mar 18, 2025 at 02:16:26AM +0530, Raj Kumar Bhagat wrote:
>> Currently, Ath12k driver only supports WiFi devices that are based on
>> PCI bus. New Ath12k device IPQ5332 is based on AHB bus. Hence, add
>> Ath12k AHB support for IPQ5332.
>>
>> IPQ5332 is IEEE802.11be 2 GHz 2x2 Wifi device. To bring-up IPQ5332
>> device:
>> - Add hardware parameters for IPQ5332.
>> - CE register address space in IPQ5332 is separate from WCSS register
>>   space. Hence, add logic to remap CE register address.
>> - Add support for fixed QMI firmware memory for IPQ5332.
>> - Support userPD handling for WCSS secure PIL driver to enable ath12k
>>   AHB support.
>>
>> NOTE:
>> The working upstream DTS changes for this series have been posted as a
>> separate series.
>> [PATCH v2] arm64: dts: qcom: add wifi node for IPQ5332 based RDP441
>>
>> v11:
>> - Updated Kconfig for ATH12k AHB.
>> - Replaced the API devm_ioremap_wc() with devm_memremap to fix ath12k-check
>>   warning: "warning: cast removes address space '__iomem' of expression"
>> - Rebased on latest ToT.
>> - Removed tag "Reviewed-by: Vasanthakumar Thiagarajan", in the updated
>>   patch [11/13] wifi: ath12k: Power up userPD
> 
> 
> This is v11 and still sent in a way it messes with toolset:
> 
>   b4 diff -C 20250317204639.1864742-2-quic_rajkbhag@quicinc.com
>   Grabbing thread from lore.kernel.org/all/20250317204639.1864742-2-quic_rajkbhag@quicinc.com/t.mbox.gz
>   Checking for older revisions
>     Added from v10: 14 patches
>   ---
>   Analyzing 135 messages in the thread
>   Preparing fake-am for v11: dt-bindings: net: wireless: describe the ath12k AHB module for IPQ5332
>   ERROR: Could not fake-am version v11
>   ---
>   Could not create fake-am range for upper series v11
> 
> Can you fix your process so the tools will be happy? Please read
> carefully your internal guideline go/upstream before posting next
> version.
> 

It may be because, I did not use b4 tool for this.
Will send the next version with b4 tool.

