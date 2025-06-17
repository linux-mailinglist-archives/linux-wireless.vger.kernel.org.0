Return-Path: <linux-wireless+bounces-24201-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBEFADC728
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 11:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7EF7179A1D
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 09:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35C92D9ED8;
	Tue, 17 Jun 2025 09:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="hlMtSG46"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FE0295D95;
	Tue, 17 Jun 2025 09:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750153837; cv=none; b=MNV+u6sHxj7dNPiWVzU2syuFs0EIxdEu7vtc2ocm0/8a60AuaZNhV5VVkzPm1avW0SV8hJgvvVTpK6mAs4u9taMa25Ma2v6lnYN88zDfQlDXpQvZ1c1L27Tk0s07QIGwsmsOao89zgzb6HbBMMPwssQzVr45p1Uw+opfJKD6w3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750153837; c=relaxed/simple;
	bh=lCvXiGlCxi8K96upupQrhg6ZesjBOryzIFfMfPNEc+E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OVD3QXC78zIH+zROkkbyBTNN95hrYZxoFPh4e2fpT9+jaIS3LOO4qSTJG3DNO1cCmyFf52SOnBZVXEORVCLdhwcN4yNoK/lY+JtvAps9PAH8Y+ZgI4yMyEwmUBuV8ZtsYNxyQChAf/9nuGCl5ly6+cYCV1kUWS7az+Vw1rdOabI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=hlMtSG46; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=lCvXiGlCxi8K96upupQrhg6ZesjBOryzIFfMfPNEc+E=;
	t=1750153836; x=1751363436; b=hlMtSG46337V3rSm9Hq+WKPYWUOhANgHqNZ8FPWw3Np3qa1
	hAc3WvIT5yWszdeZFN2MJnzUuPU0OBJyPjk3YEteFvDSKg/+b0aXFSyYwHDIF48oyVHnw9uSIarZX
	R3YBqa6wI8a5gtEK55XfHp/5E1qcN2EeVZhic49YRp3MaoqCH3ycuCFCLPC7iAOhsiqBgd1NUEC63
	cc3YDJuDEF+Eh6F61V/f9kv4M5NKYpNM71Q3uN8dWXj/BOVf60MHjuNzNZiUReci4XAvXvfZDOie7
	yMy5URtS/YxLf4g5EqmQoRbzkTzewZmQ4uNOmT7vN2kr+mkxA0Y2widNnUM218fg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uRSxd-0000000EFbx-3DuP;
	Tue, 17 Jun 2025 11:50:33 +0200
Message-ID: <49456d11ed8d4ff3adc71286b17dc657a6db131b.camel@sipsolutions.net>
Subject: Re: [syzbot] [wireless?] WARNING: net/mac80211/tx.c:LINE at
 __ieee80211_beacon_get, CPU: syz.NUM.NUM/NUM
From: Johannes Berg <johannes@sipsolutions.net>
To: Aleksandr Nogikh <nogikh@google.com>
Cc: syzbot <syzbot+468656785707b0e995df@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Date: Tue, 17 Jun 2025 11:50:32 +0200
In-Reply-To: <CANp29Y5+W426u0jUz0PT=zVde+QqSD9H1fLpTuaKSzCLrt5FcA@mail.gmail.com> (sfid-20250617_114851_219552_D4A7444C)
References: <6850d3bd.a70a0220.395abc.01fa.GAE@google.com>
	 <CANp29Y68ZaQnb0R2fZSLjcCxiOE3uZyW4b7wLEYMAycF0WHNUg@mail.gmail.com>
	 <97d6493279ab5c63e8844e8b0f349b2528d2832b.camel@sipsolutions.net>
	 <CANp29Y5+W426u0jUz0PT=zVde+QqSD9H1fLpTuaKSzCLrt5FcA@mail.gmail.com>
	 (sfid-20250617_114851_219552_D4A7444C)
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

On Tue, 2025-06-17 at 11:48 +0200, Aleksandr Nogikh wrote:
> On Tue, Jun 17, 2025 at 11:43=E2=80=AFAM Johannes Berg
> <johannes@sipsolutions.net> wrote:
> >=20
> > On Tue, 2025-06-17 at 11:34 +0200, Aleksandr Nogikh wrote:
> > > #syz dup: WARNING in __ieee80211_beacon_get
> > >=20
> >=20
> > Not just this one :)
> >=20
> > https://lore.kernel.org/linux-wireless/20250617104902.146e10919be1.I85f=
352ca4a2dce6f556e5ff45ceaa5f3769cb5ce@changeid/
> >=20
>=20
> Ah, interesting :)
>=20
> FWIW, in this particular case, syzbot sent the duplicate report
> because the WARNING format has somewhat changed in the latest
> linux-next. So before we updated syzbot's parsing rules, it had
> managed to re-report quite a few duplicates.

Right, I had noticed that, but then I looked and the old counter is
already at well over 100k so I decided to finally look at it again ;-)

This is a really long-standing problem that we discussed a few times in
the past I think, and basically the system is loaded enough that the
hwsim hrtimer can fire on time and pull the beacon, but the workqueues
are overloaded and cannot do the necessary work within the ~100ms beacon
interval ...

Should be rare in practice, but a WARN_ON() that doesn't say anything
about what's going on doesn't help anyway.

johannes

