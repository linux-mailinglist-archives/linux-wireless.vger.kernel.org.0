Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F00D39A54
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Jun 2019 05:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbfFHDja (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jun 2019 23:39:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35988 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729815AbfFHDja (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jun 2019 23:39:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so3960140wrs.3
        for <linux-wireless@vger.kernel.org>; Fri, 07 Jun 2019 20:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=SZz5vVSJj8L6XufIxjbBexPqNKXNzXpd6+WCpGpcP98=;
        b=MErl10UZBpdf710/fP2BVb/RQQC5cBNpnW7eJravUgJKEGlClD1qSaq7LWyxsdp+oO
         ZfRuSJIdW9HgzuOzazCbqMlzduiQW5duuTVVTt//1BHX5dQXVgpdS/p/bLLemLpGYWbK
         /94cCwJ4itLqE/N+j2T5QUTyPX2Y1sUhZ4E2LkX8asYgcB7nQIqfeLcFn+xpesKMyTIq
         Ym/tEI/9vL489aHRl2dcr4C325D43OV8+f8qQtBei0O8AfQ9Hhv8XlWEXrVGClz6S17p
         hKUZiHhiwxJoXPNWNydWWQZVgLfwYYHLJSfMQ1CkKy2PN4bppqm8vYkr6lHTziiUZpT8
         tHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=SZz5vVSJj8L6XufIxjbBexPqNKXNzXpd6+WCpGpcP98=;
        b=m1LY9yT5m6i9PC2SEfyxx68qkOiRXZV7JT8q/M7YaQIOs293EAvmDDiX+zFA8qwOmy
         ++diXf0zEs18rDqkFQIkLgjZ169t7Afr6cuQYaUNrqLcqjDWSng5i1quKphxKn+1jBVd
         V+6OLJhurfNejy57+6qCO1OFAbFfOTx8KHZESFAM6Y7478jl7eO99tdns8Q0ZShg7I6P
         HrlA3KbFHSsK5OMpdXxG5UPfkOLmWvMvzyWyXtGr+b4uthwbL4gs52Y0oeNFlivg8O5x
         q+gTJEWeB1YALYKffqLb99NAfK4Nx4QzhzA8RdgjKdkf/ie9LN4q1sVymmeUL9QqdcZC
         EMrg==
X-Gm-Message-State: APjAAAUjjkTiemK0hWVqgV6w/Yc+W2xQahGWIaYdrftURh60t9iUF9AB
        NzNzEwjqM+KmMtqsrisvd0Y=
X-Google-Smtp-Source: APXvYqyFv4HMoPXh25aCBhRSkh8nilO7d6F+m4VakO2891X9n2g1exJO0UyyvI6nmXrJikaYbPpnMA==
X-Received: by 2002:adf:e2c8:: with SMTP id d8mr20952962wrj.14.1559965168598;
        Fri, 07 Jun 2019 20:39:28 -0700 (PDT)
Received: from [172.16.20.20] ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id k2sm3475317wrx.84.2019.06.07.20.39.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 20:39:28 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: [RESEND] brcmfmac support for BCM4359 sdio on arm64 ??
Message-Id: <F5C2858A-498E-4AD3-859D-FA9D14BF6B37@gmail.com>
Date:   Sat, 8 Jun 2019 07:39:24 +0400
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, Wright.Feng@cypress.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>
To:     arend.vanspriel@broadcom.com
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Arend,

Last October Christoph M=C3=BCllner reported BCM4359 SDIO issues here: =
https://www.spinics.net/lists/linux-wireless/msg178783.html but the =
investigation stalled after the needs/timescale of his project forced a =
change to a different (working) module.

BCM4359 is being used in an increasing number of Amlogic devices the =
Kodi focussed distro LibreELEC supports. I=E2=80=99m one of the =
maintainers for the distro and I=E2=80=99d like to assist/resume the =
investigation.

To recap: using changes from Wright Feng that can be found here =
https://github.com/RobertCNelson/ti-linux-kernel-dev/blob/65f17112e1c883d3=
c9f3fa68837e5f9b5eb7cfad/patches/cypress/v4.14.52-2018_0928/cypress-patch/=
0050-brcmfmac-Add-support-for-BCM4359-SDIO-chipset.patch result in the =
BCM4359 device being identified but firmware/nvram loading fails:

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
firmware and nvram files from =
https://github.com/LibreELEC/brcmfmac_sdio-firmware which match files =
found in several other github and public repo locations. The =
firmware/nvram are reported working in Android.=20

BCMDHD is also reported working with commits here: =
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

I don=E2=80=99t write code but am happy to build test kernels with =
suggested patches or explicit instructions. I=E2=80=99ve also CC=E2=80=99d=
 LibreELEC colleague and linux-amlogic maintainer Neil Armstrong who can =
assist. NB: If direct access to hardware would help progress things I =
can easily organise remote access or get board samples shipped.

How can we resume the investigation?

Christian

