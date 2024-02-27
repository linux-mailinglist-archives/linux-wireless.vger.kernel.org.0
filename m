Return-Path: <linux-wireless+bounces-4077-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC14868EE0
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 12:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7980B1F22870
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 11:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57BD13959F;
	Tue, 27 Feb 2024 11:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZhZr3iBv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A05113959D
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 11:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709033710; cv=none; b=Z3H8KN5za2del6LoloTTO7IwQA3+afa+S1SNkLmksd+k0NaCjZivTz3bha7A22fRdGvjfZ4YOfK9dXCLS9+5RwCt/IrOIP11As4MrgBRquPgg4I6VFOZPfmE1m+0E1PUMslgqO9MPtbKn4D6OLGVwJfc9qVAXyR4RFAK2Uscnok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709033710; c=relaxed/simple;
	bh=189FffUhKQ7Y6nACvkCLJr4isbMvfIvjxmQB91tE00g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mz9PcC8z6/544FUhOpGXLd1BhWVzJGdHhUz0d+/i4Y+91k97uA+syFK0Aq4x6E+4NVNWZ1UpMK2mOrcvLsX1tnrzLKd8XBvwdpozygbIL0aG4wsYqiDTxyLEqE9MRHc3lPNSKMPNoZDeB9esEnrOpAA9Rj3cUmW6JYfXBR5KYjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZhZr3iBv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41R9Ynt0020951;
	Tue, 27 Feb 2024 11:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=C7JPjmXuxye/Env1zhf3k9kRNU1YZcUBMB4RQ9uFFt8=; b=Zh
	Zr3iBvZ0eSfQKXFOcQ/J9TkEd+bGzkD/LGxfdBiSaJTHjgkaQyD7Vk7IzIxWv/fa
	vDm5LapuMKrCv/lLhmnEsUbMQEzD26IR2v4ThKp+lkbNoTWdrRjaObloMdfH8wat
	HZdJZGRE3Wa7CytfLVJnHpNfMFHV5IunuS5w3EaHDG0OEi69KqDxw0dia6GkIPgs
	qg5gb/18559NnI8uUU1IC79aTbZI7pVBZX5tgWv3cPKgJMLSnAlWBU5SVzqOIDNw
	3s04QI/nuQwo4cEIxojTpvD6nwNO78GbQQJVHTeUw03zEI43qvEOlRnqzUfwtPz1
	oYbovmYkCNulRYHJtw4w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh89t0v94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 11:35:05 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RBZ4oD010176
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 11:35:04 GMT
Received: from [10.253.12.70] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 27 Feb
 2024 03:35:03 -0800
Message-ID: <9f26a75a-df9a-405a-b1ac-2e457eef8416@quicinc.com>
Date: Tue, 27 Feb 2024 19:35:00 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] wifi: ath11k: implement handling of P2P NoA event
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240226060203.2040444-1-quic_kangyang@quicinc.com>
 <20240226060203.2040444-4-quic_kangyang@quicinc.com>
 <032375ce-7dc0-4d93-9f26-12a6bb89dbe0@quicinc.com>
From: Kang Yang <quic_kangyang@quicinc.com>
In-Reply-To: <032375ce-7dc0-4d93-9f26-12a6bb89dbe0@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: O0trx4G4M6jMz5uLAd7q7e_7rUjlJlBG
X-Proofpoint-GUID: O0trx4G4M6jMz5uLAd7q7e_7rUjlJlBG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402270090


>> +
>> +static void ath11k_p2p_noa_ie_fill(u8 *data, size_t len,
>> +				   const struct ath11k_wmi_p2p_noa_info *noa)
>> +{
>> +	struct ieee80211_p2p_noa_attr *noa_attr;
>> +	u8 ctwindow = u32_get_bits(noa->noa_attr, WMI_P2P_NOA_INFO_CTWIN_TU);
>> +	bool oppps = u32_get_bits(noa->noa_attr, WMI_P2P_NOA_INFO_OPP_PS);
>> +	__le16 *noa_attr_len;
>> +	u16 attr_len;
>> +	u8 noa_descriptors = u32_get_bits(noa->noa_attr,
>> +					   WMI_P2P_NOA_INFO_DESC_NUM);
> 
> do you need to validate that this doesn't exceed
> WMI_P2P_MAX_NOA_DESCRIPTORS?
> 
>> +	int i;
>> +
>> +	/* P2P IE */
……

>> +
>> +static size_t
>> +ath11k_p2p_noa_ie_len_compute(const struct ath11k_wmi_p2p_noa_info *noa)
>> +{
>> +	size_t len = 0;
>> +
>> +	if (!(u32_get_bits(noa->noa_attr, WMI_P2P_NOA_INFO_DESC_NUM)) &&
>> +	    !(u32_get_bits(noa->noa_attr, WMI_P2P_NOA_INFO_OPP_PS)))
>> +		return 0;
>> +
>> +	len += 1 + 1 + 4; /* EID + len + OUI */
>> +	len += 1 + 2; /* noa attr + attr len */
>> +	len += 1 + 1; /* index + oppps_ctwindow */
>> +	len += u32_get_bits(noa->noa_attr, WMI_P2P_NOA_INFO_DESC_NUM) *
> 
> here again do you need to validate that this doesn't exceed
> WMI_P2P_MAX_NOA_DESCRIPTORS?
> 
> also rather than call u32_get_bits() twice for the same field, call it
> once and cache the result


Will add this check in ath11k_wmi_p2p_noa_event(), cause 
ath11k_p2p_noa_ie_fill() and ath11k_p2p_noa_ie_len_compute will only be 
called through ath11k_wmi_p2p_noa_event().


> 
>> +			sizeof(struct ieee80211_p2p_noa_desc);
>> +
>> +	return len;
>> +}
>> +

……

>>   
>> +static int ath11k_wmi_p2p_noa_event(struct ath11k_base *ab,
>> +				    struct sk_buff *skb)
>> +{
>> +	const void **tb;
>> +	const struct wmi_p2p_noa_event *ev;
>> +	const struct ath11k_wmi_p2p_noa_info *noa;
>> +	struct ath11k *ar;
>> +	int ret, vdev_id;
>> +
>> +	tb = ath11k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
>> +	if (IS_ERR(tb)) {
>> +		ret = PTR_ERR(tb);
>> +		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ev = tb[WMI_TAG_P2P_NOA_EVENT];
>> +	noa = tb[WMI_TAG_P2P_NOA_INFO];
>> +
>> +	if (!ev || !noa) {
>> +		ret = -EPROTO;
>> +		goto out;
>> +	}
>> +
>> +	vdev_id = ev->vdev_id;
>> +
>> +	ath11k_dbg(ab, ATH11K_DBG_WMI,
>> +		   "wmi tlv p2p noa vdev_id %i descriptors %u\n",
>> +		   vdev_id, u32_get_bits(noa->noa_attr, WMI_P2P_NOA_INFO_DESC_NUM));
>> +	rcu_read_lock();
>> +	ar = ath11k_mac_get_ar_by_vdev_id(ab, vdev_id);
>> +	if (!ar) {
>> +		ath11k_warn(ab, "invalid vdev id %d in P2P NoA event\n",
>> +			    vdev_id);
>> +		ret = -EINVAL;
>> +		goto unlock;
>> +	}
>> +
>> +	ath11k_p2p_noa_update_by_vdev_id(ar, vdev_id, noa);
>> +
>> +unlock:
>> +	rcu_read_unlock();
>> +out:
>> +	kfree(tb);
>> +	return 0;
>> +}
>> +
>>   static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
>>   {
>>   	struct wmi_cmd_hdr *cmd_hdr;
>> @@ -8772,6 +8824,9 @@ static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
>>   	case WMI_GTK_OFFLOAD_STATUS_EVENTID:
>>   		ath11k_wmi_gtk_offload_status_event(ab, skb);
>>   		break;
>> +	case WMI_P2P_NOA_EVENTID:
>> +		ath11k_wmi_p2p_noa_event(ab, skb);
>> +		break;
>>   	default:
>>   		ath11k_dbg(ab, ATH11K_DBG_WMI, "unsupported event id 0x%x\n", id);
>>   		break;
>> diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
>> index 4c20202947c7..564f4a9ac8ce 100644
>> --- a/drivers/net/wireless/ath/ath11k/wmi.h
>> +++ b/drivers/net/wireless/ath/ath11k/wmi.h
> 
> drivers/net/wireless/ath/ath11k/wmi.h QuIC copyright missing 2024
> 
>> @@ -3630,6 +3630,37 @@ struct wmi_ftm_event_msg {
>>   	u8 data[];
>>   } __packed;
>>   
>> +#define WMI_P2P_MAX_NOA_DESCRIPTORS		4
>> +
>> +struct wmi_p2p_noa_event {
>> +	u32 vdev_id;
>> +} __packed;
>> +
>> +struct ath11k_wmi_p2p_noa_descriptor {
>> +	u32 type_count; /* 255: continuous schedule, 0: reserved */
>> +	u32 duration;  /* Absent period duration in micro seconds */
>> +	u32 interval;   /* Absent period interval in micro seconds */
>> +	u32 start_time; /* 32 bit tsf time when in starts */
>> +} __packed;
>> +
>> +#define WMI_P2P_NOA_INFO_CHANGED_FLAG		BIT(0)
>> +#define WMI_P2P_NOA_INFO_INDEX			GENMASK(15, 8)
>> +#define WMI_P2P_NOA_INFO_OPP_PS			BIT(16)
>> +#define WMI_P2P_NOA_INFO_CTWIN_TU		GENMASK(23, 17)
>> +#define WMI_P2P_NOA_INFO_DESC_NUM		GENMASK(31, 24)
>> +
>> +struct ath11k_wmi_p2p_noa_info {
>> +	/* Bit 0 - Flag to indicate an update in NOA schedule
>> +	 * Bits 7-1 - Reserved
>> +	 * Bits 15-8 - Index (identifies the instance of NOA sub element)
>> +	 * Bit  16 - Opp PS state of the AP
>> +	 * Bits 23-17 -  Ctwindow in TUs
>> +	 * Bits 31-24 -  Number of NOA descriptors
>> +	 */
>> +	u32 noa_attr;
>> +	struct ath11k_wmi_p2p_noa_descriptor descriptors[WMI_P2P_MAX_NOA_DESCRIPTORS];
> 
> so firmware always sends the max number of records even if Bits 31-24 -
> Number of NOA descriptors indicates a smaller number?
> 

I just checked this, firmware will fill this according to valid number, 
not max number.
But when fill WMI event for P2P NOA, the TLV length is based on max number.

Even if the valid number does not reach the max number, the remain part 
is just empty.



So i think this definition is OK.



>> +} __packed;
>> +
>>   #define WMI_BEACON_TX_BUFFER_SIZE	512
>>   
>>   #define WMI_EMA_TMPL_IDX_SHIFT            8
> 
> I'm seeing things today I probably missed in the ath12k review, so let's
> make sure that when this is merged that ath12k si updated as well.

> /jeff

