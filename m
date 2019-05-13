Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 682CF1B5B0
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 14:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbfEMMSR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 08:18:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38120 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbfEMMSQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 08:18:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id f2so13486449wmj.3
        for <linux-wireless@vger.kernel.org>; Mon, 13 May 2019 05:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=NEG3vBWVhGLrRWlwKuNiB7uidufmGuDfj5WGjq1CyGc=;
        b=g+EfGPu7pX6PY1eCxt6sejRx2+4TlzR/x9faRnQCwlOOLCInZBJ26oyVW7H7m+g6Jl
         lAdiUPFjqG3fqgiTFWufHrifU3nDAEL2vstqY7aPiN0Sy/H99Na+oZ24W+3MEAhK4ZQt
         noiB+Kzoe9ayIryxuecXesJikNVL78iYfz3hHzyVo5I57J4yN3QZ9NrUofytkh+GT0PB
         4DSiz2bCFD6zm7QfFir/DOvqlcUa/JmoHtR3jDHd/ctlH588Ik72aMngouMdqJem8mt8
         tTeqmYahTiAXPHLF5O9kjCaOxHvs7oe+Uf4XUuDh+YwX0uB97RIinrW7X1My346o0/Yp
         6m5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=NEG3vBWVhGLrRWlwKuNiB7uidufmGuDfj5WGjq1CyGc=;
        b=Wz6pzCSrVpNUXq0xQxTL/y4Dywv/g5KcVgd9ieRr7nUEI0i/1cGjxCezCBbpyAa0Nb
         ZlTwA1B9fIWk9xcbVdyKnwzZGCinyTtp04JNMFx0i0YgSgcynPqmTHy9KOEOV+s6hICA
         HXG+3V8hLfzU52/e76b4EzHQWMbPUkfjS+jIctk45U3JftWOJ41SBqA9uREAuar0pM8w
         9ibrNFQS/kEkynIfuAf3dU5OLpeWby6gnBNN/+80ZErbWPRn+YfZF7lXlYe8FJ8wMrhb
         vryQ9KobyFbO07eyqUdprKSofcJf9GLSh/V6oCp3XP3sAJrueSa91/ltXpNhYE3ZJkNe
         3HhA==
X-Gm-Message-State: APjAAAUGL2cwfdQRHRM7bbH1AgJ/u5PlhtZUQxRiO6hlfhtzujM7YFlb
        FNKsKiV1eoa6Go9/s8b7+BfWv7YzjXtkpvhtAzwC8yiucvc=
X-Google-Smtp-Source: APXvYqwZBB5sLBxmgweOFaTs4tTGL+FJFGQvsN3llQlpPX/9L5H9TxR4dnolguO3KORdhzY4x5StqdgPnXEl9WNOCzU=
X-Received: by 2002:a7b:cc12:: with SMTP id f18mr15891780wmh.40.1557749894616;
 Mon, 13 May 2019 05:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190513104358.59716-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20190513104358.59716-1-andriy.shevchenko@linux.intel.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 13 May 2019 14:18:03 +0200
Message-ID: <CA+icZUV_g5mJnmHQKZgtcPj3YfZSYp1DQJT9tmi+892AzRCm3A@mail.gmail.com>
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

On Mon, May 13, 2019 at 12:44 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> It has been reported that some laptops, equipped with NXP NFC300, have
> different ID then mentioned in the driver.
>
> While at it, I found that the driver has a lot of duplication and redundant
> platform data. The rest of the series (11 out of 12 patches) is dedicated to
> clean the driver up.
>
> Sedat, would be nice if you can compile kernel with this patch series applied
> and test on your laptop.
>
> In v2:
> - added new ID patch
> - added new clean up patch
> - Cc'ed to linux-wireless@ as well, since linux-nfc@ bounces my mails
> - Cc'ed to the reported of the problem with T470 laptop
>
> Andy Shevchenko (12):
>   NFC: nxp-nci: Add NXP1001 to the ACPI ID table
>   NFC: nxp-nci: Get rid of platform data
>   NFC: nxp-nci: Convert to use GPIO descriptor
>   NFC: nxp-nci: Add GPIO ACPI mapping table
>   NFC: nxp-nci: Get rid of code duplication in ->probe()
>   NFC: nxp-nci: Get rid of useless label
>   NFC: nxp-nci: Constify acpi_device_id
>   NFC: nxp-nci: Drop of_match_ptr() use
>   NFC: nxp-nci: Drop comma in terminator lines
>   NFC: nxp-nci: Remove unused macro pr_fmt()
>   NFC: nxp-nci: Remove 'default n' for tests
>   NFC: nxp-nci: Convert to SPDX license tags
>
>  MAINTAINERS                           |   1 -
>  drivers/nfc/nxp-nci/Kconfig           |   1 -
>  drivers/nfc/nxp-nci/core.c            |  15 +--
>  drivers/nfc/nxp-nci/firmware.c        |  13 +--
>  drivers/nfc/nxp-nci/i2c.c             | 147 ++++++--------------------
>  drivers/nfc/nxp-nci/nxp-nci.h         |   1 -
>  include/linux/platform_data/nxp-nci.h |  27 -----
>  7 files changed, 37 insertions(+), 168 deletions(-)
>  delete mode 100644 include/linux/platform_data/nxp-nci.h
>
> --
> 2.20.1
>

Can we have NPC300 listed in the Kconfg help text?

Thanks.

- Sedat -

$ git diff
diff --git a/drivers/nfc/nxp-nci/Kconfig b/drivers/nfc/nxp-nci/Kconfig
index a28c4265354d..f2173c1de745 100644
--- a/drivers/nfc/nxp-nci/Kconfig
+++ b/drivers/nfc/nxp-nci/Kconfig
@@ -2,8 +2,8 @@ config NFC_NXP_NCI
        tristate "NXP-NCI NFC driver"
        depends on NFC_NCI
        ---help---
-         Generic core driver for NXP NCI chips such as the NPC100
-         or PN7150 families.
+         Generic core driver for NXP NCI chips such as the NPC100,
+         NPC300 or PN7150 families.
          This is a driver based on the NCI NFC kernel layers and
          will thus not work with NXP libnfc library.
