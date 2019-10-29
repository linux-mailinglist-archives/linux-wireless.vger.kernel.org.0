Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00F81E842D
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2019 10:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732228AbfJ2JTk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Oct 2019 05:19:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50235 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732218AbfJ2JTk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Oct 2019 05:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572340779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=STRuZBLW20OgTEwXoaCz09lBjCq7P2+g++I4UIBp2l4=;
        b=d05Sq6DyOns6hSyNx1o2rZJqu+MWOUU+1iwhZQ/Vs3o6cfbAg3ml5L1lWoKxvTf+4Wexk9
        ShTMOgmHXLxBKWVzkG1Z0vS1irhCII726/G363Vl0eH9mSTF/wUrc0Yhzde85UahiSXoVE
        Mvrbe4VY/+rRGXwRFTRCODkFMl+3qfY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-_K28Gw6FNY-zlu3aDeGgIQ-1; Tue, 29 Oct 2019 05:19:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 554531005500;
        Tue, 29 Oct 2019 09:19:33 +0000 (UTC)
Received: from localhost (unknown [10.43.2.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 669BA60870;
        Tue, 29 Oct 2019 09:19:32 +0000 (UTC)
Date:   Tue, 29 Oct 2019 10:18:57 +0100
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     linux-wireless@vger.kernel.org, Roman Yeryomin <roman@advem.lv>,
        wbob <wbob@jify.de>
Subject: Re: [PATCH] rt2800: remove erroneous duplicate condition
Message-ID: <20191029091857.GB3571@redhat.com>
References: <20191028212244.GA2590@makrotopia.org>
MIME-Version: 1.0
In-Reply-To: <20191028212244.GA2590@makrotopia.org>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: _K28Gw6FNY-zlu3aDeGgIQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Oct 28, 2019 at 10:22:44PM +0100, Daniel Golle wrote:
> On 2019-10-28 06:07, wbob wrote:
> > Hello Roman,
> >
> > while reading around drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> > I stumbled on what I think is an edit of yours made in error in march
> > 2017:
> >
> > https://github.com/torvalds/linux/commit/41977e86#diff-dae5dc10da180f3b=
055809a48118e18aR5281
> >
> > RT6352 in line 5281 should not have been introduced as the "else if"
> > below line 5291 can then not take effect for a RT6352 device. Another
> > possibility is for line 5291 to be not for RT6352, but this seems
> > very unlikely. Are you able to clarify still after this substantial tim=
e?
> >
> > 5277: static int rt2800_init_registers(struct rt2x00_dev *rt2x00dev)
> > ...
> > 5279:  } else if (rt2x00_rt(rt2x00dev, RT5390) ||
> > 5280:         rt2x00_rt(rt2x00dev, RT5392) ||
> > 5281:         rt2x00_rt(rt2x00dev, RT6352)) {
> > ...
> > 5291:  } else if (rt2x00_rt(rt2x00dev, RT6352)) {
> > ...
>=20
> Hence remove erroneous line 5281 to make the driver actually
> execute the correct initialization routine for MT7620 chips.
>=20
> Fixes: 41977e86c984 ("rt2x00: add support for MT7620")
> Reported-by: wbob <wbob@jify.de>
> Reported-by: Roman Yeryomin <roman@advem.lv>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net=
/wireless/ralink/rt2x00/rt2800lib.c
> index f1cdcd61c54a..c85456c8c193 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> @@ -5839,8 +5839,7 @@ static int rt2800_init_registers(struct rt2x00_dev =
*rt2x00dev)
>  =09=09rt2800_register_write(rt2x00dev, TX_TXBF_CFG_0, 0x8000fc21);
>  =09=09rt2800_register_write(rt2x00dev, TX_TXBF_CFG_3, 0x00009c40);
>  =09} else if (rt2x00_rt(rt2x00dev, RT5390) ||
> -=09=09   rt2x00_rt(rt2x00dev, RT5392) ||
> -=09=09   rt2x00_rt(rt2x00dev, RT6352)) {
> +=09=09   rt2x00_rt(rt2x00dev, RT5392)) {
>  =09=09rt2800_register_write(rt2x00dev, TX_SW_CFG0, 0x00000404);
>  =09=09rt2800_register_write(rt2x00dev, TX_SW_CFG1, 0x00080606);
>  =09=09rt2800_register_write(rt2x00dev, TX_SW_CFG2, 0x00000000);

I'm not sure if initialization on different path, is proper for all
variants of RT6352 chipset. Particularly I noticed that configuring
MIMO_PS_CFG can cause problems on wt3020.

Stanislaw

