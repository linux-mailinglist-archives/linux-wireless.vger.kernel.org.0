Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 547301EA2F
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2019 10:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbfEOIct (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 May 2019 04:32:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38480 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfEOIct (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 May 2019 04:32:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id d18so1076525wrs.5
        for <linux-wireless@vger.kernel.org>; Wed, 15 May 2019 01:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=2PRdHD+YHensJnwISHyY5pFCrqq6RfcJQGlSygjfgvE=;
        b=PadiKoxQRsPFCyjAREfZA3dWoErXC9/SVPdfOK8u5o2HQDmFzsuJ/d+jQKdwaIcqCj
         ujW5XR2xFfKuBmcEa2AHRB/sV62susMCxmoiA/InbZiDLp+5tvc6aG2dWY14Sxj2ETsZ
         p4dVrbJLOreijev81W2TP9XplndgEvNvhPqAlab+VDuxq0bqaBtuhfC133LYld2ldWTI
         8qBOU4c5RN1a5vqsWBO+gn2/wXrcm+7PjwlY0ouCVdMiiNkk+dXrlr3FzWBx01CxvZNw
         TGb/w/VfuGEekemrN3MP/4RygINktsmebZXqnT/NappxNp3NQMbZeGiJxkqldTqwWgDU
         eaTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=2PRdHD+YHensJnwISHyY5pFCrqq6RfcJQGlSygjfgvE=;
        b=GmIv7PF+TD9N+Vq2s2bKrFhKIgbVNlhU7BeVmCdr9g3FGIwBOJja7PuTbb7Qk6BNgF
         3r9yBiTvlpsBO7840YSPohMjJevYOZo15Zi7giE4HMrqjR0K1iT3LeX78FsnJMJ64qA1
         tqqt9f07SB1frhnDioZBWQxFlil7x/sg3xgyvRzbdIz48YyLTdV2H26l/ffzyiwaj67J
         7Re8hh2jETCtS9+0D766B4hmvJ5o3mUYMRuB0x8gYdklixlf76L4evsQPagTyQZXSA+i
         9IZFbKPMcs8u9e6hqGa7d6DKYLJuHySKuiNsjDjWCmNlK5SB25b8PnODbH/g8hXz9b4h
         v5+g==
X-Gm-Message-State: APjAAAUuNWXfJyZ4CoszX9mjnjbKHYjVnjhMp3m/Q69A5TIt2L0y6qxF
        aooKeXqlBlhQBUjqiqUhZ+svEI99FoaIdPciKx0=
X-Google-Smtp-Source: APXvYqy3st9WZQznZfPmo2qxWxf8jfyQgT5oVTHe1hmoCj3MFxSYdFtlYJbOz+jTcDowENaRu/c/YqmklIprFFNeM8M=
X-Received: by 2002:adf:dc4b:: with SMTP id m11mr25686833wrj.66.1557909167564;
 Wed, 15 May 2019 01:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190513104358.59716-1-andriy.shevchenko@linux.intel.com>
 <CA+icZUV_g5mJnmHQKZgtcPj3YfZSYp1DQJT9tmi+892AzRCm3A@mail.gmail.com>
 <20190513123751.GS9224@smile.fi.intel.com> <CA+icZUUA8TfU--6b+RwXMf=ui7ww0DK=EurzdMeDUkGvwcJ_rg@mail.gmail.com>
 <2d39b39b-27eb-abef-747f-400433daefee@intel.com> <CA+icZUW6vttB8EvgBZYi3kT7uhcbQr+baYbif_V6D78ZNEDbHQ@mail.gmail.com>
 <4f297fa0-257d-5036-8a1a-0f5434bb5d26@intel.com> <CA+icZUWZH-JS=JHLieVd2ga=Zutac2BXd4tk0tSXs+izQ5txOQ@mail.gmail.com>
 <787aff34-b1b9-b9e2-faf3-409d7fc95a52@intel.com> <CA+icZUV=TBfabHsbzj_JPnxXBjo114LWVJ==xSS7zVPkajmNgw@mail.gmail.com>
 <20190514170136.GI9224@smile.fi.intel.com>
In-Reply-To: <20190514170136.GI9224@smile.fi.intel.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 15 May 2019 10:32:36 +0200
Message-ID: <CA+icZUW0KM07sUH=muhRwFBZQKQpeqN6wCDHSDrQM-L35bA+SQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] NFC: nxp-nci: clean up and support new ID
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>,
        =?UTF-8?Q?Cl=C3=A9ment_Perrochaud?= 
        <clement.perrochaud@effinnov.com>,
        Charles Gorand <charles.gorand@effinnov.com>,
        linux-nfc@lists.01.org, Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, May 14, 2019 at 7:01 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, May 14, 2019 at 04:53:10PM +0200, Sedat Dilek wrote:
> > On Tue, May 14, 2019 at 3:57 PM Oleg Zhurakivskyy
> > <oleg.zhurakivskyy@intel.com> wrote:
>
> > What about this one?
> >
> > diff --git a/drivers/nfc/nxp-nci/Kconfig b/drivers/nfc/nxp-nci/Kconfig
> > index a28c4265354d..b9e6486aa8fe 100644
> > --- a/drivers/nfc/nxp-nci/Kconfig
> > +++ b/drivers/nfc/nxp-nci/Kconfig
> > @@ -2,8 +2,8 @@ config NFC_NXP_NCI
> >         tristate "NXP-NCI NFC driver"
> >         depends on NFC_NCI
> >         ---help---
> > -         Generic core driver for NXP NCI chips such as the NPC100
> > -         or PN7150 families.
> > +         Generic core driver for NXP NCI chips such as the NPC100 (PN5=
47),
> > +         NPC300 (PN548) or PN7150 families.
> >           This is a driver based on the NCI NFC kernel layers and
> >           will thus not work with NXP libnfc library.
> >
> > @@ -19,6 +19,11 @@ config NFC_NXP_NCI_I2C
> >           chips.
> >           Select this if your platform is using the I2C bus.
> >
> > +          Furthermore, the pin control and GPIO driver of the actual S=
oC or
> > +          PCH is needed.
> > +          For example set CONFIG_PINCTRL_SUNRISEPOINT=3Dy to activate =
the
> > +          Intel Sunrisepoint (PCH of Intel Skylake) pinctrl and GPIO d=
river.
> > +
>
> Besides some indentation problems (the help lines should be prefixed with
> 'TAB + 2 spaces'), this is not needed =E2=80=94 it's obvious and usually =
distros
> provide all of pin control drivers anyway.
>
> For debugging one may check deferred devices via DebugFS, or use
> 'initcall_debug', or other facilities.
>
> >           To compile this driver as a module, choose m here. The module=
 will
> >           be called nxp_nci_i2c.
> > -         Say Y if unsure.
> > +         Say N if unsure.
>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Excellent eyes (TAB + 2 spaces)!

So, this is enough?

$ git diff
diff --git a/drivers/nfc/nxp-nci/Kconfig b/drivers/nfc/nxp-nci/Kconfig
index a28c4265354d..d85a4761e271 100644
--- a/drivers/nfc/nxp-nci/Kconfig
+++ b/drivers/nfc/nxp-nci/Kconfig
@@ -2,8 +2,8 @@ config NFC_NXP_NCI
        tristate "NXP-NCI NFC driver"
        depends on NFC_NCI
        ---help---
-         Generic core driver for NXP NCI chips such as the NPC100
-         or PN7150 families.
+         Generic core driver for NXP NCI chips such as the PN547 (NPC100),
+         PN548 (NPC300) or PN7150 families.
          This is a driver based on the NCI NFC kernel layers and
          will thus not work with NXP libnfc library.

@@ -21,4 +21,4 @@ config NFC_NXP_NCI_I2C

          To compile this driver as a module, choose m here. The module wil=
l
          be called nxp_nci_i2c.
-         Say Y if unsure.
+         Say N if unsure.

Shall I sent a patch for this, or do you want to that yourself?

Thanks.

- Sedat -
