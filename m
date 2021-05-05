Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F412373A06
	for <lists+linux-wireless@lfdr.de>; Wed,  5 May 2021 14:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbhEEMG5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 May 2021 08:06:57 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:35159 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbhEEMGq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 May 2021 08:06:46 -0400
Date:   Wed, 05 May 2021 12:05:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1620216348;
        bh=gtFgm7cYrsDfbk9GuXRRueNZM65AtZ4o5bV8+RqEJZ4=;
        h=Date:To:From:Reply-To:Subject:From;
        b=xy9X5TUSkgIljXllw81KsjyIAgW93umIRgp/Lw7FObxxJW6PvT0YyF5pNMXaS9LFW
         J7D3e07415yBYhVKwrrSgwCXfv1ZbUSzy5H30EHwIDAnhG2zFwmieG0AIfqqRVXh0i
         4G4FKs0M5CNxV0WOnq24zF4ixW7goFuSrovInhck=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Michael Yartys <michael.yartys@protonmail.com>
Reply-To: Michael Yartys <michael.yartys@protonmail.com>
Subject: Possible bug in iwlwifi
Message-ID: <qnvkj7tfHuYKasegaKViuXD0K4KlchNwXkLn4NUZu_KWsp7nEBa4LyQm7SNRm27eQLALJTyi1-xIYXMChMeuZAKS5F_q-rhb0DVVGqv0oUc=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello

I've been testing out WPA3/WPA2-mixed networks on my OpenWrt router, and I =
noticed whenever I enable 802.11r the network doesn't show up in the list o=
f Wi-Fi networks in NetworkManager. I initially thought this was due to som=
e bug with wpa_supplicant, but running "iw dev wlp18s0 scan" also fails to =
list the network. If I'm not mistaken, iw doesn't use wpa_supplicant to sca=
n for networks, so that rules out wpa_supplicant. That means something deep=
er in the stack is causing this, and my guess falls on iwlwifi. I'm listing=
 what I think is relevant system info below (please let me know if there's =
anything else that's missing):

Distro: Fedora 34
Kernel: 5.11.17-300.fc34.x86_64

$ sudo lshw -C network
  *-network
       description: Wireless interface
       product: Wireless 7260
       vendor: Intel Corporation
       physical id: 0
       bus info: pci@0000:12:00.0
       logical name: wlp18s0
       version: bb
       serial: redacted
       width: 64 bits
       clock: 33MHz
       capabilities: pm msi pciexpress bus_master cap_list ethernet physica=
l wireless
       configuration: broadcast=3Dyes driver=3Diwlwifi driverversion=3D5.11=
.17-300.fc34.x86_64 firmware=3D17.3216344376.0 7260-17.ucode ip=3D192.168.1=
.202 latency=3D0 link=3Dyes multicast=3Dyes wireless=3DIEEE 802.11
       resources: irq:31 memory:fe500000-fe501fff

---------------------------------------------------------------------------=
--------------------------

This is what "iw dev wlp18s0 scan" outputs when 802.11r is disabled and it'=
s able to see the network:

BSS "redacted"(on wlp18s0)
=09last seen: 6947.060s [boottime]
=09TSF: 0 usec (0d, 00:00:00)
=09freq: 2412
=09beacon interval: 100 TUs
=09capability: ESS Privacy ShortPreamble ShortSlotTime (0x0431)
=09signal: -45.00 dBm
=09last seen: 5142 ms ago
=09Information elements from Probe Response frame:
=09SSID: OpenWrt_
=09Supported rates: 6.0* 9.0 12.0* 18.0 24.0* 36.0 48.0 54.0
=09DS Parameter set: channel 1
=09Country: NO=09Environment: Indoor/Outdoor
=09=09Channels [1 - 13] @ 20 dBm
=09ERP: <no flags>
=09RSN:=09 * Version: 1
=09=09 * Group cipher: CCMP
=09=09 * Pairwise ciphers: CCMP
=09=09 * Authentication suites: PSK PSK/SHA-256 SAE
=09=09 * Capabilities: 16-PTKSA-RC 1-GTKSA-RC MFP-capable (0x008c)
=09BSS Load:
=09=09 * station count: 0
=09=09 * channel utilisation: 15/255
=09=09 * available admission capacity: 0 [*32us]
=09Supported operating classes:
=09=09 * current operating class: 81
=09HT capabilities:
=09=09Capabilities: 0x19ed
=09=09=09RX LDPC
=09=09=09HT20
=09=09=09SM Power Save disabled
=09=09=09RX HT20 SGI
=09=09=09RX HT40 SGI
=09=09=09TX STBC
=09=09=09RX STBC 1-stream
=09=09=09Max AMSDU length: 7935 bytes
=09=09=09DSSS/CCK HT40
=09=09Maximum RX AMPDU length 65535 bytes (exponent: 0x003)
=09=09Minimum RX AMPDU time spacing: 8 usec (0x06)
=09=09HT TX/RX MCS rate indexes supported: 0-31
=09HT operation:
=09=09 * primary channel: 1
=09=09 * secondary channel offset: no secondary
=09=09 * STA channel width: 20 MHz
=09=09 * RIFS: 0
=09=09 * HT protection: nonmember
=09=09 * non-GF present: 0
=09=09 * OBSS non-GF present: 1
=09=09 * dual beacon: 0
=09=09 * dual CTS protection: 0
=09=09 * STBC beacon: 0
=09=09 * L-SIG TXOP Prot: 0
=09=09 * PCO active: 0
=09=09 * PCO phase: 0
=09Extended capabilities:
=09=09 * Extended Channel Switching
=09=09 * SSID List
=09=09 * UTF-8 SSID
=09=09 * Operating Mode Notification
=09Unknown IE (244): 20
=09WMM:=09 * Parameter version 1
=09=09 * u-APSD
=09=09 * BE: CW 15-1023, AIFSN 3
=09=09 * BK: CW 15-1023, AIFSN 7
=09=09 * VI: CW 7-15, AIFSN 2, TXOP 3008 usec
=09=09 * VO: CW 3-7, AIFSN 2, TXOP 1504 usec

Michael Yartys
