Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8B346CFA0
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Dec 2021 10:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhLHJED (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Dec 2021 04:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhLHJEC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Dec 2021 04:04:02 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B8DC061746
        for <linux-wireless@vger.kernel.org>; Wed,  8 Dec 2021 01:00:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E952FCE2033
        for <linux-wireless@vger.kernel.org>; Wed,  8 Dec 2021 09:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F60AC00446;
        Wed,  8 Dec 2021 09:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638954027;
        bh=krJM6Mq5KiIT+RpKx7SpSZi6opk/kHp4633AN7KqKUA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=KbbOnivmkx2Cn6riN/3Iy5hogWLewzB44dI7KMH/AVBkj5ewkHpWFfg3BIOyFnBUi
         edCmHxXFGpABzrRJOw9+DpEtNzTw14fzGSg4Gnoz92IvK/4oSPiL6Jnr/iUgSrhOZs
         IgUPqRVdhjfkxHPjLZ0cHih00C1NK65vxMeYbOBsKoYO35NWJeNIyR8nh9suOX1hD/
         g/Y40nb/Les7rhMIlXcWgCxC6O1vfin7IRcy/xRa7YZrV70G3UZDBmX8zofxnKBFK2
         hknQ5x/ZrPGyeXmzmdZQmY1SJJK8bARO1yFMWzFTevew2vUJYytepQotQqYc46Bt9J
         +XRiGrgzjl4DQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] ath10k: drop beacon and probe response which leak from other channel
References: <20211208061752.16564-1-quic_wgong@quicinc.com>
Date:   Wed, 08 Dec 2021 11:00:22 +0200
In-Reply-To: <20211208061752.16564-1-quic_wgong@quicinc.com> (Wen Gong's
        message of "Wed, 8 Dec 2021 01:17:52 -0500")
Message-ID: <87pmq7fp3t.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

> When scan request on channel 1, it also receive beacon from other
> channels, and the beacon also indicate to mac80211 and wpa_supplicant,
> and then the bss info appears in radio measurement report of radio
> measurement sent from wpa_supplicant, thus lead RRM case fail.
>
> This is to drop the beacon and probe response which is not the same
> channel of scanning.
>
> Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00049
>
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> ---
> v2: rebased to ath.git ath-202112071521
>
>  drivers/net/wireless/ath/ath10k/wmi.c | 28 ++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
> index 7c1c2658cb5f..07764ee409fe 100644
> --- a/drivers/net/wireless/ath/ath10k/wmi.c
> +++ b/drivers/net/wireless/ath/ath10k/wmi.c
> @@ -2610,10 +2610,32 @@ int ath10k_wmi_event_mgmt_rx(struct ath10k *ar, struct sk_buff *skb)
>  	if (ieee80211_is_beacon(hdr->frame_control))
>  		ath10k_mac_handle_beacon(ar, skb);
>  
> +

This caused a new warning:

drivers/net/wireless/ath/ath10k/wmi.c:2613: Please don't use multiple blank lines

Fixed in the pending branch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
