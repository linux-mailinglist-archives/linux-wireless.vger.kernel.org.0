Return-Path: <linux-wireless+bounces-18249-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8336EA24302
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 19:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8763A8E76
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 18:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86401F03F5;
	Fri, 31 Jan 2025 18:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XwrIAYDm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144BE1F94A
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 18:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738349887; cv=none; b=PSBPrT5zAqaCcIidNONa2M4Gt/LRzGERlP9I7Wm5v76anR8KPkEX1OlMWVGmcKEILsgSK26xtFIVVWhaPLAvVlMyig/pbvebz7P3B2MsetCe/FLkrltWrj3DQvELPmbUNSMRghcwY4WalgHaVM+m8n89YQy3v7ScCOhlX/m2I+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738349887; c=relaxed/simple;
	bh=zCfqjyS9is/3VADedcltH0EknXDnY6swMymYatpKGE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JMRGIKAoHSaXR78nvwoRTVPVtT9fLZG7+RIFP5L7ZZ0yuomdxFofBxV3z7aQmvjyyAOdZGrzMDZ3Zj1+syjRoi7pNQGsv6Fc0PfBOtXEXTTjPcRlXFd+80APGK93B7FIVrodh1PJnrUAP8zOaQKBeGmdNYWwNs9kwFqyN/AKynU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XwrIAYDm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50VDKnKa009729
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 18:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oLDbiHlpfJ18BnR18sVa7sUQRAmt8z7Y3PSNpWT2GUY=; b=XwrIAYDmPpfzQtjL
	7r9dVo/s8eHnJm1JRUqX8j8fFW8jgNrg6qHPty6g/0P5Q2SwupfBLW7IZTsqj7gN
	IHa7uzKi6xwHy1fKwq+LpD1iGPVui9K2I+FbyCQHo44+7Nk/LyabiQVZ4386E9H0
	2rrb5GhURBz7cPncf72fDsoQm8kWYVaWZBwWAK6plPzrYqwTHGKD6kk7fUTNuWI6
	ZrMKpfxrvPHp9Ht5zCBQbqtwRfBC9zY3dq/0wIK/hI/8GxJw6DjwQOtjTJ61EJEl
	Hq4gFeOjmhRxyL2AU+UxQEVuKgbwM9aWzf5Bkcf2BkuPoEjsvYlI6JJNQvgbclks
	9EWQKQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44gyapgt54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 18:58:05 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ef775ec883so4521476a91.1
        for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 10:58:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738349884; x=1738954684;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oLDbiHlpfJ18BnR18sVa7sUQRAmt8z7Y3PSNpWT2GUY=;
        b=mLhuWpYo3mIZQba5jFLGz1jyZAqQGs8v95oXa/fEh2W/mEvwIyIZw1TOTX/0rMJQgg
         tQjdz81SeKbohKLrkMzCzg0UDTAoulaoyessfWQiQw+PT4yVll/rdj/wfdrPctGZD1Nw
         vfd8ftGw/T4d/W2OWmLpWGZN5R/35K8R6CsP6+gMxD9auqIS3fILi8FQjcaA9yKDPj+7
         PRgAGVy5RVyJpIhudgLg6GlQHux8jnIs24fKsDe8hk0rELUXNLSL6x1otpsLANTQ03xm
         6lIjJLo5NA3B9YrcjQkYtHfrgPO/l5V5+8KH7rAwY4IEHu8agG6NGQzgldR7vmtYHXwZ
         6/4Q==
X-Gm-Message-State: AOJu0YzSMQBmdr8tqXMp1YZCS97dGhh1iv4qY1OsJIfmF7YQlPjb+Bfq
	9BXPLYuCsAAg7X6KaSpHad3XKVo5pBU81X47yzzxDxPYcZC4N6gAxzmBhYW4g2jUVF5n068HYOt
	bPW1XpLrCiKfwxDx1kZjSmWCPLuVrlvsGkXIIpLkJKKRsoxlUXzxuv5Z13NMsGuLfOg==
X-Gm-Gg: ASbGncu09rudEHOkzbjsH7hStxJ3nULwVrJVgq9UyQhZDxKhfI66BtqIrjy+sL4J8fQ
	Wvu+FFul82GeJPI1L3Msu6GvihrXwk6oQkaV5Tv+KFz5w752JMjQ87pvfiiE1/fShngDDJZcHJi
	pJSRDYU29rQC+AWAAWvPGYIWyCQObaZRpeND3rRvoD1GsMyHqoc2g2tbZ1ECXvR2C6JjmANtFE2
	uRKrWERapiDCoHryd2YcyzKUG8HoZ6E2kD2W+zwyuJBnaF+Dzveg2lw5Ld+J3YPkeYjHdebBsQu
	XqU4REvHsS3Rdw6kd8585lhj6bOYOnaABAiJ+2pGOtDTYP/ZPJGh0w==
X-Received: by 2002:a05:6a00:99b:b0:725:f1b1:cb9f with SMTP id d2e1a72fcca58-72fd0c742abmr20067198b3a.20.1738349884150;
        Fri, 31 Jan 2025 10:58:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFr3K7E06kMstbxDbWlp6BKz/m6SVOfslOY5FKSAbowgJWllb4IreqZW4dj3Y7h8T+fnacSg==
X-Received: by 2002:a05:6a00:99b:b0:725:f1b1:cb9f with SMTP id d2e1a72fcca58-72fd0c742abmr20067165b3a.20.1738349883661;
        Fri, 31 Jan 2025 10:58:03 -0800 (PST)
Received: from [192.168.246.30] ([152.58.247.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cdda2sm3660738b3a.128.2025.01.31.10.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2025 10:58:03 -0800 (PST)
Message-ID: <7c05ab37-69cb-449b-af76-123c148fec5f@oss.qualcomm.com>
Date: Sat, 1 Feb 2025 00:27:57 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath12k: add get_txpower mac ops
To: Mahendran P <quic_mahep@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
References: <20250127172202.1410429-1-rameshkumar.sundaram@oss.qualcomm.com>
 <20250127172202.1410429-3-rameshkumar.sundaram@oss.qualcomm.com>
 <1dcc7a0a-1350-e761-2926-01c96c3a9e79@quicinc.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <1dcc7a0a-1350-e761-2926-01c96c3a9e79@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 6IDdgNUdvmTkv3-N4IkdWfK9hwZ5iAsF
X-Proofpoint-GUID: 6IDdgNUdvmTkv3-N4IkdWfK9hwZ5iAsF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_07,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2501310143



On 1/30/2025 11:55 AM, Mahendran P wrote:
> On 1/27/2025 10:52 PM, Rameshkumar Sundaram wrote:
>> From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
>>
>> Driver does not support get_txpower mac ops because of which
>> cfg80211 returns vif->bss_conf.txpower to user space. bss_conf.txpower
>> gets its value from ieee80211_channel->max_reg_power. However, the final
>> txpower is dependent on few other parameters apart from max regulatory
>> supported power. It is the firmware which knows about all these
>> parameters and considers the minimum for each packet transmission.
>>
>> All ath12k firmware reports the final TX power in firmware pdev stats
>> which falls under fw_stats. add get_txpower mac ops to get the TX power
>> from firmware leveraging fw_stats and return it accordingly.
>>
>> While at it, there is a possibility that repeated stats request WMI
>> commands are queued to FW if mac80211/userspace does get tx power back
>> to back(in Multiple BSS cases). This could potentially consume the WMI
>> queue completely. Hence limit this by fetching the power only for every
>> 5 seconds and reusing the value until the refresh timeout or when there
>> is a change in channel.
>>
>> Also remove init_completion(&ar->fw_stats_complete) in
>> ath12k_mac_hw_register() as ath12k_fw_stats_init() takes care of
>> it for each ar.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
>> Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/core.h |   1 +
>>   drivers/net/wireless/ath/ath12k/mac.c  | 155 +++++++++++++++++++------
>>   drivers/net/wireless/ath/ath12k/mac.h  |   3 +
>>   3 files changed, 123 insertions(+), 36 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
>> index e4f51ad6a59f..42da19870713 100644
>> --- a/drivers/net/wireless/ath/ath12k/core.h
>> +++ b/drivers/net/wireless/ath/ath12k/core.h
>> @@ -731,6 +731,7 @@ struct ath12k {
>>   	u32 mlo_setup_status;
>>   	u8 ftm_msgref;
>>   	struct ath12k_fw_stats fw_stats;
>> +	unsigned long last_tx_power_update;
>>   };
>>   
>>   struct ath12k_hw {
>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>> index 4fb7e235be66..54fe3a2c9c0b 100644
>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>> @@ -4280,6 +4280,120 @@ static int ath12k_start_scan(struct ath12k *ar,
>>   	return 0;
>>   }
>>   
>> +static int ath12k_mac_get_fw_stats(struct ath12k *ar, u32 pdev_id,
>> +				   u32 vdev_id, u32 stats_id)
>> +{
>> +	struct ath12k_base *ab = ar->ab;
>> +	struct ath12k_hw *ah = ath12k_ar_to_ah(ar);
>> +	unsigned long time_left;
>> +	int ret;
>> +
>> +	guard(mutex)(&ah->hw_mutex);
>> +
>> +	if (ah->state != ATH12K_HW_STATE_ON)
>> +		return -ENETDOWN;
>> +
>> +	spin_lock_bh(&ar->data_lock);
>> +	ar->fw_stats.fw_stats_done = false;
>> +	ath12k_fw_stats_free(&ar->fw_stats);
>> +	spin_unlock_bh(&ar->data_lock);
> rename ath12k_debugfs_fw_stats_reset and reuse instead of the above 4 lines

Sure, will do it in next version

>
>> +	reinit_completion(&ar->fw_stats_complete);
>> +
>> +	ret = ath12k_wmi_send_stats_request_cmd(ar, stats_id, vdev_id, pdev_id);
>> +
>> +	if (ret) {
>> +		ath12k_warn(ab, "failed to request fw stats: stats id %u ret %d\n",
>> +			    stats_id, ret);
>> +		return ret;
>> +	}
>> +
>> +	ath12k_dbg(ab, ATH12K_DBG_WMI,
>> +		   "get fw stat pdev id %d vdev id %d stats id 0x%x\n",
>> +		   pdev_id, vdev_id, stats_id);
>> +
>> +	time_left = wait_for_completion_timeout(&ar->fw_stats_complete, 1 * HZ);
>> +
>> +	if (!time_left)
>> +		ath12k_warn(ab, "time out while waiting for get fw stats\n");
>> +
> suggestion is to create a separate function and move some of the common code in ath12k_mac_get_fw_stats and ath12k_debugfs_fw_stats_request

Will move the wait logic from ath12k_debugfs_fw_stats_request() to 
ath12k_mac_get_fw_stats() and use the same on both places.

>
>> +	return ret;
>> +}
>> +
>> +static int ath12k_mac_op_get_txpower(struct ieee80211_hw *hw,
>> +				     struct ieee80211_vif *vif,
>> +				     unsigned int link_id,
>> +				     int *dbm)
>> +{
>> +	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
>> +	struct ath12k_fw_stats_pdev *pdev;
>> +	struct ath12k_hw *ah = hw->priv;
>> +	struct ath12k_link_vif *arvif;
>> +	struct ath12k_base *ab;
>> +	struct ath12k *ar;
>> +	int ret;
>> +
>> +	/* Final Tx power is minimum of Target Power, CTL power, Regulatory
>> +	 * Power, PSD EIRP Power. We just know the Regulatory power from the
>> +	 * regulatory rules obtained. FW knows all these power and sets the min
>> +	 * of these. Hence, we request the FW pdev stats in which FW reports
>> +	 * the minimum of all vdev's channel Tx power.
>> +	 */
>> +	lockdep_assert_wiphy(hw->wiphy);
>> +
>> +	arvif = wiphy_dereference(ah->hw->wiphy, ahvif->link[link_id]);
>> +	if (!arvif || !arvif->ar)
>> +		return -EINVAL;
>> +
>> +	ar = arvif->ar;
>> +	ab = ar->ab;
>> +	if (ah->state != ATH12K_HW_STATE_ON)
>> +		goto err_fallback;
>> +
>> +	if (test_bit(ATH12K_FLAG_CAC_RUNNING, &ar->dev_flags))
>> +		return -EAGAIN;
>> +
>> +	/* Limit the requests to Firmware for fetching the tx power */
>> +	if (ar->chan_tx_pwr != ATH12K_PDEV_TX_POWER_INVALID &&
>> +	    time_before(jiffies,
>> +			msecs_to_jiffies(ATH12K_PDEV_TX_POWER_REFRESH_TIME_MSECS) +
>> +					 ar->last_tx_power_update))
>> +		goto send_tx_power;
>> +
>> +	ret = ath12k_mac_get_fw_stats(ar, ar->pdev->pdev_id, arvif->vdev_id,
>> +				      WMI_REQUEST_PDEV_STAT);
>> +	if (ret) {
>> +		ath12k_warn(ab, "failed to request fw pdev stats: %d\n", ret);
>> +		goto err_fallback;
>> +	}
>> +
>> +	spin_lock_bh(&ar->data_lock);
>> +	pdev = list_first_entry_or_null(&ar->fw_stats.pdevs,
>> +					struct ath12k_fw_stats_pdev, list);
>> +	if (!pdev) {
>> +		spin_unlock_bh(&ar->data_lock);
>> +		goto err_fallback;
>> +	}
>> +
>> +	ar->chan_tx_pwr = pdev->chan_tx_power;
> It is better to divide and store
>
>> +	spin_unlock_bh(&ar->data_lock);
>> +	ar->last_tx_power_update = jiffies;
>> +
>> +send_tx_power:
>> +	/* tx power reported by firmware is in units of 0.5 dBm */
>> +	*dbm = ar->chan_tx_pwr / 2;
> based on the above comment, we dont need to do divide everytime here during repeated calls

Thanks for the suggestion, will do it in next version

>
>> +	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "txpower from firmware %d, reported %d dBm\n",
>> +		   ar->chan_tx_pwr, *dbm);
>> +	return 0;
>> +
>> +err_fallback:
>> +	/* We didn't get txpower from FW. Hence, relying on vif->bss_conf.txpower */
>> +	*dbm = vif->bss_conf.txpower;
>> +	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "txpower from firmware NaN, reported %d dBm\n",
>> +		   *dbm);
>> +	return 0;
>> +}
>> +
>>   static u8
>>   ath12k_mac_find_link_id_by_ar(struct ath12k_vif *ahvif, struct ath12k *ar)
>>   {
>> @@ -7433,6 +7547,7 @@ static int ath12k_mac_start(struct ath12k *ar)
>>   	ar->num_created_vdevs = 0;
>>   	ar->num_peers = 0;
>>   	ar->allocated_vdev_map = 0;
>> +	ar->chan_tx_pwr = ATH12K_PDEV_TX_POWER_INVALID;
> ar->chan_tx_pwr type u32..and assigning signed value. fix it.

Thanks for pointing out, will fix it by assigning u32 max for 
ATH12K_PDEV_TX_POWER_INVALID

>
>>   
>>   	/* Configure monitor status ring with default rx_filter to get rx status
>>   	 * such as rssi, rx_duration.
>> @@ -8638,6 +8753,7 @@ static int ath12k_mac_op_add_chanctx(struct ieee80211_hw *hw,
>>   	 */
>>   	ar->rx_channel = ctx->def.chan;
>>   	spin_unlock_bh(&ar->data_lock);
>> +	ar->chan_tx_pwr = ATH12K_PDEV_TX_POWER_INVALID;
>>   
>>   	return 0;
>>   }
>> @@ -8666,6 +8782,7 @@ static void ath12k_mac_op_remove_chanctx(struct ieee80211_hw *hw,
>>


