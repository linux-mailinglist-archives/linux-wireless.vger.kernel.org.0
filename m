Return-Path: <linux-wireless+bounces-6936-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1668B42C4
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Apr 2024 01:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5449A282027
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 23:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499233B782;
	Fri, 26 Apr 2024 23:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bA2zcwAD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C393A1CD
	for <linux-wireless@vger.kernel.org>; Fri, 26 Apr 2024 23:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714174953; cv=none; b=QfoqbPVRDgXhbnvNt6C4RPg6V65uDkwA1GmqTGFFhbvmKBaucJE/nLPnEK8wqpcB2rEgTdnVKfoXrQnFFSw24ZK6XToHfRBYGv+F3aPD4uVhAcIynxsymcpad1Rnwc2XWJn9W31SNs61+dakIX6JqIwn6CiI6xJ+kcE5tuStvZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714174953; c=relaxed/simple;
	bh=xQ5cvB/IykyVHlBrVv5nAv3hMHJuVl5MICkmoWEKdfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=R9Y6uDL5fuDiM5a12QoXl19BRzUOaIz1CfuSbldrgbIVToIrh/usAGQu3Aeqm/YrDY35qM3foAIjlx3OuSdMPSoRDi1qccUQEwBPbW6pY7tOWy+Vy0vsZk5JgvQhz3iGFLpONR2wMZZrr5lpLtM9/P+T1whUSSn3QtGDh266fBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bA2zcwAD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43QMTfum026679;
	Fri, 26 Apr 2024 23:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=aRY/RZMc/3INa+zmPsFIGXrzZeeosFmug48uKm0/Iho=; b=bA
	2zcwADef2wQxLCTqHgydvJ7ve14VSr8GOjUGpM7B2d6hF8yIAV/Qo21bhFJ7+L0y
	/fTK4BcRjBoYRt8ngeLp/H4KzuijPsOEHDKWPuSWETyrFiezV3TfIgLpDz+5451U
	zvSUfiacaX9Zr0L3Yjiv48PM6KddLXUwB52KaZRUA31ydkSsyPHKSE/ukP1smcOk
	46XsjUQl/c40zMktBtiWmahGmTUcw9kxyXlO9OzOflQ6KaWnVwDS1WOeQLAFa74B
	Yu3ODpPR6Cft1+SFlc8yy4zvgVYwizyXstDHPogJnRmBhnqWHml45ROrZHpxwcB3
	fROYicCEGxCmrU01tEJw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xr88fhvjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 23:42:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43QNgNQD014138
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 23:42:23 GMT
Received: from [10.227.91.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 26 Apr
 2024 16:42:22 -0700
Message-ID: <198e317f-a849-4fe2-8080-3d1834d07481@quicinc.com>
Date: Fri, 26 Apr 2024 16:42:22 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] wifi: ath12k: add support for setting fixed HE
 rate/GI/LTF
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        "Muna
 Sinada" <quic_msinada@quicinc.com>
References: <20240424201959.935-1-quic_pradeepc@quicinc.com>
 <20240424201959.935-8-quic_pradeepc@quicinc.com>
 <72bc6772-8bf7-427d-8f03-01e8dbf30d0c@quicinc.com>
 <87y190fulv.fsf@kernel.org>
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
In-Reply-To: <87y190fulv.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Np6wtzd7dsvfKjCt2n7XefWjG8mXNSSP
X-Proofpoint-GUID: Np6wtzd7dsvfKjCt2n7XefWjG8mXNSSP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_20,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404260167



On 4/26/2024 12:31 AM, Kalle Valo wrote:
> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
> 
>> On 4/24/2024 1:19 PM, Pradeep Kumar Chitrapu wrote:
>>> Add support to set fixed HE rate/GI/LTF values using nl80211.
>>> Reuse parts of the existing code path already used for HT/VHT
>>> to implement the new helpers symmetrically, similar to how
>>> HT/VHT is handled.
>>>
>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>>
>>> Co-developed-by: Muna Sinada <quic_msinada@quicinc.com>
>>> Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
>>> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
>>> ---
>>
>> [...]
>>
>>> @@ -7753,7 +8034,20 @@ ath12k_mac_bitrate_mask_get_single_nss(struct ath12k *ar,
>>>   			return false;
>>>   	}
>>>   
>>> -	if (ht_nss_mask != vht_nss_mask)
>>> +	he_mcs_map = le16_to_cpu(ath12k_mac_get_tx_mcs_map(&sband->iftype_data->he_cap));
>>
>> drivers/net/wireless/ath/ath12k/mac.c:8041:22: warning: incorrect type in argument 1 (different address spaces)
>> drivers/net/wireless/ath/ath12k/mac.c:8041:22:    expected struct ieee80211_sta_he_cap const *he_cap
>> drivers/net/wireless/ath/ath12k/mac.c:8041:22:    got struct ieee80211_sta_he_cap const [noderef] __iftype_data *
> 
> ALWAYS run ath12k-check, we wrote the tool for a reason. Skipping these
> tests is disrespect for maintainers' time and a great way to get your
> patches to the bottom of the queue.
> 
Hi Kalle

I did run ath12k-check but I don't see these errors. Trying to see if 
this is due to version differences. will update further once I have more 
information on this.

This is version I ran:
qca-swiss-army-knife/tools/scripts/ath12k/ath12k-check --version
ath12k-check (md5sum cb8a85242f2ec7343f6f94af9fa5ebb2)

python:         3.6.9 (default, Mar 10 2023, 16:46:00)
[GCC 8.4.0]
host gcc:       gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
config cc:      gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
sparse:         v0.6.4
checkpatch.pl:  Version: 0.32 (md5sum 12ea394e9bf27280f30a684ff937cc57)
gtags:          gtags (GNU GLOBAL) 6.6.2


I see some notes like below this in all files:
drivers/net/wireless/ath/ath12k/mac.c: note: in included file (through 
include/linux/bitops.h, include/linux/kernel.h, include/net/mac80211.h):
drivers/net/wireless/ath/ath12k/mac.c: note: in included file (through 
include/linux/bitops.h, include/linux/kernel.h, include/net/mac80211.h):

Thanks
Pradeep

