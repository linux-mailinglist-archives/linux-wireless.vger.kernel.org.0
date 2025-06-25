Return-Path: <linux-wireless+bounces-24494-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E59AE8BAB
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 19:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 599717A4CBF
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 17:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3F22D23B8;
	Wed, 25 Jun 2025 17:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VDeuJvNG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AAE275B04;
	Wed, 25 Jun 2025 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750873235; cv=none; b=nR81xJVGdqE3cSJHBdoyeHgHsryMfCNFevOePBMGVSA+bQOhRlrX31ZdkEshXBfMEyNTST/KDihehyGHUfLzK6L4O7ngh2dx/Me7w3nnfqICXxZYjHMvTLPLheA6H7yHZ0wrptFlFXgcYuN8lz4HatdqRjq0Kdy8rygXg6SBKeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750873235; c=relaxed/simple;
	bh=jFssEt/zNPrEVHQ8PKVUmeTnC3bJbCa3JbUds7aumgs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MhWXhKyv5N1UUAYZEfbJAWqqlEAz7IqFC3x4AENyqJX12cU/ir8hOnlnyRJzTXe2LiyRbydYTz2hiq0Epm+Qy4IypKPGCG8rQzGMUMEyul7M3tkfIEPFq1Q7XivyxHvE0/UBdijHRP1+iAjGtFn5xSLLgjHhs6Ph/sn0LgkzORY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VDeuJvNG; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=jFssEt/zNPrEVHQ8PKVUmeTnC3bJbCa3JbUds7aumgs=;
	t=1750873233; x=1752082833; b=VDeuJvNGlPOab8vMEI3jT+gkzMjfKNeFjOUlE2BlGNMUy2w
	D+G6i+t1VlOOZZvAlrbqK4qRqCRRj7p0Zp3KdUZ41q7C8OCmpbifAc8NC36VVHtEZzsU99wUtpVwQ
	YAdpwivMzb41UKIaCCJGctK+SuX319Y7cLbQAvjUqgGV+a+5Io+UN4FRtnakBMGuei/HnboEYuXyK
	/L0Ao1tmzFFRHcC8+VxPesFh8eXdHsQ1zO8d/jJyHkXFFutM6oDNNmKOT9zSe4dgDMLBK6S639dRy
	qECi8rhesfgNiSuVv6frMFoeOt17x+FSiCQSwiYWCwMKqquGvuJOmnDkfbQ8+d5Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uUU6p-0000000A9e8-1Fmj;
	Wed, 25 Jun 2025 19:40:31 +0200
Message-ID: <32bc4c358dcf9f7ae2ccc30b38d9aee61014a92a.camel@sipsolutions.net>
Subject: Re: [GIT PULL] wireless-next-2025-06-25
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org, "Korenblit,
 Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Date: Wed, 25 Jun 2025 19:40:30 +0200
In-Reply-To: <20250625102555.35d3509a@kernel.org>
References: <20250625120135.41933-55-johannes@sipsolutions.net>
	 <20250625102555.35d3509a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2025-06-25 at 10:25 -0700, Jakub Kicinski wrote:
> On Wed, 25 Jun 2025 14:00:22 +0200 Johannes Berg wrote:
> > And for -next quite a bit more, but not all that much
> > that really stands out either. iwlwifi picked up a bunch
> > of really old cleanups from patchwork "spring" cleaning,
> > and the rest just move along with regularly scheduled
> > feature additions. No known merge conflicts here either.
> >=20
> > Please pull and let us know if there's any problem.
>=20
> Hm, cocci points out a real bug here I think:
>=20
> drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c:550:2-8: prec=
eding lock on line 496
>=20
> Not major enough to delay pulling tho..

Hmm, sorry about that, I _know_ I fixed this after the kernel robot
and/or Dan reported it, but looks like Miri didn't put it in yet.

It actually exists in wireless/net too though, just the file moved now
in -next so maybe that's why it was reported (again). We'll have to fix
it in wireless and the merge should sort out the file move.

johannes

