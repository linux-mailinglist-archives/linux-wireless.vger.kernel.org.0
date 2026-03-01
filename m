Return-Path: <linux-wireless+bounces-32329-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WM4MO1J1pGnAhgUAu9opvQ
	(envelope-from <linux-wireless+bounces-32329-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 01 Mar 2026 18:20:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8C11D0CFD
	for <lists+linux-wireless@lfdr.de>; Sun, 01 Mar 2026 18:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00816300B05E
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Mar 2026 17:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641DA261B6D;
	Sun,  1 Mar 2026 17:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SETPebG5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C896D175A87
	for <linux-wireless@vger.kernel.org>; Sun,  1 Mar 2026 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772385615; cv=pass; b=WIQoNx6ucfJcHApv3t92zs5jj8fFnut9VQRfbhYomouFsWT+j4yK6X6+rjEj25oJ1uMROu70pGPJlrritX9znzRq7eL6P5c9ohbHBbbGfW5pMG96SGznN5AKgkhzmHxnTj5nKp9dduts07C8nMgP68gh979NYD1i2uYnYipxcNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772385615; c=relaxed/simple;
	bh=g0gjt6jmNwsdAP3/d0xvz+ZGEs8DLZbcxUtiFW5YppM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=itJy4MTEDcmltC1DILCBxliqsC10gkRtvGf8NN5TeojJy/PAHCLbCjNh+nzANyBYn1xWUQfStTV3P/B3PeLTaPAP6cceXDiEyadH5++wIPBemx//r8KdHtQ+u2EjJt6ogPveC7XYGCZ3S2OyFGOOlC1pfOhqvPd/YVQeiWDmXxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SETPebG5; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-389e139ee5eso55590161fa.0
        for <linux-wireless@vger.kernel.org>; Sun, 01 Mar 2026 09:20:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772385611; cv=none;
        d=google.com; s=arc-20240605;
        b=G5wowi2SW46mHU9kCotVuf+Z+pYLIWQB+XnZguxrnhiSeVcaatZu1cALsbjsVr79Qh
         gtIsLojUXwxHUX+OtkTCTL043ZVXWN742o65Pr2CEDuZ6ATVGaKuInh+p7pLciSkbc/G
         py8LDeaPmKCmhsbMVpifbvKyu0/+iyObj7qxUWuwbNeR3OBbQ9sm10uPFS4IhjPRJXZn
         NnBvV77tNjii4m3xCRmWVDdgJ4dfUPTlx//ewCl2nsmtE0CvhOqiRaqxr9XD55klG6kk
         sytpLPHFJb7vQGbRSachC8RTQeo9QFFm9ae+mQCorEaCXL4RxLZGHtjIy5q7XgT+7lG5
         EA+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=cWD5ulpuTnrzUSe8uNl+OmozoXXEeC6eKmY+U22xT/M=;
        fh=RYaBfUl6G2B0R/eF8Oc826waui9gLTv4uMlI5P6LZ6M=;
        b=f8iP4LCXUdBSJAvPl9BA3tEz5/TmxNCt89gwaK+4gg6Ay88HyzGpumzBErqgLRWaKR
         1hyxYd5j8dsygahXOFoGd7AaEBaIs/uV19uMs83y/9wu30GFBIEiVVFsxVNcYSKnQhV8
         uOxfLQZLo402rKaQT8w+P2ff3toMeL9NaGGwF6TGfSQl+hEZ03NxFBk9nOhyrUeFrJxK
         9Dut+4aGUqpgaqJRYd+YhiXcHaXwwLMSACSsfbPGCq9wZzuixhrVeLhHgHmEVDHUq7Zy
         W6UQ+Gmb4ilGfzKk/awXy+l99j3Cvsm18Y5+dI2F1rX16YjvznxlXe2d6/Nbf+VJEwWW
         Whdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772385611; x=1772990411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cWD5ulpuTnrzUSe8uNl+OmozoXXEeC6eKmY+U22xT/M=;
        b=SETPebG5jfgI7Ap0iax4CUx2gr/PEmaZIAhAHi/l0JOP98kDwYqL8LaRSI96gRvL/D
         fUxoAeJ/pEJNaMjf6C7iMpaBiiFGPBHgrDNWqq5es7OzicGomg37JI5wTjvSyZoR8Ayw
         LpKvtopgZa/SPrSQYZEvp1zw9yccOIELmVj8S9TZ+ooiQD5Q9OiEJ/YE+b4+sTmReuV4
         pSHSzQLJQh859JjJgEryM5vYxKhvXxzU7mZikZEyBjH9DysxVCEckaRZMQNd4YHN02D1
         91OEQ+B6QF/h9VHXzIhNqYeu4Gyj5lCFMA1X4wAtoJ3voBnLOnW7x8NHrERy1Mn0rKBW
         FRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772385611; x=1772990411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWD5ulpuTnrzUSe8uNl+OmozoXXEeC6eKmY+U22xT/M=;
        b=hdSGtAhOHEiyKRiQ8z/MJgT0Kag7gj5HwYkdIShlhxhdxRNY9IPIYHQUOkDJtFAxEg
         7DG5sRS4GXFZS7dW96ODURU/aOWcgzKDWreTjqmil1XcTRK+BJEfs7Vk2okThej8dUbX
         VmKs8X6nl7KFuo6xZ+xrLl8H7in95nnn44OaCVaiau2XfZgs+OsItVXApbgfNMQ11de0
         06zFVbEJNhhti1k4A4opOCdlJVq0M3ijapGGPZgNbArgg6tjVb/yrW7bOQ4c/Os7TyA8
         JAu3vK+KsGCuCkJbjcZdFGwhX5qyLTd+uxLekLXe2Ce/3Lht3FLYdlfRigwJ4GF3z7L7
         r0yQ==
X-Gm-Message-State: AOJu0YyxPNRybvAeG/sZJYQYsjcfJSRoAc5BWrILVRuhUKtcD2dVlgQ3
	dEA0Yz+SXB/sqemZZQ5rDujaDkW4BocurXlmyoHeiwvx+r4jAUfUyeiUs2QRREHtfnFXkvF428T
	m9xFx+CPVozkh4qK/odeZealysgBtTUygZ3uc
X-Gm-Gg: ATEYQzxPQMhwTBY335MqxDvtigCh8lN8+qycKxhEH1EogdE+skMwwgF/8kLwlbZRQT4
	k3B2LAys7/Xzr2Vef/fEHll4piXvYXSuBAz+yuB73pSTpjWLlN9iCiyKc7zKh/eukrE6sGCZBF6
	qMtkSAy4C/ChDAClPEY+TR8oEjLrvLVpHfV4kZoAmaSow2c44cCrxnA7JEIWGzlO9xLO6w6gokR
	VqMClEzRtB9zQxYHXcvzFI+WSax+S+/rxAaqYCdkw2+QPJ8uB8clEm7cX4FTYXfaxJG8QFdapUb
	apKI2yQ0Yw==
X-Received: by 2002:a05:651c:893:b0:389:fc69:45e8 with SMTP id
 38308e7fff4ca-389ff13552fmr68451931fa.13.1772385611069; Sun, 01 Mar 2026
 09:20:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chris Wituchowski <flashrift@gmail.com>
Date: Sun, 1 Mar 2026 09:19:59 -0800
X-Gm-Features: AaiRm50664WoV6NX37bGRxcMUhDj8FBLmxXD-sSpjVppxIu-Ruw0yAlaLS-YGpM
Message-ID: <CAMX+G=Yd2fF+56+xFSzffO5Fq_PhkD41sBNkmFMpU5anN+QkmQ@mail.gmail.com>
Subject: [REGRESSION] rtw89_8852ae: HT/VHT/HE not negotiated, stuck at 54 Mbps
 since kernel 6.18
To: linux-wireless@vger.kernel.org
Cc: pkshih@realtek.com, kvalo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32329-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[flashrift@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB8C11D0CFD
X-Rspamd-Action: no action

*resend as plaintext - sent originally as html, sorry!*

Hi,

I'm reporting a regression in the rtw89_8852ae driver. After upgrading from
kernel 6.14.x (Fedora 42 GA) to 6.18.x (Fedora 43), my RTL8852AE WiFi adapt=
er
no longer negotiates HT, VHT, or HE with the access point. The connection f=
alls
back to legacy 802.11a at 54 Mbps on 5 GHz, delivering only ~20 Mbps real-w=
orld
throughput on a gigabit link.

=3D=3D Hardware =3D=3D

  Adapter: Realtek RTL8852AE 802.11ax PCIe (WiFi 6, 2x2 MIMO)
  PCI ID:  10ec:8852 (subsystem: 17aa:4852, Lenovo)
  System:  Lenovo laptop

=3D=3D Software =3D=3D

  Broken:   6.18.13-200.fc43.x86_64 (also 6.18.10, 6.18.12 =E2=80=94 all br=
oken)
  Last OK:  6.14.x (Fedora 42 GA kernel =E2=80=94 WiFi worked at full 802.1=
1ax speeds)
  Driver:   rtw89_8852ae (in-tree)
  Firmware: rtw8852a_fw.bin (v0.13.36.2 / 52acc807)
  Distro:   Fedora 43

=3D=3D Symptoms =3D=3D

The adapter connects to a 5 GHz AP (channel 157) but fails to negotiate
HT/VHT/HE, falling back to legacy 20 MHz / 54 Mbps:

  $ iw dev wlp3s0 link
  Connected to 52:bb:9f:a2:d8:4a (on wlp3s0)
      SSID: Innernette
      freq: 5785.0
      signal: -29 dBm
      rx bitrate: 54.0 MBit/s
      tx bitrate: 54.0 MBit/s

  $ iw dev wlp3s0 info
      channel 157 (5785 MHz), width: 20 MHz (no HT), center1: 5785 MHz

Debugfs confirms the driver is not reporting any HT/VHT/HE capabilities
for the station:

  /sys/kernel/debug/ieee80211/phy*/netdev:wlp3s0/stations/<bssid>/ht:
      "ht not supported"

  /sys/kernel/debug/ieee80211/phy*/netdev:wlp3s0/stations/<bssid>/vht:
      "VHT not supported"

  /sys/kernel/debug/ieee80211/phy*/netdev:wlp3s0/stations/<bssid>/he:
      "HE not supported"

=3D=3D AP Capabilities (confirmed via iw scan) =3D=3D

The AP fully supports HT, VHT, and HE:

  - HT: HT20/HT40, MCS 0-15 (2 spatial streams)
  - VHT: up to 80 MHz, MCS 0-9 for 2 SS
  - HE (WiFi 6): full 802.11ax support
  - Max advertised rate: 1170 Mbps

The AP's "HT protection" field shows "non-HT mixed mode", confirming it
sees the client as a non-HT legacy station.

=3D=3D What I've Ruled Out =3D=3D

  1. Signal strength: Excellent (-27 to -48 dBm across tests)
  2. WPA3 vs WPA2: Same result with both (key-mgmt sae and psk)
  3. wpa_supplicant vs iwd: Same result with both backends
  4. Firmware: Already on latest version (v0.13.36.2)
  5. Driver reload: Full unload/reload of rtw89 module stack =E2=80=94 no c=
hange
  6. Power save: Disabled (disable_ps_mode module parameter)
  7. wl module conflict: Blacklisted via /etc/modprobe.d/blacklist-wl.conf
  8. Regulatory: US domain active, DFS-FCC, correct for channel 157
  9. Regression within 6.18.x: Changelogs for 6.18.10=E2=86=926.18.13 conta=
in
     ZERO rtw89/mac80211/cfg80211 changes. Bug exists across all 6.18.x.

=3D=3D Likely Cause =3D=3D

Between kernel 6.14 and 6.18, the rtw89 driver received hundreds of commits
for WiFi 7 MLO (Multi-Link Operation) support, including:

  - mac80211 per-link STA refactoring (HT/VHT/HE caps moved to per-link
    link_sta structures)
  - 54+ chanctx commits in rtw89 ("chan: manage active interfaces",
    "tweak setting of channel and TX power for MLO", etc.)
  - "disable EHT protocol by chip capabilities"

The RTL8852AE is a gen1 WiFi 6 chip. The MLO work was developed and tested
primarily on gen2 WiFi 7 chips (RTL8922A/E). It appears the gen1 code path
through the new per-link framework is not correctly populating HT/VHT/HE
capabilities during association.

=3D=3D Steps to Reproduce =3D=3D

  1. System with RTL8852AE (10ec:8852) running kernel 6.18.x
  2. Connect to any 5 GHz 802.11ax access point
  3. Observe: iw dev <if> info shows "width: 20 MHz (no HT)"
  4. Observe: iw dev <if> link shows 54.0 MBit/s bitrate
  5. Observe: debugfs ht/vht/he files all report "not supported"

=3D=3D Expected Result =3D=3D

Connection should negotiate HT/VHT/HE (80 MHz, WiFi 6) as it did on
kernel 6.14.x, providing 800+ Mbps link rates.

Thanks,
Chris

