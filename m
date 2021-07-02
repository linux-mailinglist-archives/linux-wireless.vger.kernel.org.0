Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0923B9D51
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jul 2021 10:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhGBIIg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jul 2021 04:08:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230146AbhGBIIg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jul 2021 04:08:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D15B461411;
        Fri,  2 Jul 2021 08:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625213164;
        bh=pnbHfKgOBHDYd6+qjZd54kEdPxa9RR/SMfKhOPhbme0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q1nhC+4syrC6ZCnkUObse/iyTI5bk1F9oCGYg7OA6HuG/FPmcQnMqkg36GssA49eG
         CKT0qGCAsO1BSb2uZhUOWamZ2wl9PLM0GdXuloDvKA75Iquo2/ydk+FPFVig7uBFBn
         TQXCbFsCmFBfJibb9ROuIMl40UTzfIFuD6eA6Xnj5zq+2bomSY+RixKo3zpXG3ohxk
         tQoQIC7kJu6UdVwQ8Lg4N0OmD+O3x8dKcun6fuBCLc09o42lXXqvuSt+caG4mqN34b
         8IzdsHG1RPTwvhlxdzsV5RS+xoN3Npt3j3LEFNM8VV/xvxi7KNDa9a4q3QzjCZRql7
         HmVBiQOxr7ihQ==
Date:   Fri, 2 Jul 2021 10:05:59 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Christopher Chew <cc@soldelgroup.com>
Cc:     nbd@nbd.name, lorenzo.bianconi83@gmail.com,
        linux-wireless@vger.kernel.org
Subject: Re: Netgear A6210 with mt76x2u driver issues?
Message-ID: <YN7I57URPn0YVaEA@lore-desk>
References: <CANw61vGmvnMCrKaWCXO4b=m41YnoacomqpjcRTa2s60Q6w-c9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7TfSY8VbDe7/c7Wc"
Content-Disposition: inline
In-Reply-To: <CANw61vGmvnMCrKaWCXO4b=m41YnoacomqpjcRTa2s60Q6w-c9Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--7TfSY8VbDe7/c7Wc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi,
>=20
> Sorry for sending this twice but I got an email rejection notice as
> the original email had snippets of html. I am resending this as pure
> plain text. Original email continues below.
>=20
> I apologize for cold emailing you but I have been encountering some
> issues running a Netgear A6210 USB WiFi dongle with Ubuntu 18.04.05
> with kernel v5.4.
>=20
> Recently, due to network issues, I tried to use this USB adapter to
> attempt to be both client to a WiFi and also act as an access point to
> a bunch of devices.

Hi Christopher,

Can you please confirm both ap and client are running on the same channel?
Can you please try an updated kernel? (5.4 is quite old)

Regards,
Lorenzo

>=20
> Running lsusb -t shows the following.
> /:  Bus 02.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci_hcd/7p, 5000M
>     |__ Port 3: Dev 2, If 0, Class=3DVendor Specific Class, Driver=3Dmt76=
x2u, 5000M
>     |__ Port 4: Dev 3, If 0, Class=3DVideo, Driver=3Duvcvideo, 5000M
>     |__ Port 4: Dev 3, If 3, Class=3DAudio, Driver=3Dsnd-usb-audio, 5000M
>     |__ Port 4: Dev 3, If 1, Class=3DVideo, Driver=3Duvcvideo, 5000M
>     |__ Port 4: Dev 3, If 2, Class=3DAudio, Driver=3Dsnd-usb-audio, 5000M
> /:  Bus 01.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci_hcd/8p, 480M
>     |__ Port 1: Dev 3, If 0, Class=3DHub, Driver=3Dhub/4p, 480M
>         |__ Port 1: Dev 4, If 0, Class=3DHuman Interface Device,
> Driver=3Dusbhid, 12M
>         |__ Port 1: Dev 4, If 1, Class=3DHuman Interface Device,
> Driver=3Dusbhid, 12M
>         |__ Port 3: Dev 5, If 0, Class=3DHuman Interface Device,
> Driver=3Dusbhid, 1.5M
>         |__ Port 3: Dev 5, If 1, Class=3DHuman Interface Device,
> Driver=3Dusbhid, 1.5M
>         |__ Port 4: Dev 6, If 2, Class=3DAudio, Driver=3Dsnd-usb-audio, 1=
2M
>         |__ Port 4: Dev 6, If 0, Class=3DAudio, Driver=3Dsnd-usb-audio, 1=
2M
>         |__ Port 4: Dev 6, If 3, Class=3DHuman Interface Device,
> Driver=3Dusbhid, 12M
>         |__ Port 4: Dev 6, If 1, Class=3DAudio, Driver=3Dsnd-usb-audio, 1=
2M
>     |__ Port 2: Dev 2, If 2, Class=3DAudio, Driver=3Dsnd-usb-audio, 12M
>     |__ Port 2: Dev 2, If 0, Class=3DAudio, Driver=3Dsnd-usb-audio, 12M
>     |__ Port 2: Dev 2, If 3, Class=3DHuman Interface Device, Driver=3Dusb=
hid, 12M
>     |__ Port 2: Dev 2, If 1, Class=3DAudio, Driver=3Dsnd-usb-audio, 12M
>=20
> The iw list of the Netgear A6210 USB adapter shows the following.
>=20
>     Wiphy phy0
>     max # scan SSIDs: 4
>     max scan IEs length: 2243 bytes
>     max # sched scan SSIDs: 0
>     max # match sets: 0
>     max # scan plans: 1
>     max scan plan interval: -1
>     max scan plan iterations: 0
>     Retry short limit: 7
>     Retry long limit: 4
>     Coverage class: 0 (up to 0m)
>     Device supports RSN-IBSS.
>     Supported Ciphers:
>         * WEP40 (00-0f-ac:1)
>         * WEP104 (00-0f-ac:5)
>         * TKIP (00-0f-ac:2)
>         * CCMP-128 (00-0f-ac:4)
>         * CCMP-256 (00-0f-ac:10)
>         * GCMP-128 (00-0f-ac:8)
>         * GCMP-256 (00-0f-ac:9)
>         * CMAC (00-0f-ac:6)
>         * CMAC-256 (00-0f-ac:13)
>         * GMAC-128 (00-0f-ac:11)
>         * GMAC-256 (00-0f-ac:12)
>     Available Antennas: TX 0x3 RX 0x3
>     Configured Antennas: TX 0x3 RX 0x3
>     Supported interface modes:
>          * IBSS
>          * managed
>          * AP
>          * AP/VLAN
>          * monitor
>          * mesh point
>     Band 1:
>         Capabilities: 0x1ff
>             RX LDPC
>             HT20/HT40
>             SM Power Save disabled
>             RX Greenfield
>             RX HT20 SGI
>             RX HT40 SGI
>             TX STBC
>             RX STBC 1-stream
>             Max AMSDU length: 3839 bytes
>             No DSSS/CCK HT40
>         Maximum RX AMPDU length 65535 bytes (exponent: 0x003)
>         Minimum RX AMPDU time spacing: 4 usec (0x05)
>         HT TX/RX MCS rate indexes supported: 0-15
>         Bitrates (non-HT):
>             * 1.0 Mbps (short preamble supported)
>             * 2.0 Mbps (short preamble supported)
>             * 5.5 Mbps (short preamble supported)
>             * 11.0 Mbps (short preamble supported)
>             * 6.0 Mbps
>             * 9.0 Mbps
>             * 12.0 Mbps
>             * 18.0 Mbps
>             * 24.0 Mbps
>             * 36.0 Mbps
>             * 48.0 Mbps
>             * 54.0 Mbps
>         Frequencies:
>             * 2412 MHz [1] (18.0 dBm)
>             * 2417 MHz [2] (18.0 dBm)
>             * 2422 MHz [3] (18.0 dBm)
>             * 2427 MHz [4] (18.0 dBm)
>             * 2432 MHz [5] (18.0 dBm)
>             * 2437 MHz [6] (18.0 dBm)
>             * 2442 MHz [7] (18.0 dBm)
>             * 2447 MHz [8] (18.0 dBm)
>             * 2452 MHz [9] (18.0 dBm)
>             * 2457 MHz [10] (18.0 dBm)
>             * 2462 MHz [11] (18.0 dBm)
>             * 2467 MHz [12] (18.0 dBm) (no IR)
>             * 2472 MHz [13] (18.0 dBm) (no IR)
>             * 2484 MHz [14] (18.0 dBm) (no IR)
>     Band 2:
>         Capabilities: 0x1ff
>             RX LDPC
>             HT20/HT40
>             SM Power Save disabled
>             RX Greenfield
>             RX HT20 SGI
>             RX HT40 SGI
>             TX STBC
>             RX STBC 1-stream
>             Max AMSDU length: 3839 bytes
>             No DSSS/CCK HT40
>         Maximum RX AMPDU length 65535 bytes (exponent: 0x003)
>         Minimum RX AMPDU time spacing: 4 usec (0x05)
>         HT TX/RX MCS rate indexes supported: 0-15
>         VHT Capabilities (0x318001b0):
>             Max MPDU length: 3895
>             Supported Channel Width: neither 160 nor 80+80
>             RX LDPC
>             short GI (80 MHz)
>             TX STBC
>             RX antenna pattern consistency
>             TX antenna pattern consistency
>         VHT RX MCS set:
>             1 streams: MCS 0-9
>             2 streams: MCS 0-9
>             3 streams: not supported
>             4 streams: not supported
>             5 streams: not supported
>             6 streams: not supported
>             7 streams: not supported
>             8 streams: not supported
>         VHT RX highest supported: 0 Mbps
>         VHT TX MCS set:
>             1 streams: MCS 0-9
>             2 streams: MCS 0-9
>             3 streams: not supported
>             4 streams: not supported
>             5 streams: not supported
>             6 streams: not supported
>             7 streams: not supported
>             8 streams: not supported
>         VHT TX highest supported: 0 Mbps
>         Bitrates (non-HT):
>             * 6.0 Mbps
>             * 9.0 Mbps
>             * 12.0 Mbps
>             * 18.0 Mbps
>             * 24.0 Mbps
>             * 36.0 Mbps
>             * 48.0 Mbps
>             * 54.0 Mbps
>         Frequencies:
>             * 5180 MHz [36] (18.0 dBm) (no IR)
>             * 5200 MHz [40] (18.0 dBm) (no IR)
>             * 5220 MHz [44] (18.0 dBm) (no IR)
>             * 5240 MHz [48] (18.0 dBm) (no IR)
>             * 5260 MHz [52] (18.0 dBm) (no IR, radar detection)
>             * 5280 MHz [56] (18.0 dBm) (no IR, radar detection)
>             * 5300 MHz [60] (18.0 dBm) (no IR, radar detection)
>             * 5320 MHz [64] (18.0 dBm) (no IR, radar detection)
>             * 5500 MHz [100] (18.0 dBm) (no IR, radar detection)
>             * 5520 MHz [104] (18.0 dBm) (no IR, radar detection)
>             * 5540 MHz [108] (18.0 dBm) (no IR, radar detection)
>             * 5560 MHz [112] (18.0 dBm) (no IR, radar detection)
>             * 5580 MHz [116] (18.0 dBm) (no IR, radar detection)
>             * 5600 MHz [120] (18.0 dBm) (no IR, radar detection)
>             * 5620 MHz [124] (18.0 dBm) (no IR, radar detection)
>             * 5640 MHz [128] (18.0 dBm) (no IR, radar detection)
>             * 5660 MHz [132] (18.0 dBm) (no IR, radar detection)
>             * 5680 MHz [136] (18.0 dBm) (no IR, radar detection)
>             * 5700 MHz [140] (18.0 dBm) (no IR, radar detection)
>             * 5745 MHz [149] (18.0 dBm) (no IR)
>             * 5765 MHz [153] (18.0 dBm) (no IR)
>             * 5785 MHz [157] (18.0 dBm) (no IR)
>             * 5805 MHz [161] (18.0 dBm) (no IR)
>             * 5825 MHz [165] (18.0 dBm) (no IR)
>     Supported commands:
>          * new_interface
>          * set_interface
>          * new_key
>          * start_ap
>          * new_station
>          * new_mpath
>          * set_mesh_config
>          * set_bss
>          * authenticate
>          * associate
>          * deauthenticate
>          * disassociate
>          * join_ibss
>          * join_mesh
>          * set_tx_bitrate_mask
>          * frame
>          * frame_wait_cancel
>          * set_wiphy_netns
>          * set_channel
>          * set_wds_peer
>          * probe_client
>          * set_noack_map
>          * register_beacons
>          * start_p2p_device
>          * set_mcast_rate
>          * connect
>          * disconnect
>          * set_qos_map
>          * set_multicast_to_unicast
>     Supported TX frame types:
>          * IBSS: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90
> 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
>          * managed: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90
> 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
>          * AP: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0
> 0xb0 0xc0 0xd0 0xe0 0xf0
>          * AP/VLAN: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90
> 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
>          * mesh point: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80
> 0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
>          * P2P-client: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80
> 0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
>          * P2P-GO: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90
> 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
>          * P2P-device: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80
> 0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
>     Supported RX frame types:
>          * IBSS: 0x40 0xb0 0xc0 0xd0
>          * managed: 0x40 0xd0
>          * AP: 0x00 0x20 0x40 0xa0 0xb0 0xc0 0xd0
>          * AP/VLAN: 0x00 0x20 0x40 0xa0 0xb0 0xc0 0xd0
>          * mesh point: 0xb0 0xc0 0xd0
>          * P2P-client: 0x40 0xd0
>          * P2P-GO: 0x00 0x20 0x40 0xa0 0xb0 0xc0 0xd0
>          * P2P-device: 0x40 0xd0
>     software interface modes (can always be added):
>          * AP/VLAN
>          * monitor
>     valid interface combinations:
>          * #{ IBSS } <=3D 1, #{ managed, AP, mesh point } <=3D 2,
>            total <=3D 2, #channels <=3D 1, STA/AP BI must match
>     HT Capability overrides:
>          * MCS: ff ff ff ff ff ff ff ff ff ff
>          * maximum A-MSDU length
>          * supported channel width
>          * short GI for 40 MHz
>          * max A-MPDU length exponent
>          * min MPDU start spacing
>     Device supports TX status socket option.
>     Device supports HT-IBSS.
>     Device supports SAE with AUTHENTICATE command
>     Device supports low priority scan.
>     Device supports scan flush.
>     Device supports AP scan.
>     Device supports per-vif TX power setting
>     Driver supports full state transitions for AP/GO clients
>     Driver supports a userspace MPM
>     Device supports active monitor (which will ACK incoming frames)
>     Device supports configuring vdev MAC-addr on create.
>     Device supports VHT-IBSS.
>=20
> Looking at the lines
> valid interface combinations:
>      * #{ IBSS } <=3D 1, #{ managed, AP, mesh point } <=3D 2,
>        total <=3D 2, #channels <=3D 1, STA/AP BI must match
>=20
> I assumed it should be able to do what I wanted, since I was able to
> do this on my laptop with a builtin Intel WiFi adapter before.
>=20
> Creating the 2 interfaces for the Netgear A6210 was not a problem.
> I simply did this.
> iw phy phy0 interface add sta0 type managed
> iw phy phy0 interface add ap0 type __ap
>=20
> wpa_supplicant.conf is very generic.
>=20
>     # Giving configuration update rights to wpa_cli
>     ctrl_interface=3D/run/wpa_supplicant
>     ctrl_interface_group=3Dwifi
>     update_config=3D1
>=20
>     # AP scanning
>     ap_scan=3D1
>=20
>     # ISO/IEC alpha2 country code in which the device is operating
>     country=3DGB
>=20
>     # network section generated by wpa_passphrase
>     network=3D{
>         ssid=3D"Test"
>         psk=3D"testtest"
>     }
>=20
> So with the above configurations, I then attempt to connect with the 2 co=
mmands.
>=20
>     wpa_supplicant -i sta0 -c ./test.conf
>     create_ap ap0 sta0 internal password
>=20
> Everything looks like it is fine. The connection to the Test WiFi
> network is fine and I can connect to the internet. The create_ap
> command works fine, it shows that the AP is created and enabled.
>=20
> wpa_supplicant output
>=20
>     # wpa_supplicant -i sta0 -c ./example.conf
>     Successfully initialized wpa_supplicant
>     sta0: SME: Trying to authenticate with fc:ec:da:8a:84:de
> (SSID=3D'Test' freq=3D2412 MHz)
>     sta0: Trying to associate with fc:ec:da:8a:84:de (SSID=3D'Test' freq=
=3D2412 MHz)
>     sta0: Associated with fc:ec:da:8a:84:de
>     sta0: CTRL-EVENT-SUBNET-STATUS-UPDATE status=3D0
>     sta0: WPA: Key negotiation completed with fc:ec:da:8a:84:de
> [PTK=3DCCMP GTK=3DCCMP]
>     sta0: CTRL-EVENT-CONNECTED - Connection to fc:ec:da:8a:84:de
> completed [id=3D0 id_str=3D]
>=20
> create_ap output
>=20
>     # create_ap ap0 sta0 internal password Config dir:
> /tmp/create_ap.ap0.conf.EmWaK62U
>     PID: 5027
>     command failed: Operation not supported (-95)
>     Creating a virtual WiFi interface... ap1 created.
>     Sharing Internet using method: nat
>     hostapd command-line interface: hostapd_cli -p
> /tmp/create_ap.ap0.conf.EmWaK62U/hostapd_ctrl
>     Configuration file: /tmp/create_ap.ap0.conf.EmWaK62U/hostapd.conf
>     Using interface ap1 with hwaddr 78:d2:94:4a:e0:4c and ssid "internal"
>     ap1: interface state UNINITIALIZED->ENABLED
>     ap1: AP-ENABLED
>=20
> So I then try to connect my devices onto "internal" and none of my
> devices can connect.
>=20
> If I did the reverse, which is to create_ap first, then connect to the
> wpa_supplicant, the following happens.
>=20
> create_ap
>=20
>     # create_ap ap0 sta0 internal password Config dir:
> /tmp/create_ap.ap0.conf.BWI2H1Dx
>     PID: 8258
>     command failed: Operation not supported (-95)
>     Creating a virtual WiFi interface... ap1 created.
>     Sharing Internet using method: nat
>     hostapd command-line interface: hostapd_cli -p
> /tmp/create_ap.ap0.conf.BWI2H1Dx/hostapd_ctrl
>     Configuration file: /tmp/create_ap.ap0.conf.BWI2H1Dx/hostapd.conf
>     Using interface ap1 with hwaddr 78:d2:94:4a:e0:4c and ssid "internal"
>     ap1: interface state UNINITIALIZED->ENABLED
>     ap1: AP-ENABLED
>     ap1: STA 98:01:a7:48:0f:d8 IEEE 802.11: authenticated
>     ap1: STA 98:01:a7:48:0f:d8 IEEE 802.11: associated (aid 1)
>     ap1: AP-STA-CONNECTED 98:01:a7:48:0f:d8
>     ap1: STA 98:01:a7:48:0f:d8 RADIUS: starting accounting session
> 57A210FFA9AEB7DF
>     ap1: STA 98:01:a7:48:0f:d8 WPA: pairwise key handshake completed (RSN)
>=20
> As you can see, create_ap not only is created, but I manage to connect
> a tablet onto the access point.
> If I now try to run wpa_supplicant, this now happens.
>=20
>     # wpa_supplicant -i sta0 -c ./example.conf
>     Successfully initialized wpa_supplicant
>     sta0: SME: Trying to authenticate with fc:ec:da:8a:84:de
> (SSID=3D'Test' freq=3D2412 MHz)
>     sta0: SME: Trying to authenticate with fc:ec:da:8a:84:de
> (SSID=3D'Test' freq=3D2412 MHz)
>     sta0: SME: Trying to authenticate with fc:ec:da:8a:84:de
> (SSID=3D'Test' freq=3D2412 MHz)
>     sta0: SME: Trying to authenticate with fc:ec:da:8a:84:de
> (SSID=3D'Test' freq=3D2412 MHz)
>     sta0: CTRL-EVENT-SSID-TEMP-DISABLED id=3D0 ssid=3D"Test"
> auth_failures=3D1 duration=3D10 reason=3DCONN_FAILED
>     sta0: CTRL-EVENT-SSID-REENABLED id=3D0 ssid=3D"Test"
>     sta0: SME: Trying to authenticate with fc:ec:da:8a:84:de
> (SSID=3D'Test' freq=3D2412 MHz)
>     sta0: CTRL-EVENT-SSID-TEMP-DISABLED id=3D0 ssid=3D"Test"
> auth_failures=3D2 duration=3D23 reason=3DCONN_FAILED
>     sta0: CTRL-EVENT-SSID-REENABLED id=3D0 ssid=3D"Test"
>     sta0: SME: Trying to authenticate with fc:ec:da:8a:84:de
> (SSID=3D'Test' freq=3D2412 MHz)
>     sta0: CTRL-EVENT-SSID-TEMP-DISABLED id=3D0 ssid=3D"Test"
> auth_failures=3D3 duration=3D46 reason=3DCONN_FAILED
>=20
> This will go on forever never being able to authenticate.
>=20
> Furthermore, there is a case where I can crash the driver.
> To do that, what I do is I run wpa_supplicant first. Immediately after
> I see it has initialized wpa_supplicant and is trying to authenticate,
> I immediately run create_ap on another terminal window. Create_ap will
> finish first usually and be able to start the ap. But the wireless
> network will not be running. Checking dmesg will show this.
>=20
>     [ 1692.699658] wpa_supplicant  D    0  2613   2612 0x00004000
>     [ 1692.699664] Call Trace:
>     [ 1692.699673]  __schedule+0x292/0x710
>     [ 1692.699681]  ? work_busy+0x90/0x90
>     [ 1692.699686]  schedule+0x33/0xa0
>     [ 1692.699693]  schedule_timeout+0x1d3/0x320
>     [ 1692.699700]  ? ttwu_do_activate+0x5a/0x70
>     [ 1692.699707]  ? work_busy+0x90/0x90
>     [ 1692.699713]  wait_for_completion+0xba/0x140
>     [ 1692.699718]  ? wake_up_q+0x80/0x80
>     [ 1692.699726]  __flush_work+0x18a/0x1c0
>     [ 1692.699734]  ? worker_detach_from_pool+0xb0/0xb0
>     [ 1692.699740]  __cancel_work_timer+0x136/0x1b0
>     [ 1692.699746]  ? schedule_preempt_disabled+0xe/0x10
>     [ 1692.699754]  ? hrtimer_try_to_cancel+0x2a/0x110
>     [ 1692.699760]  cancel_work_sync+0x10/0x20
>     [ 1692.699769]  mt76x02u_stop_pre_tbtt_timer+0x2a/0x40 [mt76x02_usb]
>     [ 1692.699777]  mt76x02u_pre_tbtt_enable+0x23/0x40 [mt76x02_usb]
>     [ 1692.699791]  mt76x02_mac_set_beacon_enable+0x33/0x2c0 [mt76x02_lib]
>     [ 1692.699804]  mt76x02_bss_info_changed+0x107/0x110 [mt76x02_lib]
>     [ 1692.699872]  ieee80211_bss_info_change_notify+0xab/0x190 [mac80211]
>     [ 1692.699936]  ieee80211_offchannel_stop_vifs+0x175/0x1b0 [mac80211]
>     [ 1692.699998]  __ieee80211_start_scan+0x346/0x750 [mac80211]
>     [ 1692.700061]  ieee80211_request_scan+0x30/0x50 [mac80211]
>     [ 1692.700129]  ieee80211_scan+0x69/0x90 [mac80211]
>     [ 1692.700204]  nl80211_trigger_scan+0x5cd/0x740 [cfg80211]
>     [ 1692.700215]  genl_family_rcv_msg+0x21c/0x490
>     [ 1692.700224]  ? free_one_page+0xbc/0x480
>     [ 1692.700233]  genl_rcv_msg+0x4c/0x90
>     [ 1692.700239]  ? genl_family_rcv_msg+0x490/0x490
>     [ 1692.700247]  netlink_rcv_skb+0x51/0x120
>     [ 1692.700254]  genl_rcv+0x28/0x40
>     [ 1692.700260]  netlink_unicast+0x1a4/0x250
>     [ 1692.700268]  netlink_sendmsg+0x2eb/0x3f0
>     [ 1692.700277]  sock_sendmsg+0x63/0x70
>     [ 1692.700283]  ____sys_sendmsg+0x200/0x280
>     [ 1692.700291]  ___sys_sendmsg+0x88/0xd0
>     [ 1692.700297]  ? sock_do_ioctl+0x4d/0x150
>     [ 1692.700304]  ? __check_object_size+0x4d/0x1b0
>     [ 1692.700310]  ? sock_ioctl+0x34f/0x3c0
>     [ 1692.700317]  ? __sys_recvfrom+0xe9/0x160
>     [ 1692.700325]  __sys_sendmsg+0x63/0xa0
>     [ 1692.700330]  ? __sys_sendmsg+0x63/0xa0
>     [ 1692.700339]  __x64_sys_sendmsg+0x1f/0x30
>     [ 1692.700347]  do_syscall_64+0x57/0x190
>     [ 1692.700355]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>     [ 1692.700362] RIP: 0033:0x7f7020b67b94
>     [ 1692.700377] Code: Bad RIP value.
>     [ 1692.700382] RSP: 002b:00007ffc2f22d978 EFLAGS: 00000246
> ORIG_RAX: 000000000000002e
>     [ 1692.700389] RAX: ffffffffffffffda RBX: 000055f6ab3c29f0 RCX:
> 00007f7020b67b94
>     [ 1692.700393] RDX: 0000000000000000 RSI: 00007ffc2f22d9b0 RDI:
> 0000000000000005
>     [ 1692.700398] RBP: 000055f6ab411700 R08: 0000000000000000 R09:
> 0000000000000000
>     [ 1692.700402] R10: 000055f6ab3c0010 R11: 0000000000000246 R12:
> 000055f6ab3c2900
>     [ 1692.700406] R13: 00007ffc2f22d9b0 R14: 0000000000000000 R15:
> 000055f6ab3c2d48
>=20
> So I'm sort of arriving at a conclusion that for some reason, this
> Netgear A6210 is not able to create both an access point and connect
> to a WiFi network at the same time. Yet iw list suggests that the
> driver can. Is there something I'm misunderstanding?
>=20
> Or am I doing something incorrectly? If I am, please do point it out.
>=20
> Lastly, if there is any information missing and you need, please feel
> free to ask and I will do my best to provide it, or reproduce the
> issue and provide the information you need.
>=20
>=20
> Best regards,
> Chris
>=20
> ps. Apologies for resending this. I got a rejection notice for one of
> the recipients because it contained some html.

--7TfSY8VbDe7/c7Wc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYN7I5QAKCRA6cBh0uS2t
rP6KAP9Z9jXgAWetcLlxx+DncxN4Z2HOolx+kekucHXWE/zmQgEA1OHH+PS3Y+s8
s8peN+zvWonCVEm8t0ergYI2U3GkFwY=
=kKXZ
-----END PGP SIGNATURE-----

--7TfSY8VbDe7/c7Wc--
