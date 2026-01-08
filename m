Return-Path: <linux-wireless+bounces-30543-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A36D03FC7
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 16:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9707735D47F5
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 15:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2934C0960;
	Thu,  8 Jan 2026 12:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="U2/6IF2h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346EA4BE878;
	Thu,  8 Jan 2026 12:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767873739; cv=none; b=s4EviLFaBF0eE6NFb2P0YZKvBdffrTZ8fAZEJxp1L7e7ozjgU3Geu6FMzrB0e9Akv9Ac8klHYnd9G8FIHXkcZtDbaPHZDVUaoMOC/cqUidxYHWG48QPXYydHW1HL0hnb+JbPY7shvH+f+9hYz/7geljfwPAJ3vSHevAlMUOFHnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767873739; c=relaxed/simple;
	bh=v2HbcXQ6rbhyXPZBsbK6d0NNTgOwkYIXcGoFBEanUyo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uIxkZVQFM2QAf7vqp2RcqpWwFFEc0kMjW1c9fWhJUGKXRW/YqK7+VWSEkHAvCSjYBFrlXEi4jOB1XQjJXq/XIR+Lada7EEHXu3EH578bFS4Vtgn0G0Vw8R7z7tDQX8AjNX27QqWfD4/HreOcsYsv56HHJpJ5s1MRdnP5EFmOyNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=U2/6IF2h; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QfaX9HLMJRaRW/NgwHv9ZDjDlW/4VzyABrzfVgdf7r4=;
	t=1767873737; x=1769083337; b=U2/6IF2hiDCEE+acaMLFMPcjnqmTY6ZMeZKR0N5AqPqVCZT
	1g61pLqkrQ4MwR2BmxF44hU7ffHyOnlr3I3TiYKxs73v9AHLwFK22wI3dglt28MIyKRg4lrM12q2u
	kd1ebQZolHiLv0z7qmuVytEE4c7kDwxYXih118H6fH7iW5WOKwk9esb73tCJy0E7S8znJJgc1Szzp
	6Xb29WfC79Z0yG1NMDAdIUKMnsxCzU021pNCjKuLUsZPPxk2KM+KImB8DgSA+zWhG6kAUyBI2DOuz
	ZSEoKAXcc858/5P+61pW1rfhLzRuEUrLgPmsaYLIq5JOzlpQvmmKNSL1qjjnFD2Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdoiU-00000006U3L-14zW;
	Thu, 08 Jan 2026 13:02:14 +0100
Message-ID: <d1806eda47fcb78344ed952e2a91b9c178650689.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: iwlegacy: 3945-rs: fix possible null-pointer
 dereferences in il3945_rs_get_rate()
From: Johannes Berg <johannes@sipsolutions.net>
To: Stanislaw Gruszka <stf_xl@wp.pl>, Tuo Li <islituo@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 08 Jan 2026 13:02:13 +0100
In-Reply-To: <20260107085949.GA35258@wp.pl> (sfid-20260107_100022_894196_B0F8671D)
References: <20260107084149.173289-1-islituo@gmail.com>
	 <20260107085949.GA35258@wp.pl> (sfid-20260107_100022_894196_B0F8671D)
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

On Wed, 2026-01-07 at 09:59 +0100, Stanislaw Gruszka wrote:
> On Wed, Jan 07, 2026 at 04:41:49PM +0800, Tuo Li wrote:
> > In this function, il_sta is assigned to rs_sta, and rs_sta is dereferen=
ced
> > at several points. If il_sta is NULL, this can lead to null-pointer
> > dereferences. To fix this issue, add an early check for il_sta and retu=
rn
> > if it is NULL, consistent with the handling in il3945_rs_tx_status().
> >=20
> > Besides, if the STA il data is uninitialized, return early instead of
> > setting il_sta to NULL, consistent with the handling in
> > il3945_rs_tx_status().
> >=20
> > Signed-off-by: Tuo Li <islituo@gmail.com>
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

I can apply this if you want, but for the record,

> > +++ b/drivers/net/wireless/intel/iwlegacy/3945-rs.c
> > @@ -626,10 +626,15 @@ il3945_rs_get_rate(void *il_r, struct ieee80211_s=
ta *sta, void *il_sta,
> > =20
> >  	D_RATE("enter\n");
> > =20
> > +	if (!il_sta) {
> > +		D_RATE("leave: No STA il data to update!\n");
> > +		return;
> > +	}
> > +

I don't see how this would be possible. _Maybe_ the other one, but I
can't figure out any scenario in mac80211 where it could happen either.

johannes

