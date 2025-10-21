Return-Path: <linux-wireless+bounces-28136-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9DCBF665E
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 14:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7172F19A343D
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 12:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056612F260B;
	Tue, 21 Oct 2025 12:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BhTTh52d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44876355026
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 12:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049181; cv=none; b=CQngtykC2qe37BGo3GBRDw4Cp3qb5q0ZIvyNynq5W/CSbJkNvsR/xsQMU3nCiq1KkxPPzN5k3YZbF0qy3gwIl/LDBd4ic7rF0IimAcHWLDSHGp6GDmumw9M+WKcB5/cDFlLrJHziMVkNBdLwxsEWq1M1DEiDRLTzRQaz+wiYgzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049181; c=relaxed/simple;
	bh=zegNX1vwhNkSlYiepw6FtEoWLHDDEOZmjTaMhlj6cYQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WK628WwlSP1PAWlen8LAAU1q4Ppehb73MpnArokhTLRYOoKCcLw7j8aK/7SkUgL8uTRT/Zihxq2lgoDfAxm0Xp5tjXN43sRuiUss9M4JjpxP/p1hWSnmz+SCeHXRgOV8BBnQIZWOZS8UqBObNg9DYawOpsbRcZitabxezFltG3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BhTTh52d; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zegNX1vwhNkSlYiepw6FtEoWLHDDEOZmjTaMhlj6cYQ=;
	t=1761049180; x=1762258780; b=BhTTh52djqh2rne9oTS2Wxy/csWqUM5+Iir17UMl93XLfr6
	34vealutQxBsggFVxu1wp0eniVf4vskK74ljwq1R8pvTBgVR6BBqweZgR0pEBnXDVKIJh6kfM1VBg
	+3kbAEgKsyMlIpvP34hwRJe4PzzDL8EGFWMTp8zphUBCyXzwmRxheLS7gXlw8EKyQr+/Hf0dX4Y9Y
	5k+fJHnw0uyBz+a3VXck0jBY6jqIvWiaxoevaCifD9vy4o7Ph8NV0v3CktEevOsVyr/UqmIZPmgu+
	nPYHIurK7kq0a6CPwiqKbWjbdKQFN8HNbfG/vJBBuAclXc7DMUpdOuar/5pX+z5w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vBBKz-0000000BkCz-16ha;
	Tue, 21 Oct 2025 14:19:37 +0200
Message-ID: <8350f937fcab78249f840bf835f744c0b953124e.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2] wifi: mac80211: Try to overcome bad HE
 operation in association response
From: Johannes Berg <johannes@sipsolutions.net>
To: Mathieu Chouquet-Stringer <me@mathieu.digital>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
	linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>
Date: Tue, 21 Oct 2025 14:19:36 +0200
In-Reply-To: <aPd48eufR6OY45__@nosurprises>
References: 
	<20251019115152.e1cf791232a6.I69591428f2b9bde9df3c78c333e9b4fc264da0d9@changeid>
	 <6b0634994bc8428f8ebcf4032ff98604660c52fa.camel@sipsolutions.net>
	 <aPd48eufR6OY45__@nosurprises>
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

On Tue, 2025-10-21 at 14:13 +0200, Mathieu Chouquet-Stringer wrote:
> On Mon, Oct 20, 2025 at 04:08:37PM +0200, Johannes Berg wrote:
> > On Sun, 2025-10-19 at 11:52 +0300, Miri Korenblit wrote:
> > > From: Ilan Peer <ilan.peer@intel.com>
> > >=20
> > > Some APs, e.g., some versions of Aruba APs,
> >=20
> > My understanding is that both Ruckus and Aruba have fixed these issues
> > now (not sure how that'll roll out though), so I think we should
> > probably not make this change at this point, unless we know that will b=
e
> > a significant number of APs that cannot get updated?
>=20
> Well, do you have any idea when Aruba could have fixed that? I have an
> AP-635 with firmware "8.13.1.0_93688 LSR" which is the latest for the
> AOS 8 branch (released in September 2025) and it's clearly not fixed:

Recently, the test result was about a week ago, but I don't know when
the people testing it got it from Aruba. I'd imagine they would've
gotten a pre-release version to test with, but I don't know them, or the
Aruba folks involved, so it's mostly conjecture ...

johannes

