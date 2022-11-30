Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF5163E0F6
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Nov 2022 20:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiK3Tpm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Nov 2022 14:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiK3TpR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Nov 2022 14:45:17 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A7C5435F
        for <linux-wireless@vger.kernel.org>; Wed, 30 Nov 2022 11:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1669837497; bh=UolP805TsZal30IfEk6pM8QbSESNp5QPSEzVhtGvqrY=;
        h=X-UI-Sender-Class:Subject:From:To:Date;
        b=KPlunXABZKf1+GUwk09/B3K2XHPIkWpLwrEe7B8atDSuaDpWHxBJ1gVyzjP8lwzUw
         xvr6znvU9kycOqMyoX6jf5xR8VwfkP7+reoSyYlhCxVlBBETpXAB+SjpstbVl0PGGh
         EzQbOJ6lVOB7b81FuTKYwcAgMxaXkE03dqrMiCcH+HlFdZlBl8U41XgmWevvxzoRV2
         JmLxElquOM3yMc6v1TtYE2g9jK1pNwQPwRnb+m600Md9nRIHCjmvIC3G9nwkfXi7zp
         Tw6MTBqMhWkbePekzmfwJ14iSQLEHzgDTXE8QB/0+DEezCjoIDhPE68bCJKYz1ENJ9
         cm0en6NThhrKw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.157] ([31.220.67.9]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N9dsV-1ouZpc1OVR-015Z0Z for
 <linux-wireless@vger.kernel.org>; Wed, 30 Nov 2022 20:44:57 +0100
Message-ID: <1235df2ba1757a5917dc21455fa8c1d0a48bb2c4.camel@gmx.de>
Subject: Bug report: Can connect with 'wext', but not 'nl80211'
From:   "Matthias G." <maps4711@gmx.de>
To:     linux-wireless@vger.kernel.org
Date:   Wed, 30 Nov 2022 20:44:57 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1 
MIME-Version: 1.0
X-Provags-ID: V03:K1:A8MN+3Igrpwcn/qdavfQwvkhWcJ4NXHbJ/SkM3flFK/gmgynUrf
 cuAS/fxxw8hzFBwRiZisKfNIIrwZJ9BhMabhvTwokIEKv2XYP0t6pGyNmFQTpLcHSa/l116
 IeUYgwWmQMxTK7uM/mJM0xuVwjHGKgGpgmQqMCHJkjSfYBPiscd6isIC3RvHWB7j/YLFslY
 1UKnE4GXEfq+SVtqD35gw==
UI-OutboundReport: notjunk:1;M01:P0:HqYVNWyMpLQ=;KyQYtCqc1nC9ItV7MhuvY/38alU
 Lx3NiD81GBagglzKfg/sd3A3lEkG5Oz1VDGXgHKVf0rzsQ1UQdJtlZ0VbV/mYc31bq+Uf8UCs
 RZeL1t7CCOgkMFhKR65XdrwrBXF7rSjV2+jA0+O9kiPgS9G/YNWP1kcw23+Duy0lQX8a53cfd
 Lx/wl1g3ldo1MKCi63eoOshp2HS0sgk/cMqjG59Ilm7ViF34+fXdZDKg0uMHREQHi+/vC0tQC
 mcxbXY+kr5taMJaPdAh/UJx+C7I2gHEv5egfdbUXaakWQcgtYT7VjOcF2t0k9QGxkey0K6kRn
 wdlbDY2H1bYoeN4FXXbdH2I8Sk/MApL4D8+eoBwNtgdgXkemmzi0OJoXa0aWVqDcmJrBWxRZZ
 E3ecy4tTWgCTsApUtgoPycTY3N/9E+U+SPX9Ex+fFEJWIxsvMYyUBGeD70Pd/7mvsrzQslqZK
 2fJ3UlrHUYteayy1hwhY1ln7gkQ3eciXRMNpuK5MEd8HW9x61cZtwxuGzeY/G3k6foIvQef/y
 Bkcz4S0gPMPvQ/r1m1AjB33HD96q/61SWiqKfe1F271M2cMlgfyetQviCJdNPamxPp1jhzg/Z
 VyqxP495avtHPxi2eSxn/Ly9zQ7u1gkEQ/dhc8hJYm7jYtWVV3n6QF9Jtf5XftmhoIAKO191E
 qmKjuIDpfX3PY9XzXDYIskOqToj/6LC+Mg7lTb0uEpmoOO7tnGt9LDKzGqy5kJjgQaZJ0VsM6
 KPFe1of3xZGZNwdzEeXTNrTyvgM7uwtELP6nyc0RDkn0Ap2PaxcEm7j/JIf3jb6p612k6DJ6v
 vsZ9l7HVdeQE4/6WV6hL2XVcP2oXvppz/M/SnFGLyxKxDvcAcFZeacfWt2wwVWfswoaJP79Ak
 4FkZZohL28FUdsBymzt7VUBRBK7JqFGLYEt6nGSU2uxYnxNOSib4ferCxEBu5YbRNVeT4gdGX
 xZoWHasPvPm7CD6el4T0pBQMcWc=
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I hope this is the right place to report. I can connect via WiFi to my LTE =
router with the legacy 'wext' driver but not with 'nl80211'.

The router is a rebranded version of this one:
https://forum.openwrt.org/t/alcatel-tlc-hh40-lte-router-based-on-openwrt/77=
580

This command fails:
# wpa_supplicant -c wpa-home-lte.conf -i wlan0

wlan0: SME: Trying to authenticate with dc:9b:d6:de:d4:27 (SSID=3D'<redacte=
d>' freq=3D2452 MHz)
wlan0: Trying to associate with dc:9b:d6:de:d4:27 (SSID=3D'<redacted>' freq=
=3D2452 MHz)
wlan0: SME: Trying to authenticate with dc:9b:d6:de:d4:27 (SSID=3D'<redacte=
d>' freq=3D2452 MHz)
wlan0: Trying to associate with dc:9b:d6:de:d4:27 (SSID=3D'<redacted>' freq=
=3D2452 MHz)
wlan0: SME: Trying to authenticate with dc:9b:d6:de:d4:27 (SSID=3D'<redacte=
d>' freq=3D2452 MHz)
wlan0: Trying to associate with dc:9b:d6:de:d4:27 (SSID=3D'<redacted>' freq=
=3D2452 MHz)
wlan0: SME: Trying to authenticate with dc:9b:d6:de:d4:27 (SSID=3D'<redacte=
d>' freq=3D2452 MHz)
wlan0: Trying to associate with dc:9b:d6:de:d4:27 (SSID=3D'<redacted>' freq=
=3D2452 MHz)
wlan0: CTRL-EVENT-SSID-TEMP-DISABLED id=3D0 ssid=3D"<redacted>" auth_failur=
es=3D1 duration=3D10 reason=3DCONN_FAILED

while this succeeds:
# wpa_supplicant -Dwext -c wpa-home-lte.conf -i wlan0

Successfully initialized wpa_supplicant
ioctl[SIOCSIWENCODEEXT]: Invalid argument
ioctl[SIOCSIWENCODEEXT]: Invalid argument
wlan0: Trying to associate with dc:9b:d6:de:d4:27 (SSID=3D'<redacted>' freq=
=3D2452 MHz)
wlan0: Associated with dc:9b:d6:de:d4:27
wlan0: WPA: Key negotiation completed with dc:9b:d6:de:d4:27 [PTK=3DCCMP GT=
K=3DCCMP]
wlan0: CTRL-EVENT-CONNECTED - Connection to dc:9b:d6:de:d4:27 completed [id=
=3D0 id_str=3D]

Kernel logs, failure:
Nov 30 20:24:41 papaya kernel: wlan0: authenticate with dc:9b:d6:de:d4:27
Nov 30 20:24:41 papaya kernel: wlan0: bad VHT capabilities, disabling VHT
Nov 30 20:24:41 papaya kernel: wlan0: Invalid HE elem, Disable HE
Nov 30 20:24:41 papaya kernel: wlan0: 80 MHz not supported, disabling VHT
Nov 30 20:24:42 papaya kernel: wlan0: send auth to dc:9b:d6:de:d4:27 (try 1=
/3)
Nov 30 20:24:42 papaya kernel: wlan0: authenticated
Nov 30 20:24:42 papaya kernel: wlan0: associate with dc:9b:d6:de:d4:27 (try=
 1/3)
Nov 30 20:24:42 papaya kernel: wlan0: associate with dc:9b:d6:de:d4:27 (try=
 2/3)
Nov 30 20:24:42 papaya kernel: wlan0: associate with dc:9b:d6:de:d4:27 (try=
 3/3)
Nov 30 20:24:42 papaya kernel: wlan0: association with dc:9b:d6:de:d4:27 ti=
med out
Nov 30 20:24:45 papaya kernel: wlan0: authenticate with dc:9b:d6:de:d4:27
Nov 30 20:24:45 papaya kernel: wlan0: bad VHT capabilities, disabling VHT
Nov 30 20:24:45 papaya kernel: wlan0: Invalid HE elem, Disable HE
Nov 30 20:24:45 papaya kernel: wlan0: 80 MHz not supported, disabling VHT
Nov 30 20:24:45 papaya kernel: wlan0: send auth to dc:9b:d6:de:d4:27 (try 1=
/3)
Nov 30 20:24:45 papaya kernel: wlan0: authenticated
Nov 30 20:24:45 papaya kernel: wlan0: associate with dc:9b:d6:de:d4:27 (try=
 1/3)
Nov 30 20:24:45 papaya kernel: wlan0: associate with dc:9b:d6:de:d4:27 (try=
 2/3)
Nov 30 20:24:46 papaya kernel: wlan0: associate with dc:9b:d6:de:d4:27 (try=
 3/3)
Nov 30 20:24:46 papaya kernel: wlan0: association with dc:9b:d6:de:d4:27 ti=
med out

Kernel logs, success:
Nov 30 20:30:45 papaya kernel: wlan0: authenticate with dc:9b:d6:de:d4:27
Nov 30 20:30:45 papaya kernel: wlan0: bad VHT capabilities, disabling VHT
Nov 30 20:30:45 papaya kernel: wlan0: Invalid HE elem, Disable HE
Nov 30 20:30:45 papaya kernel: wlan0: 80 MHz not supported, disabling VHT
Nov 30 20:30:45 papaya kernel: wlan0: send auth to dc:9b:d6:de:d4:27 (try 1=
/3)
Nov 30 20:30:45 papaya kernel: wlan0: authenticated
Nov 30 20:30:45 papaya kernel: wlan0: associate with dc:9b:d6:de:d4:27 (try=
 1/3)
Nov 30 20:30:45 papaya kernel: wlan0: RX AssocResp from dc:9b:d6:de:d4:27 (=
capab=3D0x431 status=3D0 aid=3D1)
Nov 30 20:30:45 papaya kernel: wlan0: associated
Nov 30 20:30:45 papaya kernel: IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link b=
ecomes ready

System information:
Artix dist, Linux papaya 6.0.7-artix1-1 #1 SMP PREEMPT_DYNAMIC Thu, 03 Nov =
2022 21:10:08 +0000 x86_64 GNU/Linux

wpa_supplicant v2.10

05:00.0 Network controller: MEDIATEK Corp. MT7921 802.11ax PCI Express Wire=
less Network Adapter

mt7921e                32768  0
mt7921_common          94208  1 mt7921e
mt76_connac_lib        69632  2 mt7921e,mt7921_common
mt76                  102400  3 mt7921e,mt7921_common,mt76_connac_lib
mac80211             1298432  3 mt76,mt7921_common,mt76_connac_lib
libarc4                16384  1 mac80211
cfg80211             1118208  4 mt76,mac80211,mt7921_common,mt76_connac_lib
rfkill                 32768  5 asus_wmi,bluetooth,cfg80211

I can compile a custom linux kernel and wpa_supplicant for e.g. debugging p=
urposes. Let me know if you need more information. I didn't
subscribe to this mailing list, so please answer directly.

Regards,
Matthias

