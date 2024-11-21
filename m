Return-Path: <linux-wireless+bounces-15572-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 670559D51E8
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 18:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7F41F21055
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 17:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28D6156F5E;
	Thu, 21 Nov 2024 17:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xPHutfyv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ADC19D8B4;
	Thu, 21 Nov 2024 17:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732210844; cv=none; b=RjLCXVna+KKdPI/vd3pgz9spxn6iSOIg4wvwXXEwvQ7nBZZyA2XeAFynj+Q2JHHwzkO5+a0o/O2TX8gYIurLHjskQhtmELGTd0Y00yDjI0tWSiKAZI0YxxqXm8y6Ijbh3chVIDzTO5Y4gPjup8ol8O5ByMB4oUlG70tKHmltNls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732210844; c=relaxed/simple;
	bh=kUQIwcMNXEKH1QLWIbh2Ln8HwwNhBpHFvJDE5NUUPX8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PzhErRLY4iejUw45I9z9gTV5kgPuoj97E6yZpAgE5TSQSC8UXypK20h2cIEylNFMcE02pZ0qzijGnqvW9itnlSZl7E9fym2FZW1NT2sepwzPdl+eIkER/sw4EEVQnxYoZjJcpFW0cVhkfnb4tf83sCUbFrmvzS/ihUrQZl5RSdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xPHutfyv; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=kUQIwcMNXEKH1QLWIbh2Ln8HwwNhBpHFvJDE5NUUPX8=;
	t=1732210843; x=1733420443; b=xPHutfyvtZ2rNTJkTlp9qgf04vwCZ2+LR9t3VWBfhAsULHu
	3bVxL/fMNUPX38HR6BOdbleU1OWm3Tm83z5ySvohUhhOilJ47pU1XhYpWBeepyldWbU+0WKwh+WKE
	utV2+EKx/yTFQ6deylTQXYdS4SIWCN6KNbG7kZb3nOVzADUyZeHPoQzSk+mB3zewOeVZhIwjR+uWx
	o/QsyMkRpD8yoFoUE0OJwoRefWZHA92D5HUX2vgCfu6Fu8EfXCmsvuIutyRYJa9oSTDAlT6mJgBk/
	/25Dsu8Gye2r85rBKeA3S6YvlVBeMEc0OKxA7Js97gToURPxe+VipaFUDv5R4PHA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tEBAV-0000000AkvO-2WRl;
	Thu, 21 Nov 2024 18:40:39 +0100
Message-ID: <6b60c17b9594b990ec883729d9893494a61f0689.camel@sipsolutions.net>
Subject: Re: [PATCH] drivers:wireless: Fix a dereference before null check
 issue
From: Johannes Berg <johannes@sipsolutions.net>
To: Paolo Perego <pperego@suse.de>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Miri
 Korenblit <miriam.rachel.korenblit@intel.com>, Kalle Valo
 <kvalo@kernel.org>, Shaul Triebitz <shaul.triebitz@intel.com>, Emmanuel
 Grumbach <emmanuel.grumbach@intel.com>,  Yedidya Benshimol
 <yedidya.ben.shimol@intel.com>, Benjamin Berg <benjamin.berg@intel.com>
Date: Thu, 21 Nov 2024 18:40:38 +0100
In-Reply-To: <q3pul7n2axag5xcxzzjjrhwlu3m3vh64bz4ln6dt7w757z47hk@byhyujhanky4>
References: <20241121170257.275607-1-pperego@suse.de>
	 <e37392a6a1fcb11db42646da2afe055416ca4cea.camel@sipsolutions.net>
	 <q3pul7n2axag5xcxzzjjrhwlu3m3vh64bz4ln6dt7w757z47hk@byhyujhanky4>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-11-21 at 18:35 +0100, Paolo Perego wrote:
> On Thu, Nov 21, 2024 at 06:28:14PM GMT, Johannes Berg wrote:
> > On Thu, 2024-11-21 at 18:02 +0100, Paolo Perego wrote:
> > > This patch fixes a dereference before null check issue discovered by=
=20
> > > Coverity (CID 1601547)
> > >=20
> >=20
> > This was reported before by smatch too, and Emmanuel just made a patch
> > to simply remove the NULL checks, because the pointers are statically
> > known to be not NULL. So it's not really an issue other than
> > style/checkers/... anyway :)
> Oops, I'm so sorry this was already fixed. In Coverity dashboard the
> item seemed to be still open.

Oh it wasn't fixed yet, the patch isn't anywhere near the trees. But
it's also not very important, so I doubt we'll handle it urgently.

> Apart from that, did I followed the right steps? Was my submission good
> enough? (I'm new to kernel hacking and I'm still in the learning phase)
>=20

Well, should've had the right subject prefix, as "wifi: iwlwifi:" but
other than that, I guess?

Arguably, you also shouldn't have had the =3D 0 in the code, since it got
unconditionally assigned anyway.

And, if you're going to continue looking at Coverity reports, I'd
suggest to dig a bit deeper. We're not here to fix reports from Coverity
after all, we should fix _bugs_, and tools will get things wrong :)

johannes

