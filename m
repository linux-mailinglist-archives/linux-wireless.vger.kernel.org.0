Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5425EF2D4
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Sep 2022 11:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbiI2J4g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Sep 2022 05:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbiI2J4d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Sep 2022 05:56:33 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668C1DF393
        for <linux-wireless@vger.kernel.org>; Thu, 29 Sep 2022 02:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=8YGdRudXwmHRdNa9GW60U8K994rbfUeMjGihQsfF9wE=;
        t=1664445391; x=1665654991; b=kzUSRyZdM26SqjDHFKBwY17m/NoglEBpZr65EfRFtsPj6RN
        4bCHj978POp71bQcJLX5z+F6kIzCXNaO28fND5C6LwNVidSKC6whtf57yp6Rr0qbbzFj/dxc4Wzlb
        LxiNKSoM0Q7PNduPjuRqa+V142GCCFWFBwr6R5HxVwX1kslwARkoQugIajSDSGqUEDoFqA6IrVORd
        pCtKwig12oOTdH7u+XtfWee2qXiwsMZNZ8oIBjzr0v7FYalDzo2bnOBAJ5lEWpPlD7qVra7jxRXqt
        XsZqdUY+ABICNFiITI4JR4ZkAnSo3c8Lv26qwaM70Nam5jE8RpOA7B4+9ubYaxcA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1odqHM-00B7z7-2R;
        Thu, 29 Sep 2022 11:56:28 +0200
Message-ID: <715050f6db60d90b3fa6ae4193273dcb73838b64.camel@sipsolutions.net>
Subject: Re: [PATCH 0/1] Fix potential HE IE bug and some other questions
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Thu, 29 Sep 2022 11:56:27 +0200
In-Reply-To: <20220928224910.453232-1-prestwoj@gmail.com>
References: <20220928224910.453232-1-prestwoj@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2022-09-28 at 15:49 -0700, James Prestwood wrote:
> I believe there is a bug when building the probe request IEs for the
> HE capabilities. More info in the patch.
>=20

That fix seems right.

> While looking at this I
> noticed some other confusing code related to building the probe
> request.
>=20
> Looking at ieee80211_build_preq_ies. It is passed 'bands_used' which
> is a bitmask of bands. A probe request is only sent out on a single
> band so why would this contain multiple bands?=C2=A0
>=20

The function can be used to prepare a HW scan request, which can contain
the elements for all bands that the HW is being asked to scan on.

> We then loop over these
> bands and call ieee80211_build_preq_ies_band for each one.

Correct, and ie_desc->ies[band]/len[band] gets the pointer/size for each
band.

> This, AFAICT, would append the same IEs multiple times if 'bands_used'
> contained more than one band.
>=20

Correct.

> Internal to mac80211/util.c its only
> passed BIT(chan->band), but mac80211/scan.c seems to pass a list...

Right, that's because "internal" is ieee80211_build_probe_req(), which
builds only a single probe request, while the other code is for HW scan.

> Below is the warning I am seeing (many, many times). It says the warning
> is in build_preq_ies, but it really seems like this is not correct
> and its actually in ieee80211_get_he_6ghz_capa since I see no warning
> message as others _should_ have.
>=20
> [  732.130000] ------------[ cut here ]------------
> [  732.130000] WARNING: CPU: 0 PID: 1352 at include/net/cfg80211.h:608 ie=
ee80211_build_preq_ies+0x766/0x84d

The line number is in ieee80211_get_he_6ghz_capa() but that's inlined,
and that doesn't always work so well for the symbol resolution.

johannes
