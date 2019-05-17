Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB3B321D19
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2019 20:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbfEQSIG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 May 2019 14:08:06 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46612 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbfEQSIG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 May 2019 14:08:06 -0400
Received: by mail-yw1-f66.google.com with SMTP id a130so3064024ywe.13
        for <linux-wireless@vger.kernel.org>; Fri, 17 May 2019 11:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bz2B8Jk4th8PTqpI5vOS78BcaIYStVbY1xY/BzsFktc=;
        b=LxFFlt+l67rmHEPzsA5ux7NJFJWrjTlQdLQrF33NKs2CbEZsp0PW6v1rVFyLFVxx7U
         l6u0WGrqidColvzkqMHriaY7E/f5vTDFh6cdaaLvj0rEBaPv3hSlO772sMOY9Y388MI4
         XKBYgmBq9jkBnOry2bwCXt0fWM3O/bx0DSMnw5lIZmFRd1PBG4OIhy58eIsylN6T0lgh
         cb6PaViatI97y42rfdZjAPRylCDI82c1Uu3aIotMrUj8ZBxtKDSQFQ0vHnrFEMIBR2oe
         sjB35vGUO+1ZtYdvynnIx/otNQJcXB9LWe+t4kCG0Fh9/+idWIRYAzCbYgptY3yBNi9e
         6OiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bz2B8Jk4th8PTqpI5vOS78BcaIYStVbY1xY/BzsFktc=;
        b=oxndW8oA8VS3o3g2hGZlyQbukquU0sCT6ch92nguA2RCJ/tswBTlDnzwdmXy3zynP6
         tOevn/dhagyMj6kAQ2w0WNhsRKWgoAVPurwkf06kcFQHE/TXkE4sPoWsKyn/foTPbAzs
         nIy+7FgF9jXpOKzJRXRk5SVpJQRtVbajKDdcd6C1xtxTEYqzb6ZiJ3rzcKFOweCSY6U2
         6Yl0UV6xAD2Q/cLTLz8iUJWdB6YGVs0IHgEDg8xIl8Ndhi0SZ+/S+utWO0ChTeDmvTkE
         Kg82m94JVNJZOvAaZS4mSyWtMPuG8PNZhRmLqfoxLObYkROlVfXB2eeJa4bQa1R6YSs9
         XLmw==
X-Gm-Message-State: APjAAAWMfTThBnQzzIhPv1ChXqpipHyioCxLeezJ/P3RSz0ar3+a8Ikv
        uDADMG9/jgQ/cpe1X1AsXjzjnImHB2KoiKGDFsM=
X-Google-Smtp-Source: APXvYqwV/HP+dA2a1qXye6rBX7x4y8ngMQU21wUlPDKQCS+AhVAOe+3cED5fan4OPRepKYO+MS3JCtWtERpb4C6Qod8=
X-Received: by 2002:a81:ac46:: with SMTP id z6mr28150922ywj.255.1558116485184;
 Fri, 17 May 2019 11:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <1558008251-13692-1-git-send-email-arend.vanspriel@broadcom.com>
 <1558008251-13692-4-git-send-email-arend.vanspriel@broadcom.com>
 <20190516173113.GA540@kroah.com> <a5d32b2f-a99b-a248-1acd-9de532732e30@broadcom.com>
 <20190516200131.GA15814@kroah.com> <eeebea29-4237-6e49-7578-8d3b1ad7df85@broadcom.com>
In-Reply-To: <eeebea29-4237-6e49-7578-8d3b1ad7df85@broadcom.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date:   Fri, 17 May 2019 20:07:53 +0200
Message-ID: <CACna6rxuSFWN8eib7FpJiVQqLwdD5GOTaAFr7msJa01rBSTLKA@mail.gmail.com>
Subject: Re: [PATCH 3/7] brcmsmac: switch source files to using SPDX license identifier
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 17 May 2019 at 01:25, Arend Van Spriel
<arend.vanspriel@broadcom.com> wrote:
> On 5/16/2019 10:01 PM, Greg Kroah-Hartman wrote:
> > On Thu, May 16, 2019 at 09:45:19PM +0200, Arend Van Spriel wrote:
> >> On 5/16/2019 7:31 PM, Greg Kroah-Hartman wrote:
> >>> On Thu, May 16, 2019 at 02:04:07PM +0200, Arend van Spriel wrote:
> >>>> With ISC license text in place under the LICENSES folder switch
> >>>> to using the SPDX license identifier to refer to the ISC license.
> >>>>
> >>>> Cc: Thomas Gleixner <tglx@linutronix.de>
> >>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>>> Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
> >>>> Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.c=
om>
> >>>> Reviewed-by: Franky Lin <franky.lin@broadcom.com>
> >>>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> >>>> ---
> >>>> Hi Thomas, Greg,
> >>>>
> >>>> The file drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
> >>>> did not have license information nor copyright notice and as such
> >>>> it got included in commit b24413180f56 ("License cleanup: add SPDX
> >>>> GPL-2.0 license identifier to files with no license"). I added you
> >>>> guys as I propose to align this source file with the rest of
> >>>> the driver sources and change it to ISC license and add the missing
> >>>> copyright notice while at it (not sure if that warrants a separate
> >>>> patch).
> >>>
> >>> A separate patch would be good, to make it explicit that you are
> >>> changing the license of the file.
> >>
> >> Ok.
> >>
> >>> And ISC, ick, why...  :)
> >>
> >> Because the license text in the other driver source files is a 1:1 mat=
ch
> >> with the ISC license.
> >
> > Oh, I am not disagreeing with that, yes, that is obviously the license
> > of the files. Just complaining about that choice for Linux kernel code =
:)
>
> I see.
>
> >> Another option could be MIT license which is in the preferred folder.
> >> Will have to consult our legal department about it though.
> >
> > Hey, if your legal department is going to get asked this, why not just
> > switch it to GPLv2?  That would make everything much simpler.
>
> Hah. Because I already know the answer to that. ;-)

It's not that obvious to me, sorry. Does your legal department require
something more permissive than GPLv2? Is that worth asking them about
dual-licensing? Something like
GPL-2.0 OR MIT
? That assures driver is compatible with Linux, no matter what's the
current lawyers interpretation of MIT vs. GPL 2.0. I believe Alan Cox
once told/suggested that dual-licensing is safer for legal reasons.

--
Rafa=C5=82
