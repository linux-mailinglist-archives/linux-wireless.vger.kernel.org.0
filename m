Return-Path: <linux-wireless+bounces-22172-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 213B0AA0162
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 06:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 536DB7A8A57
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 04:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0501078F;
	Tue, 29 Apr 2025 04:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="it0Iu3TG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5F24409
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 04:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745901384; cv=none; b=PpW+rQU5UghxGnSWfrkKs9+WpK6vk83O0sZy1NO3rdEi/WT+CCALGXD+x3Jh40uL2BVD3k8Hm0Rz/HENT/3slRCWz+E9mSSbORJJxV8mMfpg2HYUCdDvtlXHFssOEt2pnJpcmivFGD9KvexTj1rMQ8VHwFdUddgg+8RJqxUwB6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745901384; c=relaxed/simple;
	bh=q1X4PdsVSQPp+TNC/35tWRYvYjFgw6ROuJxv3ycUBjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u11Wie8BR0KuL68NLDZl6dHNDllpxkvY9O+peNWi13N7NCR14Brg+Mn6E429azmpoogZrSEwE4LZEK218RCco3opRweLPTGIYX6VgLL/58GrHhecmTdFxZMrRvZBkYIgFI48voN247Ns8EjswwadVCFtEE5jYyXO8yw/64vVkuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=it0Iu3TG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SNqISW006805;
	Tue, 29 Apr 2025 04:36:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i/HnctR1j7Z9DcND90xaCFatpdnRa8F8QFkEqOxeNBE=; b=it0Iu3TGlw+WIsp1
	TfrvsVS0rOZbP3F7svui9kJlLmGBgHLpAqaVhR1vruWcjslMSjTrYZVCbeo7HDxI
	oy59p9yDFiXv50gh+ygxsTJnpPUiYAxBw/AKTkug8gpBiHLJvcxZGGkuwIpCOsQc
	dKXOcOJOgIEuPI+0/ostweMiBWzjuoGVTnbcxVuQoJLvpAyrPNsW3aWV3uKIAlcw
	m8QwwPCY2yIgYP7AhjZxK0S1+NdZTAC3pcJyQwsJn2FtscTJFKQuBkmoupa7oP3z
	xBb5C9xFx510ACB4AA8oZiQ/fU2PWmplgvsKx6sAzBF4Y2ipk07j1+N5cu/tIZuh
	mViuPA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468ptmk7wa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 04:36:17 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53T4aGB6026357
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 04:36:16 GMT
Received: from [10.216.24.29] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 28 Apr
 2025 21:36:14 -0700
Message-ID: <f885ba24-1736-47b7-b686-8de181cafcc8@quicinc.com>
Date: Tue, 29 Apr 2025 10:06:11 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 1/2] wifi: ath12k: Prepare ahvif scan link for
 parallel scan
To: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250428151927.1169783-1-rameshkumar.sundaram@oss.qualcomm.com>
 <20250428151927.1169783-2-rameshkumar.sundaram@oss.qualcomm.com>
From: Mahendran P <quic_mahep@quicinc.com>
Content-Language: en-US
In-Reply-To: <20250428151927.1169783-2-rameshkumar.sundaram@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: r8cebaliMr4GjAro7fs4uhVt7eUWg4v0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDAzMyBTYWx0ZWRfX42sMq29lZXHg 0e06ZeyooPo3RDQDv7GKujKyHEej5/ECuwVv8xZP2NyRHjS1ojzDxwLvE9V00Aq81VTMNTHKWTs AFdtRAf8TnPOgMhrpb7ItR0+lCnYQ22RlPIIakR6BPv+DAMfozyx3iXcC7eDyMA1y9SXtf27xmm
 fKqz87/hPFiXClcjMJ6df251N2lrBsBTLiJKj5KK62HYIEhm/P+4V9VMMucN8CSfrV2mkCtw7UD mKqmvYvnG0+o0fbRU3uapC8EKhqhcGvdeWaVA3hxEPvVbozIxVKJ9U2Ra7nnuqt0SrWUZEp5mqB 1gfYUKEMOtnuwPDqM4h1HiludZ1pMDRzEAw4SyXfSSoXV5/+2Fq0bhBETEcHEMJZB8HaLckLTl3
 im6S3nXBiEEvXIXnzENUHBkiYtVuuRn4WDQ8Om7uO8oOBsBl09j7mnSN9vCz1PWGJcJletGz
X-Proofpoint-GUID: r8cebaliMr4GjAro7fs4uhVt7eUWg4v0
X-Authority-Analysis: v=2.4 cv=DKWP4zNb c=1 sm=1 tr=0 ts=68105741 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=bHGmK2d0Q8oOqtnJHTwA:9
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
> When two split-phy devices that support overlapping frequency ranges within
> the same band(say 5 GHz low and 5 GHz high) are grouped into an ath12k
> hardware (HW) setup, they share a common wiphy instance. Consequently, the
> channel list (wiphy->bands[]) becomes unified across all associated
> radios (ar).
> 
> When a scan is triggered with frequency list containing frequencies of
> both 5 GHz low and 5 GHz high, mac80211 generates a single scan request
> to driver with all the frequencies. This is because mac80211 splits the
> scan request based on band.
> 
> ath12k checks the first frequency in the requested scan frequency list and
> initiates scan to corresponding radio's(ar) firmware with all the
> frequencies. Firmware rejects this scan since some of the frequencies in
> the scan request are not supported, resulting in a scan failure.
> To fix this ath12k driver should split the scan request into multiple
> scans based on requested frequencies and schedule them to corresponding
> underlying radio(s) in parallel.
> 
> Currently, ath12k driver assigns the scan link (link 15) in ahvif->links[]
> for scan vdev creation. However, with parallel scan support being
> introduced in the following patch, multiple radios (e.g., 5 GHz low and
> 5 GHz high) in the same HW group may attempt to use the same scan link
> concurrently, causing conflicts where the vdev created by one radio could
> be deleted and re-initialized by another.
> 
> To address this, reserve space for additional scan links for each radio in
> a MLO group and allow subsequent radios to use different available scan
> links (ahvif->link[15..MAX_SCAN_LINKS]) when scan link (15) is
> pre-occupied.
> While at it, rename ATH12K_DEFAULT_SCAN_LINK as ATH12K_FIRST_SCAN_LINK
> as there is no longer only one scan link.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/core.h |  2 +-
>  drivers/net/wireless/ath/ath12k/mac.c  | 49 +++++++++++++++++++-------
>  drivers/net/wireless/ath/ath12k/mac.h  |  7 ++--
>  3 files changed, 42 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 4b8f434e3e9a..0d512818ee96 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -352,7 +352,7 @@ struct ath12k_vif {
>  	struct ath12k_link_vif __rcu *link[ATH12K_NUM_MAX_LINKS];
>  	struct ath12k_vif_cache *cache[IEEE80211_MLD_MAX_NUM_LINKS];
>  	/* indicates bitmap of link vif created in FW */
> -	u16 links_map;
> +	u32 links_map;
>  	u8 last_scan_link;
>  
>  	/* Must be last - ends in a flexible-array member.
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 8949073c0163..6dab2f3a9e0d 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -3483,7 +3483,7 @@ static struct ath12k_link_vif *ath12k_mac_assign_link_vif(struct ath12k_hw *ah,
>  	/* If this is the first link arvif being created for an ML VIF
>  	 * use the preallocated deflink memory except for scan arvifs
>  	 */
> -	if (!ahvif->links_map && link_id != ATH12K_DEFAULT_SCAN_LINK) {
> +	if (!ahvif->links_map && link_id < ATH12K_FIRST_SCAN_LINK) {
>  		arvif = &ahvif->deflink;
>  
>  		if (vif->type == NL80211_IFTYPE_STATION)
> @@ -4475,11 +4475,12 @@ ath12k_mac_find_link_id_by_ar(struct ath12k_vif *ahvif, struct ath12k *ar)
>  	struct ath12k_link_vif *arvif;
>  	struct ath12k_hw *ah = ahvif->ah;
>  	unsigned long links = ahvif->links_map;
> +	unsigned long scan_links_map;
>  	u8 link_id;
>  
>  	lockdep_assert_wiphy(ah->hw->wiphy);
>  
> -	for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
> +	for_each_set_bit(link_id, &links, ATH12K_NUM_MAX_LINKS) {
>  		arvif = wiphy_dereference(ah->hw->wiphy, ahvif->link[link_id]);
>  
>  		if (!arvif || !arvif->is_created)
> @@ -4489,10 +4490,20 @@ ath12k_mac_find_link_id_by_ar(struct ath12k_vif *ahvif, struct ath12k *ar)
>  			return link_id;
>  	}
>  
> -	/* input ar is not assigned to any of the links of ML VIF, use scan
> -	 * link (15) for scan vdev creation.
> +	/* input ar is not assigned to any of the links of ML VIF, use next
> +	 * available scan link for scan vdev creation. There are cases where
> +	 * single scan req needs to be split in driver and initiate separate
> +	 * scan requests to firmware based on device.
>  	 */
> -	return ATH12K_DEFAULT_SCAN_LINK;
> +
> +	 /* Unset all non-scan links (0-14) of scan_links_map so that ffs() will
> +	  * choose an available link among scan links (i.e link id >= 15)
> +	  */
> +	scan_links_map = ~ahvif->links_map & ATH12K_SCAN_LINKS_MASK;
> +	if (scan_links_map)
> +		return __ffs(scan_links_map);
> +
> +	return ATH12K_FIRST_SCAN_LINK;
>  }
>  
>  static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
> @@ -4523,9 +4534,16 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
>  
>  	/* check if any of the links of ML VIF is already started on
>  	 * radio(ar) corresponding to given scan frequency and use it,
> -	 * if not use scan link (link 15) for scan purpose.
> +	 * if not use scan link (link id >= 15) for scan purpose.
>  	 */
>  	link_id = ath12k_mac_find_link_id_by_ar(ahvif, ar);
> +	/* All scan links are occupied. ideally this shouldn't happen as
> +	 * mac80211 won't schedule scan for same band until ongoing scan is
> +	 * completed, don't try to exceed max links just in case if it happens.
> +	 */
> +	if (link_id >= ATH12K_NUM_MAX_LINKS)
> +		return -EBUSY;
> +
>  	arvif = ath12k_mac_assign_link_vif(ah, vif, link_id);
>  
>  	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac link ID %d selected for scan",
> @@ -8654,7 +8672,8 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
>  	struct ath12k_hw *ah = hw->priv;
>  	struct ath12k *ar;
>  	struct ath12k_base *ab;
> -	u8 link_id = arvif->link_id;
> +	u8 link_id = arvif->link_id, scan_link_id;
> +	unsigned long scan_link_map;
>  	int ret;
>  
>  	lockdep_assert_wiphy(hw->wiphy);
> @@ -8673,12 +8692,16 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
>  	 * and now we want to create for actual usage.
>  	 */
>  	if (ieee80211_vif_is_mld(vif)) {
> -		scan_arvif = wiphy_dereference(hw->wiphy,
> -					       ahvif->link[ATH12K_DEFAULT_SCAN_LINK]);
> -		if (scan_arvif && scan_arvif->ar == ar) {
> -			ar->scan.arvif = NULL;
> -			ath12k_mac_remove_link_interface(hw, scan_arvif);
> -			ath12k_mac_unassign_link_vif(scan_arvif);
> +		scan_link_map = ahvif->links_map & ATH12K_SCAN_LINKS_MASK;
> +		for_each_set_bit(scan_link_id, &scan_link_map, ATH12K_NUM_MAX_LINKS) {
> +			scan_arvif = wiphy_dereference(hw->wiphy,
> +						       ahvif->link[scan_link_id]);
> +			if (scan_arvif && scan_arvif->ar == ar) {
> +				ar->scan.arvif = NULL;
> +				ath12k_mac_remove_link_interface(hw, scan_arvif);
> +				ath12k_mac_unassign_link_vif(scan_arvif);
> +				break;
> +			}
>  		}
>  	}
>  
> diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
> index da37332352fe..8ec4a890172c 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.h
> +++ b/drivers/net/wireless/ath/ath12k/mac.h
> @@ -51,8 +51,11 @@ struct ath12k_generic_iter {
>  /* Default link after the IEEE802.11 defined Max link id limit
>   * for driver usage purpose.
>   */
> -#define ATH12K_DEFAULT_SCAN_LINK	IEEE80211_MLD_MAX_NUM_LINKS
> -#define ATH12K_NUM_MAX_LINKS		(IEEE80211_MLD_MAX_NUM_LINKS + 1)
> +#define ATH12K_FIRST_SCAN_LINK		IEEE80211_MLD_MAX_NUM_LINKS
> +#define ATH12K_SCAN_MAX_LINKS		ATH12K_GROUP_MAX_RADIO
> +/* Define 1 scan link for each radio for parallel scan purposes */
> +#define ATH12K_NUM_MAX_LINKS	(IEEE80211_MLD_MAX_NUM_LINKS + ATH12K_SCAN_MAX_LINKS)
> +#define ATH12K_SCAN_LINKS_MASK	GENMASK(ATH12K_NUM_MAX_LINKS, IEEE80211_MLD_MAX_NUM_LINKS)
>  
>  enum ath12k_supported_bw {
>  	ATH12K_BW_20    = 0,

Reviewed-by: Mahendran P <quic_mahep@quicinc.com>


