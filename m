Return-Path: <linux-wireless+bounces-19943-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FF5A55930
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 22:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378ED17639F
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 21:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C172702B8;
	Thu,  6 Mar 2025 21:59:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from burlywood.banana.relay.mailchannels.net (burlywood.banana.relay.mailchannels.net [23.83.217.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AA3DDA8;
	Thu,  6 Mar 2025 21:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.217.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741298342; cv=pass; b=nCeyltdN2x7gNASjVN18f0uQLKxu6K37mLrnq+dy7q6MGjthw9W8Rs4P3d+Lqx28BDpsh3D9eZ8rL0e7hUAdeYchugQYRGqLAZ+A3a5Sc+RBan8SIwM46X2d4oBbkzlCFkWZ9A7r/quiZvJPjTeHY6CzZgftlCzuIgdaMxvmy7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741298342; c=relaxed/simple;
	bh=x85IKOUDMetD3cWMsRrc+ygQOk3AL4sFBuDAkZwKGnU=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=pxWQSv4hYGj11jkl7H62ERle+lfQnaHzWS09m2YfiKa7prfjAM8IFpiQS7MNEb/kWhnvJ0GhZJsnsNGfkroL0tQsX5WopFoSKWy+RGN8RZOSewFoBgxMgPXywZZO7tl9xyGGAvluRHN2Pb6frojPoTZa4ftpk1tuYvJHiW7xGmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.217.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 1800A902AFC;
	Thu,  6 Mar 2025 21:58:53 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (trex-8.trex.outbound.svc.cluster.local [100.110.242.246])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 3EDD090173F;
	Thu,  6 Mar 2025 21:58:51 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1741298332; a=rsa-sha256;
	cv=none;
	b=gj2qZAnl1VmezwlhFJILxwf3tFA2kTrUiw1ifOsZvDnpiGmlc+envH2xTL+0oMMa2AHdpS
	36EdOjPHO8/YvACuPWZPdNkbZG/6mjqS/c88xUYF0kHpqhWWEH40ueXyYZ/GblI7i1qZpq
	yniHIRLrkI/j5+ecFnb08vXJqS6L2MNeBJ83PL92YjIzBuiv2ocfyW4Pcjh9RlCyyhvigm
	6lL8R7xqAjsz3i+AtLPx2yxu5RvjTkzUb175E3sIKHo0fwMwD704GauFoAss7D7FH9RSj4
	r0tmvfvt4I3K8c5q5C0abjnu+FpfVdbLKLLTXueuYGdwLttT7QfG+o+XHxgO6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1741298332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=u8qhA0uxvrHR5WzwTb3W+XkTh2s1bT1ikVhVCsD9+xE=;
	b=EAsEpGHsCy2a4HvVUtUlM4ooewUrF59ZYlfA39tXX59Ci5u6Ofbk5wzxm/DZbJCljDfhTj
	yJZePTmzjBwZ7UEcmk4JiTD/Ww803XECmRZVIMd8q9itPJbITkdN+DN/6w39FZjfQg5RFd
	ZIWN6qf9biq+eRYQoLnTDV/fwL805W5KEfBvmAsLOPd2BuFldAbjDxR9ApqN/5+50+5Gvl
	In90iDuX8ovBkaMcqW2gOUQ2s9o17Iy52VN1E+zXxifDXwwfkinW+EiAh9YX52OJb/6XI0
	esQSP1Ih/bCQakMuosegcTjvK1f+9E2ppjTXNmB3jWNQng/iCll+FqH4XMho6Q==
ARC-Authentication-Results: i=1;
	rspamd-7ffbdd7fb5-6hg6d;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Junk
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Stop-Chief: 058844312af42ceb_1741298332909_2953574093
X-MC-Loop-Signature: 1741298332909:3442722564
X-MC-Ingress-Time: 1741298332909
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.110.242.246 (trex/7.0.2);
	Thu, 06 Mar 2025 21:58:52 +0000
Received: from p57b04755.dip0.t-ipconnect.de ([87.176.71.85]:63455 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98)
	(envelope-from <calestyo@scientia.org>)
	id 1tqJEw-00000005m79-1OJy;
	Thu, 06 Mar 2025 21:58:49 +0000
Message-ID: <1fdfce01346136012f5f92b8845d272f8de58652.camel@scientia.org>
Subject: hibernate suddenly broken (by )
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Cc: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Date: Thu, 06 Mar 2025 22:58:47 +0100
Content-Type: multipart/mixed; boundary="=-SePPexmLADu7eRFnrr4g"
User-Agent: Evolution 3.55.3-1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

--=-SePPexmLADu7eRFnrr4g
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey.

[Sorry for the cross posting, but I guess the cause for the issue
described below is in iwlwifi and/or mtk_t7xx, so adding the lists
mentioned in MAINTAINERS for those, as well as the mtk_t7xx maintainer.
:-) ]


Since a few days, hibernation is broken (i.e. it aborts after trying to
hibernate).


Things that may be worth to mention are:
- running on Debian unstable
- full disk encryption with dm-crypt, booting from USB
- hibernation goes into btrfs swapfile (within the same dm-crypt LUKS
  volume)

That setup has worked now since quite a while, at least since btrfs-
progs added the btrfs inspect-internal map-swapfile to find out the
proper resume offset (which was in 6.1... so around end of 2022).


For your information, but probably unrelated to this issue is, that S3-
suspend (i.e. "deep") has been broken ever since I got that device:
https://bugzilla.kernel.org/show_bug.cgi?id=3D216998
I recently (see below) had another conversation with a Fujitsu support
guy, who then claimed S3 would have been deprecated and thus not been
implemented by that device.


Normally, when I go into hibernate, Cinnamon locks the desktop, I see
how the clock (respectively the processes) freeze, the screen goes
completely off (with backlight), then goes on again (still frozen) and
then it shuts off.
With the bug, after the screen went on again, it unfroze (and then
stayed running).


Detailed kernel logs attached, with the following done:


0. In a few tries for which I haven't attached the logs hibernate
   always seemed to succeed once, and subsequent tries would fail
   (until I freshly booted without resume)


1. hibernate.1.log
   Kernel 2.12.17
   Booted with WiFi disabled (via NetworkManager), where
   enabling/disabling seems to simply set the soft block on the device,
   i.e.:
   disabled
      # rfkill list=20
      1: phy0: Wireless LAN
      	Soft blocked: yes
      	Hard blocked: no
   enabled:
      # rfkill list=20
      1: phy0: Wireless LAN
      	Soft blocked: no
      	Hard blocked: no
     =20
   Description what I did, within the log.
   In short, as long as I've kept WiFi disabled (though I did only a
   few tries, so this may be coincidental) it seemed to have kept
   working.
   After enabling WiFi, it already failed on the next try.
   Disabling it again, didn't help.
   In some of the #0 tries I even tried to remove iwlwifi modules (but
   not mtk_t7xx), but that didn't help either.


2. Same as #1, just with WiFi enabled from the fresh boot on.


3. There were only two recent package upgrade which could have been
   related.
   One was upgrade from 6.12.16 to 6.12.17, though IIRC I had already
   run a few days with 6.12.17, and it worked.
   Still downgraded and tried with that.

   But also failed with 6.12.16.


4. The only other upgrade was NetworkManager (which went from 1.50.3-1
   -> 1.52.0-2).
   So tried with that downgraded. Failed again eventually.


5. In my 5th test series I've disabled the WWAN device in the BIOS
   (and surprise what mtk_t7xx is doing ;-) ):
   I don't use it anyway, but I'm pretty sure that I've had that
   (accidentally enabled already like half a year or so ago), because
   I kept seeing mtk_t7xx errors during previous boots since around
   6.10 or so maybe also a bit earlier, which apparently caused however
   never problems with hibernate.

   With the WWAN device disabled in BIOS mtk_t7xx isn't even loaded
   anymore.

   After 5 hibernation/resume cycles, which all worked, I've stopped
   testing.


The only other "change" was that I've recently tried to flash a EC
firmware upgrade from Fujitsu, but the flasher (which I had to run from
some Windows USB stick), fails already before actually doing anything,
an the BIOS/UEFI still shows the EC firmware on the old version.

So I'd strongly guess that no flashing actually took place, and that
this is unrelated.


So I guess the problem are these:

Mar 06 21:07:40 heisenberg kernel: mtk_t7xx 0000:58:00.0: [PM] SAP suspend =
error: -110
Mar 06 21:07:40 heisenberg kernel: mtk_t7xx 0000:58:00.0: can't suspend (t7=
xx_pci_pm_runtime_suspend [mtk_t7xx] returned -110)

respectively

Mar 06 21:08:08 heisenberg kernel: mtk_t7xx 0000:58:00.0: [PM] SAP suspend =
error: -110
Mar 06 21:08:08 heisenberg kernel: mtk_t7xx 0000:58:00.0: PM: pci_pm_freeze=
(): t7xx_pci_pm_suspend [mtk_t7xx] returns -110
Mar 06 21:08:08 heisenberg kernel: mtk_t7xx 0000:58:00.0: PM: dpm_run_callb=
ack(): pci_pm_freeze returns -110
Mar 06 21:08:08 heisenberg kernel: mtk_t7xx 0000:58:00.0: PM: failed to fre=
eze async: error -110

and/or these:

Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3: CSR_RESET =3D 0x10
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3: Host monitor block=
 0x0 vector 0x0
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 0]=
: 0x3f1d0430
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 1]=
: 0x3f1d0430
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 2]=
: 0x3f1d0430
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 3]=
: 0x3f1d0430
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 4]=
: 0x3f1d0430
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 5]=
: 0x3f1d0430
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 6]=
: 0x3f1d0430
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 7]=
: 0x3f1d0030
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 8]=
: 0x3f1d0030
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 9]=
: 0x3f1d0030
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 10=
]: 0x3f1d0030
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 11=
]: 0x3f1d0030
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 12=
]: 0x3f1d0030
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 13=
]: 0x3f1d0030
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 14=
]: 0x3f1d0030
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3: Host monitor block=
 0x0 vector 0x1
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 0]=
: 0x040066c2
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 1]=
: 0x040066c2
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 2]=
: 0x040066c2
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 3]=
: 0x040066c2
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 4]=
: 0x040066c2
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 5]=
: 0x040066c2
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 6]=
: 0x040066c2
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 7]=
: 0x040066c2
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 8]=
: 0x040066c2
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 9]=
: 0x040066c2
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 10=
]: 0x040066c2
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 11=
]: 0x040066c2
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 12=
]: 0x040066c2
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 13=
]: 0x040066c2
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 14=
]: 0x040066c2
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3: Host monitor block=
 0x0 vector 0x6
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 0]=
: 0xa00c7c75
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 1]=
: 0xe00c7c75
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 2]=
: 0xf00c7c75
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 3]=
: 0xf00c7c75
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 4]=
: 0xb00c7c75
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 5]=
: 0xb00c7c75
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 6]=
: 0xb00c7c75
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 7]=
: 0xf00c7c75
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 8]=
: 0xf00c7c75
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 9]=
: 0xf00c7c75
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 10=
]: 0xb00c7c75
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 11=
]: 0xa00c7c75
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 12=
]: 0xa00c7c75
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 13=
]: 0xe00c7c75
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 14=
]: 0xe00c7c75
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3: Host monitor block=
 0x22 vector 0x0
Mar 06 21:47:34 heisenberg kernel: iwlwifi 0000:00:14.3:     value [iter 0]=
: 0x61cec019



No idea which change caused the sudden breakage of hibernate... and the
workaround (disabling the device) is okay for me,... still, would be of
course good if this could be fixed.


If I can help anything or you need further information, don't hesitate
to ask. :-)


Cheers,
Chris.

--=-SePPexmLADu7eRFnrr4g
Content-Type: application/x-xz-compressed-tar; name="logs.tar.xz"
Content-Disposition: attachment; filename="logs.tar.xz"
Content-Transfer-Encoding: base64

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


--=-SePPexmLADu7eRFnrr4g--

