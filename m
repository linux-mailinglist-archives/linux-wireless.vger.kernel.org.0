Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54B3566FBE
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Jul 2022 15:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbiGENqx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Jul 2022 09:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbiGENq1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Jul 2022 09:46:27 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B639421276
        for <linux-wireless@vger.kernel.org>; Tue,  5 Jul 2022 06:12:11 -0700 (PDT)
Date:   Tue, 05 Jul 2022 13:12:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dannyvanheumen.nl;
        s=protonmail2; t=1657026728; x=1657285928;
        bh=JIG7nPczcv5bzsWCu9+UEL66RUKapSV1XFm/87TWD5c=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=Dcnuaibh/pWl0I5cKSgg9oUOlHvh8ZsKqGiPNEyTP4Gx9onBWu8yFQvnrMlJt9kJ1
         ZYgVBR1CCiFhLrTuWIokq7Bw781DmN2iDSo/KAhiKIG5EmawKOjNG2s3kDcAS6WVzh
         7Rhur+esAEulcWIcE8pBJGpqiJpIXrN5DiYHoICnZNdlNkEU7oxJKVUdNEm0QAdVUK
         zMJtKsgS2iM4gTQMEm4lpp8Q1hCBoc8sQK/lzz3CLMKWF6hNHx5bkdoBene0xnlOBx
         DfeCuaIx5c/f+2GXoxXl3aDAh1HVnaFP/LTfnRXGTrc3hkxEvXhGfSQZg42YKrM5HW
         MD7eJMDh/Cugg==
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
From:   Danny van Heumen <danny@dannyvanheumen.nl>
Cc:     Arend Van Spriel <aspriel@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Reply-To: Danny van Heumen <danny@dannyvanheumen.nl>
Subject: Re: [PATCH v4] brcmfmac: prevent double-free on hardware-reset
Message-ID: <Ev2sGFWgWlkty5T3AbZMd-KmLY_PJiasOdrKka6OuNmLFBSOet2lSDVUj8_x3lKuJ-lNLkAdDKwzkeS9rEIGLXb3RwDhrkBMyESbuTRcu90=@dannyvanheumen.nl>
In-Reply-To: <48f31e63-f4de-faf9-3c8c-eb2bdd8a2b04@broadcom.com>
References: <g_Py6bM1lfcJOWWmHwKU8x4tCFrTRdgFtoM13qYHeN441F392j_6etJnEJ8gHJMRZ6OEKxpJYuP45x3iziHqY6HNXnVwIiyvJLYjvzxT0Xk=@dannyvanheumen.nl> <a2d63d48-74bf-06e5-0b90-d046dd0966bd@gmail.com> <SpNFVBNIoAMOViIfL2pA_NfZkIX1ldRs865SC5DNvEzTfnDVAQALh3ugJVVMnWZ6XZDQI9L85yb0TEhzjKMTt8CjZuXW8mE-FY6GMSoWCs4=@dannyvanheumen.nl> <b9af59ff-d218-69d6-35b6-eedbd8a7eb6b@gmail.com> <aK4oYk4CE84W9CQcWokt10umUlVCVt4DUEHbuT1e6euFshQ5CC4Hu5svEL0qhPF6W-LYeu8-EUNMfc4odaYa-LyxofrBZt_6KhkiE0sfwp8=@dannyvanheumen.nl> <48f31e63-f4de-faf9-3c8c-eb2bdd8a2b04@broadcom.com>
Feedback-ID: 15073070:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

------- Original Message -------
On Tuesday, July 5th, 2022 at 10:50, Arend van Spriel <arend.vanspriel@broa=
dcom.com> wrote:

> [..]
> >
> > The SDIODEV struct is hard-coded for 2 functions. The function
> > `brcmf_sdiod_intr_unregister` unregisters for the whole devices, i.e.
> > two functions simultaneously. The OOB interrupt handling is
> > function-independent. It takes a sdiodev pointer to work with. In
> > addition, the code facilitates the request of a single OOB interrupt,
> > i.e. a single one for the device as a whole.
>
> Okay. Forgot the internals of brcmf_sdiod_intr_unregister(). My elephant
> brain is failing ;-)

Okay.


> > Regarding the sdio-irq-claim/release, these are function-bound.
> > However, as mentioned before, `brcmf_sdiod_intr_unregister` handles
> > both functions at once. This code does not handle `func` for the functi=
on
> > currently being iterated on. Only a whole device.
> >
> > From how I read the code, this logic is scoped to SDIO-based devices.
> > Plz correct if this is interpretation is wrong.
>
>
> I stand corrected in this.

Okay.


> > > So your change does
> > > not add anything for devices/platforms employing the SDIO interrupt, =
but
> > > it does break those using OOB interrupt.
> >
> > It adds for SDIO-based interrupt handling that the interrupt gets relea=
sed
> > for the function that is being iterated on for removal. Therefore, it
> > satisfies the expectations of the SDIO subsystem which otherwise emits =
a
> > warning about an irq not having been freed.
> >
> > AFAICT OOB handling does not change: it still executes once. After that=
,
> > the flag `oob_irq_requested` is false. The benefit we create, is that
> > `brcmf_sdiod_intr_unregister` now only executes for func1, instead of
> > either func1 or func2 depending on iteration order.
>
> But does that matter. brcmf_sdiod_intr_unregister() will do any real
> stuff only once, right? Regardless which func comes first it will
> release both func1 and func2 irq. Does it matter? I don't see enough
> benefit to add code for it.

Does it? You can probably judge this better than I can.

What I read, is that the interrupt release logic is processed twice. And
you have recently put a lot of emphasis on potential ordering problems.
So, this is my proposal to somewhat stream-line the logic to per-func
behavior, instead of doing everything at func1 and func2 is or isn't
processed at all. I do not have a strong opinion.

> > [..]
> >
> > That is correct, but in `brcmf_ops_sdio_remove`:
> >
> > `dev_set_drvdata(&sdiodev->func1->dev, NULL); dev_set_drvdata(&sdiodev-=
>func2->dev, NULL);`
> >
> > set those pointers to NULL. So, in the use case where we process functi=
ons
> > in increasing order, `func1` will result in full device clean-up. `func=
2`
> > will result in `bus_if` (func->dev) being NULL, therefore exits immedia=
tely.
>
> That's a relieve.
>
> > So, I see two use cases:
> >
> > 1.) we iterate in decreasing order: release irq for func2 first, then d=
o
> > full clean-up in func1.
> > 2.) we iterate in increasing order: do full clean-up in func1, then ski=
p
> > clean-up for func2 due to NULL bus_if.
> >
> > > In the portion above you have:
> > >
> > > sdio_claim_host(sdiodev->func1);
> > >
> > > When brcmf_ops_sdio_remove is called for func 2 (and even func 3) [..=
]
> >
> > `func3` does not exist from what I read in the code. Can you point me t=
o
> > the logic that I have missed?
>
> We don't use/claim func3, but some devices report a func3 and the
> mmc/sdio subsystem will probe the driver with a func3. However, as we
> never claim it we will not be called for func3 so please ignore my
> blabbering about that.

Okay, so what I understand from the response right now, is that we mostly
agree on the implementation except maybe for the interrupt clean up.

For the interrupt clean-up, I guess it may be determined by how strongly yo=
u
want to tie the clean-up logic to func1 vs. the first func to be iterated o=
n.

Regards,
Danny

