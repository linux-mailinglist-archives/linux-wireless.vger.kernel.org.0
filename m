Return-Path: <linux-wireless+bounces-11999-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6801295F8E6
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 20:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B5E31F22E59
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 18:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A3B194A4C;
	Mon, 26 Aug 2024 18:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ncznHNBb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF99824BB;
	Mon, 26 Aug 2024 18:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724696660; cv=none; b=YMAcUoBCL2uvte+AZ0a+T7EDozvMoAKo50D/YJ4BMLdBTnT2+IvfsH4xCDaKZ9WZRZqILdewstHnTn3rNKiF59j+n5aBiZvR98oLgaaluQLsYWQFAfJ1ZIJgpXFGNrJsdoEGKEwuPW4vk4Hjci1zYFAMNGAokXXTJC0NpeXkegk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724696660; c=relaxed/simple;
	bh=byxJHCkx5Iq4r6CRiwRwkfcMCKInE2GC/ymxSu+bhks=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WPLMnL5rxuYsfXjZmhXImM2AvGQd+eV56pjciOaGUnBTey3JbbbYeIFGUbVuVQqsTca1zLChKRQbGpQP3RbGL05lY4Bxn3EGJrMOc/cMklDzG9t3+zR6PWggvmwqQsjlSQ09+jMoAQM2tLqwe2DH0+Zjap1fcWV12S9VZmOWAgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ncznHNBb; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Cb7Yezg7cVEgPihDB4fJdUYT14KzFQDF5zArc6GNXOc=;
	t=1724696658; x=1725906258; b=ncznHNBbok0ZiEBpzu14cPJrNXbLVeJ79hlGWQHhvuJpG1q
	l2citja3YBF29Cuj95qYIUe/nh7iZ9bOl1o0DsH7E1YspONrayCioEh5xKHuLmzVEFhFsgTgU022G
	Fu0y7m8+F5xuhEari+nu1P5hz9ONDiKaNuXLkss/KadArdRtIkAmSIZhcZUcg5myLXyeMA+mhmOBo
	clF4yEmt41F5rT6aZsuaTGoWVrqYtTalCxq1DUBp7TXSlqhBRgUMDTYDXgsAURmVvyGmcAbBupHQ0
	xvtsKUepaawkyIVRUlcg2J43WIbkLiPBKxk6GXv0gp4yN/pzn4Ortl3Pxq/OC3PQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sieNt-00000003Mw0-3RFH;
	Mon, 26 Aug 2024 20:24:10 +0200
Message-ID: <2804ef964f4ce1c4689c1e741ef45e6b6d3f6422.camel@sipsolutions.net>
Subject: Re: [PATCH v5 0/4] tracing: improve symbolic printing
From: Johannes Berg <johannes@sipsolutions.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Date: Mon, 26 Aug 2024 20:24:08 +0200
In-Reply-To: <20240819182340.3bd23d67@gandalf.local.home>
References: <20240614081956.19832-6-johannes@sipsolutions.net>
	 <20240819182340.3bd23d67@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi Steven,

> I finally got around to testing your patches.
>=20
> I did the following:
>=20
>  # cat /sys/kernel/tracing/events/*/*/format
>=20
> and hit this:
>=20
> BUG: unable to handle page fault for address: ffffffff8e6333d0

Ugh. That's ... unfortunate.

I couldn't reproduce this so far, do you happen to have the .config and
qemu command line perhaps?


> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 183c40067 P4D 183c40067 PUD 183c41063 PMD 1003ef063 PTE 800ffffe7b9cc=
062
> Oops: Oops: 0000 [#1] PREEMPT SMP PTI
> CPU: 7 UID: 0 PID: 893 Comm: cat Not tainted 6.11.0-rc4-test-00004-g4ce28=
36f008b #56 68afcee1248519f8b3b088836c40746e4a6b69d3

I guess that's just my four patches; reproducing that (rc4 + the
patches, seems there was a small conflict in skb tracing) ...

> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2 04/01/2014
> RIP: 0010:f_show (kernel/trace/trace_events.c:1601 kernel/trace/trace_eve=
nts.c:1651 kernel/trace/trace_events.c:1689)

means this was


        for (i =3D 0; i < n_sym_defs; i++) {
                unsigned int sym_len;

                if (!sym_defs[i])            // <--- HERE
                        continue;

which seems really strange to me.

Sadly the

> Code: [...]

was compiled so we don't see 'i' here, and the stop value is on the
stack...

> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   33 63 8e                xor    -0x72(%rbx),%esp
>    3:   48 2d d0 33 63 8e       sub    $0xffffffff8e6333d0,%rax

the big constant here must be __start_ftrace_sym_defs, being subtracted
from an already loaded __stop_ftrace_sym_defs in %rax ...

>    9:   48 c1 f8 03             sar    $0x3,%rax

also part of the size calculation (n_sym_defs) - we have 8 byte pointers
in each entry, so >>=3D 3 makes sense.

Given RBX is 0xffffffff8e6333d0 as well, that means
__start_ftrace_sym_defs isn't a valid pointer? But then what was
__stop_ftrace_sym_defs? And why would the section be non-empty but
invalid to dereference?

>    d:   85 c0                   test   %eax,%eax
>    f:   74 67                   je     0x78

Anyway this aborts if there are 0 entries so we get non-zero in
%eax/%rax ...

I've actually tried now with an empty section, and that also works OK.

Is there something special about your build here?

johannes

