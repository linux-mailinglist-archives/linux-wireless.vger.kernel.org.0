Return-Path: <linux-wireless+bounces-6817-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2078B1AFC
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 08:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C18671C20DA9
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 06:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDDA40877;
	Thu, 25 Apr 2024 06:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SCKeMfyp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5C23EA9B
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 06:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714026411; cv=none; b=NdeEe7jVZq0DeSpmKVNte1UbjSDnZ0HoveUrQsuk5QQCN+43M4bM85lmbj0j+n2e19PgOYA18qvoGZV/5yaGtMNfvFIIDYtg3sJgspe9vNpcXziG6a5AVQIA19CxnN9vttZo6JwwHLQZ8/WQgULfTnShxC/nVlLyaeh7W8E27uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714026411; c=relaxed/simple;
	bh=/+ZPPKGgL0viSYIlgnD2KwdMZxLzXPvBKSUTwJOktvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dM2BWo5faii8x2RfVYTm6rbVQI8CWc0IeL0kaTPWuXrteykZrgWrLm1P7miJtpEmnjeD5zVHfE/iHDKPf/qspvxhF+5aTnq6jxewrE6dCDlqclb7ENyG2dZUODQfriQkWIrS5hQHOw1eRrhxayrS0SYA88Pvbr7RzXsY9/CSUSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SCKeMfyp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P2iqgd001267;
	Thu, 25 Apr 2024 06:26:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=exQqQwxq8GkPVwvWbdiHxuFTO2STTztbSYgfFenx+N4=; b=SC
	KeMfyptMSsoMrHy6t6o9tNDmUB8qH1dlTtUVxXYVFtqLiVx0t4pjc2P4hY8VZB9X
	odFH3cNbBm82uaCp/vT2NY4LlOSXiOk8O9MwCFedlgKUVZ/w3l8XDAE+YsI032zj
	1xrAYrb89II5RlSVAqmAVwwQO/j718UA/kpWp+U+VvwjuClzefQ/9acpkKyVNGV2
	TSYiXBF5HfikyTRAapP2Q9ZgEKeJfRfLdxByu2yhiX1qAVd7gJdo6trxY0i7KOmb
	Rd3IHBL3FIO9uxwGCha0VeKOSGk4NvV3upSm+MWm2xI0BVY3UC68eM7gpZnBdBKW
	JLgdFMnjzFY+RamYrN3Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenhrfrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 06:26:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43P6Qh44020710
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 06:26:43 GMT
Received: from [10.152.205.142] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Apr
 2024 23:26:42 -0700
Message-ID: <871c57f1-bc8f-1526-b63f-43892452413c@quicinc.com>
Date: Thu, 25 Apr 2024 11:56:38 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/3] wifi: ath12k: Refactor the hardware recovery
 procedure
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240424065646.1666166-1-quic_periyasa@quicinc.com>
 <20240424065646.1666166-2-quic_periyasa@quicinc.com>
 <7813db11-2445-4af3-910f-f3232af873aa@quicinc.com>
Content-Language: en-US
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <7813db11-2445-4af3-910f-f3232af873aa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 02k7xnv3JKNXbW7XUzu2FZQ8q6NqQe11
X-Proofpoint-GUID: 02k7xnv3JKNXbW7XUzu2FZQ8q6NqQe11
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_04,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 mlxlogscore=624 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404250044



On 4/25/2024 1:50 AM, Jeff Johnson wrote:
> On 4/23/2024 11:56 PM, Karthikeyan Periyasamy wrote:
>> Currently, in multi-wiphy models, the recovery handler access mac80211
>> HW from the radio/link structure. This will be incorrect for single wiphy
>> model, as they will hold multiple link/radio structures. To fix this,
>> access mac80211 HW based on the number of hardware in the SoC/chip. This
>> approach makes the recovery handler compatible with both multi wiphy and
>> single wiphy models.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> [...]
>> @@ -1006,35 +1005,34 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
>>   		set_bit(ATH12K_FLAG_CRASH_FLUSH, &ab->dev_flags);
>>   
>>   	for (i = 0; i < ab->num_hw; i++) {
>> -		if (!ab->ah[i])
>> +		ah = ab->ah[i];
>> +		if (!ah)
>>   			continue;
>>   
>> -		ah = ab->ah[i];
>>   		ieee80211_stop_queues(ah->hw);
>> -	}
>>   
>> -	for (i = 0; i < ab->num_radios; i++) {
>> -		pdev = &ab->pdevs[i];
>> -		ar = pdev->ar;
>> -		if (!ar || ar->state == ATH12K_STATE_OFF)
>> -			continue;
>> +		for (j = 0; j < ah->num_radio; j++) {
>> +			ar = &ah->radio[j];
>> +			if (!ar || ar->state == ATH12K_STATE_OFF)
> 
> remove !ar test, result of & operation can't be NULL
> 

sure, will address this comment in the next version of the patch.


>> +				continue;
> 

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

