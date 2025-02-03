Return-Path: <linux-wireless+bounces-18291-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B244A2556F
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 10:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1651161F11
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 09:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7148E1FDE29;
	Mon,  3 Feb 2025 09:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QgEtN3pR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9003F1A270;
	Mon,  3 Feb 2025 09:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738573556; cv=none; b=l5Q4KPPJy00CuHgHogSEmWx0uDPuTMJy1y/BCP8mBolCaGCZ7Lftj+TGpx4iKeEb5ALudejFa+41Tbu1mysSZk5qW91WmoITRekH8rxJM9yQ7Z1MofzqFLbJhF2kSjG2qLL9SG1Eq7bBmB62vNSyhtvWuCfnSqJvUuQ710I0xhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738573556; c=relaxed/simple;
	bh=FF0AYy7QO4wAppz+BTEHxQ8EQD+ttCMNis84es56hb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AsvaZeWJ83VQt630EgwIXc+SNQYiyvInQupJmyuERIzk3lQToiCvWhqUWko48w3zZ8aUXWXRmwA+PxMdrxf8uJhErp6H7Zooas6t22itmrJkN6tG+Ww11/zrohJkOxu9L7cf4CgZxTm6jKO5+EBV4gfNIHEIc0xDm2H6Vld1qbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QgEtN3pR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5135OiAi000874;
	Mon, 3 Feb 2025 09:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cV5qVf3KEl2mKoV6KdKVtnjnoxdRcDLKf/ZGrf//YiE=; b=QgEtN3pRRXyiHuM0
	67MPQxFj9e0NFoGssmje7xW1tX6zAUuNqMoBsZiQMjnMrVZylVUxvgY4wkeswSkC
	bz/WpD10ijntB4lTvdo9Ki4dhR5K/qytjc+0j33ktrz/V0EhuUf2rUrFsI4X8+E7
	u6Dmbg5coGxbWPm6WIRwxtRlO2Gl5oc1md+iCAp3dlgYUpvVK12/+pCCLMvAP74w
	Uq06bFgOXqnk+ur6onX5N1bscmNtF9VVsST/gYTFhbHVh5WjJ/s2r2bPr3Z3spCa
	8iwSwBKMzUYT6dDqZQ0BhKBbaI496V/I53/kB9YQMEgcRgfEafTHOjmNGjGj4DwR
	g3laxQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44jqm40ex0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 09:05:48 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51395ll8026043
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Feb 2025 09:05:47 GMT
Received: from [10.216.42.141] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Feb 2025
 01:05:44 -0800
Message-ID: <724a4822-469a-45bb-bfb1-c02b54e971a3@quicinc.com>
Date: Mon, 3 Feb 2025 14:35:41 +0530
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
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <20250130-cunning-quail-of-opportunity-76d0ad@krzk-bin>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VPpC0vgZfiIO8bQBVN4TbmeZz2zgh_7x
X-Proofpoint-ORIG-GUID: VPpC0vgZfiIO8bQBVN4TbmeZz2zgh_7x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_03,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=822 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502030072

On 1/30/2025 1:58 PM, Krzysztof Kozlowski wrote:
>> +  memory-region:
>> +    description:
>> +      phandle to a node describing reserved memory (System RAM memory)
>> +      used by ath12k firmware (see bindings/reserved-memory/reserved-memory.txt)
> Do not say what DT syntax is, so "phandle to a node" is redundant,
> reserved-memory.txt is redundant. The only useful part here is "used by
> ath12k firmware", so based on this none of below are used by the driver
> and driver just passes them to the firmware?
> 

Sure, will rephrase the description.

These reserved memory-regions are utilized by the ath12k firmware. The ath12k driver
stores these memory addresses solely for the purpose of collecting crash dumps
(RAM dumps) when the firmware encounters a crash.

>> +    items:
>> +      - description: Q6 memory region
>> +      - description: m3 dump memory region
>> +      - description: Q6 caldata memory region
>> +      - description: Multi Link Operation (MLO) Global memory region
>> +
>> +  memory-region-names:
>> +    description:
>> +      Name of the reserved memory region used by ath12k firmware
> Drop description.
> 

Sure.

>> +    items:
>> +      - const: q6-region
>> +      - const: m3-dump
>> +      - const: q6-caldb
>> +      - const: mlo-global-mem
>> +
>> +  qcom,ath12k-calibration-variant:
>> +    $ref: /schemas/types.yaml#/definitions/string
> Why this is named after ath12k? Why this is just not
> "qcom,calibration-variant"? None of the other properties have ath12k in
> their names, so why this one in the WSI schema was named like that?
> 

This property is added after the below comment.
https://lore.kernel.org/all/qzjgpwemwaknwbs3dwils6kaa5c3inabfvkaryvc32kblzfhy3@6yduooj4dk63/

This `ath12k` in the name of this property is inherited from the 'qcom,ath10k.yaml' and
'qcom,ath11k.yaml'. Same was followed for WSI schema as well.

>> +    description:
>> +      String to uniquely identify variant of the calibration data for designs
>> +      with colliding bus and device ids
> I don't think this property is here possible. How could you have on the
> same SoC different devices?

The WiFi controller in the SoC includes an internal or external Front-End Module (FEM).
These FEMs can vary and require different calibration data. This property uniquely
identify the variant of calibration data required by a FEM.


