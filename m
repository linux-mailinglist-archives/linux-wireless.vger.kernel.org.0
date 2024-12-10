Return-Path: <linux-wireless+bounces-16201-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 103D29EBEB8
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 23:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E92E280EB2
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 22:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AEE1AA786;
	Tue, 10 Dec 2024 22:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dFa3abYS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09491F1902
	for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 22:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733871499; cv=none; b=Q78eFsaj8HNmi9JxZ1lhy1jhBAbpw8GI4gwGwTrqP0LEy6cd9r1menkOYe85RBnoLpJS+4KIc8uZBHdyKb+MslpflwdItB5k8PZjPppFwAj6LVH0hcl8uo2813X+n57DWZ1JjRBr758EM4SpmtR/N3Q0TY1DgNVSZ8F5GN4tUYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733871499; c=relaxed/simple;
	bh=Kw7rYIPWl6n7kjwypCSn6jwZIpCzkXDjSFZKIk6JVao=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Zlf0GRirSESrE7O1qHjBXI/C/zjGOsQfySoNwfDDsdIv/ctyBu6IlV7drXcIc0kDUuFJ3aGrCfQf7oifCn4pXuqIoQh7pmsPTf+Dqmt+VhcazngWI9la6K0p3GAgTG31oBUQz9Gdd+RXfZrM/bAyTRxbPGOPx3IfOCuoVltkbzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dFa3abYS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BADSscc014600;
	Tue, 10 Dec 2024 22:58:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FshelQAc48t2W/JRJ3MjsJ/F6sjJqhKuxQ8OXIrd+vM=; b=dFa3abYSASQbzBQV
	3ca5GGhY8U7nedXgsU1fLX2YGwGAFNvK1fIoDjgaKWUpZwmVdXL1Rf6py4j9Pjyr
	H209ewKvRCcqIXpCv9JvS6hetlWPab9VeCscJbMdUNOkEuYCDISzsJ6yWZ+cn/XP
	KAL444Bj8vko9hQr+eun11khvTjHe9Ig35WOT9jtO37hHZhVWgIU2uftE4g94BHX
	KtpShozSiaiS69qKiCQBQBMGha+U6aPIWdhYArRBpX3rMmAx04+NdCegmat2LZPR
	qY/0ma/dtT0xCwZjDKkngoD5Ovn7UzTyC+Cz175oL0oiwBLLV0phGYYKtf8GmUx3
	+h33uQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ee3nb0ce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 22:58:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BAMvx4J011203
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 22:57:59 GMT
Received: from [10.111.177.199] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 10 Dec
 2024 14:57:58 -0800
Message-ID: <2c80be7f-c680-4d05-bf8b-33828b98e856@quicinc.com>
Date: Tue, 10 Dec 2024 14:57:57 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] wifi: ath12k: move struct ath12k_hw from per device
 to group
To: Kees Bakker <kees@ijzerbout.nl>, Kalle Valo <kvalo@kernel.org>,
        <ath12k@lists.infradead.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        Harshitha Prem <quic_hprem@quicinc.com>,
        "Jeff
 Johnson" <jeff.johnson@oss.qualcomm.com>
CC: <linux-wireless@vger.kernel.org>
References: <20241204163216.433795-1-kvalo@kernel.org>
 <20241204163216.433795-6-kvalo@kernel.org>
 <bfd41680-060f-4bd8-a289-f4ef69429c30@ijzerbout.nl>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <bfd41680-060f-4bd8-a289-f4ef69429c30@ijzerbout.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1USOJ8PtJ0vdVKpmQj5UQLGF0lu49VQJ
X-Proofpoint-ORIG-GUID: 1USOJ8PtJ0vdVKpmQj5UQLGF0lu49VQJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 mlxlogscore=759 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412100164

On 12/10/2024 12:58 PM, Kees Bakker wrote:
> Op 04-12-2024 om 17:32 schreef Kalle Valo:
>> From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>>
>> Currently, hardware abstractions (ah) of different radio bands are tightly
>> coupled to a single device (ab). But, with hardware device group abstraction
>> (ag), multiple radios across different devices in a group can form different
>> combinations of hardware abstractions (ah) within the group. Hence, the mapping
>> between ah to ab can be removed and instead it can be mapped with struct
>> ath12k_hw_group (ag).
>> [...]
>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>> [...]
>> -void ath12k_mac_destroy(struct ath12k_base *ab)
>> +void ath12k_mac_destroy(struct ath12k_hw_group *ag)
>>   {
>>   	struct ath12k_pdev *pdev;
>> +	struct ath12k_base *ab = ag->ab[0];
>> +	int i, j;
>>   	struct ath12k_hw *ah;
>> -	int i;
>>   
>> -	for (i = 0; i < ab->num_radios; i++) {
>> -		pdev = &ab->pdevs[i];
>> -		if (!pdev->ar)
>> +	for (i = 0; i < ag->num_devices; i++) {
>> +		ab = ag->ab[i];
>> +		if (!ab)
>>   			continue;
>>   
>> -		pdev->ar = NULL;
>> +		for (j = 0; j < ab->num_radios; j++) {
>> +			pdev = &ab->pdevs[j];
>> +			if (!pdev->ar)
>> +				continue;
>> +			pdev->ar = NULL;
>> +		}
>>   	}
>>   
>>   	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
>> @@ -10942,26 +10945,59 @@ void ath12k_mac_destroy(struct ath12k_base *ab)
>>   	}
>>   }
>>   
> The new ath12k_mac_destroy() looks suspicious with respect to "ab".

There is already a patch in the internal pipeline to address this linux-next
Coverity CID

