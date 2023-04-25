Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA3A6EE76E
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Apr 2023 20:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbjDYSPG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Apr 2023 14:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbjDYSOf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Apr 2023 14:14:35 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0A3A3
        for <linux-wireless@vger.kernel.org>; Tue, 25 Apr 2023 11:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=T0078F3oFO++8puIQ5Zs473pGtZf2td4l9EHd0XM1/k=;
        t=1682446474; x=1683656074; b=iaVj4zX7jZ8jBaOXB0deMNvSJzsswgv0phLavF77INGRZWh
        aNFg0MclzBp91xa+QNz5ET2Lzr+eGrhpdO+roIJkjtcGS04brR8alsb3lwFQsNpODK7a0D0Lc4iml
        BKrFDaKwfPdbJVusqMvFeRm3m5/3ZzkJxnK7dRoVvyUvLwNWFapWluwPNQPC2dG0W9/uWrr9cuOzS
        NrzHkgVxgLNDc2M5D4sz/4EKVBKjReCAstXNed/1OwsZPkkHAS9RwqE5jalNcv7cNHlsoQLo4Oq+a
        9cb0cOAQfGSCBwVm/ut3Xbm7QhfvjSd1WrnUbReKOZgpXkLzUzxdPT8wdUjbJOUw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1prNBQ-008J9I-1p;
        Tue, 25 Apr 2023 20:14:32 +0200
Message-ID: <b3184a3baff2e1ab031e3dcc426df9a2234b89d5.camel@sipsolutions.net>
Subject: Re: question about struct ieee80211_iface_combination
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Tue, 25 Apr 2023 20:14:31 +0200
In-Reply-To: <9de1cb94-7b60-3d1d-3833-1b08624af645@broadcom.com>
References: <9de1cb94-7b60-3d1d-3833-1b08624af645@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Arend,

On Tue, 2023-04-25 at 12:01 +0200, Arend van Spriel wrote:
> My brain is tripping over a field in struct ieee80211_iface_combination,=
=20
> ie. the num_different_channels. Looking at the name I tend to think that=
=20
> num_different_channel =3D 0 means the interfaces must all operate on the=
=20
> same channel. However, in most places it is configured as 1 or more. The=
=20
> documentation in cfg80211.h [1] is not unambiguous about it in my=20
> opinion. By now it probably depends on how user-space uses it.

Well it's not valid for it to be 0 in the first place:

static int wiphy_verify_combinations(struct wiphy *wiphy)
{
...
        for (i =3D 0; i < wiphy->n_iface_combinations; i++) {
...
        for (i =3D 0; i < wiphy->n_iface_combinations; i++) {
...
                /* Need at least one channel */
                if (WARN_ON(!c->num_different_channels))
                        return -EINVAL;


So really what was meant that _1_ means you only have a single channel,
and so on. Are you tripping over the "different"? The way I read it, is
that with all the interfaces you have, you can have N different
channels, i.e. looking at it "globally". It seems maybe you're more
interpreting it as "additionally" to the first interface?

johannes
