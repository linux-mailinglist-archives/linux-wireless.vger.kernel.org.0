Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78D8554B56
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jun 2022 15:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiFVNbV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Jun 2022 09:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357449AbiFVNaw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Jun 2022 09:30:52 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF6FBE2
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jun 2022 06:30:50 -0700 (PDT)
Date:   Wed, 22 Jun 2022 13:30:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dannyvanheumen.nl;
        s=protonmail2; t=1655904648; x=1656163848;
        bh=PtcpJojz301RxWLmBJ3699vVtlYYcLr2E1q7TyKImqk=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=oXCHGUGUdae4vDAN7L4vmqVVUWr2itWn1QN5lCGOjnJnDYPdSGwKkxvgrO+EM6/0u
         ld92wvCH4jDXS7JwsOLOuDadGbirXCPcOuUyhx1o9fGmnEAlHqMXKAL3ualureTqof
         +nOwY3LeJ079jjG8izy+TQMx8LduVGjjgeqmOKg9JFK62BHePHJ/iiUD9qflINmK3b
         X0Lf9fS6ObIkRlfKAamISrKA8zTH0lzpeCPZ09xQUFr9yUObw+edfORP9hI8tnOXSP
         ZRb1PeUIWdc0gz5A2LcSKplbzZ40KWGhFJBYXuV4GCv6cSLd/ZcboAx4/K/2L1Llb+
         ES5SUdGSoHUHw==
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
From:   Danny van Heumen <danny@dannyvanheumen.nl>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Reply-To: Danny van Heumen <danny@dannyvanheumen.nl>
Subject: Re: [PATCH] work-in-progress: double-free after hardware reset due to firmware-crash
Message-ID: <FAWAACmnmgDDRgInBWC2swEfaDo7xXU_BYmQP9i_OeNHgK75m2DKYTPVzLsVk51T9U6sz3HbbFaYh-qz2BX1Go0NR4c1fN_wyxozsRIXIy0=@dannyvanheumen.nl>
In-Reply-To: <cb66e6f4-3377-99be-74d0-87e1c57599f4@broadcom.com>
References: =?us-ascii?Q?<UXibAXk2GByhvw88A6LIDXHSlkP79-ML7FrtyfnHuiC34qUd-zx03BAJAtzluyEvfwPBR0tac4hC72zKI1qT3CtgmvvVohr1v8a49TqYVSw=3D@dannyvanheumen.nl>_<1a116224-66ff-17b1-bb8b-9c0918dd47e4@broadcom.com>_<kB9OdQYlBnucF05VoKxTvsT8eUrPGJc=5Fwe9irAdR-2gmXsEl4NvkhMzDcTahLm3HLA2zKVXnhEOstESbIEcHGKYHvMOyIcr4vh80f0eJCJ0=3D@dannyvanheumen.nl>_<MV9-h4Mgj6FKxRJY93AQMhYFsz2yz0CoDQ70V8JWe742HUdLdl6Q1LbFTxGa-NCzodUmI3dbSoRGXebbE5rWPKKehHdixSTjW4TKZt10AJk=3D@dannyvanheumen.nl>_<1815e2011e8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>_<PDYrcmiOE8drECietqr7SILEQI8DpX6gL8pbVCR6IbqNrKjyXTLYPhgsWfHL-s9FuElU5v84HUUWaFntR5RZJG5EBABE2XilCP=5F2O9ZipMk=3D@dannyvanheumen.nl>_<Ct5-sN=5FCGLyGf5qHNiakimNNG33Yb=5F7toxutmv8ELxgBqGZQXM6DkaIJg2cctTqSFyawKx8XeU3ySO2Ce6idBXv-ZWrT6Wy5=5Fa9nFr4svy4=3D@dannyvanheumen.nl>_<45d90d65-cd0e-e65f-edcf-d55802a4a6bd@broadcom.com>_<VJRRELjxfxQK1fFLbnYr2IZVHdPU-0YotbBIG2-ycUA2OCppqr4TrzsbXHC=5FwpS0ZA7HNLJxZNA6-Bzy0BOAuV16DR6wqT9TPDLjQwYcp7w=3D@dannyvanheumen.nl>_<cb66e6f4-3377-?=
 =?us-ascii?Q?99be-74d0-87e1c57599f4@broadcom.com>?=
Feedback-ID: 15073070:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Arend,

------- Original Message -------
On Wednesday, June 22nd, 2022 at 11:36, Arend van Spriel <arend.vanspriel@b=
roadcom.com> wrote:

> On 6/21/2022 3:18 PM, Danny van Heumen wrote:
>
> > Hi Arend,
> >
> > ------- Original Message -------
> > On Tuesday, June 21st, 2022 at 09:41, Arend van Spriel arend.vanspriel@=
broadcom.com wrote:
> >
> > > [..]
> > >
> > > Maybe overlooked, but I have not seen a patch from you on the
> > > linux-wireless list. Do you have reference, ie. URL or Message-ID?
> >
> > I'm not sure what's most convenient here, but here's an archive link:
> > https://marc.info/?l=3Dlinux-wireless&m=3D165547582612979
> >
> > Message-ID: ThT2jwvySn9tFQm9FxrlPNMQkiGUnx_87cOhmmeexoVOFZqOkpjmAntCWG-
> > kIBMj2830LHZaOULlJxQKiRXkVtGYrrT8rBaB7R65qjIinYo=3D () dannyvanheumen !=
 nl
>
>
> Found it. Had to check my gmail account instead of my work account.
>
> > You haven't commented yet on my question regarding definition macro for=
 the clm_blob.
> > I intend to send a patch for it, because I believe at the very least so=
me parts of distribution
> > processes rely on these firmware entries. It would be good if you can c=
onfirm.
>
>
> The clm_blob is optional unless the firmware image was built without any
> clm data. If that is the case for 43456 (I think it is not) than it
> should be reflected with BRCMF_FW_CLM_DEF(). Otherwise it is fine as it
> is right now.

Okay. I checked a few of the binary blobs, some are built with and some are=
 built without (`strings` gives me a line with 'noclm' in it or with 'clm' =
and some revision/identifier) This is a bit of guessing on my part.

I will leave it as is then.

Regards,
Danny

