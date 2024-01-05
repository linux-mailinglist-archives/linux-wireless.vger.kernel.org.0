Return-Path: <linux-wireless+bounces-1525-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3B4825A44
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 19:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 444D31C238BB
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 18:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0980835EF2;
	Fri,  5 Jan 2024 18:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AgBW41Bq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2D2358B0
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jan 2024 18:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 405I3n8v001644;
	Fri, 5 Jan 2024 18:36:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=VERhAmYsAihIGWRhP9mOJMthZrse2VNPpzpcojJBNuM=; b=Ag
	BW41Bq7UZlXryUoyUsp+AiZWeRS1BZNiwLtrz3xgqkGq6INDLA7Gb3QcFaxaomkL
	BB0JoVHZ5lC8hSD/3ghSuIZMg/snzgrsyMwpJYPgS7ZflIqESRbUllRs5utnvVQ+
	1XJQ8uUvHCfqMt4Oms7Yhtwv9lxUPvSIJOS+kWP3hc6nOItRdEBDwqjKhhKRc5NP
	3XT3Zl8WtcTS3pidlnwsiOqVb4AZ0+jx7188G+ug0Y+fk+Gvdyxgjm/4ieuL7PwM
	tYxkZyOkN8w5v2qLnQ/aVbS3DJwPx076KkXxRu9ssymo+KtT1GD01PCa91+HaAoY
	OHVtE3+SNH4/JZW4RvLA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vepq9g2ye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jan 2024 18:36:00 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 405IZxEO010023
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Jan 2024 18:35:59 GMT
Received: from [10.216.3.245] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 5 Jan
 2024 10:35:57 -0800
Message-ID: <caf4a098-642e-96d2-88a3-67e89cbc450c@quicinc.com>
Date: Sat, 6 Jan 2024 00:05:52 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 02/13] wifi: ath12k: indicate NON MBSSID vdev by default
 during vdev start
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20231030222700.18914-1-quic_rajkbhag@quicinc.com>
 <20231030222700.18914-3-quic_rajkbhag@quicinc.com>
 <c7787488-3a2e-406f-96fe-f6bb293fd441@quicinc.com>
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <c7787488-3a2e-406f-96fe-f6bb293fd441@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: plT8O0VgKOAqUusLiLmo9s30nsyUZ01O
X-Proofpoint-ORIG-GUID: plT8O0VgKOAqUusLiLmo9s30nsyUZ01O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401050151

On 10/31/2023 4:42 AM, Jeff Johnson wrote:
> On 10/30/2023 3:26 PM, Raj Kumar Bhagat wrote:
>> From: Sriram R <quic_srirrama@quicinc.com>
>>
>> When any VDEV is started, MBSSID flags are passed to firmware to
>> indicate if its a MBSSID/EMA AP vdev. If the interface is not an AP
>> or if the AP doesn't support MBSSID, the vdev needs to be brought up
>> as a non MBSSID vdev. Set these flags as a non MBSSID AP by default
>> which can be updated as and when MBSSID support is added in ath12k.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
>> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/mac.c | 5 +++++
>>   drivers/net/wireless/ath/ath12k/wmi.c | 1 +
>>   drivers/net/wireless/ath/ath12k/wmi.h | 8 ++++++++
>>   3 files changed, 14 insertions(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>> index fc0d14ea3..594aa18e7 100644
>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>> @@ -5987,6 +5987,11 @@ ath12k_mac_vdev_start_restart(struct ath12k_vif *arvif,
>>       arg.pref_tx_streams = ar->num_tx_chains;
>>       arg.pref_rx_streams = ar->num_rx_chains;
>>   +    /* Fill the MBSSID flags to indicate AP is non MBSSID by default
>> +     * Corresponding flags would be updated with MBSSID support.
>> +     */
>> +    arg.mbssid_flags = WMI_VDEV_FLAGS_NON_MBSSID_AP;
>> +
>>       if (arvif->vdev_type == WMI_VDEV_TYPE_AP) {
>>           arg.ssid = arvif->u.ap.ssid;
>>           arg.ssid_len = arvif->u.ap.ssid_len;
>> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
>> index 0e5bf5ce8..88ec77dee 100644
>> --- a/drivers/net/wireless/ath/ath12k/wmi.c
>> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
>> @@ -1024,6 +1024,7 @@ int ath12k_wmi_vdev_start(struct ath12k *ar, struct wmi_vdev_start_req_arg *arg,
>>       cmd->regdomain = cpu_to_le32(arg->regdomain);
>>       cmd->he_ops = cpu_to_le32(arg->he_ops);
>>       cmd->punct_bitmap = cpu_to_le32(arg->punct_bitmap);
>> +    cmd->mbssid_flags = cpu_to_le32(arg->mbssid_flags);
>>         if (!restart) {
>>           if (arg->ssid) {
>> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
>> index 8e1eda7aa..dfe9eb0cb 100644
>> --- a/drivers/net/wireless/ath/ath12k/wmi.h
>> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
>> @@ -2269,6 +2269,14 @@ struct ath12k_wmi_hal_reg_capabilities_ext_arg {
>>       u32 high_5ghz_chan;
>>   };
>>   +enum {
>> +    WMI_VDEV_FLAGS_NON_MBSSID_AP       = BIT(0),
> 
> only the 1st one is used. do we need the rest at this point?
> perhaps add the others as they are needed?

Sure, will add only one - WMI_VDEV_FLAGS_NON_MBSSID_AP.
> 
>> +    WMI_VDEV_FLAGS_TRANSMIT_AP         = BIT(1),
>> +    WMI_VDEV_FLAGS_NON_TRANSMIT_AP     = BIT(2),
>> +    WMI_VDEV_FLAGS_EMA_MODE            = BIT(3),
>> +    WMI_VDEV_FLAGS_SCAN_MODE_VAP       = BIT(4),
> 
> note that "vap" is a non-standard term that ideally should not be used in ath12k (although a few references are present)
> 
>> +};
> 
> these seem to be added at some random place in the file. considering that these are applicable to the mbssid_flags in struct wmi_vdev_start_request_cmd, I'd suggest:
> 
> 1) defining the enum just before this struct
> 2) naming the enum, i.e. wmi_vdev_mbssid_flags
> 3) using a prefix that matches the name, i.e. WMI_VDEV_MBSSID_FLAGS_NON_MBSSID_AP
> 4) in struct wmi_vdev_start_request_cmd add a comment to:
>     __le32 mbssid_flags; /* uses enum wmi_vdev_mbssid_flags */
> 
> /jeff

Will implement the above suggestions in next version.

