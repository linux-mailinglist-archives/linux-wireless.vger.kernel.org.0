Return-Path: <linux-wireless+bounces-22958-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF15AB74DA
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 20:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07F834C2622
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 18:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A882882A6;
	Wed, 14 May 2025 18:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fhr8Yem1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4A52741A0;
	Wed, 14 May 2025 18:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747249018; cv=none; b=fthvCwxnkMdvHV32fOgjsQHQ2e05Gywv4pyFLehZKzwgYZgJzCOFO3cU8PE69Cjvj5F4LY8Gp/dbiWRhz9vri5joBFAH2qwBA4Pic1JQOfDzRR7Ec/QA7sPhYB2d7rfXfcaFSxdpm4+/2TIUPyt50MyPboiB4cDIYeOWNKHTANI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747249018; c=relaxed/simple;
	bh=KKvM3hBd7nGNbOxN+FBIYvDoZnjs3M9pvChXhh0uJdY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Piq0HhldovosrW6Qskw2fx7vdkhtMqaFZi/Mw//fP25ZGUrv6e6Y7VktrcAVzBXbtpkZmHS0UYqoNwzP1dAqdTvZkUDkVtWZAFxRyvDaLudvT1qu/9z3Y3trUlOArNSF6IILQEuCNLzhIOBljeXkQDdOmZF3vbmDeftOr5V/ebY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=fhr8Yem1; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=KKvM3hBd7nGNbOxN+FBIYvDoZnjs3M9pvChXhh0uJdY=;
	t=1747249017; x=1748458617; b=fhr8Yem12lVE49MtBkHcpjMN12ZLa2IpM1LysnNxRBi9Rh5
	QCs5O3+bDicDW5gL+Bw98GG2XgEeG0+S6kalHjreXu+0sTTRZBK9StpN2O7mgPmEoIz4+YJuUBLOL
	4ybjcTE8KNWvNIIFAW7vSsA+rAmiHmOO/YdQeIWQ2dOEByazWismWHhmRDwak9m05domEcinWrXZu
	aP/0SKdLkD4dEhSzYFhFI0fEEewhrODZ/rAt+IU+RB9YcPyBvLnlch9oJVPpdwSBjmik1AqjKtta8
	OfP2P5g+T1RRm4qWkt+UQXZtGFQ4vM4MDgaS53fA+6QN6jJTDbqCjoKgMYNXZkKQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uFHHi-00000008e1l-26qY;
	Wed, 14 May 2025 20:56:54 +0200
Message-ID: <a12c82c394e9676e32ede6b8312f821a16fef94b.camel@sipsolutions.net>
Subject: Re: lockup and kernel panic in linux-next-202505{09,12} when
 compiled with clang
From: Johannes Berg <johannes@sipsolutions.net>
To: Bert Karwatzki <spasswolf@web.de>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Cc: "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, 
 "llvm@lists.linux.dev"
	 <llvm@lists.linux.dev>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-wireless@vger.kernel.org
Date: Wed, 14 May 2025 20:56:53 +0200
In-Reply-To: <2cad838b39f00d93319509d2a6a77a4c42c7fa92.camel@web.de>
References: <20250513164807.51780-1-spasswolf@web.de> <87h61ojg3g.ffs@tglx>
				 <7471a185adcc34a79c2ab8ce1e87ab922ae2232b.camel@web.de>
			 <b644ff1714731cfb652d809d4864f0d178b24a97.camel@web.de>
		 <2d8c1929bf5ab5260dacf9aa390456b3b49ce465.camel@sipsolutions.net>
	 <2cad838b39f00d93319509d2a6a77a4c42c7fa92.camel@web.de>
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

>=20
> I've split off the problematic piece of code into an noinline function to=
 simplify the disassembly:
>=20

Oh and also, does it even still crash with that? :)

Still I feel it's possibly some kind of weird side-effect and not
strictly a compiler issue? But I don't see anything so far.

johannes

