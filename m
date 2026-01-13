Return-Path: <linux-wireless+bounces-30742-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CECBD186C6
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 12:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5E3E23008DCE
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 11:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFC2350A1E;
	Tue, 13 Jan 2026 11:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Gsg2RAsE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6659438B9B6;
	Tue, 13 Jan 2026 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768303195; cv=none; b=bKYScQoECq/1K1OxmS6Qqg/g/nPObLnvuxyj+Oza37UvBkRj5WMqWPaa/zxEc2HdHYZzgKklHnyiQer6mqYHpiLLBl4KbbMEYRbkFsoaYiqc8+T1wKLBkSYbx/0JVkaDkjIAj5HD/KdQITxETN94ROWo5PILqtuMESmT4/W0y5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768303195; c=relaxed/simple;
	bh=AgTT5HlCyyYIjme2prm71/AX046SuCNPX/VCh/YHF4I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BNByN6yVFrjEiVSsws9sBwUWbuzZNCt/xq/gg0Zrbnf48xTMXZD0HGIVXE8EeClBwm1YSia0CKI01rInmi2fJXezdQb5VEcuKh2FFHE8czI7Eq388OI5+AnZdTeQ2/OrUfnz6HwYh4+Ptuo/1TjHQzPrW12uiew3qjBPGfu9zTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Gsg2RAsE; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=AgTT5HlCyyYIjme2prm71/AX046SuCNPX/VCh/YHF4I=;
	t=1768303194; x=1769512794; b=Gsg2RAsEKY+CNRTk6+vl5HVKyqN56Fxi6c3kAWw+3I8Zw5t
	s/sMUC0sQTtDL7ZhvfaWLy5d9Z9DbTDk8BoowS65Ike06y7gC/mSXaPrirPK1Q82shOlimn/PLn0B
	uLXNmiZ0VVyy0xwcJ1FS5fe37FfWHNfRKEvWuSjwQA9NJm9vQKlfecoCdBSFc55QsrLue0xRqmI3B
	dGzaZG8hG+tVNMARBcBBbmcrHRh3OqN6dOBtjLLMMHTsyIW3QREc8xRaLoAODwhvjSDuX1Pbo0i+a
	BpbAhz1WZTUtr8wkuotkh3JYErua1ANPyFv6sdRKKvDAVP8SA/ZO3Oi2ec7ojSSw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vfcRD-0000000Ajh6-401W;
	Tue, 13 Jan 2026 12:19:52 +0100
Message-ID: <ed1279c6d79e13f9679ac33ea47201d5eea2d1c4.camel@sipsolutions.net>
Subject: Re: [PATCH 0/3] replace system_unbound_wq, add WQ_PERCPU to
 alloc_workqueue
From: Johannes Berg <johannes@sipsolutions.net>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, Tejun Heo	
 <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Frederic
 Weisbecker	 <frederic@kernel.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>,  Michal Hocko <mhocko@suse.com>
Date: Tue, 13 Jan 2026 12:19:51 +0100
In-Reply-To: <CAAofZF4Ptjmo=7taHuw_rdya-kGhEZGqXbQn8yPCi1pgA24mkw@mail.gmail.com> (sfid-20260113_121659_166861_57149C6B)
References: <20251113162032.394804-1-marco.crivellari@suse.com>
	 <CAAofZF5yenY8Q92taaJW2-=kenDVuc6ABEtbVT5+yzM_pBVZsw@mail.gmail.com>
	 <2f4c22558d20b42615adde772551c1bfb346da47.camel@sipsolutions.net>
	 <CAAofZF4Ptjmo=7taHuw_rdya-kGhEZGqXbQn8yPCi1pgA24mkw@mail.gmail.com>
	 (sfid-20260113_121659_166861_57149C6B)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2026-01-13 at 12:16 +0100, Marco Crivellari wrote:
> On Tue, Jan 13, 2026 at 12:05=E2=80=AFPM Johannes Berg
> <johannes@sipsolutions.net> wrote:
> > I have none of these pending now - if I didn't accept them then they're
> > lost. I did try to apply another similar one yesterday but it was
> > already there in a slightly different format, so maybe things have
> > gotten out of sync?
> >=20
> > johannes
>=20
> Hi Johannes,
>=20
> That's likely.
> I rebased now on v6.19-rc5 and I can only see in my branch:
> "ath6kl: add WQ_PERCPU to alloc_workqueue users".
>=20
> The others seem already applied.
>=20
> Well, sorry for the noise.

OK cool, no worries. FWIW I might have even more in wireless-next:
https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/

If you want to see what's pending, we have it in patchwork for wireless:
https://patchwork.kernel.org/project/linux-wireless/list/

The ath6kl one seems to be pending still on Jeff:
https://patchwork.kernel.org/project/linux-wireless/patch/20251113162032.39=
4804-2-marco.crivellari@suse.com/

johannes

