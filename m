Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6931273C19
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 09:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbgIVHhW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Sep 2020 03:37:22 -0400
Received: from pop31.abv.bg ([194.153.145.221]:41938 "EHLO pop31.abv.bg"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729894AbgIVHhV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Sep 2020 03:37:21 -0400
X-Greylist: delayed 492 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Sep 2020 03:37:17 EDT
Received: from smtp.abv.bg (localhost [127.0.0.1])
        by pop31.abv.bg (Postfix) with ESMTP id B28451805C67;
        Tue, 22 Sep 2020 10:29:00 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=abv.bg; s=smtp-out;
        t=1600759740; bh=ViyQKKWE46ii+jE2nNO5BhQF6BrVzumsoI+jHHuoP1I=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=dg90eGMnGCialT5NDmqbWqwL+nRMJgyJ0F9fFRjU3xe5X9MAhxerqta5aBR2Mew8f
         AZJiQqhN+J4t7nofHURwisUygQJ8djmjWHqwvRAv/tM/mEILPFAj4xw7b02MIZ8nVO
         Np94x1VUbzCRVUXKvZ4sInmtK/3jMqbSTZ3BvRlg=
X-HELO: [192.168.192.3]
Authentication-Results: smtp.abv.bg; auth=pass (plain) smtp.auth=gvalkov@abv.bg
Received: from Unknown (HELO [192.168.192.3]) (87.118.177.198)
 by smtp.abv.bg (qpsmtpd/0.96) with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted); Tue, 22 Sep 2020 10:29:00 +0300
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] mac80211: fix regression in sta connection monitor
From:   Georgi Valkov <gvalkov@abv.bg>
In-Reply-To: <20200921154545.91971-1-nbd@nbd.name>
Date:   Tue, 22 Sep 2020 10:28:57 +0300
Cc:     linux-wireless@vger.kernel.org, johannes@sipsolutions.net,
        openwrt-devel@lists.openwrt.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7A099B27-5278-4D2A-91A1-6B795CB0E221@abv.bg>
References: <20200921154545.91971-1-nbd@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Felix!

In the original code before the regression, as well as in the fix I =
proposed, probe_send_count was always reset if ack is true, while in =
your fix it will not be reset when non-null frames are received. The =
connection failed again after 10 hours and the STA remained offline for =
two minutes instead of two seconds. I should also note that I spent =
multiple days testing the fix I proposed and I had no disconnects. =
Please revise your fix again!


// my fix
void ieee80211_sta_tx_notify(struct ieee80211_sub_if_data *sdata,
			     struct ieee80211_hdr *hdr, bool ack, u16 =
tx_time)
{
	ieee80211_sta_tx_wmm_ac_notify(sdata, hdr, tx_time);

	if (ieee80211_is_any_nullfunc(hdr->frame_control) &&
	    sdata->u.mgd.probe_send_count > 0) {
		if (ack)
			sdata->u.mgd.probe_send_count =3D 0;
		else
			sdata->u.mgd.nullfunc_failed =3D true;
		ieee80211_queue_work(&sdata->local->hw, &sdata->work);
		return;
	}

	if (ack)
		sdata->u.mgd.probe_send_count =3D 0;
}


// commit 1c6d45644a54e50b6445bbc63eff1ae34b2f1e2e
void ieee80211_sta_tx_notify(struct ieee80211_sub_if_data *sdata,
			     struct ieee80211_hdr *hdr, bool ack, u16 =
tx_time)
{
	ieee80211_sta_tx_wmm_ac_notify(sdata, hdr, tx_time);

	if (!ieee80211_is_any_nullfunc(hdr->frame_control) ||
	    !sdata->u.mgd.probe_send_count)
		return;

	if (ack)
		sdata->u.mgd.probe_send_count =3D 0;
	else
		sdata->u.mgd.nullfunc_failed =3D true;
	ieee80211_queue_work(&sdata->local->hw, &sdata->work);
}


[STA: excerpt from the kernel log]
[   37.473147] jffs2_scan_eraseblock(): End of filesystem marker found =
at 0x0
[   37.587678] jffs2_build_filesystem(): unlocking the mtd device...
[   37.587722] done.
[   37.596129] jffs2_build_filesystem(): erasing all blocks after the =
end marker...
[   37.964664] br-lan: port 1(eth0.1) entered forwarding state
[   37.978167] br-lan: topology change detected, propagating
[   37.984273] IPv6: ADDRCONF(NETDEV_CHANGE): br-lan: link becomes ready
[   38.744745] ath: EEPROM regdomain: 0x8348
[   38.744752] ath: EEPROM indicates we should expect a country code
[   38.744759] ath: doing EEPROM country->regdmn map search
[   38.744764] ath: country maps to regdmn code: 0x3a
[   38.744769] ath: Country alpha2 being used: US
[   38.744772] ath: Regpair used: 0x3a
[   38.744778] ath: regdomain 0x8348 dynamically updated by user
[   39.468663] br-lan: port 2(tap_su) entered learning state
[   41.377031] br-lan: port 3(wifi) entered blocking state
[   41.382487] br-lan: port 3(wifi) entered disabled state
[   41.388183] device wifi entered promiscuous mode
[   41.484626] br-lan: port 2(tap_su) entered forwarding state
[   41.490410] br-lan: topology change detected, propagating
[   41.954884] wifi: authenticate with 60:38:e0:xx:xx:xx
[   41.974243] wifi: send auth to 60:38:e0:xx:xx:xx (try 1/3)
[   41.986584] wifi: authenticated
[   42.044684] wifi: associate with 60:38:e0:xx:xx:xx (try 1/3)
[   42.070584] wifi: RX AssocResp from 60:38:e0:xx:xx:xx (capab=3D0x431 =
status=3D0 aid=3D1)
[   42.078755] wifi: associated
[   42.093218] IPv6: ADDRCONF(NETDEV_CHANGE): wifi: link becomes ready
[   42.099926] br-lan: port 3(wifi) entered blocking state
[   42.105375] br-lan: port 3(wifi) entered listening state
[   44.140622] br-lan: port 3(wifi) entered learning state
[   46.156627] br-lan: port 3(wifi) entered forwarding state
[   46.162225] br-lan: topology change detected, sending tcn bpdu
[   66.065901] done.
[   66.067921] jffs2: notice: (1973) jffs2_build_xattr_subsystem: =
complete building xattr subsystem, 0 of xdatum (0 unchecked, 0 orphan) =
and 0 of xref (0 dead, 0 orphan) found.
[   66.371947] overlayfs: upper fs does not support tmpfile.
[   96.686235] sh (2348): drop_caches: 3
[36276.157356] wifi: deauthenticated from 60:38:e0:xx:xx:xx (Reason: =
16=3DGROUP_KEY_HANDSHAKE_TIMEOUT)
[36276.166733] br-lan: port 3(wifi) entered disabled state
[36276.172265] br-lan: topology change detected, propagating
[36277.143206] wifi: authenticate with 60:38:e0:xx:xx:xx
[36277.162537] wifi: send auth to 60:38:e0:xx:xx:xx (try 1/3)
[36277.207635] wifi: authenticated
[36277.212374] wifi: associate with 60:38:e0:xx:xx:xx (try 1/3)
[36277.236924] wifi: RX AssocResp from 60:38:e0:xx:xx:xx (capab=3D0x431 =
status=3D0 aid=3D1)
[36277.245086] wifi: associated
[36277.272020] br-lan: port 3(wifi) entered blocking state
[36277.277472] br-lan: port 3(wifi) entered listening state
[36279.304356] br-lan: port 3(wifi) entered learning state
[36281.320494] br-lan: port 3(wifi) entered forwarding state
[36281.326089] br-lan: topology change detected, sending tcn bpdu
[36301.769911] br-lan: port 3(wifi) neighbor 7fff.60:38:e0:xx:xx:xy lost
[36301.776587] br-lan: topology change detected, propagating
[36577.165274] wifi: disassociated from 60:38:e0:xx:xx:xx (Reason: =
4=3DDISASSOC_DUE_TO_INACTIVITY)
[36577.174238] br-lan: port 3(wifi) entered disabled state
[36577.228788] wifi: authenticate with 60:38:e0:xx:xx:xx
[36577.248147] wifi: send auth to 60:38:e0:xx:xx:xx (try 1/3)
[36577.255054] wifi: authenticated
[36577.259806] wifi: associate with 60:38:e0:xx:xx:xx (try 1/3)
[36577.285353] wifi: RX AssocResp from 60:38:e0:xx:xx:xx (capab=3D0x431 =
status=3D0 aid=3D1)
[36577.293521] wifi: associated
[36577.303805] br-lan: port 3(wifi) entered blocking state
[36577.309234] br-lan: port 3(wifi) entered listening state
[36579.323849] br-lan: port 3(wifi) entered learning state
[36581.339975] br-lan: port 3(wifi) entered forwarding state
[36581.345571] br-lan: topology change detected, sending tcn bpdu


[STA: excerpt from the system log]
Tue Sep 22 09:24:16 2020 daemon.notice wpa_supplicant[1436]: wifi: WPA: =
Group rekeying completed with 60:38:e0:xx:xx:xx [GTK=3DCCMP]
Tue Sep 22 09:24:20 2020 kern.info kernel: [36276.157356] wifi: =
deauthenticated from 60:38:e0:xx:xx:xx (Reason: =
16=3DGROUP_KEY_HANDSHAKE_TIMEOUT)
Tue Sep 22 09:24:20 2020 kern.info kernel: [36276.166733] br-lan: port =
3(wifi) entered disabled state
Tue Sep 22 09:24:20 2020 kern.info kernel: [36276.172265] br-lan: =
topology change detected, propagating
Tue Sep 22 09:24:20 2020 daemon.notice netifd: Network device 'wifi' =
link is down
Tue Sep 22 09:24:20 2020 daemon.notice wpa_supplicant[1436]: wifi: =
CTRL-EVENT-DISCONNECTED bssid=3D60:38:e0:xx:xx:xx reason=3D16
Tue Sep 22 09:24:21 2020 daemon.notice wpa_supplicant[1436]: wifi: SME: =
Trying to authenticate with 60:38:e0:xx:xx:xx (SSID=3D'wifi' freq=3D2432 =
MHz)
Tue Sep 22 09:24:21 2020 kern.info kernel: [36277.143206] wifi: =
authenticate with 60:38:e0:xx:xx:xx
Tue Sep 22 09:24:21 2020 kern.info kernel: [36277.162537] wifi: send =
auth to 60:38:e0:xx:xx:xx (try 1/3)
Tue Sep 22 09:24:21 2020 daemon.notice wpa_supplicant[1436]: wifi: =
Trying to associate with 60:38:e0:xx:xx:xx (SSID=3D'wifi' freq=3D2432 =
MHz)
Tue Sep 22 09:24:21 2020 kern.info kernel: [36277.207635] wifi: =
authenticated
Tue Sep 22 09:24:21 2020 kern.info kernel: [36277.212374] wifi: =
associate with 60:38:e0:xx:xx:xx (try 1/3)
Tue Sep 22 09:24:22 2020 kern.info kernel: [36277.236924] wifi: RX =
AssocResp from 60:38:e0:xx:xx:xx (capab=3D0x431 status=3D0 aid=3D1)
Tue Sep 22 09:24:22 2020 kern.info kernel: [36277.245086] wifi: =
associated
Tue Sep 22 09:24:22 2020 daemon.notice netifd: Network device 'wifi' =
link is up
Tue Sep 22 09:24:22 2020 daemon.notice wpa_supplicant[1436]: wifi: =
Associated with 60:38:e0:xx:xx:xx
Tue Sep 22 09:24:22 2020 daemon.notice wpa_supplicant[1436]: wifi: =
CTRL-EVENT-SUBNET-STATUS-UPDATE status=3D0
Tue Sep 22 09:24:22 2020 daemon.notice wpa_supplicant[1436]: wifi: WPA: =
Key negotiation completed with 60:38:e0:xx:xx:xx [PTK=3DCCMP GTK=3DCCMP]
Tue Sep 22 09:24:22 2020 daemon.notice wpa_supplicant[1436]: wifi: =
CTRL-EVENT-CONNECTED - Connection to 60:38:e0:xx:xx:xx completed [id=3D0 =
id_str=3D]
Tue Sep 22 09:24:22 2020 kern.info kernel: [36277.272020] br-lan: port =
3(wifi) entered blocking state
Tue Sep 22 09:24:22 2020 kern.info kernel: [36277.277472] br-lan: port =
3(wifi) entered listening state
Tue Sep 22 09:24:24 2020 kern.info kernel: [36279.304356] br-lan: port =
3(wifi) entered learning state
Tue Sep 22 09:24:26 2020 kern.info kernel: [36281.320494] br-lan: port =
3(wifi) entered forwarding state
Tue Sep 22 09:24:26 2020 kern.info kernel: [36281.326089] br-lan: =
topology change detected, sending tcn bpdu
Tue Sep 22 09:24:46 2020 kern.info kernel: [36301.769911] br-lan: port =
3(wifi) neighbor 7fff.60:38:e0:xx:xx:xy lost
Tue Sep 22 09:24:46 2020 kern.info kernel: [36301.776587] br-lan: =
topology change detected, propagating
Tue Sep 22 09:29:21 2020 kern.info kernel: [36577.165274] wifi: =
disassociated from 60:38:e0:xx:xx:xx (Reason: =
4=3DDISASSOC_DUE_TO_INACTIVITY)
Tue Sep 22 09:29:21 2020 kern.info kernel: [36577.174238] br-lan: port =
3(wifi) entered disabled state
Tue Sep 22 09:29:21 2020 daemon.notice netifd: Network device 'wifi' =
link is down
Tue Sep 22 09:29:21 2020 daemon.notice wpa_supplicant[1436]: wifi: =
CTRL-EVENT-DISCONNECTED bssid=3D60:38:e0:xx:xx:xx reason=3D4
Tue Sep 22 09:29:21 2020 daemon.notice wpa_supplicant[1436]: wifi: SME: =
Trying to authenticate with 60:38:e0:xx:xx:xx (SSID=3D'wifi' freq=3D2432 =
MHz)
Tue Sep 22 09:29:22 2020 kern.info kernel: [36577.228788] wifi: =
authenticate with 60:38:e0:xx:xx:xx
Tue Sep 22 09:29:22 2020 kern.info kernel: [36577.248147] wifi: send =
auth to 60:38:e0:xx:xx:xx (try 1/3)
Tue Sep 22 09:29:22 2020 kern.info kernel: [36577.255054] wifi: =
authenticated
Tue Sep 22 09:29:22 2020 daemon.notice wpa_supplicant[1436]: wifi: =
Trying to associate with 60:38:e0:xx:xx:xx (SSID=3D'wifi' freq=3D2432 =
MHz)
Tue Sep 22 09:29:22 2020 kern.info kernel: [36577.259806] wifi: =
associate with 60:38:e0:xx:xx:xx (try 1/3)
Tue Sep 22 09:29:22 2020 kern.info kernel: [36577.285353] wifi: RX =
AssocResp from 60:38:e0:xx:xx:xx (capab=3D0x431 status=3D0 aid=3D1)
Tue Sep 22 09:29:22 2020 kern.info kernel: [36577.293521] wifi: =
associated
Tue Sep 22 09:29:22 2020 daemon.notice wpa_supplicant[1436]: wifi: =
Associated with 60:38:e0:xx:xx:xx
Tue Sep 22 09:29:22 2020 daemon.notice wpa_supplicant[1436]: wifi: =
CTRL-EVENT-SUBNET-STATUS-UPDATE status=3D0
Tue Sep 22 09:29:22 2020 daemon.notice netifd: Network device 'wifi' =
link is up
Tue Sep 22 09:29:22 2020 daemon.notice wpa_supplicant[1436]: wifi: WPA: =
Key negotiation completed with 60:38:e0:xx:xx:xx [PTK=3DCCMP GTK=3DCCMP]
Tue Sep 22 09:29:22 2020 daemon.notice wpa_supplicant[1436]: wifi: =
CTRL-EVENT-CONNECTED - Connection to 60:38:e0:xx:xx:xx completed [id=3D0 =
id_str=3D]
Tue Sep 22 09:29:22 2020 kern.info kernel: [36577.303805] br-lan: port =
3(wifi) entered blocking state
Tue Sep 22 09:29:22 2020 kern.info kernel: [36577.309234] br-lan: port =
3(wifi) entered listening state
Tue Sep 22 09:29:24 2020 kern.info kernel: [36579.323849] br-lan: port =
3(wifi) entered learning state
Tue Sep 22 09:29:26 2020 kern.info kernel: [36581.339975] br-lan: port =
3(wifi) entered forwarding state
Tue Sep 22 09:29:26 2020 kern.info kernel: [36581.345571] br-lan: =
topology change detected, sending tcn bpdu


[AP: excerpt from the kernel log]
[86442.373359] ieee80211 phy1: staid 1 deleted
[86448.496264] ieee80211 phy1: staid 1 deleted


[PC: ping -t 192.168.zzz.1]
Reply from 192.168.zzz.1: bytes=3D32 time=3D6ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D2ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D2ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D2ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D2ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D2ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D6ms TTL=3D64
Request timed out.
Request timed out.
Request timed out.
Request timed out.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.

Ping statistics for 192.168.zzz.1:
    Packets: Sent =3D 29750, Received =3D 29745, Lost =3D 5 (0% loss),
Approximate round trip times in milli-seconds:
    Minimum =3D 0ms, Maximum =3D 242ms, Average =3D 2ms
Control-Break
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.7: Destination host unreachable.
Reply from 192.168.zzz.1: bytes=3D32 time=3D2996ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D502ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D502ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D502ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D502ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D502ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D44ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D502ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D502ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D504ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D502ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D502ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D502ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D502ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D502ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D502ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D502ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D503ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D502ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D504ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D503ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D504ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D502ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D502ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D504ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D502ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D502ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D502ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D502ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D502ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D502ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D505ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D503ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D502ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D502ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D502ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D301ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D507ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D5ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D2ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D2ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D2ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D2ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D2ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D2ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D3ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D2ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D2ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D2ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D2ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D2ms TTL=3D64
Reply from 192.168.zzz.1: bytes=3D32 time=3D3ms TTL=3D64

Ping statistics for 192.168.zzz.1:
    Packets: Sent =3D 29820, Received =3D 29815, Lost =3D 5 (0% loss),
Approximate round trip times in milli-seconds:
    Minimum =3D 0ms, Maximum =3D 2996ms, Average =3D 3ms


> On 2020-09-21, at 6:45 PM, Felix Fietkau <nbd@nbd.name> wrote:
>=20
> When the nulldata frame was acked, the probe send count needs to be =
reset,
> otherwise it will keep increasing until the connection is considered =
dead,
> even though it fine.
>=20
> Fixes: 9abf4e49830d ("mac80211: optimize station connection monitor")
> Reported-by: Georgi Valkov <gvalkov@abv.bg>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
> net/mac80211/mlme.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
> index 50a9b9025725..7c04d8e30482 100644
> --- a/net/mac80211/mlme.c
> +++ b/net/mac80211/mlme.c
> @@ -2508,7 +2508,9 @@ void ieee80211_sta_tx_notify(struct =
ieee80211_sub_if_data *sdata,
> 	    !sdata->u.mgd.probe_send_count)
> 		return;
>=20
> -	if (!ack)
> +	if (ack)
> +		sdata->u.mgd.probe_send_count =3D 0;
> +	else
> 		sdata->u.mgd.nullfunc_failed =3D true;
> 	ieee80211_queue_work(&sdata->local->hw, &sdata->work);
> }
> --=20
> 2.28.0
>=20
>=20

