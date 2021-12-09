Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8410346EA6F
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 15:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhLIPB1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 10:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239056AbhLIPB0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 10:01:26 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9E4C061746
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 06:57:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3CEA2CE263C
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 14:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF0CC004DD;
        Thu,  9 Dec 2021 14:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639061869;
        bh=BVZ94vOOKF2+D+qOMzxpayOxuIQkS0uZBmwk3JHtwLs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=vGyo+o0ZDsxEtYVvJ6e+KTRqAcF73L72MF/Q+pryABXZ0XE4/j+aLvx/V68z32Vy4
         +QRYmZSE++CAoW1KSSR3NXEW2zSmoX/pbX1n0rwxnXz1qjJrEm7sogA9ov2vNe044y
         Eup4ZTIBKiMPQ8GtlEiJJPBJuC6Q0C21x4y3EMxECAKMvWnqtKaKHj3xWc8BuMK0zv
         VbPkaW9fCRKnbXlMVdpd4r6Hip5DajWEow4nd+5HqqWl9CSHxjHebxHvrIY+qLUZOZ
         EMEq4T8TIVy0wcaTmEzrRwC5mMXz/3yLYBHrEHFS6qrHHIC5rBXRODk86c1hGTOf68
         oc586/0WwHmdQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Carl Huang <cjhuang@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 2/6] ath11k: Add WoW net-detect functionality
References: <20211011193750.4891-1-cjhuang@codeaurora.org>
        <20211011193750.4891-3-cjhuang@codeaurora.org>
Date:   Thu, 09 Dec 2021 16:57:46 +0200
In-Reply-To: <20211011193750.4891-3-cjhuang@codeaurora.org> (Carl Huang's
        message of "Mon, 11 Oct 2021 15:37:46 -0400")
Message-ID: <878rwt25cl.fsf@codeaurora.org>
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

> --- a/drivers/net/wireless/ath/ath11k/wmi.h
> +++ b/drivers/net/wireless/ath/ath11k/wmi.h
> @@ -5626,6 +5626,173 @@ struct wmi_wow_del_pattern_cmd {
>  	u32 pattern_type;
>  } __packed;
>  
> +#define WMI_PNO_MAX_SCHED_SCAN_PLANS      2
> +#define WMI_PNO_MAX_SCHED_SCAN_PLAN_INT   7200
> +#define WMI_PNO_MAX_SCHED_SCAN_PLAN_ITRNS 100
> +#define WMI_PNO_MAX_NETW_CHANNELS         26
> +#define WMI_PNO_MAX_NETW_CHANNELS_EX      60
> +#define WMI_PNO_MAX_SUPP_NETWORKS         WLAN_SCAN_PARAMS_MAX_SSID
> +#define WMI_PNO_MAX_IE_LENGTH             WLAN_SCAN_PARAMS_MAX_IE_LEN
> +
> +/*size based of dot11 declaration without extra IEs as we will not carry those for PNO*/

The comment style is:

/* foo bar */

That is add space after and before asterisk.

> +
> +		memcpy(pno->a_networks[i].ssid.ssid,
> +		       nd_config->match_sets[i].ssid.ssid,
> +		       nd_config->match_sets[i].ssid.ssid_len);
> +		pno->a_networks[i].authentication = 0;
> +		pno->a_networks[i].encryption     = 0;
> +		pno->a_networks[i].bcast_nw_type  = 0;
> +
> +		/*Copying list of valid channel into request */

Same here.

> @@ -433,8 +592,14 @@ int ath11k_wow_op_resume(struct ieee80211_hw *hw)
>  	ath11k_hif_irq_enable(ar->ab);
>  
>  	ret = ath11k_wow_wakeup(ar->ab);
> -	if (ret)
> +	if (ret) {
>  		ath11k_warn(ar->ab, "failed to wakeup from wow: %d\n", ret);
> +		goto exit;
> +	}
> +
> +	ret = ath11k_wow_nlo_cleanup(ar);
> +	if (ret)
> +		ath11k_warn(ar->ab, "failed to cleanup nlo: %d\n", ret);
>  
>  exit:
>  	if (ret) {

For consistency please add goto exit also for ath11k_wow_nlo_cleanup().

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
