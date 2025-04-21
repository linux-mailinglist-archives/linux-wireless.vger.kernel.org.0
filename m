Return-Path: <linux-wireless+bounces-21783-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB23A94CAF
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 08:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83A037A7531
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 06:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72F5258CC2;
	Mon, 21 Apr 2025 06:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IMo00jIS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11881A315A
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 06:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745218081; cv=none; b=kDfBeKQ/5djgTzXl5tI6RvmJE206CloBVnXnRlQ/OsJN3qtWmVyVwYcU2jxwlCt+zVe9CCv73qFwyFHBdIm22bopbB7czGp8wkCioC6zgHjZnXO/Mlj8Ck94K12qzprqeReVMGcoeyleNldzEA8eJggDGr4++WrNgywiYz4yjb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745218081; c=relaxed/simple;
	bh=nL88osFR+xwkq0d89jaqv2lpr1Vg52plmkAJMPjBbWM=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ZSIdJ+5hDn1XShIcfgbfDcFCnPYN2jTAM82TCu7WbHDoX74hlP9wr7BjzF7vU0yohhH38ZK3ZzqSi2mLQPdHrWW883G9V3BwlC/RVk55eBMf+R9g3dXpQKo4ZQvzUEUmNlllGw81ka1q5914bhWnxSxdBOqiRjwCnOylGtzilQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IMo00jIS; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac339f53df9so648470866b.1
        for <linux-wireless@vger.kernel.org>; Sun, 20 Apr 2025 23:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745218077; x=1745822877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eoh+UHAHaX63W3Xnorvqri+MwqtBlKW14ThZ2I5rFOc=;
        b=IMo00jIS7OWhR4nTJE9WCVXlHUK/0pp9NWzyPZXnhtBKZD0qavZFNVYClXoJmy1LCB
         gnhjLe3fLBzTdOZN1IWW+Z2kM9MuxwwsyV8M1qAhpXkpYUo8EyE96Cj2aZ7ydRbAR1uv
         zi9mbfJxypcXyGgSqkDCiLAtI/VGGPbe3yQv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745218077; x=1745822877;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eoh+UHAHaX63W3Xnorvqri+MwqtBlKW14ThZ2I5rFOc=;
        b=KcEDSr9ePl0kndXvaiKNDCtJ8pJPg3vtEyUTUCJRPaN+p/Gg+RwfsODUDMqGa7/w35
         4zCDrLjY7LDwmigTyn8au4rLda71DCAF+Qi5L/Zk6XhXg2DN0zcGB2+cfSfNNJwOzp2S
         jaOjth7SsYC0mk3K4jehFyy5QdfyS5LfjWsqvukOi/OGXYPUdKb3lYzTO1bUU5/4b+bq
         A6alHcuIdMvwHS1SW7IZ3K8RKfD/SBAr1iDv2hcrlt47M6v6kb9AEsnbOY/7qeySZsPj
         fS34vme52JP8hBlhmEGqTC+A6ZW2Cs7vMLZRquZHLfeA8v8h7oa3kAa0IjAiOPXtLD6K
         k7vQ==
X-Gm-Message-State: AOJu0YwrO3AqvJoaGgWtT1CYJ3XOOJlwEbZT1VxlG4L8A5NcjOI+HfKZ
	fDc3mMAX6zkzNQC5nRcUeBhvp82DnzQvR0PAVjJvPzN6N7szFrjlMDGKqSRMpCgYqWAm5qx8Sre
	uvw==
X-Gm-Gg: ASbGnctxAY8t/FLI4YFdBBHj9OxPnnmCRlb2O5LH3OjvtCV08zFmaVUQFBBl+o9cTL3
	iKCFDvyZoeoexkVqOfIJfZ2n7YkL/1Gwgv424sKpLmFVsmeg7xFoThp9r78FOJXSNgrnXwUg3D+
	Oa5eBfKP+yFUDX+WqC9tuwkJXl54zM9nLtiWvJwVSbThSodmbkiLoHjWSrA4gr6evMikV32ORDA
	h13i4S1WOmWdHxDtpVUSBTKOJFlwXYajUF6gJZGbQxQoLmG/btxHjt2bLQMegDlygqM7XEHqEEm
	dcVxqhJv2Czut92HTEtgcttYW0pENt5W5m7SS95pbFY7buk79UOkq3xzT2/K8dQ98yVBV51F22d
	tSy4=
X-Google-Smtp-Source: AGHT+IF57sTzG2W/MLUToUBMdG3Gp8wae1dAx1ppKQWPBR7VB+1fvf1xtyMNBtv0qPDtnlesQOYTmA==
X-Received: by 2002:a17:907:9622:b0:aca:df11:c53c with SMTP id a640c23a62f3a-acb74dbb5admr911534466b.43.1745218076812;
        Sun, 20 Apr 2025 23:47:56 -0700 (PDT)
Received: from [192.168.178.39] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ec04819sm479666666b.10.2025.04.20.23.47.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Apr 2025 23:47:56 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: KeithG <ys3al35l@gmail.com>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <linux-kernel@vger.kernel.org>
Date: Mon, 21 Apr 2025 08:47:56 +0200
Message-ID: <196571a7d60.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <CAG17S_NDLjfeTZ_qo8B6aXi2z6BHYCakBHzy2AqcqP2Co32hNw@mail.gmail.com>
References: <20250407042028.1481-1-vulab@iscas.ac.cn>
 <CAG17S_NDLjfeTZ_qo8B6aXi2z6BHYCakBHzy2AqcqP2Co32hNw@mail.gmail.com>
User-Agent: AquaMail/1.54.1 (build: 105401536)
Subject: Re: Cannot maintain an ap with brcmfmac
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On April 20, 2025 8:15:56 PM KeithG <ys3al35l@gmail.com> wrote:

> Group,
>
> I do not really know what has changed, but I

Can you try to find out?

> can no longer maintain an
> ap runnning with brcmfmac on my Pis with the brcmfmac43455 chip. The
> firmware is current (and ahead of what RPiOS ships):

Maybe you could try with what RPiOS ships.

> [    3.472501] brcmfmac: F1 signature read @0x18000000=0x15264345
> [    3.493274] brcmfmac: brcmf_fw_alloc_request: using
> brcm/brcmfmac43455-sdio for chip BCM4345/6
> [    3.494583] usbcore: registered new interface driver brcmfmac
> [    3.900038] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob
> available (err=-2)
> [    3.901161] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6
> wl0: Oct 28 2024 23:27:00 version 7.45.286 (be70ab3 CY) FWID
> 01-95efe7fa
>
> I get this with the default RPiOS verison of hostapd:
> # hostapd -v
> hostapd v2.10
> User space daemon for IEEE 802.11 AP management,
> IEEE 802.1X/WPA/WPA2/EAP/RADIUS Authenticator
> Copyright (c) 2002-2022, Jouni Malinen <j@w1.fi> and contributors
>
> And also with the one I built from source. The latest hostapd I could find.
> The git repo it is built from is from here: https://w1.fi/hostapd/
>
> # hostapd -v
> hostapd v2.11-hostap_2_11+
> User space daemon for IEEE 802.11 AP management,
> IEEE 802.1X/WPA/WPA2/EAP/RADIUS Authenticator
> Copyright (c) 2002-2024, Jouni Malinen <j@w1.fi> and contributors
>
> My hostapd.conf is:
> # cat /etc/hostapd/hostapd.conf
> # interface and driver
> interface=ap0
> driver=nl80211
>
> ht_capab=[HT40][SHORT-GI-20][DSSS_CCK-40]
>
> # WIFI-Config
> ssid=TestAP
> channel=6
> hw_mode=g
> wmm_enabled=1
> macaddr_acl=0
> auth_algs=1
> max_num_sta=10
>
> # WIFI authorization
> wpa=2
> wpa_key_mgmt=WPA-PSK
> wpa_pairwise=TKIP CCMP
> rsn_pairwise=CCMP
> wpa_psk_radius=0
> wpa_passphrase=secret123
>
> If there is something wrong in my setup, let me know.

Hard to tell. The above looks okay, but no idea what your setup looks like.

> when I start hostapd with dnsmasq, an interface comes up and I can
> connect. As soon as it connects, it disconnects:
> Apr 20 12:57:39 pi4 systemd-networkd[181]: ap0: Gained carrier
> Apr 20 12:57:39 pi4 dnsmasq[169728]: started, version 2.90 cachesize 150
> Apr 20 12:57:39 pi4 dnsmasq[169728]: compile time options: IPv6
> GNU-getopt DBus no-UBus i18n IDN2 DHCP DHCPv6 no-Lua TFTP conntrack
> ipset nftset auth cryptohash DNSSEC loop-detect inotify dumpfile
> Apr 20 12:57:39 pi4 dnsmasq[169728]: warning: interface ap0 does not
> currently exist

So does this mean you run with two wifi interfaces, ie. wlan0 and ap0? Can 
you try with just only an AP interface?

> Apr 20 12:57:39 pi4 dnsmasq-dhcp[169728]: DHCP, IP range 192.168.5.2
> -- 192.168.5.254, lease time 1d
> Apr 20 12:57:39 pi4 dnsmasq[169728]: reading /run/systemd/resolve/resolv.conf
> Apr 20 12:57:39 pi4 dnsmasq[169728]: using nameserver 192.168.2.253#53
> Apr 20 12:57:39 pi4 dnsmasq[169728]: read /etc/hosts - 8 names
> Apr 20 12:57:39 pi4 hostapd[169681]: ap0: interface state 
> UNINITIALIZED->ENABLED
> Apr 20 12:57:39 pi4 hostapd[169681]: ap0: AP-ENABLED
> Apr 20 12:57:39 pi4 resolvconf[169735]: Dropped protocol specifier
> '.dnsmasq' from 'lo.dnsmasq'. Using 'lo' (ifindex=1).
> Apr 20 12:57:39 pi4 resolvconf[169735]: Failed to set DNS
> configuration: Link lo is loopback device.
> Apr 20 12:57:39 pi4 systemd[1]: Started dnsmasq.service - dnsmasq - A
> lightweight DHCP and caching DNS server.
> Apr 20 12:57:40 pi4 kernel: brcmfmac: brcmf_cfg80211_set_power_mgmt:
> power save disabled
> Apr 20 12:57:48 pi4 kernel: ieee80211 phy0: brcmf_escan_timeout: timer expired
> Apr 20 12:57:48 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a IEEE
> 802.11: associated
> Apr 20 12:57:48 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a IEEE
> 802.11: associated
> Apr 20 12:57:48 pi4 hostapd[169681]: ap0: AP-STA-CONNECTED 50:84:92:a6:7a:7a
> Apr 20 12:57:48 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a
> RADIUS: starting accounting session 4336779F2221A786
> Apr 20 12:57:48 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a WPA:
> pairwise key handshake completed (RSN)
> Apr 20 12:57:48 pi4 hostapd[169681]: ap0: EAPOL-4WAY-HS-COMPLETED
> 50:84:92:a6:7a:7a
> Apr 20 12:57:48 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a
> RADIUS: starting accounting session 4336779F2221A786
> Apr 20 12:57:48 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a WPA:
> pairwise key handshake completed (RSN)

So looks like connection and security are setup correctly...
> Apr 20 12:57:48 pi4 dnsmasq-dhcp[169728]: DHCPDISCOVER(ap0) 50:84:92:a6:7a:7a
> Apr 20 12:57:48 pi4 dnsmasq-dhcp[169728]: DHCPOFFER(ap0) 192.168.5.214
> 50:84:92:a6:7a:7a
> Apr 20 12:57:48 pi4 dnsmasq-dhcp[169728]: DHCPREQUEST(ap0)
> 192.168.5.214 50:84:92:a6:7a:7a
> Apr 20 12:57:48 pi4 dnsmasq-dhcp[169728]: DHCPACK(ap0) 192.168.5.214
> 50:84:92:a6:7a:7a

...and DHCP exchange is okay, which clearly indicated encrypted data 
connection is working.

> Apr 20 12:57:52 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a IEEE
> 802.11: disassociated
> Apr 20 12:57:52 pi4 hostapd[169681]: ap0: AP-STA-DISCONNECTED 50:84:92:a6:7a:7a
> Apr 20 12:57:52 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a IEEE
> 802.11: disassociated
> Apr 20 12:57:52 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a IEEE
> 802.11: disassociated
> Apr 20 12:57:52 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a IEEE
> 802.11: disassociated
> Apr 20 12:57:52 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a IEEE
> 802.11: disassociated
> Apr 20 12:57:52 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a IEEE
> 802.11: disassociated

So not clear what triggers these disassociated events. Can you enable debug 
prints in brcmfmac, ie. use debug=0x100400? The levels are defined in 
debug.h [1]

> Apr 20 12:57:52 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a IEEE
> 802.11: associated
> Apr 20 12:57:52 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a IEEE
> 802.11: associated
> Apr 20 12:57:52 pi4 hostapd[169681]: ap0: AP-STA-CONNECTED 50:84:92:a6:7a:7a
> Apr 20 12:57:52 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a
> RADIUS: starting accounting session 33CFF844DBBE630F
> Apr 20 12:57:52 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a WPA:
> pairwise key handshake completed (RSN)
> Apr 20 12:57:52 pi4 hostapd[169681]: ap0: EAPOL-4WAY-HS-COMPLETED
> 50:84:92:a6:7a:7a
> Apr 20 12:57:52 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a
> RADIUS: starting accounting session 33CFF844DBBE630F
> Apr 20 12:57:52 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a WPA:
> pairwise key handshake completed (RSN)
> Apr 20 12:57:52 pi4 dnsmasq-dhcp[169728]: DHCPDISCOVER(ap0) 50:84:92:a6:7a:7a
> Apr 20 12:57:52 pi4 dnsmasq-dhcp[169728]: DHCPOFFER(ap0) 192.168.5.214
> 50:84:92:a6:7a:7a
> Apr 20 12:57:52 pi4 dnsmasq-dhcp[169728]: DHCPREQUEST(ap0)
> 192.168.5.214 50:84:92:a6:7a:7a
> Apr 20 12:57:52 pi4 dnsmasq-dhcp[169728]: DHCPACK(ap0) 192.168.5.214
> 50:84:92:a6:7a:7a
> Apr 20 12:57:57 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a IEEE
> 802.11: disassociated
> Apr 20 12:57:57 pi4 hostapd[169681]: ap0: AP-STA-DISCONNECTED 50:84:92:a6:7a:7a
> Apr 20 12:57:57 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a IEEE
> 802.11: disassociated
> Apr 20 12:57:57 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a IEEE
> 802.11: disassociated
> Apr 20 12:57:57 pi4 hostapd[169681]: ap0: STA 50:84:92:a6:7a:7a IEEE
> 802.11: disassociated
> Apr 20 12:58:11 pi4 hostapd[169681]: ap0: interface state ENABLED->DISABLED
> Apr 20 12:58:11 pi4 systemd[1]: Stopping hostapd.service - Hostapd
> IEEE 802.11 AP, IEEE 802.1X/WPA/WPA2/EAP/RADIUS Authenticator...

Assuming it is stopped manually here. Correct?

Regards,
Arend

[1] 
https://elixir.bootlin.com/linux/v6.14.3/source/drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.h



