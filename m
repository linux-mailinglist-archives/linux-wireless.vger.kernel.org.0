Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53FE915DFE2
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2020 17:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391698AbgBNQLE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Feb 2020 11:11:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:37438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391690AbgBNQLD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Feb 2020 11:11:03 -0500
Received: from earth.universe (dyndsl-095-033-170-229.ewe-ip-backbone.de [95.33.170.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A93FE246A1;
        Fri, 14 Feb 2020 16:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696662;
        bh=Z0RQIT47Oe1+OSu0um7557Rvca4BG/YTsPe1P4/UmIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F77mArz+MG4YvoKg8NYLJeKahuAhnvEMcSBLE0j7eulaQLQ/AfZpi7n/tIh+1Wf4Q
         ym98iczwjUFGOVHYvAzfcMGuiEO0XY9PsRJOteLlbxuwJHFmsJmUsPymWvIlSLwndc
         Xe6w64DTYrQWrG0BJiMa1PlFwq2aq3Djzr29kQ0A=
Received: by earth.universe (Postfix, from userid 1000)
        id DCB9E3C0C83; Fri, 14 Feb 2020 17:11:00 +0100 (CET)
Date:   Fri, 14 Feb 2020 17:11:00 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     "Arthur D." <spinal.by@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: Droid 4 WiFi firmware loading error
Message-ID: <20200214161100.b7aqb6wwsrxmx4ab@earth.universe>
References: <op.0fuie5cdhxa7s4@supervisor.net28>
 <20200211232425.GE16391@atomide.com>
 <op.0fu85owhhxa7s4@supervisor.net28>
 <20200212150722.GF16391@atomide.com>
 <20200212162131.GI16391@atomide.com>
 <op.0fwkyxvihxa7s4@supervisor.net28>
 <20200213041112.GL16391@atomide.com>
 <op.0fw0oas5hxa7s4@supervisor.net28>
 <20200213161157.GN16391@atomide.com>
 <op.0fx4hozhhxa7s4@supervisor.net28>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wegjx6zz3o3fg5bj"
Content-Disposition: inline
In-Reply-To: <op.0fx4hozhhxa7s4@supervisor.net28>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--wegjx6zz3o3fg5bj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

WTF :(

Right now the BT driver and the WiFi driver are no aware of
each other. Actually the kernel is not even aware, that both
drivers are using the same chip. Unfortunately this will be
tricky to solve properly. Since a system may have two WiLink
devices, the only solution coming to my mind would be adding
a link from the BT device to the WiFi device in device tree.
Additionally we would need something in the WiLink driver to
check if driver has been initialized properly for a given DT
node.

-- Sebastian

On Fri, Feb 14, 2020 at 12:54:50AM +0300, Arthur D. wrote:
> Hello.
>=20
> Some users have reported that they have issues with WiFi firmware
> loading on Droid 4. The fragment of dmesg for the issue follows
> at the bottom of this mail.
>=20
> With the help of Tony Lindgren I have found that the root of the
> issue was Bluetooth firmware loaded before WiFi driver (wlcore).
>=20
> Now we need to change the kernel to make it load Bluetooth firmware
> only after WiFi firmware is loaded. So the bug will not be triggered.
>=20
> Any ideas on how it should be done?
>=20
> P.S. When I do "rmmod hci_uart" on Droid 4 device, I get something
> like endless loop of error reporting from kernel. The fragment of
> dmesg can be downloaded from https://dropmefiles.com/wCPMF
> I'm not sure where to report this one.
>=20
> --
> Best regards, Arthur D.
>=20
>=20
> [   15.951904] ------------[ cut here ]------------
> [   16.028137] WARNING: CPU: 1 PID: 23 at
> drivers/net/wireless/ti/wlcore/sdio.c:78 wl12xx_sdio_raw_read+0xcc/0x15c
> [wlcore_sdio]
> [   16.211669] Modules linked in: omapdrm drm_kms_helper cfbfillrect
> syscopyarea cfbimgblt sysfillrect sysimgblt fb_sys_fops cfbcopyarea
> snd_soc_omap_hdmi wl12xx wlcore mac80211 panel_dsi_cm libarc4
> sha256_generic libsha256 sha256_arm cfg80211 joydev mousedev evdev
> pwm_vibra snd_soc_audio_graph_card ff_memless phy_generic
> snd_soc_simple_card_utils phy_mapphone_mdm6600(+) led_bl cpufreq_dt
> gpio_keys pwm_omap_dmtimer connector_hdmi omapdss omapdss_base
> omap4_keypad drm matrix_keymap drm_panel_orientation_quirks cec
> omap_mailbox omap_sham omap_aes_driver omap2430 ohci_platform ohci_hcd
> ehci_omap ehci_hcd st_accel_spi st_sensors_spi st_accel_i2c st_sensors_i2c
> st_accel st_sensors industrialio_triggered_buffer kfifo_buf omap_des
> libdes crypto_engine omap_crypto wlcore_sdio omap_hdq wire cn
> phy_cpcap_usb musb_hdrc cpcap_adc udc_core cpcap_battery usbcore
> usb_common rtc_cpcap cpcap_pwrbutton cpcap_charger phy_omap_usb2
> industrialio snd_soc_cpcap leds_cpcap atmel_mxt_ts hci_uart btbcm lm75
> [   16.211669]  leds_lm3532
> [   16.226989] systemd-journald[105]: Compressed data object 989 -> 808
> using LZ4
> [   17.050018]  hwmon led_class bluetooth ecdh_generic ecc libaes
> motorola_mdm n_gsm snd_soc_omap_mcbsp snd_soc_ti_sdma snd_soc_core
> snd_pcm_dmaengine snd_pcm snd_timer omap_wdt watchdog snd soundcore autof=
s4
> [   17.144073] phy-mapphone-mdm6600 usb-phy@1: Waiting for power up
> request to complete..
> [   17.255035] CPU: 1 PID: 23 Comm: kworker/1:1 Tainted: G
> W         5.5.0-00039-gadd2f906e747-dirty #23
> [   17.657806] Hardware name: Generic OMAP4 (Flattened Device Tree)
> [   17.657867] Workqueue: events request_firmware_work_func
> [   17.861297] [<c0112b88>] (unwind_backtrace) from [<c010cafc>]
> (show_stack+0x10/0x14)
> [   17.861297] [<c010cafc>] (show_stack) from [<c090753c>]
> (dump_stack+0xb4/0xd0)
> [   17.861450] [<c090753c>] (dump_stack) from [<c013aaf0>]
> (__warn+0xd0/0xf8)
> [   17.861450] [<c013aaf0>] (__warn) from [<c013abbc>]
> (warn_slowpath_fmt+0xa4/0xb4)
> [   17.861450] [<c013abbc>] (warn_slowpath_fmt) from [<bf1bf418>]
> (wl12xx_sdio_raw_read+0xcc/0x15c [wlcore_sdio])
> [   17.861633] [<bf1bf418>] (wl12xx_sdio_raw_read [wlcore_sdio]) from
> [<bf525074>] (wl12xx_get_mac+0x150/0x324 [wl12xx])
> [   17.861938] [<bf525074>] (wl12xx_get_mac [wl12xx]) from [<bf410380>]
> (wlcore_nvs_cb+0x250/0xad8 [wlcore])
> [   17.862121] [<bf410380>] (wlcore_nvs_cb [wlcore]) from [<eccfdb00>]
> (0xeccfdb00)
> [   17.868988] ---[ end trace b49285f1f3a91e50 ]---
> [   17.868988] wl1271_sdio mmc4:0001:2: sdio read failed (-110)
> [   17.869079] wlcore: ERROR couldn't get hw info

--wegjx6zz3o3fg5bj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl5GxooACgkQ2O7X88g7
+ppwMA//ds7uYyW+ktb09rAIIDTMbRmN1uBweJtm+BydWP6uAYTL5NAbrI4ucrcq
f7W1/DBGzAQYy7Vb8kY2WLQ2WKMzOEs9z4QdFsF0N2ylAoOW2LlHR/WGG0Vnm4XH
0T34OiO2VKw92nXlDt8klVgbY8sdvb6KoXWSwLxB5QZuzSfUoB+v/sJWKNTc6XGN
0lIbNQOU0ypQ2pGgT5nLtGay9VczIgDr9WtN2VWYBG7mJtC+oCxlf/ysPMYRJ9kc
r9kVPQxFf3wW2ZZaOz0Ks46woz7uWCNm95XAEzn2qqTtJG7qasl40dX8ZrbmUOGB
ydgRKjnNf2JmudzJSXr6Ltg92wvAqhV7fCRXSyiXE69VHhwogcQ6MYY2BQNTPZyQ
kfCxDlgbVkZIrLjRmUs+33NXJFAlVXVvycn1roi2k7MFxliElQekKXozYgDx0Atq
H/ejcnznRebf58+sugwbigts336GJ6NooKoEBh767Le1KuXmmmzTLDTxFf3X5Agt
1MawhLj1BrXPUskk93wA5IklQY+FdpQnyeqDL4hioCGWqX9C+AohAwDPtmQ2Zq/S
EfCrPbgD3mYPUWy/4nbjgaJAVz/m8WjZcPM2Kxag+XV4TKMpVUDxonekLbWWwrqM
CWgH7XvRs9bOYfeSdLd6QlDET+SGQ+VUkSXQy6OEj9FQYVApkqU=
=Ctqq
-----END PGP SIGNATURE-----

--wegjx6zz3o3fg5bj--
