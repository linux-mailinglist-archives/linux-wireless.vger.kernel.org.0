Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAD4A3C785
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2019 11:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404403AbfFKJp7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jun 2019 05:45:59 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46225 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727642AbfFKJp7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jun 2019 05:45:59 -0400
Received: by mail-ed1-f65.google.com with SMTP id h10so19020160edi.13
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2019 02:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mkdlossu9lkxS+7fRGCsNjYHJ659d4NTmh7T043IVrg=;
        b=IdiVrQEX32WX90t0/HexUB9Ksn3VMNyrEqRXZQLgqmM7A67yWGY9W8PUxleDbCUPkQ
         Nvufs45TxmtzGRApQzZBtuIwBIJAwyocydORqnwwDoKMtgIUDbciKT1d2p/qz71PlS72
         Y9HwIrOByPAzWjgYKggtBaJcNkdY7DJlTzc0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mkdlossu9lkxS+7fRGCsNjYHJ659d4NTmh7T043IVrg=;
        b=JFiDy4mg3ZmMHgCKlR3hU12j4vHr1NHCcgwT7RX/BTYsD/MiMyardF/lqVuCOGPnyx
         8x4+UmljUskyoNxLPAwIb9BCm98wWHXOkEU8NNpnab+gpa2VQMcP71xuWWGc/98D4DTS
         faPt0PMZtjIgY564bXhKkjmIi/HyVLcyu2St6uRs7iDfepd7hOiIx7wMd1HxqPKJIE4+
         3HDcyXSUO9iNhvq3kREWgfAy1KIJXrzSpLavASfxE6rDxwv9YTDRueNUR0Hw3xVIh5kS
         4FyyiGgxa3T/9sJMYwE/deZrf4oDYrwHoU3rYmXe13WpsbJwFiPnU2dKqpb4nt1Wykjp
         u1uQ==
X-Gm-Message-State: APjAAAUru1nZjCKsS5/9V6Sl7TAMECmcz7SVkEdk9Lu6dVSodiU0Jx1k
        XO8QrcapTtenYRQy+3hIWvdn9DOcc+MSgQ==
X-Google-Smtp-Source: APXvYqxDlFfxho6SJTCjm9BquKOHPv6k0vEXDxaiUuzc4Ftcb8mdwIFJqXR0brEIF69YKXUX4b6bDQ==
X-Received: by 2002:a50:b839:: with SMTP id j54mr47167857ede.155.1560246357864;
        Tue, 11 Jun 2019 02:45:57 -0700 (PDT)
Received: from [10.176.68.125] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id j3sm3558235edh.82.2019.06.11.02.45.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 02:45:57 -0700 (PDT)
Subject: Re: [RESEND] brcmfmac support for BCM4359 sdio on arm64 ??
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, Wright.Feng@cypress.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>
References: <F5C2858A-498E-4AD3-859D-FA9D14BF6B37@gmail.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <37d2964d-1c2b-51bd-ac98-2cc171aa0c9c@broadcom.com>
Date:   Tue, 11 Jun 2019 11:45:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <F5C2858A-498E-4AD3-859D-FA9D14BF6B37@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/8/2019 5:39 AM, Christian Hewitt wrote:
> Hello Arend,
> 
> Last October Christoph Müllner reported BCM4359 SDIO issues here: https://www.spinics.net/lists/linux-wireless/msg178783.html but the investigation stalled after the needs/timescale of his project forced a change to a different (working) module.
> 
> BCM4359 is being used in an increasing number of Amlogic devices the Kodi focussed distro LibreELEC supports. I’m one of the maintainers for the distro and I’d like to assist/resume the investigation.
> 
> To recap: using changes from Wright Feng that can be found here https://github.com/RobertCNelson/ti-linux-kernel-dev/blob/65f17112e1c883d3c9f3fa68837e5f9b5eb7cfad/patches/cypress/v4.14.52-2018_0928/cypress-patch/0050-brcmfmac-Add-support-for-BCM4359-SDIO-chipset.patch result in the BCM4359 device being identified but firmware/nvram loading fails:
> 
> [    8.557929] brcmfmac: F1 signature read @0x18000000=0x17294359
> [    8.562087] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac4359-sdio for chip BCM4359/9
> [    8.775655] brcmfmac: brcmf_sdiod_ramrw: membytes transfer failed
> [    8.775667] brcmfmac: brcmf_sdio_verifymemory: error -84 on reading 2048 membytes at 0x0025f0c0
> [    8.775670] brcmfmac: brcmf_sdio_download_firmware: dongle nvram file download failed

It seems to fail when reading back the nvram file to assure it was 
downloaded properly.

> See: http://ix.io/1KfY for the full dmesg output on 5.1-rc1 kernel including a splat that may or may not be related/relevant. I am using firmware and nvram files from https://github.com/LibreELEC/brcmfmac_sdio-firmware which match files found in several other github and public repo locations. The firmware/nvram are reported working in Android.

The splat could be relevant. Maybe try the patch below to get actual 
values that are checked in the WARN_ON.

> BCMDHD is also reported working with commits here: https://gitlab.com/baylibre/amlogic/atv/linux/commits/narmstrong/v5.1/aml/integ-5.1-bcmdhd but LibreELEC needs to support many different boards (with many different SDIO modules) from a single OS image, so BCMDHD is not the solution we need.
> 
> One additional patch I spotted mentioning BCM4359 (also from Wright Feng) was https://github.com/RobertCNelson/ti-linux-kernel-dev/blob/65f17112e1c883d3c9f3fa68837e5f9b5eb7cfad/patches/cypress/v4.14.52-2018_0928/cypress-patch/0073-non-upstream-reset-two-D11-cores-if-chip-has-two-D11.patch but it makes no difference (the dmesg log above is with this patch applied).
> 
> I don’t write code but am happy to build test kernels with suggested patches or explicit instructions. I’ve also CC’d LibreELEC colleague and linux-amlogic maintainer Neil Armstrong who can assist. NB: If direct access to hardware would help progress things I can easily organise remote access or get board samples shipped.
> 
> How can we resume the investigation?

Let's try one step at a time ;-)

Regards,
Arend
---
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c 
b/driver
index fc12598..e9b0986 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -772,7 +772,8 @@ void brcmf_sdiod_sgtable_alloc(struct brcmf_sdio_dev 
*sdiod
                       sdiodev->settings->bus.sdio.txglomsz);
         nents += (nents >> 4) + 1;

-       WARN_ON(nents > sdiodev->max_segment_count);
+       WARN(nents > sdiodev->max_segment_count, "max_seg_cnt=%u, 
host_max_seg=
+            sdiodev->max_segment_count, host->max_segs, nents);

         brcmf_dbg(TRACE, "nents=%d\n", nents);
         err = sg_alloc_table(&sdiodev->sgtable, nents, GFP_KERNEL);
q
