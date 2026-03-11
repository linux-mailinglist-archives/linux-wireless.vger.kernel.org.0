Return-Path: <linux-wireless+bounces-32992-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNISNeiJsWnkDAAAu9opvQ
	(envelope-from <linux-wireless+bounces-32992-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 16:27:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F7D2667DE
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 16:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 895193055231
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 15:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369143DEFF2;
	Wed, 11 Mar 2026 15:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRpyXx+H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D433DFC9E
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773242618; cv=pass; b=j5+inWpQmXEFPX5H+6j6ms0vVh0arvCINME8QhMGq2YPz7YrTwscyiDC/VbV8Xw4wwSGTobAhiTRabAO52zPO5EPyn1PglyyiG95yKh2n270bqyd7oZnvTqrxyYetDxzTKfzdnPoLNQFWsIAE2U0JVXhpU9FiNv8lQuFUhCmVhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773242618; c=relaxed/simple;
	bh=p+iclWnD+kyykRzF2SvREB99o+ZGj9rjuFfOf5xyVlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e8nSozCR6PbeXCX4tkhZSaqgyomE+0J+qaGTvSAg5B9HM+2dyeV/dhitqo72SeYmc5/wuudBnhTZJNfu0AMjkxoDHwbGAOjZot87zuzlj2ASWXQybhSaXaDpZXLjMdzqcout71vPhmBUTDHfOk0g6KYhS5lMLxLBbque2I/SPCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRpyXx+H; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d74aa6bcdbso31979a34.2
        for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 08:23:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773242615; cv=none;
        d=google.com; s=arc-20240605;
        b=UQXV0rKmqqIyv+xD5NtDgr4168CzZ4PAGIBeuCd8hAmvU/+3IL7zZxuTFSw5auErnw
         FLmQHTTi/BugtotHBd7t7ka2R+MCPpf3xRZgCdV/5k856PqFgweKM3mCA0lXFp9NPL6Q
         i+lzKeeTiSEj1G5a3exHHXTlLdL40ST5Oe9vdoax1XM4HRlEcP43/ZzYCZdN/mvzRsLM
         saovYdEroIuoPB+Z1iqEQI2DHa+LEK3ILr+CqWMisSxWulPLUxDtlA1eLm1NMK+0HV7t
         GRyDF6AQwWkCXXzRhKfQbZvIY8TKb7mJ8o1+mKdgpW3Yx6GrGRddGpjyHysVqEavQ8rg
         U3fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p+iclWnD+kyykRzF2SvREB99o+ZGj9rjuFfOf5xyVlI=;
        fh=fFUQ3bDSnwWYL/1dqZwPKYywXd5TONRsAevI/mvHYbI=;
        b=Kf9DpOAzql5SlBWALa7co2kCaneSylRYzsRtbbYbvtj7IVPYTUHi3KUJQXMCAtArz7
         NKp0G9IdeN7vv5SiCo4qqoJbO6pXoYa+x/xbEnS1uX6pyDLztaNO6dVoaPchICsQHfJx
         PskWnUIoMswYdHBe47SOCjTwmmm0OeQ3+FVMlNQ+q1YbEzxYEKg9p4XN6e1mH2I9bu9j
         khT8y+qqwWNvNjGyvgM6hyJyFCZmj54Ajb08J3PBMRMHZwRMuJQ2MVPxfjp1Q4R2T9dB
         JqXceYbcLyYd8EiUL/tLJM5ocohOIjLkb6N1oYIDC+TW0Y2W2X5VWU/VYOoRHbTg7jcS
         lTLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773242615; x=1773847415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+iclWnD+kyykRzF2SvREB99o+ZGj9rjuFfOf5xyVlI=;
        b=JRpyXx+HMwGcD2uctjjrGxCcqkrglMTxrdLoGhTFoDz4ELSaY8tkWhyCIqIRnEVC3d
         wm8Ovq2mIxQ5R6MLfJPUKcm0jnDYRSaeSX2Tci306/NZVOqlV9pQ+bCiv7ClIBLhEb4N
         VfEgjEbQ0IgzMvITFx6C6PJYAWQKVzP+Zz4NskJdDW36c+qmC8vdVW8rAyLB08h4o7BU
         Xf2qFPQKQ/GYWtovuV0hex1DY5mdVnKa/K9tj47xdb44zkFQM+ql6Mi+cb3o6jk9UECP
         6giiCdp/7wGLe61bS8kjOAjZBHo80sJFYfuRjvkKU5euhC+//vwcvc++l6kvI4bLt/xj
         s1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773242615; x=1773847415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p+iclWnD+kyykRzF2SvREB99o+ZGj9rjuFfOf5xyVlI=;
        b=ntl9Ksrbgqt9InvOPV0pGro5LQ6uvKaxswJDZP2uiCcxB+hiqHE8vlHJYBy2knH5UV
         D0pdCGBxMk+xFXhyQPsmhvc853bA4IX4VR1aMz7X8TafAWKRNGIJsj1b3tee1sVq4J1v
         1hofARjE8uMwKtITxOTSCvpdjuYfpxv20M25h2zi7v4TU8QBB7g86QXBAGeKvpT6QRP8
         ow3ghnYs+BN2kfs0qkk0CVuq+AIbmQzafXW1N7aL1gLjmwbOn5JC3fMyxRjxexTqFLCp
         cVqAqWU2/3iIWB8EjclnOqa3Ckbp6ycu9eDocxNczpBN2/cGsYmoidm1s+lH7DWC+yVd
         xo3w==
X-Gm-Message-State: AOJu0Yy3Sj/6Qtuw+y3HjQxs1A5zkzqcFQM+bZ6lWYzw/YaY1uadCgzR
	GsLZYF6vnpGXMkhI48rWdUQMIwLneM3twLLPZOgh4WszDlcr9vbnN1JKJiS0NOPAPWT3b8Vzp00
	kAj2fSCmuCR46LzCje7HD3W2qsYFPR44=
X-Gm-Gg: ATEYQzybY5v9Ts9sO0giRna8IsWeo0iUB0XOkF3Ap2hma1GmOmUYmM9OXkP8eC9Ynxh
	o0wuLbSN/gKdqs6ZAnV4mLST+gZIfMxD6CWfT9GwZ6THSImaaHPEfiyULpkoNQMVjCOty3dAACK
	T5GMkQOv6P5S2DGRV2MLgJCnQAQ11bieyC9fEUja91x68zKQeM+iJ+kUuozypZCpAIK+7Dyrld+
	JT0pdggQ1yM8kPJQ3djt+nJuJ2TqjjRwuL1vJUE981+NIljpFB+jqG7qwbUrzlYBe8D/q32+SDc
	L+DWET8G3NKxY9s9EDSrNnacSpLzGBF9L1Hn
X-Received: by 2002:a05:6830:4c0d:b0:7d7:4921:897d with SMTP id
 46e09a7af769-7d76a46af88mr1952155a34.0.1773242614997; Wed, 11 Mar 2026
 08:23:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <1e96af437fa24674b353ddb530b2d8e7@realtek.com> <CALdGYqQb=Vt0jjqW7k8RGMV1gczL0cg-26cHgCm3MmzBjezGMQ@mail.gmail.com>
 <792645eed36041f0b3df951f1b28a08a@realtek.com> <e6720993c8c14245981432cfa4ae902b@realtek.com>
 <CALdGYqQn8GGXXjZTsL+a5Mfdmw5HRYB2Jyvqq5M5SUwxK9yd_g@mail.gmail.com>
In-Reply-To: <CALdGYqQn8GGXXjZTsL+a5Mfdmw5HRYB2Jyvqq5M5SUwxK9yd_g@mail.gmail.com>
From: LB F <goainwo@gmail.com>
Date: Wed, 11 Mar 2026 17:22:52 +0200
X-Gm-Features: AaiRm533kMGVl9Z3MIboyRPgP4Dx0JyKQO4gSo1SUcPRXCyy9WHeNhNpWPeqSQ4
Message-ID: <CALdGYqQee1sjgdBAPJSyb1gL6ksK4z8Uw_v3ANTnyXE+LXFAiA@mail.gmail.com>
Subject: Re: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32992-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,realtek.com:email]
X-Rspamd-Queue-Id: D6F7D2667DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Ping-Ke,

I successfully applied your patch out-of-tree and performed rigorous
testing on the host machine.

I can officially confirm that the patch works flawlessly. The DMI
quirk triggered correctly and successfully prevented the
hardware-level PCIe bus lockups on my HP P3S95EA#ACB.

Testing Environment & Methodology:
- Kernel: CachyOS Linux 6.19.6-2-cachyos x86_64
- Toolchain: Clang/LLVM 21.1.8 (`make CC=3Dclang LLVM=3D1 modules`)
- Extraction: We fetched the strict
`drivers/net/wireless/realtek/rtw88` sub-tree out of the
torvalds/linux `v6.19` tree utilizing `git sparse-checkout` to cleanly
apply the patch without having to compile the entire 2.5GB+ kernel.
- The resulting `.ko` object files were compressed to `.zst` and
installed successfully over the generic CachyOS system driver objects.

Verification Conditions:
- Removed ALL local workarounds. `disable_aspm=3DY` is no longer forced
via `/etc/modprobe.d/` overrides.
- Power saving remains natively ON `wifi.powersave =3D 3` (managed by
NetworkManager).
- Left the laptop in multiple 5-10 minute complete idle states to
enforce sleep modes.

Post-Boot Log Analysis & Potential Improvement Proposition:
The system remained 100% stable without any kernel panics or UI freezes.
However, I continuously monitored the `dmesg` ring buffer and noticed
an intriguing behavior. While the laptop sits completely idle
(NetworkManager connected, but no active traffic), the `rtw88` driver
starts flooded the logs with thousands of firmware errors:

[ 1084.746485] rtw88_8821ce 0000:13:00.0: firmware failed to leave lps stat=
e
[ 1084.749662] rtw88_8821ce 0000:13:00.0: failed to send h2c command
[ 1084.752895] rtw88_8821ce 0000:13:00.0: failed to send h2c command

If my understanding of this architecture is correct, previously, when
ASPM wasn't disabled, this exact failure of the adapter firmare inside
`LPS_DEEP_MODE_LCLK` would violently lock up the PCIe bus and crash
the host. Now, thanks to your DMI ASPM quirk at the `rtw88_pci` level,
the host PCIe controller doesn't enter `L1` and is perfectly shielded
from the adapter locking itself up! The OS handles the timeouts
gracefully and driver recovery prevents a hard freeze.

A question for your consideration: Given the immense volume of these
`h2c` timeout errors (and the underlying firmware's fundamental
inability to cleanly enter/exit its own sleep states without L1
participation on this HP model), do you think it would be beneficial
to *also* dynamically disable LPS Deep sleep when this specific ASPM
quirk is triggered?

For example, dynamically forcing `rtwdev->lps_conf.deep_mode =3D
LPS_DEEP_MODE_NONE` when the DMI ASPM flag is active, strictly to
prevent the firmware from attempting a sleep cycle that is doomed to
fail and polluting the queues and logs? Perhaps this might also save
microscopic CPU interrupts from continuous H2C polling timeouts?

If you believe that simply letting the driver recover and tolerating
the error spam in `dmesg` is the preferred/safer upstream approach, I
am perfectly happy. The patch functions as advertised and system
stability is unequivocally restored!

Thank you immensely for your rapid debugging and definitive patch for
this long-standing issue and for bringing stability to this model.

Tested-by: Oleksandr Havrylov <goainwo@gmail.com>

*(Note: I was a bit unsure which of the two active mailing list
threads was the most appropriate place for this final report =E2=80=94 the
original bug discussion or the new RFT patch submission thread =E2=80=94 so=
 I
replied to both just to ensure it is correctly attached to the patch.
Apologies for the duplicate email!)*

Best regards,
Oleksandr Havrylov

=D1=81=D1=80, 11 =D0=BC=D0=B0=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 13:00, LB =
F <goainwo@gmail.com>:
>
> Hi Ping-Ke,
>
> Thank you for the incredibly fast turnaround and for providing the RFT
> patch with the DMI quirk!
>
> First, I want to mention that I am not an IT professional or a
> programmer. I am just a regular Linux user who really wants to help
> solve this problem. I am trying my best to verify everything
> carefully, so please forgive me if my terminology or induction was
> slightly off.
>
> To answer your clarifying questions from the previous emails:
>
> > Just want to clarify that these logs only appear in test 3, right?
> > No these logs in test 1/2.
>
> Yes, exactly. The `failed to send h2c command` errors only caused a
> complete system freeze when no workarounds were active and the adapter
> attempted to sleep (Test 3).
>
> > I think this is your perspective and induction, right? Did you measure
> > real hardware signals?
>
> You are entirely correct. This is just my induction based solely on
> the timing of the logs and system behavior. I do not have access to an
> oscilloscope or any hardware diagnostic tools. Given this, I
> completely agree that your approach of applying a platform-specific
> quirk is the safest and best solution.
>
> > Forgot to say. Could you share your full name for me as a reporter
> > in commit message?
>
> My full name is Oleksandr Havrylov. I would be honored to be included
> as the reporter in the commit message.
>
> ### Recent Baseline Testing Before Your Patch
>
> Before applying your patch today, we ran a few more controlled tests
> to double-check our baseline. We verified that our local workaround
> (`modprobe.d disable_aspm=3Dy`) **does indeed keep the system completely
> stable** and prevents the hard freeze, even when NetworkManager's
> `wifi.powersave` is set to ON (default).
>
> However, we noticed one interesting detail in the kernel logs: while
> the system no longer freezes with `disable_aspm=3Dy`, `dmesg` still
> constantly logs `firmware failed to leave lps state` and `failed to
> send h2c command` when the laptop is completely idle. It seems the
> firmware still crashes during LPS, but because ASPM is disabled, the
> PCIe bus ignores the crash and the system survives perfectly fine. I
> just wanted to mention this for completeness!
>
> ### Testing Plan
>
> I have **not** applied your RFT patch just yet. I wanted to make sure
> our testing baseline was 100% clean and documented first.
>
> I will compile your patch and perform rigorous testing this evening (I
> am in the EET timezone, Ukraine). I will test it with the native
> `power_save` fully enabled to ensure your patch successfully prevents
> the hard lockups as intended.
>
> I will stay in touch and reply back to this thread with a formal
> `Tested-by` confirmation (and any logs if needed) as soon as my
> testing is complete. Thank you again for all your help!
>
> Best regards,
> Oleksandr Havrylov
>
> =D1=81=D1=80, 11 =D0=BC=D0=B0=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 04:22, P=
ing-Ke Shih <pkshih@realtek.com>:
> >
> > Ping-Ke Shih <pkshih@realtek.com> wrote:
> > >
> > > LB F <goainwo@gmail.com> wrote:
> > > >
> > > > Hi Ping-Ke,
> > > >
> > > > Thank you for the incredibly fast response and assistance!
> > > >
> > > > > Can you dig kernel log (by netconsole or ramoops) if something us=
eful?
> > > > > I'd like to know this is hardware level freeze or kernel can capt=
ure something
> > > > wrong.
> > > >
> > > > I managed to pull a call trace from a historic journald log just
> > > > before the system hung. The kernel gets trapped in an IRQ thread
> > > > inside `rtw_pci_interrupt_threadfn`, calling up into `mac80211`
> > > > `ieee80211_rx_list` before everything freezes. Here is the relevant
> > > > snippet:
> > > >
> > > > ```text
> > > > Call Trace:
> > > > <IRQ>
> > > > ? __alloc_skb+0x23a/0x2a0
> > > > ? __alloc_skb+0x10c/0x2a0
> > > > ? __pfx_irq_thread_fn+0x10/0x10
> > > > [ ... truncated module list ... ]
> > > > Tainted: G W I 6.19.6-2-cachyos #1 PREEMPT(full)
> > > > Hardware name: HP HP Notebook/81F0, BIOS F.50 11/20/2020
> > > > RIP: 0010:ieee80211_rx_list+0x1012/0x1020 [mac80211]
> > > > CPU: 2 UID: 0 PID: 765 Comm: irq/56-rtw88_pc
> > > > rtw_pci_interrupt_threadfn+0x239/0x310 [rtw88_pci]
> > > > ```
> > > >
> > > > It behaves exactly like a PCIe bus deadlock or a hardware fault tha=
t
> > > > eventually brings down the CPU handling the IRQ.
> > >
> > > I wonder if there is a malformed data, causing this trace and the lea=
ds
> > > kernel freezes. If we can do validation on RX data before calling
> > > ieee80211_rx_list(), maybe trace disappears and everything will be fi=
ne?
> > > Even no need workaround.
> > >
> > > >
> > > > > Are these totally needed to workaround the problem? Or disable_as=
pm is enough?
> > > > > I'd list them in order of power consumption impact:
> > > > > 1. disable_aspm=3Dy
> > > > > 2. disable_lps_deep=3Dy
> > > > > 3. disable WiFi power save
> > > >
> > > > To verify which parameters are strictly necessary, I performed
> > > > isolated testing today. I ensured no other modprobe configs were
> > > > active, rebuilt the initramfs, and manually enforced that
> > > > `wifi.powersave` was active via `iw dev wlan0 set power_save on`
> > > > during all tests (as the OS power management profiles were defaulti=
ng
> > > > it to off, which initially masked the issue).
> > > >
> > > > I tested each workaround individually across multiple sleep/wake
> > > > cycles and active usage:
> > > >
> > > > **Test 1 (ASPM Disabled, LPS Deep Enabled):**
> > > > - Kernel parameters: `rtw88_pci disable_aspm=3Dy` (and `rtw88_core
> > > > disable_lps_deep=3Dn`)
> > > > - Result: Stable. No freezes were observed during usage or transiti=
ons
> > > > into/out of S3 sleep while power saving was enforced.
> > > >
> > > > **Test 2 (ASPM Enabled, LPS Deep Disabled):**
> > > > - Kernel parameters: `rtw88_core disable_lps_deep=3Dy` (and `rtw88_=
pci
> > > > disable_aspm=3Dn`)
> > > > - Result: Stable. No freezes were observed under the same forced po=
wer
> > > > save conditions.
> > > >
> > > > **Conclusion:** It appears we do not need both workarounds
> > > > simultaneously for this specific hardware. Using only `disable_aspm=
=3Dy`
> > > > seems to be sufficient to prevent the system freeze. Given your not=
e
> > > > about the power consumption impact ranking, this looks like the
> > > > optimal path forward.
> > >
> > > Let's test my RFT patch to disable ASPM then.
> > >
> > > >
> > > > > But what does 'deadlock' mean? As I know NAPI poll is scheduled b=
y ISR,
> > > > > and going to receive packets. The rx_no_aspm workaround is to for=
cely turn
> > > > > off ASPM during this period.
> > > >
> > > > By "deadlock" I meant a hardware-level bus lockup. It seems the
> > > > physical RTL8821CE chip itself crashes or hangs the system's PCIe b=
us
> > > > when trying to negotiate waking up from ASPM L1 while simultaneousl=
y
> > > > existing in `LPS_DEEP_MODE_LCLK`. The `rx_no_aspm` workaround in NA=
PI
> > > > helps during active Rx decoding, but the laptop often freezes while
> > > > completely idle, presumably when the AP sends a basic beacon, the c=
hip
> > > > attempts to leave LPS Deep + L1, and the hardware simply gives up a=
nd
> > > > halts the system.
> > >
> > > I think this is your perspective and induction, right? Did you measur=
e
> > > real hardware signals?
> > >
> > > My point is that if this is a hardware-level bus lockup, let's apply
> > > quirk. If some malformed data causing kernel hangs, I'd add sanity ch=
eck
> > > on RX data, but I don't actually know what we should check for now.
> > >
> > > >
> > > > > We have not modified RTL8821CE for a long time, so I'd add workar=
ound
> > > > > to specific platform as mentioned above.
> > > >
> > > > Adding a DMI/platform quirk specifically for this laptop to disable
> > > > ASPM would be wonderful and deeply appreciated. I agree it is safer
> > > > than touching the global flags for hardware that is functioning
> > > > correctly out in the wild.
> > > >
> > > > Here is the exact identifying information for my system:
> > > >
> > > > System Vendor: HP
> > > > Product Name: HP Notebook
> > > > SKU Number: P3S95EA#ACB
> > > > Family: 103C_5335KV
> > > > PCI ID: 10ec:c821
> > > > Subsystem ID: 103c:831a
> > > >
> > > > I am completely ready to test any patch or quirk you send my way.
> > > > Thank you so much for your time and helping track this down!
> > >
> > > I sent a RFT [1] for test. Please check if it works on your HP notebo=
ok.
> > > If you check rtw88 log, you can see I added similar patch 5 years ago=
,
> > > and replaced by preferred the change of "rtwpci->rx_no_aspm", which I
> > > think it can only resolve problem on partial notebooks though....
> > >
> > > [1]
> > > https://lore.kernel.org/linux-wireless/20260311020816.7065-1-pkshih@r=
ealtek.
> > > com/T/#u
> >
> > Forgot to say. Could you share your full name for me as a reporter
> > in commit message?
> >
> >

