Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3E727D164
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Sep 2020 16:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgI2Ojt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Sep 2020 10:39:49 -0400
Received: from pop36.abv.bg ([194.153.145.227]:36200 "EHLO pop36.abv.bg"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728446AbgI2Ojt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Sep 2020 10:39:49 -0400
Received: from smtp.abv.bg (localhost [127.0.0.1])
        by pop36.abv.bg (Postfix) with ESMTP id 9AF8A1805C4D;
        Tue, 29 Sep 2020 17:39:43 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=abv.bg; s=smtp-out;
        t=1601390383; bh=XgToWKX9WoVYLq079yId94dblPhBZGRTes6m1LOchMY=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=ztfQggftUvP2KnK6SutTHLW/yEXWiU3OYwPtCu6LplSwyyDkN4VBj2swSnq14hv4v
         fZ35rIZXfFzkkoLYlt3mwXJXSw5CAHhqkjR4CF29LRpDgg3zFgv/ZKrzVCotKb+kOa
         nF21aHh/lOX2P8qP2Yepr4PimL0zYsDvv9GThiJQ=
X-HELO: [192.168.192.3]
Authentication-Results: smtp.abv.bg; auth=pass (plain) smtp.auth=gvalkov@abv.bg
Received: from Unknown (HELO [192.168.192.3]) (87.118.177.198)
 by smtp.abv.bg (qpsmtpd/0.96) with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted); Tue, 29 Sep 2020 17:39:43 +0300
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v3] mac80211: fix regression in sta connection monitor
From:   Georgi Valkov <gvalkov@abv.bg>
In-Reply-To: <98daee02-b277-2850-6bc2-16f4d8971fac@nbd.name>
Date:   Tue, 29 Sep 2020 17:39:40 +0300
Cc:     linux-wireless@vger.kernel.org, johannes@sipsolutions.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <E4477E4F-80D6-47A9-8211-4D081012A457@abv.bg>
References: <20200927105605.97954-1-nbd@nbd.name>
 <4ED2AADF-092B-424E-A5B5-C2A371C88A92@abv.bg>
 <FC3CA053-0DB9-41B9-AEC6-0AE189AEFE17@abv.bg>
 <98daee02-b277-2850-6bc2-16f4d8971fac@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Felix!
I was also beginning to think that the disconnect where "group key =
handshake failed" is unrelated, because v3 of your patch resets =
probe_send_count consistently. In the rare event when the nullfunc is =
not acknowledged the first time due to a packet loss, it is resent and =
acknowleged a few miliseconds later. During a disconnect, the locations =
in ieee80211_sta_work() which print "No ack for nullfunc [... =
disconnecting]" are not called. I added printk to be sure. Comparing the =
logs during that disconnect, according to the AP: group key handshake =
failed (RSN) after 4 tries, while the STA thinks that: Group rekeying =
completed, and then gets kicked off the network. Then it tries to =
authenticate immediately, and both sides think authentication is =
successful, with the tiny detail that the AP prints "authenticated" 19 =
seconds later, and then immediately deletes the interface: phy1: staid 1 =
deleted. Yet for some reason the following 5 minutes the AP replays to =
nullfunc from STA and STA think everything is good. Something is wrong =
here.
1. Isn't the nullfunc supposed to fail, so the STA gets kicked off =
faster and reconnect?
2. Why does the group key handshake fail in first place? Could this be =
related to the KRACK countermeasurement which is supported and enabled =
in the AP (WRT3200ACM has a newer radio), but is probably not supported =
(and not listed in Luci) on the old router (1043ND v4). Or is this some =
bug? Both are compiled from the same commit (a few days ago on master).

At this pont I suggest you commit v3 and mark the original issue as =
resolved. I will be very thankful if you help me resolve the group =
handshake or why the STA remains offline for 5 minutes.

Thank you for being with me, and please let me know what you think about =
the other e-mails I sent:
1. json-c: Embed RPATH on macOS to prevent error in ucert: dyld: Library =
not loaded: libjson-c.5.dylib
2. Building on macOS with Xcode 12, clang 12 - sent only to the mail =
listing, let me know if I should forward a copy to you.

Good luck!

Georgi


[AP system log]
Tue Sep 29 15:27:04 2020 daemon.info hostapd: wifi_5g: STA =
38:f9:d3:aa:aa:aa WPA: group key handshake completed (RSN)
Tue Sep 29 15:27:04 2020 daemon.info hostapd: wifi_5g: STA =
d0:c5:f3:bb:bb:bb WPA: group key handshake completed (RSN)
Tue Sep 29 15:27:07 2020 daemon.info hostapd: wifi: STA =
98:de:d0:xx:xx:xx WPA: group key handshake failed (RSN) after 4 tries
Tue Sep 29 15:27:07 2020 daemon.notice hostapd: wifi: =
AP-STA-DISCONNECTED 98:de:d0:xx:xx:xx
Tue Sep 29 15:27:08 2020 kern.debug kernel: [432066.746438] ieee80211 =
phy1: staid 1 deleted
Tue Sep 29 15:27:08 2020 daemon.info hostapd: wifi: STA =
98:de:d0:xx:xx:xx IEEE 802.11: associated (aid 1)
Tue Sep 29 15:27:08 2020 daemon.notice hostapd: wifi: AP-STA-CONNECTED =
98:de:d0:xx:xx:xx
Tue Sep 29 15:27:08 2020 daemon.info hostapd: wifi: STA =
98:de:d0:xx:xx:xx WPA: pairwise key handshake completed (RSN)
Tue Sep 29 15:27:27 2020 daemon.info hostapd: wifi: STA =
98:de:d0:xx:xx:xx IEEE 802.11: authenticated
Tue Sep 29 15:27:27 2020 kern.debug kernel: [432086.546406] ieee80211 =
phy1: staid 1 deleted
Tue Sep 29 15:32:08 2020 daemon.notice hostapd: wifi: =
AP-STA-DISCONNECTED 98:de:d0:xx:xx:xx
Tue Sep 29 15:32:08 2020 daemon.info hostapd: wifi: STA =
98:de:d0:xx:xx:xx IEEE 802.11: disassociated due to inactivity
Tue Sep 29 15:32:08 2020 daemon.info hostapd: wifi: STA =
98:de:d0:xx:xx:xx IEEE 802.11: associated (aid 1)
Tue Sep 29 15:32:08 2020 daemon.notice hostapd: wifi: AP-STA-CONNECTED =
98:de:d0:xx:xx:xx
Tue Sep 29 15:32:08 2020 daemon.info hostapd: wifi: STA =
98:de:d0:xx:xx:xx WPA: pairwise key handshake completed (RSN)
Tue Sep 29 15:32:18 2020 daemon.info hostapd: wifi: STA =
98:de:d0:xx:xx:xx IEEE 802.11: authenticated

[STA system log]
Tue Sep 29 14:55:14 2020 kern.debug kernel: [58169.232195] =
probe_send_count++ 1
Tue Sep 29 14:55:14 2020 kern.debug kernel: [58169.235542] =
ieee80211_send_nullfunc(false) from ieee80211_mgd_probe_ap_send, =
probe_send_count 1
Tue Sep 29 14:55:14 2020 kern.info kernel: [58169.246499] wifi: =
probe_send_count: 1  vif.type 2:2
Tue Sep 29 14:55:14 2020 kern.warn kernel: [58169.251875] No ack for =
nullfunc frame to AP 60:38:e0:cd:1c:91, try 1/2
Tue Sep 29 14:55:14 2020 kern.debug kernel: [58169.258652] =
probe_send_count++ 2
Tue Sep 29 14:55:14 2020 kern.debug kernel: [58169.261989] =
ieee80211_send_nullfunc(false) from ieee80211_mgd_probe_ap_send, =
probe_send_count 2
Tue Sep 29 14:55:14 2020 kern.info kernel: [58169.271198] ivan: --- ack  =
probe_send_count: 2  vif.type 2:2

Tue Sep 29 15:25:40 2020 kern.debug kernel: [59996.019411] =
probe_send_count++ 1
Tue Sep 29 15:25:40 2020 kern.debug kernel: [59996.022750] =
ieee80211_send_nullfunc(false) from ieee80211_mgd_probe_ap_send, =
probe_send_count 1
Tue Sep 29 15:25:40 2020 kern.info kernel: [59996.031966] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Tue Sep 29 15:26:11 2020 kern.debug kernel: [60026.738838] =
probe_send_count++ 1
Tue Sep 29 15:26:11 2020 kern.debug kernel: [60026.742181] =
ieee80211_send_nullfunc(false) from ieee80211_mgd_probe_ap_send, =
probe_send_count 1
Tue Sep 29 15:26:11 2020 kern.info kernel: [60026.751408] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Tue Sep 29 15:26:44 2020 kern.debug kernel: [60059.506214] =
probe_send_count++ 1
Tue Sep 29 15:26:44 2020 kern.debug kernel: [60059.509552] =
ieee80211_send_nullfunc(false) from ieee80211_mgd_probe_ap_send, =
probe_send_count 1
Tue Sep 29 15:26:44 2020 kern.info kernel: [60059.521346] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2

Tue Sep 29 15:27:03 2020 daemon.notice wpa_supplicant[1319]: wifi: WPA: =
Group rekeying completed with 60:38:e0:yy:yy:yy [GTK=3DCCMP]
Tue Sep 29 15:27:07 2020 kern.info kernel: [60082.764451] wifi: =
deauthenticated from 60:38:e0:yy:yy:yy (Reason: =
16=3DGROUP_KEY_HANDSHAKE_TIMEOUT)
Tue Sep 29 15:27:07 2020 kern.info kernel: [60082.773803] br-lan: port =
3(wifi) entered disabled state
Tue Sep 29 15:27:07 2020 kern.info kernel: [60082.779299] br-lan: =
topology change detected, propagating
Tue Sep 29 15:27:07 2020 daemon.notice netifd: Network device 'wifi' =
link is down
Tue Sep 29 15:27:07 2020 daemon.notice wpa_supplicant[1319]: wifi: =
CTRL-EVENT-DISCONNECTED bssid=3D60:38:e0:yy:yy:yy reason=3D16
Tue Sep 29 15:27:08 2020 daemon.notice wpa_supplicant[1319]: wifi: SME: =
Trying to authenticate with 60:38:e0:yy:yy:yy (SSID=3D'wifi' freq=3D2432 =
MHz)
Tue Sep 29 15:27:08 2020 kern.info kernel: [60083.747939] wifi: =
authenticate with 60:38:e0:yy:yy:yy
Tue Sep 29 15:27:08 2020 kern.info kernel: [60083.767269] wifi: send =
auth to 60:38:e0:yy:yy:yy (try 1/3)
Tue Sep 29 15:27:08 2020 daemon.notice wpa_supplicant[1319]: wifi: =
Trying to associate with 60:38:e0:yy:yy:yy (SSID=3D'wifi' freq=3D2432 =
MHz)
Tue Sep 29 15:27:08 2020 kern.info kernel: [60083.808370] wifi: =
authenticated
Tue Sep 29 15:27:08 2020 kern.info kernel: [60083.813911] wifi: =
associate with 60:38:e0:yy:yy:yy (try 1/3)
Tue Sep 29 15:27:08 2020 kern.info kernel: [60083.838239] wifi: RX =
AssocResp from 60:38:e0:yy:yy:yy (capab=3D0x431 status=3D0 aid=3D1)
Tue Sep 29 15:27:08 2020 kern.info kernel: [60083.846402] wifi: =
associated
Tue Sep 29 15:27:08 2020 daemon.notice netifd: Network device 'wifi' =
link is up
Tue Sep 29 15:27:08 2020 daemon.notice wpa_supplicant[1319]: wifi: =
Associated with 60:38:e0:yy:yy:yy
Tue Sep 29 15:27:08 2020 daemon.notice wpa_supplicant[1319]: wifi: =
CTRL-EVENT-SUBNET-STATUS-UPDATE status=3D0
Tue Sep 29 15:27:08 2020 daemon.notice wpa_supplicant[1319]: wifi: WPA: =
Key negotiation completed with 60:38:e0:yy:yy:yy [PTK=3DCCMP GTK=3DCCMP]
Tue Sep 29 15:27:08 2020 daemon.notice wpa_supplicant[1319]: wifi: =
CTRL-EVENT-CONNECTED - Connection to 60:38:e0:yy:yy:yy completed [id=3D0 =
id_str=3D]
Tue Sep 29 15:27:08 2020 kern.info kernel: [60083.858846] br-lan: port =
3(wifi) entered blocking state
Tue Sep 29 15:27:08 2020 kern.info kernel: [60083.864305] br-lan: port =
3(wifi) entered listening state
Tue Sep 29 15:27:10 2020 kern.info kernel: [60085.873708] br-lan: port =
3(wifi) entered learning state
Tue Sep 29 15:27:12 2020 kern.info kernel: [60087.889670] br-lan: port =
3(wifi) entered forwarding state
Tue Sep 29 15:27:12 2020 kern.info kernel: [60087.895262] br-lan: =
topology change detected, sending tcn bpdu
Tue Sep 29 15:27:39 2020 kern.debug kernel: [60114.801162] =
probe_send_count++ 1
Tue Sep 29 15:27:39 2020 kern.debug kernel: [60114.804506] =
ieee80211_send_nullfunc(false) from ieee80211_mgd_probe_ap_send, =
probe_send_count 1
Tue Sep 29 15:27:39 2020 kern.info kernel: [60114.813722] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Tue Sep 29 15:27:47 2020 kern.info kernel: [60122.993006] br-lan: port =
3(wifi) neighbor 7fff.60:38:e0:yy:yy:yz lost
Tue Sep 29 15:27:47 2020 kern.info kernel: [60122.999677] br-lan: =
topology change detected, propagating
Tue Sep 29 15:28:12 2020 kern.debug kernel: [60147.568535] =
probe_send_count++ 1
Tue Sep 29 15:28:12 2020 kern.debug kernel: [60147.571880] =
ieee80211_send_nullfunc(false) from ieee80211_mgd_probe_ap_send, =
probe_send_count 1
Tue Sep 29 15:28:12 2020 kern.info kernel: [60147.581094] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Tue Sep 29 15:28:43 2020 kern.debug kernel: [60178.287944] =
probe_send_count++ 1
Tue Sep 29 15:28:43 2020 kern.debug kernel: [60178.291284] =
ieee80211_send_nullfunc(false) from ieee80211_mgd_probe_ap_send, =
probe_send_count 1
Tue Sep 29 15:28:43 2020 kern.info kernel: [60178.306328] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Tue Sep 29 15:29:13 2020 kern.debug kernel: [60209.007373] =
probe_send_count++ 1
Tue Sep 29 15:29:13 2020 kern.debug kernel: [60209.010716] =
ieee80211_send_nullfunc(false) from ieee80211_mgd_probe_ap_send, =
probe_send_count 1
Tue Sep 29 15:29:13 2020 kern.info kernel: [60209.019935] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Tue Sep 29 15:29:44 2020 kern.debug kernel: [60239.727155] =
probe_send_count++ 1
Tue Sep 29 15:29:44 2020 kern.debug kernel: [60239.730497] =
ieee80211_send_nullfunc(false) from ieee80211_mgd_probe_ap_send, =
probe_send_count 1
Tue Sep 29 15:29:44 2020 kern.info kernel: [60239.739739] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Tue Sep 29 15:30:17 2020 kern.debug kernel: [60272.494118] =
probe_send_count++ 1
Tue Sep 29 15:30:17 2020 kern.debug kernel: [60272.497466] =
ieee80211_send_nullfunc(false) from ieee80211_mgd_probe_ap_send, =
probe_send_count 1
Tue Sep 29 15:30:17 2020 kern.info kernel: [60272.506680] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Tue Sep 29 15:30:48 2020 kern.debug kernel: [60303.213517] =
probe_send_count++ 1
Tue Sep 29 15:30:48 2020 kern.debug kernel: [60303.216860] =
ieee80211_send_nullfunc(false) from ieee80211_mgd_probe_ap_send, =
probe_send_count 1
Tue Sep 29 15:30:48 2020 kern.info kernel: [60303.226077] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Tue Sep 29 15:31:18 2020 kern.debug kernel: [60333.932939] =
probe_send_count++ 1
Tue Sep 29 15:31:18 2020 kern.debug kernel: [60333.936281] =
ieee80211_send_nullfunc(false) from ieee80211_mgd_probe_ap_send, =
probe_send_count 1
Tue Sep 29 15:31:18 2020 kern.info kernel: [60333.947000] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Tue Sep 29 15:31:51 2020 kern.debug kernel: [60366.700269] =
probe_send_count++ 1
Tue Sep 29 15:31:51 2020 kern.debug kernel: [60366.703610] =
ieee80211_send_nullfunc(false) from ieee80211_mgd_probe_ap_send, =
probe_send_count 1
Tue Sep 29 15:31:51 2020 kern.info kernel: [60366.712923] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2

Tue Sep 29 15:32:08 2020 kern.info kernel: [60383.727820] wifi: =
disassociated from 60:38:e0:yy:yy:yy (Reason: =
4=3DDISASSOC_DUE_TO_INACTIVITY)
Tue Sep 29 15:32:08 2020 kern.info kernel: [60383.737620] br-lan: port =
3(wifi) entered disabled state
Tue Sep 29 15:32:08 2020 daemon.notice netifd: Network device 'wifi' =
link is down
Tue Sep 29 15:32:08 2020 daemon.notice wpa_supplicant[1319]: wifi: =
CTRL-EVENT-DISCONNECTED bssid=3D60:38:e0:yy:yy:yy reason=3D4
Tue Sep 29 15:32:08 2020 daemon.notice wpa_supplicant[1319]: wifi: SME: =
Trying to authenticate with 60:38:e0:yy:yy:yy (SSID=3D'wifi' freq=3D2432 =
MHz)
Tue Sep 29 15:32:08 2020 kern.info kernel: [60383.792996] wifi: =
authenticate with 60:38:e0:yy:yy:yy
Tue Sep 29 15:32:08 2020 kern.info kernel: [60383.812320] wifi: send =
auth to 60:38:e0:yy:yy:yy (try 1/3)
Tue Sep 29 15:32:08 2020 kern.info kernel: [60383.819596] wifi: =
authenticated
Tue Sep 29 15:32:08 2020 daemon.notice wpa_supplicant[1319]: wifi: =
Trying to associate with 60:38:e0:yy:yy:yy (SSID=3D'wifi' freq=3D2432 =
MHz)
Tue Sep 29 15:32:08 2020 kern.info kernel: [60383.824009] wifi: =
associate with 60:38:e0:yy:yy:yy (try 1/3)
Tue Sep 29 15:32:08 2020 kern.info kernel: [60383.851498] wifi: RX =
AssocResp from 60:38:e0:yy:yy:yy (capab=3D0x431 status=3D0 aid=3D1)
Tue Sep 29 15:32:08 2020 kern.info kernel: [60383.859681] wifi: =
associated
Tue Sep 29 15:32:08 2020 daemon.notice wpa_supplicant[1319]: wifi: =
Associated with 60:38:e0:yy:yy:yy
Tue Sep 29 15:32:08 2020 daemon.notice wpa_supplicant[1319]: wifi: =
CTRL-EVENT-SUBNET-STATUS-UPDATE status=3D0
Tue Sep 29 15:32:08 2020 daemon.notice netifd: Network device 'wifi' =
link is up
Tue Sep 29 15:32:08 2020 daemon.notice wpa_supplicant[1319]: wifi: WPA: =
Key negotiation completed with 60:38:e0:yy:yy:yy [PTK=3DCCMP GTK=3DCCMP]
Tue Sep 29 15:32:08 2020 daemon.notice wpa_supplicant[1319]: wifi: =
CTRL-EVENT-CONNECTED - Connection to 60:38:e0:yy:yy:yy completed [id=3D0 =
id_str=3D]
Tue Sep 29 15:32:08 2020 kern.info kernel: [60383.872438] br-lan: port =
3(wifi) entered blocking state
Tue Sep 29 15:32:08 2020 kern.info kernel: [60383.877894] br-lan: port =
3(wifi) entered listening state
Tue Sep 29 15:32:10 2020 kern.info kernel: [60385.899887] br-lan: port =
3(wifi) entered learning state
Tue Sep 29 15:32:12 2020 kern.info kernel: [60387.915843] br-lan: port =
3(wifi) entered forwarding state
Tue Sep 29 15:32:12 2020 kern.info kernel: [60387.921434] br-lan: =
topology change detected, propagating
Tue Sep 29 15:32:40 2020 kern.debug kernel: [60415.851325] =
probe_send_count++ 1
Tue Sep 29 15:32:40 2020 kern.debug kernel: [60415.854666] =
ieee80211_send_nullfunc(false) from ieee80211_mgd_probe_ap_send, =
probe_send_count 1
Tue Sep 29 15:32:40 2020 kern.info kernel: [60415.864374] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Tue Sep 29 15:33:13 2020 kern.debug kernel: [60448.618649] =
probe_send_count++ 1
Tue Sep 29 15:33:13 2020 kern.debug kernel: [60448.621993] =
ieee80211_send_nullfunc(false) from ieee80211_mgd_probe_ap_send, =
probe_send_count 1
Tue Sep 29 15:33:13 2020 kern.info kernel: [60448.631213] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Tue Sep 29 15:33:44 2020 kern.debug kernel: [60479.338025] =
probe_send_count++ 1
Tue Sep 29 15:33:44 2020 kern.debug kernel: [60479.341370] =
ieee80211_send_nullfunc(false) from ieee80211_mgd_probe_ap_send, =
probe_send_count 1
Tue Sep 29 15:33:44 2020 kern.info kernel: [60479.350602] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Tue Sep 29 15:34:15 2020 kern.debug kernel: [60510.057408] =
probe_send_count++ 1
Tue Sep 29 15:34:15 2020 kern.debug kernel: [60510.060748] =
ieee80211_send_nullfunc(false) from ieee80211_mgd_probe_ap_send, =
probe_send_count 1
Tue Sep 29 15:34:15 2020 kern.info kernel: [60510.075731] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2

[STA kernel log]
[59996.019411] probe_send_count++ 1
[59996.022750] ieee80211_send_nullfunc(false) from =
ieee80211_mgd_probe_ap_send, probe_send_count 1
[59996.031966] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[60026.738838] probe_send_count++ 1
[60026.742181] ieee80211_send_nullfunc(false) from =
ieee80211_mgd_probe_ap_send, probe_send_count 1
[60026.751408] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[60059.506214] probe_send_count++ 1
[60059.509552] ieee80211_send_nullfunc(false) from =
ieee80211_mgd_probe_ap_send, probe_send_count 1
[60059.521346] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[60082.764451] wifi: deauthenticated from 60:38:e0:yy:yy:yy (Reason: =
16=3DGROUP_KEY_HANDSHAKE_TIMEOUT)
[60082.773803] br-lan: port 3(wifi) entered disabled state
[60082.779299] br-lan: topology change detected, propagating
[60083.747939] wifi: authenticate with 60:38:e0:yy:yy:yy
[60083.767269] wifi: send auth to 60:38:e0:yy:yy:yy (try 1/3)
[60083.808370] wifi: authenticated
[60083.813911] wifi: associate with 60:38:e0:yy:yy:yy (try 1/3)
[60083.838239] wifi: RX AssocResp from 60:38:e0:yy:yy:yy (capab=3D0x431 =
status=3D0 aid=3D1)
[60083.846402] wifi: associated
[60083.858846] br-lan: port 3(wifi) entered blocking state
[60083.864305] br-lan: port 3(wifi) entered listening state
[60085.873708] br-lan: port 3(wifi) entered learning state
[60087.889670] br-lan: port 3(wifi) entered forwarding state
[60087.895262] br-lan: topology change detected, sending tcn bpdu
[60114.801162] probe_send_count++ 1
[60114.804506] ieee80211_send_nullfunc(false) from =
ieee80211_mgd_probe_ap_send, probe_send_count 1
[60114.813722] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[60122.993006] br-lan: port 3(wifi) neighbor 7fff.60:38:e0:yy:yy:yz lost
[60122.999677] br-lan: topology change detected, propagating
[60147.568535] probe_send_count++ 1
[60147.571880] ieee80211_send_nullfunc(false) from =
ieee80211_mgd_probe_ap_send, probe_send_count 1
[60147.581094] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[60178.287944] probe_send_count++ 1
[60178.291284] ieee80211_send_nullfunc(false) from =
ieee80211_mgd_probe_ap_send, probe_send_count 1
[60178.306328] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[60209.007373] probe_send_count++ 1
[60209.010716] ieee80211_send_nullfunc(false) from =
ieee80211_mgd_probe_ap_send, probe_send_count 1
[60209.019935] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[60239.727155] probe_send_count++ 1
[60239.730497] ieee80211_send_nullfunc(false) from =
ieee80211_mgd_probe_ap_send, probe_send_count 1
[60239.739739] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[60272.494118] probe_send_count++ 1
[60272.497466] ieee80211_send_nullfunc(false) from =
ieee80211_mgd_probe_ap_send, probe_send_count 1
[60272.506680] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[60303.213517] probe_send_count++ 1
[60303.216860] ieee80211_send_nullfunc(false) from =
ieee80211_mgd_probe_ap_send, probe_send_count 1
[60303.226077] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[60333.932939] probe_send_count++ 1
[60333.936281] ieee80211_send_nullfunc(false) from =
ieee80211_mgd_probe_ap_send, probe_send_count 1
[60333.947000] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[60366.700269] probe_send_count++ 1
[60366.703610] ieee80211_send_nullfunc(false) from =
ieee80211_mgd_probe_ap_send, probe_send_count 1
[60366.712923] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[60383.727820] wifi: disassociated from 60:38:e0:yy:yy:yy (Reason: =
4=3DDISASSOC_DUE_TO_INACTIVITY)
[60383.737620] br-lan: port 3(wifi) entered disabled state
[60383.792996] wifi: authenticate with 60:38:e0:yy:yy:yy
[60383.812320] wifi: send auth to 60:38:e0:yy:yy:yy (try 1/3)
[60383.819596] wifi: authenticated
[60383.824009] wifi: associate with 60:38:e0:yy:yy:yy (try 1/3)
[60383.851498] wifi: RX AssocResp from 60:38:e0:yy:yy:yy (capab=3D0x431 =
status=3D0 aid=3D1)
[60383.859681] wifi: associated
[60383.872438] br-lan: port 3(wifi) entered blocking state
[60383.877894] br-lan: port 3(wifi) entered listening state
[60385.899887] br-lan: port 3(wifi) entered learning state
[60387.915843] br-lan: port 3(wifi) entered forwarding state
[60387.921434] br-lan: topology change detected, propagating
[60415.851325] probe_send_count++ 1
[60415.854666] ieee80211_send_nullfunc(false) from =
ieee80211_mgd_probe_ap_send, probe_send_count 1
[60415.864374] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[60448.618649] probe_send_count++ 1
[60448.621993] ieee80211_send_nullfunc(false) from =
ieee80211_mgd_probe_ap_send, probe_send_count 1
[60448.631213] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[60479.338025] probe_send_count++ 1
[60479.341370] ieee80211_send_nullfunc(false) from =
ieee80211_mgd_probe_ap_send, probe_send_count 1
[60479.350602] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[60510.057408] probe_send_count++ 1
[60510.060748] ieee80211_send_nullfunc(false) from =
ieee80211_mgd_probe_ap_send, probe_send_count 1
[60510.075731] wifi: --- ack  probe_send_count: 1  vif.type 2:2




> On 2020-09-29, at 3:13 PM, Felix Fietkau <nbd@nbd.name> wrote:
>=20
>=20
> On 2020-09-28 19:09, Georgi Valkov wrote:
>> Hi Felix!
>>=20
>> Unfortunately it disconnected again after 21 hours and 44 minutes of =
uptime, and remained offline for 5 minutes again.
>> I will add some code to ieee80211_sta_work() to trace more info when =
a disconnect occurs.
>> Do you have any ideas? Why does it remain offline for exactly 5 =
minutes every time? Do we need to reset probe_send_count in rx.c? Do we =
have to send probe requests or nullfunc while there is active =
communication, e.g. acknowledged ICMP traffic?
>>=20
>> This is the most common event in the trace, it occurs every 30 =
seconds, we called ieee80211_sta_tx_notify(ack: true), and =
ieee80211_is_any_nullfunc() returned true, so probe_send_count is reset:
>> --- ack  probe_send_count: 1  vif.type 2:2
>>=20
>> These events are rare, I could not find any pattern. probe_send_count =
is reset inside status.c
>> reset connection monitor  probe_send_count: 1  nullfunc: 0
>>=20
>> These events are rare and appear randomly. The first indicates that =
we called ieee80211_sta_tx_notify(ack: false), and =
ieee80211_is_any_nullfunc() returned true, so probe_send_count is not =
reset, while the second always appears 10ms later with ack =3D true, and =
ieee80211_is_any_nullfunc() returned true, so probe_send_count is reset.
>> probe_send_count: 1  vif.type 2:2
>> --- ack  probe_send_count: 2  vif.type 2:2
> So far I don't see any strong indication that these disconnects are
> related to this patch. The debug messages you added seem normal to me.
> More comments on the disconnects below.
>=20
>> Here are some interesting parts from the trace:
>>=20
>> [STA kernel log]
>> [55045.254528] wifi: --- ack  probe_send_count: 1  vif.type 2:2
>> [55075.971445] wifi: reset connection monitor  probe_send_count: 1  =
nullfunc: 0
>> [55106.699439] wifi: --- ack  probe_send_count: 1  vif.type 2:2
>> ...
>> [57812.177775] wifi: --- ack  probe_send_count: 1  vif.type 2:2
>> [57842.894483] wifi: reset connection monitor  probe_send_count: 1  =
nullfunc: 0
>> [57873.610852] wifi: --- ack  probe_send_count: 1  vif.type 2:2
>> ...
>> [78172.681502] wifi: --- ack  probe_send_count: 1  vif.type 2:2
>> [78203.398703] wifi: --- ack  probe_send_count: 1  vif.type 2:2
>> [78234.118347] wifi: --- ack  probe_send_count: 1  vif.type 2:2
>> [78264.834126] wifi: --- ack  probe_send_count: 1  vif.type 2:2
>> [78282.530133] wifi: deauthenticated from 60:38:e0:xx:xx:xx (Reason: =
16=3DGROUP_KEY_HANDSHAKE_TIMEOUT)
> This one is definitely not related to the connection monitor.
>=20
>> [78282.539463] br-lan: port 3(wifi) entered disabled state
>> [78282.544987] br-lan: topology change detected, propagating
>> [78283.514078] wifi: authenticate with 60:38:e0:xx:xx:xx
>> [78283.533405] wifi: send auth to 60:38:e0:xx:xx:xx (try 1/3)
>> [78283.577391] wifi: authenticated
>> [78283.583874] wifi: associate with 60:38:e0:xx:xx:xx (try 1/3)
>> [78283.610166] wifi: RX AssocResp from 60:38:e0:xx:xx:xx (capab=3D0x431=
 status=3D0 aid=3D1)
>> [78283.618322] wifi: associated
>> [78283.628908] br-lan: port 3(wifi) entered blocking state
>> [78283.634358] br-lan: port 3(wifi) entered listening state
>> [78285.663507] br-lan: port 3(wifi) entered learning state
>> [78287.679338] br-lan: port 3(wifi) entered forwarding state
>> [78287.684939] br-lan: topology change detected, sending tcn bpdu
>> [78313.981348] wifi: --- ack  probe_send_count: 1  vif.type 2:2
>> [78316.028959] br-lan: port 3(wifi) neighbor 7fff.60:38:e0:xx:xx:xy =
lost
>> [78316.035630] br-lan: topology change detected, propagating
>> [78346.746657] wifi: --- ack  probe_send_count: 1  vif.type 2:2
>> [78377.464074] wifi: --- ack  probe_send_count: 1  vif.type 2:2
>> [78408.181527] wifi: --- ack  probe_send_count: 1  vif.type 2:2
>> [78438.898977] wifi: --- ack  probe_send_count: 1  vif.type 2:2
>> [78471.664287] wifi: --- ack  probe_send_count: 1  vif.type 2:2
>> [78502.381794] wifi: --- ack  probe_send_count: 1  vif.type 2:2
>> [78533.099298] wifi: --- ack  probe_send_count: 1  vif.type 2:2
>> [78563.816824] wifi: --- ack  probe_send_count: 1  vif.type 2:2
>> [78583.518337] wifi: disassociated from 60:38:e0:xx:xx:xx (Reason: =
4=3DDISASSOC_DUE_TO_INACTIVITY)
> Are you sure that this one is even related to the connection monitor? =
It
> seems to me that the client may have been kicked from the AP due to
> inactivity (might be AP probing, not STA probing).
>=20
> - Felix

