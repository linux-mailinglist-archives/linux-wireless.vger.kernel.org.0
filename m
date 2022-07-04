Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C345658EB
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jul 2022 16:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbiGDOtz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jul 2022 10:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiGDOty (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jul 2022 10:49:54 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C716BBE0
        for <linux-wireless@vger.kernel.org>; Mon,  4 Jul 2022 07:49:52 -0700 (PDT)
Date:   Mon, 04 Jul 2022 14:49:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dannyvanheumen.nl;
        s=protonmail2; t=1656946190; x=1657205390;
        bh=qk9SiVpkMaduwZpslx/4koc6GmdL5SSiZUS9Q31vCy0=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=Sqt+RKtgYhcZhjHFDiUmsNaBC/8XIlrJjD/SVIxLx5D9j+2cbm+mjw4tZoiFseY8Q
         mJXtVh2jl5TciRwXPdMNeU+Et4z1mGdr4vGMuUPqwWe/HEr/KxfOtappCV2o50YFIu
         BRzwjMkuf+3/KCitRWgzBMh+xs0+ZUwbZStifYTuQr+MXwvobN/GoTjO2uD1nTtXUi
         jyXNYoAIXxTxWd7WGrU1vCHIZQZnlq/ePEtzPUJlgHL+3AUtY/bV6jhKbhD3Scgu3J
         s8aIastOpP31oNnD9m+tb3TdKRdMtv3kiBT9yM8+rJaR+NMVoBA3o/eSh1tBJdPKOj
         IivhroVJJE1qg==
To:     Arend Van Spriel <aspriel@gmail.com>
From:   Danny van Heumen <danny@dannyvanheumen.nl>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Reply-To: Danny van Heumen <danny@dannyvanheumen.nl>
Subject: Re: [PATCH v4] brcmfmac: prevent double-free on hardware-reset
Message-ID: <SpNFVBNIoAMOViIfL2pA_NfZkIX1ldRs865SC5DNvEzTfnDVAQALh3ugJVVMnWZ6XZDQI9L85yb0TEhzjKMTt8CjZuXW8mE-FY6GMSoWCs4=@dannyvanheumen.nl>
In-Reply-To: <a2d63d48-74bf-06e5-0b90-d046dd0966bd@gmail.com>
References: <g_Py6bM1lfcJOWWmHwKU8x4tCFrTRdgFtoM13qYHeN441F392j_6etJnEJ8gHJMRZ6OEKxpJYuP45x3iziHqY6HNXnVwIiyvJLYjvzxT0Xk=@dannyvanheumen.nl> <a2d63d48-74bf-06e5-0b90-d046dd0966bd@gmail.com>
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
On Monday, July 4th, 2022 at 11:43, Arend Van Spriel <aspriel@gmail.com> wr=
ote:


> [..]
>
> It is good practice to throw in a changelog here so people know what has
> changed since earlier version of the patch.

That's fair enough. The commit message is updated.
Changes compared to v3:

- brcmf_sdiod_remove(..) disables functions in reverse order. It also claim=
s
  'func2' when disabling 'func2'. However, operations on 'func2' are always
  performed after claiming 'func1'. So this corrects mistake that deviates
  from convention.
- furthermore, following feedback from the kernel, irq is released for each
  individual function, but only func1 performs removal operations. This
  prevents the ordering issue from occurring.

> ---
>
> > .../broadcom/brcm80211/brcmfmac/bcmsdh.c | 31 ++++++++++++-------
> > .../broadcom/brcm80211/brcmfmac/sdio.c | 10 +-----
> > 2 files changed, 21 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c =
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> > index ac02244a6fdf..dd634edaa0b3 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>
>
> [...]
>
> > @@ -1096,12 +1093,24 @@ static void brcmf_ops_sdio_remove(struct sdio_f=
unc *func)
> > if (bus_if) {
> > sdiodev =3D bus_if->bus_priv.sdio;
> >
> > + if (func->num !=3D 1) {
> > + /* Satisfy kernel expectation that the irq is released once the
> > + * '.remove' callback has executed, while respecting the design
> > + * that removal is executed for 'sdiodev', instead of individual
> > + * function.
> > + /
> > + brcmf_dbg(SDIO, "Only release irq for function %d", func->num);
> > + sdio_claim_host(sdiodev->func1);
> > + sdio_release_irq(func);
> > + sdio_release_host(sdiodev->func1);
> > + return;
> > + }
> > +
> > + / func 1: so do full clean-up and removal */
> > +
>
>
> The problem is that upon driver unload we get remove for function 2 and
> then for function 1. Upon mmc_hw_reset() we get a remove for function 1
> and then for function 2. So in the scenario of mmc_hw_reset() we free
> sdiodev upon func 1 removal and then for func 2 removal we have a
> use-after-free of sdiodev.

I understood this. I recognize the different orders. However, there is a
false assumption regarding double-freeing. The removal logic in
'brcmf_ops_sdio_remove' is conditional on function number. Little is done
for any function that is not `func->num =3D=3D 1`. The proposed patch V4 fi=
ne-
tunes this behavior slightly. In this fine-tuning it mostly (completely)
negates order differences.

> The code currently relies on the order in
> which remove callback is done. To make it more robust we could throw in
> a refcount for sdiodev and only do the full clean-up when refcount hits
> zero.

Am I missing something else, maybe? If not, I think I have your concerns
covered.

Note that I have (and am) testing this patch on my own system. So far
without issue. I have run a script that resets the mmc device every 90
seconds to see if repeated use would cause issues. So far without issues.

Regards,
Danny

