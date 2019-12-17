Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBD81225F5
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2019 08:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfLQHzY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Dec 2019 02:55:24 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:43789 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfLQHzY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Dec 2019 02:55:24 -0500
Received: by mail-ua1-f65.google.com with SMTP id o42so3088377uad.10
        for <linux-wireless@vger.kernel.org>; Mon, 16 Dec 2019 23:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D/G4kabHjV1Lusdqw/G6dw2FBJ3uTWRu8cTEqrGadRc=;
        b=cqxUCS1G7IVlmZvkGltrHuDvw87/5/pLpJM73tDzujFsINJejRbYX9BIQK4bK0qEpd
         aL7ZT7jEZvO2i8XPmtx7M81MjiuXlETZubVw6VAs5B8NlxJw2TUhLzUyj3DNJbtM2vzb
         dOt8lrato+QsLoDXAErMfix5j883CUoviYZGphX3bOkKf1ZKQUFsNt/DYI16E2F5uY5h
         v7Zz5FgP+hD/MvfaOZM6pPeguCJ6VYy0wvSfTwUXfItg6v7iUKVdJM0jemddjHzambNe
         i2wsgCghSxNeJdd/rqzolcrVeYq8mXslcPymPufh+L4n2eaivAXpE9TLdvkG+eZr8z29
         /20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D/G4kabHjV1Lusdqw/G6dw2FBJ3uTWRu8cTEqrGadRc=;
        b=JW77wV7pTDTZdga068D4VoqgDEPyYh5+bj4PJLEGsAbE2s1EnWdN5zJ/xAG7wcT3PP
         3Lhg62hiuCx+LBBZbLh5n95cBnflD+Pd/QZnElPXROHX3XQ90zw1UZKd6aWNFSRlertK
         8tRB0ANfp5Vn8CPTSIHsQncSzXFdg8eZstXGoHAUOLzQ+fquMt6gv7Nhj2bfdYCrxpFf
         DFlBdKrQD5QDEbA+ICV/054EGZAp28pQk8plXT3whb52nGcXNQPmXXo/3S6DB/btLyEI
         4yc7Ly5KgkhZjg/fpIHr48lNgixkNrvIKnsArUNNKPIXbU++iZvCnyAf2a7G/n4fMbDx
         Iqmw==
X-Gm-Message-State: APjAAAX1Z44ABsCFRiw+w526O88VpLN+5XAew8g4GnbKxTRUnYv9WkMf
        b8HuDNN0QdQir63N+8Z+vqMdqeZtisM0Y5LQoxGyvw==
X-Google-Smtp-Source: APXvYqxzdVAw5xWowo76mTkKJL0/jmHoaluvjaRWrMwjM/D4pyKtGc5/nZ36l5Vnq7j6h5fqJ/4pYZyi9KnoEW68OJc=
X-Received: by 2002:ab0:5510:: with SMTP id t16mr2491529uaa.15.1576569323481;
 Mon, 16 Dec 2019 23:55:23 -0800 (PST)
MIME-Version: 1.0
References: <20191213185050.m6iku7defq44syrl@kili.mountain>
In-Reply-To: <20191213185050.m6iku7defq44syrl@kili.mountain>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 17 Dec 2019 08:54:47 +0100
Message-ID: <CAPDyKFoKvhGDuQ+C0Sp2N3==CXiMWfpcrT28+dQ2+Nq_UPaXYQ@mail.gmail.com>
Subject: Re: [bug report] mmc: core: Re-work HW reset for SDIO cards
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ Kalle

On Fri, 13 Dec 2019 at 19:51, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hello Ulf Hansson,
>
> The patch 2ac55d5e5ec9: "mmc: core: Re-work HW reset for SDIO cards"
> from Oct 17, 2019, leads to the following static checker warning:
>
>         drivers/net/wireless/ath/ath10k/sdio.c:1521 ath10k_sdio_hif_power_down()
>         warn: 'ret' can be either negative or positive

Thanks for reporting!

>
> drivers/net/wireless/ath/ath10k/sdio.c
>   1495  static void ath10k_sdio_hif_power_down(struct ath10k *ar)
>   1496  {
>   1497          struct ath10k_sdio *ar_sdio = ath10k_sdio_priv(ar);
>   1498          int ret;
>   1499
>   1500          if (ar_sdio->is_disabled)
>   1501                  return;
>   1502
>   1503          ath10k_dbg(ar, ATH10K_DBG_BOOT, "sdio power off\n");
>   1504
>   1505          /* Disable the card */
>   1506          sdio_claim_host(ar_sdio->func);
>   1507
>   1508          ret = sdio_disable_func(ar_sdio->func);
>   1509          if (ret) {
>   1510                  ath10k_warn(ar, "unable to disable sdio function: %d\n", ret);
>   1511                  sdio_release_host(ar_sdio->func);
>   1512                  return;
>   1513          }
>   1514
>   1515          ret = mmc_hw_reset(ar_sdio->func->card->host);
>   1516          if (ret)
>
> It used to be that mmc_hw_reset() return negative error codes or zero
> but now it returns 1 on certain success paths.

Correct.

I was actually looking into this while changing the behaviour of
mmc_hw_reset(). However I decided to leave this as is.

The main reason is, that mmc_hw_reset() is not going to power down the
card. It's hard power cycle, so I am kind of surprised that is being
used at all in this path. This in combination of expecting the value
from mmc_hw_reset() to never be 1 here, seemed like a good idea to
preserve the logging of the warning message.

To silent the static checker tool from warning, we could check
explicitly for "1". Is that something you want me to do?

>
>   1517                  ath10k_warn(ar, "unable to reset sdio: %d\n", ret);
>   1518
>   1519          sdio_release_host(ar_sdio->func);
>   1520
>   1521          ar_sdio->is_disabled = true;
>   1522  }
>
>
> regards,
> dan carpenter

Kind regards
Uffe
