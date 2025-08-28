Return-Path: <linux-wireless+bounces-26806-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AB4B3A42B
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 17:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CF8998683E
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 15:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D970221F29;
	Thu, 28 Aug 2025 15:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3z2ylEc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC32221CC59;
	Thu, 28 Aug 2025 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756394468; cv=none; b=Gb9MpolAVWhoUbkbPpr7PPNj3D68HYqnklk7YvIeK9wd7gwgMeI0G4NiCMTVJiM1HMoz5Bah3gP0vBkjcgsEv0KKaXQOI4ZmKTV34III1R2OhkD8mqP++8U9optGB4/6KB+WXZzSu/NZuWYwFPgydfWyZMGRHPO8FwKzVZS6O1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756394468; c=relaxed/simple;
	bh=GvermbPA8VPz++F6PSH79NqAa+FwmRDX1g3LYIqZTzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JMNaVETXzxsvkz8UXVcbiQa4Pc6C355YTGhtS4CAoNcXfWv5KIsI5XUBMPtU58Uu8UknFdaWw3mJ21Wh0hzW3k773RH1N9wZE2fKqE9czZLkCrX5a5rPEUmlabo89TK/2rtYB1yihv7dp9khseuktCxF1FIQr+kKULxjQO7NE44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3z2ylEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974C3C4CEEB;
	Thu, 28 Aug 2025 15:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756394468;
	bh=GvermbPA8VPz++F6PSH79NqAa+FwmRDX1g3LYIqZTzQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F3z2ylEc++G8u/yAU2Rgn1c0x38LDCRRpvr0mAk9AaymEqF8Uxxv8dwHWUnCcsmHe
	 jzBLztRcZITMkLALUHdxko7F8i2byWvCTzqs9TPuw3HS62yJFePNYU+mC0TLmBO4dD
	 RUDQhYXzB8TLuH9CKPo0gM0/VK7D15FkGz2zuZnqK+ORwpBzqZZkVg0KJaDpScmRAN
	 ywZrNI8Q20wXitTNJTTs+Gq7H1KxirzBe7lG1KTT2nDv+wuiSX9vStL7izWY1TKrQd
	 HJ+/BAAKbSpcpiHwgk74nyHZQ+ieU/i9mU7EXcZtXi3OyLZPvWa/LEvg/Zt0pueJFh
	 9LNcy21XGQSsg==
Date: Thu, 28 Aug 2025 08:21:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [GIT PULL] wireless-2025-08-28
Message-ID: <20250828082107.20b47296@kernel.org>
In-Reply-To: <def5293e36f56b004f43192126fb5832c73f32cc.camel@sipsolutions.net>
References: <20250828122654.1167754-8-johannes@sipsolutions.net>
	<20250828075305.46c22eb5@kernel.org>
	<def5293e36f56b004f43192126fb5832c73f32cc.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 28 Aug 2025 16:54:09 +0200 Johannes Berg wrote:
> On Thu, 2025-08-28 at 07:53 -0700, Jakub Kicinski wrote:
> > On Thu, 28 Aug 2025 14:25:58 +0200 Johannes Berg wrote: =20
> > > Back from vacation, and a bunch of things accumulated
> > > for everyone. Nothing really stands out much though,
> > > except perhaps the various iwlwifi regressions for old
> > > devices, which were all my fault... =20
> >=20
> > This missed today's PR.=C2=A0 =20
>=20
> Yeah, I figured that would happen, I was late, but also got things late.
>=20
> > Would you like me to pull before
> > merging back to net-next? Or no preference? =20
>=20
> No preference. Probably more regular to pull back first?

Right, if no preference on your side we'll cross merge Linus's merge
commit and then pull from you.

