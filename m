Return-Path: <linux-wireless+bounces-23510-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CF0AC97F2
	for <lists+linux-wireless@lfdr.de>; Sat, 31 May 2025 01:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C2E73B63FD
	for <lists+linux-wireless@lfdr.de>; Fri, 30 May 2025 23:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4127128C030;
	Fri, 30 May 2025 23:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VONeIumc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F3D219313
	for <linux-wireless@vger.kernel.org>; Fri, 30 May 2025 23:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748646073; cv=none; b=EcIfb6hAEtq/9sX47/kLipT2ZxGXNBtcQW8n1ESpIe5lmIRIOxB5b5rvS8ulOaT5xUfqutq7+694vP8pFpy6Oa8nN9dUD5BEv1auKRKKNrLJoQQ3gRNozh6sdTL0ZGZQL/ADpqHxjbuICeDyZRAGgi5/UrFWT/HFBYK74Qm/7xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748646073; c=relaxed/simple;
	bh=gMJbX4cnGOcadW5Jl2Q7N/qSLUS7mDKhkKvwAhx7hjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FCLcdzlAuAxcC44xL+EOFJZlUgndsC7Q9yPnwKGOY8ONg7Yrg2Iy6E+XzcSeKUSAkTuXfr80K82LzLe+Po/fZVMXnXI2bGLuZmzikYbBGFvmzr6nMkDJqBUx7zgKmhEqPIcvy3sRrMJtBFNMOVZtFzXP0Xomkvht8e9+/gRwDB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VONeIumc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54UJJXs6014821;
	Fri, 30 May 2025 23:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MgcyItZdrxTI6bSWFLVqPv4BRUQ0859wjttIK99YwtM=; b=VONeIumcmc6dH/Kk
	/EzcsMND+ru0l7Y/E+kFtS/aG7mMKb/RawHUw4JH/YGr6ZuYJ4cQcKO5hEQUDbN4
	ZNCq/TXRwGYU+SU5f6R3VveD6DjbEU7X6BBPMXIdkBIgWAT3F/r5SwBIeQ7z+wue
	j9kD/lTlAUQtsyJIutLP9Su0VFRNfloE/7hsZBStnaTa7X5vnTODNcnfwFOZfgVi
	66CmrgHOrOwpjBv5uzi3Siy1S4lUAZWvReUblAcKizBbBE9u9O6Mesh891XZsfmg
	OW6AZ/OlDo+xWYZHqGRXJ4GzOXy4VOm2ki05VC5+xj9kwnaXKJZ/xdyE7ZccwK0M
	ukfEUQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46wavm4m9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 May 2025 23:01:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54UN12pU029740
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 May 2025 23:01:02 GMT
Received: from [10.227.105.53] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 30 May
 2025 16:01:02 -0700
Message-ID: <9af1eebf-0562-415d-8600-d1f4505068f5@quicinc.com>
Date: Fri, 30 May 2025 16:01:01 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V13 4/9] wifi: ath12k: generate rx and tx mcs maps for
 supported HE mcs
To: Uraj Sasan <quic_usasan@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Muna Sinada <quic_msinada@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
References: <20250418174818.3336510-1-quic_pradeepc@quicinc.com>
 <20250418174818.3336510-5-quic_pradeepc@quicinc.com>
 <17747983-05c4-4666-9422-2eef8426311b@quicinc.com>
Content-Language: en-US
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
In-Reply-To: <17747983-05c4-4666-9422-2eef8426311b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yrTYO48lkSVmY0ittqrXJ1Z9Ak5FXtSS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDIwNiBTYWx0ZWRfXzPNArFJBitt1
 kAwPY3B3EZouwaxnY0wbr0KTkS2aua87rkdBh4iAvdiPVz+Um3vgBpYb3WXyDGxjoArUZqUntDO
 IZ4tOuIOsoYz7YSOhb0uWlgtScbYxAjhKFQU/frWleewLMJfvVKGWaGjFiK9BmQ1MoUrCJ1Utb1
 Br1A/Y2in/mtUVqqb05/5U+8EbTU0/ZL3MquzoibQHN2nkY07z0XyofbsnLNWb+f6/pwLzwYsb8
 XbCmUuErM7K4tvkGO9SDdxYP74R3JcR4OBmr6ptCiRgbEltVp/+0Zf5rkcGAwd3RJiuNsV1Mu/L
 aR1hSzVta1dkBc1dNH8XQWChYqgReQnirR8tQURHUqHv5vQ/BWOc2Fc/R/XeOwJ1/HAS63VDxEx
 CcABrTClT+1XSXnuKdKDMD+dCSVdWh80aHIwsympv2JalCFOWKxdoaYF8Wmebal1jgvTYMDF
X-Authority-Analysis: v=2.4 cv=fMk53Yae c=1 sm=1 tr=0 ts=683a38af cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8
 a=0wqUhmJS1m6KIOMfa-YA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: yrTYO48lkSVmY0ittqrXJ1Z9Ak5FXtSS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_10,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 phishscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505300206



On 5/28/2025 11:59 PM, Uraj Sasan wrote:
> 
> On 4/18/2025 11:18 PM, Pradeep Kumar Chitrapu wrote:
>> Generate rx and tx mcs maps in ath12k_mac_set_hemcsmap() based
>> on number of supported tx/rx chains and set them in supported
>> mcs/nss for HE capabilities.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>
>> Co-developed-by: Muna Sinada <quic_msinada@quicinc.com>
>> Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
>> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
>> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/mac.c | 40 ++++++++++++++++++++-------
>>   1 file changed, 30 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>> index 30c7d5770ef6..178c89029922 100644
>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>> @@ -6947,20 +6947,40 @@ static __le16 ath12k_mac_setup_he_6ghz_cap(struct ath12k_pdev_cap *pcap,
>>   	return cpu_to_le16(bcap->he_6ghz_capa);
>>   }
>>   
>> -static void ath12k_mac_set_hemcsmap(struct ath12k_band_cap *band_cap,
>> +static void ath12k_mac_set_hemcsmap(struct ath12k *ar,
>> +				    struct ath12k_pdev_cap *cap,
>>   				    struct ieee80211_sta_he_cap *he_cap)
>>   {
>>   	struct ieee80211_he_mcs_nss_supp *mcs_nss = &he_cap->he_mcs_nss_supp;
>> +	u16 txmcs_map, rxmcs_map;
>> +	u32 i;
>> +
>> +	rxmcs_map = 0;
>> +	txmcs_map = 0;
>> +	for (i = 0; i < 8; i++) {
>> +		if (i < ar->num_tx_chains &&
>> +		    (ar->cfg_tx_chainmask >> cap->tx_chain_mask_shift) & BIT(i))
>> +			txmcs_map |= IEEE80211_HE_MCS_SUPPORT_0_11 << (i * 2);
>> +		else
>> +			txmcs_map |= IEEE80211_HE_MCS_NOT_SUPPORTED << (i * 2);
>> +
>> +		if (i < ar->num_rx_chains &&
>> +		    (ar->cfg_rx_chainmask >> cap->tx_chain_mask_shift) & BIT(i))
> 
> I could see the changes are already in external review but wanted to post it internally,
> 
> Shouldn't this be cap->rx_chain_mask_shift ?
Hi Uraj

I expect tx_chain_mask_shift and rx_chain_mask_shift must be same. Do 
you see any specific issue with this? This will help me debug more.
> 
> *"i < ar->num_tx_chains and i < ar->num_rx_chains "*, this is issue since the value of ar->num_tx_chains is not the max supported by the hw always,
> but it gets updated later also via iw phy set antenna command and if user provides any value from 0-15 we will have
> issue. E.g if the value are non continues 1's eg 4 , 5, 6 it will fail and set the VHT/HT/EHT caps to disabled state,
> and only 1,3,7,15 would work correctly.
I see that when userspace changes chainmask, __ath12k_set_antenna calls 
ath12k_mac_setup_ht_vht_cap() to reconfigure caps. Please let me know if 
you are seeing any specific issue, so that I can address it better..

Thanks
pradeep
> 
>> +			rxmcs_map |= IEEE80211_HE_MCS_SUPPORT_0_11 << (i * 2);
>> +		else
>> +			rxmcs_map |= IEEE80211_HE_MCS_NOT_SUPPORTED << (i * 2);
>> +	}
>>   
>> -	mcs_nss->rx_mcs_80 = cpu_to_le16(band_cap->he_mcs & 0xffff);
>> -	mcs_nss->tx_mcs_80 = cpu_to_le16(band_cap->he_mcs & 0xffff);
>> -	mcs_nss->rx_mcs_160 = cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
>> -	mcs_nss->tx_mcs_160 = cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
>> -	mcs_nss->rx_mcs_80p80 = cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
>> -	mcs_nss->tx_mcs_80p80 = cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
>> +	mcs_nss->rx_mcs_80 = cpu_to_le16(rxmcs_map & 0xffff);
>> +	mcs_nss->tx_mcs_80 = cpu_to_le16(txmcs_map & 0xffff);
>> +	mcs_nss->rx_mcs_160 = cpu_to_le16(rxmcs_map & 0xffff);
>> +	mcs_nss->tx_mcs_160 = cpu_to_le16(txmcs_map & 0xffff);
>> +	mcs_nss->rx_mcs_80p80 = cpu_to_le16(rxmcs_map & 0xffff);
>> +	mcs_nss->tx_mcs_80p80 = cpu_to_le16(txmcs_map & 0xffff);
>>   }
>>   
>> -static void ath12k_mac_copy_he_cap(struct ath12k_band_cap *band_cap,
>> +static void ath12k_mac_copy_he_cap(struct ath12k *ar,
>> +				   struct ath12k_band_cap *band_cap,
>>   				   int iftype, u8 num_tx_chains,
>>   				   struct ieee80211_sta_he_cap *he_cap)
>>   {
>> @@ -7004,7 +7024,7 @@ static void ath12k_mac_copy_he_cap(struct ath12k_band_cap *band_cap,
>>   		break;
>>   	}
>>   
>> -	ath12k_mac_set_hemcsmap(band_cap, he_cap);
>> +	ath12k_mac_set_hemcsmap(ar, &ar->pdev->cap, he_cap);
>>   	memset(he_cap->ppe_thres, 0, sizeof(he_cap->ppe_thres));
>>   	if (he_cap_elem->phy_cap_info[6] &
>>   	    IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT)
>> @@ -7194,7 +7214,7 @@ static int ath12k_mac_copy_sband_iftype_data(struct ath12k *ar,
>>   
>>   		data[idx].types_mask = BIT(i);
>>   
>> -		ath12k_mac_copy_he_cap(band_cap, i, ar->num_tx_chains, he_cap);
>> +		ath12k_mac_copy_he_cap(ar, band_cap, i, ar->num_tx_chains, he_cap);
>>   		if (band == NL80211_BAND_6GHZ) {
>>   			data[idx].he_6ghz_capa.capa =
>>   				ath12k_mac_setup_he_6ghz_cap(cap, band_cap);


