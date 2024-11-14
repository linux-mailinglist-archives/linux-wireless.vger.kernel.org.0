Return-Path: <linux-wireless+bounces-15293-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 793A19C85C6
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 10:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3700D28294F
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 09:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CAC1DE4DF;
	Thu, 14 Nov 2024 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pmhahn.de header.i=@pmhahn.de header.b="ai5lbZ1f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from birdy.pmhahn.de (birdy.pmhahn.de [88.198.22.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E7EE573
	for <linux-wireless@vger.kernel.org>; Thu, 14 Nov 2024 09:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.198.22.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731575684; cv=none; b=p8mb2F+D5pNN4zhIoTW92sRL0UWXtDQFBzu4PKo6EPtV3TCNDTfPaosmlrie2YAqfFWSUSMXAnG+6xsg/6nbqDoDJrufRGdEfmB7qq4/LD2cUueW+0t/fZUsIEFedLzKOeEH/iu4RO9clcJCvHJlGEiiIjXQLfWlo33biXE7Fkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731575684; c=relaxed/simple;
	bh=l+SAW6gTEurKcDjFe2My3hQAiJh09LMK5RNJRaSwg7g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XvXPuy3azg9TL3WT0D2aQ8rrBfOfsb2mzw7t4ZkwzY0hqcvRpCfKy+uZ3xsuyWLo3jjYk5btuUcgyaPEAxfUO5KeK2hcFCCUlWhSE4YMIvX1NQ5tjvkwgZdL6cv0PxcgrzrAiYVbS0vrPXBMKggaKA8pS8QwxQU68ZNyb9HvzkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pmhahn.de; spf=pass smtp.mailfrom=pmhahn.de; dkim=pass (2048-bit key) header.d=pmhahn.de header.i=@pmhahn.de header.b=ai5lbZ1f; arc=none smtp.client-ip=88.198.22.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pmhahn.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pmhahn.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pmhahn.de; s=202202;
	t=1731575074; bh=l+SAW6gTEurKcDjFe2My3hQAiJh09LMK5RNJRaSwg7g=;
	h=Date:From:To:Cc:Subject:From;
	b=ai5lbZ1fy1waRBIURae0FEYzAgUjc4CPfQrLt5+3wQmHpdz7uHUrN0jEFTyFClLpL
	 FwYWPctFsUqMD2J4jNJd+vsbLNtjnIWRYCTXEMcB2BlAynkPV8qHzyFiflWnW5nvYA
	 OgU2D7mj8hadjayDOVS62E9ro2KXKi6IrbLGFOq4xv8KBgdjFlIH9xt588KsGZ6U2y
	 KunhUjWNqq4nrw4drUStQbW2HqJN6EBT8fJ/XMBfnR4tU8Q7AVUQh6OypWelv9KLFi
	 oVooqqOB7O5EQtJasC80Bt7VgKajdydiAv4bV5/57XmtRDdkDP6CEVf7OEWU5qMHwh
	 glH8qusp5pDjQ==
Received: from birdy.pmhahn.de (p200300e27748F4000309FD6c9a2C3c6F.dip0.t-ipconnect.de [IPv6:2003:e2:7748:f400:309:fd6c:9a2c:3c6f])
	by birdy.pmhahn.de (Postfix) with ESMTPSA id 457DA22112D3;
	Thu, 14 Nov 2024 10:04:34 +0100 (CET)
Date: Thu, 14 Nov 2024 10:04:32 +0100
From: Philipp Matthias Hahn <pmhahn@pmhahn.de>
To: iwd@lists.linux.dev, linux-wireless@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>
Subject: rtw89_8852ce + iwd stuck in (dis-)connect/-auth loop
Message-ID: <ZzW9IIrc-HYQuD6-@birdy.pmhahn.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

I finally switched from `wpa_supplicant` to `iwd` after having regular
issues with connectivity issues, so the following problem is probably
not related to `iwd` at all.

APs:
- FRITZ!Box 7490 one
  - 34:31:C4:27:99:ED (2.4 GHz)
  - 34:31:C4:27:99:EE (5 Ghz)
- FRITZ!Box 7490 two
  - E8:DF:70:4A:46:AB (2.4 GHz)
  - E8:DF:70:4A:46:AC (5 GHz)
- FRITZ!Powerline 1260E
  - F0:B0:14:88:AC:43 (2.4 GHz)
  - F0:B0:14:88:AC:47 (5 GHz)
- FRITZ!Powerline 540E
  - 5C:49:79:E1:C5:94 (2.4 GHz)

Debian-12-Buster
iwd original: 2.3, now: 3.1 self-compiled
Linux 6.10.11
04:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev 15)
        Subsystem: Hewlett-Packard Company RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller [103c:8b7c]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 19
        IOMMU group: 16
        Region 0: I/O ports at 3000 [size=256]
        Region 2: Memory at 80804000 (64-bit, non-prefetchable) [size=4K]
        Region 4: Memory at 80800000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: <access denied>
        Kernel driver in use: r8169
        Kernel modules: r8169

After a suspend (to RAM) overnight the connection cannot be
re-established and `iwd` is stuck in a re-connect/-auth loop:

Nov 14 09:11:35 phahn iwd[179340]: event: state, old: disconnected, new: autoconnect_quick
Nov 14 09:11:36 phahn iwd[179340]: udev interface=wlan0 ifindex=14
Nov 14 09:11:36 phahn iwd[179340]: event: connect-info, ssid: WBP4a Hahn +491702827535, bss: 34:31:c4:27:99:ee, signal: -78, load: 1/255
Nov 14 09:11:36 phahn iwd[179340]: event: state, old: autoconnect_quick, new: connecting (auto)
Nov 14 09:11:37 phahn iwd[179340]: event: state, old: connecting (auto), new: connected
Nov 14 09:11:46 phahn iwd[179340]: Received Deauthentication event, reason: 4, from_ap: false
Nov 14 09:11:46 phahn iwd[179340]: event: disconnect-info, reason: 4
Nov 14 09:11:46 phahn iwd[179340]: event: state, old: connected, new: disconnected
Nov 14 09:11:46 phahn iwd[179340]: event: state, old: disconnected, new: autoconnect_quick
Nov 14 09:11:47 phahn iwd[179340]: event: connect-info, ssid: WBP4a Hahn +491702827535, bss: f0:b0:14:88:ac:43, signal: -62, load: 23/255
Nov 14 09:11:47 phahn iwd[179340]: event: state, old: autoconnect_quick, new: connecting (auto)
Nov 14 09:11:47 phahn iwd[179340]: event: state, old: connecting (auto), new: connected
Nov 14 09:11:50 phahn iwd[179340]: Received Deauthentication event, reason: 4, from_ap: false
Nov 14 09:11:50 phahn iwd[179340]: event: disconnect-info, reason: 4
Nov 14 09:11:50 phahn iwd[179340]: event: state, old: connected, new: disconnected
Nov 14 09:11:50 phahn iwd[179340]: event: state, old: disconnected, new: autoconnect_quick
Nov 14 09:11:51 phahn iwd[179340]: event: connect-info, ssid: WBP4a Hahn +491702827535, bss: f0:b0:14:88:ac:43, signal: -56, load: 34/255
Nov 14 09:11:51 phahn iwd[179340]: event: state, old: autoconnect_quick, new: connecting (auto)
Nov 14 09:11:51 phahn iwd[179340]: event: state, old: connecting (auto), new: connected
Nov 14 09:11:56 phahn iwd[179340]: Received Deauthentication event, reason: 4, from_ap: false
Nov 14 09:11:56 phahn iwd[179340]: event: disconnect-info, reason: 4
Nov 14 09:11:56 phahn iwd[179340]: event: state, old: connected, new: disconnected
Nov 14 09:11:56 phahn iwd[179340]: event: state, old: disconnected, new: autoconnect_quick
Nov 14 09:11:57 phahn iwd[179340]: event: connect-info, ssid: WBP4a Hahn +491702827535, bss: 5c:49:79:e1:c5:94, signal: -61, load: 27/255
Nov 14 09:11:57 phahn iwd[179340]: event: state, old: autoconnect_quick, new: connecting (auto)
Nov 14 09:11:57 phahn iwd[179340]: event: state, old: connecting (auto), new: connected
Nov 14 09:12:03 phahn iwd[179340]: Received Deauthentication event, reason: 4, from_ap: false
Nov 14 09:12:03 phahn iwd[179340]: event: disconnect-info, reason: 4
Nov 14 09:12:03 phahn iwd[179340]: event: state, old: connected, new: disconnected
Nov 14 09:12:03 phahn iwd[179340]: event: state, old: disconnected, new: autoconnect_quick
Nov 14 09:12:04 phahn iwd[179340]: event: connect-info, ssid: WBP4a Hahn +491702827535, bss: f0:b0:14:88:ac:43, signal: -57, load: 33/255
Nov 14 09:12:04 phahn iwd[179340]: event: state, old: autoconnect_quick, new: connecting (auto)
Nov 14 09:12:04 phahn iwd[179340]: event: state, old: connecting (auto), new: connected
Nov 14 09:12:07 phahn iwd[179340]: Received Deauthentication event, reason: 4, from_ap: false
Nov 14 09:12:07 phahn iwd[179340]: event: disconnect-info, reason: 4
Nov 14 09:12:07 phahn iwd[179340]: event: state, old: connected, new: disconnected
Nov 14 09:12:07 phahn iwd[179340]: event: state, old: disconnected, new: autoconnect_quick
Nov 14 09:12:08 phahn iwd[179340]: event: connect-info, ssid: WBP4a Hahn +491702827535, bss: f0:b0:14:88:ac:43, signal: -55, load: 40/255
Nov 14 09:12:08 phahn iwd[179340]: event: state, old: autoconnect_quick, new: connecting (auto)
Nov 14 09:12:08 phahn iwd[179340]: event: state, old: connecting (auto), new: connected
Nov 14 09:12:16 phahn iwd[179340]: event: state, old: connected, new: disconnecting
Nov 14 09:12:16 phahn iwd[179340]: event: state, old: disconnecting, new: disconnected

Here's the dump of the kernel log:

[87572.028075] wlan0: authenticate with 34:31:c4:27:99:ee (local address=40:1a:58:f6:ca:6f)
[87572.028079] wlan0: send auth to 34:31:c4:27:99:ee (try 1/3)
[87572.031085] wlan0: authenticated
[87572.036527] wlan0: associate with 34:31:c4:27:99:ee (try 1/3)
[87572.039534] wlan0: RX AssocResp from 34:31:c4:27:99:ee (capab=0x1511 status=0 aid=2)
[87572.158153] wlan0: associated
[87572.158264] wlan0: Limiting TX power to 20 (23 - 3) dBm as advertised by 34:31:c4:27:99:ee
[87581.686018] wlan0: Connection to AP 34:31:c4:27:99:ee lost
[87582.508317] wlan0: authenticate with f0:b0:14:88:ac:43 (local address=40:1a:58:f6:ca:6f)
[87582.508323] wlan0: send auth to f0:b0:14:88:ac:43 (try 1/3)
[87582.517681] wlan0: authenticated
[87582.524152] wlan0: associate with f0:b0:14:88:ac:43 (try 1/3)
[87582.530272] wlan0: RX AssocResp from f0:b0:14:88:ac:43 (capab=0x1431 status=0 aid=7)
[87582.646537] wlan0: associated
[87582.646704] wlan0: Limiting TX power to 20 (20 - 0) dBm as advertised by f0:b0:14:88:ac:43
[87585.790526] wlan0: Connection to AP f0:b0:14:88:ac:43 lost
[87586.681575] wlan0: authenticate with f0:b0:14:88:ac:43 (local address=40:1a:58:f6:ca:6f)
[87586.681579] wlan0: send auth to f0:b0:14:88:ac:43 (try 1/3)
[87586.684607] wlan0: authenticated
[87586.685919] wlan0: associate with f0:b0:14:88:ac:43 (try 1/3)
[87586.691733] wlan0: RX AssocResp from f0:b0:14:88:ac:43 (capab=0x1431 status=0 aid=7)
[87586.806412] wlan0: associated
[87586.811404] wlan0: Limiting TX power to 20 (20 - 0) dBm as advertised by f0:b0:14:88:ac:43
[87591.935894] wlan0: Connection to AP f0:b0:14:88:ac:43 lost
[87592.828319] wlan0: authenticate with 5c:49:79:e1:c5:94 (local address=40:1a:58:f6:ca:6f)
[87592.828324] wlan0: send auth to 5c:49:79:e1:c5:94 (try 1/3)
[87592.831876] wlan0: authenticated
[87592.834046] wlan0: associate with 5c:49:79:e1:c5:94 (try 1/3)
[87592.844654] wlan0: RX AssocResp from 5c:49:79:e1:c5:94 (capab=0x1431 status=0 aid=1)
[87592.962487] wlan0: associated
[87592.962615] wlan0: Limiting TX power to 20 (20 - 0) dBm as advertised by 5c:49:79:e1:c5:94
[87598.534139] wlan0: Connection to AP 5c:49:79:e1:c5:94 lost
[87599.413011] wlan0: authenticate with f0:b0:14:88:ac:43 (local address=40:1a:58:f6:ca:6f)
[87599.413015] wlan0: send auth to f0:b0:14:88:ac:43 (try 1/3)
[87599.416010] wlan0: authenticated
[87599.418127] wlan0: associate with f0:b0:14:88:ac:43 (try 1/3)
[87599.428534] wlan0: RX AssocResp from f0:b0:14:88:ac:43 (capab=0x1431 status=0 aid=7)
[87599.542784] wlan0: associated
[87599.542912] wlan0: Limiting TX power to 20 (20 - 0) dBm as advertised by f0:b0:14:88:ac:43
[87603.006507] wlan0: Connection to AP f0:b0:14:88:ac:43 lost
[87603.894465] wlan0: authenticate with f0:b0:14:88:ac:43 (local address=40:1a:58:f6:ca:6f)
[87603.894470] wlan0: send auth to f0:b0:14:88:ac:43 (try 1/3)
[87603.897501] wlan0: authenticated
[87603.902232] wlan0: associate with f0:b0:14:88:ac:43 (try 1/3)
[87603.909625] wlan0: RX AssocResp from f0:b0:14:88:ac:43 (capab=0x1431 status=0 aid=7)
[87604.022839] wlan0: associated
[87604.022904] wlan0: Limiting TX power to 20 (20 - 0) dBm as advertised by f0:b0:14:88:ac:43
[87611.261845] wlan0: deauthenticating from f0:b0:14:88:ac:43 by local choice (Reason: 3=DEAUTH_LEAVING)

I have seen that "Limiting TX power to …" before with `wpa_supplicant`,
which also lead to a disconnect there, which triggered me to try `iwd`
now.

Last time unloading `rtw89_8852ce` and re-loading it did get it, but
only after switching Wifi off and on again in NetworkManager.

If you need more data, just tell we what you need.

I'm not afraid of compiling my own Linux kernel if that is needed.
I already switched from the regular Debian-12-Buster-Kernel 6.1.115 to
Debian's backports kernel 6.11 as the original kernel did not have the
`rtw89_8852ce` driver; I tried <https://github.com/lwfinger/rtw89> back
then, but did not get it working properly, which prompted me to switch
to the bpo kernel, which was easier.

PS: I'm not subscribed to to both `iwd` and `linux-wireless` lists.

Thanks in advance
Philipp Hahn

