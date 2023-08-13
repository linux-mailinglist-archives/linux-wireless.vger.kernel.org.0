Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACB277AB2F
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Aug 2023 22:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjHMU1P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Aug 2023 16:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjHMU1O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Aug 2023 16:27:14 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D71113
        for <linux-wireless@vger.kernel.org>; Sun, 13 Aug 2023 13:27:16 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6bcf2fd5d69so3400346a34.1
        for <linux-wireless@vger.kernel.org>; Sun, 13 Aug 2023 13:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691958436; x=1692563236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9/Tn5qt2Wf7Ife4bKoS4OgSQRH1QAM1mXAJ3ffDuVY=;
        b=ivQL1mK3OrU17BWO6tNjUKARYrzncLNp8gTLgLWmLoEz3deDNZ/2mQh/H6JeMiOgdl
         krf6XLAnTKmldo02OOOCH6liYV6cnzH/QcX50hZyU5Y2VZxT7GEg6cX1PeK5xF3CSY1e
         N0A05h5hpe2o/p6sjCFzzxLd7fFrNBsfVMEvFe1a0dAIcOxTXOjfXPBQ2m4ExojFU6zs
         BL6mN1aeYG/a7HobGDMVpfnpRxBNq2JKyf39p/b9G6QvWrG9r9oi6Ke5BG6YnU3sIBFi
         8EVYW/3s/6d2nHXZZZuBBnTB9CzjS8f6FhUOTzyHHmCUB+hiP9hLmE7KYVHpmtBj3dEL
         QYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691958436; x=1692563236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o9/Tn5qt2Wf7Ife4bKoS4OgSQRH1QAM1mXAJ3ffDuVY=;
        b=aD09nDVcTdrD0VIwpu0crNLUHCbBOagTcyhWdJ2DP1a8TuZtbiHeIQTUTtiOZfw6LV
         j0s5Hg+wFJtq+kdzoLcXLtYZFI0as3LdFv9YgVuHpkZ5/5/NzWz8CbRSvGy3L3vZ+0jv
         L/3xmKSIXGVftCmflWn74exeDRzmAPW/iJrgHu+qhiUv7mnWv8N9MNUzmcO2PRRBpgwm
         691sKPiJ/kmDrs+EMvMITtxm2feBhJRk+ZB2YOi92czkdUkUjdSfX+Eb8hgcbkYHKStP
         h7aD76nDKduHET8Vaod6r2MLN+t19fw52eqGk3i5deiwfSwUuFy7bEbO3bCIrl6w+wj4
         iBlQ==
X-Gm-Message-State: AOJu0YwprItVLGSOXBm7qLQ0sWq4Z3nQaFyRYS/XFoSdNfUMS6RISuRT
        XL/c4fL31cKXXWb609Na76wkq249/L+iAUjnajwLDMTy
X-Google-Smtp-Source: AGHT+IEWfdARFoQckecUf9OoQm2rCoDq80PBjn8HUHq2suE+0b42hngeSuw8Pwt3brhqYkWbhtAyPJ+Z13SNkA7gnwg=
X-Received: by 2002:a05:6870:93c8:b0:19f:2c0e:f865 with SMTP id
 c8-20020a05687093c800b0019f2c0ef865mr6407759oal.7.1691958436026; Sun, 13 Aug
 2023 13:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230719194039.16179-1-Chaitanya.Tata@nordicsemi.no>
 <2307e1741e9d32e8f1ffc4e83c73b63a4e32512b.camel@sipsolutions.net>
 <CABPxzYJvAtgbrr_v6cMuKwFjzRjYOCDota+koYp-iogtJS75HQ@mail.gmail.com>
 <CABPxzY+_2DEK-wfAr1V9z1iHZky-7vF24mQx2yFgtFUoTdWgmw@mail.gmail.com> <e3d7cb8b891d1a54ffea60b5f8257208e03129d3.camel@sipsolutions.net>
In-Reply-To: <e3d7cb8b891d1a54ffea60b5f8257208e03129d3.camel@sipsolutions.net>
From:   Krishna Chaitanya <chaitanya.mgit@gmail.com>
Date:   Mon, 14 Aug 2023 01:56:56 +0530
Message-ID: <CABPxzYLp++vabPm9GZheg_UjofkJjm+kQZDRr9HXbX54bxptBQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: Add support for sending BSSMaxIdle in association request
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Aug 11, 2023 at 3:11=E2=80=AFPM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> On Fri, 2023-08-11 at 00:17 +0530, Krishna Chaitanya wrote:
> > On Fri, Aug 11, 2023 at 12:05=E2=80=AFAM Krishna Chaitanya
> > <chaitanya.mgit@gmail.com> wrote:
> > >
> > > On Tue, Aug 8, 2023 at 4:43=E2=80=AFPM Johannes Berg <johannes@sipsol=
utions.net> wrote:
> > > >
> > > > On Thu, 2023-07-20 at 01:10 +0530, Chaitanya Tata wrote:
> > > > > When WNM is enabled, a station can send its preferred BSS maximum=
 idle
> > > > > period in the association request, add a new netlink attribute to=
 get
> > > > > this value from the supplicant and add BSS maximum idle IE in the
> > > > > association request.
> > > > >
> > > >
> > > > I don't see anything here that even requires all this code, rather =
than
> > > > wpa_s just including the element itself in the association request =
extra
> > > > IEs?
> > > Yeah, WPA supplicant can prepare this, please ignore, thanks.
>
> > Just remembered why I had to implement this in kernel, the associate/co=
nnect
> > data structure in wpa_s `wpa_driver_associate_params` doesn't have any
> > ies/extra_ies, it only gives wpa_ie and rest all are parameters for mac=
80211
> > to use. So, had just extended this as well, do you think we should add
> > this ies/extra_ies
> > to the association like we do for scan? Or as MLME is in mac80211,
> > just use this patch as is?
>
> Not sure I follow all that reasoning - is that something internal to
> wpa_supplicant? Fundamentally with my cfg/mac hat on I'm not sure I care
> so much about wpa_s internal data structures?
>
> Things like extended capabilities are also added to the "extra IEs" by
> wpa_s, so surely this would work too?

I was only pointing out that AFAIK there is no mechanism to pass "ies" in
the associate command from userspace, except for WPA IE.
