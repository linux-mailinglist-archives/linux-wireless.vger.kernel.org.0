Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE59427B2BD
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Sep 2020 19:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgI1RJV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Sep 2020 13:09:21 -0400
Received: from pop31.abv.bg ([194.153.145.221]:51910 "EHLO pop31.abv.bg"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgI1RJV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Sep 2020 13:09:21 -0400
Received: from smtp.abv.bg (localhost [127.0.0.1])
        by pop31.abv.bg (Postfix) with ESMTP id 311AC1805C6A;
        Mon, 28 Sep 2020 20:09:12 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=abv.bg; s=smtp-out;
        t=1601312952; bh=jnPb2dVNlk18sIfmYA9PosvRXa4ktCHAxqFOYRrVfiw=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=j40xAnEtJC5A4Cs30XYzOoC1K+3N3GsGlpuJ9N/Z5eX5cYC2acOPt44PKjlwKpgNH
         Mn9qTwBDAMFwRZ4fcq7eEI2fYaXdqzdLayyUj69b3InvwocYf4QXGmgizd1WPZvPYg
         xP/ZiKfa7jRAVtRwS/FldfoIw+7wdfVyQOz0/MAc=
X-HELO: [192.168.192.3]
Authentication-Results: smtp.abv.bg; auth=pass (plain) smtp.auth=gvalkov@abv.bg
Received: from Unknown (HELO [192.168.192.3]) (87.118.177.198)
 by smtp.abv.bg (qpsmtpd/0.96) with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted); Mon, 28 Sep 2020 20:09:12 +0300
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v3] mac80211: fix regression in sta connection monitor
From:   Georgi Valkov <gvalkov@abv.bg>
In-Reply-To: <4ED2AADF-092B-424E-A5B5-C2A371C88A92@abv.bg>
Date:   Mon, 28 Sep 2020 20:09:09 +0300
Cc:     linux-wireless@vger.kernel.org, johannes@sipsolutions.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <FC3CA053-0DB9-41B9-AEC6-0AE189AEFE17@abv.bg>
References: <20200927105605.97954-1-nbd@nbd.name>
 <4ED2AADF-092B-424E-A5B5-C2A371C88A92@abv.bg>
To:     Felix Fietkau <nbd@nbd.name>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Felix!

Unfortunately it disconnected again after 21 hours and 44 minutes of =
uptime, and remained offline for 5 minutes again.
I will add some code to ieee80211_sta_work() to trace more info when a =
disconnect occurs.
Do you have any ideas? Why does it remain offline for exactly 5 minutes =
every time? Do we need to reset probe_send_count in rx.c? Do we have to =
send probe requests or nullfunc while there is active communication, =
e.g. acknowledged ICMP traffic?

This is the most common event in the trace, it occurs every 30 seconds, =
we called ieee80211_sta_tx_notify(ack: true), and =
ieee80211_is_any_nullfunc() returned true, so probe_send_count is reset:
--- ack  probe_send_count: 1  vif.type 2:2

These events are rare, I could not find any pattern. probe_send_count is =
reset inside status.c
reset connection monitor  probe_send_count: 1  nullfunc: 0

These events are rare and appear randomly. The first indicates that we =
called ieee80211_sta_tx_notify(ack: false), and =
ieee80211_is_any_nullfunc() returned true, so probe_send_count is not =
reset, while the second always appears 10ms later with ack =3D true, and =
ieee80211_is_any_nullfunc() returned true, so probe_send_count is reset.
probe_send_count: 1  vif.type 2:2
--- ack  probe_send_count: 2  vif.type 2:2

Here are some interesting parts from the trace:

[STA kernel log]
[55045.254528] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[55075.971445] wifi: reset connection monitor  probe_send_count: 1  =
nullfunc: 0
[55106.699439] wifi: --- ack  probe_send_count: 1  vif.type 2:2
...
[57812.177775] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[57842.894483] wifi: reset connection monitor  probe_send_count: 1  =
nullfunc: 0
[57873.610852] wifi: --- ack  probe_send_count: 1  vif.type 2:2
...
[78172.681502] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[78203.398703] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[78234.118347] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[78264.834126] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[78282.530133] wifi: deauthenticated from 60:38:e0:xx:xx:xx (Reason: =
16=3DGROUP_KEY_HANDSHAKE_TIMEOUT)
[78282.539463] br-lan: port 3(wifi) entered disabled state
[78282.544987] br-lan: topology change detected, propagating
[78283.514078] wifi: authenticate with 60:38:e0:xx:xx:xx
[78283.533405] wifi: send auth to 60:38:e0:xx:xx:xx (try 1/3)
[78283.577391] wifi: authenticated
[78283.583874] wifi: associate with 60:38:e0:xx:xx:xx (try 1/3)
[78283.610166] wifi: RX AssocResp from 60:38:e0:xx:xx:xx (capab=3D0x431 =
status=3D0 aid=3D1)
[78283.618322] wifi: associated
[78283.628908] br-lan: port 3(wifi) entered blocking state
[78283.634358] br-lan: port 3(wifi) entered listening state
[78285.663507] br-lan: port 3(wifi) entered learning state
[78287.679338] br-lan: port 3(wifi) entered forwarding state
[78287.684939] br-lan: topology change detected, sending tcn bpdu
[78313.981348] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[78316.028959] br-lan: port 3(wifi) neighbor 7fff.60:38:e0:xx:xx:xy lost
[78316.035630] br-lan: topology change detected, propagating
[78346.746657] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[78377.464074] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[78408.181527] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[78438.898977] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[78471.664287] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[78502.381794] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[78533.099298] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[78563.816824] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[78583.518337] wifi: disassociated from 60:38:e0:xx:xx:xx (Reason: =
4=3DDISASSOC_DUE_TO_INACTIVITY)
[78583.527312] br-lan: port 3(wifi) entered disabled state
[78583.584070] wifi: authenticate with 60:38:e0:xx:xx:xx
[78583.603408] wifi: send auth to 60:38:e0:xx:xx:xx (try 1/3)
[78583.610306] wifi: authenticated
[78583.615079] wifi: associate with 60:38:e0:xx:xx:xx (try 1/3)
[78583.642902] wifi: RX AssocResp from 60:38:e0:xx:xx:xx (capab=3D0x431 =
status=3D0 aid=3D1)
[78583.651100] wifi: associated
[78583.662922] br-lan: port 3(wifi) entered blocking state
[78583.668372] br-lan: port 3(wifi) entered listening state
[78585.702846] br-lan: port 3(wifi) entered learning state
[78587.718684] br-lan: port 3(wifi) entered forwarding state
[78587.724275] br-lan: topology change detected, sending tcn bpdu
[78615.014679] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[78647.778120] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[78680.543528] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[78711.261101] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[78741.978703] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[78774.744145] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[78807.510701] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[78838.229555] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[78868.945609] wifi: --- ack  probe_send_count: 1  vif.type 2:2
...
[85414.017928] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[85444.736816] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[85475.456436] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[85508.224997] wifi: probe_send_count: 1  vif.type 2:2
[85508.230895] wifi: --- ack  probe_send_count: 2  vif.type 2:2
[85538.941413] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[85569.662128] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[85600.385660] wifi: probe_send_count: 1  vif.type 2:2
[85600.391453] wifi: --- ack  probe_send_count: 2  vif.type 2:2
[85633.146166] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[85663.864942] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[85694.583857] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[85727.350693] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[85758.069606] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[85788.795989] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[85819.507449] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[85852.274294] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[85882.993213] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[85913.713628] wifi: probe_send_count: 1  vif.type 2:2
[85913.719119] wifi: --- ack  probe_send_count: 2  vif.type 2:2
[85944.431087] wifi: --- ack  probe_send_count: 1  vif.type 2:2
[85977.197935] wifi: --- ack  probe_send_count: 1  vif.type 2:2

[STA system log]
Mon Sep 28 15:24:37 2020 kern.info kernel: [78109.201208] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:25:08 2020 kern.info kernel: [78139.916198] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:25:41 2020 kern.info kernel: [78172.681502] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:26:12 2020 kern.info kernel: [78203.398703] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:26:42 2020 kern.info kernel: [78234.118347] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:27:13 2020 kern.info kernel: [78264.834126] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:27:27 2020 daemon.notice wpa_supplicant[1436]: wifi: WPA: =
Group rekeying completed with 60:38:e0:xx:xx:xx [GTK=3DCCMP]
Mon Sep 28 15:27:31 2020 kern.info kernel: [78282.530133] wifi: =
deauthenticated from 60:38:e0:xx:xx:xx (Reason: =
16=3DGROUP_KEY_HANDSHAKE_TIMEOUT)
Mon Sep 28 15:27:31 2020 kern.info kernel: [78282.539463] br-lan: port =
3(wifi) entered disabled state
Mon Sep 28 15:27:31 2020 kern.info kernel: [78282.544987] br-lan: =
topology change detected, propagating
Mon Sep 28 15:27:31 2020 daemon.notice netifd: Network device 'wifi' =
link is down
Mon Sep 28 15:27:31 2020 daemon.notice wpa_supplicant[1436]: wifi: =
CTRL-EVENT-DISCONNECTED bssid=3D60:38:e0:xx:xx:xx reason=3D16
Mon Sep 28 15:27:32 2020 daemon.notice wpa_supplicant[1436]: wifi: SME: =
Trying to authenticate with 60:38:e0:xx:xx:xx (SSID=3D'wifi' freq=3D2432 =
MHz)
Mon Sep 28 15:27:32 2020 kern.info kernel: [78283.514078] wifi: =
authenticate with 60:38:e0:xx:xx:xx
Mon Sep 28 15:27:32 2020 kern.info kernel: [78283.533405] wifi: send =
auth to 60:38:e0:xx:xx:xx (try 1/3)
Mon Sep 28 15:27:32 2020 daemon.notice wpa_supplicant[1436]: wifi: =
Trying to associate with 60:38:e0:xx:xx:xx (SSID=3D'wifi' freq=3D2432 =
MHz)
Mon Sep 28 15:27:32 2020 kern.info kernel: [78283.577391] wifi: =
authenticated
Mon Sep 28 15:27:32 2020 kern.info kernel: [78283.583874] wifi: =
associate with 60:38:e0:xx:xx:xx (try 1/3)
Mon Sep 28 15:27:32 2020 kern.info kernel: [78283.610166] wifi: RX =
AssocResp from 60:38:e0:xx:xx:xx (capab=3D0x431 status=3D0 aid=3D1)
Mon Sep 28 15:27:32 2020 kern.info kernel: [78283.618322] wifi: =
associated
Mon Sep 28 15:27:32 2020 daemon.notice wpa_supplicant[1436]: wifi: =
Associated with 60:38:e0:xx:xx:xx
Mon Sep 28 15:27:32 2020 daemon.notice wpa_supplicant[1436]: wifi: =
CTRL-EVENT-SUBNET-STATUS-UPDATE status=3D0
Mon Sep 28 15:27:32 2020 daemon.notice netifd: Network device 'wifi' =
link is up
Mon Sep 28 15:27:32 2020 daemon.notice wpa_supplicant[1436]: wifi: WPA: =
Key negotiation completed with 60:38:e0:xx:xx:xx [PTK=3DCCMP GTK=3DCCMP]
Mon Sep 28 15:27:32 2020 daemon.notice wpa_supplicant[1436]: wifi: =
CTRL-EVENT-CONNECTED - Connection to 60:38:e0:xx:xx:xx completed [id=3D0 =
id_str=3D]
Mon Sep 28 15:27:32 2020 kern.info kernel: [78283.628908] br-lan: port =
3(wifi) entered blocking state
Mon Sep 28 15:27:32 2020 kern.info kernel: [78283.634358] br-lan: port =
3(wifi) entered listening state
Mon Sep 28 15:27:34 2020 kern.info kernel: [78285.663507] br-lan: port =
3(wifi) entered learning state
Mon Sep 28 15:27:36 2020 kern.info kernel: [78287.679338] br-lan: port =
3(wifi) entered forwarding state
Mon Sep 28 15:27:36 2020 kern.info kernel: [78287.684939] br-lan: =
topology change detected, sending tcn bpdu
Mon Sep 28 15:28:02 2020 kern.info kernel: [78313.981348] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:28:04 2020 kern.info kernel: [78316.028959] br-lan: port =
3(wifi) neighbor 7fff.60:38:e0:xx:xx:xy lost
Mon Sep 28 15:28:04 2020 kern.info kernel: [78316.035630] br-lan: =
topology change detected, propagating
Mon Sep 28 15:28:35 2020 kern.info kernel: [78346.746657] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:29:06 2020 kern.info kernel: [78377.464074] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:29:36 2020 kern.info kernel: [78408.181527] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:30:07 2020 kern.info kernel: [78438.898977] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:30:40 2020 kern.info kernel: [78471.664287] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:31:11 2020 kern.info kernel: [78502.381794] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:31:41 2020 kern.info kernel: [78533.099298] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:32:12 2020 kern.info kernel: [78563.816824] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:32:32 2020 kern.info kernel: [78583.518337] wifi: =
disassociated from 60:38:e0:xx:xx:xx (Reason: =
4=3DDISASSOC_DUE_TO_INACTIVITY)
Mon Sep 28 15:32:32 2020 kern.info kernel: [78583.527312] br-lan: port =
3(wifi) entered disabled state
Mon Sep 28 15:32:32 2020 daemon.notice netifd: Network device 'wifi' =
link is down
Mon Sep 28 15:32:32 2020 daemon.notice wpa_supplicant[1436]: wifi: =
CTRL-EVENT-DISCONNECTED bssid=3D60:38:e0:xx:xx:xx reason=3D4
Mon Sep 28 15:32:32 2020 daemon.notice wpa_supplicant[1436]: wifi: SME: =
Trying to authenticate with 60:38:e0:xx:xx:xx (SSID=3D'wifi' freq=3D2432 =
MHz)
Mon Sep 28 15:32:32 2020 kern.info kernel: [78583.584070] wifi: =
authenticate with 60:38:e0:xx:xx:xx
Mon Sep 28 15:32:32 2020 kern.info kernel: [78583.603408] wifi: send =
auth to 60:38:e0:xx:xx:xx (try 1/3)
Mon Sep 28 15:32:32 2020 kern.info kernel: [78583.610306] wifi: =
authenticated
Mon Sep 28 15:32:32 2020 daemon.notice wpa_supplicant[1436]: wifi: =
Trying to associate with 60:38:e0:xx:xx:xx (SSID=3D'wifi' freq=3D2432 =
MHz)
Mon Sep 28 15:32:32 2020 kern.info kernel: [78583.615079] wifi: =
associate with 60:38:e0:xx:xx:xx (try 1/3)
Mon Sep 28 15:32:32 2020 kern.info kernel: [78583.642902] wifi: RX =
AssocResp from 60:38:e0:xx:xx:xx (capab=3D0x431 status=3D0 aid=3D1)
Mon Sep 28 15:32:32 2020 kern.info kernel: [78583.651100] wifi: =
associated
Mon Sep 28 15:32:32 2020 daemon.notice netifd: Network device 'wifi' =
link is up
Mon Sep 28 15:32:32 2020 daemon.notice wpa_supplicant[1436]: wifi: =
Associated with 60:38:e0:xx:xx:xx
Mon Sep 28 15:32:32 2020 daemon.notice wpa_supplicant[1436]: wifi: =
CTRL-EVENT-SUBNET-STATUS-UPDATE status=3D0
Mon Sep 28 15:32:32 2020 daemon.notice wpa_supplicant[1436]: wifi: WPA: =
Key negotiation completed with 60:38:e0:xx:xx:xx [PTK=3DCCMP GTK=3DCCMP]
Mon Sep 28 15:32:32 2020 daemon.notice wpa_supplicant[1436]: wifi: =
CTRL-EVENT-CONNECTED - Connection to 60:38:e0:xx:xx:xx completed [id=3D0 =
id_str=3D]
Mon Sep 28 15:32:32 2020 kern.info kernel: [78583.662922] br-lan: port =
3(wifi) entered blocking state
Mon Sep 28 15:32:32 2020 kern.info kernel: [78583.668372] br-lan: port =
3(wifi) entered listening state
Mon Sep 28 15:32:34 2020 kern.info kernel: [78585.702846] br-lan: port =
3(wifi) entered learning state
Mon Sep 28 15:32:36 2020 kern.info kernel: [78587.718684] br-lan: port =
3(wifi) entered forwarding state
Mon Sep 28 15:32:36 2020 kern.info kernel: [78587.724275] br-lan: =
topology change detected, sending tcn bpdu
Mon Sep 28 15:33:03 2020 kern.info kernel: [78615.014679] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:33:36 2020 kern.info kernel: [78647.778120] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:34:09 2020 kern.info kernel: [78680.543528] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:34:40 2020 kern.info kernel: [78711.261101] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:35:10 2020 kern.info kernel: [78741.978703] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:35:43 2020 kern.info kernel: [78774.744145] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:36:16 2020 kern.info kernel: [78807.510701] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:36:47 2020 kern.info kernel: [78838.229555] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:37:17 2020 kern.info kernel: [78868.945609] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:37:50 2020 kern.info kernel: [78901.710407] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:38:23 2020 kern.info kernel: [78934.475985] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:38:54 2020 kern.info kernel: [78965.193562] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:39:24 2020 kern.info kernel: [78995.923202] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:39:57 2020 kern.info kernel: [79028.676806] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:40:28 2020 kern.info kernel: [79059.394517] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:40:58 2020 kern.info kernel: [79090.112246] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:41:29 2020 kern.info kernel: [79120.830012] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:42:02 2020 kern.info kernel: [79153.596715] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:42:33 2020 kern.info kernel: [79184.313338] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:43:03 2020 kern.info kernel: [79215.031325] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:43:34 2020 kern.info kernel: [79245.748885] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:44:00 2020 daemon.notice wpa_supplicant[1436]: wifi: =
CTRL-EVENT-BEACON-LOSS
Mon Sep 28 15:44:00 2020 kern.info kernel: [79271.699067] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:44:02 2020 daemon.notice wpa_supplicant[1436]: wifi: =
CTRL-EVENT-BEACON-LOSS
Mon Sep 28 15:44:02 2020 kern.info kernel: [79273.714936] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:44:03 2020 daemon.notice wpa_supplicant[1436]: wifi: =
CTRL-EVENT-BEACON-LOSS
Mon Sep 28 15:44:03 2020 kern.info kernel: [79274.707777] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:44:09 2020 daemon.notice wpa_supplicant[1436]: wifi: =
CTRL-EVENT-BEACON-LOSS
Mon Sep 28 15:44:09 2020 kern.info kernel: [79280.692306] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2
Mon Sep 28 15:44:10 2020 daemon.notice wpa_supplicant[1436]: wifi: =
CTRL-EVENT-BEACON-LOSS
Mon Sep 28 15:44:10 2020 kern.info kernel: [79281.715611] wifi: --- ack  =
probe_send_count: 1  vif.type 2:2


Good luck!

Georgi



> On 2020-09-27, at 6:10 PM, Georgi Valkov <gvalkov@abv.bg> wrote:
>=20
> Hi Felix!
>=20
> Here are some interesting tracing results based on v2. My tracing code =
is below.
> The only printed output comes from this line, so it looks like the =
other places were I added tracing were never executed.
> [11428.907823] wifi: reset connection monitor  probe_send_count: 1  =
nullfunc: 0
> [11459.636346] wifi: reset connection monitor  probe_send_count: 1  =
nullfunc: 0
> [11490.367121] wifi: reset connection monitor  probe_send_count: 1  =
nullfunc: 0
> [11523.141354] wifi: reset connection monitor  probe_send_count: 1  =
nullfunc: 0
> [11555.917399] wifi: reset connection monitor  probe_send_count: 1  =
nullfunc: 0
> [11586.644909] wifi: reset connection monitor  probe_send_count: 1  =
nullfunc: 0
> [11617.375977] wifi: reset connection monitor  probe_send_count: 1  =
nullfunc: 0
> [11650.147750] wifi: reset connection monitor  probe_send_count: 1  =
nullfunc: 0
> [11682.923378] wifi: reset connection monitor  probe_send_count: 1  =
nullfunc: 0
> [11713.649688] wifi: reset connection monitor  probe_send_count: 1  =
nullfunc: 0
> [11744.376130] wifi: reset connection monitor  probe_send_count: 1  =
nullfunc: 0
> [11777.150797] wifi: reset connection monitor  probe_send_count: 1  =
nullfunc: 0
>=20
> I just started testing v3, and so far it looks like this, but we need =
to wait and see if there will be any disconnect events:
> I wonder why we experience an increase in probe_send_count every 130 =
seconds?
> [  105.489078] wifi: --- ack  probe_send_count: 1  vif.type 2:2
> [  136.204809] wifi: --- ack  probe_send_count: 1  vif.type 2:2
> [  166.924520] wifi: --- ack  probe_send_count: 1  vif.type 2:2
> [  199.690445] wifi: --- ack  probe_send_count: 1  vif.type 2:2
> [  230.401303] wifi: --- ack  probe_send_count: 1  vif.type 2:2
> [  261.110496] wifi: --- ack  probe_send_count: 1  vif.type 2:2
> [  293.869304] wifi: --- ack  probe_send_count: 1  vif.type 2:2
> [  324.580664] wifi: --- ack  probe_send_count: 1  vif.type 2:2
> [  355.291914] wifi: --- ack  probe_send_count: 1  vif.type 2:2
> [  386.002786] wifi: --- ack  probe_send_count: 1  vif.type 2:2
> [  418.762544] wifi: --- ack  probe_send_count: 1  vif.type 2:2
> [  449.473091] wifi: --- ack  probe_send_count: 1  vif.type 2:2
> [  480.186644] wifi: --- ack  probe_send_count: 1  vif.type 2:2
> [  512.941192] wifi: reset connection monitor  probe_send_count: 1  =
nullfunc: 0
> [  545.700283] wifi: --- ack  probe_send_count: 1  vif.type 2:2
> [  576.409210] wifi: --- ack  probe_send_count: 1  vif.type 2:2
> [  607.119928] wifi: --- ack  probe_send_count: 1  vif.type 2:2
> [  639.877866] wifi: --- ack  probe_send_count: 1  vif.type 2:2
> [  670.588159] wifi: --- ack  probe_send_count: 1  vif.type 2:2
> [  701.298701] wifi: --- ack  probe_send_count: 1  vif.type 2:2
>=20
>=20
> // patch.v2 + tracing
> Index: backports-5.8-1/net/mac80211/status.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- backports-5.8-1.orig/net/mac80211/status.c
> +++ backports-5.8-1/net/mac80211/status.c
> @@ -1129,6 +1129,8 @@ void ieee80211_tx_status_ext(struct ieee
> 	noack_success =3D !!(info->flags & =
IEEE80211_TX_STAT_NOACK_TRANSMITTED);
>=20
> 	if (pubsta) {
> +		struct ieee80211_sub_if_data *sdata =3D sta->sdata;
> +
> 		if (!acked && !noack_success)
> 			sta->status_stats.retry_failed++;
> 		sta->status_stats.retry_count +=3D retry_count;
> @@ -1143,6 +1145,31 @@ void ieee80211_tx_status_ext(struct ieee
> 				/* Track when last packet was ACKed */
> 				sta->status_stats.last_pkt_time =3D =
jiffies;
>=20
> +				/* Reset connection monitor */
> +				if (sdata->vif.type =3D=3D =
NL80211_IFTYPE_STATION &&
> +				    =
unlikely(sdata->u.mgd.probe_send_count > 0)) {
> +					struct ieee80211_hdr * hdr =3D =
(struct ieee80211_hdr *)sdata;
> +
> +					sdata_info(
> +						sdata,
> +						"reset connection =
monitor  probe_send_count: %u  nullfunc: %u\n",
> +						=
sdata->u.mgd.probe_send_count,
> +						=
ieee80211_is_any_nullfunc(hdr->frame_control)
> +					);
> +
> +					sdata->u.mgd.probe_send_count =3D =
0;
> +					ieee80211_queue_work(&local->hw, =
&sdata->work);
> +				}
> +
> +				if (sdata->u.mgd.probe_send_count > 0)
> +				{
> +					sdata_info(
> +						sdata,
> +						"!!!  probe_send_count: =
%u\n",
> +						=
sdata->u.mgd.probe_send_count
> +					);
> +				}
> +
> 				if (info->status.is_valid_ack_signal) {
> 					=
sta->status_stats.last_ack_signal =3D
> 							 =
(s8)info->status.ack_signal;
> Index: backports-5.8-1/net/mac80211/mlme.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- backports-5.8-1.orig/net/mac80211/mlme.c
> +++ backports-5.8-1/net/mac80211/mlme.c
> @@ -2505,13 +2505,46 @@ void ieee80211_sta_tx_notify(struct ieee
> 	ieee80211_sta_tx_wmm_ac_notify(sdata, hdr, tx_time);
>=20
> 	if (!ieee80211_is_any_nullfunc(hdr->frame_control) ||
> -	    !sdata->u.mgd.probe_send_count)
> +		!sdata->u.mgd.probe_send_count)
> +	{
> +		if (ack && sdata->u.mgd.probe_send_count)
> +		{
> +			sdata_info(
> +				sdata,
> +				"+++ ack  probe_send_count: %u  =
nullfunc_failed %u  vif.type %u:%u\n",
> +				sdata->u.mgd.probe_send_count,
> +				sdata->u.mgd.nullfunc_failed,
> +				sdata->vif.type,
> +				NL80211_IFTYPE_STATION
> +			);
> +		}
> +
> 		return;
> +	}
>=20
> 	if (ack)
> +	{
> +		sdata_info(
> +			sdata,
> +			"--- ack  probe_send_count: %u  vif.type =
%u:%u\n",
> +			sdata->u.mgd.probe_send_count,
> +			sdata->vif.type,
> +			NL80211_IFTYPE_STATION
> +		);
> 		sdata->u.mgd.probe_send_count =3D 0;
> +	}
> 	else
> +	{
> +		sdata_info(
> +			sdata,
> +			"probe_send_count: %u  vif.type %u:%u\n",
> +			sdata->u.mgd.probe_send_count,
> +			sdata->vif.type,
> +			NL80211_IFTYPE_STATION
> +		);
> 		sdata->u.mgd.nullfunc_failed =3D true;
> +	}
> +
> 	ieee80211_queue_work(&sdata->local->hw, &sdata->work);
> }
>=20
>=20
>=20
> // 333-trace.patch for v3
> Index: backports-5.8-1/net/mac80211/mlme.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- backports-5.8-1.orig/net/mac80211/mlme.c
> +++ backports-5.8-1/net/mac80211/mlme.c
> @@ -2505,13 +2505,46 @@ void ieee80211_sta_tx_notify(struct ieee
> 	ieee80211_sta_tx_wmm_ac_notify(sdata, hdr, tx_time);
>=20
> 	if (!ieee80211_is_any_nullfunc(hdr->frame_control) ||
> -	    !sdata->u.mgd.probe_send_count)
> +		!sdata->u.mgd.probe_send_count)
> +	{
> +		if (ack && sdata->u.mgd.probe_send_count)
> +		{
> +			sdata_info(
> +				sdata,
> +				"+++ ack  probe_send_count: %u  =
nullfunc_failed %u  vif.type %u:%u\n",
> +				sdata->u.mgd.probe_send_count,
> +				sdata->u.mgd.nullfunc_failed,
> +				sdata->vif.type,
> +				NL80211_IFTYPE_STATION
> +			);
> +		}
> +
> 		return;
> +	}
>=20
> 	if (ack)
> +	{
> +		sdata_info(
> +			sdata,
> +			"--- ack  probe_send_count: %u  vif.type =
%u:%u\n",
> +			sdata->u.mgd.probe_send_count,
> +			sdata->vif.type,
> +			NL80211_IFTYPE_STATION
> +		);
> 		sdata->u.mgd.probe_send_count =3D 0;
> +	}
> 	else
> +	{
> +		sdata_info(
> +			sdata,
> +			"probe_send_count: %u  vif.type %u:%u\n",
> +			sdata->u.mgd.probe_send_count,
> +			sdata->vif.type,
> +			NL80211_IFTYPE_STATION
> +		);
> 		sdata->u.mgd.nullfunc_failed =3D true;
> +	}
> +
> 	ieee80211_queue_work(&sdata->local->hw, &sdata->work);
> }
>=20
> Index: backports-5.8-1/net/mac80211/status.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- backports-5.8-1.orig/net/mac80211/status.c
> +++ backports-5.8-1/net/mac80211/status.c
> @@ -1148,8 +1148,28 @@ void ieee80211_tx_status_ext(struct ieee
>=20
> 				/* Reset connection monitor */
> 				if (sdata->vif.type =3D=3D =
NL80211_IFTYPE_STATION &&
> -				    =
unlikely(sdata->u.mgd.probe_send_count > 0))
> +					=
unlikely(sdata->u.mgd.probe_send_count > 0))
> +				{
> +					struct ieee80211_hdr * hdr =3D =
(struct ieee80211_hdr *)sdata;
> +
> +					sdata_info(
> +						sdata,
> +						"reset connection =
monitor  probe_send_count: %u  nullfunc: %u\n",
> +						=
sdata->u.mgd.probe_send_count,
> +						=
ieee80211_is_any_nullfunc(hdr->frame_control)
> +					);
> +
> 					sdata->u.mgd.probe_send_count =3D =
0;
> +				}
> +
> +				if (sdata->u.mgd.probe_send_count > 0)
> +				{
> +					sdata_info(
> +						sdata,
> +						"!!!  probe_send_count: =
%u\n",
> +						=
sdata->u.mgd.probe_send_count
> +					);
> +				}
>=20
> 				if (info->status.is_valid_ack_signal) {
> 					=
sta->status_stats.last_ack_signal =3D
>=20
>=20
>=20
>> On 2020-09-27, at 1:56 PM, Felix Fietkau <nbd@nbd.name> wrote:
>>=20
>> When a frame was acked and probe frames were sent, the connection =
monitoring
>> needs to be reset, otherwise it will keep probing until the =
connection is
>> considered dead, even though frames have been acked in the mean time.
>>=20
>> Fixes: 9abf4e49830d ("mac80211: optimize station connection monitor")
>> Reported-by: Georgi Valkov <gvalkov@abv.bg>
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> ---
>> v3: only queue work on nullfunc frames status
>> v2: reset connection monitor when a frame was acked (not just for =
nulldata)
>>=20
>> net/mac80211/mlme.c   |  4 +++-
>> net/mac80211/status.c | 16 ++++++++++++----
>> 2 files changed, 15 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
>> index 50a9b9025725..7c04d8e30482 100644
>> --- a/net/mac80211/mlme.c
>> +++ b/net/mac80211/mlme.c
>> @@ -2508,7 +2508,9 @@ void ieee80211_sta_tx_notify(struct =
ieee80211_sub_if_data *sdata,
>> 	    !sdata->u.mgd.probe_send_count)
>> 		return;
>>=20
>> -	if (!ack)
>> +	if (ack)
>> +		sdata->u.mgd.probe_send_count =3D 0;
>> +	else
>> 		sdata->u.mgd.nullfunc_failed =3D true;
>> 	ieee80211_queue_work(&sdata->local->hw, &sdata->work);
>> }
>> diff --git a/net/mac80211/status.c b/net/mac80211/status.c
>> index 7fe5bececfd9..88a736f3c413 100644
>> --- a/net/mac80211/status.c
>> +++ b/net/mac80211/status.c
>> @@ -982,10 +982,6 @@ static void __ieee80211_tx_status(struct =
ieee80211_hw *hw,
>> 		if (!(info->flags & IEEE80211_TX_CTL_INJECTED) && acked)
>> 			ieee80211_frame_acked(sta, skb);
>>=20
>> -		if ((sta->sdata->vif.type =3D=3D NL80211_IFTYPE_STATION) =
&&
>> -		    ieee80211_hw_check(&local->hw, =
REPORTS_TX_ACK_STATUS))
>> -			ieee80211_sta_tx_notify(sta->sdata, (void *) =
skb->data,
>> -						acked, =
info->status.tx_time);
>> 	}
>>=20
>> 	/* SNMP counters
>> @@ -1120,11 +1116,18 @@ void ieee80211_tx_status_ext(struct =
ieee80211_hw *hw,
>> 	noack_success =3D !!(info->flags & =
IEEE80211_TX_STAT_NOACK_TRANSMITTED);
>>=20
>> 	if (pubsta) {
>> +		struct ieee80211_sub_if_data *sdata =3D sta->sdata;
>> +
>> 		if (!acked && !noack_success)
>> 			sta->status_stats.retry_failed++;
>> 		sta->status_stats.retry_count +=3D retry_count;
>>=20
>> 		if (ieee80211_hw_check(&local->hw, =
REPORTS_TX_ACK_STATUS)) {
>> +			if (sdata->vif.type =3D=3D =
NL80211_IFTYPE_STATION &&
>> +			    skb && !(info->flags & =
IEEE80211_TX_CTL_HW_80211_ENCAP))
>> +				ieee80211_sta_tx_notify(sdata, (void *) =
skb->data,
>> +							acked, =
info->status.tx_time);
>> +
>> 			if (acked) {
>> 				sta->status_stats.last_ack =3D jiffies;
>>=20
>> @@ -1134,6 +1137,11 @@ void ieee80211_tx_status_ext(struct =
ieee80211_hw *hw,
>> 				/* Track when last packet was ACKed */
>> 				sta->status_stats.last_pkt_time =3D =
jiffies;
>>=20
>> +				/* Reset connection monitor */
>> +				if (sdata->vif.type =3D=3D =
NL80211_IFTYPE_STATION &&
>> +				    =
unlikely(sdata->u.mgd.probe_send_count > 0))
>> +					sdata->u.mgd.probe_send_count =3D =
0;
>> +
>> 				if (info->status.is_valid_ack_signal) {
>> 					=
sta->status_stats.last_ack_signal =3D
>> 							 =
(s8)info->status.ack_signal;
>> --=20
>> 2.28.0
>>=20
>>=20
>=20
>=20

