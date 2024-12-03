Return-Path: <linux-wireless+bounces-15847-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEAA9E16EB
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 10:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0090F161176
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 09:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD551DE3BD;
	Tue,  3 Dec 2024 09:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BfWf3ptW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAFC1DB922;
	Tue,  3 Dec 2024 09:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733217190; cv=none; b=hpIcfLtF4FD6Unw54xy+hUBatHwog+KP6I5wdEQOBS9GFhQHB0rgVNii+yYl3jJrR2+GwVjqK5vbdc3/UG02+gP2nLYlkNB9WIKeyjs2MYRLXqQW4AdAZa2KJ8RO8MESEsF8U3DrEnm8H6Ea/FkhRtLUDiM6w4XnF4eP+byrKfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733217190; c=relaxed/simple;
	bh=XUH84e0egI5Kfw9FWhQHXx6YArW4ac5yEmTH0laDN8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZPIQilNJ3lR9mh975Bkqx4rYbt7pbKGkeg0Dtr0dDGYUIgBkRautH9UD8RN2ZqCedNNGSoomSiGDrR5vDZiRihIQ627ZxPKKkiJRzI118G0tpS0LOpVAqjx40zoI2Xh6eHpus5yhFIExHqxUzvPYduuhL7vOIrZipRT39Mb4qiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BfWf3ptW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B383AQs025674;
	Tue, 3 Dec 2024 09:13:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0KaoB5KjyuO+cWvVZwhloozjQT1ZeYOQtXDf2eB62T0=; b=BfWf3ptWqtx3B0+8
	6Lv8xQ5gtjOpbgGOpFtG2mR3mUIl9HsLy/dDjZ/a43A3zfiDBjfVJIBJmk1rs9An
	XojXd0wIabhRjVUVMUNMrL2IDW6AZr1on3lHhmPwUaDQBGmsgHi3+qO9zFjI6I8D
	hzMQtDwvv+kTxGWeOth8qzZoW7ZlLom6jYDJq5M4NbLovLlw5uh/mulzMj2WEBoj
	+6IGUjYbAgYTac2C/Msr9GOm95oLwSWZ+c7R3rtrzfYWPjZQEQIt0DtKgI+4wJ41
	Ba9PvExvyhiB8KedJKU129fV0Pso9ha8ZYdJ+KlZiYR4ityi+KinM1mLQaN9Frdd
	tATO4w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 437uvjyd2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 09:13:04 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B39D4UQ028352
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Dec 2024 09:13:04 GMT
Received: from [10.151.41.184] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Dec 2024
 01:12:59 -0800
Message-ID: <d7a001aa-f203-4e2d-8d39-615066e12969@quicinc.com>
Date: Tue, 3 Dec 2024 14:42:56 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/22] wifi: ath12k: fix incorrect CE addresses
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Balamurugan S <quic_bselvara@quicinc.com>
References: <20241015182637.955753-1-quic_rajkbhag@quicinc.com>
 <20241015182637.955753-13-quic_rajkbhag@quicinc.com>
 <af289022-218f-46fc-99c2-3ccf027bc8fe@oss.qualcomm.com>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <af289022-218f-46fc-99c2-3ccf027bc8fe@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: F8grdtWab1wLU11PK20TeYLn5fXgllGg
X-Proofpoint-ORIG-GUID: F8grdtWab1wLU11PK20TeYLn5fXgllGg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=949 impostorscore=0 adultscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412030079

On 10/19/2024 1:32 AM, Konrad Dybcio wrote:
> On 15.10.2024 8:26 PM, Raj Kumar Bhagat wrote:
>> From: Balamurugan S <quic_bselvara@quicinc.com>
>>
>> In the current ath12k implementation, the CE addresses
>> CE_HOST_IE_ADDRESS and CE_HOST_IE_2_ADDRESS are incorrect. These
>> values were inherited from ath11k, but ath12k does not currently use
>> them.
>>
>> However, the Ath12k AHB support relies on these addresses. Therefore,
>> corrects the CE addresses for ath12k.
>>
>> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
>> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
>> ---
> 
> This can be picked up independently of other patches in this patchset,
> please try to position such changes at the beginning of series.
> 

Sure, will have this patch in start of the series in the next version.


