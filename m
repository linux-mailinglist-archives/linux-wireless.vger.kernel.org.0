Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAD851C509
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2019 10:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfENIeW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 May 2019 04:34:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37087 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfENIeW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 May 2019 04:34:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id e15so5754404wrs.4
        for <linux-wireless@vger.kernel.org>; Tue, 14 May 2019 01:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=8NjoP7C8oyZPDDZY3IPQoINwZUvpqoxzMLsqnLr6dWg=;
        b=tKLN7ieRmd5krRtqxeRuOaavVs5eXgQg/hGNs+VdTS6gmNZ3GZPbOttPcm2Usi7ja9
         i9ToL3t8SOCH0cmxoV4MO0iZQP3ly7RtEsgbgwfoV8qPsABBot9ITLg9J7l7VXS0WG6R
         1wT4mXge/8ALMBClLImYo27ythBxl2rpP7zsqbk3lFDrqS7hdEZ93/zW1GiPhrgHUKtl
         XW/Cu8QEVYZTLE4ovnuAFfrWKMePY5snP5mZ7/w2uauytWPwazd70EKIvhaaFaBtHsuV
         K07U0NKPVnTseAHDDUNOzHtGIVB1oh+QJ4+yVKVC5wtEUU5jId/HyalodfHpcyvSwydL
         1RbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=8NjoP7C8oyZPDDZY3IPQoINwZUvpqoxzMLsqnLr6dWg=;
        b=bEBUxm79bY3dSdFah2D7Vpq//r9uuhhSoop5E8Yc4Yp2bDvmFVd0F6+xidJl4uI1lp
         Dwz7GSGaKloptK2UfDAhIDN+Er3ulZF223JoWeGL9e6Rw6gFxtY7J2yJ8dQwTi/S493a
         QyjNrP78N4RW57mBPHRUaOyPd7MfJeQLZf4LFQ0hPYyHiP80DvEijUoh7mFsoYOr7SHI
         6W/BafWwa42Zwu2cxmSX9xZqeO3bmOSeDx3LlviqTrwlTie9cvM8vewt0WhDRLzNMsRf
         FR1+FyCygsrJkvVDfiEjsKimYPy8j+1C0dakp0UXIyLqrKGcQb3sDCW2H1Iqe6K8Dr8I
         4PqA==
X-Gm-Message-State: APjAAAUEoTl0qGWFun3eBnRYyLQsu0IuYaW7ILVpUb6ryls4DtF6uTQB
        0cLimj+L8fkcInLYPstrydx7frlMyPCp7cYI0MY=
X-Google-Smtp-Source: APXvYqwwSjNEO9yPYhPmDE8T14m9ihMvCjsm7IzEEIn+yGfK3Z1xtN/7o4efwAaIqfAcqayNUS9fP3qeuiuaBWu0FLk=
X-Received: by 2002:adf:9e46:: with SMTP id v6mr9064537wre.141.1557822860443;
 Tue, 14 May 2019 01:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190513104358.59716-1-andriy.shevchenko@linux.intel.com>
 <CA+icZUV_g5mJnmHQKZgtcPj3YfZSYp1DQJT9tmi+892AzRCm3A@mail.gmail.com> <20190513123751.GS9224@smile.fi.intel.com>
In-Reply-To: <20190513123751.GS9224@smile.fi.intel.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 14 May 2019 10:34:09 +0200
Message-ID: <CA+icZUUA8TfU--6b+RwXMf=ui7ww0DK=EurzdMeDUkGvwcJ_rg@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] NFC: nxp-nci: clean up and support new ID
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     =?UTF-8?Q?Cl=C3=A9ment_Perrochaud?= 
        <clement.perrochaud@effinnov.com>,
        Charles Gorand <charles.gorand@effinnov.com>,
        linux-nfc@lists.01.org, Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org,
        Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, May 13, 2019 at 2:37 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, May 13, 2019 at 02:18:03PM +0200, Sedat Dilek wrote:
> > On Mon, May 13, 2019 at 12:44 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > It has been reported that some laptops, equipped with NXP NFC300, have
> > > different ID then mentioned in the driver.
> > >
> > > While at it, I found that the driver has a lot of duplication and redundant
> > > platform data. The rest of the series (11 out of 12 patches) is dedicated to
> > > clean the driver up.
> > >
> > > Sedat, would be nice if you can compile kernel with this patch series applied
> > > and test on your laptop.
> > >
> > > In v2:
> > > - added new ID patch
> > > - added new clean up patch
> > > - Cc'ed to linux-wireless@ as well, since linux-nfc@ bounces my mails
> > > - Cc'ed to the reported of the problem with T470 laptop
> > >
> > > Andy Shevchenko (12):
> > >   NFC: nxp-nci: Add NXP1001 to the ACPI ID table
> > >   NFC: nxp-nci: Get rid of platform data
> > >   NFC: nxp-nci: Convert to use GPIO descriptor
> > >   NFC: nxp-nci: Add GPIO ACPI mapping table
> > >   NFC: nxp-nci: Get rid of code duplication in ->probe()
> > >   NFC: nxp-nci: Get rid of useless label
> > >   NFC: nxp-nci: Constify acpi_device_id
> > >   NFC: nxp-nci: Drop of_match_ptr() use
> > >   NFC: nxp-nci: Drop comma in terminator lines
> > >   NFC: nxp-nci: Remove unused macro pr_fmt()
> > >   NFC: nxp-nci: Remove 'default n' for tests
> > >   NFC: nxp-nci: Convert to SPDX license tags
> > >
> > >  MAINTAINERS                           |   1 -
> > >  drivers/nfc/nxp-nci/Kconfig           |   1 -
> > >  drivers/nfc/nxp-nci/core.c            |  15 +--
> > >  drivers/nfc/nxp-nci/firmware.c        |  13 +--
> > >  drivers/nfc/nxp-nci/i2c.c             | 147 ++++++--------------------
> > >  drivers/nfc/nxp-nci/nxp-nci.h         |   1 -
> > >  include/linux/platform_data/nxp-nci.h |  27 -----
> > >  7 files changed, 37 insertions(+), 168 deletions(-)
> > >  delete mode 100644 include/linux/platform_data/nxp-nci.h
> >
> > Can we have NPC300 listed in the Kconfg help text?
>
> Sure, it's good thing to do!
>
> Either as a separate patch or I may incorporate in the next iteration.
> Samuel, what do you prefer?
>

Am I correct that "NPC100" is "PN547" and "NPC300" is "PN548"?

- Sedat -
