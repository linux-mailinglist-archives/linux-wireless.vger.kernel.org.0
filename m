Return-Path: <linux-wireless+bounces-23485-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F169AC794E
	for <lists+linux-wireless@lfdr.de>; Thu, 29 May 2025 09:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3509E64D1
	for <lists+linux-wireless@lfdr.de>; Thu, 29 May 2025 07:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F3B255E20;
	Thu, 29 May 2025 07:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ltBlCnEz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022BF7483
	for <linux-wireless@vger.kernel.org>; Thu, 29 May 2025 07:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748502018; cv=none; b=KAHLr/9H1Rx59M8iiPBAa3oiwG3hQz/pBwW6NBcdxLY/6HDwC25INWo6H90t/RpIW2LLSo+B/dJtrid86J5T6S1LpQgM/qy5h9x4VbsQMOLJze74RVDa4ie433vRgzeTkyhH6TZJj30JW/GThx2wxC9zlkNvIJKAuEbcAjj/GmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748502018; c=relaxed/simple;
	bh=r/T8TQ9dxJWf2SVSg6XbC5AR+IR+oY9Lr+6kBcK6B1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Pt1UBiPUSXPlqPoKKrK66ht6NHlgZPpgS0Kfy68E9sXxqYf52wZ7XVZ4YgDz5xZKOEEzwmhAHIGGy+wQyzkXxyZMzKU/c4gDzWV1z/zKhmkSv5rsJOux1oW4mlhUhXdTZ6GqkCt6r9izta1JuxMK/8oaYl6sOisnrL/s2oGY6YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ltBlCnEz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54T5Jj3t024456;
	Thu, 29 May 2025 07:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jiQPMLcyp6CcimQJDB0RRZSI8Qyp2370DI7mXdMiwRg=; b=ltBlCnEzjA9durb/
	aSf6CjWKvKOFFStZ43j8rKOo5P364wQaNRawnmZSdZ9SBwG1lnMVWTn4+S/hYRRm
	9CIPoVSr/bzfoi30wJ8rzHb+cWLz7et5yeaiyxygdwUSu+RpzMq4hwa90U/LpIh/
	HSr0Op8m9u7d4Xio/2Mm1D+mxqiCxEMBSHwpjHteU4piPI9hjlGsrOhiYvRTqjZo
	4+owlXe7DK/IswMSyLe+PPX1SAhSWDfg3FibXWVuX0fTz2o6EQ8uModwi8wS7DCx
	Gv0ornrQRTqwMry6sD9mmG791WedWFohOfOjAPbpxBzGG4dzIED/6u6mP/2UpZp2
	sIHg8g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u549mrf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 07:00:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54T7011K007090
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 07:00:02 GMT
Received: from [10.50.38.53] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 28 May
 2025 23:59:59 -0700
Message-ID: <17747983-05c4-4666-9422-2eef8426311b@quicinc.com>
Date: Thu, 29 May 2025 12:29:56 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V13 4/9] wifi: ath12k: generate rx and tx mcs maps for
 supported HE mcs
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Muna Sinada <quic_msinada@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
References: <20250418174818.3336510-1-quic_pradeepc@quicinc.com>
 <20250418174818.3336510-5-quic_pradeepc@quicinc.com>
Content-Language: en-US
From: Uraj Sasan <quic_usasan@quicinc.com>
In-Reply-To: <20250418174818.3336510-5-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bM43bygD5GaVgo9Cwj9Uy3KrSKyimlOQ
X-Authority-Analysis: v=2.4 cv=E9nNpbdl c=1 sm=1 tr=0 ts=683805f3 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8
 a=pEvFgt6wzKLrZD5As20A:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDA2OCBTYWx0ZWRfX+HWc/0jkxClQ
 BNO1a0v79+3mo1R3KGtEe1BXGSGjU/yfLKalGWhkZpN2tKl6txNBkv1EHqEut/qnmchniDDPE7x
 6AjIHmvlaPr/Rrr+YuyXD23LZ3RDRvVtOVH3n3pbROkXEtJM1qnCVpBQSJ8U0BzZwi5yanDYDWR
 5DzADq3iDK77Xg0wtL/uTafGWFWdEjwugrwx9s9Em6s74oUzJ6bYHjjMFB/p59vlBjJwfj53FY0
 ctgqhJ8mZ24x/RdFIDkB6tLcDF1e7y3R31qYaJTzctjLDOnPhl9Wz59SI8E6Hiij8X4v/FLqsT3
 qrjpCx0ROPT3JLLbk3ZiUmZ/N33jKkLPPMxCxkV5HzmweORyjBQmfozCJURLMoscjRr4Qq79Vqp
 ubr9+VN/wN0tC+JvG6oWSrTtzzDEQYn965Cpf7zr0F9cLZ/1v8C67ClON1ZEL+lE13FBVvX4
X-Proofpoint-ORIG-GUID: bM43bygD5GaVgo9Cwj9Uy3KrSKyimlOQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_03,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1011 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505290068


On 4/18/2025 11:18 PM, Pradeep Kumar Chitrapu wrote:
> Generate rx and tx mcs maps in ath12k_mac_set_hemcsmap() based
> on number of supported tx/rx chains and set them in supported
> mcs/nss for HE capabilities.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>
> Co-developed-by: Muna Sinada <quic_msinada@quicinc.com>
> Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 40 ++++++++++++++++++++-------
>  1 file changed, 30 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 30c7d5770ef6..178c89029922 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -6947,20 +6947,40 @@ static __le16 ath12k_mac_setup_he_6ghz_cap(struct ath12k_pdev_cap *pcap,
>  	return cpu_to_le16(bcap->he_6ghz_capa);
>  }
>  
> -static void ath12k_mac_set_hemcsmap(struct ath12k_band_cap *band_cap,
> +static void ath12k_mac_set_hemcsmap(struct ath12k *ar,
> +				    struct ath12k_pdev_cap *cap,
>  				    struct ieee80211_sta_he_cap *he_cap)
>  {
>  	struct ieee80211_he_mcs_nss_supp *mcs_nss = &he_cap->he_mcs_nss_supp;
> +	u16 txmcs_map, rxmcs_map;
> +	u32 i;
> +
> +	rxmcs_map = 0;
> +	txmcs_map = 0;
> +	for (i = 0; i < 8; i++) {
> +		if (i < ar->num_tx_chains &&
> +		    (ar->cfg_tx_chainmask >> cap->tx_chain_mask_shift) & BIT(i))
> +			txmcs_map |= IEEE80211_HE_MCS_SUPPORT_0_11 << (i * 2);
> +		else
> +			txmcs_map |= IEEE80211_HE_MCS_NOT_SUPPORTED << (i * 2);
> +
> +		if (i < ar->num_rx_chains &&
> +		    (ar->cfg_rx_chainmask >> cap->tx_chain_mask_shift) & BIT(i))

I could see the changes are already in external review but wanted to post it internally,

Shouldn't this be cap->rx_chain_mask_shift ?

*"i < ar->num_tx_chains and i < ar->num_rx_chains "*, this is issue since the value of ar->num_tx_chains is not the max supported by the hw always,
but it gets updated later also via iw phy set antenna command and if user provides any value from 0-15 we will have
issue. E.g if the value are non continues 1's eg 4 , 5, 6 it will fail and set the VHT/HT/EHT caps to disabled state,
and only 1,3,7,15 would work correctly.

> +			rxmcs_map |= IEEE80211_HE_MCS_SUPPORT_0_11 << (i * 2);
> +		else
> +			rxmcs_map |= IEEE80211_HE_MCS_NOT_SUPPORTED << (i * 2);
> +	}
>  
> -	mcs_nss->rx_mcs_80 = cpu_to_le16(band_cap->he_mcs & 0xffff);
> -	mcs_nss->tx_mcs_80 = cpu_to_le16(band_cap->he_mcs & 0xffff);
> -	mcs_nss->rx_mcs_160 = cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
> -	mcs_nss->tx_mcs_160 = cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
> -	mcs_nss->rx_mcs_80p80 = cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
> -	mcs_nss->tx_mcs_80p80 = cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
> +	mcs_nss->rx_mcs_80 = cpu_to_le16(rxmcs_map & 0xffff);
> +	mcs_nss->tx_mcs_80 = cpu_to_le16(txmcs_map & 0xffff);
> +	mcs_nss->rx_mcs_160 = cpu_to_le16(rxmcs_map & 0xffff);
> +	mcs_nss->tx_mcs_160 = cpu_to_le16(txmcs_map & 0xffff);
> +	mcs_nss->rx_mcs_80p80 = cpu_to_le16(rxmcs_map & 0xffff);
> +	mcs_nss->tx_mcs_80p80 = cpu_to_le16(txmcs_map & 0xffff);
>  }
>  
> -static void ath12k_mac_copy_he_cap(struct ath12k_band_cap *band_cap,
> +static void ath12k_mac_copy_he_cap(struct ath12k *ar,
> +				   struct ath12k_band_cap *band_cap,
>  				   int iftype, u8 num_tx_chains,
>  				   struct ieee80211_sta_he_cap *he_cap)
>  {
> @@ -7004,7 +7024,7 @@ static void ath12k_mac_copy_he_cap(struct ath12k_band_cap *band_cap,
>  		break;
>  	}
>  
> -	ath12k_mac_set_hemcsmap(band_cap, he_cap);
> +	ath12k_mac_set_hemcsmap(ar, &ar->pdev->cap, he_cap);
>  	memset(he_cap->ppe_thres, 0, sizeof(he_cap->ppe_thres));
>  	if (he_cap_elem->phy_cap_info[6] &
>  	    IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT)
> @@ -7194,7 +7214,7 @@ static int ath12k_mac_copy_sband_iftype_data(struct ath12k *ar,
>  
>  		data[idx].types_mask = BIT(i);
>  
> -		ath12k_mac_copy_he_cap(band_cap, i, ar->num_tx_chains, he_cap);
> +		ath12k_mac_copy_he_cap(ar, band_cap, i, ar->num_tx_chains, he_cap);
>  		if (band == NL80211_BAND_6GHZ) {
>  			data[idx].he_6ghz_capa.capa =
>  				ath12k_mac_setup_he_6ghz_cap(cap, band_cap);

