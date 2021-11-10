Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E546244C6B4
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Nov 2021 19:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhKJSSy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Nov 2021 13:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbhKJSSx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Nov 2021 13:18:53 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5629AC061764
        for <linux-wireless@vger.kernel.org>; Wed, 10 Nov 2021 10:16:05 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id v15so7083352ljc.0
        for <linux-wireless@vger.kernel.org>; Wed, 10 Nov 2021 10:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=3ar1LWfIdd6/cEoTJyslhp5bKtvnQ7TEyuAorq9rP64=;
        b=XRowrNdKVYzIhj/kikCrlMnpWCz0KHZGZsRRqe6AhYqBKO3Ajb0KSHnRxQtv91Bv8v
         qV+d1sks69vdVave38bRt92zNcHnTLr3E+KjIDUr4TgC1/LAFEwQENVUYcEambc+tHdj
         RmTJAcMnP5F4VqKBM7TaYhitLMSg8NV2hEmGJP0xzu4HO0lQzFqawZ0wm0g3t3ecZSNI
         6ouvVylpd1GNOJ3l178NcnaQd756QRHlBE4l3Z2RbWptp8uMAq8qtEpfeD2uTZOQve33
         0mMG2Qo23djDXeRs6B9wuGHVH6I7iEBlUJLOFr3p0f/d6kbCUt279mW/Cptn2XLVOI2/
         YJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3ar1LWfIdd6/cEoTJyslhp5bKtvnQ7TEyuAorq9rP64=;
        b=mzuPouG7WAjE+8nsC8yQ0qed1bzOOBEiTc5Xz6KpD5aC/lU1gmmycEJ08/ROz/cxA7
         iHObUNWYTOcB/A4GyBOa+IrC2BVVv9E5B44vCpPFg2O4oyoMArcjzl6NGp6MXM7w1InV
         Fi4hGvibuC6yJ72osMqGTMUAUO0zidZok0G0TtFY0KAuQmqVrnJu+Am5V1E5Xs/pSrml
         Xih7KkT68ibMxUK3fGDOpLdbHsK8ZWiEChEWsRUH3HNjTX+ln7IWGDWrifct1nXZjXtZ
         2ke6Ct4OpwvawF52Jcv7PETrSEJIpljdzoKkAlSGabLBhhAT1SEBFJgwUFoO9hoJqAbm
         qaGQ==
X-Gm-Message-State: AOAM531m1Sh+E7DUGxv3jDsNEA5hGkh1bbZfknXe62dLnuvXKmhke80V
        lpsmrYi5KXXLg9Pwc66rGxcH7EV54gE=
X-Google-Smtp-Source: ABdhPJwl9ppm/ZHZSYkYn4VWo6P99x96/GUHqYxhSEwadDWZsb7wMGi2zpZP+lT8djAt9iTrTUO4hw==
X-Received: by 2002:a2e:8501:: with SMTP id j1mr887190lji.347.1636568163458;
        Wed, 10 Nov 2021 10:16:03 -0800 (PST)
Received: from [192.168.8.100] ([176.59.57.249])
        by smtp.gmail.com with ESMTPSA id r3sm57755lfc.114.2021.11.10.10.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 10:16:02 -0800 (PST)
Subject: Re: [PATCH v2 2/2] ath11k: enable 802.11 power save mode in station
 mode
To:     Kalle Valo <kvalo@codeaurora.org>, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
References: <20211108123826.8463-1-kvalo@codeaurora.org>
 <20211108123826.8463-2-kvalo@codeaurora.org>
From:   Mark Herbert <mark.herbert42@gmail.com>
Message-ID: <93c6544e-597e-5c2e-7747-e636a07645a3@gmail.com>
Date:   Wed, 10 Nov 2021 21:16:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211108123826.8463-2-kvalo@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Running the new patch version, looks good so far.

CPU reaches PC10, and in idle can be about 80% in PC10 which is perfect.

With the firmware 01740 which is the release firmware for linux 
everyting good until I try to reload module ath11k_pci.

With the downgraded firmware  01230 the card is crashing periodically 
but 01230 allows to do rmmod/modprobe ath11k sequence and happily 
recovers, and the PC10 state residency is also good.

The firmware hacked from Dell official Windows drivers ( fw_version 
0x10110341 fw_build_timestamp 2021-05-02 15:16 fw_build_id in dmesg) is 
somewhere in the middle. No crashes until modules reloaded, but on 
reload the chances are 50/50 if the card will come back or not. PC10 
residency is also perfect.

On 08.11.2021 15:38, Kalle Valo wrote:
> From: Carl Huang <cjhuang@codeaurora.org>
>
> To reduce power consumption enable 802.11 power save mode in station mode. This
> allows both radio and CPU to sleep more.
>
> Only enable the mode on QCA6390 and WCN6855, it's unknown how other hardware
> families support this feature.
>
> To test that power save mode is running run "iw dev wls1 set power_save off",
> check there is no NULL Data frame seen by a sniffer. And run "iw dev wls1 set power_save
> on" and check there is a NULL Data frame in sniffer.
>
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
>
> Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
> ---
>
> v2:
>
> * improve commit log
>
> * use existing ath11k_wmi_pdev_set_ps_mode()
>
> * rename protocol_ps to supports_sta_ps
>
> * cosmetic changes
>
>   drivers/net/wireless/ath/ath11k/core.c |  5 ++
>   drivers/net/wireless/ath/ath11k/core.h |  1 +
>   drivers/net/wireless/ath/ath11k/hw.h   |  1 +
>   drivers/net/wireless/ath/ath11k/mac.c  | 87 ++++++++++++++++++++++++++
>   4 files changed, 94 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
> index b5a2af3ffc3e..a6c0d5ad7f9b 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -76,6 +76,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>   		.supports_monitor = true,
>   		.supports_shadow_regs = false,
>   		.idle_ps = false,
> +		.supports_sta_ps = false,
>   		.cold_boot_calib = true,
>   		.supports_suspend = false,
>   		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
> @@ -125,6 +126,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>   		.supports_monitor = true,
>   		.supports_shadow_regs = false,
>   		.idle_ps = false,
> +		.supports_sta_ps = false,
>   		.cold_boot_calib = true,
>   		.supports_suspend = false,
>   		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
> @@ -173,6 +175,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>   		.supports_monitor = false,
>   		.supports_shadow_regs = true,
>   		.idle_ps = true,
> +		.supports_sta_ps = true,
>   		.cold_boot_calib = false,
>   		.supports_suspend = true,
>   		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
> @@ -221,6 +224,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>   		.supports_monitor = true,
>   		.supports_shadow_regs = false,
>   		.idle_ps = false,
> +		.supports_sta_ps = false,
>   		.cold_boot_calib = false,
>   		.supports_suspend = false,
>   		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9074),
> @@ -269,6 +273,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>   		.supports_monitor = false,
>   		.supports_shadow_regs = true,
>   		.idle_ps = true,
> +		.supports_sta_ps = true,
>   		.cold_boot_calib = false,
>   		.supports_suspend = true,
>   		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn6855),
> diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
> index 31d234a51c79..2f1e10b7cc17 100644
> --- a/drivers/net/wireless/ath/ath11k/core.h
> +++ b/drivers/net/wireless/ath/ath11k/core.h
> @@ -240,6 +240,7 @@ struct ath11k_vif {
>   	bool is_started;
>   	bool is_up;
>   	bool spectral_enabled;
> +	bool ps;
>   	u32 aid;
>   	u8 bssid[ETH_ALEN];
>   	struct cfg80211_bitrate_mask bitrate_mask;
> diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
> index 19223d36846e..1c298c24b617 100644
> --- a/drivers/net/wireless/ath/ath11k/hw.h
> +++ b/drivers/net/wireless/ath/ath11k/hw.h
> @@ -170,6 +170,7 @@ struct ath11k_hw_params {
>   	bool supports_monitor;
>   	bool supports_shadow_regs;
>   	bool idle_ps;
> +	bool supports_sta_ps;
>   	bool cold_boot_calib;
>   	bool supports_suspend;
>   	u32 hal_desc_sz;
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
> index f6511fc8ae8c..82fd44f34df2 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -1049,6 +1049,83 @@ static int ath11k_mac_monitor_stop(struct ath11k *ar)
>   	return 0;
>   }
>   
> +static int ath11k_mac_vif_setup_ps(struct ath11k_vif *arvif)
> +{
> +	struct ath11k *ar = arvif->ar;
> +	struct ieee80211_vif *vif = arvif->vif;
> +	struct ieee80211_conf *conf = &ar->hw->conf;
> +	enum wmi_sta_powersave_param param;
> +	enum wmi_sta_ps_mode psmode;
> +	int ret;
> +	int timeout;
> +	bool enable_ps;
> +
> +	lockdep_assert_held(&arvif->ar->conf_mutex);
> +
> +	if (arvif->vif->type != NL80211_IFTYPE_STATION)
> +		return 0;
> +
> +	enable_ps = arvif->ps;
> +
> +	if (!arvif->is_started) {
> +		/* mac80211 can update vif powersave state while disconnected.
> +		 * Firmware doesn't behave nicely and consumes more power than
> +		 * necessary if PS is disabled on a non-started vdev. Hence
> +		 * force-enable PS for non-running vdevs.
> +		 */
> +		psmode = WMI_STA_PS_MODE_ENABLED;
> +	} else if (enable_ps) {
> +		psmode = WMI_STA_PS_MODE_ENABLED;
> +		param = WMI_STA_PS_PARAM_INACTIVITY_TIME;
> +
> +		timeout = conf->dynamic_ps_timeout;
> +		if (timeout == 0) {
> +			/* firmware doesn't like 0 */
> +			timeout = ieee80211_tu_to_usec(vif->bss_conf.beacon_int) / 1000;
> +		}
> +
> +		ret = ath11k_wmi_set_sta_ps_param(ar, arvif->vdev_id, param,
> +						  timeout);
> +		if (ret) {
> +			ath11k_warn(ar->ab, "failed to set inactivity time for vdev %d: %i\n",
> +				    arvif->vdev_id, ret);
> +			return ret;
> +		}
> +	} else {
> +		psmode = WMI_STA_PS_MODE_DISABLED;
> +	}
> +
> +	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac vdev %d psmode %s\n",
> +		   arvif->vdev_id, psmode ? "enable" : "disable");
> +
> +	ret = ath11k_wmi_pdev_set_ps_mode(ar, arvif->vdev_id, psmode);
> +	if (ret) {
> +		ath11k_warn(ar->ab, "failed to set sta power save mode %d for vdev %d: %d\n",
> +			    psmode, arvif->vdev_id, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ath11k_mac_config_ps(struct ath11k *ar)
> +{
> +	struct ath11k_vif *arvif;
> +	int ret = 0;
> +
> +	lockdep_assert_held(&ar->conf_mutex);
> +
> +	list_for_each_entry(arvif, &ar->arvifs, list) {
> +		ret = ath11k_mac_vif_setup_ps(arvif);
> +		if (ret) {
> +			ath11k_warn(ar->ab, "failed to setup powersave: %d\n", ret);
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
>   static int ath11k_mac_op_config(struct ieee80211_hw *hw, u32 changed)
>   {
>   	struct ath11k *ar = hw->priv;
> @@ -2942,6 +3019,16 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
>   		ath11k_mac_txpower_recalc(ar);
>   	}
>   
> +	if (changed & BSS_CHANGED_PS &&
> +	    ar->ab->hw_params.supports_sta_ps) {
> +		arvif->ps = vif->bss_conf.ps;
> +
> +		ret = ath11k_mac_config_ps(ar);
> +		if (ret)
> +			ath11k_warn(ar->ab, "failed to setup ps on vdev %i: %d\n",
> +				    arvif->vdev_id, ret);
> +	}
> +
>   	if (changed & BSS_CHANGED_MCAST_RATE &&
>   	    !ath11k_mac_vif_chan(arvif->vif, &def)) {
>   		band = def.chan->band;
