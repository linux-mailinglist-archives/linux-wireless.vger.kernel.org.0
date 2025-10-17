Return-Path: <linux-wireless+bounces-28013-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 983D2BE665E
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 07:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8529A4E3209
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 05:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A29F33F9;
	Fri, 17 Oct 2025 05:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BLPP2Xad"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE8C211F
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 05:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760678301; cv=none; b=UiPKPsPfMHuDf+CbbRArfwfOYXwz4CexvxgVX4RtVIYaMSVnIGT6mpC3g54AL2/ypLIM+ZbyiV74teUHnsK8XBg8aCfFJPDuwA23kZ2OaIeeyrsKwkoZdRFatNa9IwPNKA5ZfdFdcKjAEYar/YaBtp3l/0qwqwd2HXIFapdfj9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760678301; c=relaxed/simple;
	bh=nkTt7gBAoGYAj26O7473q3nFocPQatxvSUf6NdpYVFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ciITNJhoQ7f2AlAsaTZ+PwnP7mZcYfwyzwaPLzJdEB6IvVckYv3s9P7m/Mkzi0E2nsha10SBStnRybLn26MLwRKT20cj3xLMGoKwtg9AvdjBJvo3/NL5sgIt0ncswYmlemaOt2j2X5VMIRZMWYa0l1dZ7YN411ylyM63RQVlFSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BLPP2Xad; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLd5Z009737
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 05:18:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	reIHbmg1S2LMtMkXhq1TwKOVbfmyVwDGwoULlqSh5v0=; b=BLPP2XadcuqktZI4
	G5PLw4KumE1fOGyMHBatZ8wh+z6S4ygVMb7VO4ll5jIMyjQI/SaAGeElBTst9V6N
	Jmw4rTFjmlP674GmV0Y+QH15lDAMlBhWhOrTk5yrzLzDhvgRZvkgP1qP0G5xT1S+
	QaqDqojXhBgj87lTuxhx0oZR40iiyltwaV5nrTuDAPa35YCk7wxhEPSuVFGQuKH4
	cknIS3KOWW9kYLCFodEYwk7QsUObrGkA9/V1LI5/LpLCf19xv71mrhj6wvuBRU84
	J+1IXzDY9bGQvU4Ov/LH/l/G2y47fVnhVWFH7Cx3+VVwpPiVa+yjWuB3dD5vRRsK
	dJdO2Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rw1aq62a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 05:18:18 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-290c07feb72so8812145ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 16 Oct 2025 22:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760678297; x=1761283097;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=reIHbmg1S2LMtMkXhq1TwKOVbfmyVwDGwoULlqSh5v0=;
        b=UEQdPk6+23fnJhJmw0XKqFmJ2mtg7tEdm/C1AX7A1KF4YtNCXcYp8DbXtf/AgIOLHX
         EPb9twcgTUWSRJfhNhzfS4i1j3PZXniSKV1Xh4Lw0yb3TSrSmUCHfctE47RU/aiHPOuo
         nj6OkiDw8dgOMBWvsaC955E67SP3jrFQYC7Z4ELQmVUMOt3HnxliaIrnT1f28TvxwqrG
         ZCgUceiuT0OQvkZGCEODgzfxBOVmffWI+HRvS8k01NQqvLO3VtpCoS3kx1FiQJk0U+EB
         d81n6H93yTOejR0/LMs6juFOIwbJhGPYU3zCdWw/owVgq5LiJPNt93tXadrvwqYroehQ
         VH9g==
X-Forwarded-Encrypted: i=1; AJvYcCX2D6hz2wrE1Kv/I0dYABZVjaUDVsC1A7Xo/Wcdeyt1SGDgxLJ/S2YNDLuZAihLOWLiacE/K3tpacLDFHxpYA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzytXFcIuxSNEia0uYVzDVlMWZs+cz9ohys/vu0xrh7VzvfAEIw
	xOY3euzI8akThDYc8/H5ztd2+35wSQ73NrtMPafhIm0ArGtGLtSORvjyUWVxd+WnbDJ7miHS7ow
	h92e8OlldFn6US9cbAMJYo92F5366EARSVZTu9mLNMnjAjnrL63TufNd90s+W1m9k+R9a6/eUk/
	33cw==
X-Gm-Gg: ASbGncs3BXlAAHirQvT6HzVjq1usC+Xe5YF7E0xv0xGIyo6MUng0D+r18DGr8lqZnHb
	t1wuzhqpxujT8jxog1RztQbv2MEWiFtQKFD3Rtl+3e3ysx71glur0y6Rt8RuVbvD6GkLKs2rTKj
	EztIN/nV3qgnAA6R8u9r4VE8EHTG/2KQr+y94R36tTVHsCv4nObrAmQgXhhw72dnOii8TCwoKVF
	D45i9mGdzVsOaXLlqPTkSo0j9mpymbiDrBkC1eypOa2lkLe7Q7lsTV3Yebqv/4fNIxj3y34HSK8
	r1oLRrPj6LdH2UoNtzt1FmIxb/TNv7FSf9vAy5E1E9IW9sInEqfNh0qpBMXahRxXfc6FnqQ4Tm8
	7xJ4oARIkoezbn/VEnSkfEij1Hes8rjqzow0fdmYso+yYDpcak1c6S7Ve0LxDlF72ng7TpoY=
X-Received: by 2002:a17:902:f78b:b0:290:ab61:6a4f with SMTP id d9443c01a7336-290c9cb367fmr25156875ad.15.1760678296973;
        Thu, 16 Oct 2025 22:18:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4prvPmsGUPvifuO4VqVP6f5Din1XYOHdg3K5RZLlEX3aVsF4HGyFAAqiXlyH23pZrahBu9g==
X-Received: by 2002:a17:902:f78b:b0:290:ab61:6a4f with SMTP id d9443c01a7336-290c9cb367fmr25156665ad.15.1760678296499;
        Thu, 16 Oct 2025 22:18:16 -0700 (PDT)
Received: from [10.133.33.11] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a22bb5b8fsm4622661a12.37.2025.10.16.22.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 22:18:16 -0700 (PDT)
Message-ID: <d725799f-6e96-4463-adfc-12ec355dd1b5@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 13:18:13 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: add support for BSS color change
To: Wei Zhang <wei.zhang@oss.qualcomm.com>, jeff.johnson@oss.qualcomm.com
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
References: <20251017041702.1723258-1-wei.zhang@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251017041702.1723258-1-wei.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=K88v3iWI c=1 sm=1 tr=0 ts=68f1d19a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=6FjxNNwmztaAyVa-sjcA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: BxFMLa8e9LPKMr7T5YRuy-LY0-NAsHhs
X-Proofpoint-ORIG-GUID: BxFMLa8e9LPKMr7T5YRuy-LY0-NAsHhs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAzNSBTYWx0ZWRfX4hUWr19ERkQV
 sEW1pZAcXThytMXGZknjvfrP/FA0+42yExSKjOIDABaHfGBxw16ZmpZb9BpHAT3P95PUw/deOdq
 Oe6eNPCyFS6yen+0ZYJqzlrD521T85LD8Y048gJ+EMbw+jDNzTBq3U7CgrxDJOSxWWoG+U9YpPp
 z1QaNnQPgrCGdJHG3xARVmd6eSongEA5qD1e6wRhtw2gf4i3mJjVjjEgkm1q8MSRtHZvImvP7ik
 q6qfn6PpthXTLc2pikMdS/dGlkZTAb5JZ/gof2NoP/qJ69pIRddle50YCfUsXjdtY+6z5XcfqC5
 LUiGqcz+t8KVSu1+hqn/mNC8qhKzQqABuo2STQPpbdA7zKB8qb9y3R6TjMM5VVZ2VdvBCGjH5yJ
 me+NRus37b7iSCh2zDz7VbFyD10jEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130035



On 10/17/2025 12:17 PM, Wei Zhang wrote:
> Add support for handling BSS color collision events reported by firmware.
> 
> There are two scenarios where a BSS color collision may be detected:
> 1. The AP's MAC detects the collision directly, and firmware reports a
>    BSS color collision event to the host.
> 2. A STA associated with the AP detects the collision. The notification
>    frame from the peer is routed directly to the AP firmware, which handles
>    it and sends the BSS color collision event to the host.
> 
> This patch add logic to parse and handle such events, and pass the data
> up to mac80211.

Jeff's commet is not fully addressed ...

s/This patch add/Add/

> 
> Unlike CSA, firmware does not provide an offload mechanism for BSS color
> change. Instead, the color change process is triggered via beacon offload
> TX completion events sent by firmware.
> 
> BSS color feature is enabled depending on service flag advertised by
> firmware, based on which color change functionality is invoked.
> 
> This change builds upon the following ath11k patch.
> commit 886433a98425 ("ath11k: add support for BSS color change")
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.IOE_HMT.1.1-00011-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
> 
> Signed-off-by: Wei Zhang <wei.zhang@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/core.h |  1 +
>  drivers/net/wireless/ath/ath12k/mac.c  | 58 +++++++++++++++++++-
>  drivers/net/wireless/ath/ath12k/wmi.c  | 73 +++++++++++++++++++++++++-
>  drivers/net/wireless/ath/ath12k/wmi.h  | 24 +++++++++
>  4 files changed, 154 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 02a32b9f3ac2..41da0efaa854 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -356,6 +356,7 @@ struct ath12k_link_vif {
>  	bool pairwise_key_done;
>  	u16 num_stations;
>  	bool is_csa_in_progress;
> +	struct wiphy_work bcn_tx_work;
>  };
>  
>  struct ath12k_vif {
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 86b79deacf03..eb9b9a322870 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -3834,6 +3834,38 @@ static void ath12k_recalculate_mgmt_rate(struct ath12k *ar,
>  		ath12k_warn(ar->ab, "failed to set beacon tx rate %d\n", ret);
>  }
>  
> +static void ath12k_mac_bcn_tx_event(struct ath12k_link_vif *arvif)
> +{
> +	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
> +	struct ieee80211_bss_conf *link_conf;
> +
> +	link_conf = ath12k_mac_get_link_bss_conf(arvif);
> +	if (!link_conf) {
> +		ath12k_warn(arvif->ar->ab, "failed to get link conf for vdev %u\n",
> +			    arvif->vdev_id);
> +		return;
> +	}
> +
> +	if (link_conf->color_change_active) {
> +		if (ieee80211_beacon_cntdwn_is_complete(vif, arvif->link_id)) {
> +			ieee80211_color_change_finish(vif, arvif->link_id);
> +			return;
> +		}
> +
> +		ieee80211_beacon_update_cntdwn(vif, arvif->link_id);
> +		ath12k_mac_setup_bcn_tmpl(arvif);
> +	}
> +}
> +
> +static void ath12k_mac_bcn_tx_work(struct wiphy *wiphy, struct wiphy_work *work)
> +{
> +	struct ath12k_link_vif *arvif = container_of(work, struct ath12k_link_vif,
> +						     bcn_tx_work);
> +
> +	lockdep_assert_wiphy(wiphy);
> +	ath12k_mac_bcn_tx_event(arvif);
> +}
> +
>  static void ath12k_mac_init_arvif(struct ath12k_vif *ahvif,
>  				  struct ath12k_link_vif *arvif, int link_id)
>  {
> @@ -3863,6 +3895,7 @@ static void ath12k_mac_init_arvif(struct ath12k_vif *ahvif,
>  	INIT_LIST_HEAD(&arvif->list);
>  	INIT_DELAYED_WORK(&arvif->connection_loss_work,
>  			  ath12k_mac_vif_sta_connection_loss_work);
> +	wiphy_work_init(&arvif->bcn_tx_work, ath12k_mac_bcn_tx_work);
>  
>  	arvif->num_stations = 0;
>  
> @@ -3900,6 +3933,7 @@ static void ath12k_mac_remove_link_interface(struct ieee80211_hw *hw,
>  	lockdep_assert_wiphy(ah->hw->wiphy);
>  
>  	cancel_delayed_work_sync(&arvif->connection_loss_work);
> +	wiphy_work_cancel(ath12k_ar_to_hw(ar)->wiphy, &arvif->bcn_tx_work);
>  
>  	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac remove link interface (vdev %d link id %d)",
>  		   arvif->vdev_id, arvif->link_id);
> @@ -4547,8 +4581,25 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
>  							    ATH12K_BSS_COLOR_AP_PERIODS,
>  							    info->he_bss_color.enabled);
>  			if (ret)
> -				ath12k_warn(ar->ab, "failed to set bss color collision on vdev %i: %d\n",
> +				ath12k_warn(ar->ab, "failed to set bss color collision on vdev %u: %d\n",
>  					    arvif->vdev_id,  ret);
> +
> +			param_id = WMI_VDEV_PARAM_BSS_COLOR;
> +			if (info->he_bss_color.enabled)
> +				param_value = info->he_bss_color.color <<
> +					      IEEE80211_HE_OPERATION_BSS_COLOR_OFFSET;
> +			else
> +				param_value = IEEE80211_HE_OPERATION_BSS_COLOR_DISABLED;
> +
> +			ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
> +							    param_id,
> +							    param_value);
> +			if (ret)
> +				ath12k_warn(ar->ab, "failed to set bss color param on vdev %u: %d\n",
> +					    arvif->vdev_id,  ret);
> +			else
> +				ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "bss color param 0x%x set on vdev %u\n",
> +					   param_value, arvif->vdev_id);
>  		} else if (vif->type == NL80211_IFTYPE_STATION) {
>  			ret = ath12k_wmi_send_bss_color_change_enable_cmd(ar,
>  									  arvif->vdev_id,
> @@ -13972,6 +14023,11 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
>  	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
>  	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_STA_TX_PWR);
>  	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_ACK_SIGNAL_SUPPORT);
> +	if (test_bit(WMI_TLV_SERVICE_BSS_COLOR_OFFLOAD,
> +		     ab->wmi_ab.svc_map)) {
> +		wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BSS_COLOR);
> +		ieee80211_hw_set(hw, DETECTS_COLOR_COLLISION);
> +	}
>  
>  	wiphy->cipher_suites = cipher_suites;
>  	wiphy->n_cipher_suites = ARRAY_SIZE(cipher_suites);
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index e76275bd6916..5075d86df36f 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -14,6 +14,7 @@
>  #include <linux/uuid.h>
>  #include <linux/time.h>
>  #include <linux/of.h>
> +#include <linux/cleanup.h>
>  #include "core.h"
>  #include "debugfs.h"
>  #include "debug.h"
> @@ -190,6 +191,8 @@ static const struct ath12k_wmi_tlv_policy ath12k_wmi_tlv_policies[] = {
>  		.min_len = sizeof(struct wmi_11d_new_cc_event) },
>  	[WMI_TAG_PER_CHAIN_RSSI_STATS] = {
>  		.min_len = sizeof(struct wmi_per_chain_rssi_stat_params) },
> +	[WMI_TAG_OBSS_COLOR_COLLISION_EVT] = {
> +		.min_len = sizeof(struct wmi_obss_color_collision_event) },
>  };
>  
>  __le32 ath12k_wmi_tlv_hdr(u32 cmd, u32 len)
> @@ -3850,6 +3853,58 @@ int ath12k_wmi_fils_discovery(struct ath12k *ar, u32 vdev_id, u32 interval,
>  	return ret;
>  }
>  
> +static void
> +ath12k_wmi_obss_color_collision_event(struct ath12k_base *ab, struct sk_buff *skb)
> +{
> +	const struct wmi_obss_color_collision_event *ev;
> +	struct ath12k_link_vif *arvif;
> +	u32 vdev_id, evt_type;
> +	u64 bitmap;
> +
> +	const void **tb __free(kfree) = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	if (IS_ERR(tb)) {
> +		ath12k_warn(ab, "failed to parse OBSS color collision tlv %ld\n",
> +			    PTR_ERR(tb));
> +		return;
> +	}
> +
> +	ev = tb[WMI_TAG_OBSS_COLOR_COLLISION_EVT];
> +	if (!ev) {
> +		ath12k_warn(ab, "failed to fetch OBSS color collision event\n");
> +		return;
> +	}
> +
> +	vdev_id = le32_to_cpu(ev->vdev_id);
> +	evt_type = le32_to_cpu(ev->evt_type);
> +	bitmap = le64_to_cpu(ev->obss_color_bitmap);
> +
> +	guard(rcu)();
> +
> +	arvif = ath12k_mac_get_arvif_by_vdev_id(ab, vdev_id);
> +	if (!arvif) {
> +		ath12k_warn(ab, "no arvif found for vdev %u in OBSS color collision event\n",
> +			    vdev_id);
> +		return;
> +	}
> +
> +	switch (evt_type) {
> +	case WMI_BSS_COLOR_COLLISION_DETECTION:
> +		ieee80211_obss_color_collision_notify(arvif->ahvif->vif,
> +						      bitmap,
> +						      arvif->link_id);
> +		ath12k_dbg(ab, ATH12K_DBG_WMI,
> +			   "obss color collision detected vdev %u event %d bitmap %016llx\n",
> +			   vdev_id, evt_type, bitmap);
> +		break;
> +	case WMI_BSS_COLOR_COLLISION_DISABLE:
> +	case WMI_BSS_COLOR_FREE_SLOT_TIMER_EXPIRY:
> +	case WMI_BSS_COLOR_FREE_SLOT_AVAILABLE:
> +		break;
> +	default:
> +		ath12k_warn(ab, "unknown OBSS color collision event type %d\n", evt_type);
> +	}
> +}
> +
>  static void
>  ath12k_fill_band_to_mac_param(struct ath12k_base  *soc,
>  			      struct ath12k_wmi_pdev_band_arg *arg)
> @@ -7014,12 +7069,26 @@ static void ath12k_vdev_start_resp_event(struct ath12k_base *ab, struct sk_buff
>  
>  static void ath12k_bcn_tx_status_event(struct ath12k_base *ab, struct sk_buff *skb)
>  {
> +	struct ath12k_link_vif *arvif;
> +	struct ath12k *ar;
>  	u32 vdev_id, tx_status;
>  
>  	if (ath12k_pull_bcn_tx_status_ev(ab, skb, &vdev_id, &tx_status) != 0) {
>  		ath12k_warn(ab, "failed to extract bcn tx status");
>  		return;
>  	}
> +
> +	guard(rcu)();
> +
> +	arvif = ath12k_mac_get_arvif_by_vdev_id(ab, vdev_id);
> +	if (!arvif) {
> +		ath12k_warn(ab, "invalid vdev %u in bcn tx status\n",
> +			    vdev_id);
> +		return;
> +	}
> +
> +	ar = arvif->ar;
> +	wiphy_work_queue(ath12k_ar_to_hw(ar)->wiphy, &arvif->bcn_tx_work);
>  }
>  
>  static void ath12k_vdev_stopped_event(struct ath12k_base *ab, struct sk_buff *skb)
> @@ -9877,6 +9946,9 @@ static void ath12k_wmi_op_rx(struct ath12k_base *ab, struct sk_buff *skb)
>  	case WMI_PDEV_RSSI_DBM_CONVERSION_PARAMS_INFO_EVENTID:
>  		ath12k_wmi_rssi_dbm_conversion_params_info_event(ab, skb);
>  		break;
> +	case WMI_OBSS_COLOR_COLLISION_DETECTION_EVENTID:
> +		ath12k_wmi_obss_color_collision_event(ab, skb);
> +		break;
>  	/* add Unsupported events (rare) here */
>  	case WMI_TBTTOFFSET_EXT_UPDATE_EVENTID:
>  	case WMI_PEER_OPER_MODE_CHANGE_EVENTID:
> @@ -9887,7 +9959,6 @@ static void ath12k_wmi_op_rx(struct ath12k_base *ab, struct sk_buff *skb)
>  	/* add Unsupported events (frequent) here */
>  	case WMI_PDEV_GET_HALPHY_CAL_STATUS_EVENTID:
>  	case WMI_MGMT_RX_FW_CONSUMED_EVENTID:
> -	case WMI_OBSS_COLOR_COLLISION_DETECTION_EVENTID:
>  		/* debug might flood hence silently ignore (no-op) */
>  		break;
>  	case WMI_PDEV_UTF_EVENTID:
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
> index 64bd968989c8..911ef9d52817 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.h
> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
> @@ -4928,6 +4928,24 @@ struct wmi_obss_spatial_reuse_params_cmd {
>  #define ATH12K_BSS_COLOR_STA_PERIODS				10000
>  #define ATH12K_BSS_COLOR_AP_PERIODS				5000
>  
> +/**
> + * enum wmi_bss_color_collision - Event types for BSS color collision handling
> + * @WMI_BSS_COLOR_COLLISION_DISABLE: Indicates that BSS color collision detection
> + *                                   is disabled.
> + * @WMI_BSS_COLOR_COLLISION_DETECTION: Event triggered when a BSS color collision
> + *                                     is detected.
> + * @WMI_BSS_COLOR_FREE_SLOT_TIMER_EXPIRY: Event indicating that the timer for waiting
> + *                                        on a free BSS color slot has expired.
> + * @WMI_BSS_COLOR_FREE_SLOT_AVAILABLE: Event indicating that a free BSS color slot
> + *                                     has become available.
> + */
> +enum wmi_bss_color_collision {
> +	WMI_BSS_COLOR_COLLISION_DISABLE = 0,
> +	WMI_BSS_COLOR_COLLISION_DETECTION,
> +	WMI_BSS_COLOR_FREE_SLOT_TIMER_EXPIRY,
> +	WMI_BSS_COLOR_FREE_SLOT_AVAILABLE,
> +};
> +
>  struct wmi_obss_color_collision_cfg_params_cmd {
>  	__le32 tlv_header;
>  	__le32 vdev_id;
> @@ -4945,6 +4963,12 @@ struct wmi_bss_color_change_enable_params_cmd {
>  	__le32 enable;
>  } __packed;
>  
> +struct wmi_obss_color_collision_event {
> +	__le32 vdev_id;
> +	__le32 evt_type;
> +	__le64 obss_color_bitmap;
> +} __packed;
> +
>  #define ATH12K_IPV4_TH_SEED_SIZE 5
>  #define ATH12K_IPV6_TH_SEED_SIZE 11
>  
> 
> base-commit: d5ce93f136fbee2b7afbe221f34ca881036f8de3


