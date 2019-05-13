Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 329071BE2D
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 21:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfEMTs3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 15:48:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37707 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfEMTs3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 15:48:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id e15so4216553wrs.4
        for <linux-wireless@vger.kernel.org>; Mon, 13 May 2019 12:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=jxVNHvkCAClk55VtV/ChIHyBnXMsML+QlgXGtiEg/5Y=;
        b=TOJwGUsL6hhtypW1dS0xJ12N8M8OeZJl7niTOkmSTpLJKKI0zQgGNSso/y7x2Zw3/Z
         ELLZC61mEP+oAqUZVQi+efnZir0esEeP6d1O9SLqAgLhjsDuZ7l1JRS5XC7x9aQBbyzD
         ZHjePJfXMFluBdJsbgdUjuEkQPnc8IosRNF6deuMGiIYCrOiHz+/j2dkOEVAjuGre3LS
         7297z3T02H4jrSGPoosFnWP0Vcb1ol7IBsCKC6MthHV0Q5X0zA3quKlG8YcWEchV0Xjq
         e+IYoLAquuTuKNol06iz67QtpNSNM8yRqFirV0qFlg2T1fuwqo2xDGk88rhcrfe1zy9c
         3ZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=jxVNHvkCAClk55VtV/ChIHyBnXMsML+QlgXGtiEg/5Y=;
        b=k60f545/+iYZCiC0SvRbYIGV0Ei3PJh4Rpq4+wOroGnbBMEWk1qViHob0Q2TjkiMI7
         KmU/8ACifTpd0ZwCXekXXTxuHLs+HSFV2XDf9WIg4dht6hFBIf9M7IdoTztJlFM7E7xv
         3GhVp5hVle+7vFcfIjFC4Xyp0EWWgtUaQ5qa0vDCuDE71NafyEP5jIAHfWg1AYTKaqVt
         FrVxLgaH/guCkjykfFMG3ms8Fq78xUBIVOBQ3a5whJyBHHP+sOFBg0+YCV4U84wAHY/W
         lC2N7gZJ3XTWy9TgccHQuansYfwN6CIOSvywPevhbpfR8x186ykxUfZ4+ZwE6u6Hy2LP
         Mbxw==
X-Gm-Message-State: APjAAAVZt0UPa+Ec3fn9OkHtVyS+/oaeqxk9tNY4vday8FZlrJHHP6cK
        eOVIFTsOJE1uhIXj6pr262h/FlDzg/wiqAxXfY4=
X-Google-Smtp-Source: APXvYqwhH3o6/uM3plBNrSQ9gWNwyJZbcfhz+8wUrkR4+yNkxv5pvL7ft3iQppPStSnpbbS8qxPIeF/8miCZ5AoUH98=
X-Received: by 2002:a5d:4692:: with SMTP id u18mr6817860wrq.285.1557776907160;
 Mon, 13 May 2019 12:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190513104358.59716-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20190513104358.59716-1-andriy.shevchenko@linux.intel.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 13 May 2019 21:48:15 +0200
Message-ID: <CA+icZUVn9tHQ3Zug0u2scbvGFfrLag_WYdzs9FCBJsGJ4bhuzw@mail.gmail.com>
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

Is it possible to have an info in dmesg log when nxp-nci_i2c kernel
module is loaded?

- Sedat -
