Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714BA7BFF4D
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Oct 2023 16:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjJJO3L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Oct 2023 10:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbjJJO2w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Oct 2023 10:28:52 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1006AC
        for <linux-wireless@vger.kernel.org>; Tue, 10 Oct 2023 07:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=gqGhBg+Yymrde0mq9bGp5ymB6dgvoWKbsFjWMeM68VY=;
        t=1696948131; x=1698157731; b=VEpUI1ke5d0K2Pf1i1dV9bI3md3e8zxceWA1+WxSOJrBwd5
        1ahVnSoIXBAXOhWijTjBiI8Z4frxMZjIDVUD6ahSLjPH7To6r2mbeb6N/VKrYKvfCqCxUGDAvxXN6
        FX6zbfEiljyGid9ubxvkClw7uthJPoIrkxZ7TV9l2An64KcavOE8xgDtSmO+S/0la5fWN4IzAGGkQ
        l+UMGdXPNbFQEYyhjKZvRg1BZJEu/jdbSyO9bXL2+jnTwlUh8Rh+1KU17N1sMTSjK8Mc73Wzpx048
        yhDN9iGNeyRU1u53hJj/d0MrrCbg0ct56GLVGWn2KJguiZBZFw+UigUQ0581ybDQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qqDj5-00000000Rg0-4Bjw;
        Tue, 10 Oct 2023 16:28:48 +0200
Message-ID: <2ec54be2691176677386253e64e819deadcf00fb.camel@sipsolutions.net>
Subject: Re: wifi-7 + MLO: wlan is not seen in /proc/net/wireless
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>, Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Tue, 10 Oct 2023 16:28:46 +0200
In-Reply-To: <3e684eea-147b-ca03-1c40-291ece4d1ebb@candelatech.com>
References: <db9ef851-5784-c6a5-d3d5-5747ef21e0b6@candelatech.com>
         <87zg0zgemy.fsf@kernel.org>
         <3e684eea-147b-ca03-1c40-291ece4d1ebb@candelatech.com>
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

On Wed, 2023-10-04 at 06:19 -0700, Ben Greear wrote:
> On 10/3/23 10:06 PM, Kalle Valo wrote:
> > Ben Greear <greearb@candelatech.com> writes:
> >=20
> > > I'm testing a wifi-7 radio against MLO AP.  I notice the link-0 debug=
fgs links
> > > show up and STA is associated and acquired DHCP, but wlan is not in /=
proc/net/wireless.
> > > I'm in 6.5.5+ kernel.
> > >=20
> > > Is this expected?
> >=20
> > wext doesn't support Wi-Fi 7, see:
> >=20
> > https://git.kernel.org/linus/52fd90638a72
>=20
> For somewhat similar reasons, ethtool stats are broken for MLO
> too (see my patches from yesterday).
>=20
> To keep at least some backwards compatibility, would it be worth
> reporting the 'best' link's information?  To me best is highest
> band that is connected.  It could also just be the first link that is
> connected.

So I think we should differentiate here. For wext, certainly no. I don't
want to support wext forever, and multi-link is a really good reason to
say "nope, things just stop working here, stop using 1996 technology".

For ethtool, well, to be honest I never really liked it in the first
place (*), but I guess we should somehow fix some things there...
Perhaps report some cumulative values?

But let's discuss that on the individual patches I guess.


(*) I also don't like your iwlwifi patch for those 'buckets', FWIW,
there's no real explanation for why the buckets should be this way, and
putting an array into flat ethtool also feels just wrong.

johannes
