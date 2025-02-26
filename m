Return-Path: <linux-wireless+bounces-19497-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 215A2A469B3
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 19:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF2077A160C
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 18:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AAC23F42A;
	Wed, 26 Feb 2025 18:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TFhmjS12"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DF919924E;
	Wed, 26 Feb 2025 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740594098; cv=none; b=CeNjpmf3lvDyYsFN98T95uTqZxY2FiQjoFN2t8OvTchKvPo+vpsPRfS0xUkc1FjzWQjs8vyDsgAc0bkiOfEsXR6XbI8TRoRmF24THK5YbLWKCihOJw8khGE10S7mF811e7o4nJ8pg+a9g25WAS/voDrDTa0GxXE9Czu0mHLcRTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740594098; c=relaxed/simple;
	bh=9GQVHSyqDyUopJd0bMK6Kr3UM36PkXsxLEFxyNe1IOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YHqDc7Ii9XEPRtcbJ0AhtTmivDA8AJK6d0vd7BIjlCLT03+/VmxKXelb7px/h11UoVG4KdYdK3y7QzuwBUvS7C2cEO/muHZHLV2+gsTR+qYft7nLokGnPWK+bkJGT9ID/O8XyCarMSAMY+wOofMRYyrDipPPojBivdxSNr5mnkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TFhmjS12; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QA4XtO013260;
	Wed, 26 Feb 2025 18:21:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZWSD4j6EEFeqcOQdnQ85n26HkbUr80sn+V/kPvDpcbA=; b=TFhmjS128+nTmbVt
	zgEhsr+6Gk9pCQ5euCwg59tHf768r3RCoo/nwqxl4b3JM/sduzRjgq4VDxiJyty9
	4v98eHvQQPdplALtddMSMkp3KgybruXhgX/QzgNEvm8Il220HyjzJzDJdcnRo+VW
	y4pXy+VimBqWbfJiDM0u8uFbYvdH3ot05YpZACePJiKF0JlsvKY6ChKYPGWtEyMg
	nVztZ0kM3+ErXYeQfuXswA8PEiedMTGMZ2BZ9tyMsHuxb6ReRAcp+qUhuuzLNaHb
	jYbZKESkazH7+wO2Y3q4bFfkDgtmlmvxGBWCjPtjaShjjDkygn8u9M8O0DgHMy6a
	mTLmmw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prk2wg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 18:21:30 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51QILTom026686
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 18:21:29 GMT
Received: from [10.216.2.27] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Feb
 2025 10:21:25 -0800
Message-ID: <0a193a56-0197-486b-9d36-20aeb0d5860a@quicinc.com>
Date: Wed, 26 Feb 2025 23:51:22 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: qcom: add wifi node for IPQ5332 based
 RDP441
To: Bjorn Andersson <andersson@kernel.org>
CC: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20250130045900.1903927-1-quic_rajkbhag@quicinc.com>
 <3iwfhcl5gmpwfiatsawwkm5qns4pmzvhcrroq236y45kklw244@6rngcplttabx>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <3iwfhcl5gmpwfiatsawwkm5qns4pmzvhcrroq236y45kklw244@6rngcplttabx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sHONV2xv9nPhtqYL3M9SXHmuBq0UOOMR
X-Proofpoint-ORIG-GUID: sHONV2xv9nPhtqYL3M9SXHmuBq0UOOMR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260144

On 2/26/2025 9:22 AM, Bjorn Andersson wrote:
> On Thu, Jan 30, 2025 at 10:29:00AM +0530, Raj Kumar Bhagat wrote:
>> RDP441 is based on IPQ5332. It has inbuilt AHB bus based IPQ5332 WiFi
>> device.
>>
>> Describe and add WiFi node for RDP441. Also, reserve the memory
>> required by IPQ5332 firmware.
>>
>> Depends-On: [PATCH V2 0/2] mailbox: tmel-qmp: Introduce QCOM TMEL QMP mailbox driver
>> Depends-On: [PATCH V3 0/8] Add new driver for WCSS secure PIL loading
>> Link: https://lore.kernel.org/lkml/20241231054900.2144961-1-quic_srichara@quicinc.com/
>> Link: https://lore.kernel.org/lkml/20250107101647.2087358-1-quic_gokulsri@quicinc.com/
> 
> Please run "git log --grep 'Depends-on'" to see how this tag is expected
> to be used. As you can see, dependencies on other patches in flight does
> not go into the git history, and should as such be mentioned only below
> the --- line below.
> 

Thanks will take care for next submission.

> Please wait for these dependencies to be accepted before resubmitting
> this Devicetree change.
> 

Sure

>>
>> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
>> ---
>> NOTE:
>> The DT binding changes for this patch has been posted along with the
>> driver ath12k AHB series.
>> Link: https://lore.kernel.org/all/20250130043508.1885026-1-quic_rajkbhag@quicinc.com/
>>
>> v2:
>> - Dropped 'dt-bindings: net: wireless: describe the ath12k AHB module'.
>>   This DT binding is posted along with the ath12k AHB driver changes.
>> - Reserved four memory regions required by IPQ5332 ath12k firmware in DTS.
>>   These memory regions are also referenced in the WiFi node.
>> - Moved 'qcom,smem-states' and 'qcom,smem-states' to the ipq5332.dtsi file.
>> - Used lowercase hex values for the reg property.
>>
>> v1: https://lore.kernel.org/all/20250128091012.2574478-1-quic_rajkbhag@quicinc.com/
>> ---
>>  arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts |  64 ++++++++++-
>>  arch/arm64/boot/dts/qcom/ipq5332.dtsi       | 113 ++++++++++++++++++++
>>  2 files changed, 176 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
>> index 846413817e9a..4b7a75e450ca 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
>> +++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
>> @@ -2,7 +2,7 @@
>>  /*
>>   * IPQ5332 AP-MI01.2 board device tree source
>>   *
>> - * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
>> + * Copyright (c) 2022-2025 Qualcomm Innovation Center, Inc. All rights reserved.
>>   */
>>  
>>  /dts-v1/;
>> @@ -12,6 +12,61 @@
>>  / {
>>  	model = "Qualcomm Technologies, Inc. IPQ5332 MI01.2";
>>  	compatible = "qcom,ipq5332-ap-mi01.2", "qcom,ipq5332";
>> +
>> +	/*                 Default Profile
> 
> Why is the title "Default Profile", is this expected to be changed by
> someone? At what point?
> 
>> +	 * +============+==============+=====================+
>> +	 * |            |              |                     |
>> +	 * | Region     | Start Offset |       Size          |
> 
> "Start Offset" relative to address 0 is typically called "base address".
> 
>> +	 * |            |              |                     |
>> +	 * +------------+--------------+---------------------+
>> +	 * |            |              |                     |
>> +	 * |            |              |                     |
>> +	 * |            |              |                     |
>> +	 * | WLAN Q6    |  0x4A900000  |       43MB          |
>> +	 * |            |              |                     |
>> +	 * |            |              |                     |
>> +	 * +------------+--------------+---------------------+
>> +	 * | M3 Dump    |  0x4D400000  |       1MB           |
>> +	 * +------------+--------------+---------------------+
>> +	 * | Q6 caldb   |  0x4D500000  |       5MB           |
>> +	 * +------------+--------------+---------------------+
>> +	 * | MLO        |  0x4DB00000  |       18MB          |
> 
> 18MB is the same size in your graph as the 1MB segment, but somehow the
> 43MB segment is 5 times the size of the 18MB segment. So the graph isn't
> to scale...
> 
>> +	 * +============+==============+=====================+
>> +	 * |                                                 |
>> +	 * |                                                 |
>> +	 * |                                                 |
>> +	 * |            Rest of memory for Linux             |
>> +	 * |                                                 |
>> +	 * |                                                 |
>> +	 * |                                                 |
>> +	 * +=================================================+
> 
> Doesn't DDR start on a more even address, such as 0x40000000? I presume
> the purpose of your picture was to give a good overview of the memory
> layout of this system, but the only thing it added to the table below is
> a curious question about what happened to the first 169MB of DDR.
> 

Yes this graph provide the overview for memory related to wireless
components(rproc and ath12k firmware memory).

> 
> Please omit the graph, it doesn't add value beyond what's provided by
> the below text form of the "same" data.
> 

Sure, will remove in next version.

>> +	 */
>> +
>> +	reserved-memory {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		q6_region: wcss@4a900000 {
>> +			reg = <0x0 0x4a900000 0x0 0x02b00000>;
>> +			no-map;
>> +		};
>> +
>> +		m3_dump: m3-dump@4d400000 {
>> +			reg = <0x0 0x4d400000 0x0 0x100000>;
>> +			no-map;
>> +		};
>> +
>> +		q6_caldb: q6-caldb@4d500000 {
>> +			reg = <0x0 0x4d500000 0x0 0x500000>;
>> +			no-map;
>> +		};
>> +
>> +		mlo_mem: mlo-global-mem@4db00000 {
>> +			reg = <0x0 0x4db00000 0x0 0x01200000>;
>> +			no-map;
>> +		};
>> +	};
>>  };
>>  
>>  &blsp1_i2c1 {
>> @@ -63,3 +118,10 @@ data-pins {
>>  		};
>>  	};
>>  };
>> +
>> +&wifi0 {
>> +	memory-region = <&q6_region>, <&m3_dump>, <&q6_caldb>, <&mlo_mem>;
>> +	memory-region-names = "q6-region", "m3-dump", "q6-caldb", "mlo-global-mem";
> 
> As you are resubmitting this, it would be nice to have these two
> properties wrapped (one entry per line), to increase readability...
> 

will update in next version.


