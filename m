Return-Path: <linux-wireless+bounces-22955-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37815AB7336
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 19:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F357E1893E5F
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 17:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DA727FD7F;
	Wed, 14 May 2025 17:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="S/rCkGLN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AD319C54E;
	Wed, 14 May 2025 17:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747244956; cv=none; b=KUDUSb6LuYeGYOfCz6UY14Sk0SNAa+wnYw1PRXPKOoFecRWaDWXdwyICuIkjyYuUg6un339GhPQzTv2c4vvJQctZvsDH84c9V4zJEWh1BVEKlHSV4z0ofwjqINZW/dEUWXt6h8wH0EecjjwM6OZMcLwNLr/zyIbkhektHcpLtg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747244956; c=relaxed/simple;
	bh=HX/3hIs0chu+gDP0UdaB6NCKBbswm6Ic2pPa9JtF9qw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N5SyS4lUfid66Kg4wHZsI4XZRdaQUtmwED7X5501vk1wqIHCIO4gh+bEif0BJktAJgB90+YMAkNiRkEKTlSQ4b8CX8OQBgpuvt9KDCI6yOO1WZOBRj/6hr1nYJGIMuGakh/OhTdgngB8D1OqkY5R1mi7lgz2MjyQ5j3rS3Jwmo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=S/rCkGLN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HX/3hIs0chu+gDP0UdaB6NCKBbswm6Ic2pPa9JtF9qw=;
	t=1747244955; x=1748454555; b=S/rCkGLNittr92NyfQKJPYEACrQ1EKcV5u/olnstgOMdEM9
	/JCf99a0awnwuJddQQdTx03LKvdRunUefHpBA2GaijKPzwq0GseTp/slI/URvEfoAUY0sGvs8fJUo
	MriRzLDQhRtnPXGVW00NkuVSBK4IsVtMSIW/ZYsSCX27TLSkeJhf7sc6nG/PvdZgp+kR6Lsd5fKv3
	mb8mm/h6PEudLQB1d2h5WBpnkie8KzkXiU5380j7u+0ORzYSX9Hbnv+hZhDRAzc/sJ3+jU+tBo5SI
	tI0htpkLPNANavkdhnOLsZFC7niOPHI9tcdUwdMgFDaCg/c2LAE5nDZrtohGf8gQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uFGEB-00000008U00-1cFh;
	Wed, 14 May 2025 19:49:11 +0200
Message-ID: <260e12b34c2043f54f399461274e983e43672093.camel@sipsolutions.net>
Subject: Re: lockup and kernel panic in linux-next-202505{09,12} when
 compiled with clang
From: Johannes Berg <johannes@sipsolutions.net>
To: Bert Karwatzki <spasswolf@web.de>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Cc: "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, 
 "llvm@lists.linux.dev"
	 <llvm@lists.linux.dev>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-wireless@vger.kernel.org
Date: Wed, 14 May 2025 19:49:10 +0200
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

On Wed, 2025-05-14 at 15:46 +0200, Bert Karwatzki wrote:
>=20
> When compiled with clang the disassembly of the function is (from objdump=
 -d)

Can you show with relocations ("objdump -dr" I think)? The jumps with
four 00 bytes don't really make sense if there aren't relocations for
them.

johannes

