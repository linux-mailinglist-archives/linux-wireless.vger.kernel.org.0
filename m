Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD0172245D
	for <lists+linux-wireless@lfdr.de>; Sat, 18 May 2019 19:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbfERRxo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 May 2019 13:53:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38427 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbfERRxo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 May 2019 13:53:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id d18so10238318wrs.5
        for <linux-wireless@vger.kernel.org>; Sat, 18 May 2019 10:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ulKBkZsxz/eCjEBhlqoZ25lvwchNTnSgUd8cE5qKgr8=;
        b=PW64lCXca/sKCCd52bHUVTgWIpDGuk3JcncjfNzBRuQFkSMTPkp9N1wMhmlXms5KLI
         MMOEAFmG9ci4MK6MVH8kFcNKHIVMa/XlS3eDq2/kbzASuJzxgS9qi+d/WqQgMOw5igpA
         DuCsPKGSYjKoM0MLejZmbpVeoYEuh700GrP3e5dntrY7qA+KiPa6RNabSbuG8e72FGXM
         USVWo3dCqxZDTz4ujq74o4qQnsm9yB+PixXEumQXWg0XxWPjx0/lXWs0Vh3do7FaMb0U
         tzOaGXw4NLVAr1iAbEscF2TlIX4u0NpA8cFGNP8m94sMrTAgDTIoZuixlLDJMsYoAUWF
         LuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ulKBkZsxz/eCjEBhlqoZ25lvwchNTnSgUd8cE5qKgr8=;
        b=gEEjwwfgxfVxIC/7T5fBjH0EWRmcKDHS8uSWVBzCBRaFLx9VhGJVSSQtyyHdqc+rb3
         s2undTsgubRrqTBXrY/Y0oDloy9xhamxkca+QH7ADnkMw5r2rDtjXSUNEQyvJxztznSU
         I0C7758g9MEMvcc7AvXaY96FtnOxeP+GGRqIFm1c4F20WoxBZnxyWIJUjCdxhVA3+Nmf
         Fd9mSc43VN1URhaWq8YW/kfGeOZUEXyvWt8e2Afd4yXGxQZHELZU/sHwZUoMDycjvlyY
         PSuLsmhfHWOE6loEYs+v957wodS0ePrkktvMI95HAG8NQvV5my0yBpUSCzO46LoQ6HRY
         IaAA==
X-Gm-Message-State: APjAAAWWcjgJOfdA4z6238hbv+iHImAELrRNEs2rBRV09NXA+RoQV7VR
        J47W0o0Z4jarbhbSakv35W9JteLyLsRGpAKjfY7baBRR
X-Google-Smtp-Source: APXvYqwCAEOT0g4lA03njQzefyoj8iSgApJYIJrGrIgG4jCXvxYTSFYP3Nj3U89VTVCtY4PSXL19Ip53QAvi4RhyTpA=
X-Received: by 2002:adf:e344:: with SMTP id n4mr16202950wrj.192.1558202022729;
 Sat, 18 May 2019 10:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <20181016102349.26544-1-sergey.matyukevich.os@quantenna.com> <20181016102349.26544-3-sergey.matyukevich.os@quantenna.com>
In-Reply-To: <20181016102349.26544-3-sergey.matyukevich.os@quantenna.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Sat, 18 May 2019 19:54:39 +0200
Message-ID: <CAOiHx=nBWr4GNh61WV+SAY-++Z6es-HX3_pd70DB_N33bVK1tw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] qtnfmac: add support for Topaz chipsets
To:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Andrey Shevchenko <ashevchenko@quantenna.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Tue, 16 Oct 2018 at 12:25, Sergey Matyukevich
<sergey.matyukevich.os@quantenna.com> wrote:
>
> This patch adds support for QSR1000/QSR2000 family of chipsets
> to qtnfmac_pcie platform driver.
>
> QSR1000/QSR2000 (aka Topaz) is a family of 80MHz, 11ac Wave2,
> 4x4/2x4/2x2 chips, including single and dual band devices.
> Depending on specific chip model and firmware in use, either
> STA or both STA and AP modes are supported.
>
> Patch adds Topaz support to qtnfmac_pcie driver. Proper platform
> bus will be selected on probing based on chip ID.
>
> Signed-off-by: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
> Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
> Signed-off-by: Andrey Shevchenko <ashevchenko@quantenna.com>
> ---

(snip)

> diff --git a/drivers/net/wireless/quantenna/qtnfmac/qtn_hw_ids.h b/drivers/net/wireless/quantenna/qtnfmac/qtn_hw_ids.h
> index 1fe798a9a667..40295a511224 100644
> --- a/drivers/net/wireless/quantenna/qtnfmac/qtn_hw_ids.h
> +++ b/drivers/net/wireless/quantenna/qtnfmac/qtn_hw_ids.h
> @@ -23,7 +23,7 @@
>
>  /* PCIE Device IDs */
>
> -#define        PCIE_DEVICE_ID_QTN_PEARL        (0x0008)
> +#define        PCIE_DEVICE_ID_QSR              (0x0008)
>
>  #define QTN_REG_SYS_CTRL_CSR           0x14
>  #define QTN_CHIP_ID_MASK               0xF0
> @@ -35,6 +35,8 @@
>  /* FW names */
>
>  #define QTN_PCI_PEARL_FW_NAME          "qtn/fmac_qsr10g.img"
> +#define QTN_PCI_TOPAZ_FW_NAME          "qtn/fmac_qsr1000.img"
> +#define QTN_PCI_TOPAZ_BOOTLD_NAME      "qtn/uboot_qsr1000.img"

A bit late of a review/question, but how does one obtain one of these
files? There's nothing in linux-firmware, and I see only one aborted
attempt for adding fmac_qsr10g.img from 2016, but none for the others.
Searching for these filenames also didn't reveal any external
locations.


Regards
Jonas
