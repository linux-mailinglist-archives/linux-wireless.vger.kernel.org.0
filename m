Return-Path: <linux-wireless+bounces-30577-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 75424D046A8
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 17:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF4F530028A3
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 16:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5387C28688C;
	Thu,  8 Jan 2026 16:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="K0Xb0eML"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C50223DE7
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 16:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767890048; cv=none; b=Ong6Wh03/XZRA9408Fm4Ow9UegC52bpKBitu9ytl/6MKWnLL2SPjXXE1Lwju05P1ZkoE/B05Mg1fyB3ApNcHzKcJT1Q0xNyKO3dqafALyIzdEmMw/HXtIzXB7NwzcqLFs0r74TagDkuqtDKj2vA3thGl2gI2bUHMKk8qH7zyRB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767890048; c=relaxed/simple;
	bh=NY43K6r26IxmJche7yAEuhbgg5Kor2/Ijz+AE5eNi+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WiffgW3VR/eCnvE4yEloFMcf0L3UnDT/oFzSwZDGYZ+nH06EKbvFJUOMg2DzDuEEtrsrfCPgYsSd8qnG6Rg95ODJWlj932I5ExkrrT6RwrBoEbgCrQVipodFBY1Jw5GOEnjrEck9BLXuWr4E6CONlR91PncIvJQd59pOiqYzH8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=K0Xb0eML; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 48556 invoked from network); 8 Jan 2026 17:33:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1767890036; bh=PRNlBtqphsp7W52ToQ9Yd4ZMyw74Vee7QKCjfuW4FWc=;
          h=From:To:Cc:Subject;
          b=K0Xb0eMLEn+F3Z1Py5a4z4tJg+AJmgIB3JDjJJORTH0V2PrtIkhQS8/nxjAqNCLIA
           nA6yKz0FMM/PotCZfZq2sSI8slxl07+ggwRqLIDWYLzrhs4gSGrYZaR2/Nu+iTLkfv
           b+Y4Rsu3N5aXeRpbzFbhOi36qvdOSzCVn8HjNuXKu8qMjYpRJodHQtNeK6Wi6+63dh
           harcAecBB3Hmo+vTc7PQn6VfzL9GSCrAPFceFdAPHaR4bwRzFJEfXgLU4rCg0DxISQ
           TaYWzkyIlMGeirggiH7QpUGA7XQRRmoZpWiDVZPFO2nah00oDwE4sklcxZmuZvYSb3
           j44eV/XcgqFOg==
Received: from 89-64-9-177.dynamic.play.pl (HELO localhost) (stf_xl@wp.pl@[89.64.9.177])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <islituo@gmail.com>; 8 Jan 2026 17:33:56 +0100
Date: Thu, 8 Jan 2026 17:33:55 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Tuo Li <islituo@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] wifi: iwlegacy: 3945-rs: fix possible null-pointer
 dereferences in il3945_rs_get_rate()
Message-ID: <20260108163355.GA38716@wp.pl>
References: <20260107084149.173289-1-islituo@gmail.com>
 <20260107085949.GA35258@wp.pl>
 <d1806eda47fcb78344ed952e2a91b9c178650689.camel@sipsolutions.net>
 <CADm8Te=TRTgCaRm0Ebgos8n0qZ+7HJ7Q80Ck+-d8NtCMdAb1Zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADm8Te=TRTgCaRm0Ebgos8n0qZ+7HJ7Q80Ck+-d8NtCMdAb1Zw@mail.gmail.com>
X-WP-MailID: f4a8567606497a7b08392eccaa9d0612
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [wZLl]                               

On Thu, Jan 08, 2026 at 09:28:30PM +0800, Tuo Li wrote:
> On Thu, Jan 8, 2026 at 8:02 PM Johannes Berg <johannes@sipsolutions.net> wrote:
> > I can apply this if you want, but for the record,
> >
> > > > +++ b/drivers/net/wireless/intel/iwlegacy/3945-rs.c
> > > > @@ -626,10 +626,15 @@ il3945_rs_get_rate(void *il_r, struct ieee80211_sta *sta, void *il_sta,
> > > >
> > > >     D_RATE("enter\n");
> > > >
> > > > +   if (!il_sta) {
> > > > +           D_RATE("leave: No STA il data to update!\n");
> > > > +           return;
> > > > +   }
> > > > +
> >
> > I don't see how this would be possible. _Maybe_ the other one, but I
> > can't figure out any scenario in mac80211 where it could happen either.

Regarding checking the rs_sta->il, we can get rid of the ->il
backpointer, it's only used for printing debug messages in a few 
functions. I don't think person needing to debug 3945 rate scaling
algorithm exist nowadays :-)

I'll send patch for that.

> I don't have a concrete mac80211 execution path that would result in
> il_sta being NULL here either. This issue was reported by a static
> analysis tool, and after reviewing the code I noticed that the handling is
> not consistent with il3945_rs_tx_status(), which is why I submitted this
> patch to add a defensive check.

IMO is ok to have defensive checks (in reasonable amount :-)

They can be marked with WARN_ON_ONCE like this:

   if (WARN_ON_ONCE(!il_sta))
   	return

that would clearly indicate the check is for 'not possible' scenario.

Regards
Stanislaw



