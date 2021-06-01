Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE14397060
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jun 2021 11:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbhFAJaN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Jun 2021 05:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbhFAJaM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Jun 2021 05:30:12 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB70C06174A
        for <linux-wireless@vger.kernel.org>; Tue,  1 Jun 2021 02:28:30 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id t9so6491040pgn.4
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jun 2021 02:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Clq5ycZC/DAkJrYzdB1pjmh54x4ErJny57qDeI6dFMY=;
        b=dqKX3q8NCgLQ8S4jk1QY0OmAyeKWU/lyZWfKfBB96LACpUFbC/sWq3KYPZYjOphssF
         3Yl8gRO5UbgB6hzGstclGpYDZZKtawQHpfvjL6qyl2vPfslKnofb7b+/suNTC2BIWaE4
         Tiuh0Gd0oE7vtsPRMSo+tPeE0oxVgLYeb4gsvD3vUYdCLM39TpggczBvxzXapSWHixA1
         peqD/Glhwj0vCPZG6XPmwApk2tR9h6FHhJFnn3dbbIqtbhUR6XgNfB2e/fvXxVtdBB9Y
         MExlglVyfGgMHBIuu2oamq3Xvsfad4qWXXnM3OCi0RBs42WUF+sDcIhe8GFtwO/4fJ+6
         WDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Clq5ycZC/DAkJrYzdB1pjmh54x4ErJny57qDeI6dFMY=;
        b=tcaw08Gmw8Vg8yBbe4RUwRClDwJEzX9PJq4S9ezOxE0KFyoBfHUGSqT6/IHMZngIUe
         5IuLsxi9SjoWT3y5g2EOBfjLP1xbFLXF5SPljjrgccqCaQLSz3gThOoJmtKWdufi3hvv
         /7i5Y5z6sadGipesK68thcok+0ssuSQ52qB+VyjRsIZpZZp0SqSzYRl/fQeNU8aMQcII
         hMklsRFUmBaSDLRqFuR9JU+ITvzn7MB7ZjKPg9Zq8/pGhcOuvbixifrREsTlXBgUNwvj
         8voMF06tkONgVjlrFpHl3KIjJ6tMdk4s7StlkozYkWaxI943ZAarJ3FGJtUfcpr9MyBt
         MnyA==
X-Gm-Message-State: AOAM531Tjsau19Bas/PwoDLeSoa/Mwky+kasMFtdWe8Jg8GkJMPH7Ifd
        IWyIpSl7hNrTXC8c069/RflumxiTOMS+o9mwf8yLkVSwwn/rfA==
X-Google-Smtp-Source: ABdhPJySTvgpukyVQ3CCDDXP1MyH8YRLR2q7+viVESyoBvVTzX1jPv2ME/JVkoLduK0+S61xmqcZlgPx+rEgxdOuZHo=
X-Received: by 2002:a63:1906:: with SMTP id z6mr26722024pgl.173.1622539709406;
 Tue, 01 Jun 2021 02:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210601080538.71036-1-johannes@sipsolutions.net> <20210601100320.7d39e9c33a18.I0474861dad426152ac7e7afddfd7fe3ce70870e4@changeid>
In-Reply-To: <20210601100320.7d39e9c33a18.I0474861dad426152ac7e7afddfd7fe3ce70870e4@changeid>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Tue, 1 Jun 2021 11:37:48 +0200
Message-ID: <CAMZdPi-ZaH8WWKfhfKzy0OKpUtNAiCUfekh9R1de5awFP-ed=A@mail.gmail.com>
Subject: Re: [RFC 3/4] wwan: add interface creation support
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        M Chetan Kumar <m.chetan.kumar@intel.com>,
        Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On Tue, 1 Jun 2021 at 10:05, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> From: Johannes Berg <johannes.berg@intel.com>
>
> Add support to create (and destroy) interfaces via a new
> rtnetlink kind "wwan". The responsible driver has to use
> the new wwan_register_ops() to make this possible.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  drivers/net/wwan/wwan_core.c | 219 ++++++++++++++++++++++++++++++++++-
>  include/linux/wwan.h         |  36 ++++++
>  include/uapi/linux/wwan.h    |  17 +++
>  3 files changed, 267 insertions(+), 5 deletions(-)
>  create mode 100644 include/uapi/linux/wwan.h
>
> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
> index cff04e532c1e..b1ad78f386bc 100644
> --- a/drivers/net/wwan/wwan_core.c
> +++ b/drivers/net/wwan/wwan_core.c
> @@ -13,6 +13,8 @@
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  #include <linux/wwan.h>
> +#include <net/rtnetlink.h>
> +#include <uapi/linux/wwan.h>
>
>  #define WWAN_MAX_MINORS 256 /* 256 minors allowed with register_chrdev() */
>
> @@ -524,24 +526,231 @@ static const struct file_operations wwan_port_fops = {
>         .llseek = noop_llseek,
>  };
>
> +struct wwan_dev_reg {
> +       struct list_head list;
> +       struct device *dev;
> +       const struct wwan_ops *ops;
> +       void *ctxt;
> +};
> +
> +static DEFINE_MUTEX(wwan_mtx);
> +static LIST_HEAD(wwan_devs);
> +
> +int wwan_register_ops(struct device *parent, const struct wwan_ops *ops,
> +                     void *ctxt)
> +{
> +       struct wwan_dev_reg *reg;
> +       int ret;
> +
> +       if (WARN_ON(!parent || !ops))
> +               return -EINVAL;
> +
> +       mutex_lock(&wwan_mtx);
> +       list_for_each_entry(reg, &wwan_devs, list) {
> +               if (WARN_ON(reg->dev == parent)) {
> +                       ret = -EBUSY;
> +                       goto out;
> +               }
> +       }

Thanks for this, overall it looks good to me, but just checking why
you're not using the wwan_dev internally to create-or-pick wwan_dev
(wwan_dev_create) and register ops to it, instead of having a global
new wwan_devs list.

> +
> +       reg = kzalloc(sizeof(*reg), GFP_KERNEL);
> +       if (!reg) {
> +               ret = -ENOMEM;
> +               goto out;
> +       }
> +
> +       reg->dev = parent;
> +       reg->ops = ops;
> +       reg->ctxt = ctxt;
> +       list_add_tail(&reg->list, &wwan_devs);
> +
> +       ret = 0;
> +
> +out:
> +       mutex_unlock(&wwan_mtx);
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(wwan_register_ops);

Regards,
Loic
