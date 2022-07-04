Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C97565E9A
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jul 2022 22:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbiGDUnl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jul 2022 16:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiGDUnk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jul 2022 16:43:40 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5EF2630
        for <linux-wireless@vger.kernel.org>; Mon,  4 Jul 2022 13:43:37 -0700 (PDT)
Date:   Mon, 04 Jul 2022 20:43:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dannyvanheumen.nl;
        s=protonmail2; t=1656967414; x=1657226614;
        bh=Kn8C+jJD9itVMGYKd9mC/W5tODsQtM+ePzyn8v2tazI=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=NMkF7VSp2v3Rg1Nut0u4JmNQf5Tif7IMFTxNe5Gmcc71jfHIx8BLDaiEppkGYDHNS
         QpKXvHr9V+hUJomTTT2SfRGizot42GmuyNhgzrVKsfDEsbK+8jgXw0hd8QvOC/zvAs
         7Nw05Q+BjubALE0Yd5J3qD+grmDehbFyBx0XZgg0pmc0W+CUPm5hIEQo/l8fzPpvJJ
         Q5vzVbOqsdd3kHxHwZDX1cRJvz64Cv4ldJbmniQJdR2pvh+xBiXHAbbOzC3lLA+UlR
         W00ewUsdNlB5fXhZ4Q+HhZgY168ZwnSJqM9wxh0PkM8K7SgQ9UsZpfD8HcxEJnjPb3
         fNAyZTK7wmFVA==
To:     Arend Van Spriel <aspriel@gmail.com>
From:   Danny van Heumen <danny@dannyvanheumen.nl>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Reply-To: Danny van Heumen <danny@dannyvanheumen.nl>
Subject: Re: [PATCH v4] brcmfmac: prevent double-free on hardware-reset
Message-ID: <aK4oYk4CE84W9CQcWokt10umUlVCVt4DUEHbuT1e6euFshQ5CC4Hu5svEL0qhPF6W-LYeu8-EUNMfc4odaYa-LyxofrBZt_6KhkiE0sfwp8=@dannyvanheumen.nl>
In-Reply-To: <b9af59ff-d218-69d6-35b6-eedbd8a7eb6b@gmail.com>
References: <g_Py6bM1lfcJOWWmHwKU8x4tCFrTRdgFtoM13qYHeN441F392j_6etJnEJ8gHJMRZ6OEKxpJYuP45x3iziHqY6HNXnVwIiyvJLYjvzxT0Xk=@dannyvanheumen.nl> <a2d63d48-74bf-06e5-0b90-d046dd0966bd@gmail.com> <SpNFVBNIoAMOViIfL2pA_NfZkIX1ldRs865SC5DNvEzTfnDVAQALh3ugJVVMnWZ6XZDQI9L85yb0TEhzjKMTt8CjZuXW8mE-FY6GMSoWCs4=@dannyvanheumen.nl> <b9af59ff-d218-69d6-35b6-eedbd8a7eb6b@gmail.com>
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

Hi,

I'll respond to your comments one-by-one. I will include some of my
reasoning to help clarify.

------- Original Message -------
On Monday, July 4th, 2022 at 20:52, Arend Van Spriel <aspriel@gmail.com> wr=
ote:

> On 7/4/2022 4:49 PM, Danny van Heumen wrote:
>
> > Hi Arend,
> >
> > ------- Original Message -------
> > On Monday, July 4th, 2022 at 11:43, Arend Van Spriel aspriel@gmail.com =
wrote:
> >
> > > [..]
> > >
> > > It is good practice to throw in a changelog here so people know what =
has
> > > changed since earlier version of the patch.
> >
> > That's fair enough. The commit message is updated.
> > Changes compared to v3:
> >
> > - brcmf_sdiod_remove(..) disables functions in reverse order. It also c=
laims
> > 'func2' when disabling 'func2'. However, operations on 'func2' are alwa=
ys
> > performed after claiming 'func1'. So this corrects mistake that deviate=
s
> > from convention.
> > - furthermore, following feedback from the kernel, irq is released for =
each
> > individual function, but only func1 performs removal operations. This
> > prevents the ordering issue from occurring.
> >
> > > ---
> > >
> > > > .../broadcom/brcm80211/brcmfmac/bcmsdh.c | 31 ++++++++++++-------
> > > > .../broadcom/brcm80211/brcmfmac/sdio.c | 10 +-----
> > > > 2 files changed, 21 insertions(+), 20 deletions(-)
> > > >
> > > > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsd=
h.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> > > > index ac02244a6fdf..dd634edaa0b3 100644
> > > > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> > > > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> > >
> > > [...]
> > >
> > > > @@ -1096,12 +1093,24 @@ static void brcmf_ops_sdio_remove(struct sd=
io_func *func)
> > > > if (bus_if) {
> > > > sdiodev =3D bus_if->bus_priv.sdio;
> > > >
> > > > + if (func->num !=3D 1) {
> > > > + /* Satisfy kernel expectation that the irq is released once the
> > > > + * '.remove' callback has executed, while respecting the design
> > > > + * that removal is executed for 'sdiodev', instead of individual
> > > > + * function.
> > > > + /
> > > > + brcmf_dbg(SDIO, "Only release irq for function %d", func->num);
> > > > + sdio_claim_host(sdiodev->func1);
> > > > + sdio_release_irq(func);
> > > > + sdio_release_host(sdiodev->func1);
> > > > + return;
>
>
> Actually this is wrong. Before the function
> brcmf_sdiod_intr_unregister() was called for every sdio function
> instance.


We are in agreement here.


> That function does exactly the same as the above and more. On
> some platforms the device does not used the SDIO interrupt, but instead
> it uses what we call an OOB interrupt (out-of-band).

The SDIODEV struct is hard-coded for 2 functions. The function
`brcmf_sdiod_intr_unregister` unregisters for the whole devices, i.e.
two functions simultaneously. The OOB interrupt handling is
function-independent. It takes a sdiodev pointer to work with. In
addition, the code facilitates the request of a single OOB interrupt,
i.e. a single one for the device as a whole.

Regarding the sdio-irq-claim/release, these are function-bound.
However, as mentioned before, `brcmf_sdiod_intr_unregister` handles
both functions at once. This code does not handle `func` for the function
currently being iterated on. Only a whole device.

From how I read the code, this logic is scoped to SDIO-based devices.
Plz correct if this is interpretation is wrong.


> So your change does
> not add anything for devices/platforms employing the SDIO interrupt, but
> it does break those using OOB interrupt.

It adds for SDIO-based interrupt handling that the interrupt gets released
for the function that is being iterated on for removal. Therefore, it
satisfies the expectations of the SDIO subsystem which otherwise emits a
warning about an irq not having been freed.

AFAICT OOB handling does not change: it still executes once. After that,
the flag `oob_irq_requested` is false. The benefit we create, is that
`brcmf_sdiod_intr_unregister` now only executes for func1, instead of
either func1 or func2 depending on iteration order.

>
> > > > + }
> > > > +
> > > > + / func 1: so do full clean-up and removal */
> > > > +
> > >
> > > The problem is that upon driver unload we get remove for function 2 a=
nd
> > > then for function 1. Upon mmc_hw_reset() we get a remove for function=
 1
> > > and then for function 2. So in the scenario of mmc_hw_reset() we free
> > > sdiodev upon func 1 removal and then for func 2 removal we have a
> > > use-after-free of sdiodev.
> >
> > I understood this. I recognize the different orders. However, there is =
a
> > false assumption regarding double-freeing. The removal logic in
> > 'brcmf_ops_sdio_remove' is conditional on function number. Little is do=
ne
> > for any function that is not `func->num =3D=3D 1`. The proposed patch V=
4 fine-
> > tunes this behavior slightly. In this fine-tuning it mostly (completely=
)
> > negates order differences.
> >
> > > The code currently relies on the order in
> > > which remove callback is done. To make it more robust we could throw =
in
> > > a refcount for sdiodev and only do the full clean-up when refcount hi=
ts
> > > zero.
> >
> > Am I missing something else, maybe? If not, I think I have your concern=
s
> > covered.
>
>
> I think you are. The function brcmf_sdiod_remove() does end-up freeing
> the sdiodev instance. brcmf_sdiod_remove() for func 1, but in
> brcmf_ops_sdio_remove() we do dereference sdiodev instance for all
> functions.

That is correct, but in `brcmf_ops_sdio_remove`:

```
dev_set_drvdata(&sdiodev->func1->dev, NULL);
dev_set_drvdata(&sdiodev->func2->dev, NULL);
```

set those pointers to NULL. So, in the use case where we process functions
in increasing order, `func1` will result in full device clean-up. `func2`
will result in `bus_if` (func->dev) being NULL, therefore exits immediately=
.

So, I see two use cases:

1.) we iterate in decreasing order: release irq for func2 first, then do
    full clean-up in func1.
2.) we iterate in increasing order: do full clean-up in func1, then skip
    clean-up for func2 due to NULL bus_if.


> In the portion above you have:
>
> sdio_claim_host(sdiodev->func1);
>
> When brcmf_ops_sdio_remove is called for func 2 (and even func 3) [..]

`func3` does not exist from what I read in the code. Can you point me to
the logic that I have missed?


> [..] after func 1 has been removed sdiodev points to memory already free.

Not sure if we are considering the same use case, but if called from
`brcmf_sdiod_remove` within `brcmf_ops_sdio_remove`: this is called before
NULLing and '..._disable' does not clear. And then, is only called once.

Regards,
Danny

