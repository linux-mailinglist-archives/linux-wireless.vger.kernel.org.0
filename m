Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9000724B764
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Aug 2020 12:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731223AbgHTKwz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Aug 2020 06:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731754AbgHTKwl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Aug 2020 06:52:41 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C62C061385
        for <linux-wireless@vger.kernel.org>; Thu, 20 Aug 2020 03:52:39 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id q3so861845ybp.7
        for <linux-wireless@vger.kernel.org>; Thu, 20 Aug 2020 03:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qFg0fTaB3+GfMKuLQ51IwQJLD9IZEEj3iaMDrAInzYc=;
        b=D5/BITcxPOycWbCps/MIKy6oe+joJP4VtRVSVRXMDYd8jL8f8oSyudxtTeobwOKS6t
         5skKJHOjM0mXw4YHaSpWTUa25VU67JFvHdBnjXZ1DUKtZErgOspmCVqqi6wSH1lK+nvg
         Sq6P0BYyc2ccxWZPxqlekpmg4j01WPUoAEpKIZVErQLv1Ju/WElxPO/ukIf5xi2qNjfd
         x9YTd/BXjPB0zAXlMZXpKsi5xpY9/QUMuLqmLtwU9BtPpPRJyMptUjP/vruj88Wfk5nf
         aKAC+abMf/Nkn4KmEBt6/4WZCYxes2smMIjAuewF3cKAtW2T9ruGBqobx5lMP4ZVlamj
         /7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qFg0fTaB3+GfMKuLQ51IwQJLD9IZEEj3iaMDrAInzYc=;
        b=F5AXCQIAzZ6Zb9SIq+KE+ztrtk/xFVKWtA0imhlP4OP3awYLZttw6ThCPoMMuGBGSj
         I6JXdtQEN7iQJjAkghDN7Tx7QyAHt/GTXbmKv5mHOAqmnLG3SllxgaYYfoxZS/k/SddF
         qVum92EqPbJcabyKlICs+JWIKH0Ev7p/Rw9m5lHr/MNSqAkVz77OU8pT1Bt0WjCoOz1Q
         e9ZGzska1BvNb3nAsBqsB9WAFYmOvyNCtlVj5AoC+MF7NsZEWzrCWA8Mv25Td/ClBTF8
         RWiZdE1PCljAHG7HZat3N70rq3dmMWO6eq9DKLV+l2qej2kk3fwCmH3YqsjbL541xlBr
         MCdQ==
X-Gm-Message-State: AOAM532czuq91MVEpvH4llV8ejlwQ6PtZXbKw7h5kT1NoWyXFBW/LPcP
        sLMHzJw8p78cv2yF6mjgyD2fKIXuTQ46u/WvLJ0=
X-Google-Smtp-Source: ABdhPJwb0M6XgKvvL66yX0ekCv5Z3BLXQSUUqfXZzQU9GPL1zEp482UaUQEKhUnNVrFASKljVENg5cnaKV/lrz0sJfs=
X-Received: by 2002:a25:1683:: with SMTP id 125mr3506392ybw.145.1597920758293;
 Thu, 20 Aug 2020 03:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200214035555.24762-1-wgong@codeaurora.org> <878se9iup3.fsf@codeaurora.org>
 <CABPxzYK4kYvBAvYxk6rs-PHM==vBaHQTm3dCCh_+Z+KOB+c6qA@mail.gmail.com> <b7e0e8dfe9a4ee0cb92c6c0f153c7bc2@codeaurora.org>
In-Reply-To: <b7e0e8dfe9a4ee0cb92c6c0f153c7bc2@codeaurora.org>
From:   Krishna Chaitanya <chaitanya.mgit@gmail.com>
Date:   Thu, 20 Aug 2020 16:22:27 +0530
Message-ID: <CABPxzYK6wd8FGaM9tb_PYroARJ8RCjJ0Y-nVxY3AoubrfSbZ4w@mail.gmail.com>
Subject: Re: [RFC] ath10k: change to do napi_enable and napi_disable when
 insmod and rmmod for sdio
To:     Wen Gong <wgong@codeaurora.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 20, 2020 at 3:45 PM Wen Gong <wgong@codeaurora.org> wrote:
>
> On 2020-08-20 17:19, Krishna Chaitanya wrote:
> ...
> >> > diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
> >> > index 7b894dcaad2e..b71499b171c6 100644
> >> > --- a/drivers/net/wireless/ath/ath10k/sdio.c
> >> > +++ b/drivers/net/wireless/ath/ath10k/sdio.c
> >> > @@ -1756,8 +1756,6 @@ static int ath10k_sdio_hif_start(struct ath10k *ar)
> >> >       struct ath10k_sdio *ar_sdio = ath10k_sdio_priv(ar);
> >> >       int ret;
> >> >
> >> > -     napi_enable(&ar->napi);
> >> > -
> >> >       /* Sleep 20 ms before HIF interrupts are disabled.
> >> >        * This will give target plenty of time to process the BMI done
> >> >        * request before interrupts are disabled.
> >> > @@ -1884,7 +1882,6 @@ static void ath10k_sdio_hif_stop(struct ath10k *ar)
> >> >       spin_unlock_bh(&ar_sdio->wr_async_lock);
> >> >
> >> >       napi_synchronize(&ar->napi);
> >> > -     napi_disable(&ar->napi);
> >> >  }
> >> >
> >> >  #ifdef CONFIG_PM
> >> > @@ -2121,6 +2118,7 @@ static int ath10k_sdio_probe(struct sdio_func *func,
> >> >
> >> >       netif_napi_add(&ar->napi_dev, &ar->napi, ath10k_sdio_napi_poll,
> >> >                      ATH10K_NAPI_BUDGET);
> >> > +     napi_enable(&ar->napi);
> >> >
> >> >       ath10k_dbg(ar, ATH10K_DBG_BOOT,
> >> >                  "sdio new func %d vendor 0x%x device 0x%x block 0x%x/0x%x\n",
> >> > @@ -2235,6 +2233,7 @@ static void ath10k_sdio_remove(struct sdio_func *func)
> >> >
> >> >       ath10k_core_unregister(ar);
> >> >
> >> > +     napi_disable(&ar->napi);
> >> >       netif_napi_del(&ar->napi);
> >> >
> >> >       ath10k_core_destroy(ar);
> >>
> >> I'm not really convinced that this is the right fix, but I'm no NAPI
> >> expert. Can anyone else help?
> > Calling napi_disable() twice can lead to hangs, but moving NAPI from
> > start/stop to
> > the probe isn't the right approach as the datapath is tied to
> > start/stop.
> >
> > Maybe check the state of NAPI before disable?
> >
> >  if (test_bit(NAPI_STATE_SCHED, &ar->napi.napi.state))
> >   napi_disable(&ar->napi)
> > or maintain napi_state like this
> > https://patchwork.kernel.org/patch/10249365/
> it is better to use above link's patch.
> napi.state is controlled by napi API, it is better ath10k not know it.
Sure, but IMHO just canceling the async rx work should solve the issue.

> > Also, the most common cause for such issues (1st
> > napi_synchronize/napi_disable hang)
> > is that napi_poll is being scheduled, so, you might want to check that
> > napi_schedule isn't
> > called after stop.
> >
> > cd ath10k; git log --grep=napi shows plenty of such issues. the one
> > that matches closest is
> > c2cac2f74ab4bcf0db0dcf3a612f1e5b52d145c8, so, it could just be a
> > regression.
> This above commit's scene is not same with this patch.
> It is hang for only do 1 simulate crash of the commit, this patch is
> doing simulate crash and rmmod meanwhile.
yes, it is the closest one I could find.
