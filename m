Return-Path: <linux-wireless+bounces-24939-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF05AFCA73
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 14:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C260424DA7
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 12:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E908CCA52;
	Tue,  8 Jul 2025 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tAY3kLx3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767452882A5
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 12:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751977867; cv=none; b=Kl85ubeBdOzy1vOQbnmC27VBJM/OUcSfWBujLaYndQCS03YaWK392QM6X5fKpVQ62l9KL/WW2z8XmloQfWd4LSaj6SK/ACTqYQDNunkyitkTCtmlMLsM5A9pbjTeKAxnyb+CLIwzV6OKm3niznFKsOn5rvHbzUqcYRct0vNl2CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751977867; c=relaxed/simple;
	bh=CajInpPMtzw+3y91LRZGsup9M9DdJxJO9EhP+BZp/50=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YJ10GRrEnEiHrJD1Ui+PryiLfgYpHwPvmFHskdktFRBM+snzVQvbMfMhPVg0kKEQ/bBdiymzeovRQDSW9heaHir+1O6SwPlFiw4wrizv5aaY+Bw/FlyAcfCaj7BQnkD3NC6ou41OgavlDuXyp90YvBE91662XdIIsCXLZSIX62U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tAY3kLx3; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bsg8/2oAKvKo3JJ9oXYBsaG6wInJWuF4e7/mAqdsMFc=;
	t=1751977866; x=1753187466; b=tAY3kLx3otBa0ODWK9uvOegkXQapw7VLgDbUYF9PoKVUYFt
	D522KFGC69EvELrWiwj888nHOdCQX9Ngsdv/W7IcK6M0sUiU3e1kvax37R6INIBAaU9U1luQi4Wqj
	Vc+YsUYfe3WLtjNob5p18M7Akm/4kOI8NGxK2ZfVe1kLKlCLVJJLereONaabk0YrJeJEHgh+AOT2A
	ONvmgJji+26XH0ge9jbf5pf10wQiu7q0ciy2DvjlvWZH/2zeMh/1vB0dDNXaKoxLy3jQKT2mX7cFE
	dAlBNFaTqjy3cnctJwm8thxvO6o9gIyVKt7VpxOP/bqazineZUFPrJOJ/2Ox10Jg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uZ7TT-0000000Bsg5-2Dzg;
	Tue, 08 Jul 2025 14:31:03 +0200
Message-ID: <54ede5f58c3abc7de58010e492283c7930a2495f.camel@sipsolutions.net>
Subject: Re: [PATCH v5 1/3] wifi: mac80211: Assign tx-stats to the proper
 link.
From: Johannes Berg <johannes@sipsolutions.net>
To: greearb@candelatech.com, linux-wireless@vger.kernel.org
Date: Tue, 08 Jul 2025 14:31:02 +0200
In-Reply-To: <20241218232519.3156080-1-greearb@candelatech.com>
References: <20241218232519.3156080-1-greearb@candelatech.com>
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

On Wed, 2024-12-18 at 15:25 -0800, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
>=20
> For drivers that can report the tx link-id, account tx
> stats against that link.  If we cannot determine tx link,
> then use deflink.

According to all the RX stats discussion [1] you need some changes here,
so I'd appreciate if you could take a look and rebase/resend.

[1] https://lore.kernel.org/linux-wireless/c22a9e7e-d0f7-477b-b732-c2454a0a=
c904@quicinc.com/


And please, as I very frequently keep asking you, don't mix different
things into a single patch (such as 'rep_packets'/'rep_bytes' in this
patch). By insisting on not splitting your patches properly before
submitting them you're effectively saying your time is more important
than mine, and I don't appreciate that. All that achieves is that I
don't even want to look at your patches.

johannes

