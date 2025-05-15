Return-Path: <linux-wireless+bounces-22989-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3649AB7E04
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 08:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAC903AFB60
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 06:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D72183CA6;
	Thu, 15 May 2025 06:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Y1hna2Vo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D8E1CFBC;
	Thu, 15 May 2025 06:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747290655; cv=none; b=Q0nm3hC1JnNYxWi01CLjkvDTMxoE828AvpFV6HHDTZT3llOPAkkzdENFeSsoHx7DOlbkfBOUdbVV7fXDLpwuBt6q5DBjC7lKmMnYya+LpoooSySj807Bphe7loNgHzOeqcGXNVPgLcOPk1NIZWoOjRvhSZ7mt1TI2j6vPsiXF68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747290655; c=relaxed/simple;
	bh=jCueH2glao7FduKYS1PWXqjnvP3c1zoAtFN+O1aO+Xs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qxb4DKuO77aHwx7AbsrLMzocJwmlLK2WG50vbWcxUf/2IrfC9qejezrIM1FLECmp+jdXD1eTztpN/OBwnIkKSBSRtf95SYJxhPxjs8hM094WT87s6cs0eUQWIyZ3EU7y+rvHjUHpnhnstPPaGgQkyATPeOMyLd+fzVUQatQbu4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Y1hna2Vo; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=KvqrPFnT/M5tUerhMwh3HKF/Af24Nx/5fyc2diEVnYs=;
	t=1747290653; x=1748500253; b=Y1hna2Vo12IOysARB+aeIsGu8tgh46IQLs7jlsh20eYFjUH
	cqmfhFR8T/pXi+xJbhXz2mqZTzyuu7mTFL4E9dU3sUMZALAv/WNQFIVL6oBV2XoWlWDDXGoHWbz6l
	f5TiBLrcFdywdX7zbfoICfjriY44wC+t7CUHpWtQ8Ypgf9qW46Po8Urk7okEQRj/MKZKjhojh0O86
	z+wk8DgCS74GEKtm4Iu2wtfPLmcfE5JT1Fq4GUySt96I1YQ5a1TUI9jfiM7QiITL/aRFkkBHexz1c
	I7Q+BN565TWQuGukilGPg+6OmmcZeq83PDp/n4t5Fnb5FEB4KMQ88bhZClApPcog==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uFS7H-0000000AUU1-0IvF;
	Thu, 15 May 2025 08:30:51 +0200
Message-ID: <8684a2b4bf367e2e2a97e2b52356ffe5436a8270.camel@sipsolutions.net>
Subject: Re: lockup and kernel panic in linux-next-202505{09,12} when
 compiled with clang
From: Johannes Berg <johannes@sipsolutions.net>
To: Bert Karwatzki <spasswolf@web.de>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Cc: "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, 
 "llvm@lists.linux.dev"
	 <llvm@lists.linux.dev>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-wireless@vger.kernel.org
Date: Thu, 15 May 2025 08:30:50 +0200
In-Reply-To: <f8552d41fb7eae286803b78302390614179b33b0.camel@web.de>
References: <20250513164807.51780-1-spasswolf@web.de> <87h61ojg3g.ffs@tglx>
								 <7471a185adcc34a79c2ab8ce1e87ab922ae2232b.camel@web.de>
							 <b644ff1714731cfb652d809d4864f0d178b24a97.camel@web.de>
						 <2d8c1929bf5ab5260dacf9aa390456b3b49ce465.camel@sipsolutions.net>
					 <2cad838b39f00d93319509d2a6a77a4c42c7fa92.camel@web.de>
				 <a12c82c394e9676e32ede6b8312f821a16fef94b.camel@sipsolutions.net>
	 <f8552d41fb7eae286803b78302390614179b33b0.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-05-15 at 00:27 +0200, Bert Karwatzki wrote:
> Am Mittwoch, dem 14.05.2025 um 20:56 +0200 schrieb Johannes Berg:
> > >=20
> > > I've split off the problematic piece of code into an noinline functio=
n to simplify the disassembly:
> > >=20
> >=20
> > Oh and also, does it even still crash with that? :)
>=20
> Yes, it still crashes when compiled with clang.

OK, just checking. :)

FWIW, I'm not convinced at all that the code you were looking at is
really the problem. The crash (see below) is happening on the status
side. Of course it cannot crash on the status side if on the TX side we
never enter anything into the IDR data structure, and never tag the SKB
to look up in the IDR and therefore never try to create the status
report on the status side.

Basically what happens is this:

- on TX, if we have a socket requesting status, create a copy of the
  SKB, put it into the IDR, and put the IDR index into the original
  skb->cb
- then transmit the original skb, of course
- on TX status report from the driver, see if the skb->cb is tagged with
  the IDR value, if so, report the copy of the SKB back to the socket
  with the status information

(The reason we need to make a copy is that the SKB could be encrypted or
otherwise modified in flight, and we don't want to undo that, rather
keeping a copy for the report.)

>  [  267.339591][  T575] BUG: unable to handle page fault for address: fff=
fffff51e080b0
>  [  267.339598][  T575] #PF: supervisor write access in kernel mode
>  [  267.339602][  T575] #PF: error_code(0x0002) - not-present page
>  [  267.339606][  T575] PGD f1cc3c067 P4D f1cc3c067 PUD 0=20
>  [  267.339613][  T575] Oops: Oops: 0002 [#1] SMP NOPTI
>  [  267.339622][  T575] CPU: 0 UID: 0 PID: 575 Comm: napi/phy0-0 Not tain=
ted
> 6.15.0-rc6-next-20250513-llvm-00009-gec34cd07a425 #968 PREEMPT_{RT,(full)=
}=20
>  [  267.339629][  T575] Hardware name: Micro-Star International Co., Ltd.=
 Alpha
> 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
>  [  267.339632][  T575] RIP: 0010:queued_spin_lock_slowpath+0x120/0x1c0
...
> [  267.339692][  T575] Call Trace:
>  [  267.339701][  T575]  <TASK>
>  [  267.339705][  T575]  _raw_spin_lock_irqsave+0x57/0x60
>  [  267.339714][  T575]  rt_spin_lock+0x73/0xa0
>  [  267.339720][  T575]  sock_queue_err_skb+0xdc/0x140
>  [  267.339727][  T575]  skb_complete_wifi_ack+0xa9/0x120
>  [  267.339737][  T575]  ieee80211_report_used_skb+0x541/0x6e0 [mac80211]
>  [  267.339799][  T575]  ? srso_alias_return_thunk+0x5/0xfbef5
>  [  267.339804][  T575]  ? start_dl_timer+0xcf/0x110
>  [  267.339814][  T575]  ieee80211_tx_status_ext+0x3b3/0x870 [mac80211]
>  [  267.339851][  T575]  ? raw_spin_rq_lock_nested+0x15/0x80
>  [  267.339862][  T575]  ? srso_alias_return_thunk+0x5/0xfbef5
>  [  267.339866][  T575]  ? rt_spin_lock+0x3d/0xa0
>  [  267.339873][  T575]  ? mt76_tx_status_unlock+0x38/0x230 [mt76]
>  [  267.339886][  T575]  mt76_tx_status_unlock+0x1e0/0x230 [mt76]

Yeah so that's the crash on the status report as explained above, it
kind of looks almost like the skb->sk was freed and somehow invalid now?
But I don't see a general issue here (will keep digging), and how come
it only shows up with clang?

Since it reproduces pretty reliably, maybe you could do with KASAN?

Also could be interesting - what userspace are you running with wifi?
What tool is even setting up the wifi status? If you don't really know
maybe just put WARN_ON(1) into net/core/sock.s where SO_WIFI_STATUS is
written (sk_setsockopt).

johannes

