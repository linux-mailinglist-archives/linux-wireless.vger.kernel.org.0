Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C563B8897
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2019 02:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391613AbfITAgM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Sep 2019 20:36:12 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46541 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390299AbfITAgM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Sep 2019 20:36:12 -0400
Received: by mail-qk1-f194.google.com with SMTP id 201so5407359qkd.13
        for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2019 17:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=stg+GpIDtHLmRJfVFeaiidOrRaZK5aB+gDLGzBpnstM=;
        b=k2iaeOhCEz6eOKlGxqJcc/E+rroYDws2+YpFC8MfpD75tieXZpYWYoyVxPwoNMzfyb
         eHUWzoSVvZEOR3n+d4yQWUsu+bC2aY1JR6LHk1pbJ/IVWzvJ4pi45mY6UjTlq3Bn6UKa
         /uvO3Vm9A2gLaG5AHE4hQ7Lrko6vDKHlQHWCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=stg+GpIDtHLmRJfVFeaiidOrRaZK5aB+gDLGzBpnstM=;
        b=laIlg9Yd9q4W6aD0AyYJKvr1YIuZXEQVajxCkhLp3JDATMEUpO/h1vFIjCMS67t5cb
         qeaqeniB/kvi+krw0ykRUqH/etBCdS3SRNc6nuAcUviHWwUPqDMZKQ9fr1T/IPaVRton
         SAqSllWQbZrg8LUPZRk/WqG/HFxhBqgrAyuXTYe/a9l2w4taNwvVFBNtTm6Az2Av3qLi
         4rUy8eoL7EklTvmDI7kYWhviNcJruxv7t273Kt+yo6+LYNdIyNI8+YNzPoz4JOwKY3+U
         Zogn7JwBvhn9oFXPc06ia8Mvy/lI1BNYQuPZxZUDFS+Yd1e8RfqiPQoTthPgcKH0gf8I
         nrPg==
X-Gm-Message-State: APjAAAVj9I0YHt/aDeOhULQeNqUb6r2kv/QJZFyw8Xi/PDeA5TBH1gUI
        6FCX5AJq0GtFuKUmO6NYYL9YUwBLuxg=
X-Google-Smtp-Source: APXvYqzPM+ocVPKxz4AjJuokU3AOtbkWJtplG/vRbxHkH/nVDcDcciZ6PvILubjnbqyARHHPg2zwMg==
X-Received: by 2002:ae9:edc1:: with SMTP id c184mr632657qkg.336.1568939771008;
        Thu, 19 Sep 2019 17:36:11 -0700 (PDT)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com. [209.85.222.178])
        by smtp.gmail.com with ESMTPSA id q5sm185120qte.38.2019.09.19.17.36.08
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 17:36:09 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id w2so5486064qkf.2
        for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2019 17:36:08 -0700 (PDT)
X-Received: by 2002:a37:5a06:: with SMTP id o6mr606203qkb.279.1568939767810;
 Thu, 19 Sep 2019 17:36:07 -0700 (PDT)
MIME-Version: 1.0
References: <1568617425-28062-1-git-send-email-yhchuang@realtek.com>
 <1568617425-28062-6-git-send-email-yhchuang@realtek.com> <CA+ASDXOMao9uucGxa6C0Q99pFvAtKTptreeshbfKqiELDKUH0Q@mail.gmail.com>
 <F7CD281DE3E379468C6D07993EA72F84D18DC62E@RTITMBSVM04.realtek.com.tw>
In-Reply-To: <F7CD281DE3E379468C6D07993EA72F84D18DC62E@RTITMBSVM04.realtek.com.tw>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 19 Sep 2019 17:35:56 -0700
X-Gmail-Original-Message-ID: <CA+ASDXP_7FVEaQrE1V=rX0Vieu8GGWj+it7p4F_8XeRNniEWkw@mail.gmail.com>
Message-ID: <CA+ASDXP_7FVEaQrE1V=rX0Vieu8GGWj+it7p4F_8XeRNniEWkw@mail.gmail.com>
Subject: Re: [PATCH 05/15] rtw88: pci: release tx skbs DMAed when stop
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Sep 17, 2019 at 7:10 PM Tony Chuang <yhchuang@realtek.com> wrote:
> > On Mon, Sep 16, 2019 at 12:03 AM <yhchuang@realtek.com> wrote:
> > >
> > > From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> > >
> > > Interrupt is disabled to stop PCI, which means the skbs
> > > queued for each TX ring will not be released via DMA
> > > interrupt.
> >
> > In what cases do you hit this? I think you do this when entering PS
> > mode, no? But then, see below.
>
> I'll hit this when ieee80211_ops::stop, or rtw_power_off.
> Both are to turn off the device, so there's no more DMA activities.
> If we don't release the SKBs that are not released by DMA interrupt
> when powering off, these could be leaked.

Ah, I was a bit confused. So it does get called from "PS" routines:
rtw_enter_ips() -> rtw_core_stop()
but that "IPS" mode means "Inactive" Power Save, and it's only used
when transitioning into idle states (IEEE80211_CONF_IDLE).

Incidentally, I think this also may explain many of the leaks I've
been seeing elsewhere, when I leave a device sitting and scanning for
a very long time -- each scan attempt is making a single transition
out-and-back to IPS mode, which meant it may be leaking any
outstanding TX DMA. And testing confirms this: if I just bring up the
interface, run a scan, then bring it down, I see many fewer unmaps
than maps. Doing this enough times, I run out of contiguous DMA memory
and the device stops working. This fixes that problem for me. So:

Reviewed-by: Brian Norris <briannorris@chromium.org>
Tested-by: Brian Norris <briannorris@chromium.org>

I wonder if, given the problems I've seen (the driver can become
totally ineroperable), this patch and the previous patch (its only
real dependency) should be fast-tracked to the current release.

Brian
