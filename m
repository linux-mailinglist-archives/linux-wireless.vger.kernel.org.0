Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87551E7C8
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2019 18:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbfD2Qbq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Apr 2019 12:31:46 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41871 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbfD2Qbq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Apr 2019 12:31:46 -0400
Received: by mail-ed1-f68.google.com with SMTP id m4so9686205edd.8
        for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2019 09:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version:content-transfer-encoding;
        bh=BWo0kM+oFKEoYkxapW/tW60kpUQJgs2fmk/BrqH+vpA=;
        b=X2Ze4S06FbA9j/e1Ox+tI4b07KLQkp+uUJ0odpy8rk0dSjtNEAUvpCDx7T6LApW+mH
         rau7VGi8jOtPcxYn5oZhPUGKZlC0+T9JY3E0Afjl0tj9YyDGqtES78Ecm40y3Zr9BlEi
         /t7lUqN8pRqQ8bSNvxguQd8ANSeQdCrK6qPRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version
         :content-transfer-encoding;
        bh=BWo0kM+oFKEoYkxapW/tW60kpUQJgs2fmk/BrqH+vpA=;
        b=G3WVZoNgeTJCPZNKK7FpO2+CqjWtRlvwLsdHUHYglHVILCP4Fq/DD9s2IR6R/kCcJ/
         1SNE1kuiZVDLsbGdgItuKZx2Ge13Ew0y0Rh6c1/VFdNR3rmk7UZr2wD/R+Z4lFHQmEnP
         z/M6ETrW2rrjAW9Bis1sQVqEIRdnTHzWAgnz4P5HDRWmXVDdF3N2kwgU7zFLlZlru/Ch
         62lADkSpwSoKDTVmoiqoc7yP+etDgNBvMIV7tzyFs6AcOvq4S2Jf5Z7XllCfmYxniFbm
         yAN6ULHDyGXRHLJLygezaRkuOU4bH/T20Sie2bAH0o61yflLxUyguT8GekgVUsNeeiUr
         RZfw==
X-Gm-Message-State: APjAAAWK8Shle0fPgZHCz78OwO+5QdA0Zy4A4roz44rhHYZbrOTWhcjM
        9S4TGH7z2mxGD7N+eCrQ8PRzjA==
X-Google-Smtp-Source: APXvYqz4tSjJ1O/Y/1+5qjfyl3O+d9Ae3lP2oLvyBhHXTLJxaEND/yHJTp89pxoYsVxWSPtOEDy3ig==
X-Received: by 2002:a50:9047:: with SMTP id z7mr38068569edz.218.1556555502961;
        Mon, 29 Apr 2019 09:31:42 -0700 (PDT)
Received: from [192.168.178.17] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id m27sm1291072eje.67.2019.04.29.09.31.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Apr 2019 09:31:42 -0700 (PDT)
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>
Date:   Mon, 29 Apr 2019 18:31:40 +0200
Message-ID: <16a69f009e0.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <1556532561-24428-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1556532561-24428-1-git-send-email-arend.vanspriel@broadcom.com>
User-Agent: AquaMail/1.20.0-1447 (build: 102000000)
Subject: Re: [PATCH] brcmfmac: change the order of things in brcmf_detach()
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

This should have been RFT/RFC. Not sure how that's handled in patchwork but 
please do not take this (yet).

Regards,
Arend


On April 29, 2019 6:02:03 PM Arend van Spriel 
<arend.vanspriel@broadcom.com> wrote:

> When brcmf_detach() from the bus layer upon rmmod we can no longer
> communicate. Hence we will set the bus state to DOWN and cleanup
> the event and protocol layer. The network interfaces need to be
> deleted before brcmf_cfg80211_detach() because the latter does the
> wiphy_unregister() which issues a warning if there are still network
> devices linked to the wiphy instance.
>
> This change solves a null pointer dereference issue which happened
> upon issueing rmmod while there are packets queued in bus protocol
> layer.
>
> Reported-by: Rafał Miłecki <rafal@milecki.pl>
> Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
> Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
> Reviewed-by: Franky Lin <franky.lin@broadcom.com>
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> ---
> Hi Piotr,
>
> While working on an issue with msgbuf protocol (used for PCIe devices)
> your change 5cdb0ef6144f ("brcmfmac: fix NULL pointer derefence during
> USB disconnect") conflicted. I suspect my reordering stuff in
> brcmf_detach() also fixes your issue so could you retest this patch,
> which basically reverts your change and applies my reordering, and see
> whether my suspicion can be confirmed.
>
> Regards,
> Arend
> ---
>  .../wireless/broadcom/brcm80211/brcmfmac/bcdc.c    | 11 ++-------
>  .../wireless/broadcom/brcm80211/brcmfmac/bcdc.h    |  6 ++---
>  .../wireless/broadcom/brcm80211/brcmfmac/core.c    | 27 +++++++++++-----------
>  .../broadcom/brcm80211/brcmfmac/fwsignal.c         | 16 ++++---------
>  .../broadcom/brcm80211/brcmfmac/fwsignal.h         |  3 +--
>  .../wireless/broadcom/brcm80211/brcmfmac/proto.c   | 10 ++------
>  .../wireless/broadcom/brcm80211/brcmfmac/proto.h   |  3 +--
>  7 files changed, 25 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.c 
> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.c
> index 98b1687..73d3c1a 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.c
> @@ -490,18 +490,11 @@ int brcmf_proto_bcdc_attach(struct brcmf_pub *drvr)
>  	return -ENOMEM;
>  }
>  
> -void brcmf_proto_bcdc_detach_pre_delif(struct brcmf_pub *drvr)
> -{
> -	struct brcmf_bcdc *bcdc = drvr->proto->pd;
> -
> -	brcmf_fws_detach_pre_delif(bcdc->fws);
> -}
> -
> -void brcmf_proto_bcdc_detach_post_delif(struct brcmf_pub *drvr)
> +void brcmf_proto_bcdc_detach(struct brcmf_pub *drvr)
>  {
>  	struct brcmf_bcdc *bcdc = drvr->proto->pd;
>  
>  	drvr->proto->pd = NULL;
> -	brcmf_fws_detach_post_delif(bcdc->fws);
> +	brcmf_fws_detach(bcdc->fws);
>  	kfree(bcdc);
>  }
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.h 
> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.h
> index 4bc5224..3b0e9ef 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.h
> @@ -18,16 +18,14 @@
>  
>  #ifdef CONFIG_BRCMFMAC_PROTO_BCDC
>  int brcmf_proto_bcdc_attach(struct brcmf_pub *drvr);
> -void brcmf_proto_bcdc_detach_pre_delif(struct brcmf_pub *drvr);
> -void brcmf_proto_bcdc_detach_post_delif(struct brcmf_pub *drvr);
> +void brcmf_proto_bcdc_detach(struct brcmf_pub *drvr);
>  void brcmf_proto_bcdc_txflowblock(struct device *dev, bool state);
>  void brcmf_proto_bcdc_txcomplete(struct device *dev, struct sk_buff *txp,
>  				 bool success);
>  struct brcmf_fws_info *drvr_to_fws(struct brcmf_pub *drvr);
>  #else
>  static inline int brcmf_proto_bcdc_attach(struct brcmf_pub *drvr) { return 0; }
> -static void brcmf_proto_bcdc_detach_pre_delif(struct brcmf_pub *drvr) {};
> -static inline void brcmf_proto_bcdc_detach_post_delif(struct brcmf_pub 
> *drvr) {}
> +static inline void brcmf_proto_bcdc_detach(struct brcmf_pub *drvr) {}
>  #endif
>  
>  #endif /* BRCMFMAC_BCDC_H */
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c 
> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> index bc73a2e..db49381 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> @@ -1322,27 +1322,26 @@ void brcmf_detach(struct device *dev)
>  	unregister_inet6addr_notifier(&drvr->inet6addr_notifier);
>  #endif
>  
> -	/* stop firmware event handling */
> -	brcmf_fweh_detach(drvr);
> -	if (drvr->config)
> -		brcmf_p2p_detach(&drvr->config->p2p);
> -
>  	brcmf_bus_change_state(bus_if, BRCMF_BUS_DOWN);
> +	brcmf_bus_stop(drvr->bus_if);
>  
> -	brcmf_proto_detach_pre_delif(drvr);
> +	brcmf_fweh_detach(drvr);
> +	brcmf_proto_detach(drvr);
>  
>  	/* make sure primary interface removed last */
> -	for (i = BRCMF_MAX_IFS-1; i > -1; i--)
> -		brcmf_remove_interface(drvr->iflist[i], false);
> -
> -	brcmf_cfg80211_detach(drvr->config);
> -	drvr->config = NULL;
> -
> -	brcmf_bus_stop(drvr->bus_if);
> +	for (i = BRCMF_MAX_IFS-1; i > -1; i--) {
> +		if (drvr->iflist[i])
> +			brcmf_del_if(drvr, drvr->iflist[i]->bsscfgidx, false);
> +	}
>  
> -	brcmf_proto_detach_post_delif(drvr);
> +	if (drvr->config) {
> +		brcmf_p2p_detach(&drvr->config->p2p);
> +		brcmf_cfg80211_detach(drvr->config);
> +		drvr->config = NULL;
> +	}
>  
>  	bus_if->drvr = NULL;
> +
>  	wiphy_free(drvr->wiphy);
>  }
>  
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c 
> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
> index c22c49a..d48b8b2 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
> @@ -2443,25 +2443,17 @@ struct brcmf_fws_info *brcmf_fws_attach(struct 
> brcmf_pub *drvr)
>  	return fws;
>  
>  fail:
> -	brcmf_fws_detach_pre_delif(fws);
> -	brcmf_fws_detach_post_delif(fws);
> +	brcmf_fws_detach(fws);
>  	return ERR_PTR(rc);
>  }
>  
> -void brcmf_fws_detach_pre_delif(struct brcmf_fws_info *fws)
> +void brcmf_fws_detach(struct brcmf_fws_info *fws)
>  {
>  	if (!fws)
>  		return;
> -	if (fws->fws_wq) {
> -		destroy_workqueue(fws->fws_wq);
> -		fws->fws_wq = NULL;
> -	}
> -}
>  
> -void brcmf_fws_detach_post_delif(struct brcmf_fws_info *fws)
> -{
> -	if (!fws)
> -		return;
> +	if (fws->fws_wq)
> +		destroy_workqueue(fws->fws_wq);
>  
>  	/* cleanup */
>  	brcmf_fws_lock(fws);
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.h 
> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.h
> index 749c06d..4e68357 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.h
> @@ -19,8 +19,7 @@
>  #define FWSIGNAL_H_
>  
>  struct brcmf_fws_info *brcmf_fws_attach(struct brcmf_pub *drvr);
> -void brcmf_fws_detach_pre_delif(struct brcmf_fws_info *fws);
> -void brcmf_fws_detach_post_delif(struct brcmf_fws_info *fws);
> +void brcmf_fws_detach(struct brcmf_fws_info *fws);
>  void brcmf_fws_debugfs_create(struct brcmf_pub *drvr);
>  bool brcmf_fws_queue_skbs(struct brcmf_fws_info *fws);
>  bool brcmf_fws_fc_active(struct brcmf_fws_info *fws);
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/proto.c 
> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/proto.c
> index c7964cc..024c643 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/proto.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/proto.c
> @@ -67,22 +67,16 @@ int brcmf_proto_attach(struct brcmf_pub *drvr)
>  	return -ENOMEM;
>  }
>  
> -void brcmf_proto_detach_post_delif(struct brcmf_pub *drvr)
> +void brcmf_proto_detach(struct brcmf_pub *drvr)
>  {
>  	brcmf_dbg(TRACE, "Enter\n");
>  
>  	if (drvr->proto) {
>  		if (drvr->bus_if->proto_type == BRCMF_PROTO_BCDC)
> -			brcmf_proto_bcdc_detach_post_delif(drvr);
> +			brcmf_proto_bcdc_detach(drvr);
>  		else if (drvr->bus_if->proto_type == BRCMF_PROTO_MSGBUF)
>  			brcmf_proto_msgbuf_detach(drvr);
>  		kfree(drvr->proto);
>  		drvr->proto = NULL;
>  	}
>  }
> -
> -void brcmf_proto_detach_pre_delif(struct brcmf_pub *drvr)
> -{
> -	if (drvr->proto && drvr->bus_if->proto_type == BRCMF_PROTO_BCDC)
> -		brcmf_proto_bcdc_detach_pre_delif(drvr);
> -}
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/proto.h 
> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/proto.h
> index 72355ae..d3c3b9a 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/proto.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/proto.h
> @@ -54,8 +54,7 @@ struct brcmf_proto {
>  
>  
>  int brcmf_proto_attach(struct brcmf_pub *drvr);
> -void brcmf_proto_detach_pre_delif(struct brcmf_pub *drvr);
> -void brcmf_proto_detach_post_delif(struct brcmf_pub *drvr);
> +void brcmf_proto_detach(struct brcmf_pub *drvr);
>  
>  static inline int brcmf_proto_hdrpull(struct brcmf_pub *drvr, bool do_fws,
>  				      struct sk_buff *skb,
> -- 
> 1.9.1
>


