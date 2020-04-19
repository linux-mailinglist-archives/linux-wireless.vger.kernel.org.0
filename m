Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4FD1AFBC7
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2020 17:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgDSPtO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Apr 2020 11:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgDSPtN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Apr 2020 11:49:13 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672E4C061A0C
        for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2020 08:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xwFArNZ0LNOjTEWHEY1RpUJfSG6prp5hteZOveGvLIo=; b=YsxNO7EbcT4pt4TbciLCmvhcR
        c9p2PKIiHNMpyDk7mjrgy7xc64yueyPLSPGS7tKCcTnPaHzXGPUAydCmUL4qxueVuY7lahIp1d+u7
        5rO0TNrjoC4f+04S5x6FejDPTA0wvlPZ3NaNnXF9ycVCLOFeFGQZq9IJRCermZyvF6P4DaiQuR73P
        Tngl+tWzOtbEX30TXFFodnPv0UeNgcN3t66DyXfqW2LeGY3dUbjra6k98Dfv0XuLmGciFdlXAcI6F
        O/jzzxqrZANO4XJdiyU44NRnrenXWt1rBgb50LXSmXtOL3UArKLQr9/gN02LNB4Fsm+ZlVtVGOTUq
        sOWMDK/Cg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52218)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jQCBo-0006N8-H9; Sun, 19 Apr 2020 16:49:00 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jQCBm-0004xo-Nk; Sun, 19 Apr 2020 16:48:58 +0100
Date:   Sun, 19 Apr 2020 16:48:58 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        linux-wireless@vger.kernel.org
Cc:     Jon Nettleton <jon@solid-run.com>
Subject: Re: nl80211 / bcm4330 / hostapd fails to complete EAPOL in 5.6
Message-ID: <20200419154858.GO5827@shell.armlinux.org.uk>
References: <20200419082835.GV25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419082835.GV25745@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Apr 19, 2020 at 09:28:35AM +0100, Russell King - ARM Linux admin wrote:
> Hi,
> 
> I'm seeing a problem running hostapd with a BCM4330 on a SolidRun
> Hummingboard with 5.6 kernels - I can't get WPA2 authentication to
> complete with any client station.  5.3 on the same hardware was
> working fine.
> 
> Monitoring the wifi network using another machine, I see:
> 
> 02:31:53.753856 1.0 Mb/s 2412 MHz 11b -45dBm signal antenna 3 BSSID:ap:ap:ap:ap:ap:ap (oui Unknown) DA:ap:ap:ap:ap:ap:ap (oui Unknown) SA:sm:ar:tp:ho:ne:07 (oui Unknown) Authentication (Open System)-1: Successful
> 02:31:53.754159 1.0 Mb/s 2412 MHz 11b -38dBm signal antenna 3 RA:sm:ar:tp:ho:ne:07 (oui Unknown) Acknowledgment
> 02:31:53.754781 1.0 Mb/s 2412 MHz 11b -39dBm signal antenna 3 BSSID:ap:ap:ap:ap:ap:ap (oui Unknown) DA:sm:ar:tp:ho:ne:07 (oui Unknown) SA:ap:ap:ap:ap:ap:ap (oui Unknown) Authentication (Open System)-2:
> 02:31:53.755097 1.0 Mb/s 2412 MHz 11b -46dBm signal antenna 3 RA:ap:ap:ap:ap:ap:ap (oui Unknown) Acknowledgment
> 02:31:53.785688 1.0 Mb/s 2412 MHz 11b -44dBm signal antenna 3 BSSID:ap:ap:ap:ap:ap:ap (oui Unknown) DA:ap:ap:ap:ap:ap:ap (oui Unknown) SA:sm:ar:tp:ho:ne:07 (oui Unknown) Assoc Request (My-SSID) [1.0 2.0 5.5 11.0 6.0 9.0 12.0 18.0 Mbit]
> 02:31:53.785993 1.0 Mb/s 2412 MHz 11b -38dBm signal antenna 3 RA:sm:ar:tp:ho:ne:07 (oui Unknown) Acknowledgment
> 02:31:53.787462 1.0 Mb/s 2412 MHz 11b -39dBm signal antenna 3 BSSID:ap:ap:ap:ap:ap:ap (oui Unknown) DA:sm:ar:tp:ho:ne:07 (oui Unknown) SA:ap:ap:ap:ap:ap:ap (oui Unknown) Assoc Response AID(1) : PRIVACY : Successful
> 02:31:53.787777 1.0 Mb/s 2412 MHz 11b -44dBm signal antenna 3 RA:ap:ap:ap:ap:ap:ap (oui Unknown) Acknowledgment
> 02:31:53.803124 1.0 Mb/s 2412 MHz 11b -38dBm signal antenna 3 BSSID:ap:ap:ap:ap:ap:ap (oui Unknown) DA:sm:ar:tp:ho:ne:07 (oui Unknown) SA:ap:ap:ap:ap:ap:ap (oui Unknown) Action: BA ADDBA Request
> 02:31:53.803423 1.0 Mb/s 2412 MHz 11b -44dBm signal antenna 3 RA:ap:ap:ap:ap:ap:ap (oui Unknown) Acknowledgment
> 02:31:53.804871 1.0 Mb/s 2412 MHz 11b -37dBm signal antenna 3 CF +QoS DA:sm:ar:tp:ho:ne:07 (oui Unknown) BSSID:ap:ap:ap:ap:ap:ap (oui Unknown) SA:ap:ap:ap:ap:ap:ap (oui Unknown) LLC, dsap SNAP (0xaa) Individual, ssap SNAP (0xaa) Command, ctrl 0x03: oui Ethernet (0x000000), ethertype EAPOL (0x888e), length 99: EAPOL key (3) v2, len 95
> 02:31:53.805181 1.0 Mb/s 2412 MHz 11b -44dBm signal antenna 3 RA:ap:ap:ap:ap:ap:ap (oui Unknown) Acknowledgment
> 02:31:53.831347 54.0 Mb/s 2412 MHz 11g -50dBm signal antenna 3 BSSID:ap:ap:ap:ap:ap:ap (oui Unknown) SA:sm:ar:tp:ho:ne:07 (oui Unknown) DA:ap:ap:ap:ap:ap:ap (oui Unknown)
> 02:31:53.833079 24.0 Mb/s 2412 MHz 11g -51dBm signal antenna 3 RA:sm:ar:tp:ho:ne:07 (oui Unknown) Acknowledgment
> 02:31:53.833082 1.0 Mb/s 2412 MHz 11b -45dBm signal antenna 3 CF +QoS BSSID:ap:ap:ap:ap:ap:ap (oui Unknown) SA:sm:ar:tp:ho:ne:07 (oui Unknown) DA:ap:ap:ap:ap:ap:ap (oui Unknown) LLC, dsap SNAP (0xaa) Individual, ssap SNAP (0xaa) Command, ctrl 0x03: oui Ethernet (0x000000), ethertype EAPOL (0x888e), length 121: EAPOL key (3) v1, len 117
> 02:31:53.833390 1.0 Mb/s 2412 MHz 11b -37dBm signal antenna 3 RA:sm:ar:tp:ho:ne:07 (oui Unknown) Acknowledgment
> 02:31:53.833910 1.0 Mb/s 2412 MHz 11b -45dBm signal antenna 3 BSSID:ap:ap:ap:ap:ap:ap (oui Unknown) DA:ap:ap:ap:ap:ap:ap (oui Unknown) SA:sm:ar:tp:ho:ne:07 (oui Unknown) Action: BA ADDBA Response
> 02:31:53.834222 1.0 Mb/s 2412 MHz 11b -37dBm signal antenna 3 RA:sm:ar:tp:ho:ne:07 (oui Unknown) Acknowledgment
> 02:31:53.834646 1.0 Mb/s 2412 MHz 11b -37dBm signal antenna 3  RA:sm:ar:tp:ho:ne:07 (oui Unknown) TA:ap:ap:ap:ap:ap:ap (oui Unknown) CTL(4) SEQ(16) BAR
> 02:31:53.835105 1.0 Mb/s 2412 MHz 11b -45dBm signal antenna 3 RA:ap:ap:ap:ap:ap:ap (oui Unknown) BA
> 
> 02:31:54.805391 1.0 Mb/s 2412 MHz 11b -37dBm signal antenna 3 CF +QoS DA:sm:ar:tp:ho:ne:07 (oui Unknown) BSSID:ap:ap:ap:ap:ap:ap (oui Unknown) SA:ap:ap:ap:ap:ap:ap (oui Unknown) LLC, dsap SNAP (0xaa) Individual, ssap SNAP (0xaa) Command, ctrl 0x03: oui Ethernet (0x000000), ethertype EAPOL (0x888e), length 99: EAPOL key (3) v2, len 95
> 
> and it repeats.
> 
> However, turning on debug in hostapd shows that hostapd sends the
> EAPOL 1/4 message as expected, but never receives a response - it
> seems the EAPOL response that we can see above in tcpdump is getting
> dropped somewhere between the BCM4330 and hostapd.
> 
> nl80211: Drv Event 19 (NL80211_CMD_NEW_STATION) received for wlan0
> nl80211: New station sm:ar:tp:ho:ne:07
> wlan0: Event ASSOC (0) received
> wlan0: STA sm:ar:tp:ho:ne:07 IEEE 802.11: associated
> STA included RSN IE in (Re)AssocReq
>   New STA
> ap_sta_add: register ap_handle_timer timeout for sm:ar:tp:ho:ne:07 (300 seconds
> - ap_max_inactivity)
> nl80211: Set STA flags - ifname=wlan0 addr=sm:ar:tp:ho:ne:07 total_flags=0x60 flags_or=0x0 flags_and=0xfffffff1 authorized=0
> wlan0: STA sm:ar:tp:ho:ne:07 WPA: event 1 notification
> wpa_driver_nl80211_set_key: ifindex=3 (wlan0) alg=0 addr=0x20190a8 key_idx=0 set_tx=1 seq_len=0 key_len=0
>    addr=sm:ar:tp:ho:ne:07
> nl80211: set_key failed; err=-22 Invalid argument)
> RSN: PTK removal from the driver failed
> IEEE 802.1X: Ignore STA - 802.1X not enabled or forced for WPS
> wlan0: STA sm:ar:tp:ho:ne:07 WPA: start authentication
> WPA: sm:ar:tp:ho:ne:07 WPA_PTK entering state INITIALIZE
> wpa_driver_nl80211_set_key: ifindex=3 (wlan0) alg=0 addr=0x20190a8 key_idx=0 set_tx=1 seq_len=0 key_len=0
>    addr=sm:ar:tp:ho:ne:07
> nl80211: set_key failed; err=-22 Invalid argument)
> RSN: PTK removal from the driver failed
> nl80211: Set STA flags - ifname=wlan0 addr=sm:ar:tp:ho:ne:07 total_flags=0x60 flags_or=0x0 flags_and=0xfffffffe authorized=0
> wlan0: STA sm:ar:tp:ho:ne:07 IEEE 802.1X: unauthorizing port
> WPA: sm:ar:tp:ho:ne:07 WPA_PTK_GROUP entering state IDLE
> WPA: sm:ar:tp:ho:ne:07 WPA_PTK entering state AUTHENTICATION
> WPA: sm:ar:tp:ho:ne:07 WPA_PTK entering state AUTHENTICATION2
> WPA: Re-initialize GMK/Counter on first station
> GMK - hexdump(len=32): [REMOVED]
> Key Counter - hexdump(len=32): [REMOVED]
> GTK - hexdump(len=16): [REMOVED]
> wpa_driver_nl80211_set_key: ifindex=3 (wlan0) alg=3 addr=0x60a9ac key_idx=1 set_tx=1 seq_len=0 key_len=16
> nl80211: KEY_DATA - hexdump(len=16): [REMOVED]
>    broadcast key
> Searching a PSK for sm:ar:tp:ho:ne:07 prev_psk=(nil)
> Searching a PSK for sm:ar:tp:ho:ne:07 prev_psk=(nil)
> WPA: sm:ar:tp:ho:ne:07 WPA_PTK entering state PTKSTART
> wlan0: STA sm:ar:tp:ho:ne:07 WPA: sending 1/4 msg of 4-Way Handshake
> WPA: Send EAPOL(version=2 secure=0 mic=0 ack=1 install=0 pairwise=1 kde_len=0 keyidx=0 encr=0)
> WPA: Replay Counter - hexdump(len=8): 00 00 00 00 00 00 00 01
> WPA: Use EAPOL-Key timeout of 1000 ms (retry counter 1)
> wlan0: hostapd_new_assoc_sta: reschedule ap_handle_timer timeout for sm:ar:tp:ho:ne:07 (300 seconds - ap_max_inactivity)
> wlan0: STA sm:ar:tp:ho:ne:07 WPA: EAPOL-Key timeout
> WPA: sm:ar:tp:ho:ne:07 WPA_PTK entering state PTKSTART
> wlan0: STA sm:ar:tp:ho:ne:07 WPA: sending 1/4 msg of 4-Way Handshake
> WPA: Send EAPOL(version=2 secure=0 mic=0 ack=1 install=0 pairwise=1 kde_len=0 keyidx=0 encr=0)
> ...
> 
> I'm unable to add a monitor interface on the AP itself (hardware
> doesn't support monitor + AP).  How do I debug where the failure
> is occuring?

I've wound back to 5.3, and it fails there too now, which is really
odd - it was working for around 270 days with that kernel version,
and I'm ensuring I'm using the same broadcom firmware.  That's
including power cycling everything.

I've just updated my other AP - again, using debian stable (so same
hostapd version), it's also on the same kernel version (as in same
kernel binary) but that machine uses a TI WL18 chipset for its WiFi,
and that doesn't seem to have a problem.

So, the problem appears to be specific to the BCM4330 in some way.
Except maybe not according to further debug.

Enabling debug in brcmfmac:

 echo 8 > /sys/module/brcmfmac/parameters/debug

Shows:

brcmfmac: brcmf_netdev_start_xmit Enter, bsscfgidx=0
brcmfmac: brcmf_rx_frame Enter: mmc0:0001:1: rxp=c885cc00
brcmfmac: brcmf_fws_hdrpull enter: ifidx 0, skblen 135, sig 0
brcmfmac: brcmf_netif_rx rx proto=0x888E

tcpdumping the wlan interface on the AP shows the EAPOL packets (both
what we send and what is received) are present there.

stracing hostapd, which is using device_ap_sme=1 use_monitor=0, I
see:

socket(AF_PACKET, SOCK_DGRAM, htons(ETH_P_PAE)) = 15

So this socket is setup to receive packets of type 0x888e.  I
can't find anything further that manipulates this socket in the
hostapd strace.  However, I do see:

write(3, "WPA: Send EAPOL(version=2 secure=0 mic=0 ack=1 install=0 pairwise=1 kde_len=0 keyidx=0 encr=0)\n", 95) = 95
write(4, "wpas <2>: WPA: Send EAPOL(version=2 secure=0 mic=0 ack=1 install=0 pairwise=1 kde_len=0 keyidx=0 encr=0)\n", 105) = 105
write(4, "wpas <2>: WPA: Replay Counter - hexdump(len=8): 00 00 00 00 00 00 00 01", 71) = 71
write(3, "WPA: Replay Counter - hexdump(len=8): 00 00 00 00 00 00 00 01\n", 62)
= 62
sendto(13, "...", 99, 0, {sa_family=AF_PACKET, sll_protocol=htons(ETH_P_PAE), sll_ifindex=if_nametoindex("wlan0"), sll_hatype=ARPHRD_NETROM, sll_pkttype=PACKET_HOST, sll_halen=6, sll_addr=[...]}, 20) = 99
write(3, "WPA: Use EAPOL-Key timeout of 1000 ms (retry counter 1)\n", 56) = 56
write(4, "wpas <2>: WPA: Use EAPOL-Key timeout of 1000 ms (retry counter 1)\n", 66) = 66
clock_gettime(CLOCK_BOOTTIME, {tv_sec=21874, tv_nsec=646076492}) = 0
write(3, "wlan0: hostapd_new_assoc_sta: reschedule ap_handle_timer timeout for ... (300 seconds - ap_max_inactivity)\n", 121) = 121
write(4, "wpas <2>: wlan0: hostapd_new_assoc_sta: reschedule ap_handle_timer timeout for ... (300 seconds - ap_max_inactivity)\n", 131) = 131
clock_gettime(CLOCK_BOOTTIME, {tv_sec=21874, tv_nsec=647106886}) = 0
clock_gettime(CLOCK_BOOTTIME, {tv_sec=21874, tv_nsec=647439906}) = 0
_newselect(18, [5 7 9 10 11 12 15 16 17], [], [], {tv_sec=0, tv_usec=998637}) = 0 (Timeout)
clock_gettime(CLOCK_BOOTTIME, {tv_sec=21875, tv_nsec=647977403}) = 0
write(3, "wlan0: STA ... WPA: EAPOL-Key timeout\n", 52) = 52

which clearly shows that the packets are not being received by socket
fd 15.  According to the man page for packet(7), that socket on fd 15
_should_ be receiving the EAPOL frame. Yet, as I say, tcpdumping wlan0
_does_ show them, but hostapd's AF_PACKET socket is not.

I have no iptables rules, I have no ebtables rules.  If I could work
out how to use nft, I could check that as well, but it's got a most
unhelpful command line and needs me to read the 'net every time I want
to do anything with it - a most unfriendly program, seemingly designed
to be very unfriendly.

So, we're back to it looking like a kernel bug... yet I've no idea
how 5.3 worked perfectly well for 270 odd days but now doesn't.

Having now spent close to 12 hours time trying to get to the bottom of
this, I think it's time to admit defeat.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
