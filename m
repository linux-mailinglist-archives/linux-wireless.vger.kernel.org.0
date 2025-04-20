Return-Path: <linux-wireless+bounces-21765-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB11A948CD
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Apr 2025 20:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79C7B18904E7
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Apr 2025 18:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C392205AD7;
	Sun, 20 Apr 2025 18:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfDLzQms"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587291474D3;
	Sun, 20 Apr 2025 18:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745172958; cv=none; b=PX9hp3e9+5Rl6JgZVkRL9Myt7QG/IX8/c75Vqyeo0dRuVJ1ZEitzbwNk5pAaA7e7s1m9IH/Xi5LB0XtdeXnJJXNf5oSVBdpRMXTgwtdhSo7wnOH0twk3tbB/Ylzcxq96JeAyY0Bt+p3PErw6vyPH9HXuKx2dEtgj3IG4v0tTJzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745172958; c=relaxed/simple;
	bh=odgvtHg+XTEO3AmTBRmJwQpSOiq18WH8OzEFqaQ2MYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mBzAv8P/oxH5KP1vVPnr2VTmE+raOeOw5eu6yLpW/ieLp8I5BWY4V9R7uK7NA4VoNoCuO8yuEjDfcJDz5uwzfGKuDR4r0N1X4JvO2HwxkUaSJBcnBY/VdyFpaVPu03AmPAIRH7+prJydxK1N2eRgieYVc9h6sj/pyZn2N877rBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfDLzQms; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ff64550991so2346754a91.0;
        Sun, 20 Apr 2025 11:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745172955; x=1745777755; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FydHjTRLby7TeTt4ekj3nT37iiEU98LG90xEAmWrSzs=;
        b=AfDLzQmsYAN3StPmYO5E75eEy7SUl6WEsTwA9mBLQRcaC8R0OyK16EeBHi9fq0qz+N
         /CDiMoR8365ocPmd1HDGtOue7wHanAj5r5MnllQus/73W3uRnw8hHj9ZaO05y+t2xIq8
         4BCW9Odnb7nhc6BVU14R1SBUURUZ8Hm9oy8keBrQgVoYXiws50m8wERYEbbdqa/71wUW
         siymIsbo5Vvn9z64PiQ+hj16uwvjJuLZ6MkQYglZu20DsI7dA0HycgL5hZOVZs6nASsV
         5MFh5EMdq0s+Wq7vWmQxUGoUEhiNZk5+qq8wnm4nXBxAy8LbsYLjiThM1FdRJsZKQlxF
         GzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745172955; x=1745777755;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FydHjTRLby7TeTt4ekj3nT37iiEU98LG90xEAmWrSzs=;
        b=oQHqWbLt8ZD4aTiLrWyyDJktVyUZ4DYbmKNvLWxtn4Raf+dBY2F+UWFsTOqaYIc89Q
         Hyyr3kpc2a5I2a2fEscrzd8HUvx39xyVgoOzsrm/edwG26+G6GGv8eOUvwnWx73mo8C0
         hgqXgao1DbVT/7s3xeV5YNPZV86pd2tlzmwMPdXJse1lvVOzAj258uiESEZlMBEfU9uq
         5TxHcd5aw+EBKv0pPudC0lT7+6YgrUPgjXo2LILYIBTpRd5xQFX8+oud9rjjjd6wT4cF
         B25CR7U5vZDF2+Yz9HLI8XCpJ66Frdjb4VcS89MtFs7OCg0v62U67l1v8eFMynrxod2p
         DGGA==
X-Forwarded-Encrypted: i=1; AJvYcCWt93W8zgLGZ9GcyQ0ik7VCGETn7WMFjLXEbXwzIhd4CiD1G4oqZiRkQcOYFRS1ZZ+20l1u19NBAnobZTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS6Uo3WiYX2+6kD9kaQo8HeHiGfIasUoW1qr2049rp5YH3oVvo
	sHeVfCkbrdmF0CZ/phQYlV2LLrQF87aNsNSp7Hd9qnegUsK5h+9f2FdIfrMPm/nSrXnAVGI5HRL
	zt5f4Y/q1ovai8pHQ14ROQ5E2nKI=
X-Gm-Gg: ASbGnctEkCOUwsvXync6sb5Z/z5h7Jx/K46pLF/PhKKceAvm+642X4/6PhAb1GfMgc7
	Vlu7L3P07vNmkyx7FvQKhhQBzIxd5jMGRC0wc5qzW+4QvFDglKm/goICUc6jIt96u4YA6jahyiI
	zVqafPCla+ArOFeRnQO9f84cJRauGmL6muP1g=
X-Google-Smtp-Source: AGHT+IEmrCEogNYMFqbLYQVZ2wE2zn/ZiUmho4x2xb45nu3PoI0IbYdfcJq0+S2G2M/5p2WSif/7k2jiPfHtMeeEtEY=
X-Received: by 2002:a17:90a:d60b:b0:2fe:a0ac:5fcc with SMTP id
 98e67ed59e1d1-3087bccb0e3mr11217210a91.34.1745172955368; Sun, 20 Apr 2025
 11:15:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407042028.1481-1-vulab@iscas.ac.cn>
In-Reply-To: <20250407042028.1481-1-vulab@iscas.ac.cn>
From: KeithG <ys3al35l@gmail.com>
Date: Sun, 20 Apr 2025 13:15:44 -0500
X-Gm-Features: ATxdqUFigDSeDaDfsJZsrpcPI_gDT8BH5CS6xrxpWSxVb-pUH52VIWxRWgBhpBo
Message-ID: <CAG17S_NDLjfeTZ_qo8B6aXi2z6BHYCakBHzy2AqcqP2Co32hNw@mail.gmail.com>
Subject: Cannot maintain an ap with brcmfmac
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
	brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Group,

I do not really know what has changed, but I can no longer maintain an
ap runnning with brcmfmac on my Pis with the brcmfmac43455 chip. The
firmware is current (and ahead of what RPiOS ships):

[    3.472501] brcmfmac: F1 signature read @0x18000000=0x15264345
[    3.493274] brcmfmac: brcmf_fw_alloc_request: using
brcm/brcmfmac43455-sdio for chip BCM4345/6
[    3.494583] usbcore: registered new interface driver brcmfmac
[    3.900038] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob
available (err=-2)
[    3.901161] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6
wl0: Oct 28 2024 23:27:00 version 7.45.286 (be70ab3 CY) FWID
01-95efe7fa

I get this with the default RPiOS verison of hostapd:
# hostapd -v
hostapd v2.10
User space daemon for IEEE 802.11 AP management,
IEEE 802.1X/WPA/WPA2/EAP/RADIUS Authenticator
Copyright (c) 2002-2022, Jouni Malinen <j@w1.fi> and contributors

And also with the one I built from source. The latest hostapd I could find.
The git repo it is built from is from here: https://w1.fi/hostapd/

# hostapd -v
hostapd v2.11-hostap_2_11+
User space daemon for IEEE 802.11 AP management,
IEEE 802.1X/WPA/WPA2/EAP/RADIUS Authenticator
Copyright (c) 2002-2024, Jouni Malinen <j@w1.fi> and contributors

My hostapd.conf is:
# cat /etc/hostapd/hostapd.conf
# interface and driver
interface=ap0
driver=nl80211

ht_capab=[HT40][SHORT-GI-20][DSSS_CCK-40]

# WIFI-Config
ssid=TestAP
channel=6
hw_mode=g
wmm_enabled=1
macaddr_acl=0
auth_algs=1
max_num_sta=10

# WIFI authorization
wpa=2
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP CCMP
rsn_pairwise=CCMP
wpa_psk_radius=0
wpa_passphrase=secret123

If there is something wrong in my setup, let me know.

when I start hostapd with dnsmasq, an interface comes up and I can
connect. As soon as it connects, it disconnects:
Apr 20 12:57:39 pi4 systemd-networkd[181]: ap0: Gained carrier
Apr 20 12:57:39 pi4 dnsmasq[169728]: started, version 2.90 cachesize 150
Apr 20 12:57:39 pi4 dnsmasq[169728]: compile time options: IPv6
GNU-getopt DBus no-UBus i18n IDN2 DHCP DHCPv6 no-Lua TFTP conntrack
ipset nftset auth cryptohash DNSSEC loop-detect inotify dumpfile
Apr 20 12:57:39 pi4 dnsmasq[169728]: warning: interface ap0 does not
currently exist
Apr 20 12:57:39 pi4 dnsmasq-dhcp[169728]: DHCP, IP range 192.168.5.2
-- 192.168.5.254, lease time 1d
Apr 20 12:57:39 pi4 dnsmasq[169728]: reading /run/systemd/resolve/resolv.conf
Apr 20 12:57:39 pi4 dnsmasq[169728]: using nameserver 192.168.2.253#53
Apr 20 12:57:39 pi4 dnsmasq[169728]: read /etc/hosts - 8 names
Apr 20 12:57:39 pi4 hostapd[169681]: ap0: interface state UNINITIALIZED->ENABLED
Apr 20 12:57:39 pi4 hostapd[169681]: ap0: AP-ENABLED
Apr 20 12:57:39 pi4 resolvconf[169735]: Dropped protocol specifier
'.dnsmasq' from 'lo.dnsmasq'. Using 'lo' (ifindex=1).
Apr 20 12:57:39 pi4 resolvconf[169735]: Failed to set DNS
configuration: Link lo is loopback device.
Apr 20 12:57:39 pi4 systemd[1]: Started dnsmasq.service - dnsmasq - A
lightweight DHCP and caching DNS server.
Apr 20 12:57:40 pi4 kernel: brcmfmac: brcmf_cfg80211_set_power_mgmt:
power save disabled
Apr 20 12:57:48 pi4 kernel: ieee80211 phy0: brcmf_escan_timeout: timer expired
Apr 20 12:57:48 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a IEEE
802.11: associated
Apr 20 12:57:48 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a IEEE
802.11: associated
Apr 20 12:57:48 pi4 hostapd[169681]: ap0: AP-STA-CONNECTED 50:84:92:a6:7a:7a
Apr 20 12:57:48 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a
RADIUS: starting accounting session 4336779F2221A786
Apr 20 12:57:48 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a WPA:
pairwise key handshake completed (RSN)
Apr 20 12:57:48 pi4 hostapd[169681]: ap0: EAPOL-4WAY-HS-COMPLETED
50:84:92:a6:7a:7a
Apr 20 12:57:48 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a
RADIUS: starting accounting session 4336779F2221A786
Apr 20 12:57:48 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a WPA:
pairwise key handshake completed (RSN)
Apr 20 12:57:48 pi4 dnsmasq-dhcp[169728]: DHCPDISCOVER(ap0) 50:84:92:a6:7a:7a
Apr 20 12:57:48 pi4 dnsmasq-dhcp[169728]: DHCPOFFER(ap0) 192.168.5.214
50:84:92:a6:7a:7a
Apr 20 12:57:48 pi4 dnsmasq-dhcp[169728]: DHCPREQUEST(ap0)
192.168.5.214 50:84:92:a6:7a:7a
Apr 20 12:57:48 pi4 dnsmasq-dhcp[169728]: DHCPACK(ap0) 192.168.5.214
50:84:92:a6:7a:7a
Apr 20 12:57:52 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a IEEE
802.11: disassociated
Apr 20 12:57:52 pi4 hostapd[169681]: ap0: AP-STA-DISCONNECTED 50:84:92:a6:7a:7a
Apr 20 12:57:52 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a IEEE
802.11: disassociated
Apr 20 12:57:52 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a IEEE
802.11: disassociated
Apr 20 12:57:52 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a IEEE
802.11: disassociated
Apr 20 12:57:52 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a IEEE
802.11: disassociated
Apr 20 12:57:52 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a IEEE
802.11: disassociated
Apr 20 12:57:52 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a IEEE
802.11: associated
Apr 20 12:57:52 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a IEEE
802.11: associated
Apr 20 12:57:52 pi4 hostapd[169681]: ap0: AP-STA-CONNECTED 50:84:92:a6:7a:7a
Apr 20 12:57:52 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a
RADIUS: starting accounting session 33CFF844DBBE630F
Apr 20 12:57:52 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a WPA:
pairwise key handshake completed (RSN)
Apr 20 12:57:52 pi4 hostapd[169681]: ap0: EAPOL-4WAY-HS-COMPLETED
50:84:92:a6:7a:7a
Apr 20 12:57:52 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a
RADIUS: starting accounting session 33CFF844DBBE630F
Apr 20 12:57:52 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a WPA:
pairwise key handshake completed (RSN)
Apr 20 12:57:52 pi4 dnsmasq-dhcp[169728]: DHCPDISCOVER(ap0) 50:84:92:a6:7a:7a
Apr 20 12:57:52 pi4 dnsmasq-dhcp[169728]: DHCPOFFER(ap0) 192.168.5.214
50:84:92:a6:7a:7a
Apr 20 12:57:52 pi4 dnsmasq-dhcp[169728]: DHCPREQUEST(ap0)
192.168.5.214 50:84:92:a6:7a:7a
Apr 20 12:57:52 pi4 dnsmasq-dhcp[169728]: DHCPACK(ap0) 192.168.5.214
50:84:92:a6:7a:7a
Apr 20 12:57:57 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a IEEE
802.11: disassociated
Apr 20 12:57:57 pi4 hostapd[169681]: ap0: AP-STA-DISCONNECTED 50:84:92:a6:7a:7a
Apr 20 12:57:57 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a IEEE
802.11: disassociated
Apr 20 12:57:57 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a IEEE
802.11: disassociated
Apr 20 12:57:57 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a IEEE
802.11: disassociated
Apr 20 12:58:11 pi4 hostapd[169681]: ap0: interface state ENABLED->DISABLED
Apr 20 12:58:11 pi4 systemd[1]: Stopping hostapd.service - Hostapd
IEEE 802.11 AP, IEEE 802.1X/WPA/WPA2/EAP/RADIUS Authenticator...
Apr 20 12:58:11 pi4 hostapd[169681]: ap0: AP-DISABLED
Apr 20 12:58:11 pi4 hostapd[169681]: ap0: CTRL-EVENT-TERMINATING
Apr 20 12:58:11 pi4 hostapd[169681]: nl80211: deinit ifname=ap0
disabled_11b_rates=0
Apr 20 12:58:11 pi4 systemd-networkd[181]: ap0: Lost carrier
Apr 20 12:58:11 pi4 systemd[1]: hostapd.service: Deactivated successfully.
Apr 20 12:58:11 pi4 systemd[1]: Stopped hostapd.service - Hostapd IEEE
802.11 AP, IEEE 802.1X/WPA/WPA2/EAP/RADIUS Authenticator.
Apr 20 12:58:12 pi4 systemd[1]: Stopping dnsmasq.service - dnsmasq - A
lightweight DHCP and caching DNS server...
Apr 20 12:58:12 pi4 resolvconf[170375]: Dropped protocol specifier
'.dnsmasq' from 'lo.dnsmasq'. Using 'lo' (ifindex=1).
Apr 20 12:58:12 pi4 resolvconf[170375]: Failed to revert interface
configuration: Link lo is loopback device.
Apr 20 12:58:12 pi4 dnsmasq[169728]: exiting on receipt of SIGTERM
Apr 20 12:58:12 pi4 systemd[1]: dnsmasq.service: Deactivated successfully.
Apr 20 12:58:12 pi4 systemd[1]: Stopped dnsmasq.service - dnsmasq - A
lightweight DHCP and caching DNS server.
Apr 20 12:58:12 pi4 systemd-networkd[181]: ap0: Link DOWN
Apr 20 12:58:12 pi4 kernel: ieee80211 phy0:
brcmf_cfg80211_get_channel: chanspec failed (-52)

