Return-Path: <linux-wireless+bounces-7622-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB9F8C4AC1
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 03:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BE7D1F22E53
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 01:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762A3ED8;
	Tue, 14 May 2024 01:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gU2GwGKj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFFC524F
	for <linux-wireless@vger.kernel.org>; Tue, 14 May 2024 01:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715648864; cv=none; b=gMJkjY7rTPnH3AoX9zCW2b+lzK9d822Sru0R0haoahCl5iILEHy7a4a9WMdxAH4qIsNTnMPUPNz5bSW+shM3SdLTmS2oekBsTm27tY0uGkdNToCeA+p8Rlsen5bUAD21NNODXkex5D2l18Gy60BkU6ubBkLBN1wFX5XvPn6ff/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715648864; c=relaxed/simple;
	bh=0/L6/IT3OORQABL0XMlMYGxSjsc52fq09lvFopTNAsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GPxBJlC+tV91+zXSiGGzBD23hpnwKM0ocFL0ZnwGTiouD0xSqQiVjf6z2MOR9Hmdrtn3lnLf2XyaWaioVNKuRWiNfWm712fd+xhF5sVrb93Cxo83/UmnC4KsQUw0QgDKw91A+Xdy1hhwAzgYkNfBdkA0UT2rWI9WclEmoKZIawg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gU2GwGKj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44DJ8UDl020184;
	Tue, 14 May 2024 01:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=RZKMFLv2/uWBoJL9opmL++HtiEmi5Sfi5xujSRujoyI=; b=gU
	2GwGKjieW1tvyk9E7we2uNVhVYAO8P0FNcNTcXW0kon22t50O4RN1kJC4ZME5aIE
	cmXMaNmSpoWh6WVd/zOej/kJWBibFRaWwsUa85RpfqN7jPaw3xbEIOVg/g5AMcxy
	jbaveZeurcDvZ7a16mETAMosZOemZ2LnN3goiIuGjBG5xgQenvrssyd71bEub1Ya
	p0jFg8gO/yQAsIvvd9skCw5cB9rrV0A0FgR/nVMPIoIMdsUHNnwXbPsYo/RMIxAf
	uRMS5QXAI99jjk8hHF0OVo5Ez1CDZEP60s91MuxZBb2Gyy/izZobRwJuiQd3OQ7w
	M5LNxNg53MxkTSqUcymA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y21y7vurm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 01:07:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44E17YuK013617
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 01:07:34 GMT
Received: from [10.50.45.137] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 13 May
 2024 18:07:32 -0700
Message-ID: <23354bb4-4d12-da14-1764-ea71ab05ff45@quicinc.com>
Date: Tue, 14 May 2024 06:37:29 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] wifi: ath12k: use correct MAX_RADIOS
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240511013644.3103905-1-quic_periyasa@quicinc.com>
 <20240511013644.3103905-3-quic_periyasa@quicinc.com>
 <7916534b-ee14-4b95-b339-d614ce9393f1@quicinc.com>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <7916534b-ee14-4b95-b339-d614ce9393f1@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: b80ZGCVYLC-_Tn2IkhnMKjuenfQfsAfG
X-Proofpoint-GUID: b80ZGCVYLC-_Tn2IkhnMKjuenfQfsAfG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_17,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405140006



On 5/14/2024 5:01 AM, Jeff Johnson wrote:
> On 5/10/2024 6:36 PM, Karthikeyan Periyasamy wrote:
>> The current value of the MAX_RADIOS define is 3. However, this value is
>> incorrect as the maximum number of radios supported by all devices does
>> not exceed 2. Therefore, the MAX_RADIOS define should be modified to 2.
> 
> Use imperative tense: Therefore, modify ...
> 

Sure, will modify in the next version.

> What is the observed problem, if any, with the current code?
> 

No problem observed but it leads to unnecessary space allocated for the 
hw links in the group and also it gives incorrect perspective to the 
code reader that ath12k support max three radio platform.

>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/wmi.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
>> index 496866673aea..27bec3800bff 100644
>> --- a/drivers/net/wireless/ath/ath12k/wmi.h
>> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
>> @@ -4770,7 +4770,7 @@ struct wmi_probe_tmpl_cmd {
>>   	__le32 buf_len;
>>   } __packed;
>>   
>> -#define MAX_RADIOS 3
>> +#define MAX_RADIOS 2
>>   
>>   #define WMI_SERVICE_READY_TIMEOUT_HZ (5 * HZ)
>>   #define WMI_SEND_TIMEOUT_HZ (3 * HZ)
> 

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

