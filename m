Return-Path: <linux-wireless+bounces-27250-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EDFB53F50
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Sep 2025 01:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24141160DD6
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Sep 2025 23:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82FA26B769;
	Thu, 11 Sep 2025 23:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loreQqMe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F14426A0A7;
	Thu, 11 Sep 2025 23:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757634982; cv=none; b=uBvOLtEOv3jSd99pULG/CHuXZHk248uc/yq5Hper6SP6LTxXGtE5U9W1pUOFy1nSez4MFRW4NJ/IJJX9lwXM++CqWH55MWA+O4piFz8VKy5eA59zrQyetmFb/l4QUsQHfWpExxladD+UnKbmh1kfG5gQWTARpAXb55vSaPnPpi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757634982; c=relaxed/simple;
	bh=KvYjeYboHFWJWtv+WVJpkFkNTuVtS5MQR5jhgNcuTiY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MUEvoDTKQGnC6sGwtALxhtKvF8L/ZIIHAVDbv7R/gKNI5/oP7MLnvU6Dg/DTQd9iszaLDEbeUloUENWtTtM8QnepzpAnyu/Gh4BaZVgND8QME37kxAa+IWrN3mqetM3QPEkhBvLnBCFwZQ9sn+UCXNasWGzWM+NM9zQkGAk2nH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loreQqMe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA24EC4CEF0;
	Thu, 11 Sep 2025 23:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757634982;
	bh=KvYjeYboHFWJWtv+WVJpkFkNTuVtS5MQR5jhgNcuTiY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=loreQqMeR6bYdQMcAeEZgvvCWWgG7LReaKaHEWjjywup5hT1YW4AL9BP6BYalM/jE
	 Z/hG/h8V3skj9H5dSqJt2SSjFypvT7ra+kjxrHbmYdlVmbpRb4w4Z76PjFE+bCI6SX
	 a1rdIKqBVXCiXhocnwHDtIjB28b0rXrOnpSY1GlBOzIbG7L72HoHyJlv+g+j3JAW1c
	 NG2hlEBP5sF86NXuLxh6ToNCz3MUVJo7+hG6jL8PSMVa17KZ/4VDortn/XEKDJ9846
	 0Hhmbuyah/nD1UwG06yreKf91SmxKFylGvbsoT6E5Cz9rA2KnYC8SE5nEOLaWyGkXy
	 Ynj1KTC3B+wJw==
Date: Thu, 11 Sep 2025 16:56:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [GIT PULL] wireless-next-2025-09-11
Message-ID: <20250911165621.027ee3be@kernel.org>
In-Reply-To: <2da9103af3f341f05bc8c42e4425ec15231498e5.camel@sipsolutions.net>
References: <20250911100854.20445-3-johannes@sipsolutions.net>
	<2da9103af3f341f05bc8c42e4425ec15231498e5.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Sep 2025 19:01:39 +0200 Johannes Berg wrote:
> On Thu, 2025-09-11 at 12:08 +0200, Johannes Berg wrote:
> > Please pull and let us know if there's any problem. =20
>=20
> Speaking of problems ... we've kept adding Link: tags. If you're going
> to insist we remove them then please just say so explicitly, reject this
> pull request as well if you like, and save everyone the discussion.
>=20
> I do truly believe Linus to be wrong on this: assuming a patch has no
> need for any identification/correlation whatsoever before it goes into
> his (or a feeder) tree (and gets a stable sha1) is akin to assuming it
> has no life before it actually ends up there, which I think is
> completely out of touch with reality. But he does ultimately get to
> reject pull requests, so...

Let's see, IMHO links to patch.msgid.link are unambiguously purely to
the posting, not any discussion. I'm planning to try to hack something
up in our patchwork scripts to try to skip applying them when thread is
completely bare, but my next two weekends are quite busy. I'd say
steady as she goes for now..

> Maybe I should make the links go to patchwork, because there you have
> the CI results ... maybe that could be construed as useful information
> in the "Linus sense" (phrased that way because to me the mailing list
> posting is already useful information)?

Maybe. I find ML more useful, but do very occasionally want to look=20
at pw. As long as one has the message-id it's not hard to find the pw
entry. I'd recommend against changing the linking to pw. My guess is
that would only lead to increases hostility :)

My personal opinion is that pw-bot already knows the message-id to
commit hash mapping. I was asking K to expose this as some REST
endpoint so that we can trivially script the conversions. But he
suggested (not without sense) that patchwork should serve as our DB,
not 100 random disparate services. One day the netdev foundation will
clear all the organizational hurdles and the PW work will happen :D


unrelated - the wireless PR was already pulled, pw-bot did not respond
=F0=9F=A4=B7=EF=B8=8F

