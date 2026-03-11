Return-Path: <linux-wireless+bounces-32983-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEAtJ3dLsWlCtAIAu9opvQ
	(envelope-from <linux-wireless+bounces-32983-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 12:01:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D926262AE6
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 12:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 21F7730028EE
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 11:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2416131690A;
	Wed, 11 Mar 2026 11:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7JQ3+Mi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65A528BA95
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 11:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773226863; cv=pass; b=RpgNizcvS2T8N5DV/weTmnOmft8j6tONx8E8VH14pPadv0qLv5+tOeFhPQKqZ288fRSNjQE/33Qg24P389L7FmUWSnrAJBsSwWLUrgp377AvpjE1Ul9zxVSqQQNql96xxwxS9sQ0bDNnVvBmT7wejL3hULFKZcXvo+LbcV1LG8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773226863; c=relaxed/simple;
	bh=I9tgMVWgii4YP8S+XXWzKjkN2jz8ZGwU5gGZ1Ljh1vA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WlrxjxSvFxOnxTrEUgDTNR9I1g68KjWIliHxymTlcTu1FWsvszX4UD9PEn2IPLzJ1YD4GGlLArB+miUJhUox+tKPbufHo8VVBr+1qzrvd2PaJMiGV+Uqq8olfMAN8yHcfNA8tPUCRrcq2YMXtxEy31AQRkVGG8f2l5U9CmNcgSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7JQ3+Mi; arc=pass smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d7507327d7so2470809a34.3
        for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 04:01:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773226860; cv=none;
        d=google.com; s=arc-20240605;
        b=P5Px6+RLVJe6GXPblh54QSrNpxllUAq+itUqrpzXtkV++RBGfgj4vJ7NRpefHPBocf
         krFs+M3Dn00XD3lKqj9VsoO11qVQ287pUspX6I9ShJIE5ewGnOStmfdZ3kZtvrcNlKqN
         K8DsJklxOU4tvFhAft3wbYnXMBHQms2Q6ubST7JxopinRBbSqJrdD4FR/ybsedOCgt6C
         lsIBZmRhKNANDHRjNSyxPPDxogtq9NRfF5iwLGxmsDJGXZJR3qROOCdTJTOJbUNkWOv4
         58e+jeu/Pj62lyr+v/7oQwSlFnl52qmnTPD1icZSX8g8ScwKlLBZKy/sv4KRi5WLV82/
         MK0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I9tgMVWgii4YP8S+XXWzKjkN2jz8ZGwU5gGZ1Ljh1vA=;
        fh=fFUQ3bDSnwWYL/1dqZwPKYywXd5TONRsAevI/mvHYbI=;
        b=jfwCcCIYTh8h+iQlgHJmXV9Q5YiJvAWQHJFA0cxXtZhf8J3cGaa3Z8j7RY+4dZvSXb
         8fuROpEiULi8OiwBeYae/RSI/QKzwQMGpneWh1fjJXHKY6XCZUbRl0cc0aKCWb2JHU8z
         YGLjdCS50asgcDMUeCYiEtywRe3pR3ZEUTHMEe59VWgp4r63nRttAYwSsUM1CbeVhfx/
         3AYJzPc7OVQXS9GsW7jr5NzCuNQjbfofYkfp7c9XM21BiYR3VavZug/o7GeR8f1scGtY
         imtxlBJxU0D5gLUEDXj6mI0ZB1ARifdxsoZL9wh5A9JyOWr1DD2PC001zwyWWKp01u2h
         V+6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773226860; x=1773831660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9tgMVWgii4YP8S+XXWzKjkN2jz8ZGwU5gGZ1Ljh1vA=;
        b=d7JQ3+MiPebxLp+vQXggDkuhdWIY/uj2qcr4ei5vHdUPYCSxkfhTUPBVOS3g5dpg7V
         sXzo3gboVBPkG/zMrvcUl16OK26tZaxLB9gmWO5dciL3kwFe/byFCzgsNZegQyYe537h
         03Jxi9BH0whWh+F36z4/Fv1F8WNohKoogJMJLDCkEpL/VxQQ1q0DmnyA5Fbu3VNbWo5P
         f2IxO59zpeeU8VZzhm4/4bUT0WAdMyAv8NzK/xJGbdksM0Nh9hgPnt6a40n8nGqMJH+i
         959O2p+W4/zGXBc5pxzGsyYqWs9bm7iJnE/cG+NOWHFcMwOibqBi444qHwKCI1SKjncl
         LVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773226860; x=1773831660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I9tgMVWgii4YP8S+XXWzKjkN2jz8ZGwU5gGZ1Ljh1vA=;
        b=leO8l7uQCTpzpi7dJk16ReRyoLL85+Kx4187Vyp0MpUX1P3rY9/MPkgcMhKhNvE5Yz
         OadBhkdtEHZU8ALgHkO+H2+IvTxGvqhDvij39uo8q+z33N7xwD6UTgm7yeORtBFad/2k
         Wwk4Uc+muVwS3QPbeCzIFJhb/04NRrn+Zp4Z0R016y5KmsgUmNpKLtsmfLgwO1MwBLbt
         h0WGZTmLjeikyTlbM3sAeHyMaUcKZt1SsiY/w44aL5xVBgQgTEJiVC7lyM947aAH6h55
         kRuU203uDdPe9WaJ+iRvH0ylhV5vW0Z5iXVNm7hl5xxJdNv43Kthp9gLnrJKHl5F1aso
         W/cQ==
X-Gm-Message-State: AOJu0Yx/sUCk9HeYioLrkpsujz4NgVTRr75aY9K61X+kLipSoLfea31t
	nHB4eGXtPRjqNP0yorphYNXt55sZejfbEpuifUprafT5BEi+J3Sp4dIiie6N5eIYHzhRTIqQfzy
	0hqoQdNcjdq27coDetcdXfUSI5kFWV5E=
X-Gm-Gg: ATEYQzwDM+R7wz8rM2HJDh5h8nr1utdhQpiwofStoAPuFc5hRbpk4teU8fSoVC0Oryb
	JKmd6qmZO7CcvuVMYyovI+W7P/WJ1u21vCAw0oEwS66GghQsdJfrY37A6iwY1bFk4kCDvYwJCAW
	P/vi5Y1r4EcaW1vsESyZhwvT2bJObwXZbqIBDTdmaYmVhtNHgYuS0n8IDad8eQMyIgarbHk0XzM
	Yh+cCZ/zh6XsdIMKG/BMnF5VnTldIhuavQxV1VFz+DVFAJtUOZoXHMafpnKG/grO7Qx/wNc32UN
	/2L9VUrhDtBhc45jY3v6dAI2DQ==
X-Received: by 2002:a05:6830:2a91:b0:7d7:455d:1003 with SMTP id
 46e09a7af769-7d76a6bd729mr1442004a34.4.1773226859502; Wed, 11 Mar 2026
 04:00:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <1e96af437fa24674b353ddb530b2d8e7@realtek.com> <CALdGYqQb=Vt0jjqW7k8RGMV1gczL0cg-26cHgCm3MmzBjezGMQ@mail.gmail.com>
 <792645eed36041f0b3df951f1b28a08a@realtek.com> <e6720993c8c14245981432cfa4ae902b@realtek.com>
In-Reply-To: <e6720993c8c14245981432cfa4ae902b@realtek.com>
From: LB F <goainwo@gmail.com>
Date: Wed, 11 Mar 2026 13:00:21 +0200
X-Gm-Features: AaiRm51RsHJX-zT6cw4LQUmc3KZ4V7JdAsYX9aCOhUdsiipItBoiGOzfdCxTf7s
Message-ID: <CALdGYqQn8GGXXjZTsL+a5Mfdmw5HRYB2Jyvqq5M5SUwxK9yd_g@mail.gmail.com>
Subject: Re: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0D926262AE6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32983-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi Ping-Ke,

Thank you for the incredibly fast turnaround and for providing the RFT
patch with the DMI quirk!

First, I want to mention that I am not an IT professional or a
programmer. I am just a regular Linux user who really wants to help
solve this problem. I am trying my best to verify everything
carefully, so please forgive me if my terminology or induction was
slightly off.

To answer your clarifying questions from the previous emails:

> Just want to clarify that these logs only appear in test 3, right?
> No these logs in test 1/2.

Yes, exactly. The `failed to send h2c command` errors only caused a
complete system freeze when no workarounds were active and the adapter
attempted to sleep (Test 3).

> I think this is your perspective and induction, right? Did you measure
> real hardware signals?

You are entirely correct. This is just my induction based solely on
the timing of the logs and system behavior. I do not have access to an
oscilloscope or any hardware diagnostic tools. Given this, I
completely agree that your approach of applying a platform-specific
quirk is the safest and best solution.

> Forgot to say. Could you share your full name for me as a reporter
> in commit message?

My full name is Oleksandr Havrylov. I would be honored to be included
as the reporter in the commit message.

### Recent Baseline Testing Before Your Patch

Before applying your patch today, we ran a few more controlled tests
to double-check our baseline. We verified that our local workaround
(`modprobe.d disable_aspm=3Dy`) **does indeed keep the system completely
stable** and prevents the hard freeze, even when NetworkManager's
`wifi.powersave` is set to ON (default).

However, we noticed one interesting detail in the kernel logs: while
the system no longer freezes with `disable_aspm=3Dy`, `dmesg` still
constantly logs `firmware failed to leave lps state` and `failed to
send h2c command` when the laptop is completely idle. It seems the
firmware still crashes during LPS, but because ASPM is disabled, the
PCIe bus ignores the crash and the system survives perfectly fine. I
just wanted to mention this for completeness!

### Testing Plan

I have **not** applied your RFT patch just yet. I wanted to make sure
our testing baseline was 100% clean and documented first.

I will compile your patch and perform rigorous testing this evening (I
am in the EET timezone, Ukraine). I will test it with the native
`power_save` fully enabled to ensure your patch successfully prevents
the hard lockups as intended.

I will stay in touch and reply back to this thread with a formal
`Tested-by` confirmation (and any logs if needed) as soon as my
testing is complete. Thank you again for all your help!

Best regards,
Oleksandr Havrylov

=D1=81=D1=80, 11 =D0=BC=D0=B0=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 04:22, Pin=
g-Ke Shih <pkshih@realtek.com>:
>
> Ping-Ke Shih <pkshih@realtek.com> wrote:
> >
> > LB F <goainwo@gmail.com> wrote:
> > >
> > > Hi Ping-Ke,
> > >
> > > Thank you for the incredibly fast response and assistance!
> > >
> > > > Can you dig kernel log (by netconsole or ramoops) if something usef=
ul?
> > > > I'd like to know this is hardware level freeze or kernel can captur=
e something
> > > wrong.
> > >
> > > I managed to pull a call trace from a historic journald log just
> > > before the system hung. The kernel gets trapped in an IRQ thread
> > > inside `rtw_pci_interrupt_threadfn`, calling up into `mac80211`
> > > `ieee80211_rx_list` before everything freezes. Here is the relevant
> > > snippet:
> > >
> > > ```text
> > > Call Trace:
> > > <IRQ>
> > > ? __alloc_skb+0x23a/0x2a0
> > > ? __alloc_skb+0x10c/0x2a0
> > > ? __pfx_irq_thread_fn+0x10/0x10
> > > [ ... truncated module list ... ]
> > > Tainted: G W I 6.19.6-2-cachyos #1 PREEMPT(full)
> > > Hardware name: HP HP Notebook/81F0, BIOS F.50 11/20/2020
> > > RIP: 0010:ieee80211_rx_list+0x1012/0x1020 [mac80211]
> > > CPU: 2 UID: 0 PID: 765 Comm: irq/56-rtw88_pc
> > > rtw_pci_interrupt_threadfn+0x239/0x310 [rtw88_pci]
> > > ```
> > >
> > > It behaves exactly like a PCIe bus deadlock or a hardware fault that
> > > eventually brings down the CPU handling the IRQ.
> >
> > I wonder if there is a malformed data, causing this trace and the leads
> > kernel freezes. If we can do validation on RX data before calling
> > ieee80211_rx_list(), maybe trace disappears and everything will be fine=
?
> > Even no need workaround.
> >
> > >
> > > > Are these totally needed to workaround the problem? Or disable_aspm=
 is enough?
> > > > I'd list them in order of power consumption impact:
> > > > 1. disable_aspm=3Dy
> > > > 2. disable_lps_deep=3Dy
> > > > 3. disable WiFi power save
> > >
> > > To verify which parameters are strictly necessary, I performed
> > > isolated testing today. I ensured no other modprobe configs were
> > > active, rebuilt the initramfs, and manually enforced that
> > > `wifi.powersave` was active via `iw dev wlan0 set power_save on`
> > > during all tests (as the OS power management profiles were defaulting
> > > it to off, which initially masked the issue).
> > >
> > > I tested each workaround individually across multiple sleep/wake
> > > cycles and active usage:
> > >
> > > **Test 1 (ASPM Disabled, LPS Deep Enabled):**
> > > - Kernel parameters: `rtw88_pci disable_aspm=3Dy` (and `rtw88_core
> > > disable_lps_deep=3Dn`)
> > > - Result: Stable. No freezes were observed during usage or transition=
s
> > > into/out of S3 sleep while power saving was enforced.
> > >
> > > **Test 2 (ASPM Enabled, LPS Deep Disabled):**
> > > - Kernel parameters: `rtw88_core disable_lps_deep=3Dy` (and `rtw88_pc=
i
> > > disable_aspm=3Dn`)
> > > - Result: Stable. No freezes were observed under the same forced powe=
r
> > > save conditions.
> > >
> > > **Conclusion:** It appears we do not need both workarounds
> > > simultaneously for this specific hardware. Using only `disable_aspm=
=3Dy`
> > > seems to be sufficient to prevent the system freeze. Given your note
> > > about the power consumption impact ranking, this looks like the
> > > optimal path forward.
> >
> > Let's test my RFT patch to disable ASPM then.
> >
> > >
> > > > But what does 'deadlock' mean? As I know NAPI poll is scheduled by =
ISR,
> > > > and going to receive packets. The rx_no_aspm workaround is to force=
ly turn
> > > > off ASPM during this period.
> > >
> > > By "deadlock" I meant a hardware-level bus lockup. It seems the
> > > physical RTL8821CE chip itself crashes or hangs the system's PCIe bus
> > > when trying to negotiate waking up from ASPM L1 while simultaneously
> > > existing in `LPS_DEEP_MODE_LCLK`. The `rx_no_aspm` workaround in NAPI
> > > helps during active Rx decoding, but the laptop often freezes while
> > > completely idle, presumably when the AP sends a basic beacon, the chi=
p
> > > attempts to leave LPS Deep + L1, and the hardware simply gives up and
> > > halts the system.
> >
> > I think this is your perspective and induction, right? Did you measure
> > real hardware signals?
> >
> > My point is that if this is a hardware-level bus lockup, let's apply
> > quirk. If some malformed data causing kernel hangs, I'd add sanity chec=
k
> > on RX data, but I don't actually know what we should check for now.
> >
> > >
> > > > We have not modified RTL8821CE for a long time, so I'd add workarou=
nd
> > > > to specific platform as mentioned above.
> > >
> > > Adding a DMI/platform quirk specifically for this laptop to disable
> > > ASPM would be wonderful and deeply appreciated. I agree it is safer
> > > than touching the global flags for hardware that is functioning
> > > correctly out in the wild.
> > >
> > > Here is the exact identifying information for my system:
> > >
> > > System Vendor: HP
> > > Product Name: HP Notebook
> > > SKU Number: P3S95EA#ACB
> > > Family: 103C_5335KV
> > > PCI ID: 10ec:c821
> > > Subsystem ID: 103c:831a
> > >
> > > I am completely ready to test any patch or quirk you send my way.
> > > Thank you so much for your time and helping track this down!
> >
> > I sent a RFT [1] for test. Please check if it works on your HP notebook=
.
> > If you check rtw88 log, you can see I added similar patch 5 years ago,
> > and replaced by preferred the change of "rtwpci->rx_no_aspm", which I
> > think it can only resolve problem on partial notebooks though....
> >
> > [1]
> > https://lore.kernel.org/linux-wireless/20260311020816.7065-1-pkshih@rea=
ltek.
> > com/T/#u
>
> Forgot to say. Could you share your full name for me as a reporter
> in commit message?
>
>

