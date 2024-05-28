Return-Path: <linux-wireless+bounces-8172-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C12E8D16B0
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 10:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCA7C1C21924
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 08:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628FA38DE9;
	Tue, 28 May 2024 08:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="i3Fl4No+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DC417E8FC;
	Tue, 28 May 2024 08:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716886488; cv=none; b=pSve9E49JxU4kdnSdczwaMlv+aXhEUu2rNfbR/JMdwm9tGBRs6P38SKPB2r+0GBLD2vLj3EP+mh2eEQHXr1dWhHj0AViv+5qG14stap8FnztWJgTV0SjRx8C4eQB6s0y8U4+gAa4xcdP0pmr0gKT3hJDKpZc7BPFrkJIbuy+4Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716886488; c=relaxed/simple;
	bh=Gs3QmqQSbpTfzpf1lSqoPGDED7Dke7tMMi0saWmEoDw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iaDaG8r0fHPz08cEDtLMpVRCgbnr+CrH0ojzaJNVQJ7MRuoV6aip3/XEkcvLhGVeY3Q0JKgdTq02uf4Ti7BuXQpWH5TwefiAIKEJmHEcnbnRkO+XS64yrDHQ2QChbJpzfjz1oVgXC6hy/rBDpqvJ2BrOqXaK39N0ck2VDrSoCXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=i3Fl4No+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Gs3QmqQSbpTfzpf1lSqoPGDED7Dke7tMMi0saWmEoDw=;
	t=1716886476; x=1718096076; b=i3Fl4No+ocSEBeuzCNoOSO3ePUusUq9YYuI0tv1WedB57rG
	CCQRheiLaOaJTnPpXLRE+L+Yaemuv0tSoMuAl/OCCzSrw3lKNEnclO38X+kYfeH/4ZmzD70DkXh6U
	7pFynZPNUEztIzisDpQ8CDGCRlrODteNNrAOUX/If336YhpDWCf+pWbrYS3gbwaPT1gfKGzVVfAkh
	11YRAfNpzftnl8GodKERcTTDLdrANITO3sYaGO8tnbuQoQXTPZ/zgH6UUiO/sySJWQckSEOzud2Q1
	hzOvnApnuDzBBAHk8+IY7YsAv2vooHVSbtyxoVIauZ81DWgTcovQ8xmGqNtFwD2g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sBsbH-0000000EAm5-3vLV;
	Tue, 28 May 2024 10:54:32 +0200
Message-ID: <d5ac0440ff009f6975728a87384bb3f4b92ee548.camel@sipsolutions.net>
Subject: Re: [PATCH wireless] wifi: wlcore: fix wlcore AP mode
From: Johannes Berg <johannes@sipsolutions.net>
To: Russell King <rmk+kernel@armlinux.org.uk>, Kalle Valo <kvalo@kernel.org>
Cc: Michael Nemanov <michael.nemanov@ti.com>, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org
Date: Tue, 28 May 2024 10:54:31 +0200
In-Reply-To: <E1sBsK3-00E8Uo-Ab@rmk-PC.armlinux.org.uk>
References: <E1sBsK3-00E8Uo-Ab@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-05-28 at 09:36 +0100, Russell King wrote:
> From: Johannes Berg <johannes.berg@intel.com>

Honestly, while I did write a good chunk of the patch itself, all the
commit log, actually making it compile/work etc. was all you, so I'd
suggest to reverse our roles here in the authorship/credits.

johannes


