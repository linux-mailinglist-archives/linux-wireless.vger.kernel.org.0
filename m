Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD8C53D763
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Jun 2022 17:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237102AbiFDPAV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Jun 2022 11:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237689AbiFDPAI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Jun 2022 11:00:08 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26B52EA13
        for <linux-wireless@vger.kernel.org>; Sat,  4 Jun 2022 08:00:06 -0700 (PDT)
Date:   Sat, 04 Jun 2022 14:59:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dannyvanheumen.nl;
        s=protonmail2; t=1654354801; x=1654614001;
        bh=CaIKHW9IpR3uwvvAJ5S/+qjR5x5LFqm3na/+pKJ115E=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=aTyyeJcKu1oPqdvCPOnJomyr3SHlfPHmDrVcMijMhjcCG1aJtOkAl6pvQ/IZt+c6q
         Iz9UgiDlXhLYGcaWdH1IpNCHV+deSFbfXHNiijYmZ6uFTpkSBzx6whhzcoVXvD+jo2
         genab3WIeRQm0aNp1vzMuNjXz0VHDYRl78wQo6DUYfBGuwfhx6r1QZjyZsjnFZtBNC
         uGYTLaK9OHrxNa3SB8RJcbJl6RRPhWfSmCC5sJmPUzCZxPDY0W8JizAwSlvNeTfU+a
         8NI1zRkYuAbhLrlOq0XHkgkw/ZDXewvc5YuWMT4RggNCxKtD2pHLTTtka/2RTdAcbF
         LjiM/Kwihn3kw==
To:     Franky Lin <franky.lin@broadcom.com>
From:   Danny van Heumen <danny@dannyvanheumen.nl>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "SHA-cyfmac-dev-list@infineon.com" <SHA-cyfmac-dev-list@infineon.com>
Reply-To: Danny van Heumen <danny@dannyvanheumen.nl>
Subject: Re: [PATCH] work-in-progress: double-free after hardware reset due to firmware-crash
Message-ID: <jJuvC2YezD_e1G6VFXwJjFFUAir0HFcDnBaZGRvKtnaY69v8aI3KkCouzzyOjrb9bZOnSzinETjNNxHvlmYCwNijdmts_5bEXZSV7dMNi0s=@dannyvanheumen.nl>
In-Reply-To: <51CC1C7B-400C-4A7A-A5D3-EB457DC6862F@broadcom.com>
References: <UXibAXk2GByhvw88A6LIDXHSlkP79-ML7FrtyfnHuiC34qUd-zx03BAJAtzluyEvfwPBR0tac4hC72zKI1qT3CtgmvvVohr1v8a49TqYVSw=@dannyvanheumen.nl> <Uba0mwWYafMZd4JdEJVxMd-Uh8M6T4dHoTse71YdCikdJLYLxunwtrxxbasffgMuXtPVi_JmJrtAnqviM6x-99_SyysHZm-Yvz933mPXr74=@dannyvanheumen.nl> <Y_XMhLmW7kj2Ls3X8pCfFd2RdWzXd9UWdv3ksFrVi7xh79wY7l6K52N3ODhI3_UK_IqG1uJcIEv0PxT-wQG9tdYu9krraq7gxsprUu-RtjQ=@dannyvanheumen.nl> <51CC1C7B-400C-4A7A-A5D3-EB457DC6862F@broadcom.com>
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

Hi Franky,

------- Original Message -------
On Saturday, June 4th, 2022 at 00:58, Franky Lin <franky.lin@broadcom.com> =
wrote:

> Hi Danny,
>
> [..]
>
> Thanks for reporting and sending out a patch to fix this.
>
> If the problem is double freeing the freezer buffer, it should be address=
ed from the root by setting pointer to NULL. Same thing might need to be do=
ne for sg table as well. Sorry I don=E2=80=99t have any sdio module to repr=
oduce and test. Please see if the below change fixes the problem.

Your suggestion to set the freeze buffer address to zero was also my first =
proposal. I have since
revised, because there are a few things I considered, although I am not sur=
e:

- does zero-ing the address prevent future detection of double-frees with t=
he hardened memory
  allocator? (If so, I would prefer to avoid doing this.)
- IIUC correctly, 'sdio_set_block_size' does not do any meaningful "activat=
ion" or "allocation".
  Therefore would not need to be *undone*. (repeated probes would override =
previous calls)
- Starting with the call 'sdio_enable_func', I guess/suspect more elaborate=
 "cleanup" is necessary
  therefore, leaving the 'goto out' from that point on. I would assume (for=
 lack of evidence to the
  contrary) that the logic at 'goto out' provides proper clean-up.

So, returning immediately with the errorcode seemed more appropriate. Regar=
dless, I have only
incidental knowledge from checking the code just for this particular proble=
m. In the end my goal
is to have the issues addressed so that I am not forced to reboot my system=
 to get it back in
working order.

As for your remark about sg-table: I had not considered that, but if my not=
es above check out,
maybe this does not need to be treated conditionally at all.

Kind regards,
Danny

> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/=
drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> index ac02244a6fdf..e9bad7197ba9 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> @@ -802,6 +802,7 @@ static void brcmf_sdiod_freezer_detach(struct brcmf_s=
dio_dev *sdiodev)
> if (sdiodev->freezer) {
>
> WARN_ON(atomic_read(&sdiodev->freezer->freezing));
>
> kfree(sdiodev->freezer);
>
> + sdiodev->freezer =3D NULL;
>
> }
> }
>
> @@ -885,7 +886,11 @@ int brcmf_sdiod_remove(struct brcmf_sdio_dev *sdiode=
v)
> sdio_disable_func(sdiodev->func1);
>
> sdio_release_host(sdiodev->func1);
>
>
> - sg_free_table(&sdiodev->sgtable);
>
> + if (sdiodev->sgtable) {
>
> + sg_free_table(&sdiodev->sgtable);
>
> + sdiodev->sgtable =3D NULL;
>
> + }
> +
> sdiodev->sbwad =3D 0;
>
>
> pm_runtime_allow(sdiodev->func1->card->host->parent);
>
>
> As for submitting patch to linux-wireless, please follow the guideline. [=
1]
>
> Thanks,
> - Franky
>
> [1] https://wireless.wiki.kernel.org/en/developers/documentation/submitti=
ngpatches
>
>
>
> --
> This electronic communication and the information and any files transmitt=
ed
> with it, or attached to it, are confidential and are intended solely for
> the use of the individual or entity to whom it is addressed and may conta=
in
> information that is confidential, legally privileged, protected by privac=
y
> laws, or otherwise restricted from disclosure to anyone else. If you are
> not the intended recipient or the person responsible for delivering the
> e-mail to the intended recipient, you are hereby notified that any use,
> copying, distributing, dissemination, forwarding, printing, or copying of
> this e-mail is strictly prohibited. If you received this e-mail in error,
> please return the e-mail to the sender, delete it from your computer, and
> destroy any printed copy of it.
