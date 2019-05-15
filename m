Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F36381EC0A
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2019 12:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfEOKWs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 May 2019 06:22:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33011 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfEOKWs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 May 2019 06:22:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id d9so2065877wrx.0
        for <linux-wireless@vger.kernel.org>; Wed, 15 May 2019 03:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=laCY1D40foyBD+P6cy+jfrP2F74oAtcihG3FIQoD5RY=;
        b=c4HAA2AJsfUWWfilte+XxwqGFZVys3NQ7x+4D073IA5yNYG7SpDSQb1a/tG5A8LPDH
         qMsCgo83DEJKzig6qII1o5FYPtWuKSsaa71ExEz3WX5Aox6vHCiTC+mi5azTUlh3EJt5
         OY5q9TN393aoZozQNwrXOyMr/ONxIUQ8MNSlFFHcRpgoDlUlDQ+MtPrGnQPthnbtnpJX
         J3i1YCisMxSmZAOGXw6irY1oHtjS4IMjJvGzFx/1GOAPk9lVYXWRDpBm+0/tBfonUvRk
         prn8rEqwhcCQ0ZcQIdq6S6+/k1fkjltrpofajooKPQUMC5tiOyBSAFXuPNkJsm7OnMZ5
         wMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=laCY1D40foyBD+P6cy+jfrP2F74oAtcihG3FIQoD5RY=;
        b=RUI04lsL3aX/X1+mTKQo5eNoJb9YhLEtTSXh9KbVdDNkawsHZpbSENzwHpY6vRWHSn
         IopDAFZ0mBzgZWt4dhrUmsXai2Qa3epFWLSRVz3bb/HxrdkigFDDjNT3g7JdJ/taovJ1
         MAx8e9iSKxUJhXVfOmHNCtF1kO/yC35pXQDuEQQmBhEShVX1kXMcY1ebMw1QQ6og7HT8
         DU4XaJ/zIQPJiUAzPWLXq4mvnBUgP2eM/2nNdZfzStnEwBPPXyOH8vUwnuS8tfKitKEp
         7w+hk8GyXB/fy1ywO0p7zYEmn6CVvKVCz33qGEPCNyXWI77LlmaXXrMQfpiRKgJokRXv
         LDOA==
X-Gm-Message-State: APjAAAXF02HkjOvuukzTOqJUuIa9Ls0iWO4f5kwRObFHeZryN5F1cfYn
        4U+nSthlTdM/Und+OdATpl5jd3e3prmQv23+yFk=
X-Google-Smtp-Source: APXvYqzgviRHpMCakiwzpzxO70m78ERkw7BjAHWMSNRBT67hsUlz+nkr8PDh4OppZfJX4aJsukQJYInezTpsVIjm7eE=
X-Received: by 2002:adf:dd0d:: with SMTP id a13mr7532941wrm.153.1557915766195;
 Wed, 15 May 2019 03:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190513123751.GS9224@smile.fi.intel.com> <CA+icZUUA8TfU--6b+RwXMf=ui7ww0DK=EurzdMeDUkGvwcJ_rg@mail.gmail.com>
 <2d39b39b-27eb-abef-747f-400433daefee@intel.com> <CA+icZUW6vttB8EvgBZYi3kT7uhcbQr+baYbif_V6D78ZNEDbHQ@mail.gmail.com>
 <4f297fa0-257d-5036-8a1a-0f5434bb5d26@intel.com> <CA+icZUWZH-JS=JHLieVd2ga=Zutac2BXd4tk0tSXs+izQ5txOQ@mail.gmail.com>
 <787aff34-b1b9-b9e2-faf3-409d7fc95a52@intel.com> <CA+icZUV=TBfabHsbzj_JPnxXBjo114LWVJ==xSS7zVPkajmNgw@mail.gmail.com>
 <20190514170136.GI9224@smile.fi.intel.com> <CA+icZUW0KM07sUH=muhRwFBZQKQpeqN6wCDHSDrQM-L35bA+SQ@mail.gmail.com>
 <20190515100919.GJ9224@smile.fi.intel.com>
In-Reply-To: <20190515100919.GJ9224@smile.fi.intel.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 15 May 2019 12:22:34 +0200
Message-ID: <CA+icZUV1FjAr_Ro5gACVy3QQ9n1nUggW-XtjE2Qx4hwFdNddiA@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] NFC: nxp-nci: clean up and support new ID
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>,
        =?UTF-8?Q?Cl=C3=A9ment_Perrochaud?= 
        <clement.perrochaud@effinnov.com>,
        Charles Gorand <charles.gorand@effinnov.com>,
        linux-nfc@lists.01.org, Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 15, 2019 at 12:09 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, May 15, 2019 at 10:32:36AM +0200, Sedat Dilek wrote:
> > On Tue, May 14, 2019 at 7:01 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
>
> > So, this is enough?
>
> Yes, please send it as a formal patch, I will chain it to my series and resend
> in a bunch of v3.
>

Will do after rebooting into Linux v5.1.2 stable :-).

- Sedat -

> > $ git diff
> > diff --git a/drivers/nfc/nxp-nci/Kconfig b/drivers/nfc/nxp-nci/Kconfig
> > index a28c4265354d..d85a4761e271 100644
> > --- a/drivers/nfc/nxp-nci/Kconfig
> > +++ b/drivers/nfc/nxp-nci/Kconfig
> > @@ -2,8 +2,8 @@ config NFC_NXP_NCI
> >         tristate "NXP-NCI NFC driver"
> >         depends on NFC_NCI
> >         ---help---
> > -         Generic core driver for NXP NCI chips such as the NPC100
> > -         or PN7150 families.
> > +         Generic core driver for NXP NCI chips such as the PN547 (NPC100),
> > +         PN548 (NPC300) or PN7150 families.
> >           This is a driver based on the NCI NFC kernel layers and
> >           will thus not work with NXP libnfc library.
> >
> > @@ -21,4 +21,4 @@ config NFC_NXP_NCI_I2C
> >
> >           To compile this driver as a module, choose m here. The module will
> >           be called nxp_nci_i2c.
> > -         Say Y if unsure.
> > +         Say N if unsure.
> >
> > Shall I sent a patch for this, or do you want to that yourself?
> >
> > Thanks.
> >
> > - Sedat -
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
