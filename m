Return-Path: <linux-wireless+bounces-18753-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2BCA3071C
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 10:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5FAD18878A7
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 09:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929C51F153C;
	Tue, 11 Feb 2025 09:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HNvxBhA5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CAC1F1510
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 09:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739266197; cv=none; b=i7L8REHBGfH5CgNXcM6ZdHI6aagZ55Vaaq9ciO19wtXPZVbQ0I9YE3l09UDLoTDOFIfxjGgbHcSlzdyLb0tP9l2ZSmXfW/LtDGXcsJ0ROR8wDwBAV60CP1p2KxRxRhmQkGxl9D3Vfokc6CAvPseywifUvMc3GhO/XzKZJM003qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739266197; c=relaxed/simple;
	bh=WF35NSDhxconPyrtHhHlp8/ieZ89HRA6cOOfqBxTFYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=udrRviUe2q/HXhrkC4Bmu9iWQuypaO4M7uOaAc5BujRIDG4Bwpe9eufuljYe6nrJIOp0Jww24g/f0C1e17sQTQFYDmo2y24i+gGTaKbC56JjkqhqLmslmf6yvk0cb4PsymgHYydCbBT9Ettu/fWBGkZgit2k5JqS1vUG0+T4jUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HNvxBhA5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51B9TcZY029885;
	Tue, 11 Feb 2025 09:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TxAVz91mBsbW/bpfGDgg1seVn2JmTTRBiLgiA5plYcs=; b=HNvxBhA5jRjWZEnX
	2OXRuxz0Nr6QbCk9yT1IHFHM4Q4lKE8RxHeLiELjHBawta8z5EE338XBfAFIbzG9
	IQBHQ/HHR0FHf68Oh9yMxxF1rhqt2o6TEkc3YTgV+m3up0ZIJ6CH3kzjtkfVSg7J
	3GP+lI8+u40pMsd3nyHbqsRhGjrosLFwcgyxyznyFmea68IcXoA2yJ0ORMUnHOrl
	v7gHlPmSN9wMHXj8AjKuUlm+lmtpVEGb60CvvxwnuD04ywRHrJDFj3oUaT8bUzvw
	j8FAc2gq1Dw310NRS2zMi8C+KH6FzJKzTVFHmGyjbAKVYH9ENQiapBZxHQxYp5vb
	JTreHg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44p0dxq8dy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 09:29:51 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51B9ToXM004964
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 09:29:50 GMT
Received: from [10.152.202.85] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 11 Feb
 2025 01:29:48 -0800
Message-ID: <d75e1388-8f73-d7eb-cade-35c1fc9e6208@quicinc.com>
Date: Tue, 11 Feb 2025 14:59:45 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v9 2/9] wifi: ath12k: Add HAL_PHYRX_GENERIC_EHT_SIG TLV
 parsing support
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
References: <20250206013854.174765-1-quic_periyasa@quicinc.com>
 <20250206013854.174765-3-quic_periyasa@quicinc.com>
 <7a27d2d0-6630-f074-b426-04b199f3821d@quicinc.com>
 <a825284b-431f-696b-3f76-f13763e46438@quicinc.com>
Content-Language: en-US
From: Mahendran P <quic_mahep@quicinc.com>
In-Reply-To: <a825284b-431f-696b-3f76-f13763e46438@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vAWRrwlbX5rvLKkyhw8Xc1wFRYIJJXAT
X-Proofpoint-ORIG-GUID: vAWRrwlbX5rvLKkyhw8Xc1wFRYIJJXAT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_04,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502110058

On 2/10/2025 7:20 PM, Karthikeyan Periyasamy wrote:
> 
> 
> On 2/10/2025 4:23 PM, Mahendran P wrote:
>> On 2/6/2025 7:08 AM, Karthikeyan Periyasamy wrote:
>>> Currently, monitor is not enabled. However, in the future, the monitor
>>> will be enabled. Therefore, add the necessary HAL_PHYRX_GENERIC_EHT_SIG
>>> TLV parsing support in monitor Rx path, which help to populate the EHT
>>> radiotap data.
>>>
>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>>
>>> Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
>>> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
>>> Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
>>> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>>> ---
>>>   drivers/net/wireless/ath/ath12k/dp_mon.c | 548 +++++++++++++++++++++--
>>>   drivers/net/wireless/ath/ath12k/hal_rx.h | 136 +++++-
>>>   2 files changed, 638 insertions(+), 46 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
>>> index 61fd481b7a3b..dd17607d470d 100644
>>> --- a/drivers/net/wireless/ath/ath12k/dp_mon.c
>>> +++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
>>> @@ -13,6 +13,9 @@
>>>   #define ATH12K_LE32_DEC_ENC(value, dec_bits, enc_bits)    \
>>>           u32_encode_bits(le32_get_bits(value, dec_bits), enc_bits)
>>>   +#define ATH12K_LE64_DEC_ENC(value, dec_bits, enc_bits) \
>>> +        u32_encode_bits(le64_get_bits(value, dec_bits), enc_bits)
>>
>> u64_encode_bits?
>>
> 
> No, Its not needed. Here we need to decode from the u64 and get assign to u32 as defined by eht radiotap header.

Okay. Using le32_encode_bits in the ATH12K_LE64_DEC_ENC macro is likely sufficient with the current mask usage
however it is good to add a comment so that this macro can be used acoordingly in future

> 
> 
>>> @@ -836,6 +1239,9 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k *ar,
>>>           case HAL_RX_PREAMBLE_11AX:
>>>               ppdu_info->he_flags = 1;
>>>               break;
>>> +        case HAL_RX_PREAMBLE_11BE:
>>> +            ppdu_info->is_eht = true;
>>> +            break;
>>>           default:
>>>               break;
>>>           }
>>> @@ -961,6 +1367,21 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k *ar,
>>>       case HAL_PHYRX_GENERIC_U_SIG:
>>>           ath12k_dp_mon_hal_rx_parse_u_sig_hdr(tlv_data, ppdu_info);
>>>           break;
>>> +    case HAL_PHYRX_GENERIC_EHT_SIG:
>>> +        /* Handle the case where aggregation is in progress
>>> +         * or the current TLV is one of the TLVs which should be
>>> +         * aggregated
>>> +         */
>>> +        if (!ppdu_info->tlv_aggr.in_progress) {
>>> +            ppdu_info->tlv_aggr.in_progress = true;
>>> +            ppdu_info->tlv_aggr.tlv_tag = tlv_tag;
>>> +            ppdu_info->tlv_aggr.cur_len = 0;
>>> +        }
>>> +
>>> +        ppdu_info->is_eht = true;
>>> +
>>> +        ath12k_dp_mon_hal_aggr_tlv(ppdu_info, tlv_len, tlv_data);
>>> +        break;
>>>       case HAL_DUMMY:
>>>           return HAL_RX_MON_STATUS_BUF_DONE;
>>>       case HAL_RX_PPDU_END_STATUS_DONE:
>>> @@ -1158,22 +1579,59 @@ static void ath12k_dp_mon_update_radiotap(struct ath12k *ar,
>>>           rxs->ampdu_reference = ampdu_id;
>>>       }
>>>   -    if (ppduinfo->eht_usig) {
>>> +    if (ppduinfo->is_eht || ppduinfo->eht_usig) {
>>>           struct ieee80211_radiotap_tlv *tlv;
>>> +        struct ieee80211_radiotap_eht *eht;
>>>           struct ieee80211_radiotap_eht_usig *usig;
>>> -        u16 len = sizeof(*usig);
>>> +        u16 len = 0, i, eht_len, usig_len;
>>> +        u8 user;
>>> +
>>> +        if (ppduinfo->is_eht) {
>>> +            eht_len = struct_size(eht,
>>> +                          user_info,
>>> +                          ppduinfo->eht_info.num_user_info);
>>> +            len += sizeof(*tlv) + eht_len;
>>> +        }
>>> +
>>> +        if (ppduinfo->eht_usig) {
>>> +            usig_len = sizeof(*usig);
>>> +            len += sizeof(*tlv) + usig_len;
>>> +        }
>>>             rxs->flag |= RX_FLAG_RADIOTAP_TLV_AT_END;
>>>           rxs->encoding = RX_ENC_EHT;
>>>             skb_reset_mac_header(mon_skb);
>>>   -        tlv = skb_push(mon_skb, sizeof(*tlv) + len);
>>> -        tlv->type = cpu_to_le16(IEEE80211_RADIOTAP_EHT_USIG);
>>> -        tlv->len = cpu_to_le16(len);
>>> +        tlv = skb_push(mon_skb, len);
>>> +
>>> +        if (ppduinfo->is_eht) {
>>> +            tlv->type = cpu_to_le16(IEEE80211_RADIOTAP_EHT);
>>> +            tlv->len = cpu_to_le16(eht_len);
>>>   -        usig = (struct ieee80211_radiotap_eht_usig *)tlv->data;
>>> -        *usig = ppduinfo->usig;
>>> +            eht = (struct ieee80211_radiotap_eht *)tlv->data;
>>> +            eht->known = ppduinfo->eht_info.eht.known;
>>> +
>>> +            for (i = 0;
>>> +                 i < ARRAY_SIZE(eht->data) &&
>>> +                 i < ARRAY_SIZE(ppduinfo->eht_info.eht.data);
>>> +                 i++)
>>> +                eht->data[i] = ppduinfo->eht_info.eht.data[i];
>>> +
>>> +            for (user = 0; user < ppduinfo->eht_info.num_user_info; user++)
>>> +                put_unaligned_le32(ppduinfo->eht_info.user_info[user],
>>> +                           &eht->user_info[user]);
>>> +
>>> +            tlv = (struct ieee80211_radiotap_tlv *)&tlv->data[eht_len];
>>> +        }
>>> +
>>> +        if (ppduinfo->eht_usig) {
>>> +            tlv->type = cpu_to_le16(IEEE80211_RADIOTAP_EHT_USIG);
>>> +            tlv->len = cpu_to_le16(usig_len);
>>> +
>>> +            usig = (struct ieee80211_radiotap_eht_usig *)tlv->data;
>>> +            *usig = ppduinfo->u_sig_info.usig;
>>> +        }
>>>       } else if (ppduinfo->he_mu_flags) {
>>>           rxs->flag |= RX_FLAG_RADIOTAP_HE_MU;
>>>           rxs->encoding = RX_ENC_HE;
>>> diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.h b/drivers/net/wireless/ath/ath12k/hal_rx.h
>>> index 2da16f27e76c..959f2283294c 100644
>>> --- a/drivers/net/wireless/ath/ath12k/hal_rx.h
>>> +++ b/drivers/net/wireless/ath/ath12k/hal_rx.h
>>> @@ -71,6 +71,8 @@ enum hal_rx_preamble {
>>>       HAL_RX_PREAMBLE_11N,
>>>       HAL_RX_PREAMBLE_11AC,
>>>       HAL_RX_PREAMBLE_11AX,
>>> +    HAL_RX_PREAMBLE_11BA,
>>
>> is it needed?
>>
> 
> It will be good to have the defined values in the enum instead of initialise the HAL_RX_PREAMBLE_11BE = 6 directly.

got it.

> 
>>> +    HAL_RX_PREAMBLE_11BE,
>>>       HAL_RX_PREAMBLE_MAX,
>>>   };
>>>   
> 


