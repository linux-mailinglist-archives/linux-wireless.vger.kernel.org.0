Return-Path: <linux-wireless+bounces-16354-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9B19F0503
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 07:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9658416A510
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 06:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08650188907;
	Fri, 13 Dec 2024 06:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hnMcZSQK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC0A18785D
	for <linux-wireless@vger.kernel.org>; Fri, 13 Dec 2024 06:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734072387; cv=none; b=Pem91uVzCVHeVTPnvJdg6qyVxyl0LEbnHOihR4Ms7a0txpLzkNw0DJydd7orXXyYM3pUA2M19dK5XzN0dn3f6tJETSlpSivVC2aWcIIeBxC5uZOnMHM0/HisKmQJcSVRUT+j9kN4wYnPIJlo/G1+5UzGEz/1mDTfhRqAetJGLM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734072387; c=relaxed/simple;
	bh=RgqXYy1exuGWcyzdDll8oeNDgwkUUEsaRK2K3vlITMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IpHxUBC4lxt7OiDTAkkAuP9q/RliT0zLhvvUiIQU0tUK/TJ6vxtJLUhosAmYo1/H1BzXaWMF8zEIYhCTGyaSMZT6HQrHcsIBhkmNSG0P6s08JGlX15WRNcLfNf+hJs/iwkXjNX3F+q3ZdbJvuJwVh3q2l+uICQw2Ku++UhlDxV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hnMcZSQK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD6MD6b026852;
	Fri, 13 Dec 2024 06:46:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7oqBkIztTMd+a0ITaA1ANvdOI20jM+UGGbXNGNgQhu0=; b=hnMcZSQKNlMaUmqb
	68B0wLDENaGA1jU9xaQYA0YNf8YLX+Cp+7f7YGPPQEB8oJlOMVH8FX8F7xT3FiaC
	X/oYponx0ILdrKJnWHaSas8YtfEcJ/koJGRrbxITyNQLtzqD/zsBv/fK1R7rF3nU
	/Og0mcetwU22GqwLux5HdpOKh+r0DutQrzvSSQ/4uMm6TD8sHn+FKyEVvJDlR+L9
	jiY6fFqrHKAKYx8n5f2FM7oCva9u0iDCVrujTZF3v8jGEb3nLCz2ZgYyxPdOiyAG
	AIP/G7CiePI/GwzSfP4SxZtMEnAmKhzD8yCCj/mxXy1vhVNUxIGpkbDXCAi+pbVH
	kvCeHQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fd40nbes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 06:46:18 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BD6kDgb026577
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 06:46:13 GMT
Received: from [10.110.46.166] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 12 Dec
 2024 22:46:12 -0800
Message-ID: <07734404-b737-4a8c-ae24-f8b0b8c16e58@quicinc.com>
Date: Fri, 13 Dec 2024 14:46:10 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] wifi: ath11k: move update channel list to worker
 for wait flag
To: Kalle Valo <kvalo@kernel.org>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20241129070714.226-1-quic_kangyang@quicinc.com>
 <20241129070714.226-3-quic_kangyang@quicinc.com> <87y10lngf1.fsf@kernel.org>
Content-Language: en-US
From: Kang Yang <quic_kangyang@quicinc.com>
In-Reply-To: <87y10lngf1.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VrB9COWG6suFogTu1dDNCpfIni3U88Bx
X-Proofpoint-ORIG-GUID: VrB9COWG6suFogTu1dDNCpfIni3U88Bx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 suspectscore=0 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130047



On 12/12/2024 10:07 PM, Kalle Valo wrote:
> Kang Yang <quic_kangyang@quicinc.com> writes:
> 
>> From: Wen Gong <quic_wgong@quicinc.com>
>>
>> When wait flag is set for ath11k_reg_update_chan_list(), it will wait
>> the completion of 11d/hw scan if 11d/hw scan is running.
>>
>> With the previous patch "wifi: ath11k: move update channel list from
>> update reg worker to reg notifier", ath11k_reg_update_chan_list() will
>> be called when reg_work is running. The global lock rtnl_lock will be
>> held by reg_work in the meantime. If the wait_for_completion_timeout()
>> is called due to 11d/hw scan is running, the occupation time of
>> rtnl_lock will increase. This will increase blocking time for other
>> threads if they want to use rtnl_lock.
>>
>> Move update channel list operation in ath11k_reg_update_chan_list() to
>> a new worker, then the wait of completion of 11d/hw scan will not
>> happen in reg_work and not increase the occupation time of the rtnl_lock.
>>
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
>>
>> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
>> Co-developed-by: Kang Yang <quic_kangyang@quicinc.com>
>> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> 
> Same here, I think the commit message should be more or less rewritten.
> 
>> --- a/drivers/net/wireless/ath/ath11k/core.h
>> +++ b/drivers/net/wireless/ath/ath11k/core.h
>> @@ -743,6 +743,10 @@ struct ath11k {
>>   	struct completion bss_survey_done;
>>   
>>   	struct work_struct regd_update_work;
>> +	struct work_struct channel_update_work;
>> +	struct list_head channel_update_queue;
>> +	/* protects channel_update_queue data */
>> +	spinlock_t channel_update_lock;
> 
> Do you really need a new lock? Why not use data_lock?

Seems data_lock is OK, will change in next version.

> 
>> @@ -6318,6 +6320,15 @@ static void ath11k_mac_op_stop(struct ieee80211_hw *hw, bool suspend)
>>   	}
>>   	spin_unlock_bh(&ar->data_lock);
>>   
>> +	spin_lock_bh(&ar->channel_update_lock);
> 
> Empty line here, please.
> 
>> +	while ((params = list_first_entry_or_null(&ar->channel_update_queue,
>> +						  struct scan_chan_list_params,
>> +						  list))) {
>> +		list_del(&params->list);
>> +		kfree(params);
>> +	}
> 
> Here also empty line.
> 
>> +	spin_unlock_bh(&ar->channel_update_lock);
>> +
>>   	rcu_assign_pointer(ar->ab->pdevs_active[ar->pdev_idx], NULL);
>>   
>>   	synchronize_rcu();
> 
> [...]
> 
>> +void ath11k_regd_update_chan_list_work(struct work_struct *work)
>> +{
>> +	struct ath11k *ar = container_of(work, struct ath11k,
>> +					 channel_update_work);
>> +	struct scan_chan_list_params *params;
>> +	struct list_head local_update_list;
>> +	int left;
>> +
>> +	INIT_LIST_HEAD(&local_update_list);
>> +
>> +	spin_lock_bh(&ar->channel_update_lock);
>> +	while ((params = list_first_entry_or_null(&ar->channel_update_queue,
>> +						  struct scan_chan_list_params,
>> +						  list))) {
>> +		list_del(&params->list);
>> +		list_add_tail(&params->list, &local_update_list);
>> +	}
>> +	spin_unlock_bh(&ar->channel_update_lock);
> 
> What about list_splice_tail_init() or similar?

Seems list_splice_tail_init() is better. The time complexity is O(1).👍

> 
>> +
>> +	while ((params = list_first_entry_or_null(&local_update_list,
>> +						  struct scan_chan_list_params,
>> +						  list))) {
>> +		if (ar->state_11d != ATH11K_11D_IDLE) {
>> +			left = wait_for_completion_timeout(&ar->completed_11d_scan,
>> +							   ATH11K_SCAN_TIMEOUT_HZ);
>> +			if (!left) {
>> +				ath11k_dbg(ar->ab, ATH11K_DBG_REG,
>> +					   "failed to receive 11d scan complete: timed out\n");
>> +				ar->state_11d = ATH11K_11D_IDLE;
>> +			}
> 
> Empty line here.
> 


