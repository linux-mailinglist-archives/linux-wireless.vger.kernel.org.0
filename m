Return-Path: <linux-wireless+bounces-792-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95981812FD0
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 13:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B3DA1F22452
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 12:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393E241767;
	Thu, 14 Dec 2023 12:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wLTKgOzC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058D5BD;
	Thu, 14 Dec 2023 04:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=i3BQLavQ7q8dzK5mqTZacIcgB0K8M4R6u9OZ0gzDytE=;
	t=1702555918; x=1703765518; b=wLTKgOzC9uf3RmlJWJd1QzQHFYtW3Pns8Hg2YKc95rxkmDs
	HptNPdO3Oak4XCWprU9c9VHFo0IjJUie+iTNGM8aAj0BaSuTwlJuuUHwhdmmbpofvvtPxJqk3eM08
	KxwU41+ZJS1i+ivjKulB3EknTtcWcQT8dy/x0g/0PBQBxvK8QDpwgaNCyWuQS/Nm80GwL48n9BAZ3
	EaXwCphp2jj6lO0QpCiREQ5IFI6n5OUsVxuCb+PRlGMZg12cMvmMvdmHn60P9ZuGz75YrMsd3eOYS
	pEXOQGaUNmX23MAFXojCk0aZpvXgJehfhK/x/0yQ+qdxttIJEJfr31d+RI0DdZhw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rDkZI-0000000AoWX-06kI;
	Thu, 14 Dec 2023 13:11:56 +0100
Message-ID: <d8667c83111b70144b40a3b7c457c7a2dd440e09.camel@sipsolutions.net>
Subject: Re: pull-request: wireless-2023-12-14
From: Johannes Berg <johannes@sipsolutions.net>
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Date: Thu, 14 Dec 2023 13:11:55 +0100
In-Reply-To: <ddb0d6217b333c3f025760b5b704342a989f2094.camel@redhat.com>
References: <20231214111515.60626-3-johannes@sipsolutions.net>
	 <ddb0d6217b333c3f025760b5b704342a989f2094.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2023-12-14 at 13:08 +0100, Paolo Abeni wrote:
> On Thu, 2023-12-14 at 12:13 +0100, Johannes Berg wrote:
> > So more stragglers than I'd like, perhaps, but here we are.
> > A bunch of these escaped Intel's vault late though, and we're
> > now rewriting our tooling so should get better at that...
> >=20
> > Please pull and let us know if there's any problem.
>=20
> whoops, this will not enter today's PR, as I'm finalizing it right now.

Yeah I kind of expected that.

> Unless you scream very hard, very soon, for good reasons, and I'll
> restart my work from scratch ;) (well not really all the PR work, but
> some ...)
>=20
> Please let me know!

There'll be another chance next week, hopefully?

Anyway, I don't see anything super critical and likely to affect
everyone badly. Even if it doesn't make it at all, that wouldn't be a
huge problem, we'd just have to do some creative merging on our end (or
reset the tree) :)

johannes

