Return-Path: <linux-wireless+bounces-27793-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5306EBB522B
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Oct 2025 22:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03256485033
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Oct 2025 20:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DA91DED63;
	Thu,  2 Oct 2025 20:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fFf1ZIXA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FEC1C1F13
	for <linux-wireless@vger.kernel.org>; Thu,  2 Oct 2025 20:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759437489; cv=none; b=KGTLD/SEZUQnWsinlYBHix4d1iLtNuD6bVRDai2bjIlKbaaqVhVvoVDZYFt0hhpP91OLTavTVfRS4aWVkVExDz6IxMMAiiq1OoE3Q3tzZ+4r19Qa0ceIQ1kEQkwwHm/MC6joUZEiFingzHFZaAnz6HQ462cGEBlD22w8SxTvWf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759437489; c=relaxed/simple;
	bh=n/ZjRRHouR6bOLFNuvZKJYzCnmBZ8qHHWXGyJXZ55PA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=khcgvdDEH7jYzz04iMM5VXmBs6AOl3QWc9+N7Z/jmyN5aOJLkLQNaROKcXXgWdwm/Q/lEWIN9t/kxVgcnnZLupi9j5v7yUc8/hfaZa65GTCc+YJErFS2cbzHFdq6Tg9Q8z3Nz9jqF7M82UuEiyISVTEylGsTKftl16drLPQxaF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fFf1ZIXA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59295DdH012562;
	Thu, 2 Oct 2025 20:38:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R51FWFQ7Cctn/OANVhy1+/UrxI71AfbAifEB1dOlGT0=; b=fFf1ZIXA9uFMCra2
	aBX6xi2x4rGyz/CrrVlVZaquHRg33Nv0YEbpLA+SPDGag/dg0CcD/1Dr3FfL2eUj
	V1nicwWkzx3n07xBNaQnldayv+PAJrD4w+zOmdttSuG1mPtcA2rsX7QZ3YNQVFHB
	IatAb5Q4Gg256qYtSRrUPWbeQzyIoxf491+duyFuZJG+giJMFMrJ0Dj5+JahUjir
	Vq1UfRfMqWZ1KPfxnoS00fEZDJ7l/f8cQ/LjW56UKbk15oRyD46fZecb9pnydE46
	10RWhKbu2cYJTre07xu/ryTysroF0E+01oZL6dFP+1ESj1EDfU2+3htrQtj12O+B
	k/VW8Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e80u14mh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Oct 2025 20:38:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 592Kc0Lb025242
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 Oct 2025 20:38:00 GMT
Received: from [10.110.5.41] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Thu, 2 Oct
 2025 13:37:59 -0700
Message-ID: <d3abec0f-05f8-483a-bb01-629a27026171@quicinc.com>
Date: Thu, 2 Oct 2025 13:37:58 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next V16 1/2] wifi: ath12k: fix VHT MCS assignment
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Baochen Qiang <quic_bqiang@quicinc.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
References: <20251002000732.1916364-1-quic_pradeepc@quicinc.com>
 <20251002000732.1916364-2-quic_pradeepc@quicinc.com>
 <4bb3de8a-92dd-444e-bed0-13ec2419cd34@oss.qualcomm.com>
Content-Language: en-US
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
In-Reply-To: <4bb3de8a-92dd-444e-bed0-13ec2419cd34@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyOSBTYWx0ZWRfXzs1NPcYwV5Ue
 xCImEsT/yZABIsUSIKqkEql7zpKZcfxr5Y/AqhxmUoptBBLnxW7/ERyTiG6d19750G1oaUQbqpR
 fKWp7gmYueDxrVssTB8mu4oqMa4D9qjix8xBX318H/QJDDazl6TQlD1C2+YL77J+u/+Bi8f1t/v
 fjhvbgrsw4dCgKyCSUTI/NsCJ1Ywe+ORBKG7Z+w0GoVpYlkQ7tO78lKWq+/OwPQVH//LMiJm+Mf
 LR5qUoEk6Su2DjYCRGNI2mljUYU0DTP4K2TNgXkRUK7YPGuh7A/VdfePBaKDpfN8LpmPkbWUEO+
 Ux7TOUnwzWIsjUM4fsbW3guBvElf0yqFBFWVsMuUWjhIqdjWRlp9suuuckN7ijsRKoe50cCXjzW
 QfEpNXqsS4q2pNYNDWw3tzy1NkX/Ag==
X-Proofpoint-GUID: URq3yOjfH6iIjUDdLLPPMDUNpl1BddrG
X-Authority-Analysis: v=2.4 cv=OMkqHCaB c=1 sm=1 tr=0 ts=68dee2a9 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=VwHbBrl-h6yUJW5RUa8A:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: URq3yOjfH6iIjUDdLLPPMDUNpl1BddrG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_08,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270029



On 10/1/2025 6:31 PM, Jeff Johnson wrote:
> On 10/1/2025 5:07 PM, Pradeep Kumar Chitrapu wrote:
>> From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
>>
>> While associating, firmware needs the peer's receive capability
>> to calculate its own VHT transmit MCS. Currently, the host
>> sends this information via mcs->rx_mcs_set field, but firmware
>> actually reads it from mcs->tx_mcs_set field. Thjis mismatch is
> 
> s/Thjis/This/
> 
>> incorrect.
>>
>> This issue has not caused failures so far because most peers
>> advertise identical TX and RX capabilities. Fix this by
>> assigning the value to tx_mcs_set as expected.
>>
>> Additionally, the rate control mask is intended to limit our
>> transmit MCS, so it should also apply to the peer's receive
>> capability. Update the logic accordingly.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>
>> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
>> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
>> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/mac.c |  7 +++----
>>   drivers/net/wireless/ath/ath12k/wmi.c | 11 +++++++----
>>   drivers/net/wireless/ath/ath12k/wmi.h |  2 ++
> 
> wmi.c and wmi.h need copyright updates to match current guidance.
> 
>>   3 files changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>> index 1d7b60aa5cb0..0d425a1bc0ab 100644
>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>> @@ -2249,7 +2249,6 @@ static void ath12k_peer_assoc_h_vht(struct ath12k *ar,
>>   	struct cfg80211_chan_def def;
>>   	enum nl80211_band band;
>>   	u16 *vht_mcs_mask;
>> -	u16 tx_mcs_map;
>>   	u8 ampdu_factor;
>>   	u8 max_nss, vht_mcs;
>>   	int i, vht_nss, nss_idx;
>> @@ -2340,10 +2339,10 @@ static void ath12k_peer_assoc_h_vht(struct ath12k *ar,
>>   	arg->peer_nss = min(link_sta->rx_nss, max_nss);
>>   	arg->rx_max_rate = __le16_to_cpu(vht_cap->vht_mcs.rx_highest);
>>   	arg->rx_mcs_set = __le16_to_cpu(vht_cap->vht_mcs.rx_mcs_map);
>> -	arg->tx_max_rate = __le16_to_cpu(vht_cap->vht_mcs.tx_highest);
>> +	arg->rx_mcs_set = ath12k_peer_assoc_h_vht_limit(arg->rx_mcs_set, vht_mcs_mask);
>>   
>> -	tx_mcs_map = __le16_to_cpu(vht_cap->vht_mcs.tx_mcs_map);
>> -	arg->tx_mcs_set = ath12k_peer_assoc_h_vht_limit(tx_mcs_map, vht_mcs_mask);
>> +	arg->tx_max_rate = __le16_to_cpu(vht_cap->vht_mcs.tx_highest);
>> +	arg->tx_mcs_set = __le16_to_cpu(vht_cap->vht_mcs.tx_mcs_map);
>>   
>>   	/* In QCN9274 platform, VHT MCS rate 10 and 11 is enabled by default.
>>   	 * VHT MCS rate 10 and 11 is not supported in 11ac standard.
>> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
>> index ff6b3d4ea820..2682d89afd44 100644
>> --- a/drivers/net/wireless/ath/ath12k/wmi.c
>> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
>> @@ -2367,10 +2367,13 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
>>   	cmd->peer_bw_rxnss_override |= cpu_to_le32(arg->peer_bw_rxnss_override);
>>   
>>   	if (arg->vht_capable) {
>> -		mcs->rx_max_rate = cpu_to_le32(arg->rx_max_rate);
>> -		mcs->rx_mcs_set = cpu_to_le32(arg->rx_mcs_set);
>> -		mcs->tx_max_rate = cpu_to_le32(arg->tx_max_rate);
>> -		mcs->tx_mcs_set = cpu_to_le32(arg->tx_mcs_set);
>> +		/* Firmware interprets mcs->tx_mcs_set field as peer's
>> +		 * RX capability
>> +		 */
>> +		mcs->rx_max_rate = cpu_to_le32(arg->tx_max_rate);
>> +		mcs->rx_mcs_set = cpu_to_le32(arg->tx_mcs_set);
>> +		mcs->tx_max_rate = cpu_to_le32(arg->rx_max_rate);
>> +		mcs->tx_mcs_set = cpu_to_le32(arg->rx_mcs_set);
>>   	}
>>   
>>   	/* HE Rates */
>> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
>> index a8c3190e8ad9..6d9c645e3d5d 100644
>> --- a/drivers/net/wireless/ath/ath12k/wmi.h
>> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
>> @@ -4218,8 +4218,10 @@ struct wmi_unit_test_cmd {
>>   struct ath12k_wmi_vht_rate_set_params {
>>   	__le32 tlv_header;
>>   	__le32 rx_max_rate;
>> +	/* MCS at which the peer can transmit */
>>   	__le32 rx_mcs_set;
>>   	__le32 tx_max_rate;
>> +	/* MCS at which the peer can receive */
>>   	__le32 tx_mcs_set;
>>   	__le32 tx_max_mcs_nss;
>>   } __packed;
> I can apply my two comments when I process this series if there are no other
> changes required.
> 
> /jeff
Thanks for the review Jeff..

I will wait for any further review comments.

