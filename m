Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13970258BDB
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Sep 2020 11:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgIAJjN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Sep 2020 05:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgIAJjM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Sep 2020 05:39:12 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB89EC061244
        for <linux-wireless@vger.kernel.org>; Tue,  1 Sep 2020 02:39:12 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id z15so260182plo.7
        for <linux-wireless@vger.kernel.org>; Tue, 01 Sep 2020 02:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2mhtQ32jWUCMlPLJkXciuz3aTxdYye+aMIZiOmanVmM=;
        b=gPZNMkBLqVrCT9qbK+6SslNpIm6fKzCx1vXUTAVTCRrFS+iDk0BQKPjMcXUjJ/7gtg
         SZJ6y2YB++2f70V+DmXngfBBsZCOSQ962JJA5qtL+yWyWmo8Fbuzgb273Z/u/aHRmeFk
         V+hlm5PEo69zHQEf4efbutOrHdZrszboYFLWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2mhtQ32jWUCMlPLJkXciuz3aTxdYye+aMIZiOmanVmM=;
        b=UMu0ARjoM3+prlpAFlPbzt2REf/nBqHoUw0WjhJid9wrHfd5wr9dqkQAphTkMptvYr
         ILgMbzVY4XDefynH6gEswZblj+zTJ3IxuvOi9CoTxFcwnHV8GIitAzoS5Nrm7tHZAFP3
         gFUTx66o47zZDNcNmtLBvmmmc6t/tmF9kZo7fPtTBZbKo4zrSJWaQ8Ua6yuRoUkOKGmv
         hpcrfPz4QEw7TyeYHGBx3sDUd4NfneG66nlXgtea8ZPbh/bPBVdgQLF6I5lRPTeLCYam
         gH032HmnrBZDYIcdw1Kho/z2XezsHIDmbuJ6UGIOk6cIb9b4f+kN4EEcdqCjL6BoqMwD
         trFA==
X-Gm-Message-State: AOAM5334DebOymL8YKQE9Z2zYA+H2NVjy/vCQa1MOK4P6vFotuMNGoMy
        1XvimcEE4ODfhcSniK7OV4VY/g==
X-Google-Smtp-Source: ABdhPJxyEz8UIe3sOi6AGjBXxjlTyL1io8uuRDgro1YSfUJje6HdwuDVC2m7EV8AWHFHmNV0miDmmQ==
X-Received: by 2002:a17:90a:1f43:: with SMTP id y3mr775346pjy.28.1598953152059;
        Tue, 01 Sep 2020 02:39:12 -0700 (PDT)
Received: from [10.230.32.194] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id r3sm1218614pfh.88.2020.09.01.02.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 02:39:11 -0700 (PDT)
Subject: Re: [PATCH 3/4] brcmfmac: support the forwarding packet
To:     Wright Feng <wright.feng@cypress.com>,
        linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com,
        Jia-Shyr Chuang <joseph.chuang@cypress.com>,
        Ting-Ying Li <tingying.li@cypress.com>
References: <20200901063237.15549-1-wright.feng@cypress.com>
 <20200901063237.15549-4-wright.feng@cypress.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <4e44b1b0-50d8-8f03-57f1-a307b759effa@broadcom.com>
Date:   Tue, 1 Sep 2020 11:39:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200901063237.15549-4-wright.feng@cypress.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/1/2020 8:32 AM, Wright Feng wrote:
> From: Jia-Shyr Chuang <joseph.chuang@cypress.com>
> 
> Support packet forwarding mechanism for some special usages on PCIE,
> and fix BE/VI priority issue when pumping iperf.

This is a bit to brief for what is being introduced here. Basically, 
your are introducing a shortcut if a packet from an associated STA is 
destined for another associated STA taking the linux network stack and 
its overhead out of the equation. Not sure if this is a desired feature 
for upstream driver as it likely is interfering with features like TSQ. 
So there should be something done to inform the network stack about this 
packet going into transmit path.

I also don't understand what is PCIe specific about this and what BE/VI 
priority issue is being fixed. Please spend more words on the commit 
message.

Some more specific comment below.

Regards,
Arend

> Signed-off-by: Jia-Shyr Chuang <joseph.chuang@cypress.com>
> Signed-off-by: Ting-Ying Li <tingying.li@cypress.com>
> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
> ---
>   .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  13 ++-
>   .../broadcom/brcm80211/brcmfmac/core.c        | 100 +++++++++++++++++-
>   .../broadcom/brcm80211/brcmfmac/core.h        |  18 +++-
>   .../broadcom/brcm80211/brcmfmac/msgbuf.c      |  31 +++++-
>   4 files changed, 157 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> index d6972420d426..8c7941f85715 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> @@ -4799,7 +4799,7 @@ brcmf_cfg80211_start_ap(struct wiphy *wiphy, struct net_device *ndev,
>   		err = -EINVAL;
>   		goto exit;
>   	}
> -
> +	ifp->isap = false;
>   	/* Interface specific setup */
>   	if (dev_role == NL80211_IFTYPE_AP) {
>   		if ((brcmf_feat_is_enabled(ifp, BRCMF_FEAT_MBSS)) && (!mbss))
> @@ -4860,7 +4860,7 @@ brcmf_cfg80211_start_ap(struct wiphy *wiphy, struct net_device *ndev,
>   				 err);
>   			goto exit;
>   		}
> -
> +		ifp->isap = true;
>   		brcmf_dbg(TRACE, "AP mode configuration complete\n");
>   	} else if (dev_role == NL80211_IFTYPE_P2P_GO) {
>   		err = brcmf_fil_iovar_int_set(ifp, "chanspec", chanspec);
> @@ -4892,6 +4892,7 @@ brcmf_cfg80211_start_ap(struct wiphy *wiphy, struct net_device *ndev,
>   			goto exit;
>   		}
>   
> +		ifp->isap = true;
>   		brcmf_dbg(TRACE, "GO mode configuration complete\n");
>   	} else {
>   		WARN_ON(1);
> @@ -6045,6 +6046,14 @@ brcmf_notify_connect_status(struct brcmf_if *ifp,
>   	}
>   
>   	if (brcmf_is_apmode(ifp->vif)) {

Given this function I don't think the new struct brcmf_if::isap flag is 
necessary.

> +		if (e->event_code == BRCMF_E_ASSOC_IND ||
> +		    e->event_code == BRCMF_E_REASSOC_IND) {
> +			brcmf_findadd_sta(ifp, e->addr);
> +		} else if ((e->event_code == BRCMF_E_DISASSOC_IND) ||
> +				(e->event_code == BRCMF_E_DEAUTH_IND) ||
> +				(e->event_code == BRCMF_E_DEAUTH)) {
> +			brcmf_del_sta(ifp, e->addr);
> +		}
>   		err = brcmf_notify_connect_status_ap(cfg, ndev, e, data);
>   	} else if (brcmf_is_linkup(ifp->vif, e)) {
>   		brcmf_dbg(CONN, "Linkup\n");
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> index 20c510dca601..3257b784e019 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> @@ -62,6 +62,14 @@ struct wlc_d11rxhdr {
>   	s8 rxpwr[4];
>   } __packed;
>   
> +#define BRCMF_IF_STA_LIST_LOCK_INIT(ifp) spin_lock_init(&(ifp)->sta_list_lock)
> +#define BRCMF_IF_STA_LIST_LOCK(ifp, flags) \
> +	spin_lock_irqsave(&(ifp)->sta_list_lock, (flags))
> +#define BRCMF_IF_STA_LIST_UNLOCK(ifp, flags) \
> +	spin_unlock_irqrestore(&(ifp)->sta_list_lock, (flags))
> +
> +#define BRCMF_STA_NULL ((struct brcmf_sta *)NULL)

Don't hide actual functions with macros like these.
