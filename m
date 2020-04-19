Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEB91AF8C0
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2020 10:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgDSI2q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Apr 2020 04:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725446AbgDSI2q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Apr 2020 04:28:46 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95289C061A0C
        for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2020 01:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oGz0ihBLvFr3l3BzEcwEji974kLofFhxTwuD/T4H/fw=; b=ZuvdcN/GWUHsnYkwdZRfe2id0
        exSbdjPo4KY3HJbISNW4i00B4LGEM81+XVJNcEyompmZbX+/k/PqQ7Qf1UeIchZzI9z6t0FMEklMG
        2lWurIIIkOx8qZD6GLZGZez8GmHYzbrUjGAc7r6ASj62CQu9/SW3p9DuInesKFQes71fKFhES3P5x
        ekoscVeqOBlpNkW9BRkR2PGoXQQbOwj0oWTxTI0msB8Ez953syeUPXDnFdEfXnG+itUloGg6VMslf
        OWnw80nVKGjBGCJbAP77LXdAABL6bMclDWNuT8rMltf1MzxMQgDRw1fs3vvVDKfOTEOZyZVo36WuA
        JeFwlAQrA==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:47946)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jQ5Je-0004TA-C0; Sun, 19 Apr 2020 09:28:38 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jQ5Jc-0004hs-3j; Sun, 19 Apr 2020 09:28:36 +0100
Date:   Sun, 19 Apr 2020 09:28:36 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        linux-wireless@vger.kernel.org
Cc:     Jon Nettleton <jon@solid-run.com>
Subject: nl80211 / bcm4330 / hostapd fails to complete EAPOL in 5.6
Message-ID: <20200419082835.GV25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I'm seeing a problem running hostapd with a BCM4330 on a SolidRun
Hummingboard with 5.6 kernels - I can't get WPA2 authentication to
complete with any client station.  5.3 on the same hardware was
working fine.

Monitoring the wifi network using another machine, I see:

02:31:53.753856 1.0 Mb/s 2412 MHz 11b -45dBm signal antenna 3 BSSID:ap:ap:ap:ap:ap:ap (oui Unknown) DA:ap:ap:ap:ap:ap:ap (oui Unknown) SA:sm:ar:tp:ho:ne:07 (oui Unknown) Authentication (Open System)-1: Successful
02:31:53.754159 1.0 Mb/s 2412 MHz 11b -38dBm signal antenna 3 RA:sm:ar:tp:ho:ne:07 (oui Unknown) Acknowledgment
02:31:53.754781 1.0 Mb/s 2412 MHz 11b -39dBm signal antenna 3 BSSID:ap:ap:ap:ap:ap:ap (oui Unknown) DA:sm:ar:tp:ho:ne:07 (oui Unknown) SA:ap:ap:ap:ap:ap:ap (oui Unknown) Authentication (Open System)-2:
02:31:53.755097 1.0 Mb/s 2412 MHz 11b -46dBm signal antenna 3 RA:ap:ap:ap:ap:ap:ap (oui Unknown) Acknowledgment
02:31:53.785688 1.0 Mb/s 2412 MHz 11b -44dBm signal antenna 3 BSSID:ap:ap:ap:ap:ap:ap (oui Unknown) DA:ap:ap:ap:ap:ap:ap (oui Unknown) SA:sm:ar:tp:ho:ne:07 (oui Unknown) Assoc Request (My-SSID) [1.0 2.0 5.5 11.0 6.0 9.0 12.0 18.0 Mbit]
02:31:53.785993 1.0 Mb/s 2412 MHz 11b -38dBm signal antenna 3 RA:sm:ar:tp:ho:ne:07 (oui Unknown) Acknowledgment
02:31:53.787462 1.0 Mb/s 2412 MHz 11b -39dBm signal antenna 3 BSSID:ap:ap:ap:ap:ap:ap (oui Unknown) DA:sm:ar:tp:ho:ne:07 (oui Unknown) SA:ap:ap:ap:ap:ap:ap (oui Unknown) Assoc Response AID(1) : PRIVACY : Successful
02:31:53.787777 1.0 Mb/s 2412 MHz 11b -44dBm signal antenna 3 RA:ap:ap:ap:ap:ap:ap (oui Unknown) Acknowledgment
02:31:53.803124 1.0 Mb/s 2412 MHz 11b -38dBm signal antenna 3 BSSID:ap:ap:ap:ap:ap:ap (oui Unknown) DA:sm:ar:tp:ho:ne:07 (oui Unknown) SA:ap:ap:ap:ap:ap:ap (oui Unknown) Action: BA ADDBA Request
02:31:53.803423 1.0 Mb/s 2412 MHz 11b -44dBm signal antenna 3 RA:ap:ap:ap:ap:ap:ap (oui Unknown) Acknowledgment
02:31:53.804871 1.0 Mb/s 2412 MHz 11b -37dBm signal antenna 3 CF +QoS DA:sm:ar:tp:ho:ne:07 (oui Unknown) BSSID:ap:ap:ap:ap:ap:ap (oui Unknown) SA:ap:ap:ap:ap:ap:ap (oui Unknown) LLC, dsap SNAP (0xaa) Individual, ssap SNAP (0xaa) Command, ctrl 0x03: oui Ethernet (0x000000), ethertype EAPOL (0x888e), length 99: EAPOL key (3) v2, len 95
02:31:53.805181 1.0 Mb/s 2412 MHz 11b -44dBm signal antenna 3 RA:ap:ap:ap:ap:ap:ap (oui Unknown) Acknowledgment
02:31:53.831347 54.0 Mb/s 2412 MHz 11g -50dBm signal antenna 3 BSSID:ap:ap:ap:ap:ap:ap (oui Unknown) SA:sm:ar:tp:ho:ne:07 (oui Unknown) DA:ap:ap:ap:ap:ap:ap (oui Unknown)
02:31:53.833079 24.0 Mb/s 2412 MHz 11g -51dBm signal antenna 3 RA:sm:ar:tp:ho:ne:07 (oui Unknown) Acknowledgment
02:31:53.833082 1.0 Mb/s 2412 MHz 11b -45dBm signal antenna 3 CF +QoS BSSID:ap:ap:ap:ap:ap:ap (oui Unknown) SA:sm:ar:tp:ho:ne:07 (oui Unknown) DA:ap:ap:ap:ap:ap:ap (oui Unknown) LLC, dsap SNAP (0xaa) Individual, ssap SNAP (0xaa) Command, ctrl 0x03: oui Ethernet (0x000000), ethertype EAPOL (0x888e), length 121: EAPOL key (3) v1, len 117
02:31:53.833390 1.0 Mb/s 2412 MHz 11b -37dBm signal antenna 3 RA:sm:ar:tp:ho:ne:07 (oui Unknown) Acknowledgment
02:31:53.833910 1.0 Mb/s 2412 MHz 11b -45dBm signal antenna 3 BSSID:ap:ap:ap:ap:ap:ap (oui Unknown) DA:ap:ap:ap:ap:ap:ap (oui Unknown) SA:sm:ar:tp:ho:ne:07 (oui Unknown) Action: BA ADDBA Response
02:31:53.834222 1.0 Mb/s 2412 MHz 11b -37dBm signal antenna 3 RA:sm:ar:tp:ho:ne:07 (oui Unknown) Acknowledgment
02:31:53.834646 1.0 Mb/s 2412 MHz 11b -37dBm signal antenna 3  RA:sm:ar:tp:ho:ne:07 (oui Unknown) TA:ap:ap:ap:ap:ap:ap (oui Unknown) CTL(4) SEQ(16) BAR
02:31:53.835105 1.0 Mb/s 2412 MHz 11b -45dBm signal antenna 3 RA:ap:ap:ap:ap:ap:ap (oui Unknown) BA

02:31:54.805391 1.0 Mb/s 2412 MHz 11b -37dBm signal antenna 3 CF +QoS DA:sm:ar:tp:ho:ne:07 (oui Unknown) BSSID:ap:ap:ap:ap:ap:ap (oui Unknown) SA:ap:ap:ap:ap:ap:ap (oui Unknown) LLC, dsap SNAP (0xaa) Individual, ssap SNAP (0xaa) Command, ctrl 0x03: oui Ethernet (0x000000), ethertype EAPOL (0x888e), length 99: EAPOL key (3) v2, len 95

and it repeats.

However, turning on debug in hostapd shows that hostapd sends the
EAPOL 1/4 message as expected, but never receives a response - it
seems the EAPOL response that we can see above in tcpdump is getting
dropped somewhere between the BCM4330 and hostapd.

nl80211: Drv Event 19 (NL80211_CMD_NEW_STATION) received for wlan0
nl80211: New station sm:ar:tp:ho:ne:07
wlan0: Event ASSOC (0) received
wlan0: STA sm:ar:tp:ho:ne:07 IEEE 802.11: associated
STA included RSN IE in (Re)AssocReq
  New STA
ap_sta_add: register ap_handle_timer timeout for sm:ar:tp:ho:ne:07 (300 seconds
- ap_max_inactivity)
nl80211: Set STA flags - ifname=wlan0 addr=sm:ar:tp:ho:ne:07 total_flags=0x60 flags_or=0x0 flags_and=0xfffffff1 authorized=0
wlan0: STA sm:ar:tp:ho:ne:07 WPA: event 1 notification
wpa_driver_nl80211_set_key: ifindex=3 (wlan0) alg=0 addr=0x20190a8 key_idx=0 set_tx=1 seq_len=0 key_len=0
   addr=sm:ar:tp:ho:ne:07
nl80211: set_key failed; err=-22 Invalid argument)
RSN: PTK removal from the driver failed
IEEE 802.1X: Ignore STA - 802.1X not enabled or forced for WPS
wlan0: STA sm:ar:tp:ho:ne:07 WPA: start authentication
WPA: sm:ar:tp:ho:ne:07 WPA_PTK entering state INITIALIZE
wpa_driver_nl80211_set_key: ifindex=3 (wlan0) alg=0 addr=0x20190a8 key_idx=0 set_tx=1 seq_len=0 key_len=0
   addr=sm:ar:tp:ho:ne:07
nl80211: set_key failed; err=-22 Invalid argument)
RSN: PTK removal from the driver failed
nl80211: Set STA flags - ifname=wlan0 addr=sm:ar:tp:ho:ne:07 total_flags=0x60 flags_or=0x0 flags_and=0xfffffffe authorized=0
wlan0: STA sm:ar:tp:ho:ne:07 IEEE 802.1X: unauthorizing port
WPA: sm:ar:tp:ho:ne:07 WPA_PTK_GROUP entering state IDLE
WPA: sm:ar:tp:ho:ne:07 WPA_PTK entering state AUTHENTICATION
WPA: sm:ar:tp:ho:ne:07 WPA_PTK entering state AUTHENTICATION2
WPA: Re-initialize GMK/Counter on first station
GMK - hexdump(len=32): [REMOVED]
Key Counter - hexdump(len=32): [REMOVED]
GTK - hexdump(len=16): [REMOVED]
wpa_driver_nl80211_set_key: ifindex=3 (wlan0) alg=3 addr=0x60a9ac key_idx=1 set_tx=1 seq_len=0 key_len=16
nl80211: KEY_DATA - hexdump(len=16): [REMOVED]
   broadcast key
Searching a PSK for sm:ar:tp:ho:ne:07 prev_psk=(nil)
Searching a PSK for sm:ar:tp:ho:ne:07 prev_psk=(nil)
WPA: sm:ar:tp:ho:ne:07 WPA_PTK entering state PTKSTART
wlan0: STA sm:ar:tp:ho:ne:07 WPA: sending 1/4 msg of 4-Way Handshake
WPA: Send EAPOL(version=2 secure=0 mic=0 ack=1 install=0 pairwise=1 kde_len=0 keyidx=0 encr=0)
WPA: Replay Counter - hexdump(len=8): 00 00 00 00 00 00 00 01
WPA: Use EAPOL-Key timeout of 1000 ms (retry counter 1)
wlan0: hostapd_new_assoc_sta: reschedule ap_handle_timer timeout for sm:ar:tp:ho:ne:07 (300 seconds - ap_max_inactivity)
wlan0: STA sm:ar:tp:ho:ne:07 WPA: EAPOL-Key timeout
WPA: sm:ar:tp:ho:ne:07 WPA_PTK entering state PTKSTART
wlan0: STA sm:ar:tp:ho:ne:07 WPA: sending 1/4 msg of 4-Way Handshake
WPA: Send EAPOL(version=2 secure=0 mic=0 ack=1 install=0 pairwise=1 kde_len=0 keyidx=0 encr=0)
...

I'm unable to add a monitor interface on the AP itself (hardware
doesn't support monitor + AP).  How do I debug where the failure
is occuring?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
