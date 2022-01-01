Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C34B48286D
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Jan 2022 21:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbiAAU1f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 1 Jan 2022 15:27:35 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:37069 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbiAAU1d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 1 Jan 2022 15:27:33 -0500
Received: from localhost.localdomain ([37.4.249.169]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MGA0o-1nBOsJ3wMO-00GbrR; Sat, 01 Jan 2022 21:27:16 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Phil Elwell <phil@raspberrypi.com>, devicetree@vger.kernel.org,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH RFC 0/4] ARM: dts: Add Raspberry Pi Zero 2 W support
Date:   Sat,  1 Jan 2022 21:26:48 +0100
Message-Id: <1641068812-5851-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:IFSO4SUR/GIS5KxCX2rqPx8bY+J5e6YDOUTd/t3oeHG3mWoStUS
 AX9YcJnrfYrz4qtPGFGKHCv+7TU0r7i+BCJ0vHJR4hO8aCnWTQM+7lQ54tAHw/PDBw6eOUb
 G5giL64OquBD3UCz0yfE3ba43et33AA4GJaVYkId52sxzvofn4udgAMoRbOyzciF+0nZeo3
 f5i6sNZOpDTXNG1N2EQjA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RMBwnFZyx5g=:PTRizSkKrKbmSWzLVZGc6P
 ZcSXAb1FX2HHMdsC8kWz4h6/l1iypMbdizOj6zbg1IpaPhMQEpXai+9g6DqObTG4EkZJxqkMr
 UuDC88WT7yma8TzB6nB67trJXLk+E/mn/n+74NaZTTSMHzUIxS7Lx4+ZDFjr0Ju4wYig1vDnU
 U57qD0hz7bMqPoobFfJF21ROv/w2v8LiQ7a/VcNiy+rolUHXxYuGSHh/Q0WK6yVeLt8mLc5TG
 EId8GyC6kX3K80nFI5cmQkMrz2W/dI88sd+wUTmw30nVqIS/mDiNa2z60mdaucaXJ+uzx8EYk
 iH1Jxv69x7iwISlvH1LH51No8D1oagBhr1J7AeQDGa5viPV5PtmdLSbWNhMy7qAHMUQmwFn0V
 a5HTNwnZmaFtPwLQDIiUiY529izbN1O7B9AxnZlEw+dsLOgg3fbYfXR92TnzxoiAZCoD6TFcU
 0pwbvEI3XSwMECn3JTB22MdcPkubVlbhOSOJRWt4HoFCqC19eVXjaozI1VHgyEM2KFnPWy1sz
 KwhLyuIfxWsiWcfSMkLKZ3e81v9784HCvAU6u6Kkagct0wc9ewjfjEGyquxzlWdrrBFRNi3c2
 girp8TbUczpJxHZGvogr7aoiSPoRXLusoiICbhamxU6zMztUy/70MA69HKdxKh6H/Y4k2PN5l
 3fRo5ra8jSiwpZAH90Ke2WBkGMwyEp405iWhohDw51vG+camf5f9o2UokUq41AqqQ7H6w6jTY
 EF2f0mI6k6GsMKWl
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This small series tries to add support for the Raspberry Pi Zero 2 W.

Stefan Wahren (4):
  brcmfmac: use separate firmware for 43430 revision 4
  dt-bindings: arm: bcm2835: Add Raspberry Pi Zero 2 W
  ARM: dts: Add Raspberry Pi Zero 2 W
  arm64: dts: broadcom: Add reference to RPi Zero 2 W

 .../devicetree/bindings/arm/bcm/bcm2835.yaml       |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/bcm2837-rpi-zero-2-w.dts         | 136 +++++++++++++++++++++
 arch/arm64/boot/dts/broadcom/Makefile              |   3 +-
 .../boot/dts/broadcom/bcm2837-rpi-zero-2-w.dts     |   2 +
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    |   4 +-
 6 files changed, 145 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm2837-rpi-zero-2-w.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837-rpi-zero-2-w.dts

-- 
2.7.4

