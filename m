Return-Path: <linux-wireless+bounces-32827-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OHbJIf6r2mmdwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32827-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 12:03:35 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD9F249EEA
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 12:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 76E32303E6AB
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 11:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61EA2BF3E2;
	Tue, 10 Mar 2026 11:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hy5D3efw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE503859DC
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 11:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140537; cv=pass; b=aMBKSWTyNUkqJHG9MW6W4isDvxRImet1qh6Bqh7JPN5DQb30st6OalI6wdR0ziLEFuGob4SljZCMIvwE/TltVjYOh/KIyigJB6QnJkC0iKuq2eaWMRn6iACvCEJd9sJcQrj9XlSW6ur/QVgoa2tivnqgbRMkciF1lP2oP36hQvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140537; c=relaxed/simple;
	bh=DQhkWZ7vGA27UCJ7PrtZxdgKY5v5cVyIkF8OtNg+RmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ha8/46JJqmGqL2nNsGBQoeTH38Dm/cjDae87UD5XDusAHbnFVTRuyJVTapAsTumQxtffdsb7gDmMf31YojlwzuI/8cZ84xStnhTAz7Oz/6dQREAK1W3M0fw0bOZIXpv5xXSmzJQsRiAqpVdmCeGxO0vGGN4V/ZZXZYl6awC++ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hy5D3efw; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d75e74f5adso403729a34.3
        for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 04:02:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773140535; cv=none;
        d=google.com; s=arc-20240605;
        b=cKrtdnNwI48YvRRINip1ebLj3rTwLiD6WKNIx2bA1ay4Eb33wuoGSLxqPU0YCpa6he
         u4ib5ZJ8EWPipysqz2Sw3ysF2B2ZZrcgYEOkGZZqB5JISy7gDkZFH+BTYw427FIphEtl
         yfWGJKiUba/Sauq+TiK/tHwcLRh1+5PS+1W77fQVP1l6dDm0Q1Vw+wYi4k03nhvx52Nf
         Vo3Fq5sYtgZuUmtx17w7AHk1ei5+G72i9+yiqTN5LoDtWOxQiylfOKaJ3KBy2k6GbYLh
         uZvcfPLZFZzwilMsBi7WQOtJ7eKZQzkS7d+6Qxrd6c9jALSddPDRvhrv1UnpEQUfSbMj
         Gg2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DQhkWZ7vGA27UCJ7PrtZxdgKY5v5cVyIkF8OtNg+RmA=;
        fh=fFUQ3bDSnwWYL/1dqZwPKYywXd5TONRsAevI/mvHYbI=;
        b=RyXR02kisgkwozCDFdUlwWKnYnbGpub5c5U99tD70b4BOnkLETDGcBKGD+rqyfwBYM
         CozeRnsYZ60udg/JuQgZYsN+G7GYLbGlhHT/cbKoUztGtFuIT+boP0qGrlRn8YX0yIGe
         r/NcuIfy8zCXbtHEdHYMky4KTEp12rILo5DN8zZFB1Hd9OgRMlv+HZLYnroqkGat/bAh
         oKgrZ3yexxadmnoa6LMnsM3Z8te7/YKDP+ow04LJwzv+acNFYtRW0g4Cna9z6gIxl/FZ
         7xNsCYiaxEu8eFkzZ8qUhnV+4kxk9O406r4By9jvpm0L2JJRsy2jC+u8zYcQyrDDvolw
         UrUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773140535; x=1773745335; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DQhkWZ7vGA27UCJ7PrtZxdgKY5v5cVyIkF8OtNg+RmA=;
        b=Hy5D3efw4Fgb4kbnCRkP/zYGlDohZRI/ZJW4zCwu9YcEVIoVdCdrfLfaIMi1VX5HPg
         vf6HOKtEv4Cw4nvhaqEufUlrYqcLttbCQOUI/SWKWB/K3uRxhGriYtdolv3wUY6s4+X0
         ypX0v0tndgkgtj609hyU1/TwvpTdXc3sL7hVqDow78pzgJ+2ymvP58lfJrqA+REfCoxl
         Wrylow0430RweN5ZGEv3+ltD/1rBuZ4Xjetn21DtrEBiwkyAVGlJwXwibnREGsmnNS5q
         KCnPj666jIgyyWVD8PW6GrRaHag8htBP8UZVcPUwu3pVyS9+QZIQi/dBeG6b8DR5/BHs
         v/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773140535; x=1773745335;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQhkWZ7vGA27UCJ7PrtZxdgKY5v5cVyIkF8OtNg+RmA=;
        b=tcI8tuI8RxwCQAg9dWLvb31x1ZIN2sFhBcWDxXSheb1zKjshV+Ca46wIhhEHZOAzbn
         n5eWTbfIJl7ykiQTClV+kGAPx0PafytYSAoiIp1mVohUdPevB6TM8bulUm67GQ9fKq9H
         o/0n4uxcQ70TP1IDCw302fg35oNoVS1XzrYQpCkdto4NsNaOjUxsmrgqoZ0Cu+BegLAx
         ZnkqwJo2hVRliv4958KE3uon4V6sXJoesKT2nzTDBjWMbP4Sx+4gqLV8SBFWZJuoloGP
         4YAKMCVfN1Gpb7ZlEyCGJ/tcsjBqgWfq6yVzpyT8RvFH+kd/bBhhw4FdureAOCrXVuvJ
         Btrg==
X-Gm-Message-State: AOJu0YzaGjhx9JoVkS0GAbzpiyaY1tZwmPNsJRLGkJ3uFnSWu6fPCQvQ
	grSako0nb23Azehig6COskS7vjiWzj/m1Hpr7KNcIbxe96dPaIB117/6+wrympf4sOn2RkEw3aO
	9YvfjTLRWqvbWRgnrwWl8k+7366C2osU=
X-Gm-Gg: ATEYQzyfwr3g3op0QBUensGxZU+c/aQ/WIYzLXjO9CX67dE5L2rYvSl/Q7sqeHn+fZZ
	vO0UfqfwcvFkuyP6Zu9WQJPvu0PUaku/ixsv0jdi6a96kOKGeodF6vUKxK1dMQDWnCcPJHH+qRL
	+CGGGnn4vFpRTWEa53C0n7KEaTOGIUozcmar+xr6csvGfPl/xferQexOIuscgm+lJE0TDdSGenZ
	5Kq7KsVHFNcoWqg6P0w4hzuGqHGjEk6jBuIlSM1ow42bOnSBBLHbXXXEPHu3IlLBp1cXeep9Vw/
	V205ypvgheBtNE2dYA407DHX9w==
X-Received: by 2002:a05:6830:2e05:b0:7d7:4666:69be with SMTP id
 46e09a7af769-7d746666b8amr6106834a34.18.1773140535213; Tue, 10 Mar 2026
 04:02:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <1e96af437fa24674b353ddb530b2d8e7@realtek.com>
In-Reply-To: <1e96af437fa24674b353ddb530b2d8e7@realtek.com>
From: LB F <goainwo@gmail.com>
Date: Tue, 10 Mar 2026 13:01:36 +0200
X-Gm-Features: AaiRm50ELWPwVRBdKOslQOL3oqEqSFLwQK1mBBMLL1RufWwV7y5_k5ioyvoDqWg
Message-ID: <CALdGYqQb=Vt0jjqW7k8RGMV1gczL0cg-26cHgCm3MmzBjezGMQ@mail.gmail.com>
Subject: Re: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 4DD9F249EEA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32827-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi Ping-Ke,

Thank you for the incredibly fast response and assistance!

> Can you dig kernel log (by netconsole or ramoops) if something useful?
> I'd like to know this is hardware level freeze or kernel can capture something wrong.

I managed to pull a call trace from a historic journald log just
before the system hung. The kernel gets trapped in an IRQ thread
inside `rtw_pci_interrupt_threadfn`, calling up into `mac80211`
`ieee80211_rx_list` before everything freezes. Here is the relevant
snippet:

```text
Call Trace:
<IRQ>
? __alloc_skb+0x23a/0x2a0
? __alloc_skb+0x10c/0x2a0
? __pfx_irq_thread_fn+0x10/0x10
[ ... truncated module list ... ]
Tainted: G W I 6.19.6-2-cachyos #1 PREEMPT(full)
Hardware name: HP HP Notebook/81F0, BIOS F.50 11/20/2020
RIP: 0010:ieee80211_rx_list+0x1012/0x1020 [mac80211]
CPU: 2 UID: 0 PID: 765 Comm: irq/56-rtw88_pc
rtw_pci_interrupt_threadfn+0x239/0x310 [rtw88_pci]
```

It behaves exactly like a PCIe bus deadlock or a hardware fault that
eventually brings down the CPU handling the IRQ.

> Are these totally needed to workaround the problem? Or disable_aspm is enough?
> I'd list them in order of power consumption impact:
> 1. disable_aspm=y
> 2. disable_lps_deep=y
> 3. disable WiFi power save

To verify which parameters are strictly necessary, I performed
isolated testing today. I ensured no other modprobe configs were
active, rebuilt the initramfs, and manually enforced that
`wifi.powersave` was active via `iw dev wlan0 set power_save on`
during all tests (as the OS power management profiles were defaulting
it to off, which initially masked the issue).

I tested each workaround individually across multiple sleep/wake
cycles and active usage:

**Test 1 (ASPM Disabled, LPS Deep Enabled):**
- Kernel parameters: `rtw88_pci disable_aspm=y` (and `rtw88_core
disable_lps_deep=n`)
- Result: Stable. No freezes were observed during usage or transitions
into/out of S3 sleep while power saving was enforced.

**Test 2 (ASPM Enabled, LPS Deep Disabled):**
- Kernel parameters: `rtw88_core disable_lps_deep=y` (and `rtw88_pci
disable_aspm=n`)
- Result: Stable. No freezes were observed under the same forced power
save conditions.

**Conclusion:** It appears we do not need both workarounds
simultaneously for this specific hardware. Using only `disable_aspm=y`
seems to be sufficient to prevent the system freeze. Given your note
about the power consumption impact ranking, this looks like the
optimal path forward.

> But what does 'deadlock' mean? As I know NAPI poll is scheduled by ISR,
> and going to receive packets. The rx_no_aspm workaround is to forcely turn
> off ASPM during this period.

By "deadlock" I meant a hardware-level bus lockup. It seems the
physical RTL8821CE chip itself crashes or hangs the system's PCIe bus
when trying to negotiate waking up from ASPM L1 while simultaneously
existing in `LPS_DEEP_MODE_LCLK`. The `rx_no_aspm` workaround in NAPI
helps during active Rx decoding, but the laptop often freezes while
completely idle, presumably when the AP sends a basic beacon, the chip
attempts to leave LPS Deep + L1, and the hardware simply gives up and
halts the system.

> We have not modified RTL8821CE for a long time, so I'd add workaround
> to specific platform as mentioned above.

Adding a DMI/platform quirk specifically for this laptop to disable
ASPM would be wonderful and deeply appreciated. I agree it is safer
than touching the global flags for hardware that is functioning
correctly out in the wild.

Here is the exact identifying information for my system:

System Vendor: HP
Product Name: HP Notebook
SKU Number: P3S95EA#ACB
Family: 103C_5335KV
PCI ID: 10ec:c821
Subsystem ID: 103c:831a

I am completely ready to test any patch or quirk you send my way.
Thank you so much for your time and helping track this down!

Best regards,
Oleksandr

