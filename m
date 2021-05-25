Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DEC38FF68
	for <lists+linux-wireless@lfdr.de>; Tue, 25 May 2021 12:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhEYKlJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 May 2021 06:41:09 -0400
Received: from mail-40135.protonmail.ch ([185.70.40.135]:12372 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhEYKlI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 May 2021 06:41:08 -0400
Date:   Tue, 25 May 2021 10:39:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1621939177;
        bh=REt5iF3DDoMYsZiGWymRR6sSMUWbj4eVoAcBwr/Pc3w=;
        h=Date:To:From:Reply-To:Subject:In-Reply-To:References:From;
        b=bpUvcwFpyJNv1aFMnylr9l48/m7GtKdkH/MD6EpejqZkL/fH/pLmOnMQa6ouX7YtN
         yEpz0k651MRyBMuPpge6XbzJ57vNpbgM8aCtEQaorRJuVvYcbw+QVGWRu5iEY9bokD
         Gao/uXKsJukErWA7XctBE0QRRU2oJRUJqIqKJ9E0=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   rtl8821cerfe2 <rtl8821cerfe2@protonmail.com>
Reply-To: rtl8821cerfe2 <rtl8821cerfe2@protonmail.com>
Subject: Re: rtw88: Guaranteed system freeze with RTL8821CE with RFE 2 type
Message-ID: <hXlLGR-ccu9ozKXl1rsCyt7jWfmH0ufgepYDXU9dkZUYJWDmwjflabUNuxh-XWDeey4GQRjaSmtSIEqFsY5mieunEOMCTawMpyFzW9dbA0A=@protonmail.com>
In-Reply-To: <d65a162e-9d0c-fff9-65e3-4553a1981ad3@lwfinger.net>
References: <vWuRjLpNOkVGXHNeCL6phN5YDcd6Oljm1WgEMO4vA9aufK8MxzN5itvDnRjPBWHZN0geAbRLAzgIj36kAiNtdHh5vg2RjUH_TzuqZ7WSYeE=@protonmail.com> <65c86fe7-f1f1-445f-40c2-25ceaa4e4fb6@lwfinger.net> <1jmF9EMZn2ywrHSGrNCzOUSAzllw9ox-Da2zfbSTnTULlX8Ha8F211TfKuxITBBtkfxiU_R0w7zUeFLdtDj4ejp6qPnCIhFj2U-rsCVNlMg=@protonmail.com> <Qg7Ae-IznoeEC_X2m_4XXKRlM-yT3O7dzdbZ0egHTsdEaA0uILKZ0uBymFMrN7aI38rz-ZTKSxTDUAU4tKJPIntXELdx9Rd0MIU5sSG_VCI=@protonmail.com> <ZJknGMd-LYMAOQNAoIsR9G59_Wlt9uYUPzzJ_v2p3W8kCQ_gIQ_ymF09TV83SN0h5Md0tyzlpIxTjCMkK88gXOkSI5UA_knH6RGUd4ITHrA=@protonmail.com> <d65a162e-9d0c-fff9-65e3-4553a1981ad3@lwfinger.net>
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

On Thursday, May 20, 2021 8:51 AM, Larry Finger <Larry.Finger@lwfinger.net>=
 wrote:

> On 5/19/21 4:00 PM, rtl8821cerfe2 wrote:
>
> > On Monday, May 10, 2021 4:49 PM, rtl8821cerfe2 rtl8821cerfe2@protonmail=
.com wrote:
> > > On Monday, May 10, 2021 3:06 PM, rtl8821cerfe2 rtl8821cerfe2@protonma=
il.com wrote:
> > >
> > > > On Monday, May 10, 2021 4:16 AM, Larry Finger Larry.Finger@lwfinger=
.net wrote:
> > > >
> > > > > The only splat that shows in either attachment is due to you not =
installing the
> > > > > regulatory database that sets the channels etc. for your domain. =
I do not know
> > > > > what it is called for your distro - it is wireless-regdb on mine.=
 It is unlikely
> > > > > that this is the cause of your problem, but who knows?
> > > > > Larry
> > > >
> > > > I installed the wireless-regdb package. The error message about
> > > > regulatory.db went away, but the system still froze.
> > > > I'll try the rtw_core parameter disable_lps_deep=3D1 now.
> > >
> > > disable_lps_deep=3D1 did not help.
> > The patch set called "rtw88: add scan notify to firmware and refine fw_=
feature check" may have fixed this problem. I've been running commit 6ccdad=
5a58e18eac6b1335f05f94bf2b36146e00 from lwfinger/rtw88 for 3 days now with =
no freeze. It was impossible to go more than a few hours without a freeze b=
efore these patches.
>
> Sounds good. I will keep porting the patches submitted to wreless-drivers=
-next
> to the rtw88 repo at GitHub. I have no idea why this would preclude a sys=
tem
> freeze, but the Realtek guys might.
>
> Larry

I spoke too soon. It does still freeze even with that patch set.
