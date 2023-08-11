Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFFD778A3C
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Aug 2023 11:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjHKJlx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Aug 2023 05:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjHKJlw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Aug 2023 05:41:52 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C77ED
        for <linux-wireless@vger.kernel.org>; Fri, 11 Aug 2023 02:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=xaY0Ef0hU/C1Pt+SZUSGpXgT+3YVXW9Md4691MHBlhs=;
        t=1691746911; x=1692956511; b=R+FULDesh52IkIiLcvkrV9obAM4vGVyBzuBNGKfiUhqxmSG
        6x7zf+Qj1TEbCpk+RJ8fVu7gPNuTehUZ3cSo8fj72lpGXO4cQVhabYfI/MP/ILTtJi8GKhJP4hDw6
        x+WVgLaulziu2PqJKzGNIXNgK4BZemliCBruJPOQGNFsWBSdvIvh/N2YdcZv5ZgtyZq1WsP7CHcWM
        /xFusmhjEPYAR7ku2dYPEWz1rFJhLuRIUgrEYumJ42i6SssfSeJYOpjeoYriVqwJkwq/OiXdhA8Do
        LA3Uu8EvUm02g0rEgJn/bJDtI1K8UwpYEHjiyWAdA8pzaN3WpR6UqLc5fAM9I/xw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qUOeT-000qcT-1w;
        Fri, 11 Aug 2023 11:41:49 +0200
Message-ID: <e3d7cb8b891d1a54ffea60b5f8257208e03129d3.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: Add support for sending BSSMaxIdle in association
 request
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Krishna Chaitanya <chaitanya.mgit@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 11 Aug 2023 11:41:48 +0200
In-Reply-To: <CABPxzY+_2DEK-wfAr1V9z1iHZky-7vF24mQx2yFgtFUoTdWgmw@mail.gmail.com>
References: <20230719194039.16179-1-Chaitanya.Tata@nordicsemi.no>
         <2307e1741e9d32e8f1ffc4e83c73b63a4e32512b.camel@sipsolutions.net>
         <CABPxzYJvAtgbrr_v6cMuKwFjzRjYOCDota+koYp-iogtJS75HQ@mail.gmail.com>
         <CABPxzY+_2DEK-wfAr1V9z1iHZky-7vF24mQx2yFgtFUoTdWgmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2023-08-11 at 00:17 +0530, Krishna Chaitanya wrote:
> On Fri, Aug 11, 2023 at 12:05=E2=80=AFAM Krishna Chaitanya
> <chaitanya.mgit@gmail.com> wrote:
> >=20
> > On Tue, Aug 8, 2023 at 4:43=E2=80=AFPM Johannes Berg <johannes@sipsolut=
ions.net> wrote:
> > >=20
> > > On Thu, 2023-07-20 at 01:10 +0530, Chaitanya Tata wrote:
> > > > When WNM is enabled, a station can send its preferred BSS maximum i=
dle
> > > > period in the association request, add a new netlink attribute to g=
et
> > > > this value from the supplicant and add BSS maximum idle IE in the
> > > > association request.
> > > >=20
> > >=20
> > > I don't see anything here that even requires all this code, rather th=
an
> > > wpa_s just including the element itself in the association request ex=
tra
> > > IEs?
> > Yeah, WPA supplicant can prepare this, please ignore, thanks.

> Just remembered why I had to implement this in kernel, the associate/conn=
ect
> data structure in wpa_s `wpa_driver_associate_params` doesn't have any
> ies/extra_ies, it only gives wpa_ie and rest all are parameters for mac80=
211
> to use. So, had just extended this as well, do you think we should add
> this ies/extra_ies
> to the association like we do for scan? Or as MLME is in mac80211,
> just use this patch as is?

Not sure I follow all that reasoning - is that something internal to
wpa_supplicant? Fundamentally with my cfg/mac hat on I'm not sure I care
so much about wpa_s internal data structures?

Things like extended capabilities are also added to the "extra IEs" by
wpa_s, so surely this would work too?

johannes
