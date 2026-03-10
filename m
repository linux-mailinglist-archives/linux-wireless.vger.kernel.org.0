Return-Path: <linux-wireless+bounces-32910-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODZEEW41sGnRhAIAu9opvQ
	(envelope-from <linux-wireless+bounces-32910-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 16:14:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB8F253105
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 16:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B1E1304BD20
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 15:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699842FD68B;
	Tue, 10 Mar 2026 15:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUMtwsMa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D8B28504D
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155586; cv=pass; b=L4tahqGkKIl/AbyjNbL+Fqr7/6VaFMNrMAEzvZnvO92lkan2cIk4JUPmtqTorqfjCMBbWLPPEGtjaK+vbCzUiNXskiZMmO26JoUOMy3WV8tRdBWJoz0G1hjSiS7HWkIlqysYs0iu46XNPJabsHE9i5yknertBTqtaMNWgX2G0jI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155586; c=relaxed/simple;
	bh=PMBgRVe7ASFVZz+OyPGYr/DeCcAOHYnN9P1xHlQ7WyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZpZhcPcHjab4NN0qglvQsOf6wvaT+R43F88qCXVGQEvdtQayMeGe9KDwQd+7/MKFzVC8pjHVqO/aXChN/JzbPl4KZVoyRbs1/2ERfMBbAJ+PGTHhCBChwstIQT9TNU+Ll14v9IjpHFJBbPBKfvSywelYb7mMigln+35s5ffAiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUMtwsMa; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4043b27ddeaso5836638fac.1
        for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 08:13:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773155584; cv=none;
        d=google.com; s=arc-20240605;
        b=S0MNlZ02OeMz5exi7CJ0UyLTghrTcYQ4iufI801K0gQNQIWEa7oIWnitiNvUgklXsl
         tPQpmjcDACv/H49EmV5eyfZhpYiogYRcmQICSL7H3HUuxZ42Lo5bFmf1uNciXAuePmFm
         1OoChQbPUE0oOMvyk+eyBkdohQ97va2302KP6yFLQT26qQXH3QlwdIqN+kTgW776KVPW
         mKBOlE4sPLe1RdS8VC2NtsJO4wVAFm3qLqS60SZ+J790oeR8mBfP5leJOQZ3OBU3d2vk
         Sc6Agf6ahIQIQVJLruck6NhFOasQcLBXz4LDfCYX1k6tLxc+Eb5wlFeLxUqPihiNKjkN
         pD1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nq7gpmqdv5iLm78Ib0DqMYsNaS2ltiqYogKyZLSefTM=;
        fh=fFUQ3bDSnwWYL/1dqZwPKYywXd5TONRsAevI/mvHYbI=;
        b=J1uh5oYfItOHe9ahWH2Izeg8zyRvOYtLvxI2ox6oRRwoRHZdb6cM+GbECm6LTEeL2t
         PktKTer9lKlFmq5ihqjkqST0Dl1scvM6ivpGh+KaHPSzOYCm75/NKy0NRJLicPchFoTB
         pYpJtQX5XdxUWvVtC901bjMr3vc0e50mu3+oFssAesdIgCJPQT/GaQrlTgGEbZjhClko
         hPMGo5ZND7LsIGZ3yKF4MKsaKcOxaD1FrBXKdjwDpL1GxP6ZnGiPj6Dly39A3+WQj6EY
         lZPEPsb8PmML1jNXU8AIldu7GqxP+7pNGaNIkRNVSszWvWt5V5ItBSzxWaBaZ6z98KFv
         4jwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773155584; x=1773760384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nq7gpmqdv5iLm78Ib0DqMYsNaS2ltiqYogKyZLSefTM=;
        b=BUMtwsMa5pLSuRIHAYfx3Fl9WxBqMvOS08GmjLBmYGaDVI8UDBtOQkiAID0o+wXqF0
         Dqt9seCWFcxUXCwjj8XKe1JymZi8ewiF/Pvxd4ckVCOhZAbI8M3OaK2Mnw/9gtIG4Rbz
         QgXKmPAVr5N1cFpmKyXaow87VnJ5dAYJdikiFD2LfWUrT2ZLZ6JuPRgTDGMK0I4J+b9e
         MuDevk3jiCasENrx0kbHaK1H73eHZbHwDvGygyIGbzNPoK8XNb6pIBb4QScdOVjIGBfq
         6RSnT2rC96BVQEJ05YaAM8ujujL4Yada4tC36wB45gaxy3+hRIB+0KYX+/a+KpAF+MKf
         Fo/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773155584; x=1773760384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nq7gpmqdv5iLm78Ib0DqMYsNaS2ltiqYogKyZLSefTM=;
        b=p+nfgBrfyjCqTgtSKFzPaUDziqZsryUYd7jgYbcdsp+KBVV/i77rOQZoIeby+89n8A
         Avp/JrUNUIwJeA31R+3p8efs5i6ICSDXkIMJcE4aK6d98HqoEjK2jdNTxpMkWjrYSXAl
         feD5Dpjw1IWv4a5ZqoUQnvfPvFJTnJZEBCAUVw7I0ta22aLEABrhHgsFyrQJWh5Cx6Vp
         gg22+HRDi8Chh9MJl8BtknhQZrvUwP2xzIcn5k6/KpxwvxnEfdHDX/jO91NtnFVZr4QT
         QLk3VBupBFIPQd2o5/cfcaty2b5T4x4/q2G6vKspfTIMEdhXPwTnTUy3SaLJy3PiYfGR
         Aetg==
X-Gm-Message-State: AOJu0YzRL2+Axn8oYKoltr93nkL+yYZCkXj9+f2i53h3G++6wC0A3kBd
	kkZ9DA7BWHTKQJDLtONQPP1lAD/76VlH5PecXEWaVhUkM1WqYoVMpKY7o6H9AMxQwmMEMD3sbjo
	K8OM8SXbznjzQvi5oEhfrpM3/R+I5POsOk+pEaQgq40CEb9s=
X-Gm-Gg: ATEYQzwlm9AQ1+K7cb+JyaR/oXiucsSmhY7oVfnRZmthaaklxmysRA14NCLrsy6iW5m
	IHR/SzoWiFUMlBlgd8TZJ+T0qayXPrjQ6LP+/lmoKxGputiqf5N/VM+oIblbOY9jikLkwkv6ZdB
	DXCRP5KrBnPz1tDOrVgCKcuu49Z/YxNqjo+mhqhO4tn0CD7U0y/gTunXomoA8Aur1XMfG6N+E3x
	v3PxMXdlRaKaCaHq5ot0Ly9W56jxJcJTVloJdHQmKiZ8QdnhKUNl99yFy66LEGlddELBE8ZTBHQ
	m7DX1NzeZE4wiYOC5lCuUu8anw==
X-Received: by 2002:a05:6870:1596:b0:404:3f0a:9351 with SMTP id
 586e51a60fabf-416e45c75ebmr7617051fac.52.1773155583486; Tue, 10 Mar 2026
 08:13:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <1e96af437fa24674b353ddb530b2d8e7@realtek.com> <CALdGYqQb=Vt0jjqW7k8RGMV1gczL0cg-26cHgCm3MmzBjezGMQ@mail.gmail.com>
In-Reply-To: <CALdGYqQb=Vt0jjqW7k8RGMV1gczL0cg-26cHgCm3MmzBjezGMQ@mail.gmail.com>
From: LB F <goainwo@gmail.com>
Date: Tue, 10 Mar 2026 17:12:19 +0200
X-Gm-Features: AaiRm52x8TlR31_szyRXWIQUp1BkwS9h5lUXsZ7KIP1mAQXdsKqAdoFbaDTYjEA
Message-ID: <CALdGYqSz3SNzoSjUQvK6FgTc2Xkac52=T5A7Lt=d+nxAXGgJVw@mail.gmail.com>
Subject: Re: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: DCB8F253105
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32910-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goainwo@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Ping-Ke,

Thank you for your guidance. To provide you with the cleanest possible
diagnostic data, we devised a strict testing environment:

1. **Live USB Environment:** We booted a completely fresh Live USB of
CachyOS (Kernel 6.19.6) to eliminate any potential interference from
installed software, TLP profiles, or custom NetworkManager
configurations.
2. **Aggressive Local Logging:** Because the system freeze physically
locks the PCIe bus and disables the Wi-Fi adapter instantly, using
`netconsole` was impossible (the network drops microseconds before the
freeze).

To overcome this, we wrote an "aggressive logger" script that pipes
`dmesg -w` directly to an independent FAT32 USB drive while issuing a
`sync` command twice a second. This bypassed RAM caching and
physically burned the logs to the drive right up to the moment of the
hard freeze. The script we used was:

```bash
#!/bin/bash
LOG_FILE=3D"/run/media/liveuser/LOGS/kernel_freeze.log"
dmesg -w > "$LOG_FILE" &
while true; do
    sync
    sleep 0.5
done
```

3. No workarounds (`disable_aspm=3Dn`, `disable_lps_deep=3Dn`) were active
in this test. We manually enabled power saving (`iw dev wlan0 set
power_save on`) and triggered the freeze via typical web browsing.

Here are the precise, unadulterated logs showing the adapter
successfully connecting to the network, sitting idle for about 10
seconds (presumably entering power-saving states), and then suffering
a fatal firmware lockup right before the PCIe bus froze:

```
[  304.709201] audit: type=3D1111 ... op=3Dconnection-add-activate ...
name=3D"Andrey_5G" ...
[  305.617785] wlan0: authenticate with 6c:68:a4:1c:97:5b ...
[  305.660333] wlan0: authenticated
[  305.661661] wlan0: associate with 6c:68:a4:1c:97:5b (try 1/3)
[  305.663404] wlan0: associated
[  305.719997] wlan0: Limiting TX power to 30 (30 - 0) dBm as
advertised by 6c:68:a4:1c:97:5b
... (~10 seconds of idle network time) ...
[  316.907114] rtw88_8821ce 0000:13:00.0: failed to send h2c command
[  316.911190] rtw88_8821ce 0000:13:00.0: failed to send h2c command
[  316.921504] rtw88_8821ce 0000:13:00.0: coex request time out
...
[  349.630952] rtw88_8821ce 0000:13:00.0: failed to send h2c command
[  349.635023] rtw88_8821ce 0000:13:00.0: failed to send h2c command
[  357.811235] rtw88_8821ce 0000:13:00.0: firmware failed to leave lps stat=
e
[  359.797238] rtw88_8821ce 0000:13:00.0: firmware failed to leave lps stat=
e
... (repeats indefinitely until hard reset) ...
```

As the logs clearly demonstrate, the adapter authenticates perfectly
but the firmware explicitly fails to leave the LPS state after a brief
idle period, dropping all H2C commands immediately before the
system-wide hard freeze begins.

We will upload the full, unabridged `.log` file to our Bugzilla thread
(Bug 221195) momentarily, but we wanted to provide you with this exact
'smoking gun' trace right away to help identify the root cause.

Please let us know if this information is helpful or if there are any
specific module patches or further tests you would like us to perform
to assist with debugging.

Best regards,
Oleksandr

=D0=B2=D1=82, 10 =D0=BC=D0=B0=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 13:01, LB =
F <goainwo@gmail.com>:
>
> Hi Ping-Ke,
>
> Thank you for the incredibly fast response and assistance!
>
> > Can you dig kernel log (by netconsole or ramoops) if something useful?
> > I'd like to know this is hardware level freeze or kernel can capture so=
mething wrong.
>
> I managed to pull a call trace from a historic journald log just
> before the system hung. The kernel gets trapped in an IRQ thread
> inside `rtw_pci_interrupt_threadfn`, calling up into `mac80211`
> `ieee80211_rx_list` before everything freezes. Here is the relevant
> snippet:
>
> ```text
> Call Trace:
> <IRQ>
> ? __alloc_skb+0x23a/0x2a0
> ? __alloc_skb+0x10c/0x2a0
> ? __pfx_irq_thread_fn+0x10/0x10
> [ ... truncated module list ... ]
> Tainted: G W I 6.19.6-2-cachyos #1 PREEMPT(full)
> Hardware name: HP HP Notebook/81F0, BIOS F.50 11/20/2020
> RIP: 0010:ieee80211_rx_list+0x1012/0x1020 [mac80211]
> CPU: 2 UID: 0 PID: 765 Comm: irq/56-rtw88_pc
> rtw_pci_interrupt_threadfn+0x239/0x310 [rtw88_pci]
> ```
>
> It behaves exactly like a PCIe bus deadlock or a hardware fault that
> eventually brings down the CPU handling the IRQ.
>
> > Are these totally needed to workaround the problem? Or disable_aspm is =
enough?
> > I'd list them in order of power consumption impact:
> > 1. disable_aspm=3Dy
> > 2. disable_lps_deep=3Dy
> > 3. disable WiFi power save
>
> To verify which parameters are strictly necessary, I performed
> isolated testing today. I ensured no other modprobe configs were
> active, rebuilt the initramfs, and manually enforced that
> `wifi.powersave` was active via `iw dev wlan0 set power_save on`
> during all tests (as the OS power management profiles were defaulting
> it to off, which initially masked the issue).
>
> I tested each workaround individually across multiple sleep/wake
> cycles and active usage:
>
> **Test 1 (ASPM Disabled, LPS Deep Enabled):**
> - Kernel parameters: `rtw88_pci disable_aspm=3Dy` (and `rtw88_core
> disable_lps_deep=3Dn`)
> - Result: Stable. No freezes were observed during usage or transitions
> into/out of S3 sleep while power saving was enforced.
>
> **Test 2 (ASPM Enabled, LPS Deep Disabled):**
> - Kernel parameters: `rtw88_core disable_lps_deep=3Dy` (and `rtw88_pci
> disable_aspm=3Dn`)
> - Result: Stable. No freezes were observed under the same forced power
> save conditions.
>
> **Conclusion:** It appears we do not need both workarounds
> simultaneously for this specific hardware. Using only `disable_aspm=3Dy`
> seems to be sufficient to prevent the system freeze. Given your note
> about the power consumption impact ranking, this looks like the
> optimal path forward.
>
> > But what does 'deadlock' mean? As I know NAPI poll is scheduled by ISR,
> > and going to receive packets. The rx_no_aspm workaround is to forcely t=
urn
> > off ASPM during this period.
>
> By "deadlock" I meant a hardware-level bus lockup. It seems the
> physical RTL8821CE chip itself crashes or hangs the system's PCIe bus
> when trying to negotiate waking up from ASPM L1 while simultaneously
> existing in `LPS_DEEP_MODE_LCLK`. The `rx_no_aspm` workaround in NAPI
> helps during active Rx decoding, but the laptop often freezes while
> completely idle, presumably when the AP sends a basic beacon, the chip
> attempts to leave LPS Deep + L1, and the hardware simply gives up and
> halts the system.
>
> > We have not modified RTL8821CE for a long time, so I'd add workaround
> > to specific platform as mentioned above.
>
> Adding a DMI/platform quirk specifically for this laptop to disable
> ASPM would be wonderful and deeply appreciated. I agree it is safer
> than touching the global flags for hardware that is functioning
> correctly out in the wild.
>
> Here is the exact identifying information for my system:
>
> System Vendor: HP
> Product Name: HP Notebook
> SKU Number: P3S95EA#ACB
> Family: 103C_5335KV
> PCI ID: 10ec:c821
> Subsystem ID: 103c:831a
>
> I am completely ready to test any patch or quirk you send my way.
> Thank you so much for your time and helping track this down!
>
> Best regards,
> Oleksandr

