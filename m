Return-Path: <linux-wireless+bounces-30424-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E012DCFC88B
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 09:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B8953007FD2
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 08:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8521DED57;
	Wed,  7 Jan 2026 08:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="ayOfZxrU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7911284663
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 08:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767773208; cv=none; b=imFgXQucC/d9EG3/GdwSYt9zl9MnMHHTid4AVY0tUXjltdSmoUneTACHk0Sr6uzdhC5jOl8PpZD5aZwKWkg/MmGiOK5IQhYyMHuhHguH+9zhDZ432lUBMVRv8kPQfJoLx/kZNfLLmjeSrxA2pRVrFQ2PTwb6MbgeON7jZPmfEgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767773208; c=relaxed/simple;
	bh=/e7m1LUUc4PysGuAoKyBm2Ed78S9H5HAyicgtxqNGr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bndV4fNWxOUX7NFzxIgggO3sXaOKrBg/9gkFotg7Jy+/yE9biJDfJ/dWQG8+e+l21TznRrD0FzmAQEx6lkQgPIGL8PtzGOKp+FbHq+xMTZbTgybCYLEx6t9X9vp9OQqIOR0tNpYUrMPfRLpD4dSydX6M1JeyORDIYjurbNWkwVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=ayOfZxrU; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 38350 invoked from network); 7 Jan 2026 09:06:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1767773201; bh=ICZJEwOnuvFoqpHG8uF80tmIEic7pmSNUuyjHxU3Sp0=;
          h=From:To:Cc:Subject;
          b=ayOfZxrUXweo35L6rzu8pp/07SXan9WT6B8fA9wJGpmnbBr+Bwb4Dx/Vi6Pv9/ULQ
           SmdZrn9J1zHxquAa2CKQLz4giANkoNqJntFqfzmtwhz+1XSandBOS6hbWtEXKhy+ep
           S07UgqaFE3IBhHXZ578KT2VbSZHbp992sFumVFUCvFaESIqPaPUtAM5PK8PSTdNbwn
           CBlZzniiRIl0xml0sBc8zHVlmG3UgKgBdkouhSbayhm9h3rIEeui2oqN/2FQO8+nhP
           Np9ldM1WuUFG6CfLq6bSXGM/G+hp4PnbYJhK3UHBgrVJLaKY3mv0nNfFVgxFpy9bcQ
           kCFThR5QBOE/g==
Received: from 89-64-9-177.dynamic.play.pl (HELO localhost) (stf_xl@wp.pl@[89.64.9.177])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <islituo@gmail.com>; 7 Jan 2026 09:06:41 +0100
Date: Wed, 7 Jan 2026 09:06:41 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Tuo Li <islituo@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iwlegacy: 3945-rs: fix possible null-pointer
 dereferences in il3945_rs_get_rate()
Message-ID: <20260107080641.GB34085@wp.pl>
References: <20260107071001.172132-1-islituo@gmail.com>
 <20260107074438.GA34085@wp.pl>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107074438.GA34085@wp.pl>
X-WP-MailID: bdaf6da7728e5f19f7a3ddfbaa1bec0c
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000003 [YWCl]                               

On Wed, Jan 07, 2026 at 08:44:40AM +0100, Stanislaw Gruszka wrote:
> On Wed, Jan 07, 2026 at 03:10:01PM +0800, Tuo Li wrote:
> > In this function, il_sta is assigned to rs_sta, and rs_sta is dereferenced
> > at several points. If il_sta is NULL, this can lead to null-pointer
> > dereferences. To fix this issue, add an early check for il_sta and return
> > if it is NULL, consistent with the handling in il3945_rs_tx_status().
> > 
> > Signed-off-by: Tuo Li <islituo@gmail.com>
> > ---
> >  drivers/net/wireless/intel/iwlegacy/3945-rs.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/wireless/intel/iwlegacy/3945-rs.c b/drivers/net/wireless/intel/iwlegacy/3945-rs.c
> > index 1826c37c090c..c13268093a6e 100644
> > --- a/drivers/net/wireless/intel/iwlegacy/3945-rs.c
> > +++ b/drivers/net/wireless/intel/iwlegacy/3945-rs.c
> > @@ -626,8 +626,13 @@ il3945_rs_get_rate(void *il_r, struct ieee80211_sta *sta, void *il_sta,
> >  
> >  	D_RATE("enter\n");
> >  
> > +	if (!il_sta) {
> > +		D_RATE("leave: No STA il data available!\n");
> > +		return;
> > +	}
> > +
> >  	/* Treat uninitialized rate scaling data same as non-existing. */
> > -	if (rs_sta && !rs_sta->il) {
> > +	if (!rs_sta->il) {
> >  		D_RATE("Rate scaling information not initialized yet.\n");
> >  		il_sta = NULL;
> Please also change to return here instead of setting il_sta to NULL.
> And make D_RATE messages similar to il3945_rs_tx_status() i.e. :
> 
>           if (!il_sta) {
>                   D_RATE("leave: No STA il data to update!\n");
>                   return;
>           }
> 
>           /* Treat uninitialized rate scaling data same as non-existing. */
>           if (!rs_sta->il) {
>                   D_RATE("leave: STA il data uninitialized!\n");
>                   return;
>           }

Please also add 'wifi:' prefix to the patch title.
 
Thanks
Stanislaw

