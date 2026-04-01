Return-Path: <linux-wireless+bounces-34289-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJLWKUerzWlRfwYAu9opvQ
	(envelope-from <linux-wireless+bounces-34289-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 01:33:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9B4381AFF
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 01:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0390D301FF95
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2026 23:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E82E1FA272;
	Wed,  1 Apr 2026 23:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/5T8d5h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF19611E
	for <linux-wireless@vger.kernel.org>; Wed,  1 Apr 2026 23:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775086395; cv=none; b=e//PpzCnF0Iqdxfh0oO6hzJTp3hz8BSoplsSBdmduarIlKptrNam73+I6QbZEDOPbNxLwR0be3b8WsSeVug9E6ekXpnmgMxPMdf2opqE7zEEhV/kouEqdLDqmqkxD+I5VXUyFIvAywr/6c+SuADlB27TQWBpbqCH2gop5Hz9Seg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775086395; c=relaxed/simple;
	bh=1sXBNqug0DkE2sO3RKQReACBcJvWTOGM7QqwiJSRO1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X332WVVkDGnLpNod8earw3vHCKeOqvX3lG+FNUKGvPwUNOPEMPQSZO6Bjb0RkesKutec0fMFcDBmUmjPPtOTLMzH06hV1UkVUBeW5v4Ng2spEnaq+8FaCkEIMu99cChYzoNsqcZoqgdwLI/W9aaNaRtntxTAyRDw61wnwF0/kzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/5T8d5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF08FC4CEF7
	for <linux-wireless@vger.kernel.org>; Wed,  1 Apr 2026 23:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775086394;
	bh=1sXBNqug0DkE2sO3RKQReACBcJvWTOGM7QqwiJSRO1g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b/5T8d5hK0Af0DpF0zqeb3jsYu8NsJg3mz2UzZZplfwnYEiZO7g2QA3Ff1NC7R4XJ
	 0gowvLGs0sXRxQMBqi8h8owSdKNg7+ZvH2B1DICiRBsC5aooxonbeOSuDztkf4SkGs
	 UA9DK8ybPw8uRake+0k2t6TLlChHe8W91kNaI+RnWO12YauXMI9V9rCX0HB5RvXDSO
	 4jB5lScb1ASi6LJFVLnLqoHMQ0uqnhGmjemtWh+LndetKe+NKxgeRzWo/+oYYB6VIU
	 YmnqsJR+jGhbkWDp+wpOduMqwJq83LphwNQe8nLfmKG2bEca1MpwB/aDp0iq3aVgGi
	 uh6Q/6IiGERPA==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38cc8708d76so2537111fa.3
        for <linux-wireless@vger.kernel.org>; Wed, 01 Apr 2026 16:33:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWsf1FLAgcK6aaDqP/8Akvvjm2nr6wINHlF4XQtGj7euv/9mMyfM/S3KkdaEZDWreVRjT1iZ7a7Bf98wj8eLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIElFabQoIc6zVtLJv8MAMM18+s7Wjm2lb/t/qyIN+Hkhv4gU4
	050DpEGMOjQI5JfNg9X4yEsyX7PfqjH3dfV5U78d8qS+L+d2ph4nFEgKOCtFVIv/KME7jb6Af7Q
	cp8VRIA0gNqxBmVhuL0+oj0s+g9LiRxg=
X-Received: by 2002:a2e:96c4:0:b0:38b:fd3e:c42f with SMTP id
 38308e7fff4ca-38cc2f6d560mr14044901fa.14.1775086393244; Wed, 01 Apr 2026
 16:33:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEoHs0hONW_X8POryv-YC8ahGAVoOsvXXJw9VnDOguSgq52v=Q@mail.gmail.com>
In-Reply-To: <CAEoHs0hONW_X8POryv-YC8ahGAVoOsvXXJw9VnDOguSgq52v=Q@mail.gmail.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Wed, 1 Apr 2026 18:33:00 -0500
X-Gmail-Original-Message-ID: <CAGp9LzqMNFwQVg248rxEQ=YPhqABprVGMHx2jREmSBBzSW91aw@mail.gmail.com>
X-Gm-Features: AQROBzDkN6WEAOoeEce2wboeQZfOu-bn-7y38aYDKlWopxuom81kQnrkfRRU5wI
Message-ID: <CAGp9LzqMNFwQVg248rxEQ=YPhqABprVGMHx2jREmSBBzSW91aw@mail.gmail.com>
Subject: Re: [BUG] mt7925e: MSI Vector A16 HX A8WHG-004US reports permanent
 hardware rfkill block under Linux; ACPI GPPA.WLAN AE_ALREADY_EXISTS
To: Ross <rosspayant@gmail.com>
Cc: linux-mediatek@lists.infradead.org, nbd@nbd.name, lorenzo@kernel.org, 
	ryder.lee@mediatek.com, shayne.chen@mediatek.com, sean.wang@mediatek.com, 
	deren.wu@mediatek.com, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34289-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0A9B4381AFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Mon, Mar 9, 2026 at 2:20=E2=80=AFPM Ross <rosspayant@gmail.com> wrote:
>
> Hello, I want to report a wifi bug. This bug makes the wifi hard lock
> on my computer under Arch Linux as well as Fedora. Wifi does work on
> Linux LTE and Windows 11. The computer is a Vector A16 HX A8WHG-004US
> and this it's actually the second I bought. I returned the first one
> because of the exact same bug. Since I got the second one I've stuck
> it through hoping there would be a fix, it's been three months now.
> I've tried all the possible fixes (on both machines), nothing. "sudo
> rfkill unblock all" and "sudo rfkill unblock wifi" do not work. There
> is no switch in the bios or "airplane mode" hotkey to toggle either.
> The wifi just does not work in Linux (apart from LTE). I've updated
> the bios to the new version every time a new one drops (including the
> most recent one from a couple days ago) and nothing has changed
> anything. I've updated everything else frequently. No dice.
>
> Anyway, I suppose this is where I go to file report bugs like this?
> I've never issued a bug report before so I'm not sure. Thank you so
> much for giving this the time of day, as well as all the other work
> you do on the LInux project. If you need further information I'll give
> you whatever you need.
>
> I had the following written for me by AI but I can confirm it's
> accurate to the problem:
>
>
> I am reporting what appears to be an MSI-platform-specific MT7925
> hard-rfkill issue on Linux.
>
> Hardware
> - Laptop: MSI Vector A16 HX A8WHG-004US
> - WLAN: MEDIATEK MT7925 802.11be 160MHz 2x2 PCIe Wireless Network
> Adapter [14c3:7925]
> - Subsystem: Foxconn International, Inc. Device [105b:e138]
>
> Software
> - BIOS: E15MMAMS.107
> - Kernel: 6.19.6-arch1-1
> - linux-firmware: 20260221-1
> - Distro: Arch Linux
>
> Problem
> - The Wi-Fi device is detected correctly.
> - The mt7925e driver binds successfully.
> - Firmware appears to load.
> - The interface is created/renamed to wlp5s0.
> - However, rfkill always reports the WLAN as hard blocked.
>
> Current rfkill state
> - Bluetooth: Soft blocked: no / Hard blocked: no
> - Wireless LAN: Soft blocked: no / Hard blocked: yes
>
> Attempted commands
> - sudo rfkill unblock wifi
> - sudo rfkill unblock all
>
> Neither command changes the WLAN hard block.
>
> Relevant observations
> - lspci shows:
> MEDIATEK Corp. MT7925 802.11be 160MHz 2x2 PCIe Wireless Network
> Adapter [Filogic 360] [14c3:7925]
> Kernel driver in use: mt7925e
> - The boot log shows the device being enabled, ASIC revision detected,
> firmware information printed, and the interface renamed from wlan0 to
> wlp5s0.
> - The same boot log also shows repeated ACPI errors involving WLAN
> objects under \_SB.PCI0.GPPA.WLAN..., including repeated
> AE_ALREADY_EXISTS failures.
>
> This makes it look like:
> - the device is present,
> - the mt7925e driver is loading,
> - but platform/ACPI state may be forcing or misreporting hardware rfkill.
>
> Relevant kernel log excerpt
>
> mt7925e 0000:05:00.0: enabling device (0000 -> 0002)
> mt7925e 0000:05:00.0: ASIC revision: 79250000
> mt7925e 0000:05:00.0: HW/SW Version: 0x8a108a10, Build Time: 202601061530=
07a
> mt7925e 0000:05:00.0: WM Firmware Version: ____000000, Build Time:
> 20260106153120
> mt7925e 0000:05:00.0 wlp5s0: renamed from wlan0
>

From the logs so far, this does not look like a basic mt7925e
initialization failure. The device probes normally, firmware loads,
and the interface is created, but the WLAN still ends up reported as
hard blocked, so Wi-Fi never becomes usable. Typically, this kind of
blocked state comes from a platform-level source, such as a hardware
radio switch or platform-provided radio state, rather than from the
mt7925e path itself.

> ACPI BIOS Error (bug): Failure creating named object
> [\_SB.PCI0.GPPA.WLAN._S0W], AE_ALREADY_EXISTS
> ACPI BIOS Error (bug): Failure creating named object
> [\_SB.PCI0.GPPA.WLAN._S4W], AE_ALREADY_EXISTS
> ACPI BIOS Error (bug): Failure creating named object
> [\_SB.PCI0.GPPA.WLAN._DSM], AE_ALREADY_EXISTS
> ACPI BIOS Error (bug): Failure creating named object
> [\_SB.PCI0.GPPA.WLAN.PCIF], AE_ALREADY_EXISTS
> ACPI BIOS Error (bug): Failure creating named object
> [\_SB.PCI0.GPPA.WLAN.NVID], AE_ALREADY_EXISTS
> ACPI BIOS Error (bug): Failure creating named object
> [\_SB.PCI0.GPPA.WLAN.NDID], AE_ALREADY_EXISTS
> ACPI BIOS Error (bug): Failure creating named object
> [\_SB.PCI0.GPPA.WLAN.PWR1], AE_ALREADY_EXISTS
> ACPI BIOS Error (bug): Failure creating named object
> [\_SB.PCI0.GPPA.WLAN._PR0], AE_ALREADY_EXISTS
> ACPI BIOS Error (bug): Failure creating named object
> [\_SB.PCI0.GPPA.WLAN._PR2], AE_ALREADY_EXISTS
> ACPI BIOS Error (bug): Failure creating named object
> [\_SB.PCI0.GPPA.WLAN._PR3], AE_ALREADY_EXISTS
> ACPI BIOS Error (bug): Failure creating named object
> [\_SB.PCI0.GPPA.WLAN.PWFR], AE_ALREADY_EXISTS
> ACPI BIOS Error (bug): Failure creating named object
> [\_SB.PCI0.GPPA.WLAN._PRR], AE_ALREADY_EXISTS
>
> Reproduction
> 1. Boot Linux normally.
> 2. Run:
> rfkill list all
> 3. Wireless LAN is always reported as:
> Soft blocked: no
> Hard blocked: yes
>
> Additional notes
> - Windows 11 on the same laptop can use Wi-Fi normally.
> - Updating BIOS from E15MMAMS.106 to E15MMAMS.107 did not resolve the iss=
ue.
> - This may be similar in shape to other MT7925 hard-rfkill issues that
> required a machine-specific quirk, but on this MSI model the prominent
> clue is the repeated ACPI GPPA.WLAN object collision.
>
> Please let me know if you want:
> - full lspci -nnk output
> - full dmesg/journalctl -b -k
> - acpidump / decoded DSDT
> - additional testing with a proposed patch or boot parameter
>
> --
> Ross Payant
>

