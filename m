Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFFC392CBE
	for <lists+linux-wireless@lfdr.de>; Thu, 27 May 2021 13:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbhE0Lc1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 May 2021 07:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhE0Lc0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 May 2021 07:32:26 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC1FC061760
        for <linux-wireless@vger.kernel.org>; Thu, 27 May 2021 04:30:53 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id h20-20020a17090aa894b029015db8f3969eso193420pjq.3
        for <linux-wireless@vger.kernel.org>; Thu, 27 May 2021 04:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MlS0xmdn5B4d696+cBc2Ff0rtw7TtyTBgee8RyjE/Wo=;
        b=sRvivJZeJr1e9K10JQ2nra9RQgGVMYk+f2aRl5FfFgzWHmEf3mK+jiEeweODT2Dal+
         DambZ57j9v+D1kApQB4+eGQwY9Cjx0CG4u7+dtZuKYjpUmR5ZYtp2VYDWKzs3aRPo5Le
         uKZP12jNAkctmjB0j5Ic7GjikUgiMomy74tDahdcxBuaYPp0dltBqOgMAMJx0ln5iPvP
         cD7t5CNpI5w16NHIBggx7s2rSv7a3F7YnV8gEHufGYjvI7ggRJoM7m+Ibmz9b0EztTi1
         FS5OxBMRrwV7ZARdyLZvsjcStODYAgf2u07s4uzqKZTf9QUgYoLaIU5IV6CZmsDjr7z7
         fnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MlS0xmdn5B4d696+cBc2Ff0rtw7TtyTBgee8RyjE/Wo=;
        b=ex2QQm3tiqAn41pOxRXjKurTJ31CvX1hUahsiRvINJBhjjeGURbDVBWnHLxKaAvFxg
         8E2mFFHFrqTUA+/VIff6jmHINTvDrC1PpL6er0rzB860YAY7NWy05E+Ric6GMF5wKX8J
         fXkxOoWoBb+rQcQHZRzhFmxCFtOZTfLT73S0OqnzOQNQZsBVgKa3lHm6LOkMWiI4vv+W
         tquYtZRx4mQrvztjbWwGgXRANOVOA7iIWi3Z2bvFM3MlcieTzGLQw9aRVmrLZ9EFO4a0
         LaDGm8B6FfCrTLnF6WkNFdtzjV7b1TSoiH+Tkv++LKkRGBp1Ke5N3B2iPXR9DpItR4z8
         /6cA==
X-Gm-Message-State: AOAM531r5w5p2eceOKQ39pQvZ/3mBkYyAdeZrBzXZJJzfrzJUtpAh0Z8
        y+aYnGNms/pyGMwqvWPVFLrEfYqLTdE3U+f3o861mvkXUrvlnQ==
X-Google-Smtp-Source: ABdhPJytqfGNci7XZJDHtajiqlx61hSssQZwDs9hGcFmeZ3WD+smspd9MTVEU3+iJ+bG2oC6MFEP5l4AzMBMrGAduOs=
X-Received: by 2002:a17:90b:1b04:: with SMTP id nu4mr3375909pjb.18.1622115053067;
 Thu, 27 May 2021 04:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210520140158.10132-1-m.chetan.kumar@intel.com>
 <20210520140158.10132-16-m.chetan.kumar@intel.com> <CAMZdPi-Xs00vMq-im_wHnNE5XkhXU1-mOgrNbGnExPbHYAL-rw@mail.gmail.com>
 <90f93c17164a4d8299d17a02b1f15bfa@intel.com> <CAMZdPi_VbLcbVA34Bb3uBGDsDCkN0GjP4HmHUbX95PF9skwe2Q@mail.gmail.com>
 <c7d2dd39e82ada5aa4e4d6741865ecb1198959fe.camel@sipsolutions.net>
 <CAMZdPi99Un=AQeUMZUWzudubr2kR6=YciefdaXxYbhebSy+yVQ@mail.gmail.com> <c7b149f5f3014e02a0b94b11d957cfc73d675ad7.camel@sipsolutions.net>
In-Reply-To: <c7b149f5f3014e02a0b94b11d957cfc73d675ad7.camel@sipsolutions.net>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Thu, 27 May 2021 13:39:09 +0200
Message-ID: <CAMZdPi9Tmz1oD3rcpg3RfrvjwWo8RuiinpmURJF6WpETyumAGg@mail.gmail.com>
Subject: Re: [PATCH V3 15/16] net: iosm: net driver
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     "Kumar, M Chetan" <m.chetan.kumar@intel.com>,
        Network Development <netdev@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Sudi, Krishna C" <krishna.c.sudi@intel.com>,
        linuxwwan <linuxwwan@intel.com>, Dan Williams <dcbw@redhat.com>,
        =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On Thu, 27 May 2021 at 11:40, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> Hi Loic,
>
> > Yes, I guess it's all about timings... At least, I care now...
>
> :)
>
> > I've recently worked on the mhi_net driver, which is basically the
> > netdev driver for Qualcomm PCIe modems. MHI being similar to IOSM
> > (exposing logical channels over PCI). Like QCOM USB variants, data can
> > be transferred in QMAP format (I guess what you call QMI), via the
> > `rmnet` link type (setup via iproute2).
>
> Right.
>
> (I know nothing about the formats, so if I said anything about 'QMI'
> just ignore and think 'qualcomm stuff')
>
> >
> > This a legitimate point, but it's not too late to do the 'right'
> > thing, + It should not be too much change in the IOSM driver.
>
> Agree. Though I looked at it now in the last couple of hours, and it's
> actually not easy to do.
>
> I came up with these patches for now:
> https://p.sipsolutions.net/d8d8897c3f43cb85.txt
>
> (on top of 5.13-rc3 + the patchset we're discussing here)

Great, that looks exactly what we need.

>
> The key problem is that rtnetlink ops are meant to be for a single
> device family, and don't really generalize well. For example:
>
> +static void wwan_rtnl_setup(struct net_device *dev)
> +{
> +       /* FIXME - how do we implement this? we dont have any data
> +        * at this point ..., i.e. we can't look up the context yet?
> +        * We'd need data[IFLA_WWAN_DEV_NAME], see wwan_rtnl_newlink().
> +        */
> +}

Argh, yes I've overlooked that issue. But, do we even need to do
something here? What if we do nothing here and call wwan->ops->setup()
early in wwan_rtnl_newlink(). AFAIU, we don't really use data setup
info until we actually register the netdev, except maybe for the
netdev->txqueue_len. Though it's probably not a robust solution...

>
> or
>
> +static struct rtnl_link_ops wwan_rtnl_link_ops __read_mostly = {
> [...]
> +       .priv_size = WWAN_MAX_NETDEV_PRIV,
>
> are both rather annoying.
>
> Making this more generic should of course be possible, but would require
> fairly large changes all over the kernel - passing the tb/data to all
> the handlers involved here, etc. That seems awkward?

Yes, or alternatively add an optional alloc_netdev() rtnl ops, e.g. in
rtnl_create_link:

-       dev = alloc_netdev_mqs(ops->priv_size, ifname, name_assign_type,
-                              ops->setup, num_tx_queues, num_rx_queues);
+       if (ops->alloc_netdev) {
+               dev = ops->alloc_netdev(ifname, name_assign_type, num_tx_queues,
+                                       num_rx_queues, tb);
+       } else {
+               dev = alloc_netdev_mqs(ops->priv_size, ifname, name_assign_type,
+                                      ops->setup, num_tx_queues,
num_rx_queues);
+       }

That would solve both the issues (setup, priv_size), without entire
kernel refactoring.

>
> What do you think?
>
> The alternative I could see is doing what wifi did and create a
> completely new (generic) netlink family, but that's also awkward to some
> extend and requires writing more code to handle stuff that rtnetlink
> already does ...

That would work indeed, but I would prefer avoiding such 'complexity',
mainly because link management is all we need. Indeed, except if we
want to abstract and handle control protocols (MBIM, QMI, AT) in the
kernel, we should not have to expose additional high-level operations
as in nl80211/cfg80211.

>
>
> Please take a look. I suppose we could change rtnetlink to make it
> possible to have this behind it ... but that might even be tricky,
> because setup() is called in the context of alloc_netdev_mqs(), and that
> also has no private data to pass through. So would we have to extend
> rtnetlink ops with a "get_setup()" method that actually *returns* a
> pointer to the setup method, so that it can be per-user (such as IOSM)?
> Tricky stuff.

What do you think about this alloc_netdev() ops? we should be able to
retrieve all we need from that.

Regards,
Loic
