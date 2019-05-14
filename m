Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB0321CAE9
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2019 16:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbfENOxX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 May 2019 10:53:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34629 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfENOxX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 May 2019 10:53:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id j187so2557927wma.1
        for <linux-wireless@vger.kernel.org>; Tue, 14 May 2019 07:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=3q9zAd1mfqLEWgtN9KBQL8ZyemYmSupu9NkVwzRaOEQ=;
        b=twzOdOTMQC3qusxoiOhAwwUuB9dHoScRb1Mxt3wsoHDCScqVS0joqx9vLHbi5lDwMw
         aFQa6RvqLhPLv6pMkH+T3k938wsNJoGcFuw7KGCrdE3iq/Gq8ltj2dyu7zd9sk9zO+4n
         +bATAOdWIh9l5qgdRT1b1yVXPJcSbVd2Dg13FT6J3ZSxbZ0kAfA1puNcH95P2w4Sx/FJ
         23aZR/AA59hwShUR5atR8whyZz2uAgQOclXapxgfL5LI9Rs+Fi1COflqUQ7gf5ri1QMz
         Vku7ih3WErJ+AotXpcjQ/06DZvdnEwUZBClIztK0Jf5B8VWJjMgHCDylyJIYfqU4s5ch
         gcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=3q9zAd1mfqLEWgtN9KBQL8ZyemYmSupu9NkVwzRaOEQ=;
        b=YXc3+25LERAVnlGihx4albhwtuocq2Z3/2jk5OucV5EaJ8/0SGYxgpIjuB+4GfU+Dt
         AHOi8R0VJeYSpdBAKItriCPgiLEfxCkiQARRrdoQ0WpTaROL3060UhOKsrbx/Wb9Vt6l
         RtHBew43MSypDHE+bAXnAnt8RK5L2LlHJYoDelFrW9ksyIJJD0P5lHnyXVnx7oTWmUjp
         SuwZ1jAceN087Va1TZjZUmx/BAQx6QEzGbtjggIQkcYOlcTJziCEyZQyNqwplulx/j6I
         6g3IG04/SvUobOxRSfYlZUduM5GIhYk96lLhTLhMUc+FMaWuPelfvll0xrbQrnw43NXN
         p7+g==
X-Gm-Message-State: APjAAAUhWW6ugxFBT1r3arFD7+TIb1Tw75yPqxxevkv4j4TklOTQWSyq
        3lCL68E/dQtfi+E2mv0T3fC+2INQT7akzL8avCcn22hNpJ8=
X-Google-Smtp-Source: APXvYqz1IN9x6k5J6WB/v6FVQ5pXgqKV96kikS/r8kCM6VZ3elo/3jq1wHqf+U2+r90KE4kKB1DmaoZnqWobKWjXeGY=
X-Received: by 2002:a1c:9616:: with SMTP id y22mr9069193wmd.73.1557845601591;
 Tue, 14 May 2019 07:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190513104358.59716-1-andriy.shevchenko@linux.intel.com>
 <CA+icZUV_g5mJnmHQKZgtcPj3YfZSYp1DQJT9tmi+892AzRCm3A@mail.gmail.com>
 <20190513123751.GS9224@smile.fi.intel.com> <CA+icZUUA8TfU--6b+RwXMf=ui7ww0DK=EurzdMeDUkGvwcJ_rg@mail.gmail.com>
 <2d39b39b-27eb-abef-747f-400433daefee@intel.com> <CA+icZUW6vttB8EvgBZYi3kT7uhcbQr+baYbif_V6D78ZNEDbHQ@mail.gmail.com>
 <4f297fa0-257d-5036-8a1a-0f5434bb5d26@intel.com> <CA+icZUWZH-JS=JHLieVd2ga=Zutac2BXd4tk0tSXs+izQ5txOQ@mail.gmail.com>
 <787aff34-b1b9-b9e2-faf3-409d7fc95a52@intel.com>
In-Reply-To: <787aff34-b1b9-b9e2-faf3-409d7fc95a52@intel.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 14 May 2019 16:53:10 +0200
Message-ID: <CA+icZUV=TBfabHsbzj_JPnxXBjo114LWVJ==xSS7zVPkajmNgw@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] NFC: nxp-nci: clean up and support new ID
To:     Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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

On Tue, May 14, 2019 at 3:57 PM Oleg Zhurakivskyy
<oleg.zhurakivskyy@intel.com> wrote:
>
>
> On 5/14/19 4:44 PM, Sedat Dilek wrote:
>
> >            Say Y if unsure.
> >
> > Shouldn't that be "Say N if unsure"?
> > Or Say Yes If Sure :-).
>
> :)
>
> Must be a typo.
>
> As to me, the last 5 lines in the description are extra, but this is just a matter of taste.
>

What about this one?

diff --git a/drivers/nfc/nxp-nci/Kconfig b/drivers/nfc/nxp-nci/Kconfig
index a28c4265354d..b9e6486aa8fe 100644
--- a/drivers/nfc/nxp-nci/Kconfig
+++ b/drivers/nfc/nxp-nci/Kconfig
@@ -2,8 +2,8 @@ config NFC_NXP_NCI
        tristate "NXP-NCI NFC driver"
        depends on NFC_NCI
        ---help---
-         Generic core driver for NXP NCI chips such as the NPC100
-         or PN7150 families.
+         Generic core driver for NXP NCI chips such as the NPC100 (PN547),
+         NPC300 (PN548) or PN7150 families.
          This is a driver based on the NCI NFC kernel layers and
          will thus not work with NXP libnfc library.

@@ -19,6 +19,11 @@ config NFC_NXP_NCI_I2C
          chips.
          Select this if your platform is using the I2C bus.

+          Furthermore, the pin control and GPIO driver of the actual SoC or
+          PCH is needed.
+          For example set CONFIG_PINCTRL_SUNRISEPOINT=y to activate the
+          Intel Sunrisepoint (PCH of Intel Skylake) pinctrl and GPIO driver.
+
          To compile this driver as a module, choose m here. The module will
          be called nxp_nci_i2c.
-         Say Y if unsure.
+         Say N if unsure.

- Sedat -
