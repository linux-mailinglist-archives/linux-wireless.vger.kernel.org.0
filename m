Return-Path: <linux-wireless+bounces-22990-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54223AB7E16
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 08:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AFC23ABDAF
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 06:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7D128F505;
	Thu, 15 May 2025 06:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lFwVPcqv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5382D54758
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 06:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747290888; cv=none; b=IEP8UDZ9k2wXO6rm65hu8zvuHHZ0xISJN3w4ITEVESLBtyZVg5QMphT7kzwLwRHR0v0KYP9FPt1lBXVK5ftWgwwxGDvWxJFhnUBc/C6j1YbLpkeCQ0yoA5f8T9e9aP9D9lNsosL8hC5OJeBKz59SeYhlkdvaN1VQQ3QbnyFbaR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747290888; c=relaxed/simple;
	bh=DX3UHaU9QyM4e7BXxjz2vicMN+mBD4JbDE3V/nQN28c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LN1qOrKbR+SwPha3xjoCcs6FdurDFasLlPQjS8VT1Y5ztB9gpl2kl/JERarYuayb//90+vP7/S/Q2vbNLtDFPWwr1us5cPAQHj6MCztd2kOOE0i1VEEfZ2YMga8jlPzH+AQNqAM1Wxtdel/ybHI/5wEdt96WOKOPOlIpClynQS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lFwVPcqv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EKP3C0002607
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 06:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7nhmmA1XvEaEKRzp943p1FAzDW4rYuXS1qZxO1y4fc8=; b=lFwVPcqvTrd6OBMs
	H3XpviNGwnnIXJeE/1bAW0wMYNc8GQZiBj+IZlGLyKu0+ICBD7iiHAHA6hq7SBZT
	gZ9uq1mYOlsTvaDJPhfxyZbArPwbGVdfsg1NRfeH/R9+yeA9dMJ5CJkh1A6fu1Dc
	KBLBDNeooOjlLdwmZbudZnHgUJlwJUFE3F50TW08YlxsyTKZ+JK9aERFSzX4uEwI
	bdzCgMSgEJ3FRVev4afA7mWnMnzWXJ8m3A3l0WkhVizhRNGuurLMaf0bYxPkVtNK
	Jtg3z+7+Fx8Tw0iKZ9MVU85Zg2UXKT53YZTBL65+PEv+LpPPn2OdGYY46ugBAv63
	bRzlJQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbex54wn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 06:34:45 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-741a845cab2so877241b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 14 May 2025 23:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747290884; x=1747895684;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7nhmmA1XvEaEKRzp943p1FAzDW4rYuXS1qZxO1y4fc8=;
        b=BYYTJ9eanFKxxPEqYXHPUkvLrx+bbFPGmn+P8147+oquAf2Swl3g2iYO/4V9vsbVh5
         05dVqe4lZkv9BfPmgigsx/59ZUPCk3KrmpIa0SxR5H9voeIZJjZJR59g+D+Ae5ix1wOu
         ge1nsSmgOLOGJ5jpWlgdqllwl2tXzQbwi6MeU4mWDIEWuLrxXCXniNV05Gpq1uA7wjKF
         WelPmKN/FAZoVFZWQ+LexvLoiC1dPOOY/FByroVmYAPotkR51QyGSGCi+MXjrwsihvUZ
         an8SnxPVcatvdxSO3TqZLnCKPQHD6YfTCWZfQT68psdvFtGtucbSmAcJ1N4FGxOC7Inj
         YsZA==
X-Gm-Message-State: AOJu0YwIFbuzTJd/Rwz+7bEnZXyZZ524Quj/msm0hpih1jBrAMTNIguf
	0t7hR81bNlOMgJbFnEBenMQNbwYiIl0uTY1NLpwECaE1UljR2+ErFwJGXcCeXKMGd+OUF4d5Lfv
	mwnzEKeI6bAmRrJQZxb+WpsEyEk5kEZ/7oUNCG15ZBKdHM5VJ9VldHAjE1DA+/2dGJw==
X-Gm-Gg: ASbGncuboLavJ4qYYBzxQhAQGeZ9XQznFHoWpD6HoIQ63n63U6mQHTOoEwcPf2e+Sxw
	INYRNv+QdC8/HdSTW9fTS+uSfxOnKGO1YE2ZAiHOzUj1HDNreEX6AraZSD7QM9n9TkDXkDTk/bB
	1Y93BN05aqEMBMiu0NFEe8MPHpcPhfME4+a2L9JO7lXaORd087l488aYlThqTePLAzkpzcdcCdH
	FbFyOUavO7UEJuJMxoDMDMLQF7V1sn6diXA+g49w6x6nkJXzEqwvjdcfiYGvbKpc11shdo4kiAg
	aNpoh+ajU9w9Ue4kYgGEHDM96G8B9OGqymNQnkWrrj+LYwZ5t7+cuwoxVx7PJV1eQGfUz9B1Qw=
	=
X-Received: by 2002:a05:6a00:1941:b0:740:9e87:9625 with SMTP id d2e1a72fcca58-742984c1549mr2265708b3a.4.1747290883662;
        Wed, 14 May 2025 23:34:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHr9HOu//sfc7uf6w//YCDUtcHLX/6lc12BRjbEaxudXLKi6jJoPFBgS+NUWaUQEBurxEOYKA==
X-Received: by 2002:a05:6a00:1941:b0:740:9e87:9625 with SMTP id d2e1a72fcca58-742984c1549mr2265571b3a.4.1747290882025;
        Wed, 14 May 2025 23:34:42 -0700 (PDT)
Received: from [10.133.33.17] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237704025sm10997427b3a.13.2025.05.14.23.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 23:34:41 -0700 (PDT)
Message-ID: <7db2e4b5-377c-4d3b-b51f-290accc9ddd9@oss.qualcomm.com>
Date: Thu, 15 May 2025 14:34:39 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2] wifi: ath12k: combine channel list for
 split-phy devices in single-wiphy
To: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        ath12k@lists.infradead.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        aditya.kumar.singh@oss.qualcomm.com
Cc: linux-wireless@vger.kernel.org
References: <20250506105624.466019-1-rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
From: Kang Yang <kang.yang@oss.qualcomm.com>
In-Reply-To: <20250506105624.466019-1-rameshkumar.sundaram@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDA2MiBTYWx0ZWRfX4TSiauI4Z8AE
 ay1LzLODNXDjAu1V2dEhb5FaDgwJ2I/1vIT/UMIKjxCa+VKqBYXd9COm+5HS+NMuVH7ZZJ0S7X/
 gNe3CjCT8s964gcUj03nn0c06o+dTLlGCHxTLuwZarIvLd9stDGeCK+vxFhLSMUFEdVwWcOic4A
 IB7wQIw3nhZyCgPO5T+wVKqLk55lMqvA2USnCDZONeNcDXBvK4Xp+XruCq5olBlJpPuhD0ZR4CW
 7nNoSiMJ2Hzw1vaDuyaNqS78nsJ4E9Xy/DNM/4jBaZhidUrjtA4HbQ8kM4bskN5LGlGAhXX9UlO
 1c/+Lbz6FNuED8sxy8Xpt6qiddIW7z68rHdw2bb0sBI1R09BvzcqbRurHUwgTywE12mcfNPf7yr
 TTtot9POQQZuC1MCNyNjsfjsugnfBKz1zy7pfI9zuqvec1Y55NaUA2WErrmyaG8vXNtmYR/c
X-Proofpoint-ORIG-GUID: AXNLuDiBELpNpnCI8CAfzHfB6vkhK2FO
X-Proofpoint-GUID: AXNLuDiBELpNpnCI8CAfzHfB6vkhK2FO
X-Authority-Analysis: v=2.4 cv=IcuHWXqa c=1 sm=1 tr=0 ts=68258b05 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=rz7yrZg-k9xSqkJEgisA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_02,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 spamscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505150062



On 5/6/2025 6:56 PM, Rameshkumar Sundaram wrote:
> When two split-phy devices that support overlapping frequency ranges within
> the same band are grouped into an ath12k hardware (HW) setup, they share a
> common wiphy instance. Consequently, the channel list (wiphy->bands[])
> becomes unified across all associated radios (ar).
> 
> For reference, the devices are:
> 2.4 GHz + 5 GHz Low Band
> 5 GHz High Band + 6 GHz
> 
> The first radio probed within the 5 GHz range (say 5 GHz Low Band) updates
> its sband reference (&ar->mac.sbands[NL80211_BAND_5GHZ]) within
> wiphy->bands[]. However, when the second 5 GHz radio (5 GHz High Band) is
> probed, it replaces the existing wiphy->bands[] entry with its own sub-band
> reference. As a result, wiphy->bands[] always reflects the channel list
> from the most recently probed radio in that band, restricting supported
> channels to those within its specific range for upper-layer.
> 
> Fix this by updating the wiphy->bands[] to just enable the channels of
> current radio when there exist a radio which already has set it.
> This will make sure wiphy->bands[] holds reference of first radio which
> got probed in 5 GHz band and subsequent radio just updates the channel list
> in the same address space.
> 
> Since same sband memory space is shared between radios of a band, while
> determining the allowed frequency range of radio, its frequency limits
> (ar->freq_range.start_freq, end_freq) should be used.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1


Offline sync with aditya:

This patch and patch [1][2] will make WCN7850 update regulatory rules 
and trigger scan incorrectly.

They are based on the design that one chip only supports one band.

This design will limit WCN7850 to one band.
During init, WCN7850 will be limited to one band(such as 5G band) due to 
patch[1]. Then will only update 5G regulatory rules and trigger 5G scan.
If manually set country code by "iw reg set XX", WCN7850 will be limited 
to 2G band due to patch[2]. Then similar issue will happen.


If QCN supports multi bands like WCN i think you will have the same problem.

WIN team needs to figure a new design for this issue to support multi 
bands on one chip too.



[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=b7544de8a2984e61b95c58c1c6c1e8ce659b1021
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=13324cecbb2c390a11f1fbfe87f3a5e62d6e4591



> 
> Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
> ---
> 
> *v2:
>    - Fixed frequency conversion from KHZ to MHZ in freq_to_idx()
> 
> ---
>   drivers/net/wireless/ath/ath12k/mac.c | 93 +++++++++++++++++++++++++--
>   drivers/net/wireless/ath/ath12k/reg.c | 13 ++++
>   drivers/net/wireless/ath/ath12k/wmi.c |  9 ++-
>   3 files changed, 109 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 4dae941c9615..23cbf348e836 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -4131,8 +4131,9 @@ ath12k_mac_select_scan_device(struct ieee80211_hw *hw,
>   		band = NL80211_BAND_6GHZ;
>   
>   	for_each_ar(ah, ar, i) {
> -		/* TODO 5 GHz low high split changes */
> -		if (ar->mac.sbands[band].channels)
> +		if (ar->mac.sbands[band].channels &&
> +		    center_freq >= KHZ_TO_MHZ(ar->freq_range.start_freq) &&
> +		    center_freq <= KHZ_TO_MHZ(ar->freq_range.end_freq))


Though WCN7850 won't reach here, but this is also not good for those 
chips who support multi bands.


>   			return ar;
>   	}
>   
> @@ -10925,6 +10926,32 @@ static u32 ath12k_get_phy_id(struct ath12k *ar, u32 band)
>   	return 0;
>   }
>   
> +static int ath12k_mac_update_band(struct ath12k *ar,
> +				  struct ieee80211_supported_band *orig_band,
> +				  struct ieee80211_supported_band *new_band)
> +{
> +	int i;
> +
> +	if (!orig_band || !new_band)
> +		return -EINVAL;
> +
> +	if (orig_band->band != new_band->band)
> +		return -EINVAL;
> +
> +	for (i = 0; i < new_band->n_channels; i++) {
> +		if (new_band->channels[i].flags & IEEE80211_CHAN_DISABLED)
> +			continue;
> +		/* An enabled channel in new_band should not be already enabled
> +		 * in the orig_band
> +		 */
> +		if (WARN_ON(!(orig_band->channels[i].flags &
> +			      IEEE80211_CHAN_DISABLED)))
> +			return -EINVAL;
> +		orig_band->channels[i].flags &= ~IEEE80211_CHAN_DISABLED;
> +	}
> +	return 0;
> +}
> +
>   static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
>   					   u32 supported_bands,
>   					   struct ieee80211_supported_band *bands[])
> @@ -10935,6 +10962,7 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
>   	u32 phy_id, freq_low, freq_high;
>   	struct ath12k_hw *ah = ar->ah;
>   	void *channels;
> +	int ret;
>   
>   	BUILD_BUG_ON((ARRAY_SIZE(ath12k_2ghz_channels) +
>   		      ARRAY_SIZE(ath12k_5ghz_channels) +
> @@ -10956,7 +10984,6 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
>   		band->channels = channels;
>   		band->n_bitrates = ath12k_g_rates_size;
>   		band->bitrates = ath12k_g_rates;
> -		bands[NL80211_BAND_2GHZ] = band;
>   
>   		if (ab->hw_params->single_pdev_only) {
>   			phy_id = ath12k_get_phy_id(ar, WMI_HOST_WLAN_2GHZ_CAP);
> @@ -10973,6 +11000,22 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
>   					  reg_cap->high_2ghz_chan);
>   
>   		ath12k_mac_update_freq_range(ar, freq_low, freq_high);
> +
> +		if (!bands[NL80211_BAND_2GHZ]) {
> +			bands[NL80211_BAND_2GHZ] = band;
> +		} else {
> +			/* Split mac in same band under same wiphy */
> +			ret = ath12k_mac_update_band(ar, bands[NL80211_BAND_2GHZ], band);
> +			if (ret) {
> +				kfree(channels);
> +				band->channels = NULL;
> +				return ret;
> +			}
> +			ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac pdev %u identified as 2 GHz split mac with start freq %d end freq %d",
> +				   ar->pdev->pdev_id,
> +				   KHZ_TO_MHZ(ar->freq_range.start_freq),
> +				   KHZ_TO_MHZ(ar->freq_range.end_freq));
> +		}
>   	}
>   
>   	if (supported_bands & WMI_HOST_WLAN_5GHZ_CAP) {
> @@ -10991,7 +11034,6 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
>   			band->channels = channels;
>   			band->n_bitrates = ath12k_a_rates_size;
>   			band->bitrates = ath12k_a_rates;
> -			bands[NL80211_BAND_6GHZ] = band;
>   
>   			freq_low = max(reg_cap->low_5ghz_chan,
>   				       ab->reg_freq_6ghz.start_freq);
> @@ -11004,6 +11046,26 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
>   
>   			ath12k_mac_update_freq_range(ar, freq_low, freq_high);
>   			ah->use_6ghz_regd = true;
> +
> +			if (!bands[NL80211_BAND_6GHZ]) {
> +				bands[NL80211_BAND_6GHZ] = band;
> +			} else {
> +				/* Split mac in same band under same wiphy */
> +				ret = ath12k_mac_update_band(ar,
> +							     bands[NL80211_BAND_6GHZ],
> +							     band);
> +				if (ret) {
> +					kfree(ar->mac.sbands[NL80211_BAND_2GHZ].channels);
> +					ar->mac.sbands[NL80211_BAND_2GHZ].channels = NULL;
> +					kfree(channels);
> +					band->channels = NULL;
> +					return ret;
> +				}
> +				ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac pdev %u identified as 6 GHz split mac with start freq %d end freq %d",
> +					   ar->pdev->pdev_id,
> +					   KHZ_TO_MHZ(ar->freq_range.start_freq),
> +					   KHZ_TO_MHZ(ar->freq_range.end_freq));
> +			}
>   		}
>   
>   		if (reg_cap->low_5ghz_chan < ATH12K_MIN_6GHZ_FREQ) {
> @@ -11022,7 +11084,6 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
>   			band->channels = channels;
>   			band->n_bitrates = ath12k_a_rates_size;
>   			band->bitrates = ath12k_a_rates;
> -			bands[NL80211_BAND_5GHZ] = band;
>   
>   			if (ab->hw_params->single_pdev_only) {
>   				phy_id = ath12k_get_phy_id(ar, WMI_HOST_WLAN_5GHZ_CAP);
> @@ -11039,6 +11100,28 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
>   						  reg_cap->high_5ghz_chan);
>   
>   			ath12k_mac_update_freq_range(ar, freq_low, freq_high);
> +
> +			if (!bands[NL80211_BAND_5GHZ]) {
> +				bands[NL80211_BAND_5GHZ] = band;
> +			} else {
> +				/* Split mac in same band under same wiphy */
> +				ret = ath12k_mac_update_band(ar,
> +							     bands[NL80211_BAND_5GHZ],
> +							     band);
> +				if (ret) {
> +					kfree(ar->mac.sbands[NL80211_BAND_2GHZ].channels);
> +					ar->mac.sbands[NL80211_BAND_2GHZ].channels = NULL;
> +					kfree(ar->mac.sbands[NL80211_BAND_6GHZ].channels);
> +					ar->mac.sbands[NL80211_BAND_2GHZ].channels = NULL;
> +					kfree(channels);
> +					band->channels = NULL;
> +					return ret;
> +				}
> +				ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac pdev %u identified as 5 GHz split mac with start freq %d end freq %d",
> +					   ar->pdev->pdev_id,
> +					   KHZ_TO_MHZ(ar->freq_range.start_freq),
> +					   KHZ_TO_MHZ(ar->freq_range.end_freq));
> +			}
>   		}
>   	}
>   
> diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
> index 7048834e0d14..5c577188fa74 100644
> --- a/drivers/net/wireless/ath/ath12k/reg.c
> +++ b/drivers/net/wireless/ath/ath12k/reg.c
> @@ -176,6 +176,12 @@ int ath12k_reg_update_chan_list(struct ath12k *ar, bool wait)
>   			if (bands[band]->channels[i].flags &
>   			    IEEE80211_CHAN_DISABLED)
>   				continue;
> +			/* Skip Channels that are not in current radio's range */
> +			if (bands[band]->channels[i].center_freq <
> +			    KHZ_TO_MHZ(ar->freq_range.start_freq) ||
> +			    bands[band]->channels[i].center_freq >
> +			    KHZ_TO_MHZ(ar->freq_range.end_freq))
> +				continue;

Here will make WCN7850 only updates one band's channel list.

>   
>   			num_channels++;
>   		}
> @@ -204,6 +210,13 @@ int ath12k_reg_update_chan_list(struct ath12k *ar, bool wait)
>   			if (channel->flags & IEEE80211_CHAN_DISABLED)
>   				continue;
>   
> +			/* Skip Channels that are not in current radio's range */
> +			if (bands[band]->channels[i].center_freq <
> +			    KHZ_TO_MHZ(ar->freq_range.start_freq) ||
> +			    bands[band]->channels[i].center_freq >
> +			    KHZ_TO_MHZ(ar->freq_range.end_freq))
> +				continue;


Here will make WCN7850 only updates one band's channel list.


> +
>   			/* TODO: Set to true/false based on some condition? */
>   			ch->allow_ht = true;
>   			ch->allow_vht = true;
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index ea303dca38b5..dfd36491c024 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -5887,9 +5887,16 @@ static int freq_to_idx(struct ath12k *ar, int freq)
>   		if (!sband)
>   			continue;
>   
> -		for (ch = 0; ch < sband->n_channels; ch++, idx++)
> +		for (ch = 0; ch < sband->n_channels; ch++, idx++) {
> +			if (sband->channels[ch].center_freq <
> +			    KHZ_TO_MHZ(ar->freq_range.start_freq) ||
> +			    sband->channels[ch].center_freq >
> +			    KHZ_TO_MHZ(ar->freq_range.end_freq))
> +				continue;
> +
>   			if (sband->channels[ch].center_freq == freq)
>   				goto exit;
> +		}
>   	}
>   
>   exit:
> 
> base-commit: 21346cd925c2567d5f56cdb1421c94815ac10221


