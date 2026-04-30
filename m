Return-Path: <linux-wireless+bounces-35720-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCdzBo2E82kY4wEAu9opvQ
	(envelope-from <linux-wireless+bounces-35720-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 18:34:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AED644A5C4B
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 18:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B292B30684A6
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 16:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC13A472760;
	Thu, 30 Apr 2026 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZUOUL0f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560CF46AF3D;
	Thu, 30 Apr 2026 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566469; cv=none; b=oSfK5N1IjDLZP0hEecs4lA97evHsy+tN+S5CXKz83VUFfgMkAmACdQP1vWomMOEsaHCUek6FbePT8gkt+aFyoeuYdKS+MWz8V76N6nPrRNhHot7lx/dol8lo6aEkAW3lSG4qaitRrbrEC72p3y3a71UoafeZwnoOiTTFJqcR3u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566469; c=relaxed/simple;
	bh=4BGDOGjkt/PpqpBP0oNPJG+z/w2EjajmF59dDJ2uF48=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=keZDwDk9kelTniYmzcYU6sBE8m8Tqlb1rovuDoQorAFmEfKeaDxYPy+WYQBUl4cESEplmTFpSR0dvDE95FclTsEGdO/UxJfAOmNtRhVRytkr6G8eiwe8TwMA5Smv0/GAIWHtKbG4uRQHddoepR6p3kKZqJOPP0ttyhZN2oU1sbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZUOUL0f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D5AC2BCB3;
	Thu, 30 Apr 2026 16:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777566468;
	bh=4BGDOGjkt/PpqpBP0oNPJG+z/w2EjajmF59dDJ2uF48=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kZUOUL0fYOYaOFmFH2dbAK98tGDuTPu606dyzva5BW1oKmXDqTEe1kEUHxnbBUrJX
	 bWJHXxQRsG+OYHuJAliq0ZXE/K3gOoqw2O+PH0FLGWCGST6rYzCkYN7Qe3jrpsfB6k
	 2XMpYTGfsMQq37sxxSZT0riti3ovh+IG/BsAX4mwWlwjfZXMUrYa4WRwJ6QrvUJs3v
	 pNOqgk856oC3CRX1GQ+nCL0JI+ucY1v5XcOb6LlMdTam3s/sObS/yJfhiZmSNIz606
	 5vjgj8Uic9cQlyWZ3q0zDpXOZpwkVbqpk9di0Z2vBB3kkAFATQSXRP4mA6dfv8AUYa
	 X0bT5KqWm0ikg==
Date: Thu, 30 Apr 2026 09:27:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [GIT PULL] wireless-2026-04-30
Message-ID: <20260430092747.63a7754c@kernel.org>
In-Reply-To: <027691e6472079e06f816462a8049308a1bea908.camel@sipsolutions.net>
References: <20260430111831.219242-6-johannes@sipsolutions.net>
	<20260430071239.36b0e5f0@kernel.org>
	<027691e6472079e06f816462a8049308a1bea908.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AED644A5C4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35720-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Thu, 30 Apr 2026 17:51:15 +0200 Johannes Berg wrote:
> On Thu, 2026-04-30 at 07:12 -0700, Jakub Kicinski wrote:
> > On Thu, 30 Apr 2026 13:17:52 +0200 Johannes Berg wrote:  
> > > So the LLM floodgates are starting to open ;-) But I'm somewhat
> > > happy that so far we haven't gotten any really critical reports.
> > > Here's a couple of first fixes though.
> > > 
> > > Please pull and let us know if there's any problem.  
> > 
> > Looks like this breaks kunit:
> > 
> > ok 70 mac80211-tpe
> >     KTAP version 1
> >     # Subtest: mac80211-mlme-chan-mode
> >     # module: mac80211_tests
> >     1..1
> >         KTAP version 1
> >         # Subtest: test_determine_chan_mode
> >         ok 1 Normal case, EHT is working
> >         ok 2 Requiring EHT support is fine
> >         ok 3 Lowering the mode limits us
> > kunit: required basic rate or BSS membership selectors not supported or disabled, rejecting connection
> >         ok 4 Requesting a basic rate/selector that we do not support
> >         ok 5 As before, but userspace says it is taking care of it
> >     # test_determine_chan_mode: ASSERTION FAILED at net/mac80211/tests/chan-mode.c:258
> >     Expected conn.mode == params->expected_mode, but
> >         conn.mode == 5 (0x5)
> >         params->expected_mode == 1 (0x1)
> >         not ok 6 Masking out a supported rate in HT capabilities
> >   
> 
> D'oh. Yeah, that's the AP workaround, we'll need to adjust the test. I'm
> on my way out right now, so I guess that'll have to wait for next week.

SG, Paolo already submitted our PR so from Linus tree's perspective
later today or early next week doesn't matter..

