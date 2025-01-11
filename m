Return-Path: <linux-wireless+bounces-17352-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D39FBA0A21B
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jan 2025 10:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A173A4FAB
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jan 2025 09:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075BA10E9;
	Sat, 11 Jan 2025 09:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OKwBiy53"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6058624B259
	for <linux-wireless@vger.kernel.org>; Sat, 11 Jan 2025 09:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736586173; cv=none; b=Rz7OLkHV6ZBuLtW/eI3FyBg7/wIs94yBs9lbBtzRMZbO2n2wSPvo14GHO4z7exTaaaq4rQJyZlZ4K+HA+91tqVijHjAxGeenC9O5kNFJH7QwmnFaZtspSSUe4L9r7bcZcSK5TcvmUHV8qBjlf48Xr+CMGBqGvI+qXWzUDQZXvFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736586173; c=relaxed/simple;
	bh=AUH6BGaSbCCKvc1kqPbQvGTXToRCreih1Ne09r9ORFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KU/mPfmQbw9zC8X/9Gj73RC7l1WDDBFbCriStGtsgUKE5R8AaOatyTkk85u6HxLS4WhHHIdMVxVX4UcxTuIJ+Hyyhi1VlZm3ByMCm0/TtHsBYTFCOjeYoPLomYIsvSeuQrsNmWCoNxP74cNci4NdaSm5cEFEH5rdfBGEA5lkXM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OKwBiy53; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50B7dTOC031896;
	Sat, 11 Jan 2025 09:02:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	phBm/zXx8cQ4rAo80BdajRgd+tCVQ4reg+jTZDHmAZ0=; b=OKwBiy53rV3jcDB6
	QdbaE1TEBaThL6k3gm7lJfnEWRe3JC3w/nQrVkWbumSFVvrdhJyRr86y/qWEUbUp
	3JBeTElhLSImINqf5nGDKkEQ/eHQgr2tzx12YJjltIevKUw8QeoPHKJwd0C4vDhW
	KnGP+0jwRlJm99/U4SB1qOkyDVDiW8wDTos8d0tPaHv+YktWw7pT23/yo9k1UlIh
	/JqnZevdnGg34GTNqnIG5uOYVtP7Hfa8Dqmu2imF2O8lKIuY0AI7we8Z+0u9usiY
	rtp2eQooEarUIn+9aL2dFgNusdtc4dGrJh+UWzpowDQ66VVXR82+e5jkm6C1TcYL
	H+xdyQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 443htgr9sy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Jan 2025 09:02:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50B92m0E002724
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Jan 2025 09:02:48 GMT
Received: from [10.50.23.147] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 11 Jan
 2025 01:02:46 -0800
Message-ID: <159a6ef4-2f4d-626e-9705-feb8fb3bfec6@quicinc.com>
Date: Sat, 11 Jan 2025 14:32:42 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 3/4] wifi: ath12k: Refactor ath12k_get_num_hw() helper
 function argument
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
References: <20241217035920.2683568-1-quic_periyasa@quicinc.com>
 <20241217035920.2683568-4-quic_periyasa@quicinc.com>
 <8c756343-af71-4e8e-ae9f-6681159e90e9@oss.qualcomm.com>
Content-Language: en-US
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <8c756343-af71-4e8e-ae9f-6681159e90e9@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Dn92OqUhHdC3xyKJsNE1khVaqdrc1dVJ
X-Proofpoint-ORIG-GUID: Dn92OqUhHdC3xyKJsNE1khVaqdrc1dVJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501110077



On 1/10/2025 9:42 PM, Jeff Johnson wrote:
> On 12/16/2024 7:59 PM, Karthikeyan Periyasamy wrote:
>> Currently, the ath12k_get_num_hw() helper function takes the device handle
>> as an argument. Here, the number of hardware is retrieved from the group
>> handle. Demanding the device handle from the caller is unnecessary since
>> in some cases the group handle is already available. Therefore, change this
>> helper function argument from the device handle to the group handle. This
>> also fixes the below Smatch static checker warning.
>>
>> Smatch warning:
>> ath12k_mac_destroy() error: we previously assumed 'ab' could be null
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>>
>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>> Closes: https://lore.kernel.org/ath12k/3e705de0-67d1-4437-97ff-4828d83ae2af@stanley.mountain/
>> Closes: https://scan7.scan.coverity.com/#/project-view/52682/11354?selectedIssue=1602340
>> Fixes: a343d97f27f5 ("wifi: ath12k: move struct ath12k_hw from per device to group")
>> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>> ---
> 
> ...
> 
>> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
>> index 6b31e053d6da..f37a50f3eabb 100644
>> --- a/drivers/net/wireless/ath/ath12k/core.h
>> +++ b/drivers/net/wireless/ath/ath12k/core.h
>> @@ -1209,9 +1209,9 @@ static inline void ath12k_ag_set_ah(struct ath12k_hw_group *ag, int idx,
>>   	ag->ah[idx] = ah;
>>   }
>>   
>> -static inline int ath12k_get_num_hw(struct ath12k_base *ab)
>> +static inline int ath12k_get_num_hw(struct ath12k_hw_group *ag)
>>   {
>> -	return ab->ag->num_hw;
>> +	return ag->num_hw;
> 
> since there is no longer multiple indirection perhaps we should just get rid
> of this and directly use ag->num_hw at all call sites, especially given that
> there are already places that do this:
> 
> drivers/net/wireless/ath/ath12k/core.c: for (i = 0; i < ag->num_hw; i++) {
> drivers/net/wireless/ath/ath12k/mac.c:  for (i = 0; i < ag->num_hw; i++) {
> drivers/net/wireless/ath/ath12k/mac.c:  for (i = 0; i < ag->num_hw; i++) {
> 
Sure, will fix in the next version of the patch.

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

