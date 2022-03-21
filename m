Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B714E3198
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 21:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245406AbiCUUTW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Mar 2022 16:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353225AbiCUUTV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Mar 2022 16:19:21 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D001EA
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 13:17:56 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id c11so11089084pgu.11
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 13:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4pZUoUae/CV0+chIgjEa7wfBXVTwl8EKVh364hVPrfU=;
        b=X5KauTsk3eLQsj+qa7E6jSKCFBPSMKfod/+Be0ck0vCAvGL9W8url/Cgnp5nrIOrPN
         S7+X0KpRBOsWPMpBbFuCPvYXgvnetyKv5wSZ7jX3OhQ2G27rVrj/p+lwul0eoKFzZ9Sg
         SZ5Rk/TCBZW253dC+VWk9Wl/LGKtfyrqFG3Og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4pZUoUae/CV0+chIgjEa7wfBXVTwl8EKVh364hVPrfU=;
        b=h6QV5wgJLTMxYqBl6/6ME76/B4CyskdVB20AOvHcjIXv4OMELzcN0asgYxG6UAA9/7
         OkEUrmy+yKIt6g+wkMYirTwXQ2ou9HTxoc3KAc77bjcPWwrdlUNzXc0lxMvYvGEyrOpB
         rlOR3XQ0v+moNago4ZnKCGobXJrQ0iTh9cH6YppvSZCFlsRXQuPdsbheIa2fZB2GvbtM
         0bQ3+YAKY4m4f/fdGzdyo2iX12VNfFK8nZH4TGiH39dd6foHwqa0wEvUD15MAQdJCfYq
         n9D9KttsIBdNeKtNKUQ+al7NqEGwFYQW0eQ+U1HPGHNr1bf73CGJF1tqVhHb2R7aODMV
         6yDw==
X-Gm-Message-State: AOAM533jHY/+hSXDZoiz5zwFXC/PvxF12qYnBgGbh+Y5H5vgLxOrofdn
        i+RRxBRHli8svzSXFYP1gX+hQQ==
X-Google-Smtp-Source: ABdhPJzrRkReN7gf5PI06JXQDaediU+hsjAG3DJq+virv9lI1eDrkUlMkyhZgFaOOR88JLGnGDSDjA==
X-Received: by 2002:a05:6a00:22cb:b0:4fa:ad77:1510 with SMTP id f11-20020a056a0022cb00b004faad771510mr3343403pfj.80.1647893875630;
        Mon, 21 Mar 2022 13:17:55 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:6dba:56e0:1f17:3446])
        by smtp.gmail.com with ESMTPSA id r4-20020a638f44000000b0038105776895sm15804846pgn.76.2022.03.21.13.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 13:17:54 -0700 (PDT)
Date:   Mon, 21 Mar 2022 13:17:52 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Niels Dossche <dossche.niels@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@kernel.org>
Subject: Re: [PATCH RFT] mwifiex: add mutex lock for call in
 mwifiex_dfs_chan_sw_work_queue
Message-ID: <YjjdcG5NmzLOmjEu@google.com>
References: <20220319224751.72241-1-dossche.niels@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220319224751.72241-1-dossche.niels@gmail.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Mar 19, 2022 at 11:47:52PM +0100, Niels Dossche wrote:
> --- a/drivers/net/wireless/marvell/mwifiex/11h.c
> +++ b/drivers/net/wireless/marvell/mwifiex/11h.c
> @@ -285,6 +285,7 @@ void mwifiex_dfs_chan_sw_work_queue(struct work_struct *work)
>  	struct mwifiex_private *priv =
>  			container_of(delayed_work, struct mwifiex_private,
>  				     dfs_chan_sw_work);
> +	struct net_device *netdev;
>  
>  	bss_cfg = &priv->bss_cfg;
>  	if (!bss_cfg->beacon_period) {
> @@ -301,7 +302,11 @@ void mwifiex_dfs_chan_sw_work_queue(struct work_struct *work)
>  		return;
>  	}
>  
> +	netdev = priv->netdev;
> +
>  	mwifiex_dbg(priv->adapter, MSG,
>  		    "indicating channel switch completion to kernel\n");
> -	cfg80211_ch_switch_notify(priv->netdev, &priv->dfs_chandef);
> +	mutex_lock(&netdev->ieee80211_ptr->mtx);

A more appropriate route to this object might be priv->wdev.mtx. But
otherwise, I think this makes sense, and matches what
ath6kl_cfg80211_ch_switch_notify() and qtnf_event_handle_freq_change()
do. With the suggested change:

Reviewed-by: Brian Norris <briannorris@chromium.org>

Thanks.

> +	cfg80211_ch_switch_notify(netdev, &priv->dfs_chandef);
> +	mutex_unlock(&netdev->ieee80211_ptr->mtx);
>  }
> -- 
> 2.35.1
> 
