Return-Path: <linux-wireless+bounces-34342-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLEsOM010Gnm4gYAu9opvQ
	(envelope-from <linux-wireless+bounces-34342-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Apr 2026 23:49:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B34F3988FE
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Apr 2026 23:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A31E03013248
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Apr 2026 21:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5D43009E2;
	Fri,  3 Apr 2026 21:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mP8aWg3c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF84B2D592F
	for <linux-wireless@vger.kernel.org>; Fri,  3 Apr 2026 21:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775252903; cv=pass; b=huk3VaDAOUIK9mm6BiLZ8iSYtVGc5PdrVh2tYYDRKB3/hxP8DIWgCzUcqeC718nJTiHNg0IWObdc/8d9RK1Bw/l8EJM9yA8PC8oi1Uy+DxNxGZ/XVCUWLbaJdcHrBPsNkCoAqisJU5S/O0GL6R6bmdTBSOtoYo4zI79Jqynyb9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775252903; c=relaxed/simple;
	bh=4Mybm8ZE4heOTROCwuYpcX2b5aSOvjUqyqV7WG5Fsrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YmXLr0BSLwtYgWC76SzZNcYEzAK188+GkZk+GwJl7OWUXylCEZNI//C9opUYIPC2uswXrB09V9EES+gEsBIzZBm0g3Snsl/bDLJ9Uq3SN3sc7Cd9WSOjD/XvpLHPwBCiJN5G4I3QuZ8ZygaUO8XXiFrM6MVHquBlBcKQUbqIbk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mP8aWg3c; arc=pass smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-40ee9b945d5so1833248fac.0
        for <linux-wireless@vger.kernel.org>; Fri, 03 Apr 2026 14:48:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775252901; cv=none;
        d=google.com; s=arc-20240605;
        b=XcVzROWDN+1mDW8pj/JpUhjMY1d2eqVxWzejNWs6aN6MJwCuONht43L2GrEPTB+vUc
         G+6QEzz26ZVDkOkz9U1VadK+YoIkf63JFB+hoKxMdV9CBeo5Rcbcuas4C3rnL95kY3Ye
         IO24A6eYvTdNeHDLeHl+LYMqxr2CoW0v4si7jhX77QdDAeI+9NPuJLhkhhMe/H3Mcos7
         UQLkA9dPs81W8ZwCYYT977FSbzzN9mCBnW2c+SnHdRn0R7damcW994MxlOb07WhIsX6j
         vSuIo5scFKGVGgb9GKzh5W5NnKdZWsZiU/tmBCbE++ZXeG1nKpAncF8xHGq/nSY/pusx
         7kng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9A/NvhOobEGKSNNHEG0vu4GE3BhoHnkh+A+reV/BCQ4=;
        fh=FzHZjjLUufp4mRCPfTTKUvuQTdjfHtmb3uLdBTo3ISI=;
        b=azeHtpspgqj2SmD6BlyieqlTAyTL08HnlbWooOBCp2hk6jvBdzuNw2UtMIJlLMDuw7
         h/iapydng2brYXYQxKsolwrYlLvnljVU4wLt4BAFhB3ObdkVN2IKhVX88XigxsrrHWrM
         FJkgCp8jh5CMOpke3numLY8HOtD8wNvSpphSZzvQWlin/0iDPxaP7Uywt/TsAg9Oh2mw
         mLEK8ljiA+B2zcOOVNbbsww5t3BDp6XduEsUv3XnmBRxrADqGExQXDPNinU1jM/GOf3X
         DX1lThjNaLObe/xQfFqkQmSK4GPvCch3KNhfRI1U9UbuqSfmNar9kTfacCRST0+saTv/
         BVog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775252901; x=1775857701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9A/NvhOobEGKSNNHEG0vu4GE3BhoHnkh+A+reV/BCQ4=;
        b=mP8aWg3cWubb1JARf0kjH3CrS9ga7vImKW5QefiUNoYusBDu37tk/Gs7Pzuzdw7DOW
         eWAznDbnZ2glvsHbumBWTV44YEbWp064FCD1vcWgRvdd7RJZw/80DQkxxZSPnBJRZQ+8
         PwmdmB6Zguyhi1J2BgFaruiigww89O+YZQ588hM6ISWV/6Jw4EMK4542Xx5wfDA2nmFu
         sYiDxfmy8r3tWzdYq6NXcW0+Fg//eI0B4mkWrrj/97V0fY6M/b0bRmSf6i32BZsUWMkH
         oTI5l4ilpnLYIFBRvlh10chTJEDi2nF6uyKxtEBzO3pmjAcabMhOYjE6O2EDDixF7vf4
         z/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775252901; x=1775857701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9A/NvhOobEGKSNNHEG0vu4GE3BhoHnkh+A+reV/BCQ4=;
        b=lfMSEezpmhP/lQB2jD7V4mM0s4zI1XnB1DLxY2oUCuNE2DlogyNr/tBhnlYARxcoyZ
         6U+Is5+jzqAZJhd21tFqI/O0OjpCvlvrBFq1g6zkMSnuybMKFEyieYKcZk7y3C1gjCkz
         nW6gABDqXiZjMDK3QrO4BKfWhqz5NrAwXVfsJXBTdC3XX2QMB2scCS+0N7OaECznIjgp
         /5I2SPHbuabycAhLS8b9bDpKKdL6NBKeo8rQFqMFVwqxCOZQZxpxaK51I9UC0IZmKbNz
         CvV76t/Ili4nlKw9/HcUIAShJ22Zwc5OP15eezCq/GeMwCMOcLjaqL2NFws8ix7hpMbI
         qJMg==
X-Forwarded-Encrypted: i=1; AJvYcCU949YHFArS8vwYqVWhn6uzJWKDXeX2egUDs27+Wa984C9f5ZfUao4mS9kZI6X0kBNcsScEa67joGrlAzhjEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAg15W7ywvHKE+8tz8RYXN1MV/zC24DW7EfI83hV/yW0t8dPGx
	FRa8qFrE8lEGUzBuDuyXKacYQdn7QLyCL00Kzqq64KG8ughKac4+MrChn48VEeB+fs7QGK8UhLw
	Y/tVRehWxaLOUg45bqRwUOyJ5//LcKRg=
X-Gm-Gg: ATEYQzx6udjgTU36LBstpkPSB+FmEJpqnxF+p3QYEzdMCE5Bqy5S2p4eHpsYn+gQ3sn
	vqUvCCw1sBVQSQAhS98nMqqy3op3X5TIrmHRrTtmxDCxx3HED7pBxtMufkAEhIU9Wgatc8HJGql
	an5irFJxuzAs6l738SJWvegcCtV6dlm2/c3xjqsVp0nAxuYsxX0NQ0IBJGnehEQ+/EY/+HNiF1o
	VCnhl2JuFb5oh2/N7MfxJv4kltVVun6z0pf8MY4cRFeeJHgp6BJvyYn5w5PZ+lfCnSkFB2xYKF6
	ztLNyY9n
X-Received: by 2002:a05:6870:158a:b0:41c:b538:e19c with SMTP id
 586e51a60fabf-423100855b8mr2360450fac.38.1775252900556; Fri, 03 Apr 2026
 14:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <CALdGYqQ3tS_aQpmf7xLkaCG9W55ATQXP=tnRNdjBAG8waqg8yA@mail.gmail.com>
 <dbe78a09fafe4a0ab16cd691049896a8@realtek.com> <CALdGYqQ3JQgFvvjiqh-ck8UqUQpAoJ0zeUzEL4i4Un8qPmqxJA@mail.gmail.com>
 <CALdGYqQuS5EOWCaeimr6PY758feF-DPo5i3XFwoQ8ewf4xnm7A@mail.gmail.com>
 <b231d63665334ac786e808610fe4a1e9@realtek.com> <CALdGYqSd61wxNrPDui+m-S+Na_is-RM18-=L6xm-Jf4QQ+-DOg@mail.gmail.com>
 <a8e187e1b40e4a35bbeb3bc3a3d21821@realtek.com> <CALdGYqRPcDRctCpNSJFatXvqMKLFiiRGXZoQa3KJwfwutHJEwA@mail.gmail.com>
 <ba9790526e4e42c386642a05fcbc2f34@realtek.com> <CALdGYqQ5U2USCqVEixoDda1Xd2ugBakh1K1QkaKAU7HPSTTNWg@mail.gmail.com>
 <CALdGYqQ_RCOwa2J-GsEyCxCQ4bztyxSzbc+6eYNesBSaY3Nt-w@mail.gmail.com>
 <da30a61b-dad0-48ff-a283-3dd8e9bdf91d@gmail.com> <CALdGYqS53=MmG4yCLwgV+RJAZ=U8Aqi8QQZFZ5oFMernhSyxTg@mail.gmail.com>
 <5eb90d6d-e590-4c9e-91c8-1ba315f45304@gmail.com> <CALdGYqRkX8=XMOePeauxvSTDZFLEYyJZKCtoxCzqaNwdO6BNnw@mail.gmail.com>
 <a5ea6373-8c07-4fcd-95fc-d87ce6aef6d5@gmail.com> <6898154c58c84536a0dd4351b3b026fb@realtek.com>
 <CALdGYqT2e+jt+mK-o_bL8hfdEwqZ44fUt9_N6-H4jYp8FpqQJw@mail.gmail.com> <5fb2f699626b483b8a0a537960b274f0@realtek.com>
In-Reply-To: <5fb2f699626b483b8a0a537960b274f0@realtek.com>
From: LB F <goainwo@gmail.com>
Date: Sat, 4 Apr 2026 00:47:44 +0300
X-Gm-Features: AQROBzBqZEhcsduHdj-XrMiDiS5dzH0XRbEDmf0fTypasx0HvHgeBhqW8dU9s4E
Message-ID: <CALdGYqThUD1DSAcsshC0y4Lm=uG=EDvBccMqkL=qr2+Jajp4tg@mail.gmail.com>
Subject: Re: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34342-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goainwo@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B34F3988FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
> If we can't find the reason for these weird frames, maybe the best
> way to filter them out is to check RTW_RX_DESC_W0_DRV_INFO_SIZE.

Hi Bitterblue, Ping-Ke,

I have a new crash to report that shows a different failure mode
from the garbage RX data, with some characteristics I haven't
seen before.

=3D=3D=3D NEW INCIDENT: 2026-04-03 =3D=3D=3D

The system froze approximately 1 second after Wi-Fi association
on a fresh cold boot (not resume from hibernation). Hard power-off
was required.

Timeline:
  17:16:16  Cold boot (PM: Image not found =E2=80=94 no hibernation image)
  17:16:38  wlan0 associated with AP (6c:68:a4:1c:97:5b)
  17:16:39  First "pci bus timeout" + mac80211 WARNING
  17:16:39-17:17:00  System frozen, hard reset required

Kernel: 6.19.10-1-cachyos (PREEMPT full, Clang/LLVM)
Patches applied: DMI quirk (ASPM+LPS disabled), rate validation v2,
  Bitterblue's diagnostic hex dump in query_phy_status.

=3D=3D=3D THREE DIFFERENCES FROM PREVIOUS CRASHES =3D=3D=3D

1) Zero "unused phy status page" events.

   Every previous incident had a burst of these messages before
   or during the crash. This time there were none at all. The
   corrupted data appears to have gone straight to mac80211 without
   triggering query_phy_status =E2=80=94 likely because PHYST=3D0 in the
   corrupted descriptors, so the diagnostic hex dump never fired.

2) Cold boot, 1 second after initial association.

   All previous crashes occurred after minutes to hours of uptime
   or shortly after hibernation resume. This one happened on a
   fresh boot before any power-state transition. ASPM and LPS Deep
   were already disabled by the DMI quirk.

3) Hang mechanism: infinite "pci bus timeout" loop.

   Not the NULL dereference (Bug 221286) and not the ASPM deadlock
   (Bug 221195). The loop produced 547 "pci bus timeout" messages
   and 41 mac80211 WARNINGs over 21 seconds.

=3D=3D=3D HANG MECHANISM (my reading of the code, please correct if wrong) =
=3D=3D=3D

The crash appears to follow this sequence in rtw_pci_rx_napi():

  while (count--) {
      rtw_pci_dma_check(rtwdev, ring, cur_rp);   // [A]
      ...
      rtw_rx_query_rx_desc(rtwdev, rx_desc, ...); // [B]
      ...
      ieee80211_rx_napi(rtwdev->hw, NULL, new, napi); // [C]
  }

At [A], rtw_pci_dma_check() detects an RX tag mismatch and prints
the warning, but returns void and the loop continues. At [B], since
PHYST=3D0, query_phy_status is not called. At [C], the garbage frame
reaches ieee80211_rx_list(), triggering WARNING at rx.c:896.

The RBP values across the 41 WARNING traces form a monotonically
increasing sequence from 0x55 to 0x1FF, which looks like cur_rp
cycling through the ring. Once exhausted, rtw_pci_get_hw_rx_ring_nr()
reads more entries from hardware (which is in a bad state), and the
loop restarts. The NAPI poll never returns.

The execution context migrated from irq/58-rtw_pci (PID 635,
170 traces) to ksoftirqd/1 (PID 26, 216 traces) as the softirq
was deferred, but the loop continued in both.

=3D=3D=3D FIRST WARNING (full trace) =3D=3D=3D

WARNING: net/mac80211/rx.c:896 at ieee80211_rx_list+0x1033/0x1040
  [mac80211], CPU#1: irq/58-rtw_pci/635

RAX: 0000000000020100 RBX: 0000000000000000 RCX: 0000000000000004
RDX: 0000000000000000 RSI: ffff8e56c7bb2f18 RDI: 0000000000000000
RBP: 0000000000000055 R08: 0000000000000004 R09: 0000000000000000

Call Trace:
 <IRQ>
  ieee80211_rx_napi+0x51/0xe0 [mac80211]
  rtw_pci_rx_napi+0x2fd/0x400 [rtw_pci]
  rtw_pci_napi_poll+0x79/0x1d0 [rtw_pci]
  net_rx_action+0x195/0x290
  handle_softirqs+0x12d/0x1c0
  do_softirq+0x56/0x70
 </IRQ>
 <TASK>
  __local_bh_enable_ip.cold+0xc/0x11
  rtw_pci_interrupt_threadfn+0x270/0x360 [rtw_pci]
  irq_thread_fn+0x24/0x50
  irq_thread+0xbc/0x160
  kthread+0x205/0x280
 </TASK>

=3D=3D=3D NAIVE HARDENING IDEA (please ignore if this is wrong) =3D=3D=3D

I am not a kernel developer and I may be misreading the code, but
I wondered if making rtw_pci_dma_check() return a value and
skipping the frame on tag mismatch might prevent the infinite loop,
independently of the DRV_INFO_SIZE filter. Something along these
lines:

--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
-static void rtw_pci_dma_check(struct rtw_dev *rtwdev,
+static bool rtw_pci_dma_check(struct rtw_dev *rtwdev,
                               struct rtw_pci_rx_ring *rx_ring,
                               u32 idx)
 {
-    if (total_pkt_size !=3D rtwpci->rx_tag)
+    if (total_pkt_size !=3D rtwpci->rx_tag) {
         rtw_warn(rtwdev, "pci bus timeout, check dma status\n");
+        return false;
+    }
     rtwpci->rx_tag =3D (rtwpci->rx_tag + 1) % RX_TAG_MAX;
+    return true;
 }

     while (count--) {
-        rtw_pci_dma_check(rtwdev, ring, cur_rp);
+        if (!rtw_pci_dma_check(rtwdev, ring, cur_rp))
+            goto next_rp;

I am sure there are considerations I am missing. Please treat this
only as a description of what I observed, not as a proposed patch.

=3D=3D=3D SUMMARY =3D=3D=3D

The garbage RX data from this chip now appears to cause at least
three distinct failure modes:

1) Bug 221195: ASPM/LPS deadlock (fixed by DMI quirk)
2) Bug 221286: NULL dereference via C2H_ADAPTIVITY misinterpretation
3) This incident: infinite loop triggered by DMA tag mismatch

I wanted to report this new failure mode in case it is useful for
your work on the DRV_INFO_SIZE filter. I can provide the full dmesg
from this crash (7828 lines) if it would be helpful =E2=80=94 just let me
know.

Best regards,
Oleksandr Havrylov

