Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD36B28F928
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Oct 2020 21:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391455AbgJOTEy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Oct 2020 15:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730089AbgJOTEx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Oct 2020 15:04:53 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF335C0613D2
        for <linux-wireless@vger.kernel.org>; Thu, 15 Oct 2020 12:04:52 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id t15so1136272ual.6
        for <linux-wireless@vger.kernel.org>; Thu, 15 Oct 2020 12:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FsqHAs58x4trJhhHbsTmRDV/y8bm/KqBtxUEW7L/rUE=;
        b=YNNWaoUtxTP/GIofNOCaOHVKhI6pyeffEbAmx886qQVLDGA3jsArPDvJf/qbzSWmCc
         C5JfSYJSVtYWs6UJQCeHi99QiHWdoFYMYViyrs4GkHdbebB9lvRoT5MsmnuVEbrv5sQ5
         xyBdn1KZD+RztL6gagqXOC5GBULxTxnMWP+g3mewAA2K+kcEaPCupv4dBfWaESKTZ0q4
         F/jljeAcNeIyh+7o++HQGpupYtGu3HVDJc3LL7YW5gHdbei4cJBlby+rSSR2WQbMITIL
         Y200lB9YcKNGyyeCJEg3TIV4W7HQoW+8SvWycOmJ5NiqvujbAt6k1iobSf04Y5uPkCOq
         SULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FsqHAs58x4trJhhHbsTmRDV/y8bm/KqBtxUEW7L/rUE=;
        b=fuaZtU15QX1GWPNxLhb5HeNvbacBI8Ir3r4NYbFukAZFhGJBAk+b6euw2Vl1lq8xE3
         CMGRljlqGfgQxTgh9LiWlU4bgG6HluHLTsuXSZpOPZSZ4ViTJxkFwRhggFBvTZDtQHun
         j5Rd7AXd4tl9W5CUpg68Umh9UlXr9iyhQmIF4Y+pgkg7wAJXJWp3mhTKhAJ72ZR5CzpE
         f37MnUVMfW2wON1cfTudm2onT8Cvzuv/oAqo3BIL0j0gRSA+9aOC6JLCFzT+jdyHvAxH
         7rNMRoZ4iwRHf8qavEqWWhSFIkonaOukukR9+tTfF1eSIB4G+GSm6BeaQiNtda8rlfZ/
         cgHw==
X-Gm-Message-State: AOAM533UENAQftYineD6BePvVggCXcWsSKA2p2L2SanxWK1Pt1vpF2du
        miTsAkup/85aHHFydAjw6sAqAMDOMJQ=
X-Google-Smtp-Source: ABdhPJx7WgV1VDDyz+rnwGzH9uQo2iwVrmh8Qz0ngrnTseUwdg+GpbukOvipp6YRzKMaFXYdE2ILKg==
X-Received: by 2002:ab0:384a:: with SMTP id h10mr76019uaw.132.1602788690075;
        Thu, 15 Oct 2020 12:04:50 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id l23sm15466uap.7.2020.10.15.12.04.48
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 12:04:48 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id r1so44898vsi.12
        for <linux-wireless@vger.kernel.org>; Thu, 15 Oct 2020 12:04:48 -0700 (PDT)
X-Received: by 2002:a67:d84:: with SMTP id 126mr3522829vsn.51.1602788688034;
 Thu, 15 Oct 2020 12:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <20201007101726.3149375-1-a.nogikh@gmail.com> <20201007101726.3149375-2-a.nogikh@gmail.com>
 <20201009161558.57792e1a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CACT4Y+ZF_umjBpyJiCb8YPQOOSofG-M9h0CB=xn3bCgK=Kr=9w@mail.gmail.com>
 <20201010081431.1f2d9d0d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CACT4Y+aEQoRMO6eA7iQZf4dhOu2cD1ZbbH6TT4Rs_uQwG0PWYg@mail.gmail.com>
 <CADpXja8i4YPT=vcuCr412RYqRMjTOGuaMW2dyV0j7BtEwNBgFA@mail.gmail.com> <20201013095038.61ba8f55@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201013095038.61ba8f55@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 15 Oct 2020 15:04:11 -0400
X-Gmail-Original-Message-ID: <CA+FuTSf2kfvdYydXYJNCCfE62q9DXXOBMh_ZSO5W=L9GK478HA@mail.gmail.com>
Message-ID: <CA+FuTSf2kfvdYydXYJNCCfE62q9DXXOBMh_ZSO5W=L9GK478HA@mail.gmail.com>
Subject: Re: [PATCH 1/2] net: store KCOV remote handle in sk_buff
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Aleksandr Nogikh <a.nogikh@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        David Miller <davem@davemloft.net>,
        Johannes Berg <johannes@sipsolutions.net>,
        Eric Dumazet <edumazet@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Aleksandr Nogikh <nogikh@google.com>,
        Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Oct 13, 2020 at 12:50 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Tue, 13 Oct 2020 18:59:28 +0300 Aleksandr Nogikh wrote:
> > On Mon, 12 Oct 2020 at 09:04, Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > On Sat, Oct 10, 2020 at 5:14 PM Jakub Kicinski <kuba@kernel.org> wrote:
> > > >
> > > > On Sat, 10 Oct 2020 09:54:57 +0200 Dmitry Vyukov wrote:
> > > > > On Sat, Oct 10, 2020 at 1:16 AM Jakub Kicinski <kuba@kernel.org> wrote:
> > [...]
> > > > > > Could you use skb_extensions for this?
> > > > >
> > > > > Why? If for space, this is already under a non-production ifdef.
> > > >
> > > > I understand, but the skb_ext infra is there for uncommon use cases
> > > > like this one. Any particular reason you don't want to use it?
> > > > The slight LoC increase?
> > > >
> > > > Is there any precedent for adding the kcov field to other performance
> > > > critical structures?
> >
> > It would be great to come to some conclusion on where exactly to store
> > kcov_handle. Technically, it is possible to use skb extensions for the
> > purpose, though it will indeed slightly increase the complexity.
> >
> > Jakub, you think that kcov_handle should be added as an skb extension,
> > right?
>
> That'd be preferable. I understand with current use cases it doesn't
> really matter, but history shows people come up with all sort of
> wonderful use cases down the line. And when they do they rarely go back
> and fix such fundamental minutiae.
>
> > Though I do not really object to moving the field, it still seems to
> > me that sk_buff itself is a better place. Right now skb extensions
> > store values that are local to specific protocols and that are only
> > meaningful in the context of these protocols (correct me if I'm
> > wrong). Although this patch only adds remote kcov coverage to the wifi
> > code, kcov_handle can be meaningful for other protocols as well - just
> > like the already existing sk_buff fields. So adding kcov_handle to skb
> > extensions will break this logical separation.
>
> It's not as much protocols as subsystems. The values are meaningful to
> a subsystem which inserts them, that doesn't mean single layer of the
> stack. If it was about storing layer's context we would just use
> skb->cb.
>
> So I think the kcov use matches pretty well.

skb_extensions was the first thing that came to mind when I read this
patchset too. It is not specific to protocols.

We have long stopped growing sk_buff size.
