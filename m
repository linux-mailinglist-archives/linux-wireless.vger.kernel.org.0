Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A8C7BFF5C
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Oct 2023 16:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjJJOdU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Oct 2023 10:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbjJJOdT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Oct 2023 10:33:19 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFF891
        for <linux-wireless@vger.kernel.org>; Tue, 10 Oct 2023 07:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=LcM0X57ttJM+yZRpA0bdaPmgMfMAgtgXntBWRr1jAQQ=;
        t=1696948398; x=1698157998; b=ksYIKyI2159aZZd/hZJcORQSx89Wn4cquTRr2IFD5onbo+d
        y1YYJ4Ua4nFmhHh//WYS91VyxHP0f565wmRcL4vnUUquBTwMtLe3K1V29kmW63y/Sm4uaWhrlLz+D
        WWjIAjJzzZLlXWv0GnarToHKrqWQqW9MJU+IfruUx0hFExTY35fH3oByW/6Tdnuih24H3+8aWJaS4
        k6oBaLQBUAwpKOr+wRB9k/Q8sg74s/bkoxrBiaoXJyESOeFJd5BeeCr47Abuql2rmP4uv7t0PK2br
        ZDYYs244wXmku9+BOC1GvMRGS7he8D4Y6mcnlvx92nePPPlgyYVYCI0gjafBNmHA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qqDnO-00000000RuH-2Gzm;
        Tue, 10 Oct 2023 16:33:14 +0200
Message-ID: <748f5db3e109ea99c6ff83fe04a02dc2d6046a0e.camel@sipsolutions.net>
Subject: Re: removing OCB/WAVE/802.11p
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Carlo Augusto Grazia <carloaugusto.grazia@unimore.it>
Cc:     linux-wireless@vger.kernel.org,
        Rostislav Lisovy <lisovy@gmail.com>,
        Bertold Van den Bergh <bertold.vandenbergh@esat.kuleuven.be>,
        chrisshen@skku.edu, bienaime@skku.edu, pauljeong@skku.edu
Date:   Tue, 10 Oct 2023 16:33:13 +0200
In-Reply-To: <CALDN43k=-QqLvK-XTQfnNFWYp6EzceHOQer8EB7YLnFrSNCC1w@mail.gmail.com>
References: <ec69aa2722b07bffd6184d687861cc7e5ae9c1ef.camel@sipsolutions.net>
         <CALDN43k=-QqLvK-XTQfnNFWYp6EzceHOQer8EB7YLnFrSNCC1w@mail.gmail.com>
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

Hi Carlo,

Thanks for your response! I'm quoting it fully below for the benefit of
the list which dropped your response since it was HTML.

On Fri, 2023-09-29 at 16:40 +0200, Carlo Augusto Grazia wrote:
> Dear Johannes,
> Thank you for this email!
> I'm in the "people who use/used" it.

:)

>  I've tested the OCB performance in some scientific papers and used the O=
CB mode in
> the laboratory part of my course on Automotive Connectivity at the Univer=
sity of Modena and Reggio Emilia (Italy).
> I'm using it in "low-cost laboratory" mode with Arduino Yuns and a proper=
 version of LEDE/OpenWRT, indeed, as you said,=C2=A0
> the Yun device mounts ath9k.

Right.

> I don't know if will be ever implemented a DSRC/WAVE/802.11p mode on Linu=
x, allowing low-cost hardware to perform as On Board Unit
> for my tests, I'll probably always have to use Codha Wireless devices or =
SDR properly configured for doing this...
>=20
> I've always tried to see if the OCB on ath9k was going to be ported at le=
ast on ath9k_htc, but nothing...so I got your point (maybe), an IBSS code w=
ell maintained for more
> drivers is better than an OCB code working only for ath9k.
>=20
> Also, I've never maintained a driver, so I don't know if I can help, but =
I'm really interested in the direction this story will take.

OK, fair enough. I was mostly just putting out feelers.

Honestly the thing isn't even necessarily maintaining it, but as it
stands, I don't even know of any way to _run_ the code, which is a bit
sad.

Is all the setup that you had very complex?

johannes
