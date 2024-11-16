Return-Path: <linux-wireless+bounces-15402-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 511B79CFD5F
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2024 09:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9F681F23311
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2024 08:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D35192598;
	Sat, 16 Nov 2024 08:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="AGyqB26n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC5617BB38
	for <linux-wireless@vger.kernel.org>; Sat, 16 Nov 2024 08:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731746331; cv=none; b=J1pmA1MJ+hF1S8ON9MH3b8t7OQu8XFYewZIqN9b12JF2F+b/L7zxTu8Rl9PzjrJIu3E9gK50T/hLLVA61BGp5h6kpwlGLyXdmUXp2hfObabywlJuywomB+0ssUSxWK0ethMfxzwQoZJ18NwzU3Q0MtvZnQciMPoCdTsy74STSHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731746331; c=relaxed/simple;
	bh=nbC9+cPkzKXQXPvFBZFEQLPR92kVzrNQW3gd9HegkaU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SCpse9wIgFsDGag7SL/il9RFeQaRjWelD7SuO5s8yvS1jw69uiHHyaiNEDp1qQhi+sTmZoxevuZOjUWJMFjH8D8TNnIFXd/G3k0CtgZi7nwK7XCHCJHrqUYLs5rNLzTzy1ks76nyPt0EGyWsFAVksA3Mi3bJHbraQVnOVFHR8NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=AGyqB26n; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nbC9+cPkzKXQXPvFBZFEQLPR92kVzrNQW3gd9HegkaU=;
	t=1731746330; x=1732955930; b=AGyqB26n0+8icWs8VLibbMG48NmeVIxM76miKG4K4zBUhr3
	BioyTCG/KvdXgyyyDri0xIEJdWArGNyPSc039kqbY8tPXuu4pXS2B4kRjZ2FH8Lkl/4xR3z/czVMt
	yFgPchn6+rmBMjXB7KmQEr7XtLg+Lr8HrNm0ZzLEfKx6/L9dPm26+7BV7trGJnEI5PnVVY6+NAvK+
	gYiCyv3BRLAbFNag98aisXmiyR5B/8U9LYMr0szeBYdg5jqAa1xFLnhy37aXS5KNFYo9i5t/FnvYA
	Ucwvk00w2sPeosVGD9rBEWmkS9anQzy6p5AaUlUDQKxlUMNlFmPdU4azbyzkGb3w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tCEKN-00000006Jt2-11z7;
	Sat, 16 Nov 2024 09:38:47 +0100
Message-ID: <d783a6d6a429feec6763077126e76445b6f186e2.camel@sipsolutions.net>
Subject: Re: [PATCH] wireless-regdb: assert and correct maximum bandwidth
 within frequency difference
From: Johannes Berg <johannes@sipsolutions.net>
To: Ping-Ke Shih <pkshih@gmail.com>, wens@kernel.org
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org, 
	combuster@gmail.com
Date: Sat, 16 Nov 2024 09:38:46 +0100
In-Reply-To: <ca8e16a2dbc9c38e5bf2f3e426a2132393b381be.camel@sipsolutions.net>
References: <20241116082417.8720-1-pkshih@gmail.com>
	 <ca8e16a2dbc9c38e5bf2f3e426a2132393b381be.camel@sipsolutions.net>
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

On Sat, 2024-11-16 at 09:33 +0100, Johannes Berg wrote:
> On Sat, 2024-11-16 at 16:24 +0800, Ping-Ke Shih wrote:
> > From: Ping-Ke Shih <pkshih@realtek.com>
> >=20
> > Since kernel will reject max bandwidth being larger than freq_diff in
> > is_valid_reg_rule(), as well reject it ahead.
>=20
> Not sure that's generally true, if you have AUTO-BW I think it should be
> OK?
>=20

Sorry, no, I guess AUTO-BW just lets it expand the bandwidth beyond the
listed, if there are adjacent ranges. Been ages since I looked at this.

Anyway this probably doesn't fix the user's problem, it just makes it
rejected when compiling already ;-)

johannes

