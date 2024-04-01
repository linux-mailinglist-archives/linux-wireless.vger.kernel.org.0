Return-Path: <linux-wireless+bounces-5721-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A878944A2
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 20:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7ECB1F22646
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 18:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF164D9F2;
	Mon,  1 Apr 2024 18:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M1QtgQMs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4FE4D9E9
	for <linux-wireless@vger.kernel.org>; Mon,  1 Apr 2024 18:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711994921; cv=none; b=gIO4T7wZ+IPBQZFvCoHjZ/xIdBSVEQ2V5X566UaXRFXEdyOl7lZgZS/z37CCn3g9RYNdutZo5gfVDLcNOjqvEdkdc3a0iPL60hPNtxZvz56rzqpfDHmznAFejK5N4BGRS8x2KNyFjTYbxctexOqBS6RdXm69QQdtbydTt3DC0wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711994921; c=relaxed/simple;
	bh=HUZMM3AKA9gQQ8Hw1LJeidroB0HuM4xmlMr1J5GyQg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RK/Aq/rDERgOtJu9qGKvnsR4t7CST7wqC1o3xU/z8LgRjIHkwajXwBoryT6tEDtOWCigbNoVA/kJtbPM1A5VpcP9z/97yHwr51qJ1c+CWzjDW/VHuhASyzbGufk2a6PK9Wj4x3sUGwU1uWPk2crHUTXJ/gExPtLa4oxEZ/B9mZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M1QtgQMs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 431GuwAK029404;
	Mon, 1 Apr 2024 18:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=9xMEW3+SVtFhufOnoKM3ox1bPVltq/fwZhGsuzloJB0=; b=M1
	QtgQMs72R7k0fsTYbO6fnPX/be3URkdIMp0yWXxNTNnd/dlqSIiF1wqA9Xc8Goe5
	Y8I9+ghk/hbf0VkEZ9869j/8aYYRdmnJKLXtmHc7F8ZNf+Kem3B9DNmZwxT1poE4
	S+wSUCwLSh3ZdSXY9oRs8mFTqp5W816yOxXRsy0vbaAb0vnA6nYTzSxzvdIcwUsj
	p42YhxnHcHdkBcvdaWsYxc0EPN3OXbw/8oLZwt7yDPWmk6PyUIs6HxUxSnFJPkFO
	S3zHFhcZNhts5mRaEAdhTodszGhrDPWau1CB5H04FFW4sZ8aasgJQBYCM1dfmHSC
	UiULUQJXMaWHAukR/Mjg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x80w5g72n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 18:08:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 431I8WSN031419
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Apr 2024 18:08:32 GMT
Received: from [10.227.91.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 1 Apr
 2024 11:08:32 -0700
Message-ID: <ea60844d-7d66-43a0-a298-2f89a6867318@quicinc.com>
Date: Mon, 1 Apr 2024 11:08:31 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] wifi: ath12k: add support for setting fixed HE
 rate/GI/LTF
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Muna Sinada <quic_msinada@quicinc.com>
References: <20240327170910.23975-1-quic_pradeepc@quicinc.com>
 <20240327170910.23975-8-quic_pradeepc@quicinc.com>
 <a217c752-65fb-4975-8208-c708a0ceeab8@quicinc.com>
Content-Language: en-US
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
In-Reply-To: <a217c752-65fb-4975-8208-c708a0ceeab8@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BAwA91PtSBykupOyznrsnuoXGUJZeL5i
X-Proofpoint-ORIG-GUID: BAwA91PtSBykupOyznrsnuoXGUJZeL5i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_12,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404010127



On 3/29/2024 2:34 PM, Jeff Johnson wrote:
> On 3/27/2024 10:09 AM, Pradeep Kumar Chitrapu wrote:
>> Add support to set fixed HE rate/GI/LTF values using nl80211.
>> Reuse parts of the existing code path already used for HT/VHT
>> to implement the new helpers symmetrically, similar to how
>> HT/VHT is handled.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>
>> Co-developed-by: Muna Sinada <quic_msinada@quicinc.com>
>> Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
>> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/mac.c | 588 ++++++++++++++++++++++++--
>>   drivers/net/wireless/ath/ath12k/wmi.h |  18 +
>>   2 files changed, 562 insertions(+), 44 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>> index 46ef2d63a3de..72232285d2b1 100644
>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> [...]
>> @@ -3888,8 +4130,9 @@ static void ath12k_sta_rc_update_wk(struct work_struct *wk)
>>   	mutex_lock(&ar->conf_mutex);
>>   
>>   	nss = max_t(u32, 1, nss);
>> -	nss = min(nss, max(ath12k_mac_max_ht_nss(ht_mcs_mask),
>> -			   ath12k_mac_max_vht_nss(vht_mcs_mask)));
>> +	nss = min(nss, max3(ath12k_mac_max_ht_nss(ht_mcs_mask),
>> +			    ath12k_mac_max_vht_nss(vht_mcs_mask),
>> +			    ath12k_mac_max_he_nss(he_mcs_mask)));
> 
> When I run this entire series through ath12k-check I'm getting the following
> issue here:
> 
> drivers/net/wireless/ath/ath12k/mac.c:4170:15: error: too long token expansion
> drivers/net/wireless/ath/ath12k/mac.c:4170:15: error: too long token expansion
> 
> caeed0eb7fb4d (Pradeep Kumar Chitrapu 2024-03-27 10:09:07 -0700 4170)   nss = min(nss, max3(ath12k_mac_max_ht_nss(ht_mcs_mask),
> 
> I don't see anything wrong with the code.
> 
> Even stranger is that when this series is in place, I see this same issue at
> another place:
> drivers/net/wireless/ath/ath12k/mac.c:7903:23: error: too long token expansion
> drivers/net/wireless/ath/ath12k/mac.c:7903:23: error: too long token expansion
> 
> But that is actually pre-existing code from the original ath12k driver drop:
> d889913205cf7 (Kalle Valo             2022-11-28 17:09:53 +0200 7903)          nss = min_t(u32, ar->num_tx_chains,
> 
> And the issue is not flagged when this series is not present.
> 
> However that same logic also caused the same issue in ath11k, and Kalle fixed
> it there with:
> https://lore.kernel.org/all/20231214161740.1582340-1-kvalo@kernel.org/
> 
> And one of the MediaTek drivers encountered a similar issue here:
> https://lore.kernel.org/all/5457b92e41909dd75ab3db7a0e9ec372b917a386.1710858172.git.lorenzo@kernel.org/
> 
> So there is definitely a tooling issue here.
> 
> As a local test I added an intermediate step and now I don't see the issue
> here:
> -       u32 changed, bw, nss, smps, bw_prev;
> +       u32 changed, bw, nss, mac_nss, smps, bw_prev;
> ...
> -       nss = min(nss, max3(ath12k_mac_max_ht_nss(ht_mcs_mask),
> -                           ath12k_mac_max_vht_nss(vht_mcs_mask),
> -                           ath12k_mac_max_he_nss(he_mcs_mask)));
> +       mac_nss = max3(ath12k_mac_max_ht_nss(ht_mcs_mask),
> +                      ath12k_mac_max_vht_nss(vht_mcs_mask),
> +                      ath12k_mac_max_he_nss(he_mcs_mask));
> +       nss = min(nss, mac_nss);
> 
> So let's add something like that in v3 (perhaps pick a better name)
> 
> (Even with this I still see the other issue from the original driver drop so
> we may need to separately propagate the ath11k driver change to ath12k).
> 
> /jeff
> 
> 
Sure Jeff, thanks for the details..will address in next revision

