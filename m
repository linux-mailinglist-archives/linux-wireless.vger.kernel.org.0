Return-Path: <linux-wireless+bounces-22856-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF46EAB2BEC
	for <lists+linux-wireless@lfdr.de>; Mon, 12 May 2025 00:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3315F175701
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 22:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF21262FF6;
	Sun, 11 May 2025 22:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=tsoy.me header.i=@tsoy.me header.b="IVVKuhC0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from puleglot.ru (puleglot.ru [195.201.32.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882191A5B95
	for <linux-wireless@vger.kernel.org>; Sun, 11 May 2025 22:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.32.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747002680; cv=none; b=nMagpWX0I/1FB7V1eel5Yw1tqBhaHuJQXh9WgXZPXph/pN6x48qDQl4Y8SIZp/Up4YU05dHijPMot+kogh80sWJKJESVlMTQaVfvNKb8iugEs0X99Midw33DnKOH9Ng/Pc6OoGbiXwhaivm3T+jdQtBSYSPOks5wXj7FsMVPjWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747002680; c=relaxed/simple;
	bh=aBnBzoIFoniefJiYbmW76aVR7ezh3i78bBci7FPCGCA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iSavfZqzKGTRGgnedvaFY6u6NpqiE7F+Zg4Rysn9KNG9pwWkUzAZLXYR4OCSdyIUUnMht8VNUeI4tPvpBmfgi+0L2Ff0iLGBc4YG/Md2qtRxTnNpArPgyy+SIA5c1dn+jC+SSqnxpugPUiEiXn8Hu0VB25qwvXQUVavmZguVZ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tsoy.me; spf=pass smtp.mailfrom=puleglot.ru; dkim=pass (1024-bit key) header.d=tsoy.me header.i=@tsoy.me header.b=IVVKuhC0; arc=none smtp.client-ip=195.201.32.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tsoy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=puleglot.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me;
	s=mymail; h=Sender:MIME-Version:Content-Transfer-Encoding:Content-Type:
	References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
	:List-Post:List-Owner:List-Archive;
	bh=aBnBzoIFoniefJiYbmW76aVR7ezh3i78bBci7FPCGCA=; b=IVVKuhC0DEdsOc6sHzpOVNlUfU
	78FQCIFqkzBWjL+qDctQYdoLEjs1qgZaqxQi9cgi2YTZRXc3ebRj18UaiGAtTEHxuMP16mm+tqcxV
	dLlbngb6l62d+zkNTNIRfFy5Xgf8t9a2Dr6E3Hg5nTUpwTMR5q7TNhipKtko6SwV6Q1o=;
Received: from [62.217.191.191] (helo=[192.168.1.144])
	by puleglot.ru with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <puleglot@puleglot.ru>)
	id 1uEFCJ-00000000u85-0GPs;
	Mon, 12 May 2025 01:31:03 +0300
Message-ID: <e63ac0579e0e3851a85020d2e575bd54a3dfd131.camel@tsoy.me>
Subject: Re: ath12k: kernel BUG at net/core/skbuff.c:209!
From: Alexander Tsoy <alexander@tsoy.me>
To: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>, 
	ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Mon, 12 May 2025 01:31:01 +0300
In-Reply-To: <d76df512-5098-6e14-113a-bd22fa3b6245@quicinc.com>
References: <9073c24c1fe0e00a8b925548c90ab2f15f3df2b3.camel@tsoy.me>
	 <d76df512-5098-6e14-113a-bd22fa3b6245@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: puleglot@puleglot.ru

=D0=92 =D0=92=D1=81, 11/05/2025 =D0=B2 22:40 +0530, Vasanthakumar Thiagaraj=
an =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>=20
>=20
> On 5/11/2025 12:30 AM, Alexander Tsoy wrote:
> > Hello!
> >=20
> > I recently got two QCNCM865 (wcn7850) cards and experience kernel
> > panics on different systems and different kernel versions. Card
> > info:
> >=20
> > [=C2=A0=C2=A0 13.584230] ath12k_pci 0000:0b:00.0: BAR 0 [mem 0xfc200000=
-
> > 0xfc3fffff 64bit]: assigned
> > [=C2=A0=C2=A0 13.584252] ath12k_pci 0000:0b:00.0: enabling device (0000=
 ->
> > 0002)
> > [=C2=A0=C2=A0 13.584636] ath12k_pci 0000:0b:00.0: MSI vectors: 16
> > [=C2=A0=C2=A0 13.584644] ath12k_pci 0000:0b:00.0: Hardware name: wcn785=
0
> > hw2.0
> > [=C2=A0=C2=A0 14.210605] ath12k_pci 0000:0b:00.0: chip_id 0x2 chip_fami=
ly 0x4
> > board_id 0xff soc_id 0x40170200
> > [=C2=A0=C2=A0 14.210613] ath12k_pci 0000:0b:00.0: fw_version 0x100301e1
> > fw_build_timestamp 2023-12-06 04:05 fw_build_id
> > QC_IMAGE_VERSION_STRING=3DWLAN.HMT.1.0.c5-00481-
> > QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> >=20
> >=20
> > Kernels I've tried so far: 6.12.24..6.12.28, 6.14.5, 6.15.0-rc5
> >=20
> > Synthetic load like pumping traffic via netcat or iperf seems
> > unable to
> > trigger this bug, but something like downloading of Steam games or
> > torrents is triggering this bug very quickly.

I was wrong. iperf3 with multiple parallel streams and bidirectional
mode enabled triggered this panic in several seconds for me:

iperf3 -t 3600 -P 10 --bidir -c ...

> >=20
> > Any ideas on what's going on here? I'm ready to test any patch.
> >=20
>=20
> Can you try with=20
> https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?id=3D=
763216fe6c5df95d122c71ef34c342427c987820
> =C2=A0
> ?

This patch seems to fix the problem. Thank you! I see a Fixes tag, so
hopefully this commit will eventually hit stable trees.

BTW, I also see IOMMU page faults under stress test (iperf3 command
above). This seems to cause device reset, but at least my systems
doesn't crash now.

