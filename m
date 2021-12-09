Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177C646EA8E
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 16:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239165AbhLIPHn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 10:07:43 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54856 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239160AbhLIPHj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 10:07:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69F13B82489
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 15:04:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716EDC004DD;
        Thu,  9 Dec 2021 15:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639062244;
        bh=8xs4YTLGZ98iWqV7F/ovnNkGI8pHbnjD07YgrV2I5Ig=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Y7nwfi+WLw9TyfVMQlQNfxkmQ1nTz44aFxVPOGXtel5T545sCFFMiIIPY6K05YRI/
         NRUw6o/56PWKvkjrFJu7eUP9jGCA4PBjB69idBCP+ZnSfswckC43iwmvgNKjU8rWSg
         wx6+q2lkkHCkmz++8YruJXityKNjhxW7MG9T57yCySrUZXMFr8BJdBgQ4iH57LjPKR
         /lFhPGRtAIigYKcI6/KPtv6odKj15nPIRkC2cgGijWSS2DJwE40K3xJAY8wY2li09z
         836jElyuEu4tDMHifSuLLQEDGdzx5qH0lLpHUzDg2BZwTOCzRXs7EvhNupLzaJbN0w
         Ehk9S7kWsqz6g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Carl Huang <cjhuang@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 2/6] ath11k: Add WoW net-detect functionality
References: <20211011193750.4891-1-cjhuang@codeaurora.org>
        <20211011193750.4891-3-cjhuang@codeaurora.org>
Date:   Thu, 09 Dec 2021 17:03:59 +0200
In-Reply-To: <20211011193750.4891-3-cjhuang@codeaurora.org> (Carl Huang's
        message of "Mon, 11 Oct 2021 15:37:46 -0400")
Message-ID: <874k7h2528.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Carl Huang <cjhuang@codeaurora.org> writes:

> Implement net-detect feature by setting flag
> WIPHY_WOWLAN_NET_DETECT if firmware supports this
> feature. Driver sets the related PNO configuration
> to firmware before entering WoW and firmware then
> scans periodically and wakes up host if a specific
> SSID is found.
>
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
>
> Signed-off-by: Carl Huang <cjhuang@codeaurora.org>

[...]

> +static int ath11k_wmi_pno_check_and_convert(struct ath11k *ar, u32 vdev_id,
> +					    struct cfg80211_sched_scan_request *nd_config,
> +					    struct wmi_pno_scan_req *pno)
> +{
> +	int i, j;
> +	u8 ssid_len;
> +
> +	pno->enable = 1;
> +	pno->vdev_id = vdev_id;
> +	pno->uc_networks_count = nd_config->n_match_sets;
> +
> +	if (!pno->uc_networks_count ||
> +	    pno->uc_networks_count > WMI_PNO_MAX_SUPP_NETWORKS)
> +		return -EINVAL;
> +
> +	if (nd_config->n_channels > WMI_PNO_MAX_NETW_CHANNELS_EX)
> +		return -EINVAL;
> +
> +	/* Filling per profile params */
> +	for (i = 0; i < pno->uc_networks_count; i++) {
> +		ssid_len = nd_config->match_sets[i].ssid.ssid_len;
> +
> +		if (ssid_len == 0 || ssid_len > 32)
> +			return -EINVAL;

A define for 32 would be nice, WMI_MAC_MAX_SSID_LENGTH has a bad name
but I couldn't find anything better from wmi.h. sizeof(struct
wmi_ssid.ssid) might be other alternative.

But length from cfg80211 should be trustworthy anyway, so I'm not sure
if the check is even needed?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
