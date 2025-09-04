Return-Path: <linux-wireless+bounces-26998-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89934B4368A
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 11:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E46497B8FA0
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 09:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682EC23506F;
	Thu,  4 Sep 2025 09:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ogdsW1od"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB092C9D
	for <linux-wireless@vger.kernel.org>; Thu,  4 Sep 2025 09:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756976571; cv=none; b=Gqx6Mn0/cNnXc7ay5Ubxu54XD8QsWAhtN+BexoWTtY3A/5IZ5RWIm/S0qEbA4iSZfi5OI3cmxudQCdnxvv1RDXcvFWPTX72yZeGLAO1UUf0krC/ZVjc9RYHoT2gQCQiY6uBGoRowPJHA/Qarx/G5r5DFqciNNc2BwiiagJuzDF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756976571; c=relaxed/simple;
	bh=aXnXIoJCf+lGnkSVH/LrwO+X+ZUtX31tY9jjhqNTvAY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=etbVOO9a8IqWmy4XmrmSEbcJKCo2CzM7u52fMQp1lzUFjYlZZpSCrT6BiJF3yAT/ZRLuDqkLmp1K1VOdJxSAYWEoSFwIHmX5V9tVdQvsABjMwgYlWLbT8PyDx23OUHYW/Y8pGrJO0cicknJEet2WVDSBeXtrlbWNkcIbHPt5K74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ogdsW1od; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=aXnXIoJCf+lGnkSVH/LrwO+X+ZUtX31tY9jjhqNTvAY=;
	t=1756976569; x=1758186169; b=ogdsW1od95hXzkky6PFyBk82yRpKBTWofsBTsfgipm+NpkU
	gFpavATBdiseZDVUhnkMFYZMhsq1VqkFWu9mFSPsyc+9WcWWR6qLrEG2pYcCC0GR7cKeMO43TFc5Z
	EhZC87j+wYrpaIePOWv7Cat34XGoV+nFyafIwW9xH99dUQMDMgEIzmv2WuMys1vuzd2toWsspZ8sb
	lpUHqvwqoZuEj1MPnbO6ojV35FsQgFq08sI5wZ69QhpahYsErUf9Xe9B41tgLDhUFzvq8xPhEGosq
	WiMSCk8JLFqWUURnSgl3WFnOn06V1ZNX63iSmeAQieW2mr1QhWSFsb+BEn9umG4g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uu5rj-0000000Dstw-1HPf;
	Thu, 04 Sep 2025 11:02:47 +0200
Message-ID: <298c43de5b668ea9b9996e3ec0547007f6e65174.camel@sipsolutions.net>
Subject: Re: [wireless-next v2 3/3] wifi: mac80211: kunit: add kunit tests
 for S1G PVB decoding
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Thu, 04 Sep 2025 11:02:46 +0200
In-Reply-To: <7zj6xu6apxs2b73iwsck3p5qappcpt3hn7vrdecvfh3to5ixzw@3uzofpejtuvu> (sfid-20250904_105950_540518_2DD6654D)
References: <20250725132221.258217-1-lachlan.hodges@morsemicro.com>
	 <20250725132221.258217-4-lachlan.hodges@morsemicro.com>
	 <65411d6ba7516e01920ccf39627269fc2f71dd56.camel@sipsolutions.net>
	 <e4j5rbffwxgrqafkwyuezl2q3z4mgdn5lxrkxjxaphmn66movm@d743xb4xbdrc>
	 <78645f03a5b61371ee9f95544695ffe86bd1ed8e.camel@sipsolutions.net>
	 <7zj6xu6apxs2b73iwsck3p5qappcpt3hn7vrdecvfh3to5ixzw@3uzofpejtuvu>
	 (sfid-20250904_105950_540518_2DD6654D)
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

On Thu, 2025-09-04 at 18:59 +1000, Lachlan Hodges wrote:
> >=20
> > Did you want to do that? As I said, I can also just fix it up, but mayb=
e
> > you also had other changes in mind.
>=20
> I reviewed it last week and was happy, so if you want to make the fix whe=
n
> you apply I am fine with that (and saves me a bit of time aswell :)).

Will do!

johannes

