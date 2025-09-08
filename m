Return-Path: <linux-wireless+bounces-27078-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5163BB48863
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 11:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CF8B3AA2B9
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 09:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6451A2F1FD7;
	Mon,  8 Sep 2025 09:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Zx7tIAq3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962A52EB5BF;
	Mon,  8 Sep 2025 09:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757323679; cv=none; b=m+6Nk0bDLuQw1+EhWb6ozQnWsLFJnsMAgtpzuHgftK6n4Z54fCL/ieIVcj+Nw2RDZG/PPM7FNWwismoC9YeL2hTyXrkmRC042qsqfePx7bWjzG01PU12a3rsef1/E6n79UVLwxooT4fN5jII4gPzM57taCe8GQYuDokFBCVvVFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757323679; c=relaxed/simple;
	bh=mVe3Sl1rP9VgFF2GZRiqka32lkis0qkl9gRYgeDe8Po=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CP6ngPSUpC1PY6+rOpT4/+b9+1T0rzmepRk46pEyT+bl/XnwXLQbwPhGxlBwR8IUKm5gjifGHs0fDhHB1QKG8j3KVp+kgHObMDlCRtQ8uEAzLZhIqOu/Sx/iaIGK4PLwszWj2mGWdXLFBfVMC3TsEo+OZwHRUlz01P5rYRjVBeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Zx7tIAq3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58890DlZ026682;
	Mon, 8 Sep 2025 09:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	blPqGsDWqOkQ7scMUEI63AykP0Duimlw27M5hZ7Nj8c=; b=Zx7tIAq3tk6bR3kV
	TQV2JBcZM2rvihO+F8dyklOQoRPpWwNUVfM27or7Lv/CS+Xi+XaBHwzgLe0chHaF
	1qAVHRA+uJeppsRBElgBaqIQaB+mrkO6Pz2QgKSrCnYc3+jWeV5dJAtTUwfNdZvS
	FPOiHLEZKzevPKaxMOWlRvdnXoUhfWBs84DGXzndcDOhl8a7YGH2SvkdGXy7sydN
	Ol89/oGbQPgkfo8EdmqNOdWqooXO4rzPqwbosx+OpY8XaYuNekc2DK0DOlDBc3PB
	DmJx4regdrzF2srKnXLKnVsTrg1tLI/xvki9lGT8sXOVJll3fOKIAsZyjnaUjDV+
	d+ixWA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490bws46p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 09:27:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5889Rql6006707
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Sep 2025 09:27:52 GMT
Received: from [10.133.33.112] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Mon, 8 Sep
 2025 02:27:50 -0700
Message-ID: <a97626c6-fcfb-4a57-9ba9-68b4f2cc67c4@quicinc.com>
Date: Mon, 8 Sep 2025 17:26:19 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current] wifi: ath12k: Fix missing station power save
 configuration
To: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>, <jjohnson@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250908015025.1301398-1-miaoqing.pan@oss.qualcomm.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20250908015025.1301398-1-miaoqing.pan@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YcNMYz9Ox-AgdiWt5u9xfEP6SanSLUOZ
X-Proofpoint-GUID: YcNMYz9Ox-AgdiWt5u9xfEP6SanSLUOZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfX2YEzMLeyO4vw
 BzGzwyPHXhNV5jQ9rzEsRzaSrJOgu5xz/OtaeXJ3XVb/IFHUaWOKoGYju3oDWjnvwwjjnAjmzbd
 DL+UhjKvKzJ4IdSZeGY2Xbz35T5ZReem/K/mYD3hp+sAPPWdtytTGBt6lGNuAO18dzTkxDYZMRR
 vHRFU09qcdxmEPgOKXUW1oWdrMi8JFSNqKSwTGz8ejuqx8XAgPDbCfhMGcGV6oFcG8qNpKo2dvT
 3+fFpYvRcx6nrm6n9VOJxa0O3UkLT1iJ1Uym6M+L9zcDUa5AwlUJkvCMj+oGOt/LhV2ZCwPNqwq
 c4QsHXcTT0y/YvhrczUI1G9Mg2p45Qvy0ZBgpfH0yZ/z+WApAG6IrKvLXlEV1uaINnk3Ba6LGzI
 ma1E3lJh
X-Authority-Analysis: v=2.4 cv=G4kcE8k5 c=1 sm=1 tr=0 ts=68bea199 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8
 a=EecTVN4gN2f6d5QKcsUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_03,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1011
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018



On 9/8/2025 9:50 AM, Miaoqing Pan wrote:
> Commit afbab6e4e88d ("wifi: ath12k: modify ath12k_mac_op_bss_info_changed()
> for MLO") replaced the bss_info_changed() callback with vif_cfg_changed()
> and link_info_changed() to support Multi-Link Operation (MLO). As a result,
> the station power save configuration is no longer correctly applied in
> ath12k_mac_bss_info_changed().
> 
> Move the handling of 'BSS_CHANGED_PS' into ath12k_mac_op_vif_cfg_changed()
> to align with the updated callback structure introduced for MLO, ensuring
> proper power-save behavior for station interfaces.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.IOE_HMT.1.1-00011-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
> 
> Fixes: afbab6e4e88d ("wifi: ath12k: modify ath12k_mac_op_bss_info_changed() for MLO")
> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 122 ++++++++++++++------------
>  1 file changed, 67 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index bd1ec3b2c084..3a3965b79942 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -4078,12 +4078,68 @@ static int ath12k_mac_fils_discovery(struct ath12k_link_vif *arvif,
>  	return ret;
>  }
>  
> +static void ath12k_mac_vif_setup_ps(struct ath12k_link_vif *arvif)
> +{
> +	struct ath12k *ar = arvif->ar;
> +	struct ieee80211_vif *vif = arvif->ahvif->vif;
> +	struct ieee80211_conf *conf = &ath12k_ar_to_hw(ar)->conf;
> +	enum wmi_sta_powersave_param param;
> +	struct ieee80211_bss_conf *info;
> +	enum wmi_sta_ps_mode psmode;
> +	int ret;
> +	int timeout;
> +	bool enable_ps;
> +
> +	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
> +
> +	if (vif->type != NL80211_IFTYPE_STATION)
> +		return;
> +
> +	enable_ps = arvif->ahvif->ps;
> +	if (enable_ps) {
> +		psmode = WMI_STA_PS_MODE_ENABLED;
> +		param = WMI_STA_PS_PARAM_INACTIVITY_TIME;
> +
> +		timeout = conf->dynamic_ps_timeout;
> +		if (timeout == 0) {
> +			info = ath12k_mac_get_link_bss_conf(arvif);
> +			if (!info) {
> +				ath12k_warn(ar->ab, "unable to access bss link conf in setup ps for vif %pM link %u\n",
> +					    vif->addr, arvif->link_id);
> +				return;
> +			}
> +
> +			/* firmware doesn't like 0 */
> +			timeout = ieee80211_tu_to_usec(info->beacon_int) / 1000;
> +		}
> +
> +		ret = ath12k_wmi_set_sta_ps_param(ar, arvif->vdev_id, param,
> +						  timeout);
> +		if (ret) {
> +			ath12k_warn(ar->ab, "failed to set inactivity time for vdev %d: %i\n",
> +				    arvif->vdev_id, ret);
> +			return;
> +		}
> +	} else {
> +		psmode = WMI_STA_PS_MODE_DISABLED;
> +	}
> +
> +	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac vdev %d psmode %s\n",
> +		   arvif->vdev_id, psmode ? "enable" : "disable");
> +
> +	ret = ath12k_wmi_pdev_set_ps_mode(ar, arvif->vdev_id, psmode);
> +	if (ret)
> +		ath12k_warn(ar->ab, "failed to set sta power save mode %d for vdev %d: %d\n",
> +			    psmode, arvif->vdev_id, ret);
> +}
> +
>  static void ath12k_mac_op_vif_cfg_changed(struct ieee80211_hw *hw,
>  					  struct ieee80211_vif *vif,
>  					  u64 changed)
>  {
>  	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
>  	unsigned long links = ahvif->links_map;
> +	struct ieee80211_vif_cfg *vif_cfg;
>  	struct ieee80211_bss_conf *info;
>  	struct ath12k_link_vif *arvif;
>  	struct ieee80211_sta *sta;
> @@ -4147,61 +4203,24 @@ static void ath12k_mac_op_vif_cfg_changed(struct ieee80211_hw *hw,
>  			}
>  		}
>  	}
> -}
> -
> -static void ath12k_mac_vif_setup_ps(struct ath12k_link_vif *arvif)
> -{
> -	struct ath12k *ar = arvif->ar;
> -	struct ieee80211_vif *vif = arvif->ahvif->vif;
> -	struct ieee80211_conf *conf = &ath12k_ar_to_hw(ar)->conf;
> -	enum wmi_sta_powersave_param param;
> -	struct ieee80211_bss_conf *info;
> -	enum wmi_sta_ps_mode psmode;
> -	int ret;
> -	int timeout;
> -	bool enable_ps;
>  
> -	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
> +	if (changed & BSS_CHANGED_PS) {
> +		links = ahvif->links_map;
> +		vif_cfg = &vif->cfg;
>  
> -	if (vif->type != NL80211_IFTYPE_STATION)
> -		return;
> +		for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
> +			arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
> +			if (!arvif || !arvif->ar)
> +				continue;
>  
> -	enable_ps = arvif->ahvif->ps;
> -	if (enable_ps) {
> -		psmode = WMI_STA_PS_MODE_ENABLED;
> -		param = WMI_STA_PS_PARAM_INACTIVITY_TIME;
> +			ar = arvif->ar;
>  
> -		timeout = conf->dynamic_ps_timeout;
> -		if (timeout == 0) {
> -			info = ath12k_mac_get_link_bss_conf(arvif);
> -			if (!info) {
> -				ath12k_warn(ar->ab, "unable to access bss link conf in setup ps for vif %pM link %u\n",
> -					    vif->addr, arvif->link_id);
> -				return;
> +			if (ar->ab->hw_params->supports_sta_ps) {
> +				ahvif->ps = vif_cfg->ps;
> +				ath12k_mac_vif_setup_ps(arvif);
>  			}
> -
> -			/* firmware doesn't like 0 */
> -			timeout = ieee80211_tu_to_usec(info->beacon_int) / 1000;
>  		}
> -
> -		ret = ath12k_wmi_set_sta_ps_param(ar, arvif->vdev_id, param,
> -						  timeout);
> -		if (ret) {
> -			ath12k_warn(ar->ab, "failed to set inactivity time for vdev %d: %i\n",
> -				    arvif->vdev_id, ret);
> -			return;
> -		}
> -	} else {
> -		psmode = WMI_STA_PS_MODE_DISABLED;
>  	}
> -
> -	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac vdev %d psmode %s\n",
> -		   arvif->vdev_id, psmode ? "enable" : "disable");
> -
> -	ret = ath12k_wmi_pdev_set_ps_mode(ar, arvif->vdev_id, psmode);
> -	if (ret)
> -		ath12k_warn(ar->ab, "failed to set sta power save mode %d for vdev %d: %d\n",
> -			    psmode, arvif->vdev_id, ret);
>  }
>  
>  static bool ath12k_mac_supports_tpc(struct ath12k *ar, struct ath12k_vif *ahvif,
> @@ -4223,7 +4242,6 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
>  {
>  	struct ath12k_vif *ahvif = arvif->ahvif;
>  	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(ahvif);
> -	struct ieee80211_vif_cfg *vif_cfg = &vif->cfg;
>  	struct cfg80211_chan_def def;
>  	u32 param_id, param_value;
>  	enum nl80211_band band;
> @@ -4510,12 +4528,6 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
>  	}
>  
>  	ath12k_mac_fils_discovery(arvif, info);
> -
> -	if (changed & BSS_CHANGED_PS &&
> -	    ar->ab->hw_params->supports_sta_ps) {
> -		ahvif->ps = vif_cfg->ps;
> -		ath12k_mac_vif_setup_ps(arvif);
> -	}
>  }
>  
>  static struct ath12k_vif_cache *ath12k_ahvif_get_link_cache(struct ath12k_vif *ahvif,
> 
> base-commit: 27893dd6341b929f87d45fc4d65c5778179319dd

Reviewed-by:  Baochen Qiang <baochen.qiang@oss.qualcomm.com>


