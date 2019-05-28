Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF2692C001
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2019 09:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfE1HTs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 May 2019 03:19:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39965 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfE1HTs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 May 2019 03:19:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id 15so1538503wmg.5
        for <linux-wireless@vger.kernel.org>; Tue, 28 May 2019 00:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=ZF+cSC/4MWq0mKk78GnfZCDNZCWZTceLMMBw2Bu/KBs=;
        b=OnRWoALvwN5m89qZ8JT8Vep2+HTCX3n9l/3WuVHdpDIvXlqKA/SgebAJdTQQcZtAMS
         D9HruHPLM4rXo5SM1Vjw44FGVy+g4qRrtIDWkvCit2hCVDd6w5DHpzbEhsRkkWoHQREx
         0rNtMdRx2gUCfxHT+wt1Xrb5qvaDC7fxrFmxvha29yK+nhb0o18fek/KsjbrfURi9ySb
         ObHDuqjyiVWAmYq4llxsiWKg6ZGEBqD2RgS2yGSnSw4OQxVmnWEQhqJ7WDJ560FskerB
         6EjGICfiDwM8IdLvsNrpRsN02hHPewgrprd4yeWQY/4NM/csWxgZ/dF/jJfxnybdGZnZ
         CPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=ZF+cSC/4MWq0mKk78GnfZCDNZCWZTceLMMBw2Bu/KBs=;
        b=GjabrN52KNw5pBQcSyMpVpu+NdV5xNfOOknGl+KsJJNdC9QEAaT/p+C6HtZ1wOPz9g
         c/hAM97NEFIFrDv8x2O9cnb4Onl0ClEZI2xY+b63aj6FaMpNEtXG8zwQMaFk2CAldzi9
         uBn6hKWx+zDxu7uCCGq8kVl9Ffzj/EkCG0IBxshPmr8+x5zFgloGfsq7e+EMUJ4Dsu30
         VJMEp16PDTiVD8KAi39YmAPqoAr43jVsvOFwEgHvMWwHdxbb27Mie0T5Ye1P+p0JlgNL
         Oid8sGz0UZ8P/+7PpvKYxuAKHaWHcUOYNPmm/pe8F7zeE3/qvkwB2rWoXPrHXzynbdmf
         44sQ==
X-Gm-Message-State: APjAAAVjq5WsicQ/lTI6n+wdtOroyq29uzkA2u0XMvnpodM4wZF35N2o
        vYl9N347YcdkaZE09IwYs2k=
X-Google-Smtp-Source: APXvYqyubbBEyOG4UGx0pI+rLCtFB2FzzQeVvDVAbONooc6cGg9d6GxssLBz2jDiO7SHlzAW1UVbWg==
X-Received: by 2002:a1c:f408:: with SMTP id z8mr1928521wma.140.1559027985949;
        Tue, 28 May 2019 00:19:45 -0700 (PDT)
Received: from [172.16.20.20] ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id v11sm10694163wrr.87.2019.05.28.00.19.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 00:19:45 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: brcmfmac support for BCM4359 sdio on arm64
Message-Id: <9B1E511E-A6F7-4907-953B-537EC7F75EEE@gmail.com>
Date:   Tue, 28 May 2019 11:19:42 +0400
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, Wright.Feng@cypress.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>
To:     arend.vanspriel@broadcom.com
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Arend,

Last October Christoph M=C3=BCllner reported BCM4359 SDIO issues here: =
https://www.spinics.net/lists/linux-wireless/msg178783.html but the =
investigation stalled after the needs/timescale of his project forced a =
change to an alternate (working) module.

BCM4359 is also being used in an increasing number of Amlogic devices =
the Kodi focussed distro LibreELEC supports. I=E2=80=99m one of the =
maintainers for the distro and I=E2=80=99d like to assist/resume the =
investigation.

To recap: using changes from Wright Feng that can be found here =
https://github.com/RobertCNelson/ti-linux-kernel-dev/blob/65f17112e1c883d3=
c9f3fa68837e5f9b5eb7cfad/patches/cypress/v4.14.52-2018_0928/cypress-patch/=
0050-brcmfmac-Add-support-for-BCM4359-SDIO-chipset.patch results in the =
BCM4359 device being identified but firmware loading fails:

[    8.557929] brcmfmac: F1 signature read @0x18000000=3D0x17294359
[    8.562087] brcmfmac: brcmf_fw_alloc_request: using =
brcm/brcmfmac4359-sdio for chip BCM4359/9
[    8.775655] brcmfmac: brcmf_sdiod_ramrw: membytes transfer failed
[    8.775667] brcmfmac: brcmf_sdio_verifymemory: error -84 on reading =
2048 membytes at 0x0025f0c0
[    8.775670] brcmfmac: brcmf_sdio_download_firmware: dongle nvram file =
download failed

See: http://ix.io/1KfY for the full dmesg output on 5.1-rc1 kernel =
including a splat that may or may not be related/relevant. I am using =
the firmware and nvram files from =
https://github.com/LibreELEC/brcmfmac_sdio-firmware which match files =
found in several other github and public repo locations. The =
firmware/nvram are reported working in Android.=20

BCMDHD is also reported working with the last few commits here: =
https://gitlab.com/baylibre/amlogic/atv/linux/commits/narmstrong/v5.1/aml/=
integ-5.1-bcmdhd but LibreELEC needs to support many different boards =
(with many different SDIO modules) from a single OS image, so BCMDHD is =
not the solution we need.

One additional patch I spotted mentioning BCM4359 (also from Wright =
Feng) was =
https://github.com/RobertCNelson/ti-linux-kernel-dev/blob/65f17112e1c883d3=
c9f3fa68837e5f9b5eb7cfad/patches/cypress/v4.14.52-2018_0928/cypress-patch/=
0073-non-upstream-reset-two-D11-cores-if-chip-has-two-D11.patch but it =
makes no difference (the dmesg log above is with this patch applied).

I=E2=80=99m happy building test kernels but I don=E2=80=99t write code =
so I can be fed patches and can provide logs/output as long as the =
instructions are fairly explicit. I=E2=80=99ve also CC=E2=80=99d =
LibreELEC colleague and linux-amlogic maintainer Neil Armstrong who has =
vastly superior skills to myself and can assist. NB: If direct access to =
hardware would help progress things I can easily organise remote access =
or get board samples shipped.

How to resume things again?

Christian

