Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11AC77C1AD
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Aug 2023 22:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjHNUqH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Aug 2023 16:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjHNUqG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Aug 2023 16:46:06 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F110D1
        for <linux-wireless@vger.kernel.org>; Mon, 14 Aug 2023 13:46:05 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-5633b7e5f90so3450691eaf.1
        for <linux-wireless@vger.kernel.org>; Mon, 14 Aug 2023 13:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692045965; x=1692650765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60kCd4I5U6yzx9+Qb2B62bu9EUOqliaFCx5IKGWLsK8=;
        b=aKhEjrzNALJ+RrNtiArKyrAD5yeEaCLac8ATUM/aNsd4KoAVxuTA2hb892y+XaTKs0
         M0+47IQR/4CeOl+mOerTc3tUbi/UH2ddxOu/rErMMPM83ejYwcS153H/C9McqFaWIXa2
         KejBPxwi9OISF7n0nJUn18OzvcPXIyBNj0CrMIpN/R/iSPHhBHgLJ4r3x9wqlzPahgEK
         wDRPUwnuo9poKkVYiw9sW6OpieRFI7iSYd6c+u7fOokPW/WtSiFp/tKthNVjQeO9fWAM
         uRmug23bN0pLwxsg7u+RVTJ9MeG1NFtKivVqlK1OSXFLXODGb/RkQgyx+wFifBzy/xa2
         6N6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692045965; x=1692650765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60kCd4I5U6yzx9+Qb2B62bu9EUOqliaFCx5IKGWLsK8=;
        b=diVwIK8WG7gRN75xZ6GcAnn9dDqiS3Hg7Cp3RxIKeh93tg3GgZ5aBJx0h7hiczAvRC
         gUF0JyaYXLe7q7btkkVl+z4okyrkRtc9GmXVpObnWLLk1vwXh03R5BoKJASxCo+Ewboq
         t9G8gWeoLrGrxb4KudkIFiRTVndxkFLi4bsvDMc7hvnIHtHa31G5FpsBi5OxmFjEN2mS
         zd1uSYPIEklbP+Cs+8zdnK89Sel4GW+veVlRHfm4AXnCjLnIiO3PLgY2W38ttr+oihp7
         CFrTbJR+nz/MJ8izIBkF+1bYgSqVz0VKkFUsVI2rzukbugOf2CMllAuFCz4xlIXTpgCh
         W7vA==
X-Gm-Message-State: AOJu0YysEz5ZCWiYl2VC2Hj7z4GKrIufTu1x50cEBcL7uKh0tmjNNhT3
        y+zN4yq5wYjO0owVX5Wcd3+gejnO9JrW73jILSy5D1qb
X-Google-Smtp-Source: AGHT+IH5u7fiutup6tdOh07LEXb/ehDW7F1Fj3FfSUcDXWdLh0+wDK0K6+MFUZzSajhhcW6vfMvcYVddOVoTF/2uEnw=
X-Received: by 2002:a05:6870:d0c4:b0:1bf:1a38:283b with SMTP id
 k4-20020a056870d0c400b001bf1a38283bmr10512210oaa.9.1692045964768; Mon, 14 Aug
 2023 13:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230719194039.16179-1-Chaitanya.Tata@nordicsemi.no>
 <2307e1741e9d32e8f1ffc4e83c73b63a4e32512b.camel@sipsolutions.net>
 <CABPxzYJvAtgbrr_v6cMuKwFjzRjYOCDota+koYp-iogtJS75HQ@mail.gmail.com>
 <CABPxzY+_2DEK-wfAr1V9z1iHZky-7vF24mQx2yFgtFUoTdWgmw@mail.gmail.com>
 <e3d7cb8b891d1a54ffea60b5f8257208e03129d3.camel@sipsolutions.net>
 <CABPxzYLp++vabPm9GZheg_UjofkJjm+kQZDRr9HXbX54bxptBQ@mail.gmail.com> <a998334c11f8cd2d2f3d4d6b6883f9c0f699cd2c.camel@sipsolutions.net>
In-Reply-To: <a998334c11f8cd2d2f3d4d6b6883f9c0f699cd2c.camel@sipsolutions.net>
From:   Krishna Chaitanya <chaitanya.mgit@gmail.com>
Date:   Tue, 15 Aug 2023 02:15:45 +0530
Message-ID: <CABPxzYKBQuYzeRKjsNPTkmtLauGEyY1jg+T_dt2SK2u_BMB1qA@mail.gmail.com>
Subject: Re: [PATCH] wifi: Add support for sending BSSMaxIdle in association request
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Aug 14, 2023 at 2:28=E2=80=AFPM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> On Mon, 2023-08-14 at 01:56 +0530, Krishna Chaitanya wrote:
> > >
> > > > Just remembered why I had to implement this in kernel, the associat=
e/connect
> > > > data structure in wpa_s `wpa_driver_associate_params` doesn't have =
any
> > > > ies/extra_ies, it only gives wpa_ie and rest all are parameters for=
 mac80211
> > > > to use. So, had just extended this as well, do you think we should =
add
> > > > this ies/extra_ies
> > > > to the association like we do for scan? Or as MLME is in mac80211,
> > > > just use this patch as is?
> > >
> > > Not sure I follow all that reasoning - is that something internal to
> > > wpa_supplicant? Fundamentally with my cfg/mac hat on I'm not sure I c=
are
> > > so much about wpa_s internal data structures?
> > >
> > > Things like extended capabilities are also added to the "extra IEs" b=
y
> > > wpa_s, so surely this would work too?
> >
> > I was only pointing out that AFAIK there is no mechanism to pass "ies" =
in
> > the associate command from userspace, except for WPA IE.
>
> Oh you're talking about the associate command? You never mentioned that,
> and in fact most of your patch is concerned with mac80211 ...
>
> Would it kill the implementation you have to add "extra elements" rather
> than all these individual settings? Does this thing affect the local
> firmware implementation? I guess in a sense it must?
>
> I don't know ... and I have no way of ever finding out! So again this is
> one of those things where we're never going to see an upstream driver
> using it, right? I'm getting really close to just giving up on that.
> Since Jouni is happy to add vendor commands for settings left and right
> in wpa_supplicant, I pretty much think this stuff has failed. We're
> littering the nl80211 API with things that don't really get used
> upstream, or like here, do get used but in a way that's
>   (a) pretty useless since it doesn't do anything but add an element
>       wpa_s could have added itself, and
>   (b) looks like just a fig-leaf for this exact reason? Shouldn't
>       something be configured here to the NIC too? NIC should support
>       it, etc.? What's even the purpose of this in mac80211?
I agree that this IE should be populated by wpa_s as it needs user
input, I had looked at other information in cmd_associate where it's passed
to mac80211 using nl80211, so, had followed this approach. I will try and
add this to wpa_s itself, thanks.

NIC isn't involved here directly (unless keepalive for connection is offloa=
ded),
this is about conveying a user preference to AP to avoid AP prematurely
disassociating the client.
