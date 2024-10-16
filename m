Return-Path: <linux-wireless+bounces-14060-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEBC9A049A
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 10:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 747FFB20EE8
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 08:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0C11FCC6A;
	Wed, 16 Oct 2024 08:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kVIeTejc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D6A1865E2;
	Wed, 16 Oct 2024 08:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729068538; cv=none; b=SO7PVLwF5ib1snF6HX95FL02pk2Lq7PoGL8g0zt9Rtl4a3a0TCKEleJQCq4jKJgcbl5UCyIyuLxlEb6WhajXHyfozHDu6Xrj6Z+C07KvSX3bRBe8KhF/ObTKin2j/eoeX/ZxMYnI3BlXqJf+210/XtiKAYjKI+lNyaRM9nxZAeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729068538; c=relaxed/simple;
	bh=4VgZz4yLtQii/zVmyg9PHNVDdQYpnxH1Pv+8yYlKqxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BlN6XxNaAZAdKaQqqR9HWsVieLnnH4R4OCGCuOVsA1235nEPCpbvbccJnI0o+YWqK4Siu+qdvaTu7swbx1V30FMr1MDrPvDmuTCTVmKr+dUaa1M/ZmN3J8HXyORlDDC4oLhAjoT4iKTMuE5CYGnDUCahefDtvEQYM2cf269Evm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kVIeTejc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G8PuON014334;
	Wed, 16 Oct 2024 08:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4VgZz4yLtQii/zVmyg9PHNVDdQYpnxH1Pv+8yYlKqxM=; b=kVIeTejcPqWkS1cI
	rxdKdfprP5VIAukccatnHx3devfaHQuNx1LaNDVhYtJXWCwTZ0ca9TxqgEaeJYdh
	6DtVkBKnuU9Jd1yg3PnXJqFIA1sdiQdkFO2n33amqPcJvRYAko6nI5GGw1bth/Ar
	pqaLgCdYpXCTMOTs84N+19VaDQ5IcPB/W3A2U9/jQTPSSskWs0brnuKiOhDeZY8d
	AlVRg6DbumKysnnGscMAHg6FyDlD6vlvZx+z11rlXFBQw1CGj0ZRPhxWjFdlBpb+
	QZpOGhgKNF3sJFEgWwKzbXI/sjGBKvw5+ps4I1OlEh9CzX2ue9Odi/tXjSl7OU/y
	mwaISQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42a79h8jv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 08:48:50 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49G8mnYa006852
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 08:48:49 GMT
Received: from [10.50.26.161] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 16 Oct
 2024 01:48:44 -0700
Message-ID: <ed906492-a82a-4c20-9966-26d862ec03c4@quicinc.com>
Date: Wed, 16 Oct 2024 14:18:41 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/22] arm64: dts: qcom: add wifi node for IPQ5332
 based RDP441
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Kalle Valo
	<kvalo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jeff Johnson
	<jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20241015182637.955753-1-quic_rajkbhag@quicinc.com>
 <20241015182637.955753-3-quic_rajkbhag@quicinc.com>
 <ftvwsizfupm7veg662adnzc6jpulk5shga3xmvbtom3saclnf6@bmatmqw5lp72>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <ftvwsizfupm7veg662adnzc6jpulk5shga3xmvbtom3saclnf6@bmatmqw5lp72>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FqqHyzGn5_myvUH1deseV5_5ag_P7ZuJ
X-Proofpoint-ORIG-GUID: FqqHyzGn5_myvUH1deseV5_5ag_P7ZuJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=874 suspectscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410160058

On 10/16/2024 12:28 PM, Krzysztof Kozlowski wrote:
> On Tue, Oct 15, 2024 at 11:56:17PM +0530, Raj Kumar Bhagat wrote:
>> RDP441 is based on IPQ5332. It has inbuilt AHB bus based IPQ5332 WiFi
>> device.
>>
>> Describe and add WiFi node for RDP441. Also, reserve the memory
>> required by IPQ5332 firmware.
>>
>> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> Don't send one DTS patch in 22 patchset targetting different subsystem.
> Imagine, how wireless maintainers are supposed to apply their bits? 21
> commands instead of one command?

Sure, we can drop the DTS patch from this series. Will take this patch
separately once the binding (qcom,ath12k-ahb.yaml) is merged.

