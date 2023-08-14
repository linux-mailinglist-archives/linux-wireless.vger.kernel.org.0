Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F8977B58A
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Aug 2023 11:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbjHNJfY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Aug 2023 05:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235775AbjHNJAG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Aug 2023 05:00:06 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33472117
        for <linux-wireless@vger.kernel.org>; Mon, 14 Aug 2023 01:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=i877FpT5qodl1tYCxsJp7SLUPoE/IQXdlXHatl2Wf8I=;
        t=1692003553; x=1693213153; b=mZwExuPdxJU9FUoOcxy9gTOBSyUZMaBox4kAsyXkM3KHYiX
        Y7UCoN9rZKMZ3Xt/k3B6+75P/6gK8A9Felt/pAK1HlztduhytbyW1On4IahgU/JkFQnI1QBNft4VV
        UX2AejZlL9xScbj5bc1eMp3VwVpwEG6RmSd9SHQmVpAsAOompLTFxnpspCGVYonZhsImnb7J5kAT8
        ctu0EItJSnnAN/RwotQtnrs0N0tuxcoN2DgZN3jvjUXrx/wUjd/B/DeUVmwbInAv06lu26xlpipYw
        dp81sfKFYdhirA0SUhKetlxYKO/t5bPwqnAzXNQWT+oTEb5ALAmKePkJ9rMRu8zg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qVTPS-006ZAS-1b;
        Mon, 14 Aug 2023 10:58:46 +0200
Message-ID: <a998334c11f8cd2d2f3d4d6b6883f9c0f699cd2c.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: Add support for sending BSSMaxIdle in association
 request
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Krishna Chaitanya <chaitanya.mgit@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 14 Aug 2023 10:58:45 +0200
In-Reply-To: <CABPxzYLp++vabPm9GZheg_UjofkJjm+kQZDRr9HXbX54bxptBQ@mail.gmail.com>
References: <20230719194039.16179-1-Chaitanya.Tata@nordicsemi.no>
         <2307e1741e9d32e8f1ffc4e83c73b63a4e32512b.camel@sipsolutions.net>
         <CABPxzYJvAtgbrr_v6cMuKwFjzRjYOCDota+koYp-iogtJS75HQ@mail.gmail.com>
         <CABPxzY+_2DEK-wfAr1V9z1iHZky-7vF24mQx2yFgtFUoTdWgmw@mail.gmail.com>
         <e3d7cb8b891d1a54ffea60b5f8257208e03129d3.camel@sipsolutions.net>
         <CABPxzYLp++vabPm9GZheg_UjofkJjm+kQZDRr9HXbX54bxptBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2023-08-14 at 01:56 +0530, Krishna Chaitanya wrote:
> >=20
> > > Just remembered why I had to implement this in kernel, the associate/=
connect
> > > data structure in wpa_s `wpa_driver_associate_params` doesn't have an=
y
> > > ies/extra_ies, it only gives wpa_ie and rest all are parameters for m=
ac80211
> > > to use. So, had just extended this as well, do you think we should ad=
d
> > > this ies/extra_ies
> > > to the association like we do for scan? Or as MLME is in mac80211,
> > > just use this patch as is?
> >=20
> > Not sure I follow all that reasoning - is that something internal to
> > wpa_supplicant? Fundamentally with my cfg/mac hat on I'm not sure I car=
e
> > so much about wpa_s internal data structures?
> >=20
> > Things like extended capabilities are also added to the "extra IEs" by
> > wpa_s, so surely this would work too?
>=20
> I was only pointing out that AFAIK there is no mechanism to pass "ies" in
> the associate command from userspace, except for WPA IE.

Oh you're talking about the associate command? You never mentioned that,
and in fact most of your patch is concerned with mac80211 ...

Would it kill the implementation you have to add "extra elements" rather
than all these individual settings? Does this thing affect the local
firmware implementation? I guess in a sense it must?

I don't know ... and I have no way of ever finding out! So again this is
one of those things where we're never going to see an upstream driver
using it, right? I'm getting really close to just giving up on that.
Since Jouni is happy to add vendor commands for settings left and right
in wpa_supplicant, I pretty much think this stuff has failed. We're
littering the nl80211 API with things that don't really get used
upstream, or like here, do get used but in a way that's
  (a) pretty useless since it doesn't do anything but add an element
      wpa_s could have added itself, and
  (b) looks like just a fig-leaf for this exact reason? Shouldn't
      something be configured here to the NIC too? NIC should support
      it, etc.? What's even the purpose of this in mac80211?

johannes
