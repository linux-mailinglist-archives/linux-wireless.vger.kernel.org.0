Return-Path: <linux-wireless+bounces-18297-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30009A256E7
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 11:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEECB165D8D
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 10:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E38B200BB9;
	Mon,  3 Feb 2025 10:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Z0P5jlAp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADDA1E7C0E;
	Mon,  3 Feb 2025 10:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738578488; cv=none; b=d0+ipS+HvpcmLIpQdYt2F8G19DnW83eDuJAkEIT1YvcyB4NlZkbW9UqIsi9PtqpV7rmVWetmVtVRHDYn6x0P0rmkmk8SAKG8hpCiRV+IXMO53EWIGwJSrTI4XTyYtWwOnMsmTf3Krz2WBpxSabJM4kG/4BBNBp3//KSseihmTCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738578488; c=relaxed/simple;
	bh=HM9co9bHk3fz6yhzYqHJ2p5kWjd1y6fPfQIMblAplFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JCzoElCCjZCfN5czE25NbiWusFLDwg4Bf2JKVmtHv/EhiiSOK9BOJ1UpEdEWzooLqLAatENU0ztqUxkZvIhUDcaFidCawrVC2FSbU36hGsmrSF4xr/8eUKWTISwNvuABZNNb9K0Fh9TtRnJ2Qvk1HFsr5Ntk0PfPVuWXHgzAblo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Z0P5jlAp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 512MxSs3005964;
	Mon, 3 Feb 2025 10:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6x8BAunRvsjNsAkzeigQzLsRnDaLSX8GrXI9PQGXuhg=; b=Z0P5jlApR87jwpR/
	JvpCtZD7NT2qguc941qD803+UVnSrfXctufSmGm8x13X7zgaI/rZ8cWzP8O4mxbA
	uKOxqHFKxkr4HpkYQUiFreeky8l5CUPn/zArMikRVdFKHRlEjJ7FpFbSicJ7GbGO
	hPgUjgsCwXy/nx407+1IbFM4Vp4LA+VenmnR2WyqqnWWAWsWmMbEzxg+fAWLoplT
	/PGymaWRqQkY1AIFSEbzO9zJJd1DlezglgW4wv/Z/qsdEGwUwmQ8pi9epp++SKxx
	rl/R81q8P0mjCNVtOm+FaKUXAJShHeidqHAhtiPbcP15SAo3W6y/IiC80m4hYgdD
	0o5qow==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44jd429bh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 10:27:59 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 513ARwNC024654
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Feb 2025 10:27:58 GMT
Received: from [10.216.42.141] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Feb 2025
 02:27:55 -0800
Message-ID: <b4276ac3-42a5-4a9f-83b1-875721d483d9@quicinc.com>
Date: Mon, 3 Feb 2025 15:57:52 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/13] dt-bindings: net: wireless: describe the ath12k
 AHB module
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Kalle Valo
	<kvalo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jeff Johnson
	<jjohnson@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250130043508.1885026-1-quic_rajkbhag@quicinc.com>
 <20250130043508.1885026-2-quic_rajkbhag@quicinc.com>
 <20250130-cunning-quail-of-opportunity-76d0ad@krzk-bin>
 <104e6b6f-3c1e-4a00-8822-aa6fb4562411@kernel.org>
 <a3c7b0e6-a440-4452-83a2-eb95de0de9bc@quicinc.com>
 <7b57f8c8-7d0b-46f8-8364-a13860ab530e@kernel.org>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <7b57f8c8-7d0b-46f8-8364-a13860ab530e@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yJcKrWY2_aG_p9Gq0oZ-j5LSCDEeeCKR
X-Proofpoint-ORIG-GUID: yJcKrWY2_aG_p9Gq0oZ-j5LSCDEeeCKR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_04,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 malwarescore=0
 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502030080

On 2/3/2025 3:35 PM, Krzysztof Kozlowski wrote:
> On 03/02/2025 09:43, Raj Kumar Bhagat wrote:
>> On 1/30/2025 2:10 PM, Krzysztof Kozlowski wrote:
>>> On 30/01/2025 09:28, Krzysztof Kozlowski wrote:
>>>> On Thu, Jan 30, 2025 at 10:04:56AM +0530, Raj Kumar Bhagat wrote:
>>>>> Add device-tree bindings for the ATH12K module found in the IPQ5332
>>>>> device.
>>>>>
>>>>> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
>>>>> ---
>>>>>  .../net/wireless/qcom,ath12k-ahb.yaml         | 319 ++++++++++++++++++
>>>>>  1 file changed, 319 insertions(+)
>>>>>  create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..bd953a028dc3
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
>>>>
>>>> Filename should match compatible. This binding does not look like
>>>> supporting more devices, so there is no much benefit calling it by generic name.
>>>
>>>
>>> I saw now your other patchset, so you have here two devices, but I still
>>> do not understand why this cannot follow standard naming practice like
>>> most bindings supporting one or more devices. Like every review we give.
>>>
>>
>> Sure, we can rename the filename to match the compatibles - "qcom,ipq5x-wifi.yaml".
> 
> No:
> 
>>>> Filename should match compatible.
> 
> 

Ok, will rename to - "qcom,ipq5332-wifi.yaml"

