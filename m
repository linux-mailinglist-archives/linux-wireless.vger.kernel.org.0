Return-Path: <linux-wireless+bounces-7454-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4429E8C255D
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 15:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67AD11C20AB1
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 13:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA8F127E01;
	Fri, 10 May 2024 13:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Efni5ABK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC6D5E099;
	Fri, 10 May 2024 13:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715346261; cv=none; b=eF7LFlgPV2taEp1I/FIhqRXU6XkBn4OBj1QdOJS2ZxDcx0Q+9Kv8LOQDVnI7LPkqq2OY/Xg5+Lbq+6GrvzvPpmo0Cs3z3G1k4+B4tbatLlk4Rabz67EsrnBAlnQjEO6E3WzvWgShRWlW5CDkbn+e/bSDzKWC2BEKdAxQymijccM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715346261; c=relaxed/simple;
	bh=Dw8L8eZBtaQm/RhUW4Qdw6yEwtJ2BgiUeEHmTXbJQT0=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=b/e0wppKSqvMzKnQTIrPNhD0MplWSe2LmlPjiW0d6YXm6X3u95oq/uSBSlKOotGpr81WEqbcY2va/mbjky+5d1q/7SsZttv5DzbFqLsYAjzLvspR683a7psPBnYU4n/PUt4LsJJwAlF9W+OCCCOWk2cUNmiG6/js62CCyC1Yw1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Efni5ABK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44A2u9du019772;
	Fri, 10 May 2024 13:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:cc:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=6ciBEr91BthWrBkA1+Q08rrfel/AWetQxbWTdmHHWTk=; b=Ef
	ni5ABKp7PdzHsOx7YIPB1ULax7dc5nI6ntf9ynv+UywEQjVMGWhY3gfOM7euTCj+
	pgWnuoYA8sohGRoz1TvKhf+4R0CK5eUk3q0UKaBCM19KNxfEaJh5SrMbuO+scX0N
	rI1EbBzvPkFLMAGmrkabDXn5V32SfwxWcVcO5D3BZU4mqTcJiqVo418fDxw/WPgl
	s5LKORj4oTZWEDCicYJJ8Z1vEP5QFW1GQ9W7QEKuqZAqlWpQmzK2Zgti+9Md4VOV
	Eaz7vhxm1MyxevWjYygZGOL8Wjq/rzaSdCVVs9bc9Xq2DyS9e9p6Xva3HvT0TS0/
	K9mRKuy8EM00sf79ajMg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w1hhju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 13:04:11 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44AD4AUT024270
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 13:04:10 GMT
Received: from [10.231.194.144] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 10 May
 2024 06:04:09 -0700
Message-ID: <4d60ccf3-455d-4189-9100-d35488b00236@quicinc.com>
Date: Fri, 10 May 2024 21:04:06 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <quic_cjhuang@quicinc.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <regressions@lists.linux.dev>
Subject: Re: [PATCH 1/2] wifi: ath11k: supports 2 station interfaces
To: Kalle Valo <kvalo@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>
References: <20230714023801.2621802-1-quic_cjhuang@quicinc.com>
 <20230714023801.2621802-2-quic_cjhuang@quicinc.com>
 <D15TIIDIIESY.D1EKKJLZINMA@fairphone.com> <87jzk2km0g.fsf@kernel.org>
 <93c15c59-f24c-4472-ae7e-969fd1e3bfec@quicinc.com>
Content-Language: en-US
From: Carl Huang <quic_cjhuang@quicinc.com>
In-Reply-To: <93c15c59-f24c-4472-ae7e-969fd1e3bfec@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7gLfDyWbJEHC47QhIfqDhFL5OXg6Pt0p
X-Proofpoint-GUID: 7gLfDyWbJEHC47QhIfqDhFL5OXg6Pt0p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_08,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 impostorscore=0 clxscore=1015 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405100093



On 2024/5/10 20:03, Carl Huang wrote:
> 
> 
> On 2024/5/10 18:18, Kalle Valo wrote:
>> "Luca Weiss" <luca.weiss@fairphone.com> writes:
>>
>>> On Fri Jul 14, 2023 at 4:38 AM CEST, Carl Huang wrote:
>>>> Add hardware parameter support_dual_stations to indicate
>>>> whether 2 station interfaces are supported. For chips which
>>>> support this feature, limit total number of AP interface and
>>>> mesh point to 1. The max interfaces are 3 for such chips.
>>>>
>>>> The chips affected are:
>>>>   QCA6390 hw2.0
>>>>   WCN6855 hw2.0
>>>>   WCN6855 hw2.1
>>>> Other chips are not affected.
>>>>
>>>> For affected chips, remove radar_detect_widths because now
>>>> num_different_channels is set to 2. radar_detect_widths can
>>>> be set only when num_different_channels is 1. See mac80211
>>>> function wiphy_verify_combinations for details.
>>>>
>>>> Tested-on: WCN6855 hw2.0 PCI 
>>>> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
>>>
>>> Hi Carl,
>>>
>>> Unfortunately this commit breaks wifi on a QCM6490 smartphone
>>> (qcm6490-fairphone-fp5) and makes the board crash.
>>>
>>> Reverting this commit (plus for conflict resolution 5dc9d1a55e95 ("wifi:
>>> ath11k: add support for QCA2066") and 24395ec11707 ("wifi: ath11k:
>>> provide address list if chip supports 2 stations")) makes wifi work
>>> again.
>>
>> Thanks for the report. So the broken commit is:
>>
>> f019f4dff2e4 wifi: ath11k: support 2 station interfaces
>>
>> This went into v6.9-rc1 so I'm guessing that WCN6750 support will be
>> fully broken in v6.9? Not good. And most likely Linus will release v6.9
>> on Sunday so it's too late to get a fix included in the final release.
>>
>> Carl, can you fix this ASAP? Or should we just revert the broken
>> commits?
>>
>> Adding this to our regression tracking:
>>
>> #regzbot introduced: f019f4dff2e4 ^
>> #regzbot title: ath11k: WCN6750 firmware crashes during initialisation
>>
> Kalle, looks we're not able to fix it before Sunday as I don't have 
> WCN6750 setup to verify the fix. The fix could be to define a dedicated 
> function ath11k_init_wmi_config_wcn6750() for WCN6750. I'll send the 
> patch out so others like Luca can have a try.
> 
Sorry, I have problem to run "git send-email" as it prompts "5.7.60 
SMTP; Client does not have permissions to send as this sender".

The patch looks like:

 From 19bb7f1377a5e3c5d42ab2bedbaf9e976c1068b4 Mon Sep 17 00:00:00 2001
From: Carl Huang <quic_cjhuang@quicinc.com>
Date: Fri, 10 May 2024 19:40:37 +0800
Subject: [PATCH] wifi:ath11k: fix WCN6750 firmware crash

WCN6750 firmware crashed because of vdev_number changed to 3 from 4
in commit f019f4dff2e4("wifi: ath11k: support 2 station interfaces").

Fix it by defining a separate function ath11k_init_wmi_config_wcn6750()
for WCN6750 to initialize its' specific parameters.

Fixes: f019f4dff2e4 ("wifi: ath11k: support 2 station interfaces")
Tested-on: WCN6855 hw2.0 PCI 
WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3

Signed-off-by: Carl Huang <quic_cjhuang@quicinc.com>
---
  drivers/net/wireless/ath/ath11k/hw.c | 49 +++++++++++++++++++++++++++-
  1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/hw.c 
b/drivers/net/wireless/ath/ath11k/hw.c
index caa6dc12a790..df8822ac3be1 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -102,6 +102,53 @@ static void ath11k_init_wmi_config_qca6390(struct 
ath11k_base *ab,
  	config->flag1 |= WMI_RSRC_CFG_FLAG1_BSS_CHANNEL_INFO_64;
  }

+static void ath11k_init_wmi_config_wcn6750(struct ath11k_base *ab,
+					   struct target_resource_config *config)
+{
+	config->num_vdevs = 4;
+	config->num_peers = 16;
+	config->num_tids = 32;
+
+	config->num_offload_peers = 3;
+	config->num_offload_reorder_buffs = 3;
+	config->num_peer_keys = TARGET_NUM_PEER_KEYS;
+	config->ast_skid_limit = TARGET_AST_SKID_LIMIT;
+	config->tx_chain_mask = (1 << ab->target_caps.num_rf_chains) - 1;
+	config->rx_chain_mask = (1 << ab->target_caps.num_rf_chains) - 1;
+	config->rx_timeout_pri[0] = TARGET_RX_TIMEOUT_LO_PRI;
+	config->rx_timeout_pri[1] = TARGET_RX_TIMEOUT_LO_PRI;
+	config->rx_timeout_pri[2] = TARGET_RX_TIMEOUT_LO_PRI;
+	config->rx_timeout_pri[3] = TARGET_RX_TIMEOUT_HI_PRI;
+	config->rx_decap_mode = TARGET_DECAP_MODE_NATIVE_WIFI;
+	config->scan_max_pending_req = TARGET_SCAN_MAX_PENDING_REQS;
+	config->bmiss_offload_max_vdev = TARGET_BMISS_OFFLOAD_MAX_VDEV;
+	config->roam_offload_max_vdev = TARGET_ROAM_OFFLOAD_MAX_VDEV;
+	config->roam_offload_max_ap_profiles = 
TARGET_ROAM_OFFLOAD_MAX_AP_PROFILES;
+	config->num_mcast_groups = 0;
+	config->num_mcast_table_elems = 0;
+	config->mcast2ucast_mode = 0;
+	config->tx_dbg_log_size = TARGET_TX_DBG_LOG_SIZE;
+	config->num_wds_entries = 0;
+	config->dma_burst_size = 0;
+	config->rx_skip_defrag_timeout_dup_detection_check = 0;
+	config->vow_config = TARGET_VOW_CONFIG;
+	config->gtk_offload_max_vdev = 2;
+	config->num_msdu_desc = 0x400;
+	config->beacon_tx_offload_max_vdev = 2;
+	config->rx_batchmode = TARGET_RX_BATCHMODE;
+
+	config->peer_map_unmap_v2_support = 0;
+	config->use_pdev_id = 1;
+	config->max_frag_entries = 0xa;
+	config->num_tdls_vdevs = 0x1;
+	config->num_tdls_conn_table_entries = 8;
+	config->beacon_tx_offload_max_vdev = 0x2;
+	config->num_multicast_filter_entries = 0x20;
+	config->num_wow_filters = 0x16;
+	config->num_keep_alive_pattern = 0;
+	config->flag1 |= WMI_RSRC_CFG_FLAG1_BSS_CHANNEL_INFO_64;
+}
+
  static void ath11k_hw_ipq8074_reo_setup(struct ath11k_base *ab)
  {
  	u32 reo_base = HAL_SEQ_WCSS_UMAC_REO_REG;
@@ -1102,7 +1149,7 @@ const struct ath11k_hw_ops wcn6855_ops = {

  const struct ath11k_hw_ops wcn6750_ops = {
  	.get_hw_mac_from_pdev_id = ath11k_hw_ipq8074_mac_from_pdev_id,
-	.wmi_init_config = ath11k_init_wmi_config_qca6390,
+	.wmi_init_config = ath11k_init_wmi_config_wcn6750,
  	.mac_id_to_pdev_id = ath11k_hw_mac_id_to_pdev_id_qca6390,
  	.mac_id_to_srng_id = ath11k_hw_mac_id_to_srng_id_qca6390,
  	.tx_mesh_enable = ath11k_hw_qcn9074_tx_mesh_enable,
-- 
2.34.1


Hi Luca, could you help apply this patch and retest?

Hi Kalle, could you help send this patch if Luca verifies it works?




