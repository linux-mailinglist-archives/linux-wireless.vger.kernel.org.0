Return-Path: <linux-wireless+bounces-16711-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA059FAA16
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 06:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20524164BF2
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 05:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6F078C91;
	Mon, 23 Dec 2024 05:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g4QMOzcQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1158E848C
	for <linux-wireless@vger.kernel.org>; Mon, 23 Dec 2024 05:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734933134; cv=none; b=F6gGB2IyvOwRJDFDhVf0DD732Nzu3C8x6X7P6SqbgGcOSNZdfuhDyBe95qSQytXPyR0zDfLiHixDfI9BXkAPM4Ryb9CQy6LrHKeWJxPfJWBYeE/IyiY7SbF4FmNDsXM5nMsou/00Y7nsshIzomnQ7L7SdrUppLj3PvQsv1NWVQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734933134; c=relaxed/simple;
	bh=bpiwK9J6peHsvBqzMiNvOvq90GOOpB7pKa78XRU6vmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=Dn37/KEcW8quhrbMgHbBR+Tbw59hUp3bjKxcIIOWf73wceEP+Xx3oKESmh10xcjWMCmx8Yuf0WMdckOX5Kr/6eJfo2bwlrBX+sezqbzAHkwi9yNJ4LJBrpUaGH3morlug/qNIT1zyDc/kTvoI77DKCKuIWo/k5EdBKc/3rc5VQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g4QMOzcQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BN3Cdhb007890;
	Mon, 23 Dec 2024 05:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IXCVZRigwx4iw2UGQod5yPNq2rDksO7iKjqAHBQ1Taw=; b=g4QMOzcQmg2E/jtH
	GDh5JNbHJmp8EXwKnijq4dZlNqCkpwmz7MvHEdhxROaCS/4+hGxWlamONCYPkYzs
	/yPJ5+d1iEqruXkwxrlVkZ8+FO5Xr3IpJVwbkoyUpsgrviZgTmv8ibpyHYBQcFo9
	vgAloZWtPJYj90Dt3Cf7kyz5/KbEanSAimcyJQJS9Ics2sw9pMfrobXVpdnihhNR
	7em7g0TqOIsazHn3kMO/tKtTUD/FWZPnLpM6Ens4QgauaSRbqvTfK9larPNInzsF
	VBNNYqYcTcQoYaR9QARQZsTSyySx68m7SHnn/XV2ffqXiTl3r9G1DSQiUBUYMkyq
	8Ev/7w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43pyrprg9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 05:52:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BN5q9HH007639
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 05:52:09 GMT
Received: from [10.50.9.211] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 22 Dec
 2024 21:52:07 -0800
Message-ID: <9b4b8604-02fe-446b-9db6-703381be9042@quicinc.com>
Date: Mon, 23 Dec 2024 11:22:04 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] wifi: ath12k: Avoid multiple times configuring
 monitor filter
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
References: <20241221043014.1252841-1-quic_ppranees@quicinc.com>
 <20241221043014.1252841-4-quic_ppranees@quicinc.com>
 <12dd8c67-9817-f189-738b-87d3533998c9@quicinc.com>
Content-Language: en-US
CC: <linux-wireless@vger.kernel.org>
From: Praneesh P <quic_ppranees@quicinc.com>
In-Reply-To: <12dd8c67-9817-f189-738b-87d3533998c9@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8ywiEfTifOWcwLqVn6dIx2OrJ95zByRw
X-Proofpoint-GUID: 8ywiEfTifOWcwLqVn6dIx2OrJ95zByRw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412230050

On 12/22/2024 10:45 AM, Karthikeyan Periyasamy wrote:
> 
> 
> On 12/21/2024 10:00 AM, P Praneesh wrote:
>> ath12k_mac_op_configure_filter() gets called multiple times during
>> interface bringup. Applying filter configuration from this function leads
>> to writing same filter configurations multiple times.
>>
>> Fix it by moving the filter configuration to ath12k_mac_op_start().
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481- 
>> QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/mac.c | 55 ++++++++++++++-------------
>>   1 file changed, 29 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/ 
>> wireless/ath/ath12k/mac.c
>> index 6f10813d9378..2cb6e9b529d7 100644
>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>> @@ -7237,8 +7237,34 @@ void ath12k_mac_drain_tx(struct ath12k *ar)
>>   static int ath12k_mac_config_mon_status_default(struct ath12k *ar, 
>> bool enable)
>>   {
>> -    return -EOPNOTSUPP;
>> -    /* TODO: Need to support new monitor mode */
>> +    struct htt_rx_ring_tlv_filter tlv_filter = {};
>> +    struct ath12k_base *ab = ar->ab;
>> +    u32 ring_id, i;
>> +    int ret = 0;
>> +
>> +    lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
>> +
>> +    if (!ab->hw_params->rxdma1_enable)
>> +        return ret;
>> +
>> +    if (enable)
>> +        tlv_filter = ath12k_mac_mon_status_filter_default;
> 
> No need to disable the filter in the else case like below ?
> 
> tlv_filter.rxmon_disable = true;
> 
> 
Yes, setting this flag to true fully disables the monitor ring. I'll 
include this change in the next version.

