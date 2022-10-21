Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F6D607F9B
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Oct 2022 22:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJUUWU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Oct 2022 16:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJUUWS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Oct 2022 16:22:18 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C86A26FF87
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 13:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=JTG4Q7hNZgI2Zu6WLoPHJtGWuNChJ1sTMBguvEFn3iM=;
        t=1666383738; x=1667593338; b=paRn6uMepQd4Nv7umNMIJkfXYL1NHy4zhte1EHzf+K7l6BV
        S6EMixsTAUlSoTqeg/DMbl6TMPKsq9EFXjMBPZEJnRn+xIx3O7BFc7krUmv4O9nw3zJjVIgB/BcqO
        uNnZ6Srcnr1UkvuAPOBJVow16PUMADJlqoY/RdEVsh9rVS3yGG9cyczNw2Bk/s3YDBA8hVk8UsSEV
        EedapfTYJE17z4fhQBof+gkgWcP8fwtJJd8t8PSDI+k3dt6+E6eYFEjchiIs5JB5wOGHmW6hmUAcN
        oOLoZo2vAlcRo+zPgvajon40KsEk3xJSrqFj2KThFpYU2Xss3PKnNJK4+kd014zA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1olyX1-00D0CH-2c;
        Fri, 21 Oct 2022 22:22:15 +0200
Message-ID: <d23613213568545ec808599a33c04a2e77ac7889.camel@sipsolutions.net>
Subject: Re: [PATCH 1/5] wifi: rtl8xxxu: Add central frequency offset
 tracking
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
Date:   Fri, 21 Oct 2022 22:22:14 +0200
In-Reply-To: <c3540f87-b124-2642-f53e-aa15704a54e8@gmail.com>
References: <2b29b6d9-c17e-76d6-c32f-630f24b407b7@gmail.com>
         <6a91fd1b8d5e4bf3910366121ed92f3b@realtek.com>
         <c3540f87-b124-2642-f53e-aa15704a54e8@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
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

On Fri, 2022-10-21 at 21:32 +0300, Bitterblue Smith wrote:
> >=20
> > #define XTAL1 GENMASK(22, 17)
> > #define XTAL0 GENMASK(16, 11)
> >=20
> > val32 &=3D ~(XTAL1 | XTAL2)
> > val32 |=3D FIELD_PREP(XTAL1, crystal_cap) |
> >          FIELD_PREP(XTAL0, crystal_cap);
> >=20
>=20
> Ah, so that's what FIELD_PREP does.

FWIW, personally, I've come to prefer u32_encode_bits() and friends, or,
in this case perhaps

	u32p_replace_bits(&val32, crystal_cap, XTAL0);
	u32p_replace_bits(&val32, crystal_cap, XTAL1);

or maybe writing that as

val32 &=3D ~(XTAL0 | XTAL1);
val32 |=3D u32_encode_bits(crystal_cap, XTAL0);
val32 |=3D u32_encode_bits(crystal_cap, XTAL1);

instead.

That's partially because there are also le32 variants of it etc. that
are simpler to use with endian-fixed firmware interfaces or similar.


But YMMV (as might that of the maintainers of this driver) :-)

johannes
