Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8442E3C3731
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jul 2021 00:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhGJW7u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 10 Jul 2021 18:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhGJW7t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 10 Jul 2021 18:59:49 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E39C0613DD
        for <linux-wireless@vger.kernel.org>; Sat, 10 Jul 2021 15:57:04 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso8226532pjp.2
        for <linux-wireless@vger.kernel.org>; Sat, 10 Jul 2021 15:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=FilhCVQvgHE0KOjLg420S3mEOgIe2PFbm06pSVj43Tg=;
        b=N7bpoxnwPDjVij04vcPK/F/FQEs46Tj1SLSdGC6zLb5gcbrSWpcz/yIARM6skxs2sK
         ORgrr0y4DTT+rK+WlwQuiGVzs1E8Ex537bTUCS63PvP21dawJDgFjXlcY3LyHhJvWkDb
         qwuN1XjXOW5v5luejzHqoVdcOCLk3yy8e77QI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=FilhCVQvgHE0KOjLg420S3mEOgIe2PFbm06pSVj43Tg=;
        b=THVVltZBcdIIfM83G/Db/DdB6lowdoKufih17qAkVJ4QTOot+hB6NnXOgTy4hAVrDX
         VFKuPfbgYUitYhK1/x4fjY6Nqjl5JXT/M/AbPcJNWLi+JIbxIbQ/7xnuZgYjo0sa8jZC
         YQcPnJ76XDwKBQ0prTqiLhh7srf4n8MljdBCImbHy9WcfVoAZhIsXqmgYNTLDpk1/6Q4
         X9l7GX0IVl7M95FTjW0YXtKQYEbC8+JV7n7WM3jJGmYGDpOnwAH88JXo5E/FSVXsdjeH
         4jqUUHZdNOZQClG/NKx0YelbxdrOyAufqQc5MZa4O4ytX5pCZnpAtRc7GtIfBk5tpnfK
         8Rvg==
X-Gm-Message-State: AOAM530P9y9SSmu1jTobDykMdlnw1ILnsF3V0sUuRiHJEw51OhvdajIx
        KqOd+MQnmkEPiNXWVZDezQpGImr9mhKzFENL
X-Google-Smtp-Source: ABdhPJxzx1XaP1TqiOGAn4FX88+kj9ms1vxGqvU0zV2wRrRFveL1MPbGLrBk7SoD21X2Oj/L3Iqy8g==
X-Received: by 2002:a17:90a:f0d4:: with SMTP id fa20mr6444939pjb.22.1625957823554;
        Sat, 10 Jul 2021 15:57:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w2sm5932pjf.2.2021.07.10.15.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 15:57:03 -0700 (PDT)
Date:   Sat, 10 Jul 2021 15:57:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     linux-wireless@vger.kernel.org
Cc:     Jes.Sorensen@gmail.com
Subject: Realtek USB WiFi dongle (0x2357:0x0108)
Message-ID: <202107101443.163EE06D4@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi!

Two things, first, here's some details on a dongle I just got:

Bus 001 Device 005: ID 2357:0108 TP-Link TL-WN822N Version 4 RTL8192EU
(Physical device says version 5.20, though)

usb 1-3: new high-speed USB device number 5 using xhci_hcd
usb 1-3: New USB device found, idVendor=3D2357, idProduct=3D0108, bcdDevice=
=3D 2.00
usb 1-3: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D3
usb 1-3: Product: 802.11n NIC=20
usb 1-3: Manufacturer: Realtek=20
usb 1-3: SerialNumber: 00e04c000001
usb 1-3: This Realtek USB WiFi dongle (0x2357:0x0108) is untested!
usb 1-3: Please report results to Jes.Sorensen@gmail.com
usb 1-3: Vendor: Realtek
usb 1-3: Product: =03802.11n NI
usb 1-3: Serial:=20
usb 1-3: rtl8192eu_parse_efuse: dumping efuse (0x200 bytes):
usb 1-3: 00: 29 81 00 7c 01 40 03 00
usb 1-3: 08: 40 74 04 50 14 00 00 00
usb 1-3: 10: 2c 2c 2c 2d 2d 2d 2c 2d
usb 1-3: 18: 2d 2d 2d f2 ef ef ff ff
usb 1-3: 20: ff ff ff ff ff ff ff ff
usb 1-3: 28: ff ff ff ff ff ff ff ff
usb 1-3: 30: ff ff ff ff ff ff ff ff
usb 1-3: 38: ff ff 27 27 27 27 27 27
usb 1-3: 40: 28 27 27 27 27 f2 ef ef
usb 1-3: 48: ff ff ff ff ff ff ff ff
usb 1-3: 50: ff ff ff ff ff ff ff ff
usb 1-3: 58: ff ff ff ff ff ff ff ff
usb 1-3: 60: ff ff ff ff ff ff ff ff
usb 1-3: 68: ff ff ff ff ff ff ff ff
usb 1-3: 70: ff ff ff ff ff ff ff ff
usb 1-3: 78: ff ff ff ff ff ff ff ff
usb 1-3: 80: ff ff ff ff ff ff ff ff
usb 1-3: 88: ff ff ff ff ff ff ff ff
usb 1-3: 90: ff ff ff ff ff ff ff ff
usb 1-3: 98: ff ff ff ff ff ff ff ff
usb 1-3: a0: ff ff ff ff ff ff ff ff
usb 1-3: a8: ff ff ff ff ff ff ff ff
usb 1-3: b0: ff ff ff ff ff ff ff ff
usb 1-3: b8: a1 2f 23 00 00 00 ff ff
usb 1-3: c0: ff 01 00 10 00 00 00 ff
usb 1-3: c8: 00 00 ff ff ff ff ff ff
usb 1-3: d0: 57 23 08 01 e7 47 02 d0
usb 1-3: d8: 37 45 ed 71 51 0a 03 52
usb 1-3: e0: 65 61 6c 74 65 6b 20 0e
usb 1-3: e8: 03 38 30 32 2e 31 31 6e
usb 1-3: f0: 20 4e 49 43 20 00 00 ff
usb 1-3: f8: ff ff ff ff ff ff ff ff
usb 1-3: 100: ff ff ff ff ff ff ff ff
usb 1-3: 108: ff ff ff ff ff ff ff ff
usb 1-3: 110: ff ff ff ff ff ff ff 0d
usb 1-3: 118: 03 00 05 00 30 00 00 00
usb 1-3: 120: 00 93 ff ff ff ff ff ff
usb 1-3: 128: ff ff ff ff ff ff ff ff
usb 1-3: 130: f6 a8 98 2d 03 92 98 00
usb 1-3: 138: fc 8c 00 11 9b 44 02 0a
usb 1-3: 140: ff ff ff ff ff ff ff ff
usb 1-3: 148: ff ff ff ff ff ff ff ff
usb 1-3: 150: ff ff ff ff ff ff ff ff
usb 1-3: 158: ff ff ff ff ff ff ff ff
usb 1-3: 160: ff ff ff ff ff ff ff ff
usb 1-3: 168: ff ff ff ff ff ff ff ff
usb 1-3: 170: ff ff ff ff ff ff ff ff
usb 1-3: 178: ff ff ff ff ff ff ff ff
usb 1-3: 180: ff ff ff ff ff ff ff ff
usb 1-3: 188: ff ff ff ff ff ff ff ff
usb 1-3: 190: ff ff ff ff ff ff ff ff
usb 1-3: 198: ff ff ff ff ff ff ff ff
usb 1-3: 1a0: ff ff ff ff ff ff ff ff
usb 1-3: 1a8: ff ff ff ff ff ff ff ff
usb 1-3: 1b0: ff ff ff ff ff ff ff ff
usb 1-3: 1b8: ff ff ff ff ff ff ff ff
usb 1-3: 1c0: ff ff ff ff ff ff ff ff
usb 1-3: 1c8: ff ff ff ff ff ff ff ff
usb 1-3: 1d0: ff ff ff ff ff ff ff ff
usb 1-3: 1d8: ff ff ff ff ff ff ff ff
usb 1-3: 1e0: ff ff ff ff ff ff ff ff
usb 1-3: 1e8: ff ff ff ff ff ff ff ff
usb 1-3: 1f0: ff ff ff ff ff ff ff ff
usb 1-3: 1f8: ff ff ff ff ff ff ff ff
usb 1-3: RTL8192EU rev B (SMIC) 2T2R, TX queues 3, WiFi=3D1, BT=3D0, GPS=3D=
0, HI PA=3D0
usb 1-3: RTL8192EU MAC: d0:37:45:ed:71:51
usb 1-3: rtl8xxxu: Loading firmware rtlwifi/rtl8192eu_nic.bin
usb 1-3: Firmware revision 19.0 (signature 0x92e1)
usbcore: registered new interface driver rtl8xxxu
rtl8xxxu 1-3:1.0 wlxd03745ed7151: renamed from wlan0


Wiphy phy2
	wiphy index: 2
	max # scan SSIDs: 4
	max scan IEs length: 2257 bytes
	max # sched scan SSIDs: 0
	max # match sets: 0
	RTS threshold: 2347
	Retry short limit: 7
	Retry long limit: 4
	Coverage class: 0 (up to 0m)
	Supported Ciphers:
		* WEP40 (00-0f-ac:1)
		* WEP104 (00-0f-ac:5)
		* TKIP (00-0f-ac:2)
		* CCMP-128 (00-0f-ac:4)
		* CCMP-256 (00-0f-ac:10)
		* GCMP-128 (00-0f-ac:8)
		* GCMP-256 (00-0f-ac:9)
	Available Antennas: TX 0 RX 0
	Supported interface modes:
		 * managed
		 * monitor
	Band 1:
		Capabilities: 0x6c
			HT20
			SM Power Save disabled
			RX HT20 SGI
			RX HT40 SGI
			No RX STBC
			Max AMSDU length: 3839 bytes
			No DSSS/CCK HT40
		Maximum RX AMPDU length 65535 bytes (exponent: 0x003)
		Minimum RX AMPDU time spacing: 16 usec (0x07)
		HT TX/RX MCS rate indexes supported: 0-15, 32
		Bitrates (non-HT):
			* 1.0 Mbps
			* 2.0 Mbps
			* 5.5 Mbps
			* 11.0 Mbps
			* 6.0 Mbps
			* 9.0 Mbps
			* 12.0 Mbps
			* 18.0 Mbps
			* 24.0 Mbps
			* 36.0 Mbps
			* 48.0 Mbps
			* 54.0 Mbps
		Frequencies:
			* 2412 MHz [1] (20.0 dBm)
			* 2417 MHz [2] (20.0 dBm)
			* 2422 MHz [3] (20.0 dBm)
			* 2427 MHz [4] (20.0 dBm)
			* 2432 MHz [5] (20.0 dBm)
			* 2437 MHz [6] (20.0 dBm)
			* 2442 MHz [7] (20.0 dBm)
			* 2447 MHz [8] (20.0 dBm)
			* 2452 MHz [9] (20.0 dBm)
			* 2457 MHz [10] (20.0 dBm)
			* 2462 MHz [11] (20.0 dBm)
			* 2467 MHz [12] (20.0 dBm) (no IR)
			* 2472 MHz [13] (20.0 dBm) (no IR)
			* 2484 MHz [14] (20.0 dBm) (no IR)
	Supported commands:
		 * new_interface
		 * set_interface
		 * new_key
		 * start_ap
		 * new_station
		 * new_mpath
		 * set_mesh_config
		 * set_bss
		 * authenticate
		 * associate
		 * deauthenticate
		 * disassociate
		 * join_ibss
		 * join_mesh
		 * remain_on_channel
		 * set_tx_bitrate_mask
		 * frame
		 * frame_wait_cancel
		 * set_wiphy_netns
		 * set_channel
		 * probe_client
		 * set_noack_map
		 * register_beacons
		 * start_p2p_device
		 * set_mcast_rate
		 * connect
		 * disconnect
		 * set_qos_map
		 * set_multicast_to_unicast
	software interface modes (can always be added):
		 * monitor
	interface combinations are not supported
	HT Capability overrides:
		 * MCS: ff ff ff ff ff ff ff ff ff ff
		 * maximum A-MSDU length
		 * supported channel width
		 * short GI for 40 MHz
		 * max A-MPDU length exponent
		 * min MPDU start spacing
	Device supports TX status socket option.
	Device supports HT-IBSS.
	Device supports SAE with AUTHENTICATE command
	Device supports low priority scan.
	Device supports scan flush.
	Device supports AP scan.
	Device supports per-vif TX power setting
	Driver supports full state transitions for AP/GO clients
	Driver supports a userspace MPM
	Device supports configuring vdev MAC-addr on create.
	max # scan plans: 1
	max scan plan interval: -1
	max scan plan iterations: 0
	Supported TX frame types:
		 * IBSS: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0 0xc0=
 0xd0 0xe0 0xf0
		 * managed: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0 0=
xc0 0xd0 0xe0 0xf0
		 * AP: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0 0xc0 0=
xd0 0xe0 0xf0
		 * AP/VLAN: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0 0=
xc0 0xd0 0xe0 0xf0
		 * mesh point: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb=
0 0xc0 0xd0 0xe0 0xf0
		 * P2P-client: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb=
0 0xc0 0xd0 0xe0 0xf0
		 * P2P-GO: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0 0x=
c0 0xd0 0xe0 0xf0
		 * P2P-device: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb=
0 0xc0 0xd0 0xe0 0xf0
	Supported RX frame types:
		 * IBSS: 0x40 0xb0 0xc0 0xd0
		 * managed: 0x40 0xb0 0xd0
		 * AP: 0x00 0x20 0x40 0xa0 0xb0 0xc0 0xd0
		 * AP/VLAN: 0x00 0x20 0x40 0xa0 0xb0 0xc0 0xd0
		 * mesh point: 0xb0 0xc0 0xd0
		 * P2P-client: 0x40 0xd0
		 * P2P-GO: 0x00 0x20 0x40 0xa0 0xb0 0xc0 0xd0
		 * P2P-device: 0x40 0xd0
	Supported extended features:
		* [ RRM ]: RRM
		* [ FILS_STA ]: STA FILS (Fast Initial Link Setup)
		* [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
		* [ CONTROL_PORT_OVER_NL80211 ]: control port over nl80211
		* [ SCAN_RANDOM_SN ]: use random sequence numbers in scans
		* [ SCAN_MIN_PREQ_CONTENT ]: use probe request with only rate IEs in scans
		* [ CONTROL_PORT_NO_PREAUTH ]: disable pre-auth over nl80211 control port=
 support
		* [ SCAN_FREQ_KHZ ]: scan on kHz frequency support
		* [ CONTROL_PORT_OVER_NL80211_TX_STATUS ]: tx status for nl80211 control =
port support


This model appears to have been discussed before in 2017:
https://lore.kernel.org/linux-wireless/1195e649-c57f-1247-a0dc-2f0cc0732a00=
@gmail.com/
and I'm seeing the same issues: it does appear to work, though it seems
to not correctly do "g" or "n" speeds. It also shows very low antenna
gain compared to a built-in adapter.

I also note that this was added as a "known device" in commit
c14239f23adb80aa2532909e312986317ba3cd09, but that commit didn't add a
"tested" exception for it (which, given its poor performance seems
fine).

The out-of-tree driver appears to still be getting updates?
https://github.com/Mange/rtl8192eu-linux-driver/commits/realtek-4.4.x

Any pointers on what I can do to help improve support for this device?
(Or for the 8812AU, which seems to be what's used for nearly all of the
other top-selling USB wifi adapters.)

And on a related note, do you have any idea what would be needed to get
AP mode working for these drivers? It seems there's a firmware for it
(8192eu_ap_wowlan).

Thanks!

-Kees

--=20
Kees Cook
