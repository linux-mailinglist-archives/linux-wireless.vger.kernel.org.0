Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42BC839D85D
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jun 2021 11:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhFGJQa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Jun 2021 05:16:30 -0400
Received: from mail-0301.mail-europe.com ([188.165.51.139]:59899 "EHLO
        mail-03.mail-europe.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230313AbhFGJQ3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Jun 2021 05:16:29 -0400
Date:   Mon, 07 Jun 2021 09:14:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1623057274;
        bh=SJ4bJ7pSsobzQcPEUXmp3AThcrnqPBd/XtDWRDJaZu8=;
        h=Date:To:From:Reply-To:Subject:In-Reply-To:References:From;
        b=KZhhykacgVeCxnXVrid8V2KBzWmDjtcZHxhYkLs92NjvadugVogRE24NAPNkPRUZ4
         n2knSdBcyPLudH3PJGQJ4DkaAqDVe6sGX4TC+ngiU72rJmmwhNuiUDpyNzsBkIiSdt
         IPMxbXp7POwc4dMwHr9oDN/scw+gS4oI6GT1OZF0=
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   rtl8821cerfe2 <rtl8821cerfe2@protonmail.com>
Reply-To: rtl8821cerfe2 <rtl8821cerfe2@protonmail.com>
Subject: Re: rtw88: Guaranteed system freeze with RTL8821CE with RFE 2 type
Message-ID: <W68Ww5UFZgiYqnd1iBRJvRdWn21m66TPzi-I0qCUHYtvmg00Og-sjxQvD6o8crwwChp_b8AK0wKe7AcLW06ITagwVJYozDgmshbSA7HD-x4=@protonmail.com>
In-Reply-To: <8016eaac-de68-8438-8032-7b557157b0dd@lwfinger.net>
References: <vWuRjLpNOkVGXHNeCL6phN5YDcd6Oljm1WgEMO4vA9aufK8MxzN5itvDnRjPBWHZN0geAbRLAzgIj36kAiNtdHh5vg2RjUH_TzuqZ7WSYeE=@protonmail.com> <65c86fe7-f1f1-445f-40c2-25ceaa4e4fb6@lwfinger.net> <1jmF9EMZn2ywrHSGrNCzOUSAzllw9ox-Da2zfbSTnTULlX8Ha8F211TfKuxITBBtkfxiU_R0w7zUeFLdtDj4ejp6qPnCIhFj2U-rsCVNlMg=@protonmail.com> <Qg7Ae-IznoeEC_X2m_4XXKRlM-yT3O7dzdbZ0egHTsdEaA0uILKZ0uBymFMrN7aI38rz-ZTKSxTDUAU4tKJPIntXELdx9Rd0MIU5sSG_VCI=@protonmail.com> <ZJknGMd-LYMAOQNAoIsR9G59_Wlt9uYUPzzJ_v2p3W8kCQ_gIQ_ymF09TV83SN0h5Md0tyzlpIxTjCMkK88gXOkSI5UA_knH6RGUd4ITHrA=@protonmail.com> <d65a162e-9d0c-fff9-65e3-4553a1981ad3@lwfinger.net> <M6B18j30lqREPrsrfDN_5xjiWeKoy7uO6P-kqZiVk2pSFN0c8ioDQK6qymbdV-yXDV0W0bt0UP9PDQKzbnWfa3LjubFUw6mLI6WmqKs3br8=@protonmail.com> <8016eaac-de68-8438-8032-7b557157b0dd@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.7 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org




Sent with ProtonMail Secure Email.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Wednesday, May 26, 2021 10:03 PM, Larry Finger <Larry.Finger@lwfinger.ne=
t> wrote:

> On 5/23/21 1:36 PM, rtl8821cerfe2 wrote:
>
> > On Thursday, May 20, 2021 8:51 AM, Larry Finger Larry.Finger@lwfinger.n=
et wrote:
> >
> > > On 5/19/21 4:00 PM, rtl8821cerfe2 wrote:
> > >
> > > > On Monday, May 10, 2021 4:49 PM, rtl8821cerfe2 rtl8821cerfe2@proton=
mail.com wrote:
> > > >
> > > > > On Monday, May 10, 2021 3:06 PM, rtl8821cerfe2 rtl8821cerfe2@prot=
onmail.com wrote:
> > > > > disable_lps_deep=3D1 did not help.
> > > > > The patch set called "rtw88: add scan notify to firmware and refi=
ne fw_feature check" may have fixed this problem. I've been running commit =
6ccdad5a58e18eac6b1335f05f94bf2b36146e00 from lwfinger/rtw88 for 3 days now=
 with no freeze. It was impossible to go more than a few hours without a fr=
eeze before these patches.
> > >
> > > Sounds good. I will keep porting the patches submitted to wreless-dri=
vers-next
> > > to the rtw88 repo at GitHub. I have no idea why this would preclude a=
 system
> > > freeze, but the Realtek guys might.
> > > Larry
> >
> > I spoke too soon. It does still freeze even with that patch set.
>
> Can you provide any more information about the freezes? As I recall, you =
did say
> that nothing was logged, but are the CPU fans working hard indicating the=
 the
> CPU is active? On the desktop, does the mouse pointer move?
>
> Larry

Sorry, I forgot to check my email.

Nothing was logged, the CPU fan was spinning at a normal speed which is bar=
ely audible, and the mouse pointer didn't move anymore.

Also, I tried the rtw_core option debug_mask=3D65535, which activates all t=
he debug messages available, hoping to capture some useful information duri=
ng the freeze, but with that option the freeze didn't happen. This suggests=
 to me a timing problem, but who knows. I'm mostly clueless about kernel pr=
ogramming.
