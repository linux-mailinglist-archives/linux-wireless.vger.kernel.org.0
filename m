Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5AC52AC08
	for <lists+linux-wireless@lfdr.de>; Tue, 17 May 2022 21:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352792AbiEQTdY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 May 2022 15:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352797AbiEQTdS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 May 2022 15:33:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65E74522DD
        for <linux-wireless@vger.kernel.org>; Tue, 17 May 2022 12:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652815995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+1sB48ou7sq4iG5odbW5UgPnDZdHq+eVYauDlKBiRrs=;
        b=S463gJCBWFlvOXD5DmJehN0IxcF2rgSDzJByhhg0VPsfxkq4iZaJVTuE+k9HgLy5DAJaYg
        Al/FB5np77IXpON5MDaYZxLRAlSpCoSORPQltRuGQvtXcq7d7DpfWZYMK5oBmixIIUR5sv
        /bYZ1F1rnfGxKQtgTAGmPzvbNVINxRg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-369-3ep1lnnzOCqVwzhGVcBQyg-1; Tue, 17 May 2022 15:33:14 -0400
X-MC-Unique: 3ep1lnnzOCqVwzhGVcBQyg-1
Received: by mail-qv1-f69.google.com with SMTP id 11-20020a0562140d0b00b0045aac32023fso15614074qvh.19
        for <linux-wireless@vger.kernel.org>; Tue, 17 May 2022 12:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+1sB48ou7sq4iG5odbW5UgPnDZdHq+eVYauDlKBiRrs=;
        b=3GVgO5vSVKeXmONZV8FZOHWLrxBVtCP9PAgvjl51ucW8ANYOIvw3OsvkD4oTQ0PDH7
         5h2UzLwFKj1fpZbQZJBTYAeDM2cx3x4ITveLaRemYlOvgbWGYIp7MfJFed++KX2GKFzl
         kl1+P+ZMtYr/nI3fU/OPryti98jZfxTrJjASagBXCqv49N9uKC5jP3wau8hv7GCuDrDd
         64/dbWf7nf6hyo8C6sylAnSHOx1RqOOT4Aeyi7c9NhnR5h5IGcpV07KUm7zq/6RYtHz2
         LNDy+1A/ztPdC8e3vDjBzq5rJ3TR4ZRIDBUZX82OrG1WtcJV0JRvkawtn8d5WHDfoCNT
         Fekw==
X-Gm-Message-State: AOAM532x2jPPvM4oFoGyJk88Cv+3mD0ZyyIFC3bibqGunVMpJZ2l0hbJ
        TuSyHl1Msvy6xTQR+aeh5TdyutXAlIxyZAXn9TQwAstwgHUDjsNk1eS8ptbDiXsq0SUajfT/4sh
        TUGLpxcT7Wm1fZKXCzNlK2C36ahf+FwOxdszsxrCBzXM=
X-Received: by 2002:a05:620a:40c2:b0:6a0:2b1b:2b86 with SMTP id g2-20020a05620a40c200b006a02b1b2b86mr17543588qko.80.1652815993429;
        Tue, 17 May 2022 12:33:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyErJA1QMczBYTs9gR2mpRT35GolnnXP55O3949L3bTONuRk5dupXTRdiVJjTkve0f85GDa08PrMhPUDoaknLI=
X-Received: by 2002:a05:620a:40c2:b0:6a0:2b1b:2b86 with SMTP id
 g2-20020a05620a40c200b006a02b1b2b86mr17543569qko.80.1652815993241; Tue, 17
 May 2022 12:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220516215638.1787257-1-kuba@kernel.org> <8e9f1b04-d17b-2812-22bb-e62b5560aa6e@gmail.com>
In-Reply-To: <8e9f1b04-d17b-2812-22bb-e62b5560aa6e@gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 17 May 2022 15:33:02 -0400
Message-ID: <CAK-6q+jRDMDGbNS2JkTXmW2dp6D7mGzZ6ghrjf7m-wp7Xo9weQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ifdefy the wireless pointers in struct net_device
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        edumazet@google.com, Paolo Abeni <pabeni@redhat.com>,
        johannes@sipsolutions.net, Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc,
        sven@narfation.org, linux-wireless@vger.kernel.org,
        linux-wpan - ML <linux-wpan@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Mon, May 16, 2022 at 10:13 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
>
> On 5/16/2022 2:56 PM, Jakub Kicinski wrote:
> > Most protocol-specific pointers in struct net_device are under
> > a respective ifdef. Wireless is the notable exception. Since
> > there's a sizable number of custom-built kernels for datacenter
> > workloads which don't build wireless it seems reasonable to
> > ifdefy those pointers as well.
> >
> > While at it move IPv4 and IPv6 pointers up, those are special
> > for obvious reasons.
> >
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>
> Could not we move to an union of pointers in the future since in many
> cases a network device can only have one of those pointers at any given
> time?

note that ieee802154 has also functionality like __dev_get_by_index()
and checks via "if (netdev->ieee802154_ptr)" if it's a wpan interface
or not, guess the solution would be like it's done in wireless then.

- Alex

