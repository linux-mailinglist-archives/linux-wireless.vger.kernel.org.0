Return-Path: <linux-wireless+bounces-4663-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F9A87A2C7
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 06:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3EE91F22286
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 05:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F87AFC1B;
	Wed, 13 Mar 2024 05:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=s.l-h@gmx.de header.b="UV3Vf2j8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB6023AD
	for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 05:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710308982; cv=none; b=Q/VfsD29JPtJBgMWRGZzjac1aHFwsX+JQ48GO7kgaAidbxj4NKC0sGNyfu9rCwY41xp4TCbAV0wiWhSXLV4c6ICQWJ67AXLi2H5waFqJYNP2XfVMT/so7+Ml1eY3UULvTXsfmcL0EtpcBFa1mayIztjZju66/qZGvq4XaveElFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710308982; c=relaxed/simple;
	bh=Myyd7cV8YdfknI6oI+ei1fduROyKuf+5IGKM/54JKE0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KRfsMUMB8jB7H8Xt1Ej5EbBsjXKQm2eLLjYKdEazUNDgqAhCFupL+1V0lkkKO1MwopMqMto57qcV94QXZkhaqEl/Z0bJh8Ybx30u6u1YVDxmoIlYhZpilmUZltSklUQ+BacGmC97pm1Fq/Nf+EfS9C6OikdYjIOX02pgDDCoX+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=s.l-h@gmx.de header.b=UV3Vf2j8; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1710308964; x=1710913764; i=s.l-h@gmx.de;
	bh=Myyd7cV8YdfknI6oI+ei1fduROyKuf+5IGKM/54JKE0=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:
	 References;
	b=UV3Vf2j8KitsEF1LaoC+ckVxJ0+ExGXSpu5cBFOS8LZ4DgUPI22qrVq0Laya6PoW
	 4iBC0vA19pbHf9b35NPjPPBy87IYI8eZIHfuN2N4D1W7MC7rbhr5qffJcVQ6vbi+p
	 daWu3AwKO79tGVqfydBNP5sxduYakRNOsa+LKVsxs5KIhjIbuJveFfwCgGZfRkrgr
	 tFJYudHb+46Dxtt5g+IIF++LwVy9iS7JVkmAGxbG5qqBgsBukySozlmgTVJwtH1b2
	 tPICHBVBWQcCzykuyo6tiWcFiQDKOqH0o4XE3MgT0BUwpgenB+Fq0Paws1HqOQeDp
	 kl0amrwBc0d0P2WWSQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mir ([94.31.82.155]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1HZo-1rn1Je2adO-002pt0; Wed, 13
 Mar 2024 06:49:24 +0100
Date: Wed, 13 Mar 2024 06:49:17 +0100
From: Stefan Lippers-Hollmann <s.l-h@gmx.de>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 Ping-Ke Shih <pkshih@realtek.com>, Larry Finger
 <Larry.Finger@lwfinger.net>, Christian Hewitt <chewitt@libreelec.tv>
Subject: Re: [PATCH 1/3] wifi: rtlwifi: Move code from rtl8192de to
 rtl8192d-common
Message-ID: <20240313064917.527110c4@mir>
In-Reply-To: <e1922019-21eb-4013-a35f-0077167e92cf@gmail.com>
References: <e1922019-21eb-4013-a35f-0077167e92cf@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uLJmLZqezyoJoHzrP1CjuQJBv2ATdWGUx4/QBiKEM9WZd6hYntA
 niKiQ9roLJO0Ns4BwgjUkH5RTQKOxXSxGr1cKOP53YMTqSkz40v89xC8Q/qNL2R+tQ8Ton8
 c6VvS+/htxWdz/s/fEw3KlwngpHuoys9Xj+QN1oo92F/L1/MAXVvDP0+ptG1h0vgQjdWqDZ
 1s46/YcvaGZ2C6nHwhr9A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NXO6Z5JrQ5I=;FYOoGEozoVMC50hHfxy4rB0gZSE
 fceVYprGOOa3mlXvQh60GpaJqMg8SZGFDierVcTXTBuMgamgLenCZCeyitDJSEcLjYSbJrmYi
 L0lNh2qgE5UoP8OuJPuCYrcVnBPHITMu5qq1qTv/AaQ8HnopxmdXx3glYf7/cuukNeyY0J4S2
 T9sgZ7eVYv7hS6Nkcgh959UHC08ZSvOSDKm4Fkwk/WPg5gUYKX1KruvUtwTolwOT3K4sic163
 tkhtHeB6CLF/nUIjuPkeCRLeQQb33h8gyo0Ud6ZK0xQec4hv3QfxFtZtyS2iG9qSrQMxAXhmS
 lV+QlWdWUi23Y60Pp4bG0piPZd0VAjhrXTFbxaQvigOB0LEU3W5Yds35q4rhHCjKZ/+Ztvsq/
 PPVMpIdDEIiXkwoD/UChfCt/NjtY6VAb1EsoF+nfxbsRwlM4c9RVaoOKa5XgV/ObYGung+pVG
 BFmlblnRF1lNXBIRmN7RPyJX+fhE/WQ6bpd48RkbgJD10GyLQJEkYOYmIdxhWABEayCDNt71x
 faFDBoT3k9/FwwXM8bWWPVdXae+AjlOHBB4GQGtLhQQlkZMCz7lKCPtVM2NacKJnji+46piwb
 pY9hGtXfVCCTkBWd9YHgi0VwZgILfFaduy0EiukGaPMC/5auwac1inyGkfOMMRoGVAVdDqwTu
 tthZiVoczLJR9hCGp/qS/uGgBTI/cl60I5mhwStrRV42sNmYq83sP83GHiw2yVMZ/bBMtgxh2
 EK3rfznUasKjCdepaMGQE5MBZwnDvpNZMuuaK8XtetJS5US1RE5emrUebExmu2yzxlqJK+LNb
 /WSvvy91fum+h7OWNCPyiT/XuroFUeCbeqWQ4fWHPTHzA=

Hi

On 2024-03-13, Bitterblue Smith wrote:
> Create the new module rtl8192d-common and move some code into it from
> rtl8192de. Now the rtl8192de driver (PCI) and the new rtl8192du driver
> (USB) can share some of the code.
[...]
> Tested only with RTL8192DU.
>
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

Tested-by: Stefan Lippers-Hollmann <s.l-h@gmx.de>

I've successfully tested this series and its preparatory patch on my
DeLock 88540,
https://www.delock.com/produkt/88540/merkmale.html?setLanguage=3Den

wifi: rtlwifi: rtl8192de: Fix 5 GHz TX power
wifi: rtlwifi: Move code from rtl8192de to rtl8192d-common
wifi: rtlwifi: Adjust rtl8192d-common for USB
wifi: rtlwifi: Add new rtl8192du driver

[   32.083987] usb 3-5: new high-speed USB device number 5 using xhci_hcd
[   32.212707] usb 3-5: New USB device found, idVendor=3D0bda, idProduct=
=3D8194, bcdDevice=3D 0.00
[   32.212722] usb 3-5: New USB device strings: Mfr=3D1, Product=3D2, Seri=
alNumber=3D3
[   32.212727] usb 3-5: Product: 802.11n NIC
[   32.212732] usb 3-5: Manufacturer: Realtek
[   32.212735] usb 3-5: SerialNumber: 00e04c000001
[   32.362820] rtl_usb: rx_max_size 15360, rx_urb_num 8, in_ep 1
[   32.362836] rtl8192du: Inactive Power Save off (module option)
[   32.362839] rtl8192du: Driver for Realtek RTL8192DU WLAN interface
[   32.362840] rtl8192du: Loading firmware file rtlwifi/rtl8192dufw.bin
[   32.362952] ieee80211 phy1: Selected rate control algorithm 'rtl_rc'
[   32.364168] usbcore: registered new interface driver rtl8192du
[   32.372367] rtl8192du 3-5:1.0 wlxXXXXXXXXXXXX: renamed from wlan0
[...]
[  130.838250] wlxXXXXXXXXXXXX: authenticate with XX:XX:XX:XX:XX:XX (local=
 address=3DXX:XX:XX:XX:XX:XX)
[  130.838256] wlxXXXXXXXXXXXX: send auth to XX:XX:XX:XX:XX:XX (try 1/3)
[  130.849611] wlxXXXXXXXXXXXX: authenticate with XX:XX:XX:XX:XX:XX (local=
 address=3DXX:XX:XX:XX:XX:XX)
[  130.849621] wlxXXXXXXXXXXXX: send auth to XX:XX:XX:XX:XX:XX (try 1/3)
[  130.852150] wlxXXXXXXXXXXXX: authenticated
[  130.853287] wlxXXXXXXXXXXXX: associate with XX:XX:XX:XX:XX:XX (try 1/3)
[  130.860230] wlxXXXXXXXXXXXX: RX AssocResp from XX:XX:XX:XX:XX:XX (capab=
=3D0x1511 status=3D0 aid=3D3)
[  130.861618] wlxXXXXXXXXXXXX: associated
[  130.876995] wlxXXXXXXXXXXXX: Limiting TX power to 23 (23 - 0) dBm as ad=
vertised by XX:XX:XX:XX:XX:XX

# wpa_cli -i wlxXXXXXXXXXXXX status
bssid=3DXX:XX:XX:XX:XX:XX
freq=3D5260
ssid=3DXXX
id=3D4
id_str=3DXXX
mode=3Dstation
wifi_generation=3D4
pairwise_cipher=3DCCMP
group_cipher=3DCCMP
key_mgmt=3DSAE
pmf=3D2
mgmt_group_cipher=3DBIP
sae_group=3D19
sae_h2e=3D0
sae_pk=3D0
wpa_state=3DCOMPLETED
p2p_device_address=3DXX:XX:XX:XX:XX:XX
address=3DXX:XX:XX:XX:XX:XX
uuid=3DXXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXXXX

Using the firmware from https://github.com/lwfinger/rtl8192du/,
it would be great if someone could publish the necessary firmware
to linux-firmware.

MD5:
abccba1e9bb456eb81dfc88502a56300  /lib/firmware/rtlwifi/rtl8192dufw.bin

SHA256:
9b51f15642b7f2d41e8369d7df956f92333c09699d8a88039081a8bdc77242a1  /lib/fir=
mware/rtlwifi/rtl8192dufw.bin

Regards
	Stefan Lippers-Hollmann

