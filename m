Return-Path: <linux-wireless+bounces-22103-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CCEA9DDF0
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Apr 2025 01:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACFB61B61F36
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Apr 2025 23:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477991FF7B3;
	Sat, 26 Apr 2025 23:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="Xu0yPlSx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1381DFF0
	for <linux-wireless@vger.kernel.org>; Sat, 26 Apr 2025 23:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745711752; cv=none; b=frmcuJYTw8cIBH6hsmh3INYzF3Y0Dp45jSYw1yQljvOxsNJhgwhQLpvZlG4CHLsQPPot/u1UR5xndVDtPTYJnCHBx7jrJ2dgKHa+b29TeIqXgceZG8/5c3u4lJTFjAO4UUF6kWhbOSSDv+bwwfOaP1/ZYWamU3CXU8EEAvV1sLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745711752; c=relaxed/simple;
	bh=sZukwQouq5e8baLeOsu75MRGU0eGNisjXGvwRrgnHVw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Irw4mhFJVQCwMqe7aL+JeKALTepqAv4DeWX7StPInRon8Pno5E6SKFcfasqG88ai0aVROTKbOWPpPptFjTazcK0lclWNQAh82eulVkSZZWQ9Wyj9fGvS8mXXzjeLYNZ7wwQOkVTGDVQRq/+F3hVBGLswQt5bjiJSQhv1yDdBbeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=Xu0yPlSx; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1745711313; bh=sZukwQouq5e8baLeOsu75MRGU0eGNisjXGvwRrgnHVw=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:From;
	b=Xu0yPlSxUDgUb73OdbRopQ5K2HujnsBN/C01Kc/CKTZuIyDLEqsx0EirqppLNf3to
	 IqrWyu6y+LrdAZZ5wfhuSf38LXaODIwJcJLGsyzibukJ8xBVC8dJGVPdasMqfX6+/p
	 s5AeCgb7qq5iQcQugVd65rndAtA0OBiBrQ7BqSg8=
Date: Sun, 27 Apr 2025 01:48:32 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org
Subject: "no IR" issue with multiple cards using rtw89 driver in one system
Message-ID: <2goskmst4na36v42p2bs47uernp6kh3gzpadhr3u3r2yvyoxlg@bfprgq2qae7p>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I've spent a better part of a day chasing a weird perhaps regulatory related
issue in rtw89 driver, which I think may be useful reporting on. :)

I have a dual wifi card system, with both cards serving as APs: RTL8852AE
and RTL8852CE.

I observe two things:

- hostapd fails to start 5G AP on either RTL8852AE or RTL8852CE with this in the
  log:

  wlan-5g: interface state UNINITIALIZED->COUNTRY_UPDATE
  Frequency 5180 (primary) not allowed for AP mode, flags: 0x11873 NO-IR
  Primary frequency not allowed
  wlan-5g: IEEE 802.11 Configured channel (36) or frequency (5180)
    (secondary_channel=1) not found from the channel list of the current mode (2)
    IEEE 802.11a
  wlan-5g: IEEE 802.11 Hardware does not support configured channel
  Could not select hw_mode and channel. (-3)
  wlan-5g: interface state COUNTRY_UPDATE->DISABLED
  wlan-5g: AP-DISABLED
  wlan-5g: Unable to setup interface.
  wlan-5g: interface state DISABLED->DISABLED
  wlan-5g: AP-DISABLED
  wlan-5g: CTRL-EVENT-TERMINATING
  hostapd_free_hapd_data: Interface wlan-5g wasn't started
  nl80211: deinit ifname=wlan-5g disabled_11b_rates=0
  wlan-5g: IEEE 802.11 Configured channel (36) or frequency (5180)
    (secondary_channel=1) not found from the channel list of the current mode (2)
    IEEE 802.11a
  wlan-5g: IEEE 802.11 Hardware does not support configured channel
  
  (previously it worked fine)

- I can see this in `iw phy` output for both cards:

  Frequencies:
  * 5180.0 MHz [36] (20.0 dBm) (no IR)
  * 5200.0 MHz [40] (20.0 dBm) (no IR)
  * 5220.0 MHz [44] (20.0 dBm) (no IR)
  * 5240.0 MHz [48] (20.0 dBm) (no IR)
  
- And now the interesting thing. no IR flag is only present, when both cards
  are installed at once in the system.

- When I remove either one of the cards, "no IR" flags are gone from
  5G band channels in `iw phy` output and hostapd starts successfully.

- Both cards have \xff\xff in efuse.country_code (so they are WW roaming cards,
  I guess)

- Interestingly this did not happen when I was using RTL8822AE instead of
  RTL8852CE in this system. So this seem to be somehow triggered by using
  two cards driven by rtw89 driver.

`iw reg get` always returns in any case (and hostapd is set up with country_code=CZ
for both cards):

global 
country CZ: DFS-ETSI
	(2400 - 2483 @ 40), (N/A, 20), (N/A)
	(5150 - 5250 @ 80), (N/A, 23), (N/A), NO-OUTDOOR, AUTO-BW
	(5250 - 5350 @ 80), (N/A, 20), (0 ms), NO-OUTDOOR, DFS, AUTO-BW
	(5470 - 5725 @ 160), (N/A, 26), (0 ms), DFS
	(5725 - 5875 @ 80), (N/A, 13), (N/A)
	(5945 - 6425 @ 320), (N/A, 23), (N/A), NO-OUTDOOR
	(57000 - 66000 @ 2160), (N/A, 40), (N/A)

I'm wondering how "no IR" flag can appear on 5G channels when I have two
cards in one system, and disappear when I have just one installed, all other
things being equal. :)

Best regards,
	Ondrej

