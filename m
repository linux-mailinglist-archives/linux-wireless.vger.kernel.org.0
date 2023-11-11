Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255147E8BB8
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Nov 2023 17:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjKKQsq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 Nov 2023 11:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjKKQsp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 Nov 2023 11:48:45 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9392590
        for <linux-wireless@vger.kernel.org>; Sat, 11 Nov 2023 08:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1699721307; x=1700326107; i=wahrenst@gmx.net;
        bh=dNAn0wYj/TnZTYATgaI9kmfZojIZxyDfgfJ/IRyhsdM=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=THZynaP0lknSmZcbiUUBRcOhdhsK0acS6mcHMzqLqut2HWFXX8qxNhMjdyo58LJr
         FHmpGgZBq5up9A2VcijL/qnK1El4/YhxEllWByXkx4LAWLPJ57b37bm1ydYXvmQiM
         JLefTsFj3tBKi6Z+4UuTzyFJl2urpI0D+K953sxz5FJPAFjOBfW8etOgmHFK0ezCU
         jNRO0Rq8FjBdUTTtN71i5rbS7cvzoppoWvrSHiRyyhXibCzd1N5O4KnqjoSFIKNGf
         naEehONFd0Uqbv/jyaYUs32ZHCfkev+r3umQyFhx+B6e15rg+FSl9b+xjiGgo44Qt
         QMVDjDrQl6pbZSGM1w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MORAU-1qksEP1EwY-00Pz2u; Sat, 11
 Nov 2023 17:48:27 +0100
Message-ID: <d9c9336a-6314-4de9-aead-8b865bb30f05@gmx.net>
Date:   Sat, 11 Nov 2023 17:48:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, Hector Martin <marcan@marcan.st>,
        Kalle Valo <kvalo@kernel.org>
From:   Stefan Wahren <wahrenst@gmx.net>
Subject: brcmfmac: Unexpected brcmf_set_channel: set chanspec 0xd022 fail,
 reason -52 - Part 2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l3wm5pcy3Pv2fLGSW7lmjgQiWKyNKhgTWWm4qhdYODsVyS4GVsm
 eHeYmwbAIhzQWAuz/dDOFuUKdYklaLNGGwDmlzxG4mImenUIGNjDSNsL9UArx4mJ0VidAgf
 N/OaNIIxKGFb198qrEGVDo/CCRwKofHe0BW4plRtTc8jXLzBi6vw0M1M8ppSEKfpInac51y
 8IhTd/JdUjr66Ebpu78cQ==
UI-OutboundReport: notjunk:1;M01:P0:+wgohZjXzBs=;BbmGk/h/SeFyaJWlF406ko/ZSS2
 jVUm7zSyX33zOEsI9/du1rWoKuBOJ1kO3fqwSUxkioHaPzIArQdA3kDjg+WGpDYbIGeAMgjCq
 oiq4Qio+zo0llqU6m4uBkFBQmr4jSkKccLYtpsF5D2PcxJMFOtFH8VO+e3xbh+hPCZqltfMLm
 Rzk3K9P5lnzo8OO521IGbAVpPTB8EbsExJw1h4PM7ijkpgv3G4PIg/8uFGwKMUo2XmMP8QLmX
 y97KKCOiIIBLZpawl0D/jN4QXobygHgYd2WHT3oLFFGZdiV95IDwF0maD8U/vYPnVCxLaZHN/
 P1NL8qrb7CaUTZ1THVHI2i8aQpSVwlBLpd4WCDmXiHpQljIoCz3Um30FssOD7XyfGfPNe1XYW
 QTWAc6xCLWhi5+lLAyM3sMIvf/Y7vkOTDHrT+rNFuDOnrCbvcFXzIHV1Ohz5YT0NjCe6D65nT
 cNzsSbdtojtfQPF/W09rZgSsZHs6OQ86CbNVPSNusw9mmqEGLESTYyzCEypw5299rMQAvWiLr
 JlcgoPu9W06f8ky6X3zQCt9YBA8/zvh+ouiAcJglLdl0Ecqn6GjxQsnDJlwsDEknZ3980Nq6F
 IyWhLvmXVNoNddxRJfCzjbp7Q74i29L6w9gbqOiApYtAINP6juLlJApi+W20527TUVJ5NLY5V
 sca94rDXCbjxX+i4cLFVqTVjgIAwS/Coxnqoheg8xudpVXoW3XQcXHIf90kIf1DzwdInL6zPR
 SVSEqkDkQbrgxhnwY+T+fc3JRCP5jWp7zWLw6nmgs5/q3nkllicVqnkA1Q2PBLrtVt8YceKfM
 JkuvA7VwiaJi3FoMWjFMD7LNpBN2HYPztguAacOlsrqdZmJImDNSdXM0qNSEKiR3uVQhjhDFL
 7sjAiLyqegD2nYCJTxzFKsypkh82W7ZgRb1/j6664NBb8Y9N9YxniM6S2EJTw7KniM+v0GBrN
 GCXVEg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

almost one year ago, i reported [1] about annoying log messages from
brcmfmac. After commit "wifi: brcmfmac: avoid handling disabled channels
for survey dump" [2] the periodic messages disappeared, which is great.

Unfortunately there is a different scenario, which still trigger them at
least on the Raspberry Pi 3B+ (arm/multi_v7_defconfig). I tested Linux
6.3, 6.6 and recent mainline.

Used firmware:
Firmware: BCM4345/6 wl0: Jan  4 2021 19:56:29 version 7.45.229 (617f1f5
CY) FWID 01-2dbd9d2e

Scenario:
- start Raspberry Pi 3B+ with graphical interface
- wpa_supplicant successful connects automatically to WPA2 network
- disconnect from WPA2 network (no brcmfmac error messages until now)
- re-connect successfully to WPA2 network again (trigger error messages
once)

Example output from current mainline:
[   87.449903] brcmfmac: brcmf_set_channel: set chanspec 0xd022 fail,
reason -52
[   87.559928] brcmfmac: brcmf_set_channel: set chanspec 0xd026 fail,
reason -52
[   87.669940] brcmfmac: brcmf_set_channel: set chanspec 0xd02a fail,
reason -52
[   87.779964] brcmfmac: brcmf_set_channel: set chanspec 0xd02e fail,
reason -52
[   89.539921] brcmfmac: brcmf_set_channel: set chanspec 0xd090 fail,
reason -52
[   89.540316] brcmfmac: brcmf_set_channel: set chanspec 0xd095 fail,
reason -52
[   89.540653] brcmfmac: brcmf_set_channel: set chanspec 0xd099 fail,
reason -52
[   89.540985] brcmfmac: brcmf_set_channel: set chanspec 0xd09d fail,
reason -52
[   89.541326] brcmfmac: brcmf_set_channel: set chanspec 0xd0a1 fail,
reason -52
[   89.541662] brcmfmac: brcmf_set_channel: set chanspec 0xd0a5 fail,
reason -52

Best regards

[1] -
https://lore.kernel.org/linux-wireless/2635fd4f-dfa0-1d87-058b-e455cee9675=
0@i2se.com/
[2] -
https://lore.kernel.org/linux-wireless/2635fd4f-dfa0-1d87-058b-e455cee9675=
0@i2se.com/
