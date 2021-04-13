Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A4C35E556
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Apr 2021 19:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347337AbhDMRtk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Apr 2021 13:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347323AbhDMRtk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Apr 2021 13:49:40 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3C8C061574
        for <linux-wireless@vger.kernel.org>; Tue, 13 Apr 2021 10:49:19 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id w8so8440768pfn.9
        for <linux-wireless@vger.kernel.org>; Tue, 13 Apr 2021 10:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VRKzVsLuoCq+mTv2DRLYTgFxh/UyG4WyL0V7P1rrJx4=;
        b=ofzm0sYr+RisYzXQntOWQzdqfyAmX26Soc4HmwK3NunE9W3LMIwTDSwofu0JR27whi
         7IM3wU2/yrlvfy7yedKAb8ETXq1BkRNbxe6Tb+k3+R+9IPcEpOjj8TmSsOYj8Hifj3uM
         SVeOz+e7zBUgWXQ2HRC2BcEfuL+FBnuXwb6cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VRKzVsLuoCq+mTv2DRLYTgFxh/UyG4WyL0V7P1rrJx4=;
        b=PaRvG49E65NHxattOxlRi9qHB5hR7/kDRP162I/RtiON4S8hNXoQZSHy8kRpiGCPo1
         lqGvm+p2F1gnM9cFPYx4h0WDwaF8NrVzIVlhpr9zZSa55nifCDd+vnGb9s3RHTUNg+o+
         N8VANWQpVus49X5MK5xFTMoMemBVZGB4Yifxmlfe07K/IPi3MQMgfR97YvoQe495kW40
         eNKrDqPXxk+Hb9E1nB/YK+xfSssWghVttePTH1YhygxCZ6wrY9nVdqHeGNp6HMPBd9yU
         /gzkC66792E84fZvXNXXMdXWsDWw2EpuaLezTr16488ikQoQnpaGsYJM9Py64LUd3l3u
         JHlA==
X-Gm-Message-State: AOAM530VQUFLI4ypP9/xLGjfO84WsL/ZrOKKeM+uEnxs0l10ICKONT7C
        BQDh0hNpqEQBmW87RoyPZcsSLw==
X-Google-Smtp-Source: ABdhPJwWFim9PDHSAz9q4v3f6mcv2/noXThrFw+AQ6CqPfX4x/vYPgnelO4ACjrC2YHCwBP6VA3UkQ==
X-Received: by 2002:a63:4763:: with SMTP id w35mr33275195pgk.226.1618336141156;
        Tue, 13 Apr 2021 10:49:01 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:2f60:18d6:1566:ee50])
        by smtp.gmail.com with ESMTPSA id i9sm2976981pji.41.2021.04.13.10.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 10:48:59 -0700 (PDT)
Date:   Tue, 13 Apr 2021 10:48:57 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     lyl2019@mail.ustc.edu.cn
Cc:     amitkarwar@gmail.com, ganapathi.bhat@nxp.com,
        huxinming820@gmail.com, kvalo@codeaurora.org, davem@davemloft.net,
        kuba@kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wireless/marvell/mwifiex: Fix a double free in
 mwifiex_send_tdls_action_frame
Message-ID: <YHXZibYWEc6715KO@google.com>
References: <20210329112435.7960-1-lyl2019@mail.ustc.edu.cn>
 <4cb8138.42c74.178cbfdd339.Coremail.lyl2019@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4cb8138.42c74.178cbfdd339.Coremail.lyl2019@mail.ustc.edu.cn>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Wed, Apr 14, 2021 at 12:08:32AM +0800, lyl2019@mail.ustc.edu.cn wrote:
> 
> Hi,
>   maintianers.
> 
>   Sorry to disturb you, but this patch seems to be missed more than two weeks.
>   Could you help to review this patch? I am sure it won't take you much time.

You might take a look here:
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#checking_state_of_patches_from_patchwork
https://patchwork.kernel.org/project/linux-wireless/list/

Two weeks is not unheard of for waiting.

Anyway, you *did* succeed in catching my attention today, so I'll give
you a review, below:

> > -----原始邮件-----
> > 发件人: "Lv Yunlong" <lyl2019@mail.ustc.edu.cn>
> > 发送时间: 2021-03-29 19:24:35 (星期一)
> > 收件人: amitkarwar@gmail.com, ganapathi.bhat@nxp.com, huxinming820@gmail.com, kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
> > 抄送: linux-wireless@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Lv Yunlong" <lyl2019@mail.ustc.edu.cn>
> > 主题: [PATCH] wireless/marvell/mwifiex: Fix a double free in mwifiex_send_tdls_action_frame
> > 
> > In mwifiex_send_tdls_action_frame, it calls mwifiex_construct_tdls_action_frame
> > (..,skb). The skb will be freed in mwifiex_construct_tdls_action_frame() when
> > it is failed. But when mwifiex_construct_tdls_action_frame() returns error,
> > the skb will be freed in the second time by dev_kfree_skb_any(skb).
> > 
> > My patch removes the redundant dev_kfree_skb_any(skb) when
> > mwifiex_construct_tdls_action_frame() failed.
> > 
> > Fixes: b23bce2965680 ("mwifiex: add tdls_mgmt handler support")
> > Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> > ---
> >  drivers/net/wireless/marvell/mwifiex/tdls.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/net/wireless/marvell/mwifiex/tdls.c b/drivers/net/wireless/marvell/mwifiex/tdls.c
> > index 97bb87c3676b..8d4d0a9cf6ac 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/tdls.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/tdls.c
> > @@ -856,7 +856,6 @@ int mwifiex_send_tdls_action_frame(struct mwifiex_private *priv, const u8 *peer,
> >  	if (mwifiex_construct_tdls_action_frame(priv, peer, action_code,
> >  						dialog_token, status_code,
> >  						skb)) {
> > -		dev_kfree_skb_any(skb);

Good catch, and this looks correct for most cases, but I'll note that
you missed one issue: mwifiex_construct_tdls_action_frame() has a
default/error case ("Unknown TDLS action frame type") which does *not*
free this SKB, so you should patch that up at the same time. Otherwise,
you're trading a double-free for a potential memory leak.

With that fixed:

Reviewed-by: Brian Norris <briannorris@chromium.org>

Thanks.

> >  		return -EINVAL;
> >  	}
> >  
> > -- 
> > 2.25.1
> > 
