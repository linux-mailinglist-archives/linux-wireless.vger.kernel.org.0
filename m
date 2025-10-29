Return-Path: <linux-wireless+bounces-28351-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2F5C185B0
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 06:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06EF1C646A9
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 05:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1D22E8B61;
	Wed, 29 Oct 2025 05:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LoAUlbno";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iZsqEXtT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54BE1EEA49
	for <linux-wireless@vger.kernel.org>; Wed, 29 Oct 2025 05:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761717030; cv=none; b=JqsagXW9Tu/06k8fVL6CXekANbsxbJIj6gl0UGJf4glyXc2yVImCRKPFbNiAAuSrpGrf45GDUtef2n2yKntb20G/DqaCxg+6P9g31n6TWYdgcA0cpZyBFCjO/pS42bsEOgw2+uVHewPPyDWOd9xnJ+4n/71WBscqw7Zgg/GyqVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761717030; c=relaxed/simple;
	bh=XYZA6dr1okn2VPnrrxRm+D/fdgcyYPasXfIVwZAT9Og=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GBZl0C4ILs1eHJCaMzduxUe6nc49TqOOb9vytoaGXio4Hkk26t7UOeVlj5Y3oIUDI9szbQp6+wLFXU4FPkvnD2Fl9p78cMMmkdHrBzb/iA2uqhw3b7QfwX+g7AKUTR1uwlLnBF71la5Y+R0p6jUUyrXd0OxvJBsrBXRjanwGxSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LoAUlbno; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iZsqEXtT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4usSS3764268
	for <linux-wireless@vger.kernel.org>; Wed, 29 Oct 2025 05:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WmAbIa2HLXGYbY6ZAbrAI3G+RXNbdEwalIvBalCKji4=; b=LoAUlbno80vuob69
	4XmkeXz5/TSlanqqv8vvBmc6XesLnrOD2VotMcYOzHhYp5Q2eba3ssaoMZ034cBz
	5vtdZ6mdB2a+9QLuERnqChFlaP+Z8ZjOB4YxJug7yYPPPBl6mXNtiAguzQ1/lC3i
	uk8suQ8tHLMCCJECHt28zYFhWTGYpHHWWBhrcCvpujnQ9q88a6RLzrfLsYxmwlLb
	HSybs3Idlak16TVxaXEMeywc9lT77IKFL9lKnLdDZIB09MR/cD6ZnA+1XN/B45zD
	zfAYCckvMuil/Bjus0ZCAa3FvA+3Tsnd8Zd/zQ1+M8OE8+1NayAOIPaZPjfvBEE7
	TzkvFQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a11aue-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Oct 2025 05:50:27 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29085106b99so65599015ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 28 Oct 2025 22:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761717027; x=1762321827; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WmAbIa2HLXGYbY6ZAbrAI3G+RXNbdEwalIvBalCKji4=;
        b=iZsqEXtTJR82EKBlF+iDLcWBPzwjFWlKw1gPwbPXY/BE0DTaXIfGPBXnCcCg4vfeKN
         hlpjnlKZOxX20yR9L6upiVK90EDlOXmGnahnEtmpQxICBgjeZLFw5fht+ZM4xFoEN9C5
         gUjm5i+7XWsX+6IkDDgxjehfrBMfHxjfvOejHpf9kKZHI3CtTlnMTHYJ6zCBqKd67zUb
         M1VtZHF76iQT+oEseu1zyBKEDigXqml34nLOWdoEdt1cuDeQlSRj9GuEpT89rywUkyad
         CSEbma8Ez8urmY4sEPKFsffcmIAgBbx6wTogBL2OHFa63Cjs/AizV7z1bqR0w7Ufq2aO
         XErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761717027; x=1762321827;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WmAbIa2HLXGYbY6ZAbrAI3G+RXNbdEwalIvBalCKji4=;
        b=emcVNG9g5EuglPmvTE4SYaoSJOoAWoV8EoPLiPxpnDcCBYdXbwIR7sCohNGhLQT4Jt
         c7I2jbpVH5Odib4YYXS2evEGA/7xPzTauzUw/UowL8whN8DY8lOFcLo4ZDjX2s14jpnw
         rdaxr6iN0zk0vh9GhSX+/xIySyg/w/xbEzNBI0GjDCTg1BT5DQOkkFG2bQh7TVQRxiVG
         xMdnh88I+J/2hmDsIkmi1Fy6t+2ok3NHzZ1VuNXpHQIJGuVcYw1dOavbD2xVtMKe+qXs
         zyoGC0C5wC3wzHmo/ghCWmfWqU7zg0ffynO7alMeZexEUkiLBxBqK9hst4us/P+eDHXj
         egWg==
X-Forwarded-Encrypted: i=1; AJvYcCVDPyRnNJ+cfU/CCyo9WD2VL1pbEuO6/38ajhcl/sjM2MFaAco7Dkerc3Rug5L/9r2OrIRS+AHteCMlw1NsyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgvJb+RTu4pjZVqROf4u721jx5L1SGLtZNF/bU6BqDejXrKsBD
	J53nosvRt9qUcQx8hQ1+Es9mdVamceowtXKOUuUKlFc/D9yn7lvM2zzlDXgsr3kThim8dBIfhCb
	DqrdR6QjdCFy49qZ/X/fcrHJos24tAtWuDf4Qn4XWvs0xI/qrqyCMevDIQx2c+lN5PYDcjQ==
X-Gm-Gg: ASbGncvm4IK2b4XuebLj0Hwm+FXIQj0cE+AjSLbjZ8APg5uavbMFStPTwfJQhKAa6vX
	PjjQ9sHJ0hI/iDaRHETFMOGfmUczafNGnh64L9nQ8uxoFEkSDR9Zt1Yp+YLKBpo5lA6e5Rz6Z/V
	fFFZvqFstwWdiKt2esiXmcjgT6uJhOUeVky0qkSsLm8m7zc06Y4oJMfZBr0AhLLQRrnaZRON6xY
	vKb1umnXCF+9evOzplj/LS3tnKnHoS8dm5MJh2JMV0y8b9L9LrRt1VdcmmmlxrAuamTR6eXno9W
	cNOagDaVflLb6lvMmziMEjVngwc/hhOZ/ZXpWKk13g/yYc/pzxS/cZT6zSn/HSHMQeeRuhzTqoz
	kX//Pp8KnVkPEgS+YicyX8YTG0Y7b7+HFMUc7Rf6zeU0+5kxGqJ+D/ixj4pBF
X-Received: by 2002:a17:902:e5ce:b0:290:c3ad:8432 with SMTP id d9443c01a7336-294deef9a95mr22435885ad.46.1761717026488;
        Tue, 28 Oct 2025 22:50:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3oGqY6JtnY6s9TE+mNpoQ7oW8tW3Vrva1KS/4zSSUMofam04Zi+J5i3WgpjvLhwaCJSaxcA==
X-Received: by 2002:a17:902:e5ce:b0:290:c3ad:8432 with SMTP id d9443c01a7336-294deef9a95mr22435595ad.46.1761717026005;
        Tue, 28 Oct 2025 22:50:26 -0700 (PDT)
Received: from [10.133.33.233] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0c414sm137576335ad.44.2025.10.28.22.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 22:50:25 -0700 (PDT)
Message-ID: <7d389aa2-5e5d-4b0c-8603-60bbcbce7015@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 13:50:22 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current] Revert "wifi: ath12k: Fix missing station
 power save configuration"
To: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>, jjohnson@kernel.org
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ross Brown <true.robot.ross@gmail.com>
References: <20251028060744.897198-1-miaoqing.pan@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251028060744.897198-1-miaoqing.pan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: mMujMzADuq0XeAwX8lY9VoCSzoxG1u9b
X-Proofpoint-ORIG-GUID: mMujMzADuq0XeAwX8lY9VoCSzoxG1u9b
X-Authority-Analysis: v=2.4 cv=A5dh/qWG c=1 sm=1 tr=0 ts=6901ab23 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=dJ2fJ0zB95bh057hNQsA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA0MSBTYWx0ZWRfX6k4Hnj9HXko8
 qGBUjRy3AeU3hDYQ2upPU4ova27fHHmYR4dE2UTYcooajE8oW0muIxbiRSTqPQn19Vyisguodcc
 eQR1rUZCiS9am+i13oePApueP4GlH2I2eAULwjdD2ifnaQa/+dwPv2vpuP8w1Fs9nMuhP1B2LDE
 2XZZbqB/pojqEO4E38lpQkewcGWBqz5PCaNKPQFtcKf0zsgcN0QRMkNa4X0ZPnTHjKTVW1UfvwZ
 P3vcmCzCx8Mj6CQR8aL+sI+6kyCEhC+4gklYczHbo8N6ST39bPY89ZbIohT6HryXbf8FHmjdnuR
 seSW5zlQEPhRBXj26KBn3SWnJXhr6eD06BbCCmSIgq9RSsZV7P7DEei7luWu4D6EzvUnf1CSoK9
 BUleSXKCtIyKf/LptmuwGsvjrpk0UQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290041



On 10/28/2025 2:07 PM, Miaoqing Pan wrote:
> This reverts commit 4b66d18918f8e4d85e51974a9e3ce9abad5c7c3d.
> 
> In [1], Ross Brown reports poor performance of WCN7850 after enabling
> power save. Temporarily revert the fix; it will be re-enabled once
> the issue is resolved.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.IOE_HMT.1.1-00011-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
> 
> Fixes: 4b66d18918f8 ("wifi: ath12k: Fix missing station power save configuration")
> Reported-by: Ross Brown <true.robot.ross@gmail.com>
> Closes: https://lore.kernel.org/all/CAMn66qZENLhDOcVJuwUZ3ir89PVtVnQRq9DkV5xjJn1p6BKB9w@mail.gmail.com/ # [1]
> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 122 ++++++++++++--------------
>  1 file changed, 55 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index eacab798630a..db351c922018 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -4064,68 +4064,12 @@ static int ath12k_mac_fils_discovery(struct ath12k_link_vif *arvif,
>  	return ret;
>  }
>  
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
> -
> -	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
> -
> -	if (vif->type != NL80211_IFTYPE_STATION)
> -		return;
> -
> -	enable_ps = arvif->ahvif->ps;
> -	if (enable_ps) {
> -		psmode = WMI_STA_PS_MODE_ENABLED;
> -		param = WMI_STA_PS_PARAM_INACTIVITY_TIME;
> -
> -		timeout = conf->dynamic_ps_timeout;
> -		if (timeout == 0) {
> -			info = ath12k_mac_get_link_bss_conf(arvif);
> -			if (!info) {
> -				ath12k_warn(ar->ab, "unable to access bss link conf in setup ps for vif %pM link %u\n",
> -					    vif->addr, arvif->link_id);
> -				return;
> -			}
> -
> -			/* firmware doesn't like 0 */
> -			timeout = ieee80211_tu_to_usec(info->beacon_int) / 1000;
> -		}
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
> -	}
> -
> -	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac vdev %d psmode %s\n",
> -		   arvif->vdev_id, psmode ? "enable" : "disable");
> -
> -	ret = ath12k_wmi_pdev_set_ps_mode(ar, arvif->vdev_id, psmode);
> -	if (ret)
> -		ath12k_warn(ar->ab, "failed to set sta power save mode %d for vdev %d: %d\n",
> -			    psmode, arvif->vdev_id, ret);
> -}
> -
>  static void ath12k_mac_op_vif_cfg_changed(struct ieee80211_hw *hw,
>  					  struct ieee80211_vif *vif,
>  					  u64 changed)
>  {
>  	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
>  	unsigned long links = ahvif->links_map;
> -	struct ieee80211_vif_cfg *vif_cfg;
>  	struct ieee80211_bss_conf *info;
>  	struct ath12k_link_vif *arvif;
>  	struct ieee80211_sta *sta;
> @@ -4189,24 +4133,61 @@ static void ath12k_mac_op_vif_cfg_changed(struct ieee80211_hw *hw,
>  			}
>  		}
>  	}
> +}
>  
> -	if (changed & BSS_CHANGED_PS) {
> -		links = ahvif->links_map;
> -		vif_cfg = &vif->cfg;
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
>  
> -		for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
> -			arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
> -			if (!arvif || !arvif->ar)
> -				continue;
> +	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
>  
> -			ar = arvif->ar;
> +	if (vif->type != NL80211_IFTYPE_STATION)
> +		return;
> +
> +	enable_ps = arvif->ahvif->ps;
> +	if (enable_ps) {
> +		psmode = WMI_STA_PS_MODE_ENABLED;
> +		param = WMI_STA_PS_PARAM_INACTIVITY_TIME;
>  
> -			if (ar->ab->hw_params->supports_sta_ps) {
> -				ahvif->ps = vif_cfg->ps;
> -				ath12k_mac_vif_setup_ps(arvif);
> +		timeout = conf->dynamic_ps_timeout;
> +		if (timeout == 0) {
> +			info = ath12k_mac_get_link_bss_conf(arvif);
> +			if (!info) {
> +				ath12k_warn(ar->ab, "unable to access bss link conf in setup ps for vif %pM link %u\n",
> +					    vif->addr, arvif->link_id);
> +				return;
>  			}
> +
> +			/* firmware doesn't like 0 */
> +			timeout = ieee80211_tu_to_usec(info->beacon_int) / 1000;
>  		}
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
>  	}
> +
> +	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac vdev %d psmode %s\n",
> +		   arvif->vdev_id, psmode ? "enable" : "disable");
> +
> +	ret = ath12k_wmi_pdev_set_ps_mode(ar, arvif->vdev_id, psmode);
> +	if (ret)
> +		ath12k_warn(ar->ab, "failed to set sta power save mode %d for vdev %d: %d\n",
> +			    psmode, arvif->vdev_id, ret);
>  }
>  
>  static bool ath12k_mac_supports_tpc(struct ath12k *ar, struct ath12k_vif *ahvif,
> @@ -4228,6 +4209,7 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
>  {
>  	struct ath12k_vif *ahvif = arvif->ahvif;
>  	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(ahvif);
> +	struct ieee80211_vif_cfg *vif_cfg = &vif->cfg;
>  	struct cfg80211_chan_def def;
>  	u32 param_id, param_value;
>  	enum nl80211_band band;
> @@ -4514,6 +4496,12 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
>  	}
>  
>  	ath12k_mac_fils_discovery(arvif, info);
> +
> +	if (changed & BSS_CHANGED_PS &&
> +	    ar->ab->hw_params->supports_sta_ps) {
> +		ahvif->ps = vif_cfg->ps;
> +		ath12k_mac_vif_setup_ps(arvif);
> +	}
>  }
>  
>  static struct ath12k_vif_cache *ath12k_ahvif_get_link_cache(struct ath12k_vif *ahvif,
> 
> base-commit: 2469bb6a6af944755a7d7daf66be90f3b8decbf9

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


