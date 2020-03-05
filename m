Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14024179EA5
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2020 05:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgCEEhx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Mar 2020 23:37:53 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46737 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgCEEhx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Mar 2020 23:37:53 -0500
Received: by mail-lf1-f68.google.com with SMTP id v6so3402775lfo.13
        for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2020 20:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t2NH86lH1DI/On0AefQ9vdB8vQNR37Hyb66yqqiKK9w=;
        b=iylATBPgLeRW8zT14gwN4uEbnKpONggVIenAcFarCgI87I7oWndJpa55z2OS7w94lN
         GZAXFFiZGGdlT/IiFD7Wb1JdAWlL0UUC6fqZbjfZbYFnUAHhKiAq33GBRvT5WMEhAtRF
         yWRf3IOYI/FImd9zdLUH9PIO0cWM4Ix/PApY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t2NH86lH1DI/On0AefQ9vdB8vQNR37Hyb66yqqiKK9w=;
        b=HLLUyk7m/FrJqas/GQNbLCh3tnQAKLlU6WlVfLjpyQkFJcg+kTVjEHAy82KYckDTEC
         /lmHTZvuDbUZ6A/MPP9FNYiEdi7nmZTWspeFXvDawSozSBMCWLNG5RKC9cMpohhEAJOZ
         OtwLfieCexdQWBXrYiqCMHIm7Kduf6D8qNkOsZAMbTVwoasU/X35dk6eyZwwR0WaIGr5
         GP78F1cvPCqdwr3mJgg0+wnb6LsVPnWZfGIUHb7XvSpra68Hc1OtdC6El+rObHhGWyke
         VdCNKDd4nSGeMq6gBkFFVlEaFDc6XdUvcqDK/5ruAyNl2qhb1g8dGT2Kt31Eh5TEtL5O
         1k8g==
X-Gm-Message-State: ANhLgQ2Wl6uhWJGnYtxORJz8baK/8Pvm80Fy8d25x60R+fODCmZ0THoX
        w/FjqXWh2Q3JjKZodHz5wJvyvBdE6LA=
X-Google-Smtp-Source: ADFU+vsjNeJvHsVhsQofnihhUnF04RIzjR3mnr+lUitK/CJsBuYYn0QSdavlQfHU78E1s5rEe51dcQ==
X-Received: by 2002:a05:6512:692:: with SMTP id t18mr4090474lfe.212.1583383070743;
        Wed, 04 Mar 2020 20:37:50 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id t7sm14767819ljo.7.2020.03.04.20.37.49
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 20:37:49 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id v6so3402726lfo.13
        for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2020 20:37:49 -0800 (PST)
X-Received: by 2002:a19:4cc4:: with SMTP id z187mr4069381lfa.49.1583383068980;
 Wed, 04 Mar 2020 20:37:48 -0800 (PST)
MIME-Version: 1.0
References: <20200227000511.256055-1-briannorris@chromium.org> <DB7PR04MB524240B38FF6603D89D694538FE20@DB7PR04MB5242.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB524240B38FF6603D89D694538FE20@DB7PR04MB5242.eurprd04.prod.outlook.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 4 Mar 2020 20:37:36 -0800
X-Gmail-Original-Message-ID: <CA+ASDXNvjJLzH+_0g1OUNckmRoLyNJVwiAg9=OPwd7LGk-E2Cg@mail.gmail.com>
Message-ID: <CA+ASDXNvjJLzH+_0g1OUNckmRoLyNJVwiAg9=OPwd7LGk-E2Cg@mail.gmail.com>
Subject: Re: [EXT] [PATCH] mwifiex: set needed_headroom, not hard_header_len
To:     Ganapathi Bhat <ganapathi.bhat@nxp.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Arend Van Spriel <arend@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Ganapathi,

On Wed, Mar 4, 2020 at 8:00 PM Ganapathi Bhat <ganapathi.bhat@nxp.com> wrote:
> > hard_header_len provides limitations for things like AF_PACKET, such that
> > we don't allow transmitting packets smaller than this.
>
> OK; However, are we not supposed to mention hard_header_len also?

No, my understanding is that we do not need to bother with
hard_header_len ourselves -- ether_setup() establishes the appropriate
L2 header parameters. I think that's covered a little better below.

> > This is the essentially the same bug (and fix) that brcmfmac had, fixed in
> > commit cb39288fd6bb ("brcmfmac: use ndev->needed_headroom to reserve
> > additional header space").
>
> OK; I read this commit:
>
> "... According to definition of LL_RESERVED_SPACE() and hard_header_len, we should use hard_header_len to reserve for L2 header, like ethernet header(ETH_HLEN) in our case and use needed_headroom for the additional headroom needed by hardware..."

Yeah, that's probably a little more verbose and accurate description,
which is partly why I referred to that commit :)

> So, does it mean, hard_header_len is already considered by upper layer?

Right, it's set by ether_setup().

Brian
