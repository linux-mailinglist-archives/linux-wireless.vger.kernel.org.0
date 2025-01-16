Return-Path: <linux-wireless+bounces-17593-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF3FA1382F
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 11:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0534F166491
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 10:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2C81DD0DC;
	Thu, 16 Jan 2025 10:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Kor24XFT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0CF24A7C0;
	Thu, 16 Jan 2025 10:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737024199; cv=none; b=k0fRAwworfQ18bqKC9NYuAcDir1s+JO4M6E50i2nYM39Sj9E90XRu6+z5q2I2FzQo6BSUwyHzZbBL1HxlpcQ7txwWY7KaefxsqqtgvHZcnMHGHgMtg58BGVHIYlDiSpU113/NXh3nXyuPTJXarQnGCGck9/Ynhl4x8evE9VoLB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737024199; c=relaxed/simple;
	bh=qzLYkv99ids61r6ZJB9zr1ZGXY5g196993+VoWquJFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EpWC0rMHThNsDSuIKWMT1kg7aASltZCVghCEuZDNPzc99AIUPAlxX1HYqetZTHkNfVk0g/aotgrgJ8Dq+6ofwQ+0n+YJyf+Uk82JdtmQvsnjKa/6q71jseftzcbcJnfEX1vPf3dYI7f6ehMKBiTcdd51lv8Tg/PQVnatR2qU08Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Kor24XFT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50G87Uvc001394;
	Thu, 16 Jan 2025 10:43:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ECbOBzjUQRkQI9B/o0Q8yKm3RwdtExjB74ks2Y5YniI=; b=Kor24XFTqtpbQ6wv
	5U06y1MV/cgK1ovBIo3BxYNoq3qlLHMaCUBhwRjoelPmwGRhTI+z4gR2Gz/UufW5
	bfd5OFTDMaCniRMHLYcvK0BLtTM7/GCpihC5cQbT8An5BpOY4CCy5T+auPYy26wX
	vXnlayQmi8rY6Z3TW5FZnpBcDxcqftPJLs5fP2Dwq4Sw94zgKtyU56QdtjjzrW+t
	rjKHDGzUf1LDXUO8JD9wVw7BLKjChv9Vmm4tqHPfoV803hbkVO8Whr9enM3eUthT
	/CWiDaOHt9RrON4UCsVChqSqr4lJ6T8fLKGFtXyfAZYhApIvRPZREKaOMjkLHdRH
	IOy+oA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 446xay8dp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 10:43:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50GAhBSL002074
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 10:43:11 GMT
Received: from [10.216.35.176] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 16 Jan
 2025 02:43:07 -0800
Message-ID: <4ef04d75-5ac8-4db4-8cde-25f9e097b020@quicinc.com>
Date: Thu, 16 Jan 2025 16:13:03 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] wifi: ath12k: fix firmware assert during reboot
 with hardware grouping
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Kalle Valo
	<kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        "Karthikeyan
 Periyasamy" <quic_periyasa@quicinc.com>,
        Harshitha Prem
	<quic_hprem@quicinc.com>
CC: Kalle Valo <quic_kvalo@quicinc.com>, <linux-wireless@vger.kernel.org>,
        <ath12k@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250109-fix_reboot_issues_with_hw_grouping-v1-0-fb39ec03451e@quicinc.com>
 <20250109-fix_reboot_issues_with_hw_grouping-v1-4-fb39ec03451e@quicinc.com>
 <5925d874-1b8c-413a-a6ad-16d7ab299f4e@oss.qualcomm.com>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Content-Language: en-US
In-Reply-To: <5925d874-1b8c-413a-a6ad-16d7ab299f4e@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fh1dj5W5nidUwb0t-GANLJXj_6MTECh-
X-Proofpoint-ORIG-GUID: fh1dj5W5nidUwb0t-GANLJXj_6MTECh-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_04,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501160079

On 1/14/25 00:42, Jeff Johnson wrote:
> On 1/8/2025 8:25 PM, Aditya Kumar Singh wrote:
>> At present, during PCI shutdown, the power down is only executed for a
>> single device. However, when operating in a group, all devices need to be
>> powered down simultaneously. Failure to do so will result in a firmware
>> assertion.
>>
>> Hence, introduce a new ath12k_pci_hw_group_power_down() and call it during
>> power down. This will ensure that all partner devices are properly powered
>> down.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Aditya Kumar Singh<quic_adisi@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/pci.c | 23 ++++++++++++++++++++++-
>>   1 file changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
>> index 837be309cd45a2d037ee8c3bba8f7be0f457d6b2..7f6521a56ffc0f1e9687c94d6829a9c1f1887661 100644
>> --- a/drivers/net/wireless/ath/ath12k/pci.c
>> +++ b/drivers/net/wireless/ath/ath12k/pci.c
>> @@ -1751,13 +1751,34 @@ static void ath12k_pci_remove(struct pci_dev *pdev)
>>   	ath12k_core_free(ab);
>>   }
>>   
>> +static void ath12k_pci_hw_group_power_down(struct ath12k_hw_group *ag)

> don't you end up calling this for every device in the group?
> what prevents ath12k_pci_power_down(ab, false) from being called multiple
> times for the same ab?

That's true. ath12k_pci_power_down() has logic already that if device is 
powered down, it will ignore the further call. This is handled via 
previous patch.

-- 
Aditya

