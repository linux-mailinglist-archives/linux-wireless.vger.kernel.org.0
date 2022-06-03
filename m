Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375E053D1A7
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jun 2022 20:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346922AbiFCSkN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jun 2022 14:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244339AbiFCSjS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jun 2022 14:39:18 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E24CC6
        for <linux-wireless@vger.kernel.org>; Fri,  3 Jun 2022 11:39:15 -0700 (PDT)
Date:   Fri, 03 Jun 2022 18:39:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dannyvanheumen.nl;
        s=protonmail2; t=1654281553; x=1654540753;
        bh=Cq0/pCC/saQhbhE+l3whMTZvXQSRJ5YdHrdQJ0ldUkk=;
        h=Date:To:From:Reply-To:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=CUAnnq3sJZKviJfbfCDqdqRhBBfsNMlxRJE8zdMDu3uf8/4Dtk/2VfF5VWERJJuqo
         /42V5TRfw15pvIjkqo0FcwdCWfbBG27c06gZNX/4obJ9gSSKlN2uraCPANa+k76VaW
         J15qo9XgQZ+gRkjQGGDwGJ4Ohc38WEJG1Pdwe45DRQMZn21C7GObZj62cX9UpOQHbU
         Vn6LLpVdoDG6UNsN+Lo4eljvlSogPuEt096Y48qj5NL5n73moVMUAlyFifUQTqcsNW
         VffHyOgCHZi5DMPUENnZojl39REz2TJs3LA5O8jjjTieYGZYMwe51kMalBxtUkc++7
         RDugzKVmbVGUw==
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "SHA-cyfmac-dev-list@infineon.com" <SHA-cyfmac-dev-list@infineon.com>
From:   Danny van Heumen <danny@dannyvanheumen.nl>
Reply-To: Danny van Heumen <danny@dannyvanheumen.nl>
Subject: Re: [PATCH] work-in-progress: double-free after hardware reset due to firmware-crash
Message-ID: <Y_XMhLmW7kj2Ls3X8pCfFd2RdWzXd9UWdv3ksFrVi7xh79wY7l6K52N3ODhI3_UK_IqG1uJcIEv0PxT-wQG9tdYu9krraq7gxsprUu-RtjQ=@dannyvanheumen.nl>
In-Reply-To: <Uba0mwWYafMZd4JdEJVxMd-Uh8M6T4dHoTse71YdCikdJLYLxunwtrxxbasffgMuXtPVi_JmJrtAnqviM6x-99_SyysHZm-Yvz933mPXr74=@dannyvanheumen.nl>
References: <UXibAXk2GByhvw88A6LIDXHSlkP79-ML7FrtyfnHuiC34qUd-zx03BAJAtzluyEvfwPBR0tac4hC72zKI1qT3CtgmvvVohr1v8a49TqYVSw=@dannyvanheumen.nl> <Uba0mwWYafMZd4JdEJVxMd-Uh8M6T4dHoTse71YdCikdJLYLxunwtrxxbasffgMuXtPVi_JmJrtAnqviM6x-99_SyysHZm-Yvz933mPXr74=@dannyvanheumen.nl>
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

------- Original Message -------
On Monday, May 30th, 2022 at 19:59, Danny van Heumen <danny@dannyvanheumen.=
nl> wrote:

> Hi all,
>
> I'd like to follow up with an updated patch. I had another look at the co=
de. I think the
> following proposal may correct the control flow to prevent the double-fre=
e from happening
> in the first place.
>
> Again, I would appreciate any feedback you might have, as I have little e=
xperience in this
> area. A stacktrace is present in the commit message, in case you are look=
ing for extra data
> that demonstrates the issue.

Could someone follow up on this?

I have not received any response, so it is not clear to me if the patch is =
the issue,
or whether it is something else. I am running these changes on my Pinebook =
Pro laptop,
so far without issue.

Thanks in advance,
Danny


> [..]
>
> ------- Original Message -------
> On Tuesday, May 24th, 2022 at 18:51, Danny van Heumen danny@dannyvanheume=
n.nl wrote:
>
>
>
> > Dear all,
> >
> > I am not a regular C developer nor kernel developer. I don't regularly =
report issues, so I will probably do things wrong.
> >
> > I investigated a crash that IIUC occurs with hardened memory allocation=
 enabled and a firmware-crash followed by an early failure during hardware =
reinitialization/probing. The hardened allocator detects double-free issue.
> >
> > I have created the patch (see attachment) against linux-5.18. Though, p=
lease check carefully, because I have not been able to confirm that it actu=
ally works. I am hoping someone familiar with the code-base can either test=
 this easily, or confirm from review/analysis.
> >
> > The commit message describes it in more detail. In summary:
> > 'brcmf_sdio_bus_reset' cleans up and reinitializes the hardware. It fre=
es memory used by (struct brcmf_sdio_dev)->freezer (struct brcmf_sdiod_free=
zer). However, it then goes to probe the hardware, and an early failure to =
probe results in the same freeing, both called through function 'brcmf_sdio=
d_freezer_detach' called inside 'brcmf_sdiod_remove'. Which results in doub=
le freeing.
> >
> > As mentioned before, I was not able to test this and I do not regularly=
 develop in C. I am not confident that this is the proper way to fix it, bu=
t it seemed obvious enough. I hope you can support in fixing this bug.
> >
> > Kind regards,
> > Danny
> >
> > PS: Please let me know if I am doing things wrong. I have included both=
 maintainers and mailing lists from https://docs.kernel.org/process/maintai=
ners.html#broadcom-brcm80211-ieee802-11n-wireless-driver I hope I this is a=
lright.
