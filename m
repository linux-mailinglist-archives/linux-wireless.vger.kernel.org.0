Return-Path: <linux-wireless+bounces-26995-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A79F8B4364B
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 10:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635CC3A4A9C
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 08:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4D924167F;
	Thu,  4 Sep 2025 08:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VzXTlZnG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAE12264B1
	for <linux-wireless@vger.kernel.org>; Thu,  4 Sep 2025 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975946; cv=none; b=HiRoVMDY0N+vqj6nmYVreJBVgbCkHLItpG98BKVtNFGYvMWK+Fo5VQtd36iIMKO3MwRbRJdfYhOSytphJk8sIDaO+ELcVIo+xtmsfTR5p8CO6EPOguoLvwhxl4s9ZK1NPIy8lR/VoyKcYweD8u8Jjy6B48q0Ag1C9u9NzHKVIkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975946; c=relaxed/simple;
	bh=8BkLV9X1wIlosMoB5KA6pRId7ZihXMPPKv1kiuLhqlI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aFyiCXgdfm26Pyx2ibBEdjoMVMfTYzfAM1lbGh39YTzUfPII7zRuk0nGcKJYN7uF2TqYwBw8udVP9Dn+BKyLPrmzmAe2hYQwj1BtoRMwegs4CR50hmUiv2oRKLvRYcr7ZalAd+dyRFN62KSjfo9Q7p9tU3OqRVIMZoTkPgpxmPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VzXTlZnG; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8BkLV9X1wIlosMoB5KA6pRId7ZihXMPPKv1kiuLhqlI=;
	t=1756975944; x=1758185544; b=VzXTlZnGsI9vanJiL4WkPoO1ngkbvafCEVqot21pYxlW1Fl
	znMjJOqHlcYZmjP9bfLH9HfI2Df/9VFIPRJlt63Sle0H8cWormaYx80+lalH/1Re7KbyFv8wGlcqw
	s6hkOu4aaONPGSAgueMJSI1MJTSLwU5L5wYdgNDkv4mxXwiy6YzuGdyY76QEhEXmDFHh6moSfSlaj
	dhvSzVsXYwdERRg+XP9XwOX9F8Kckj9y1+g7eqknqpCEZuy4nX7xi4oOJwoRIo7Fa/yHb2h+pF1Wr
	SvXRxvVhOHTXhPjnrdVb9k/kQJacidkERXb8vj/0qd0w+f5e2oDwI2O1A4/yarwA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uu5he-0000000DrvW-0zp9;
	Thu, 04 Sep 2025 10:52:22 +0200
Message-ID: <78645f03a5b61371ee9f95544695ffe86bd1ed8e.camel@sipsolutions.net>
Subject: Re: [wireless-next v2 3/3] wifi: mac80211: kunit: add kunit tests
 for S1G PVB decoding
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Thu, 04 Sep 2025 10:52:21 +0200
In-Reply-To: <e4j5rbffwxgrqafkwyuezl2q3z4mgdn5lxrkxjxaphmn66movm@d743xb4xbdrc> (sfid-20250801_071111_882172_4E0E8E2B)
References: <20250725132221.258217-1-lachlan.hodges@morsemicro.com>
	 <20250725132221.258217-4-lachlan.hodges@morsemicro.com>
	 <65411d6ba7516e01920ccf39627269fc2f71dd56.camel@sipsolutions.net>
	 <e4j5rbffwxgrqafkwyuezl2q3z4mgdn5lxrkxjxaphmn66movm@d743xb4xbdrc>
	 (sfid-20250801_071111_882172_4E0E8E2B)
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

On Fri, 2025-08-01 at 15:11 +1000, Lachlan Hodges wrote:
> > Anyway, it's the middle of the merge windows, so I guess it'll be a
> > while before I apply things.

I'm finally getting to merging things to wireless-next, so it ended up
being quite a while indeed.

> That's fine - I can submit a v3 once the merge window closes with these
> minor fixups, no rush from our end. Plus its always good getting the
> dopamine hit from seeing all green :)

Did you want to do that? As I said, I can also just fix it up, but maybe
you also had other changes in mind.

johannes

