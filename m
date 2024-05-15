Return-Path: <linux-wireless+bounces-7664-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 642FA8C6001
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 07:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 853421C2496F
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 05:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E171138FA5;
	Wed, 15 May 2024 05:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jUalRTH6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200A138FA3
	for <linux-wireless@vger.kernel.org>; Wed, 15 May 2024 05:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715749224; cv=none; b=iU05LS0ad1cyAPrwshpI9+hqJ0L+vFoiYgq27fv757vdhbhweMzZax5prXbltMO7/6RGAOWnFUCMQVKXXm3V1vFYxAPtXWTnOGCkMxo9bj3gjAmvj4YX87pfGbkEigi4Y/UQObGX0oI+a2OzsoOxlqtArSWkCZqx8+QX12T5PKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715749224; c=relaxed/simple;
	bh=qw5vJ3S+29YfQ+35Ezz0uIwkDXP6TAHq7YB3gr+qBlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hGuAurRwFT/Kr8JBkeURhrsOxzlkbuB5qk9PVGYrJ5tmD6J/64oqgRyhICGhEAAmCx5hNux0G2evmrNsPitycoC3YZd4xidRYbeaAyEI8RExmAY163xhGhqrWE8AWqJjrXPhOSiOrmbYRfWXXyaaMbSwyEPgDilREQDhIbnmmNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jUalRTH6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44EE9tOY004684;
	Wed, 15 May 2024 05:00:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=E8t+G5qaNF7bnZZtry2qMy4ghPNEP0UUgn1EhlQD5dk=; b=jU
	alRTH6hLGgjZSwjIMg+DXwWbDAVK7LVbQt2GinunMkX/uwkg3t4V76+75E3w5EBh
	sTm1BS1O4nVSCWJQz68VYMsMdioRqMBiRxqCPAsu7SF3ZGve9kx/TR0KKiz2+HWG
	s/mpr1C7LXKYMALl8vKxIr7w7rzXLxzplRYgCU0x/0HsAZAGJLDOWQaxf+1erk2Q
	r4E/VSKi3mzC58ie9GomOWqcDBR+9iQIsTpbXGy4r33WpijWceJO/QpM8LAFDim+
	rNDECfXxG2XC1xQH14HHh+uCXoqkgMNm+kRAJPwS02SQItTq/pNmc8eGh6uLx2aG
	ARKl87/R5AHq254Ia8cw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y49ft1ku4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 05:00:18 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44F50HOG019888
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 05:00:17 GMT
Received: from [10.50.32.39] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 14 May
 2024 22:00:15 -0700
Message-ID: <984c2fac-1b74-f043-5df5-e1fd591e3a9a@quicinc.com>
Date: Wed, 15 May 2024 10:30:11 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] wifi: ath12k: support average ack rssi in station dump
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Sivashankari Madhavan
	<quic_sivamadh@quicinc.com>
References: <20240514124949.2197384-1-quic_ssreeela@quicinc.com>
 <27d7b0d8-5e1b-4df1-987a-159b559b85d8@quicinc.com>
From: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
In-Reply-To: <27d7b0d8-5e1b-4df1-987a-159b559b85d8@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tQCdL0Yjg-UBNQ6BilvVDvCdg0QEl1Tx
X-Proofpoint-GUID: tQCdL0Yjg-UBNQ6BilvVDvCdg0QEl1Tx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_01,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405150033

On 5/14/2024 10:32 PM, Jeff Johnson wrote:
> On 5/14/2024 5:49 AM, Sowmiya Sree Elavalagan wrote:
>> From: Sivashankari Madhavan <quic_sivamadh@quicinc.com>
>>
>> Currently, the ACK RSSI value is not shown in station dump. Enable WMI
>> resource flag for ACK RSSI in WMI INIT command to add ACK RSSI value in
>> management TX completion event from WMI. Update ACK RSSI value obtained
>> in management and data frame completion path to ieee80211_tx_info. Also
>> advertise NL80211_EXT_FEATURE_ACK_SIGNAL_SUPPORT flag during hardware
>> register to mac80211 layer so that ACK RSSI is added to station dump
>> message.
>>
>> Example output :
>> Station 00:03:7f:12:cc:cc (on wlo1)
>>         inactive time:  600 ms
>>         rx bytes:       288106
>>         rx packets:     1446
>>         tx bytes:       41818
>>         tx packets:     342
>>         tx retries:     64
>>         tx failed:      0
>>         beacon loss:    0
>>         beacon rx:      602
>>         rx drop misc:   51
>>         signal:         0 dBm
>>         beacon signal avg:      -44 dBm
>>         tx duration:    0 us
>>         rx bitrate:     1441.1 MBit/s 80MHz HE-MCS 9 HE-NSS 3 HE-GI 0 HE-DCM 0
>>         rx duration:    0 us
>>         last ack signal:-51 dBm
>>         avg ack signal: -50 dBm
>>         authorized:     yes
>>         .......
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Sivashankari Madhavan <quic_sivamadh@quicinc.com>
>> Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
>>
>> Depends-On: wifi: ath12k: fix the issue that calculation of ack signal strength
>>  https://patchwork.kernel.org/project/linux-wireless/patch/20240511030917.65811-1-quic_lingbok@quicinc.com/
> 
> Does your patch not need to consider whether or not
> WMI_TLV_SERVICE_HW_DB2DBM_CONVERSION_SUPPORT is enabled?
> 

WMI_TLV_SERVICE_HW_DB2DBM_CONVERSION_SUPPORT flag is used to decide whether we need to add noise 
floor (ATH12K_DEFAULT_NOISE_FLOOR) or not to the ack_rssi value we receive in data path. In this patch we do 
not add noise floor anywhere. The ack rssi received in WMI completion path includes the noise 
floor computation before sending to driver.

>> ---
>>  drivers/net/wireless/ath/ath12k/dp_tx.c |  2 ++
>>  drivers/net/wireless/ath/ath12k/mac.c   |  1 +
>>  drivers/net/wireless/ath/ath12k/wmi.c   | 15 +++++++++++----
>>  drivers/net/wireless/ath/ath12k/wmi.h   |  3 +++
>>  4 files changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
>> index 32496015cf9a..43bdb49d08e2 100644
>> --- a/drivers/net/wireless/ath/ath12k/dp_tx.c
>> +++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
>> @@ -541,6 +541,8 @@ static void ath12k_dp_tx_status_parse(struct ath12k_base *ab,
>>  
>>  	ts->ppdu_id = le32_get_bits(desc->info1,
>>  				    HAL_WBM_COMPL_TX_INFO1_TQM_STATUS_NUMBER);
>> +	ts->ack_rssi = le32_get_bits(desc->info2,
>> +				     HAL_WBM_COMPL_TX_INFO2_ACK_FRAME_RSSI);
>>  	if (le32_to_cpu(desc->rate_stats.info0) & HAL_TX_RATE_STATS_INFO0_VALID)
>>  		ts->rate_stats = le32_to_cpu(desc->rate_stats.info0);
>>  	else
>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>> index 96dc5c2e096f..1f4739269544 100644
>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>> @@ -8733,6 +8733,7 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
>>  
>>  	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
>>  	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_STA_TX_PWR);
>> +	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_ACK_SIGNAL_SUPPORT);
>>  
>>  	wiphy->cipher_suites = cipher_suites;
>>  	wiphy->n_cipher_suites = ARRAY_SIZE(cipher_suites);
>> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
>> index 3004c7463be9..fe909d866539 100644
>> --- a/drivers/net/wireless/ath/ath12k/wmi.c
>> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
>> @@ -3468,7 +3468,8 @@ ath12k_wmi_copy_resource_config(struct ath12k_wmi_resource_config_params *wmi_cf
>>  	wmi_cfg->max_bssid_rx_filters = cpu_to_le32(tg_cfg->max_bssid_rx_filters);
>>  	wmi_cfg->use_pdev_id = cpu_to_le32(tg_cfg->use_pdev_id);
>>  	wmi_cfg->flag1 = cpu_to_le32(tg_cfg->atf_config |
>> -				     WMI_RSRC_CFG_FLAG1_BSS_CHANNEL_INFO_64);
>> +				     WMI_RSRC_CFG_FLAG1_BSS_CHANNEL_INFO_64 |
>> +				     WMI_RSRC_CFG_FLAG1_ACK_RSSI);
>>  	wmi_cfg->peer_map_unmap_version = cpu_to_le32(tg_cfg->peer_map_unmap_version);
>>  	wmi_cfg->sched_params = cpu_to_le32(tg_cfg->sched_params);
>>  	wmi_cfg->twt_ap_pdev_count = cpu_to_le32(tg_cfg->twt_ap_pdev_count);
>> @@ -5134,7 +5135,7 @@ static int ath12k_pull_mgmt_rx_params_tlv(struct ath12k_base *ab,
>>  }
>>  
>>  static int wmi_process_mgmt_tx_comp(struct ath12k *ar, u32 desc_id,
>> -				    u32 status)
>> +				    u32 status, u32 ack_rssi)
>>  {
>>  	struct sk_buff *msdu;
>>  	struct ieee80211_tx_info *info;
>> @@ -5158,8 +5159,11 @@ static int wmi_process_mgmt_tx_comp(struct ath12k *ar, u32 desc_id,
>>  	dma_unmap_single(ar->ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
>>  
>>  	info = IEEE80211_SKB_CB(msdu);
>> -	if ((!(info->flags & IEEE80211_TX_CTL_NO_ACK)) && !status)
>> +	if ((!(info->flags & IEEE80211_TX_CTL_NO_ACK)) && !status) {
>>  		info->flags |= IEEE80211_TX_STAT_ACK;
>> +		info->status.ack_signal = ack_rssi;
>> +		info->status.flags |= IEEE80211_TX_STATUS_ACK_SIGNAL_VALID;
>> +	}
>>  
>>  	ieee80211_tx_status_irqsafe(ath12k_ar_to_hw(ar), msdu);
>>  
>> @@ -5200,6 +5204,8 @@ static int ath12k_pull_mgmt_tx_compl_param_tlv(struct ath12k_base *ab,
>>  	param->pdev_id = ev->pdev_id;
>>  	param->desc_id = ev->desc_id;
>>  	param->status = ev->status;
>> +	param->ppdu_id = ev->ppdu_id;
>> +	param->ack_rssi = ev->ack_rssi;
>>  
>>  	kfree(tb);
>>  	return 0;
>> @@ -6110,7 +6116,8 @@ static void ath12k_mgmt_tx_compl_event(struct ath12k_base *ab, struct sk_buff *s
>>  	}
>>  
>>  	wmi_process_mgmt_tx_comp(ar, le32_to_cpu(tx_compl_param.desc_id),
>> -				 le32_to_cpu(tx_compl_param.status));
>> +				 le32_to_cpu(tx_compl_param.status),
>> +				 le32_to_cpu(tx_compl_param.ack_rssi));
>>  
>>  	ath12k_dbg(ab, ATH12K_DBG_MGMT,
>>  		   "mgmt tx compl ev pdev_id %d, desc_id %d, status %d",
>> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
>> index 496866673aea..7ebd52a7ebb8 100644
>> --- a/drivers/net/wireless/ath/ath12k/wmi.h
>> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
>> @@ -2410,6 +2410,7 @@ struct wmi_init_cmd {
>>  #define WMI_RSRC_CFG_HOST_SVC_FLAG_REG_CC_EXT_SUPPORT_BIT 4
>>  #define WMI_RSRC_CFG_FLAGS2_RX_PEER_METADATA_VERSION		GENMASK(5, 4)
>>  #define WMI_RSRC_CFG_FLAG1_BSS_CHANNEL_INFO_64	BIT(5)
>> +#define WMI_RSRC_CFG_FLAG1_ACK_RSSI BIT(18)
>>  
>>  struct ath12k_wmi_resource_config_params {
>>  	__le32 tlv_header;
>> @@ -4180,6 +4181,8 @@ struct wmi_mgmt_tx_compl_event {
>>  	__le32 desc_id;
>>  	__le32 status;
>>  	__le32 pdev_id;
>> +	__le32 ppdu_id;
>> +	__le32 ack_rssi;
>>  } __packed;
>>  
>>  struct wmi_scan_event {
> 

Hi jeff, 

Please find my response inline.

Thanks,
Sowmiya Sree

