Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373E826CE5B
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Sep 2020 00:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgIPWIM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Sep 2020 18:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgIPWH7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Sep 2020 18:07:59 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50599C061223
        for <linux-wireless@vger.kernel.org>; Wed, 16 Sep 2020 14:32:02 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id x20so85474ybs.8
        for <linux-wireless@vger.kernel.org>; Wed, 16 Sep 2020 14:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=761IcqWmFjbjqvUtUTtc0WPwUOML3qXtRAVU21kD73k=;
        b=a+WENrWJvsrKgUasDIsti54O809lSg0RXGXcMgWt/EC4fm0ut9QnpCnEyJ2bF/jwG2
         QiVaZAX8qEokkSLZIwxWRUUHHUllFIw7MhAEUDuq5ZYEpK9lUytzCCnJhG74TqRr/yOA
         UWwgrpO8/+0E9xTUHh9jLDdB9pGNXR7EJaul7UXzmd+DcsWmgN15rdUq08wombL/ZAfG
         GTEYrXZhRqh5hUO68doxqDBw/Zl54KeQinJHS6hO4rb6NdtFgPnzUWcA+QajqmvBrThm
         KHxdzQSDi+aIl1wE7tVtJWh4qqFf5WA2/HxX0hNA5eOkD+77qA5JkVhACT24dKB6bDU1
         z5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=761IcqWmFjbjqvUtUTtc0WPwUOML3qXtRAVU21kD73k=;
        b=cDunRHu8iVtlKvZOPIZU+mOgNRNvLz9KWDYWeFyvCOhVHbLsFI+zpZ/D18iW6GhSK4
         ba61xMB+8Z06E6NfLXqBHJl8ZtcM7PqizoNWrncIu37Q845LT1meTuocaCjX4xrXXCOa
         DNUbcRgOMBPE6EebRPYpA6KbLoq/o6xwUbxoHGXNUaVnLKZ9+nd1338KL1WcJrl/ii2F
         bvJPzaz8/uWTfyrkcbmC1smLceQ4LJ4/BB2kotJT7BOx/IL25DxGIy4hRXIAlOPgdg7S
         YRjehVJ5PEIqvAiTZHXJQ4o+VA5DoShaKpFnnxkzQzk8TSzw0sv2jBYBdjgMY3CsjX4w
         dAaA==
X-Gm-Message-State: AOAM530vhJeE5kVdesohyfe+AdDVQRmeClPMDg9aCOWt3Kt9nfbpO/7Q
        w/8Q/PUm7Rqq4JJh02IF6dH9CKr+9tRxOvCJV6UZ7MczmIY=
X-Google-Smtp-Source: ABdhPJxd7LRUjsrsROEc4jaEFDosBv0f7inWto8U0OkZ3Adgh+KqC7WGVmNBGUHs5fVgysClLgopr7gpvbcfRdOtQ6I=
X-Received: by 2002:a25:8110:: with SMTP id o16mr36210006ybk.14.1600291921640;
 Wed, 16 Sep 2020 14:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAD_iCC8EyWV8bLdJ+VsRdMHOa6ccOOOOUMM6nMwDk16LtMppcg@mail.gmail.com>
 <PR2PR08MB464983615CFB2AF2B3BCD644D12E0@PR2PR08MB4649.eurprd08.prod.outlook.com>
 <CAD_iCC-=rvC6mC8pOKNKqrrWQv2wt9BXVMQB2DR1QKcGp_KbiQ@mail.gmail.com>
 <CABPxzYJ=vJB4pnCC__G6Luhdp_m51Z_nKq80HFxEfN6cdsKQbw@mail.gmail.com>
 <CAD_iCC-koZwPCew4+n4nk8Ou_jWC2BxxcSDy_rf9KnO4Q=MO=g@mail.gmail.com>
 <CABPxzY+tfkjKETjdKJE7AjY6ELFfsLw4utVWOfXwxuV4C+RK8w@mail.gmail.com>
 <CAD_iCC-=9XU-DbfUorUtSRzCOEW=gr83T8ZSMvJn_xFgoMWvew@mail.gmail.com>
 <CABPxzYJmL7x1Hfx9Yf+4XT6xngWNmYC9ZGGvDYqLo7y2bNtCow@mail.gmail.com>
 <CAD_iCC9Vu55FG5vHSWF=H8v-ZZKQoyin8B-1zBtaJ+2MeJqCjg@mail.gmail.com>
 <CABPxzYKVK3OK6nKMrLrBfdy-Yz1v_bbyhHHLCkxnFzWtFBSGaA@mail.gmail.com>
 <CAD_iCC8XDNXfDmghhXyK8auFg5WinqaACpbpbiZ4g0toaDoeiw@mail.gmail.com>
 <CABPxzYK-HN-Q3wREn+6qAkiHAnkuyqz-g6m9XpUtaMd8ckHQPg@mail.gmail.com>
 <CAD_iCC-LMnDeL-e-i2GPYe9fRruWxkKvHEsNGDERv2j8eN1YFw@mail.gmail.com>
 <CABPxzYJVwjPGrHitstWkgiL+kEB9AeTMy_e5nu7FNXVv4ZNk-A@mail.gmail.com>
 <CAD_iCC_1TV_wQK+xOWk48eaJhWo82CZgTL-g4jg7tOdVxvqEZw@mail.gmail.com>
 <CABPxzY+2OO6nptyE+oH+COLe3pVgKhji=H1trP7m_bcpVqEe7Q@mail.gmail.com>
 <CAD_iCC-x9J4UB5aVR85WNi4OwaXQiU28+4B1AD176zDu8DBhwQ@mail.gmail.com>
 <CABPxzY+oy=p4QLHfyVMprigHOpTJEJGsJ-Bsti5b9Ly=eDy+cQ@mail.gmail.com>
 <CAD_iCC-mCo58fs1v+bqyB=NRXkQDTa20R=NGe+SwTP2s7NPfOA@mail.gmail.com>
 <CABPxzYKckJ94+96YsTY4Y7D7_z-Pk=b+T1tvu5BzaoVjVi0apw@mail.gmail.com>
 <CAD_iCC8StVW7Yh9f8fm2Da7LcN6LQzR=ssp+1E8-=YYCM-5tOQ@mail.gmail.com>
 <CABPxzYKFUN-hyhJnxG_-EcD0L0bsp8rn+b+tyt_ReAf11vzKng@mail.gmail.com>
 <fd8fafe85f2d75a2563e5be766cce1f45424e2bf.camel@sipsolutions.net> <CABPxzYLEZ5KU5x3w9rex3SQqj+TwGXFOXnC_QXdEu9NLfcRHMQ@mail.gmail.com>
In-Reply-To: <CABPxzYLEZ5KU5x3w9rex3SQqj+TwGXFOXnC_QXdEu9NLfcRHMQ@mail.gmail.com>
From:   Krishna Chaitanya <chaitanya.mgit@gmail.com>
Date:   Thu, 17 Sep 2020 03:01:50 +0530
Message-ID: <CABPxzYKPHXtJHP4FhdrtJ763ZeHwf4bjyPOr5c7g_88r_pSdLQ@mail.gmail.com>
Subject: Re: Configuring WiFi6 in hostapd
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Sugandh Huthanahally Mohan <sugandhgowda@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luciano Coelho <luciano.coelho@intel.com>,
        Cedric Izoard <Cedric.Izoard@ceva-dsp.com>,
        "Hostap@lists.infradead.org" <Hostap@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Sep 12, 2020 at 12:56 AM Krishna Chaitanya
<chaitanya.mgit@gmail.com> wrote:
>
> On Fri, Sep 11, 2020 at 10:41 PM Johannes Berg
> <johannes@sipsolutions.net> wrote:
> >
> > On Fri, 2020-09-11 at 20:37 +0530, Krishna Chaitanya wrote:
> >
> > > > [  228.315290] iwlwifi 0000:03:00.0: 0x00002078 | ADVANCED_SYSASSERT
> > > > [  228.315294] iwlwifi 0000:03:00.0: 0x00A0A200 | trm_hw_status0
> > > > [  228.315297] iwlwifi 0000:03:00.0: 0x00000000 | trm_hw_status1
> > > > [  228.315300] iwlwifi 0000:03:00.0: 0x004F8E3C | branchlink2
> > > > [  228.315303] iwlwifi 0000:03:00.0: 0x004E4FF4 | interruptlink1
> > > > [  228.315307] iwlwifi 0000:03:00.0: 0x004E4FF4 | interruptlink2
> > > > [  228.315310] iwlwifi 0000:03:00.0: 0x07000101 | data1
> > > > [  228.315313] iwlwifi 0000:03:00.0: 0x48308403 | data2
> > > > [  228.315316] iwlwifi 0000:03:00.0: 0x00000005 | data3
> >
> > This means that we got an invalid TX rate, notably an HE rate was
> > requested/configured on a MAC configuration that didn't have HE.
> >
> > I think I saw some patches in this area (configuring the MAC to be HE)
> > fly by internally recently, but not sure... Luca probably knows.
> Ah okay. This was reported on 5.4 kernel, do you think is it worth
> trying on latest iwlwifi-next tree? Or as you are referring to the internal tree
> the issue is present in the latest as well?
Hi Luca,

Can you please take a look? Any help is appreciated.
