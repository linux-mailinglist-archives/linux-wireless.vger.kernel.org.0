Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33B14ADE67
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Feb 2022 17:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382831AbiBHQeV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Feb 2022 11:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343746AbiBHQeU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Feb 2022 11:34:20 -0500
X-Greylist: delayed 444 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 08:34:17 PST
Received: from mx4.securetransport.de (mx4.securetransport.de [178.254.6.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CEEC5C061576
        for <linux-wireless@vger.kernel.org>; Tue,  8 Feb 2022 08:34:17 -0800 (PST)
Received: from mail.dh-electronics.com (business-24-134-97-169.pool2.vodafone-ip.de [24.134.97.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.securetransport.de (Postfix) with ESMTPSA id 8725C72030B;
        Tue,  8 Feb 2022 17:26:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1644337594;
        bh=Jgt7DJJcti2J7ijVBBTXfSxyUJJnJXpSzrQGfK2Wy84=;
        h=From:To:CC:Subject:Date:From;
        b=dinHwezZfwAx/HaEBe71M0iHp4XvOAFfkjfy4HPyo4MRu4mOQ6gdEmYOaZuGQwv4z
         AgY/vzKEugZo9JlcZ57kIgqByD//rMphqmbQhuX7LR+wGTG0phm8RvdJ+M5m7KaITd
         ObCFQn2xZkRkwIAQchBpYtzUyjGzi9s0XSxRpWU+/8gOu6/le8U2aMOkpW+BSvdPtC
         ok1N62idduVsazLz+gD9PSWsE8LV50O24/XAFmugDX9ewVdZaAbZ2tzz2vJZC9PSr2
         83mfElFK11G+aY+6WMEDdmJV6AQ/RCudUgikdSNJA1dHEFWKwiRW9G57SkkM05o2/L
         KcRQEDUevjQLg==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 8 Feb 2022 17:26:07 +0100
Received: from DHPWEX01.DH-ELECTRONICS.ORG ([fe80::6ced:fa7f:9a9c:e579]) by
 DHPWEX01.DH-ELECTRONICS.ORG ([fe80::6ced:fa7f:9a9c:e579%6]) with mapi id
 15.02.0986.015; Tue, 8 Feb 2022 17:26:07 +0100
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "ajay.kathat@microchip.com" <ajay.kathat@microchip.com>,
        "claudiu.beznea@microchip.com" <claudiu.beznea@microchip.com>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "Andreas Geisreiter" <ageisreiter@dh-electronics.com>,
        "Marek MV. Vasut" <marex@denx.de>
Subject: Possible bug on wilc1000 [Klartext]
Thread-Topic: Possible bug on wilc1000 [Klartext]
Thread-Index: AdgdBYpowDRGmRhhS4ylc9cEzwODUw==
Date:   Tue, 8 Feb 2022 16:26:07 +0000
Message-ID: <3994a34bb0d84e9d8181ec490a3f71d2@dh-electronics.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.51.18]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I tested the wireless chip wilc1000 with the 5.16.5 Kernel and the firmware=
 v15.4.1
(https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.gi=
t/tree/atmel/wilc1000_wifi_firmware-1.bin)
on an i.MX6 QUAD with iperf3:

# iperf3 -c IP_ADDR -P 16 -t 0=20

After a while the test gets stuck and I got the following kernel messages:
mmc0: Timeout waiting for hardware interrupt.
mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI REGISTER DUMP =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
mmc0: sdhci: Sys addr:  0x138f0200 | Version:  0x00000002
mmc0: sdhci: Blk size:  0x00000158 | Blk cnt:  0x00000001
mmc0: sdhci: Argument:  0x14000158 | Trn mode: 0x00000013
mmc0: sdhci: Present:   0x01d88a0a | Host ctl: 0x00000013
mmc0: sdhci: Power:     0x00000002 | Blk gap:  0x00000080
mmc0: sdhci: Wake-up:   0x00000008 | Clock:    0x0000009f
mmc0: sdhci: Timeout:   0x0000008f | Int stat: 0x00000000
mmc0: sdhci: Int enab:  0x107f100b | Sig enab: 0x107f100b
mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000003
mmc0: sdhci: Caps:      0x07eb0000 | Caps_1:   0x0000a000
mmc0: sdhci: Cmd:       0x0000353a | Max curr: 0x00ffffff
mmc0: sdhci: Resp[0]:   0x00001000 | Resp[1]:  0x00000000
mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
mmc0: sdhci: Host ctl2: 0x00000000
mmc0: sdhci: ADMA Err:  0x00000007 | ADMA Ptr: 0x4c041200
mmc0: sdhci-esdhc-imx: =3D=3D=3D=3D=3D=3D=3D=3D=3D ESDHC IMX DEBUG STATUS D=
UMP =3D=3D=3D=3D=3D=3D=3D=3D=3D
mmc0: sdhci-esdhc-imx: cmd debug status:  0x2100
mmc0: sdhci-esdhc-imx: data debug status:  0x2200
mmc0: sdhci-esdhc-imx: trans debug status:  0x2300
mmc0: sdhci-esdhc-imx: dma debug status:  0x2402
mmc0: sdhci-esdhc-imx: adma debug status:  0x25b4
mmc0: sdhci-esdhc-imx: fifo debug status:  0x2610
mmc0: sdhci-esdhc-imx: async fifo debug status:  0x2751
mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
wilc1000_sdio mmc0:0001:1: wilc_sdio_cmd53..failed, err(-110)
wilc1000_sdio mmc0:0001:1: Failed cmd53 [0], bytes read...

I tried to reduce the clock speed to 20MHz in the devicetree with
max-frequency =3D <20000000>;
but the problem then also occurs.

Is this a possible bug?


Thanks in advance and best regards
Christoph
