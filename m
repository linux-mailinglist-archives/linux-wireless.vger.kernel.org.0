Return-Path: <linux-wireless+bounces-32773-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKEFKlker2neOAIAu9opvQ
	(envelope-from <linux-wireless+bounces-32773-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 20:24:09 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E2E23FC05
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 20:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A3FD317C4B1
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 19:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33BC35DA79;
	Mon,  9 Mar 2026 19:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpBXg8qx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E09123C4FA
	for <linux-wireless@vger.kernel.org>; Mon,  9 Mar 2026 19:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773083565; cv=pass; b=eaPhM6Cb3B9g8ioq0XmXbUU/ajsHP0bFLilJ9rZMXWCu+d7VPqXIk32hW5MpfjFwQ37/4/l1NW1841+QP01BZLDVfsh3F0K1vPV2sjl+EYznYddDhCUWngJDxFtv8IpjtL/aA7YPa7EFIArIXW15BB0koZ9T9wxJ2h2B9eOZ/so=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773083565; c=relaxed/simple;
	bh=oJ3lgCgLI0ZgM+iGcPJDb8Q96iU+aCxhvsm2qs7fMcQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=BGWZ+QibRYz65RYhCPKpwMjAybNh64BVPX0TJTrgtQYCAEubWp4levXDu8NjXsO0mGkLjaZMvTiHhiTKtsIMmFpkreAyYXY+8aEdrHUuw97JkvhwECig5REpULqpc6U6MjnTZPxt8M6t/yNzoma4/8WcJ4sZNMLutJjj6s7YQbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpBXg8qx; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-509143c1620so1427411cf.2
        for <linux-wireless@vger.kernel.org>; Mon, 09 Mar 2026 12:12:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773083563; cv=none;
        d=google.com; s=arc-20240605;
        b=QdieYP+AZ4h5/ENs1gfz45KCjr2S178FrpPbsThMGQ/Xoa6AcMUfUS5OHzpNo7+gX2
         tJLMxGSXPGO7/N98YkU5rezC36pdnZfys8c9DBAddaQpyd+QCiW2HSBwEaM2wnL/R+ER
         Nz4gISKs56LweiRgvesLw9jUxl4wg7wqymFq8Z/DFQcfSOjR3dRhZiM0WmvdYWKx3DM2
         CqDpgXe+OZZ/IXaL0c1mc+u9oZUX0t6EQwUyF2srASyebyX7AuHaVf+xy0i5S1jpH8uc
         FU65u/CM1E8qJ1ebcAJKVGXVFE/7vZCE7g3gnTGHi4UKQR/JHJiZ1iOGnXRWILu/Mrh1
         xeDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=pXhBEdQGcnN0qoRku0HoZmNcFhiZMtfh8n8ATcjwOdc=;
        fh=aEmVlbB12a4QXELNz/cBXOjHzKtSrxo7eDoyoyNGg6g=;
        b=kfEhsAAsRM/ox0jVWJiRCqGbJf9tMwdVWBB1S4FNOUKxu3rciDb4s+r8V6cHau5ObC
         GkT8Uv6kvh9bCA7aKdMhi9tstZRGosY92zHh6X/64qZDn247Wyfk2nRd9MI9swSRUE2f
         brmU3tLPcUJ5ZKIxNSRBwyVeO9BJEkaUm/nzxpfkOyyTjlq2Qy19vezRVXu3IDYk+Hyt
         2Oln3uPQ6HaiNPu2S+fOmnKreEcX/uG/ttl/CjZku6gk3vq8xOL71q19c71Fvd0v1iSC
         TrwLCLEii8X00O6r4ssZ+iIG0ULr+Wwhk0QjQBOldT179WBrgCP3NDJkuuieXi8tDGuE
         Z/Ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773083563; x=1773688363; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pXhBEdQGcnN0qoRku0HoZmNcFhiZMtfh8n8ATcjwOdc=;
        b=jpBXg8qxfmLh7NbqZQUHeuZKdVjU5dHYg1c9nlu6exo8tfIyBiB4w6yym8CYStIhFu
         ajvK278zoa3bdL3G5BVg13qMSo6cccaCoF7Nmftx43emZv8GdTw9PpeTl3tr095fh3F9
         e74sdfFr2QRLVuLCGehmacpREDVnV97/QTTJrpHXecGrxaFET79S6MiWnqMlHJyInyVL
         TjyGCEQZRyY2tmUUb435moefZ7w6DpYRVJg311PfDGm4xI7ihgQFFGNVf9wBY7Ccn7HM
         4fzGdAGasNDg1q/YiJPRUBFEiJPli7+q1crCiFcwB41DBpjWkqH0darNo4iRy3R8jzbg
         aX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773083563; x=1773688363;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pXhBEdQGcnN0qoRku0HoZmNcFhiZMtfh8n8ATcjwOdc=;
        b=cpzbsvpKIRqGmtq2lXG12w0HrPDv8/KFI/MALaUNK2mJ+mM//fsHCKTlkXW0TitZDH
         wvSIkpqKj2QJW3cA/PlwMpJazrMwMCYrTOUplGJxy0oPw/lQaUoFsK5qTW0+Our9Z0/3
         Cy7G+Z0KFENbJnFx5bzICqoFL35IVVZ2mZFP3/nzSigHraoAlXVtM6IGt1sEOVA9syGh
         S65W1MhTYyNMDz5eRQpyik9Nd1Ipxir48iefVLNoYujW9ActVcqA9QkeNLe5f99Y2vNC
         x8/bDu0KnO97ZMlibwdcXl56IBdxcufNDwcA55v5PeCj1DGiH8U+/lBmEH8GSUasl1NE
         suwg==
X-Forwarded-Encrypted: i=1; AJvYcCW9qaAcg07hygu6Zxcevo87L37Mwehh/BF06I9QXoPczcIJuG28j7TO0ZkNl6CZeXA0Vf7SbvV8YZRH5JuZdA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5mTx1pRTeLPykfGtarXvua+V3c56EwlQU2br+WKyNok3sUovc
	Et6468h4XBLXOMCsBV9HVyHpoGbme0ujC91dKvZM2O8wdhi5IIj5bpR7PfB1tGNZrHD4YiaD6zd
	XZW2yGvqMh0F4rIxzeXhMOw03mCt+/A==
X-Gm-Gg: ATEYQzz1W42FNi3JS4OStkPLeD3Q9xkWMlqbBY2NmPv1r4OIxQUgb8ahT+k5YnoMfQE
	g8J//h5KSGlfllmFJ0ELKfoUzywfZj2UL3+vXosOJwbXDu5blmkTOIuJIG3zJgCOPG3yYu6fSXn
	q6hzOVN6RPh5FsdfC6i81AzwG6eowtXnuzRdRF4DEaCqbT6Bq+2LjLAhU/woGxUgaHFCWWvJgv0
	eTqu2CjKg2yDtN2N4Wsab5iIKXRHqFeFm0Z1/CHWccKrsBOerJRgxRXtIjqdxKzHY0xCM4YZ0nJ
	7QHCBqg4k+3CgIwEjyyC6quDIEkSrSTEQN9PvCf5SRsu7cDznYLwJ5n+qyB2GAZJeFrYPQ==
X-Received: by 2002:a05:622a:1a92:b0:509:219f:8e34 with SMTP id
 d75a77b69052e-509219f950cmr27757211cf.0.1773083562925; Mon, 09 Mar 2026
 12:12:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ross <rosspayant@gmail.com>
Date: Mon, 9 Mar 2026 15:13:15 -0400
X-Gm-Features: AaiRm51jddNVjoRcK1qA5v9l-_4tFtwEQK9aBsMeUXcvrw54qUePQscalDtrb1s
Message-ID: <CAEoHs0hONW_X8POryv-YC8ahGAVoOsvXXJw9VnDOguSgq52v=Q@mail.gmail.com>
Subject: [BUG] mt7925e: MSI Vector A16 HX A8WHG-004US reports permanent
 hardware rfkill block under Linux; ACPI GPPA.WLAN AE_ALREADY_EXISTS
To: linux-mediatek@lists.infradead.org
Cc: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com, 
	shayne.chen@mediatek.com, sean.wang@mediatek.com, deren.wu@mediatek.com, 
	linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 26E2E23FC05
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32773-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosspayant@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hello, I want to report a wifi bug. This bug makes the wifi hard lock
on my computer under Arch Linux as well as Fedora. Wifi does work on
Linux LTE and Windows 11. The computer is a Vector A16 HX A8WHG-004US
and this it's actually the second I bought. I returned the first one
because of the exact same bug. Since I got the second one I've stuck
it through hoping there would be a fix, it's been three months now.
I've tried all the possible fixes (on both machines), nothing. "sudo
rfkill unblock all" and "sudo rfkill unblock wifi" do not work. There
is no switch in the bios or "airplane mode" hotkey to toggle either.
The wifi just does not work in Linux (apart from LTE). I've updated
the bios to the new version every time a new one drops (including the
most recent one from a couple days ago) and nothing has changed
anything. I've updated everything else frequently. No dice.

Anyway, I suppose this is where I go to file report bugs like this?
I've never issued a bug report before so I'm not sure. Thank you so
much for giving this the time of day, as well as all the other work
you do on the LInux project. If you need further information I'll give
you whatever you need.

I had the following written for me by AI but I can confirm it's
accurate to the problem:


I am reporting what appears to be an MSI-platform-specific MT7925
hard-rfkill issue on Linux.

Hardware
- Laptop: MSI Vector A16 HX A8WHG-004US
- WLAN: MEDIATEK MT7925 802.11be 160MHz 2x2 PCIe Wireless Network
Adapter [14c3:7925]
- Subsystem: Foxconn International, Inc. Device [105b:e138]

Software
- BIOS: E15MMAMS.107
- Kernel: 6.19.6-arch1-1
- linux-firmware: 20260221-1
- Distro: Arch Linux

Problem
- The Wi-Fi device is detected correctly.
- The mt7925e driver binds successfully.
- Firmware appears to load.
- The interface is created/renamed to wlp5s0.
- However, rfkill always reports the WLAN as hard blocked.

Current rfkill state
- Bluetooth: Soft blocked: no / Hard blocked: no
- Wireless LAN: Soft blocked: no / Hard blocked: yes

Attempted commands
- sudo rfkill unblock wifi
- sudo rfkill unblock all

Neither command changes the WLAN hard block.

Relevant observations
- lspci shows:
MEDIATEK Corp. MT7925 802.11be 160MHz 2x2 PCIe Wireless Network
Adapter [Filogic 360] [14c3:7925]
Kernel driver in use: mt7925e
- The boot log shows the device being enabled, ASIC revision detected,
firmware information printed, and the interface renamed from wlan0 to
wlp5s0.
- The same boot log also shows repeated ACPI errors involving WLAN
objects under \_SB.PCI0.GPPA.WLAN..., including repeated
AE_ALREADY_EXISTS failures.

This makes it look like:
- the device is present,
- the mt7925e driver is loading,
- but platform/ACPI state may be forcing or misreporting hardware rfkill.

Relevant kernel log excerpt

mt7925e 0000:05:00.0: enabling device (0000 -> 0002)
mt7925e 0000:05:00.0: ASIC revision: 79250000
mt7925e 0000:05:00.0: HW/SW Version: 0x8a108a10, Build Time: 20260106153007a
mt7925e 0000:05:00.0: WM Firmware Version: ____000000, Build Time:
20260106153120
mt7925e 0000:05:00.0 wlp5s0: renamed from wlan0

ACPI BIOS Error (bug): Failure creating named object
[\_SB.PCI0.GPPA.WLAN._S0W], AE_ALREADY_EXISTS
ACPI BIOS Error (bug): Failure creating named object
[\_SB.PCI0.GPPA.WLAN._S4W], AE_ALREADY_EXISTS
ACPI BIOS Error (bug): Failure creating named object
[\_SB.PCI0.GPPA.WLAN._DSM], AE_ALREADY_EXISTS
ACPI BIOS Error (bug): Failure creating named object
[\_SB.PCI0.GPPA.WLAN.PCIF], AE_ALREADY_EXISTS
ACPI BIOS Error (bug): Failure creating named object
[\_SB.PCI0.GPPA.WLAN.NVID], AE_ALREADY_EXISTS
ACPI BIOS Error (bug): Failure creating named object
[\_SB.PCI0.GPPA.WLAN.NDID], AE_ALREADY_EXISTS
ACPI BIOS Error (bug): Failure creating named object
[\_SB.PCI0.GPPA.WLAN.PWR1], AE_ALREADY_EXISTS
ACPI BIOS Error (bug): Failure creating named object
[\_SB.PCI0.GPPA.WLAN._PR0], AE_ALREADY_EXISTS
ACPI BIOS Error (bug): Failure creating named object
[\_SB.PCI0.GPPA.WLAN._PR2], AE_ALREADY_EXISTS
ACPI BIOS Error (bug): Failure creating named object
[\_SB.PCI0.GPPA.WLAN._PR3], AE_ALREADY_EXISTS
ACPI BIOS Error (bug): Failure creating named object
[\_SB.PCI0.GPPA.WLAN.PWFR], AE_ALREADY_EXISTS
ACPI BIOS Error (bug): Failure creating named object
[\_SB.PCI0.GPPA.WLAN._PRR], AE_ALREADY_EXISTS

Reproduction
1. Boot Linux normally.
2. Run:
rfkill list all
3. Wireless LAN is always reported as:
Soft blocked: no
Hard blocked: yes

Additional notes
- Windows 11 on the same laptop can use Wi-Fi normally.
- Updating BIOS from E15MMAMS.106 to E15MMAMS.107 did not resolve the issue.
- This may be similar in shape to other MT7925 hard-rfkill issues that
required a machine-specific quirk, but on this MSI model the prominent
clue is the repeated ACPI GPPA.WLAN object collision.

Please let me know if you want:
- full lspci -nnk output
- full dmesg/journalctl -b -k
- acpidump / decoded DSDT
- additional testing with a proposed patch or boot parameter

-- 
Ross Payant

