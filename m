Return-Path: <linux-wireless+bounces-25667-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEA0B0A80A
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 17:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 246033BB0D4
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 15:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AB42E5B0C;
	Fri, 18 Jul 2025 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="b2Wv6gID"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59EA26ADD;
	Fri, 18 Jul 2025 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752854260; cv=none; b=d/Ltm/BsZGwyFPZy0qRV/uwUpCy0nzKnWOJrGHHCsihl04UpijAos6/XTPjqO4Ogz7UJHgy3z3aJGvhCw6uZLr/YAxcLAckl39sAALZGcu7TNieP/3+7DG+7M5mIk/UAtXDQfAXa2bT32GkXAkPo+Q0eGLmEq+KUQ27nqrINVDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752854260; c=relaxed/simple;
	bh=LHLqqJFovhgxSpklvL5XVrRNk8HTcb+MZcN/GxLQd6s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fYwev+9B0UA1LQ3W7UVgfccJXErWGWx5MiHdbVhGIsZVmWApCpk01if08LgNyIRMRirV5CX0VDe9xm6r/GheRzhb9vKZ2rRUkiltopNZUFptIEkNl0fRF/j9TImWobqy4lXP2MY5EuTvZleO2ruu5oHW5lwF4gNJqEpp8TvVqBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=b2Wv6gID; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SulPe+WYKJoxLSlyxNtx26YPColW+wIyanOtCwJbKL8=;
	t=1752854258; x=1754063858; b=b2Wv6gID4qx47/Ra62pddlMHvZIShPIjavkQuMNjQEMNgD5
	/Ex43RsUFS+SodbCgD3nx29U1jDKV1Hk2aXMFKaV2v6C+y4/jg448OFq+u7tplKoFaw1dWlxbnvW2
	luq3qouoegRSAoDOmmpqHyx97tvZaq+U9bOf1PcBsnCMB5jziLMB7pnI4tNUrSu0/Q+wegmFKi1QG
	C9CEVRc5JDqDWt2fiQW0MJIapu4GihkEhEAX46R+Mg2W/SeJjLy/eVlFKuXyie1900wtOxW1JzLAR
	U99JHV7WE9rf+Zn3f+fENTQW2MKV5g1f7o5FyQT9yKvWm2/M7f8PBCFO/RnA+aSg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ucnSi-0000000CwCr-1R0U;
	Fri, 18 Jul 2025 17:57:28 +0200
Message-ID: <2d1a41aa000c8de8f82827bd8c06459e01f10423.camel@sipsolutions.net>
Subject: Re: [syzbot] [wireless] BUG: unable to handle kernel paging request
 in ieee80211_wep_encrypt
From: Johannes Berg <johannes@sipsolutions.net>
To: Eric Biggers <ebiggers@kernel.org>, linux-wireless@vger.kernel.org
Cc: syzbot <syzbot+d1008c24929007591b6b@syzkaller.appspotmail.com>, 
	ardb@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 mingo@redhat.com, 	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 tglx@linutronix.de, 	x86@kernel.org
Date: Fri, 18 Jul 2025 17:57:27 +0200
In-Reply-To: <20250718145049.GA1574@quark>
References: <6878cd49.a70a0220.693ce.0044.GAE@google.com>
	 <20250718145049.GA1574@quark>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-07-18 at 07:50 -0700, Eric Biggers wrote:
> >=20
> > BUG: unable to handle page fault for address: ffff8880bfffd000
[...]
> > Call Trace:
> >  <TASK>
> >  crc32_le_arch+0x56/0xa0 arch/x86/lib/crc32.c:21
> >  crc32_le include/linux/crc32.h:18 [inline]
> >  ieee80211_wep_encrypt_data net/mac80211/wep.c:114 [inline]
> >  ieee80211_wep_encrypt+0x228/0x410 net/mac80211/wep.c:158
[...]
> >  nl80211_tx_mgmt+0x9fd/0xd50 net/wireless/nl80211.c:12921
>=20
> syzbot assigned this to the "crypto" subsystem.  However, the crash
> happened in crc32_le() which is not part of the crypto subsystem.  Also,
> crc32_le() is well-tested (e.g. by crc_kunit), and the bug is unlikely
> to be there.  Rather, the calling code in ieee80211_wep_encrypt_data()
> is passing an invalid data buffer to crc32_le().  So let's do:

Agree, that makes sense, looks like we never check the frame length
correctly. Since there's no reproducer (yet) I guess we won't be testing
against it with syzbot though :)

johannes

