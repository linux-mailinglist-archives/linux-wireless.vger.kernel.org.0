Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF43476725
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Dec 2021 01:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhLPAyi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Dec 2021 19:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhLPAyi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Dec 2021 19:54:38 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20C3C061574
        for <linux-wireless@vger.kernel.org>; Wed, 15 Dec 2021 16:54:37 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id q72so32862984iod.12
        for <linux-wireless@vger.kernel.org>; Wed, 15 Dec 2021 16:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=egauge.net; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=DxLv+nTj3iyF1XqRT921ana05xn+Hmmvy3irbfbMeUg=;
        b=fgsGDeLK7ztcoYM+u3Hed1c7I8HlCgkuEnVF58UJruKy5AFxe8OGYQAL0t3+4W4rNG
         OKwJEx5KXCDr00rPCnJhzN1VetNIFbawhVwXcghlozLrDHwFsabtyoXpvtevvl0HLNil
         EZnGMlf5Bpu1IFJjV1kdszh67TxPhBguRmsJ0GH1SvI65otyTeBGiOSbmJiw6e6kJhQv
         Vv6cAP/m3nehvw8dwKbgow9HoMqqQeYifAuVXHWDuzFuZq+GpsGJ8dMmeygxcUjt0CRo
         xuDw3HI7E+JjuGdkdmygC/Z5HZoDmr8nOIjLdfWeuv2BLGZHtny5YBpW3VnfH715qCIE
         Mp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=DxLv+nTj3iyF1XqRT921ana05xn+Hmmvy3irbfbMeUg=;
        b=A3eTzi39uXrzwyzDLpf91PWBawWpUYxoZhwulowl3uD9kTEqh3v41eiFd8Yc3ImXq7
         MIGob4U0xG70qAHvAjAbFG3Dg77uvdEjY+3X823EH/AdMFXvyPb7Tv2DmzHuD6gdcFcF
         36TIqvOszKAz63pzhsu5CzWkbTmTPfUX+xqsVQX3Qm5Bgr+OpibLcQpUcK1SjrqGfrF4
         7W1rgsmr2L1hakSN27YC3yKLRl4IlwoqKOsfkwwxQ1RkJ9YECleuI7aPWQcfRIX2sPG+
         hexRERKQRBwBrAopupnRGcUA8du19M0Ctu1ZOMCK5KqTmP2ll2t1uD3NsO96LWvyr9vM
         AODg==
X-Gm-Message-State: AOAM5315rRTT5q8YKLi39IEN0i9zk2xiXyoHG4J6hTxrRU+3Co146L3X
        9ro2VysjTCbLyo+ImyrV7x+v
X-Google-Smtp-Source: ABdhPJxZWNK/+lFDVswO9ljLaEr02GFWsO0oX4D9//e7ZP8UsNLqpEEb6AZLxgePXkBviezTDdMDTA==
X-Received: by 2002:a02:7053:: with SMTP id f80mr7596204jac.28.1639616077169;
        Wed, 15 Dec 2021 16:54:37 -0800 (PST)
Received: from ?IPv6:2601:281:8300:4e0:2ba9:697d:eeec:13b? ([2601:281:8300:4e0:2ba9:697d:eeec:13b])
        by smtp.gmail.com with ESMTPSA id j6sm1715921ilc.8.2021.12.15.16.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 16:54:36 -0800 (PST)
Message-ID: <8bca161b9689bf02f0620e3b59f5040c7e8b2db1.camel@egauge.net>
Subject: Re: RFC: wilc1000: refactor TX path to use sk_buff queue
From:   David Mosberger-Tang <davidm@egauge.net>
To:     Ajay.Kathat@microchip.com, Claudiu.Beznea@microchip.com,
        kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Date:   Wed, 15 Dec 2021 17:54:27 -0700
In-Reply-To: <7a6956db-8710-4d6c-9bed-702ec1b7041e@microchip.com>
References: <e3502ecffe0c4c01b263ada8deed814d5135c24c.camel@egauge.net>
         <7a6956db-8710-4d6c-9bed-702ec1b7041e@microchip.com>
Organization: eGauge Systems LLC
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2021-12-15 at 12:44 +0000, Ajay.Kathat@microchip.com wrote:
> On 12/12/21 02:02, David Mosberger-Tang wrote:
> > Notes:
> > 
> >   - Don't try to apply this patch as is.  There are two other small
> >     but unrelated changes that this patch below depends on.
> 
> Btw what are the other two changes required to make it work. I believe 
> the working flow shouldn't get impacted after the restructuring 
> especially when code is refactor(replaced) using the existing solution.

I'll start working on a patch series.  There are some before and some
after the sk_buff refactor, but those are all pretty straight-forward
in comparison.

> > 
> > Thoughts and/or suggestions?
> 
> Using sk_buff queue is a good idea but the patch has other changes also. 
> This patch should be splited into a few different logical related 
> changes. Using a single patch for all these changes may not be easy to 
> review and handle if there are any regressions.
> 
> One way to split the changes could be like:
> 
>   - sk_buff handling for mgmt/data and config frames
>   - WID(config packets) functions refactoring
>   - Functions refactoring
>   - Rename related changes

Yeah, the WID refactoring and structure renaming can be split off
easily, good suggestion.  Let me start working on that.

> <snip>
> 
> >                  (*ac)++;
> >          
> > +static int wilc_wlan_cfg_apply_wid(struct wilc_vif *vif, int start, u16 wid,
> > +                                  u8 *buffer, u32 buffer_size, int commit,
> > +                                  u32 drv_handler, bool set)
> >   {
> > -       u32 offset;
> >          int ret_size;
> >          struct wilc *wilc = vif->wilc;
> > 
> >          mutex_lock(&wilc->cfg_cmd_lock);
> > 
> > -       if (start)
> > -               wilc->cfg_frame_offset = 0;
> > -
> > -       offset = wilc->cfg_frame_offset;
> > -       ret_size = wilc_wlan_cfg_set_wid(wilc->cfg_frame.frame, offset,
> > -                                        wid, buffer, buffer_size);
> > -       offset += ret_size;
> > -       wilc->cfg_frame_offset = offset;
> > -
> > -       if (!commit) {
> > -               mutex_unlock(&wilc->cfg_cmd_lock);
> > -               return ret_size;
> > +       if (start) {
> > +               WARN_ON(wilc->cfg_skb);
> > +               wilc->cfg_skb = alloc_cfg_skb(vif);
> > +               if (!wilc->cfg_skb) {
> 
> 'cfg_cmd_lock' mutex unlock is missing.

Indeed, thanks for catching that!

  --david


