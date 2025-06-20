Return-Path: <linux-wireless+bounces-24284-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7A7AE197F
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 13:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20313ABB4F
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 11:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86117283FCD;
	Fri, 20 Jun 2025 11:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qpTLyP6P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2FF24500E;
	Fri, 20 Jun 2025 11:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750417319; cv=none; b=SRMtBg461Zfz53tRvq0zTjUs+H5hX88ChWkM4fRcrY8t4biEvl60hMEgdTAIah37EA0CuP/imBjT7QAwYMP24+0xxJCjKmT1amgGfYXtlfi9NG07oSmrnXJ7S2wi1u5klf6f9oquGhTww+Yj4fVXMCmEN1pCWUe+xCBbveIKKwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750417319; c=relaxed/simple;
	bh=0+189Q01OWW44SjCAKrdmB3dlldQZT7EfBm4Z9bM//A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U0cw74GBye+lEr3gbDLcp3ucOVivSeIlpbV0nlxC8eEhjgwzIOdxOaKdfQvSYHMqySbodpBvPZ2U2E9EVx20O+UUxFHA//mzASx0Jc1/U7lQynJriR17EUst4ws8VztnfQq8vahpuXvmm6b4nD/7nHJRgoh0mEyhu9WOZeMc8Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qpTLyP6P; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=0+189Q01OWW44SjCAKrdmB3dlldQZT7EfBm4Z9bM//A=;
	t=1750417318; x=1751626918; b=qpTLyP6P+lSPqpRHG7OZG+7HmDl8D3S2sJIzfpzPhGo/WAh
	uoNjXUAXRUqK69zAt86Q+A2yfaTO/S5Rd5mlfE8DhRrLQsg1IjZK4uagstDBQGAp6nuzSs40lSUG/
	xj9GD1rFRz6HN+qx0M7TsfBlHxSOexaE7UDdlE+LTuSx8Eql6SSKbWFm6/7tXWWVy6wj1Rnf1frSa
	NdjkhfNkGTfpqQ0TbGRsl8IB1VI+aD9xuPGd6Lwd4dt86GKciaAGdhuK8hdtT45NHv/fTSE8stHFF
	wD3fCdRw782KA8L7ufJDLXmlYW45kZRKoibScdsLDcyWzZ2KpgILV9f+k//FrI8A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uSZVI-00000002fE2-0TFC;
	Fri, 20 Jun 2025 13:01:52 +0200
Message-ID: <c78aef54d57a83c874cd9092d6e50c3656540c02.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: Prevent comparison with invalid
 registered dev scan req
From: Johannes Berg <johannes@sipsolutions.net>
To: Lizhi Xu <lizhi.xu@windriver.com>, 
	syzbot+189dcafc06865d38178d@syzkaller.appspotmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Date: Fri, 20 Jun 2025 13:01:51 +0200
In-Reply-To: <20250619080526.899000-1-lizhi.xu@windriver.com> (sfid-20250619_100643_662853_B51B997A)
References: <684ba12f.a00a0220.279073.0009.GAE@google.com>
	 <20250619080526.899000-1-lizhi.xu@windriver.com>
	 (sfid-20250619_100643_662853_B51B997A)
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

On Thu, 2025-06-19 at 16:05 +0800, Lizhi Xu wrote:
> The scan req of a registered device may have been released, so it should
> be checked to be valid before comparing it with the current req.
>=20

I don't understand the subject/commit log at all. You're now accepting
scan_done() with a NULL scan request, why does that make sense?

johannes

