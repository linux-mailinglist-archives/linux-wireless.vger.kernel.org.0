Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA6954260E
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jun 2022 08:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242850AbiFHBDn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Jun 2022 21:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1843878AbiFHALi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Jun 2022 20:11:38 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3E82C4FA2
        for <linux-wireless@vger.kernel.org>; Tue,  7 Jun 2022 12:45:29 -0700 (PDT)
Date:   Tue, 07 Jun 2022 19:45:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dannyvanheumen.nl;
        s=protonmail2; t=1654631127; x=1654890327;
        bh=C5DdC7B29tiGJTCh69OOxYeHGXyGpJ5tKKVknz0wD2s=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=V23rVERaRd1TFX+WDZh39PAR82eE1lIqdWMMYgeWgYYxFOcCziapA9WpmpXpGys8V
         RNmapwON4pd50qjqqEKx5sxykR6yX8BiRqG+uhd9yy0E52FrKajHidlFjHpLEanhnA
         AFg2vMvjbdyoq9Gzyt1+efcc9ukl3cb91WHjA1wx1oakTYyG/w6hHu27z41rYdvHHF
         ovfwuK9Nu9YDFpIr5pvEmYZ6RDr5Q4mNVECYzzdsRL1L1Hth/woXHa48ch7emcU+0P
         CjIlhfCkJIfxDWceCC8PdMVXial0RHGgZsy033mejmIjTN60Uw0LGNPiCZ/yMDdVJ5
         +xsR3tJzmprsA==
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
From:   Danny van Heumen <danny@dannyvanheumen.nl>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "SHA-cyfmac-dev-list@infineon.com" <SHA-cyfmac-dev-list@infineon.com>
Reply-To: Danny van Heumen <danny@dannyvanheumen.nl>
Subject: Re: [PATCH] work-in-progress: double-free after hardware reset due to firmware-crash
Message-ID: <kB9OdQYlBnucF05VoKxTvsT8eUrPGJc_we9irAdR-2gmXsEl4NvkhMzDcTahLm3HLA2zKVXnhEOstESbIEcHGKYHvMOyIcr4vh80f0eJCJ0=@dannyvanheumen.nl>
In-Reply-To: <1a116224-66ff-17b1-bb8b-9c0918dd47e4@broadcom.com>
References: <UXibAXk2GByhvw88A6LIDXHSlkP79-ML7FrtyfnHuiC34qUd-zx03BAJAtzluyEvfwPBR0tac4hC72zKI1qT3CtgmvvVohr1v8a49TqYVSw=@dannyvanheumen.nl> <Uba0mwWYafMZd4JdEJVxMd-Uh8M6T4dHoTse71YdCikdJLYLxunwtrxxbasffgMuXtPVi_JmJrtAnqviM6x-99_SyysHZm-Yvz933mPXr74=@dannyvanheumen.nl> <Y_XMhLmW7kj2Ls3X8pCfFd2RdWzXd9UWdv3ksFrVi7xh79wY7l6K52N3ODhI3_UK_IqG1uJcIEv0PxT-wQG9tdYu9krraq7gxsprUu-RtjQ=@dannyvanheumen.nl> <51CC1C7B-400C-4A7A-A5D3-EB457DC6862F@broadcom.com> <jJuvC2YezD_e1G6VFXwJjFFUAir0HFcDnBaZGRvKtnaY69v8aI3KkCouzzyOjrb9bZOnSzinETjNNxHvlmYCwNijdmts_5bEXZSV7dMNi0s=@dannyvanheumen.nl> <B08447EB-F222-49B5-A411-0DB6848A80ED@broadcom.com> <EbyrCYK_mR6ppJYbSc5JfGGG_QZEZb2Zp8Htx9f-orZ_wX0Dpz1pXhDjQ9P1nGuyTH041zvsScaRIPllClzLpLgwVuff4ZTTAiVOXe5-Mwg=@dannyvanheumen.nl> <1a116224-66ff-17b1-bb8b-9c0918dd47e4@broadcom.com>
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

Hi Arend,

------- Original Message -------
On Tuesday, June 7th, 2022 at 21:00, Arend van Spriel <arend.vanspriel@broa=
dcom.com> wrote:

> [..]
>
> > > While directly return without invoking clean up process makes
> > > perfect sense for the issue described here, it doesn=E2=80=99t addres=
s the
> > > broader issue that sdiodev might hold on to couple stale pointers tha=
t
> > > might subsequently be used in somewhere down the path because sdiodev=
 is
> > > not freed. Setting these pointer to NULL after freeing them could hel=
p
> > > us to catch such issue which is more catastrophic than a double-free.
> > > The perfect solution of course is to rework the code to free sdiodev
> > > whenever brcmf_sdiod_remove() is invoked but that can not be done in
> > > short-term unfortunately.
>
> > - True.
> > - If the two early returns are appropriate -- I think they are -- so
> > we can leave those in. (Again, I'm unfamiliar with the code-base.)
> > - Setting the pointer to NULL at least has the benefit that behavior
> > (even if bugged) is the same irrespective of memory allocation behavior=
.
> > - I checked your suggestion for 'sdiodev->sgtable': it is not a
>
> pointer, so setting to NULL will not help. If I read this correctly,
> 'sg_free_table(..)' is already resistant to multiple freeing attempts
> with a test of '.sgl'.
>
> > .. as for the control flow. Sure, rework would be nice, but -- to me
> > at least -- it is not clear if it is really necessary. Maybe I'm
> > mistaken, but there seem to be few entry-points to take into account.
> > The "hardware-reset after firmware-crash"-logic was added later IIUC, s=
o
> > maybe it was an oversight? Regardless, I have updated the patch.
>
> The reset-after-fw-crash was indeed added later. I am wondering is we
> can leave the remove-reprobe dance to the mmc core. Maybe mmc_hw_reset()
> could do the trick, ie. simply call mmc_hw_reset() in
> brcmf_sdio_bus_reset() and be done with it. Maybe opening a can of worms
> here, but I always felt uncertain about calling .remove and .probe
> callbacks directly from the driver itself as it may cause issue like
> this double-free, but also the bus is unaware and I don't know that is a
> bad thing or not.

I am pretty sure you found a can of worms indeed :-)

So, a few things to note:

- do you have a reliable way to test this behavior?
- from my PoV: I have encountered various compositions of firmware and uCod=
e
  for the BCM4345/9 (43456-sdio). Earlier versions may occasionally
  exhibit the crashing-behavior, but not reliably.
- do you want to tackle this as a separate effort, given that there is alre=
ady
  benefit in merging the earlier patch proposal?

Let me try to give my impression of the code, that I get from my cursory sc=
ans
through the brcmfmac code: it seems that the device as a whole (the "root")
gets activated. From what I remember, there seems to be a callback that
triggers subsequent initialization. So, it makes somewhat sense to me if a
hardware-reset could flow (back) into the existing initialization flow.
(Again, don't trust info below, as I have very limited knowledge in this do=
main.
I'm trying to check the extent to which I can make sense of it.)

Kind regards,
Danny



> Regards,
> Arend
>
> > > Also I forgot that our IT attached a legal footer to all emails sent
>
> to an external party. I am sorry about that to anyone reading my mail
> but there is nothing I can do at the moment.
>
> > > Thanks,
>
> > > - Franky
>
> > I have attached the updated patch. As mentioned before, I will be
>
> running the changes myself.
>
> > Regards,
>
> > Danny
>
> > > > So, returning immediately with the errorcode seemed more
>
> appropriate. Regardless, I have only
>
> > > > incidental knowledge from checking the code just for this
>
> particular problem. In the end my goal
>
> > > > is to have the issues addressed so that I am not forced to reboot
>
> my system to get it back in
>
> > > > working order.
>
> > > > As for your remark about sg-table: I had not considered that, but
>
> if my notes above check out,
>
> > > > maybe this does not need to be treated conditionally at all.
>
> > > > Kind regards,
>
> > > > Danny
>
> > > > > diff --git
>
> a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>
> > > > > index ac02244a6fdf..e9bad7197ba9 100644
>
> > > > > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>
> > > > > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>
> > > > > @@ -802,6 +802,7 @@ static void brcmf_sdiod_freezer_detach(struct
>
> brcmf_sdio_dev *sdiodev)
>
> > > > > if (sdiodev->freezer) {
>
> > > > > WARN_ON(atomic_read(&sdiodev->freezer->freezing));
>
> > > > > kfree(sdiodev->freezer);
>
> > > > > + sdiodev->freezer =3D NULL;
>
> > > > > }
>
> > > > > }
>
> > > > > @@ -885,7 +886,11 @@ int brcmf_sdiod_remove(struct brcmf_sdio_dev
>
> *sdiodev)
>
> > > > > sdio_disable_func(sdiodev->func1);
>
> > > > > sdio_release_host(sdiodev->func1);
>
> > > > > - sg_free_table(&sdiodev->sgtable);
>
> > > > > + if (sdiodev->sgtable) {
>
> > > > > + sg_free_table(&sdiodev->sgtable);
>
> > > > > + sdiodev->sgtable =3D NULL;
>
> > > > > + }
>
> > > > > +
>
> > > > > sdiodev->sbwad =3D 0;
>
> > > > > pm_runtime_allow(sdiodev->func1->card->host->parent);
>
> > > > > As for submitting patch to linux-wireless, please follow the
>
> guideline. [1]
>
> > > > > Thanks,
>
> > > > > - Franky
>
> > > > > [1]
>
> https://www.google.com/url?q=3Dhttps://wireless.wiki.kernel.org/en/develo=
pers/documentation/submittingpatches&source=3Dgmail-imap&ust=3D165495960400=
0000&usg=3DAOvVaw1Q6aXVZjiKkrq9qmyYVVDa
>
> > > --
>
> > > This electronic communication and the information and any files
>
> transmitted
>
> > > with it, or attached to it, are confidential and are intended solely =
for
>
> > > the use of the individual or entity to whom it is addressed and may
>
> contain
>
> > > information that is confidential, legally privileged, protected by
>
> privacy
>
> > > laws, or otherwise restricted from disclosure to anyone else. If you =
are
>
> > > not the intended recipient or the person responsible for delivering t=
he
>
> > > e-mail to the intended recipient, you are hereby notified that any us=
e,
>
> > > copying, distributing, dissemination, forwarding, printing, or
>
> copying of
>
> > > this e-mail is strictly prohibited. If you received this e-mail in
>
> error,
>
> > > please return the e-mail to the sender, delete it from your
>
> computer, and
>
> > > destroy any printed copy of it.
