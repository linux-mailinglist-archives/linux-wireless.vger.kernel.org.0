Return-Path: <linux-wireless+bounces-22174-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3A9AA0165
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 06:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C72C3466E5C
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 04:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969D248CFC;
	Tue, 29 Apr 2025 04:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EOxDcJzV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FA64409
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 04:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745901404; cv=none; b=Eb8+RSqHadoWuC2AoRg3vJN59V8LAWIEWPvoDkq+ke4ha5k9I4iEOkKaf/cfDPkTnwpLw47Ol1YvD6oqXXzzK0hunQNdZdN2ujssbddBuB5YQlctlv4jMO9TWOnU8f/cDSJPAyB1A5ioWwvvAFkJteHu1XBeJENUSsr0LWqd8oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745901404; c=relaxed/simple;
	bh=kwAac0XmY9E0EzMUboQix5xD2s5eiCem4Yt7Q1glfi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O0ucyP1hs/wkspR1l8oM4tAFMxNNpuTFPeOsRqI+wOOeAI6ClLuZC6+UJod6jZPIUwmcuWYS7Xou814qSGNive7g5jzSlxSZDcsfjD4MbP2UZs2hNhB0HR+cAdpthYihGs7ABw20kOxb3IU9e2kQ/7QHbn4PaI3GcgGHpQPUjnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EOxDcJzV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SNqISY006805;
	Tue, 29 Apr 2025 04:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h5F6GDNDNVG3efZLMBROVGqEtCgXme6lJSN6yrogOh8=; b=EOxDcJzVSVo8oEiA
	YwSOwSsYKbzy7PIAX8OoDHSpas4wlsDl6nApSjba4jbHCDyp82lJjd+soKkD3KrI
	EE43V1/5VaRDtpkh1avZv512emkLs/M0fkH53DZnt/aB4WTBAwzwqr+qoJohq+vL
	viqDtX1xHSIEvppOyGp58DnwTY2JyAvdJcMDK1lMHxYbR5dbjVlFYxdbyEOGngVs
	n1ec5ESxP5LKQX7JQWAiWckhXgw34AQUFU2qLW79S+S7slW7wZXmHH9oxcPcdLtD
	3I5DgsfJiU6ydgN0pTFho3PSEMDJeLR79r0H2A2Yq0AuITE0tnAc8HxzGDqz7gUv
	0rrFvg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468ptmk7x3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 04:36:37 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53T4aaAq003302
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 04:36:36 GMT
Received: from [10.216.24.29] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 28 Apr
 2025 21:36:34 -0700
Message-ID: <c4aa15f3-79b9-48c8-83a6-a946d8a24a23@quicinc.com>
Date: Tue, 29 Apr 2025 10:06:31 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 2/2] wifi: ath12k: Split scan request for split
 band device
To: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Vignesh C <quic_vignc@quicinc.com>
References: <20250428151927.1169783-1-rameshkumar.sundaram@oss.qualcomm.com>
 <20250428151927.1169783-3-rameshkumar.sundaram@oss.qualcomm.com>
From: Mahendran P <quic_mahep@quicinc.com>
Content-Language: en-US
In-Reply-To: <20250428151927.1169783-3-rameshkumar.sundaram@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xE638SdQxjMtbGfWk0GfnEdC8CAix3sz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDAzMyBTYWx0ZWRfX1pDtRrnfulDS opYxp5JJJHVqAbfkSxeACffCk8/zuiPPQOHY7aOwTgi8ALcWfitPxj++evzEfT6wmWu88bfFGm6 zQWM1nrzaFeVSoosn6+OnxXLgEAv9mYE/6lN+9PM5LebgMBdn89KSiTFw63qb4pKi+/Cdzjyrsr
 CsecE5BtTjS1O0G1KMWO1xoC1u8AhUNUpw1CyKlTtkUcuO/Goqq8lKvYp+8QFz1CYMzpr0FMsXc 2JRx5XqnCrtaTp4rddeeQ4m7555x+1fzVr7GuaiBzgNSBnEVJMsOCmGv4wfdBM/C542Qhl/oyI+ 7shLw/lKqan3CRnaVT9r6CTzMRRMiXZ33nD746v6Rbh4/dcdvGfI0J/jxGdtidVwQ/Zb2NKi9eb
 QfuuyJ/9WJOAFVJh7Mzqhk0oMoBvqDdJKeA6qw4A3TqMJVMyC1J9tvQlZJPJATSeYi+2B46M
X-Proofpoint-GUID: xE638SdQxjMtbGfWk0GfnEdC8CAix3sz
X-Authority-Analysis: v=2.4 cv=DKWP4zNb c=1 sm=1 tr=0 ts=68105755 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=gB7bVOSc0XIp0_K5HaAA:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290033

On 4/28/2025 8:49 PM, Rameshkumar Sundaram wrote:
> When two split-phy devices having supported frequency range in same band
> (as mentioned below) are combined into an ath12k HW group, they will be
> part of same wiphy and hence the channel list (wiphy->bands[]) will be
> common for all of the radios (ar).
> 
> 1 - 2.4 GHz + 5 GHz Low band
> 2 - 5 GHz High band + 6 GHz
> 
> When a scan is triggered with frequency list containing frequencies of
> both  5 GHz low and 5 GHz high, mac80211 generates a single scan request
> to driver with both the frequencies. This is because mac80211 splits the
> scan request based on band.
> 
> ath12k checks the first frequency in the requested scan frequency list and
> initiates scan to corresponding radio's(ar) firmware with all the
> frequencies. Firmware rejects this scan as some frequencies in the scan
> request are not supported, resulting is scan failure.
> 
> Fix this by splitting the scan request into multiples scans in driver
> based on the supported frequency range of different radios in a band and
> schedule scans in parallel to them.
> Finally send scan completion/abort notification to mac80211 after all the
> radios complete their scheduled scan.
> 
> Also, last_scan_link is not needed anymore as ath12k internally schedules
> multiple scans, remove the same and use ahvif->links_map to identify
> scan links when scan is cancelled.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> Co-developed-by: Vignesh C <quic_vignc@quicinc.com>
> Signed-off-by: Vignesh C <quic_vignc@quicinc.com>
> Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/core.h |   2 -
>  drivers/net/wireless/ath/ath12k/mac.c  | 148 ++++++++++++++++++++-----
>  2 files changed, 118 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 0d512818ee96..c8fd0b29aaa1 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -353,8 +353,6 @@ struct ath12k_vif {
>  	struct ath12k_vif_cache *cache[IEEE80211_MLD_MAX_NUM_LINKS];
>  	/* indicates bitmap of link vif created in FW */
>  	u32 links_map;
> -	u8 last_scan_link;
> -
>  	/* Must be last - ends in a flexible-array member.
>  	 *
>  	 * FIXME: Driver should not copy struct ieee80211_chanctx_conf,
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 6dab2f3a9e0d..236e3ee22d4d 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -4249,6 +4249,23 @@ static void ath12k_scan_timeout_work(struct work_struct *work)
>  	wiphy_unlock(ath12k_ar_to_hw(ar)->wiphy);
>  }
>  
> +static void ath12k_mac_scan_send_complete(struct ath12k *ar,
> +					  struct cfg80211_scan_info *info)
> +{
> +	struct ath12k_hw *ah = ar->ah;
> +	struct ath12k *partner_ar;
> +	int i;
> +
> +	lockdep_assert_wiphy(ah->hw->wiphy);
> +
> +	for_each_ar(ah, partner_ar, i)
> +		if (partner_ar != ar &&
> +		    partner_ar->scan.state == ATH12K_SCAN_RUNNING)
> +			return;
> +
> +	ieee80211_scan_completed(ah->hw, info);
> +}
> +
>  static void ath12k_scan_vdev_clean_work(struct wiphy *wiphy, struct wiphy_work *work)
>  {
>  	struct ath12k *ar = container_of(work, struct ath12k,
> @@ -4287,7 +4304,7 @@ static void ath12k_scan_vdev_clean_work(struct wiphy *wiphy, struct wiphy_work *
>  				    ATH12K_SCAN_STARTING)),
>  		};
>  
> -		ieee80211_scan_completed(ar->ah->hw, &info);
> +		ath12k_mac_scan_send_complete(ar, &info);
>  	}
>  
>  	ar->scan.state = ATH12K_SCAN_IDLE;
> @@ -4506,12 +4523,14 @@ ath12k_mac_find_link_id_by_ar(struct ath12k_vif *ahvif, struct ath12k *ar)
>  	return ATH12K_FIRST_SCAN_LINK;
>  }
>  
> -static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
> -				 struct ieee80211_vif *vif,
> -				 struct ieee80211_scan_request *hw_req)
> +static int ath12k_mac_initiate_hw_scan(struct ieee80211_hw *hw,
> +				       struct ieee80211_vif *vif,
> +				       struct ieee80211_scan_request *hw_req,
> +				       int n_channels,
> +				       struct ieee80211_channel **chan_list,
> +				       struct ath12k *ar)
>  {
>  	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
> -	struct ath12k *ar;
>  	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
>  	struct ath12k_link_vif *arvif;
>  	struct cfg80211_scan_request *req = &hw_req->req;
> @@ -4525,13 +4544,6 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
>  
>  	arvif = &ahvif->deflink;
>  
> -	/* Since the targeted scan device could depend on the frequency
> -	 * requested in the hw_req, select the corresponding radio
> -	 */
> -	ar = ath12k_mac_select_scan_device(hw, vif, hw_req->req.channels[0]->center_freq);
> -	if (!ar)
> -		return -EINVAL;
> -
>  	/* check if any of the links of ML VIF is already started on
>  	 * radio(ar) corresponding to given scan frequency and use it,
>  	 * if not use scan link (link id >= 15) for scan purpose.
> @@ -4634,8 +4646,8 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
>  		arg->scan_f_passive = 1;
>  	}
>  
> -	if (req->n_channels) {
> -		arg->num_chan = req->n_channels;
> +	if (n_channels) {
> +		arg->num_chan = n_channels;
>  		arg->chan_list = kcalloc(arg->num_chan, sizeof(*arg->chan_list),
>  					 GFP_KERNEL);
>  		if (!arg->chan_list) {
> @@ -4644,7 +4656,7 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
>  		}
>  
>  		for (i = 0; i < arg->num_chan; i++)
> -			arg->chan_list[i] = req->channels[i]->center_freq;
> +			arg->chan_list[i] = chan_list[i]->center_freq;
>  	}
>  
>  	ret = ath12k_start_scan(ar, arg);
> @@ -4662,13 +4674,6 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
>  
>  	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac scan started");
>  
> -	/* As per cfg80211/mac80211 scan design, it allows only one
> -	 * scan at a time. Hence last_scan link id is used for
> -	 * tracking the link id on which the scan is been done on
> -	 * this vif.
> -	 */
> -	ahvif->last_scan_link = arvif->link_id;
> -
>  	/* Add a margin to account for event/command processing */
>  	ieee80211_queue_delayed_work(ath12k_ar_to_hw(ar), &ar->scan.timeout,
>  				     msecs_to_jiffies(arg->max_scan_time +
> @@ -4689,25 +4694,108 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
>  	return ret;
>  }
>  
> +static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
> +				 struct ieee80211_vif *vif,
> +				 struct ieee80211_scan_request *hw_req)
> +{
> +	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
> +	struct ieee80211_channel **chan_list, *chan;
> +	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
> +	unsigned long links_map, link_id;
> +	struct ath12k_link_vif *arvif;
> +	struct ath12k *ar, *scan_ar;
> +	int i, j, ret = 0;
> +
> +	lockdep_assert_wiphy(hw->wiphy);
> +
> +	chan_list = kcalloc(hw_req->req.n_channels, sizeof(*chan_list), GFP_KERNEL);
> +	if (!chan_list)
> +		return -ENOMEM;
> +
> +	/* There could be channels that belong to multiple underlying radio
> +	 * in same scan request as mac80211 sees it as single band. In that
> +	 * case split the hw_req based on frequency range and schedule scans to
> +	 * corresponding radio.
> +	 */
> +	for_each_ar(ah, ar, i) {
> +		int n_chans = 0;
> +
> +		for (j = 0; j < hw_req->req.n_channels; j++) {
> +			chan = hw_req->req.channels[j];
> +			scan_ar = ath12k_mac_select_scan_device(hw, vif,
> +								chan->center_freq);
> +			if (!scan_ar) {
> +				ath12k_hw_warn(ah, "unable to select scan device for freq %d\n",
> +					       chan->center_freq);
> +				ret = -EINVAL;
> +				goto abort;
> +			}
> +			if (ar != scan_ar)
> +				continue;
> +
> +			chan_list[n_chans++] = chan;
> +		}
> +		if (n_chans) {
> +			ret = ath12k_mac_initiate_hw_scan(hw, vif, hw_req, n_chans,
> +							  chan_list, ar);
> +			if (ret)
> +				goto abort;
> +		}
> +	}
> +abort:
> +	/* If any of the parallel scans initiated fails, abort all and
> +	 * remove the scan interfaces created. Return complete scan
> +	 * failure as mac80211 assumes this as single scan request.
> +	 */
> +	if (ret) {
> +		ath12k_hw_warn(ah, "Scan failed %d , cleanup all scan vdevs\n", ret);
> +		links_map = ahvif->links_map;
> +		for_each_set_bit(link_id, &links_map, ATH12K_NUM_MAX_LINKS) {
> +			arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
> +			if (!arvif)
> +				continue;
> +
> +			ar = arvif->ar;
> +			if (ar->scan.arvif == arvif) {
> +				wiphy_work_cancel(hw->wiphy, &ar->scan.vdev_clean_wk);
> +				spin_lock_bh(&ar->data_lock);
> +				ar->scan.arvif = NULL;
> +				ar->scan.state = ATH12K_SCAN_IDLE;
> +				ar->scan_channel = NULL;
> +				ar->scan.roc_freq = 0;
> +				spin_unlock_bh(&ar->data_lock);
> +			}
> +			if (link_id >= ATH12K_FIRST_SCAN_LINK) {
> +				ath12k_mac_remove_link_interface(hw, arvif);
> +				ath12k_mac_unassign_link_vif(arvif);
> +			}
> +		}
> +	}
> +	kfree(chan_list);
> +	return ret;
> +}
> +
>  static void ath12k_mac_op_cancel_hw_scan(struct ieee80211_hw *hw,
>  					 struct ieee80211_vif *vif)
>  {
>  	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
> -	u16 link_id = ahvif->last_scan_link;
> +	unsigned long link_id, links_map = ahvif->links_map;
>  	struct ath12k_link_vif *arvif;
>  	struct ath12k *ar;
>  
>  	lockdep_assert_wiphy(hw->wiphy);
>  
> -	arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
> -	if (!arvif || arvif->is_started)
> -		return;
> +	for_each_set_bit(link_id, &links_map, ATH12K_NUM_MAX_LINKS) {
> +		arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
> +		if (!arvif || arvif->is_started)
> +			continue;
>  
> -	ar = arvif->ar;
> +		ar = arvif->ar;
>  
> -	ath12k_scan_abort(ar);
> +		ath12k_scan_abort(ar);
>  
> -	cancel_delayed_work_sync(&ar->scan.timeout);
> +		cancel_delayed_work_sync(&ar->scan.timeout);
> +	}
>  }
>  
>  static int ath12k_install_key(struct ath12k_link_vif *arvif,
> @@ -8917,7 +9005,7 @@ static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
>  					.aborted = true,
>  				};
>  
> -				ieee80211_scan_completed(ar->ah->hw, &info);
> +				ath12k_mac_scan_send_complete(ar, &info);
>  			}
>  
>  			ar->scan.state = ATH12K_SCAN_IDLE;

Reviewed-by: Mahendran P <quic_mahep@quicinc.com>


