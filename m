Return-Path: <linux-wireless+bounces-8071-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3058CF87D
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 06:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAC16B22431
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 04:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E2979E1;
	Mon, 27 May 2024 04:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="piJ5dvK9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D8E2F4A
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 04:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716785052; cv=none; b=FVk7JQPs03AOT2TYzjnfDPVJ08rA9vB17zJ89B7JjvabgN2Tpef18IEMKhhOfXiT9PqIg9GAhQzDfJzZpNo5HZFpXMSHu0+R4FOfdRq79LfHW/COHOBbOX6M9LUvNsxUJNcuCei4RaBePvwbFtjjFSzULz+nGYLpaW6Bb2Q1H+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716785052; c=relaxed/simple;
	bh=Y4AWEpIGHhNnsAPfKRHGtvEnif0EEYBgBl4YaJ367/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lLjKYvUmMWAv0vLm+wCOsZEIBi3cNIT91Ln5Z0P7/NhnUhCjh7IxDFP/ewtjbwWMR+cJ844wsYRFLJzoF0kRlQtXlL8DNwh8phOAsJLTRoJ8GwriUdoUdEUZKWCrpG9a+8GY6PvCAI7AWdHOJmVtJMycp9B9reFtF+GDuWs6+/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=piJ5dvK9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44R0Qs6l014491;
	Mon, 27 May 2024 04:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BxXoftpsQbbJzWdxegDrPAtMKsSXw07brHUmKfr9UeI=; b=piJ5dvK9hT8OaSVr
	s110/7wIAjgNmwmeyGTgbyYUqr2WKQK+WpS8G1dXAJAPYK+znqw29Rg4UW8BLTxU
	hq6vtRmgV0TrG0SOl6qkTSOtFXegb0vTfyQqAzrEvHcuSw2Al92YWDI8PhPBxJxM
	iNSWm1x73eRFlX24kL0YWZ8K/fq4B4lMowlCrMTu9jiHc+G8YUQrpGhKw4BfWb0o
	BkYH0GT1oB7dKgU3NycdtDJOnbhNyxjCTnEhqPDP64C3moFUfZBF5vRH9rT8PEkZ
	8IyqAgtLRc0cDCHkhiRVozpsVHwOgl6QLvpva8fUsckAi9LXzJe16jSSGFzVly6d
	YKKMBQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba0pjken-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 04:44:06 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44R4i2K3022280
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 04:44:02 GMT
Received: from [10.152.206.169] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 26 May
 2024 21:44:00 -0700
Message-ID: <78b640af-22ae-8dcc-e086-25f3a9bd79c6@quicinc.com>
Date: Mon, 27 May 2024 10:13:57 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH v5 8/8] wifi: ath12k: move ath12k_hw from per soc to group
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
References: <20240522095439.2596989-1-quic_hprem@quicinc.com>
 <20240522095439.2596989-9-quic_hprem@quicinc.com>
 <d981696e-0ce2-43c2-8877-68ead0743dd3@quicinc.com>
Content-Language: en-US
From: Harshitha Prem <quic_hprem@quicinc.com>
In-Reply-To: <d981696e-0ce2-43c2-8877-68ead0743dd3@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yUE7unRGYo3CLMSP5p2FXLKzrIgrhPt1
X-Proofpoint-GUID: yUE7unRGYo3CLMSP5p2FXLKzrIgrhPt1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-26_09,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 adultscore=0 phishscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405270036



On 5/23/2024 1:28 AM, Jeff Johnson wrote:
> On 5/22/2024 2:54 AM, Harshitha Prem wrote:
>> From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>>
>> Currently, hardware abstractions (ah) of different radio bands
>> are tightly coupled to a single device (ab). But, with hardware
>> device group abstraction (ag), multiple radios across different
>> devices in a group can possibly form different combinations of
>> hardware abstractions (ah) within the group. Hence, the mapping
>> between ah to ab can be removed and instead it can be mapped with ag.
>>
>> Please find below illustration of how mapping between ath12k_hw (ah),
>> ath12k_base (ab) and ath12k_hw_group (ag) is changed.
>>
>>          current mapping of hardware abstraction (ah) with device (ab)
>>              +------------------------------------------------+
>>              |  +-------------------------------------+       |
>>              |  | +---------------+ +---------------+ |       |
>>              |  | |ath12k_hw (ah) | |ath12k_hw (ah) | |       |
>>              |  | +---------------+ +---------------+ |       |
>>              |  |                                     |       |
>>              |  |  +-----------+ |   +-----------+    |       |
>>              |  |  | ar (2GHz) | |   | ar (5GHz) |    |       |
>>              |  |  +-----------+ |   +-----------+    |       |
>>              |  |          Dual band device-1 (ab)    |       |
>>              |  +-------------------------------------+       |
>>              |    ath12k_hw_group (ag) based on group id      |
>>              +------------------------------------------------+
>>
>>                  After, with hardware device group abstraction
>>                  (moving ah array out of ab to ag)
>>              +----------------------------------------------+
>>              |   +---------------+  +---------------+       |
>>              |   |ath12k_hw (ah) |  |ath12k_hw (ah) |       |
>>              |   +---------------+  +---------------+       |
>>              |  +-------------------------------------+     |
>>              |  | +-----------+     +-----------+     |     |
>>              |  | | ar (2GHz) |     | ar (5GHz) |     |     |
>>              |  | +-----------+     +-----------+     |     |
>>              |  |     Dual band device-1 (ab)         |     |
>>              |  +-------------------------------------+     |
>>              |   ath12k_hw_group (ag) based on group id     |
>>              +----------------------------------------------+
>>
>> This decoupling of ath12k_hw (ah) from ath12k_base (ab) and mapping it
>> to ath12k_hw_group (ag) will help in forming different combinations of
>> multi-link devices.
>>
>> Say for example, device 1 has two radios (2 GHz and 5 GHz band) and
>> device 2 has one radio (6 GHz).
>>
>> In existing code -
>>          device 1 will have two hardware abstractions hw1 (2 GHz) and
>>          hw2 (5 GHz) will be registered separately to mac80211 as phy0
>>          and phy1 respectively. Similarly, device 2 will register its
>>          hw (6 GHz) as phy2 to mac80211.
>>
>> In future, with multi-link abstraction
>>
>>          combination 1 - Different group id for device1 and device 2
>>                  Device 1 will create a single hardware abstraction hw1
>>                  (2 GHz and 5 GHz) and will be registered to mac80211 as
>>                  phy0. similarly, device 2 will register its hardware
>>                  (6 GHz) to mac80211 as phy1.
>>
>>          combination 2 - Same group id for device1 and device 2
>>                  Both device details are combined together as a group, say
>>                  group1, with single hardware abstraction of radios 2 GHz,
>>                  5 GHz and 6 GHz band details and will be registered to
>>                  mac80211 as phy0.
>>
>> Hence, Add changes to decouple ath12k_hw (ah) from ath12k_base (ab) and
>> map it to ath12k_hw_group (ag).
>>
>> Refactor the following APIs to help simplify the registration based on
>> ath12k_hw_group (ag) rather than ath12k_base (ab)
>>          * ath12k_mac_allocate()
>>          * ath12k_mac_destroy()
>>          * ath12k_mac_register()
>>          * ath12k_mac_unregister()
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 

Thanks Jeff.

With this patch seeing below smatch error:

drivers/net/wireless/ath/ath12k/mac.c:8918 ath12k_mac_hw_allocate() 
error: uninitialized symbol 'ab'.
   CC [M]  drivers/net/wireless/ath/ath12k/reg.o
   CHECK   drivers/net/wireless/ath/ath12k/reg.c

Will fix it in next patchset.

Regards,
Harshitha

