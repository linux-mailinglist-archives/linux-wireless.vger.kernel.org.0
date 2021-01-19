Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81AD22FC3BB
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Jan 2021 23:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387605AbhASOg1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Jan 2021 09:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389396AbhASKDk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Jan 2021 05:03:40 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E1DC061757
        for <linux-wireless@vger.kernel.org>; Tue, 19 Jan 2021 02:02:59 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id d13so35166073ioy.4
        for <linux-wireless@vger.kernel.org>; Tue, 19 Jan 2021 02:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7L3sZXwRHIpVGKeGthU15hEuDgHxM9YUe2i8FEz3+gs=;
        b=QGc5x3VhQAJwu9nD5rJcKEp7vy4eTMIP/DLoZvlgiuzey24WjILHwG/xbnAmw+fX+s
         A0iieuCNoXFpIpT2nt9Z10PuJTcPQjCaiqHLC5+pxUD1LaEbdxjvd8dQD9nCMr72p86z
         cJpfXQsNy6ErQa0k1l/udkHM2S+WCtQPyqjkTpXZjl8GthPLHEq5RsoBuphWYrY9ObKn
         qNsVkZeEBHrZQXLGrmYwIsXete6eSacpg77CUrIWndGErafoKhSI+rqqVNWj+7idr9rc
         jeqXH7GhLljBVNu2Ob5/ZMG84SvflkaULxL9utzFy9ASFoFiXA2il+dbFoKoyRiZZCp3
         woyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7L3sZXwRHIpVGKeGthU15hEuDgHxM9YUe2i8FEz3+gs=;
        b=FFM+vDHUFCwp/YMr9sVosQ9ZFhLpezolzC6VfHOdv6MlHqfkKWRwkquarOtgHKIs/n
         WRhUzT5V2N5FPwHLlps/aqb8CQdVArv2KLVqfv5T8lXtimc7FOP7ZFS/ZTf5ZeCnK/mN
         E4T8j+T2qE9dj76yhfOOAPGSTJINiG/QTLOKMTds5D4je2NgnWJT0iTcp9UQ+BcykId7
         vq9ckD6jWWkbteBCGXDs136NztDypiVyAc85xnZfV/erCVvVsbhxa+a1rK1EGLWnTtIW
         ofbQTGINYG6+e/zjvs7YdVA6aCVbQBAbnSDv3qTU51YcdIeJ9WEm2eig7Ah7b3XSThjX
         V6PA==
X-Gm-Message-State: AOAM533fCR3TyNHwS0Npd0UYQywIu9Xluwa17OfPLZ1lt01ps+JSzcmf
        66Sn40xPRnJodwxT/00nRgINLgGri97eyyRXAQV35A==
X-Google-Smtp-Source: ABdhPJzJFqOALKVpKAZAZX8QjvCsPOaDOUqDydlCGkCxthSCtEcAnOjgoR+7aNvkIFDuQy9vC4C2eqtTcd8mtFBdaRI=
X-Received: by 2002:a92:d3c7:: with SMTP id c7mr2711479ilh.137.1611050578589;
 Tue, 19 Jan 2021 02:02:58 -0800 (PST)
MIME-Version: 1.0
References: <5664fa0f-aef2-c336-651a-093c9eed23ab@candelatech.com>
 <765f370d-ce2d-b75a-2dde-87f69ae7c185@candelatech.com> <CANn89iKpa1y2SKJuR9kRi=AZs94sj+-tzRs+2D0vmxh+ahEcGA@mail.gmail.com>
 <adbee2ec-c6ba-7a17-eb98-1c53365fa911@candelatech.com> <CANn89iJQnSVZFp2XDgREN1QMtU4exOsnJq=5VzJ6tqTCJ7MH-g@mail.gmail.com>
 <c4bcee7d-b2eb-759c-c659-d65f3e7daec9@candelatech.com> <CANn89i++Kgkj57ms70a5GDOQ-Cpewx3NQkzP3EmZmLYQ4eHzww@mail.gmail.com>
 <5d89fd24-f00a-7e70-00ce-83529f13b05e@candelatech.com> <20201218121627.603329b2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <9003ea3720a03b4bd1b8abf3d8f645563a58f953.camel@sipsolutions.net>
 <43a5b45c-955a-22d4-2bf9-dbab852dbb5f@candelatech.com> <CANn89iJBO13s9fOVRnDyfj5HXt9wjnRpbh2_f5SuyNkNAfjzJQ@mail.gmail.com>
 <CANn89iJTCDof6ypxCkiGaPo+y0Bngg0NX5cLPWisTEZaFo1BQw@mail.gmail.com>
 <CANn89iJWG2n1s3j7EdpwkQQv-9dOY02V+FGYHAWguO4JiqWuJA@mail.gmail.com> <d75b2c43a416d4bb84185aab4005d42e49962e36.camel@sipsolutions.net>
In-Reply-To: <d75b2c43a416d4bb84185aab4005d42e49962e36.camel@sipsolutions.net>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 19 Jan 2021 11:02:47 +0100
Message-ID: <CANn89iLZ9Y0fMk8X1a4=J7Xf2H=M0oLK_SekOLZypN+2-8a0yw@mail.gmail.com>
Subject: Re: net: tso: add UDP segmentation support: adds regression for ax200 upload
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Ben Greear <greearb@candelatech.com>,
        Rainer Suhm <automat@posteo.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Luca Coelho <luciano.coelho@intel.com>,
        netdev <netdev@vger.kernel.org>, linux-wireless@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Jan 19, 2021 at 9:53 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> Hi Eric, all,
>
> Sorry we've been so silent on this.
>
> > --- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
> > @@ -773,6 +773,7 @@ iwl_mvm_tx_tso_segment(struct sk_buff *skb,
> > unsigned int num_subframes,
> >
> >         next = skb_gso_segment(skb, netdev_flags);
> >         skb_shinfo(skb)->gso_size = mss;
> > +       skb_shinfo(skb)->gso_type = ipv4 ? SKB_GSO_TCPV4 : SKB_GSO_TCPV6;
> >         if (WARN_ON_ONCE(IS_ERR(next)))
> >                 return -EINVAL;
> >         else if (next)
> > @@ -795,6 +796,7 @@ iwl_mvm_tx_tso_segment(struct sk_buff *skb,
> > unsigned int num_subframes,
> >
> >                 if (tcp_payload_len > mss) {
> >                         skb_shinfo(tmp)->gso_size = mss;
> > +                       skb_shinfo(tmp)->gso_type = ipv4 ?
> > SKB_GSO_TCPV4 : SKB_GSO_TCPV6;
> >                 } else {
> >                         if (qos) {
> >                                 u8 *qc;
>
> This does fix the problems reported on iwlwifi, were you planning to
> submit it as a proper patch?

Sure, I will do, thanks !
