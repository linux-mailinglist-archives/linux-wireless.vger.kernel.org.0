Return-Path: <linux-wireless+bounces-26463-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A63B2CB33
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 19:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29AAB7B8769
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 17:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D41A30F7F7;
	Tue, 19 Aug 2025 17:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=comcast.net header.i=@comcast.net header.b="iLSI0kSq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from resqmta-h2p-567037.sys.comcast.net (resqmta-h2p-567037.sys.comcast.net [96.102.200.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFCC34AAFD
	for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.102.200.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755625160; cv=none; b=aiJlzNVST/GHsByTfDfUEkJroJgpCrM/r04dzax5QuG19PHOcVbgf9CeuVucjZVAZdRcgo1vYSEHrgc+Kcu11bJLifWiWj5ySAt1pPQO8Ea1iw2Lp6gEMOz4EzjYGtL2r3Esxr/LOCSUnGnqfcimPF8kW4pWZ+hsdcpwuEXtwTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755625160; c=relaxed/simple;
	bh=KkdjP+xkKFxvCc4AqsmRbpDrphwVii66/2aadOjXg0Y=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=BWep1znODk9qbWLJIJE2jtM/liWywnoOcwtyvSRDcOQVOr1Fq7jFCGu5k30J78rjBz6nExZlFQzzhRUAQGXU38kTtGfoS/XFphaXPMOwb0VJiYEOmQ0V+LhDzXSbNqNSk2LFz9HO8KCTok+9vhvqFOXGpsONT0gsnEwVdZ9DpKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=comcast.net; spf=pass smtp.mailfrom=comcast.net; dkim=pass (2048-bit key) header.d=comcast.net header.i=@comcast.net header.b=iLSI0kSq; arc=none smtp.client-ip=96.102.200.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=comcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=comcast.net
Received: from resomta-h2p-555359.sys.comcast.net ([96.102.179.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
	(Client did not present a certificate)
	by resqmta-h2p-567037.sys.comcast.net with ESMTPS
	id oORLuaAPe6tT4oQGGuWZPR; Tue, 19 Aug 2025 17:36:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=20190202a; t=1755625000;
	bh=KkdjP+xkKFxvCc4AqsmRbpDrphwVii66/2aadOjXg0Y=;
	h=Received:Received:Date:From:To:Message-ID:Subject:MIME-Version:
	 Content-Type:Xfinity-Spam-Result;
	b=iLSI0kSqEC8gmtuOtJcXCJIsNSKFQDiDaBM1tZqUk98vkyHvUcqiP9KvfYriiteIJ
	 F7BxdfMAuxOWW9yAXb/O2VcMfHwfCQtm8aAkBC0UHSx8rey4rCQnJeeM5inb7FJere
	 xNxWkewgi923uKYi4cnBZrjyj97ZJzp5hz2Q1uu2wwbdRsLygoxRFMuqUWDApOI3W/
	 zrO0HU+s+gyOqd8faRP8ulOBas97ojYJEPs4qaCUQiW2ei9w1n7LRvlLvyfvwXiZE7
	 Pwtb8+K/+sQrhg6jZnZt41MI+o9SbZJCN2Vl0RfsI2Gs/2PcvyuqaTsFKaYhyVBIW7
	 XO7F8jMku/P5g==
Received: from boobie.home ([73.69.89.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
	(Client did not present a certificate)
	by resomta-h2p-555359.sys.comcast.net with ESMTPSA
	id oQGCuwULGARtkoQGEuxiPw; Tue, 19 Aug 2025 17:36:40 +0000
Date: Tue, 19 Aug 2025 13:36:38 -0400 (EDT)
From: Ameer Antar <ameerantar@comcast.net>
To: Balsam Chihi <balsam.chihi@moment.tech>,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	jjohnson@kernel.org
Message-ID: <1321153053.0.1755624998195@boobie.home>
In-Reply-To: <CAONkfw58jcGRxotm2zJasQd56oDR-h0b3Z0Yi+pE8hdrmN=Ucg@mail.gmail.com>
References: <20250611164004.38580-1-balsam.chihi@moment.tech>
	<91fa8b1d-7bd0-4beb-80ef-eb65d2562f17@oss.qualcomm.com> <CAONkfw5Xyk8CGmVDpWZfkWnuCcFq6400jUkqyeMDtS0UNSh9vg@mail.gmail.com>
	<ecab2156-b234-4fba-a2ad-13a2d9b4693f@oss.qualcomm.com> <CAONkfw4hkDQtJyOj4RVsR3V=FJDJYKnjtmqzD=jBMy1ax=tC_A@mail.gmail.com>
	<0dfe48fc-085f-4dce-933d-e0f132d2ff9c@oss.qualcomm.com> <CAONkfw4p1AuE-MhGiZNMmi-PXR+CjoY63K2Yx_dmv2vnjo-Eyg@mail.gmail.com>
	<CAONkfw58jcGRxotm2zJasQd56oDR-h0b3Z0Yi+pE8hdrmN=Ucg@mail.gmail.com>
Subject: Re: [PATCH] ath11k: pci: avoid unsafe register access during
 shutdown
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CMAE-Envelope: MS4xfNRExL+WcnRtJHrQ+U/4CjUMmGo271K+AGvdIzEKIYIvoIe5010ScJCPoxAyx48TkXsb+RrGktvJ934s07EF2MPTEkl8Rm+uzcBcxnfcDQsePeZ/ymDd
 X7LA8pS+IAiCpNOs4aDW8o4quHpG+RcQEmgDY/27D/URLkW0ql7tOF3b5pSilynEVmEPnB9sqzyZqeT2mxuD3s1e8d9LusXW4q3Ece+BmpjJQ+AZt9vuJnyf
 Jq1ys2pyxfQlelPhFl9WOrKkEGmJ5G5qD5wA340oAGnyZ3mivTEEolF8Ueemi3HKUmqbGPtkh0KA3fBjjpADEyENbPGpt/7stfJuDD5wi0lYs7RjOYTQet4m
 jHh2vDyA

Balsam, do you have a patch for this? I also have cards that require differ=
ent
bin files for each band. I haven't been able to figure out how to do this v=
ia
configuration rather than rebuilding drivers.

Thanks.
-Ameer

----- Original Message -----
From: Balsam Chihi <balsam.chihi@moment.tech>
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
jjohnson@kernel.org
Subject: Re: [PATCH] ath11k: pci: avoid unsafe register access during shutd=
own
Date: 8/19/25 4:50:47 AM

>Hello,
>I Have a question on the same subject but not related to the bug.
>I have many identical PCIe WiFi cards on the system and I need to load
>a different board-2.bin on each one (1 adapter per frequency band).
>Is there any kernel built-in solution for that?
>I could not find any, so I had to create a patch that loads a
>different board-2.bin for each card based on the pci device address.
>I patched ath11k's core.c file so that it reads a string from a text
>file in the rootfs (board-2.bin path per wifi card).
>If the text file is not found, the driver loads the default file
>provided by linux-firmware for all cards, the original behaviour.
>Please let me know if there is a better solution for that.
>Best regards.
>Balsam

