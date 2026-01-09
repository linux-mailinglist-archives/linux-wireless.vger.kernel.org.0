Return-Path: <linux-wireless+bounces-30610-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DA3D0C339
	for <lists+linux-wireless@lfdr.de>; Fri, 09 Jan 2026 21:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34C3030142F0
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jan 2026 20:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F7D2DB794;
	Fri,  9 Jan 2026 20:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="joy6bc0w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3AF19D8BC
	for <linux-wireless@vger.kernel.org>; Fri,  9 Jan 2026 20:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767991367; cv=none; b=ozkvz+ZBtzRa9jrYzLejlSI2I6fuqvbd28U6AzN2dm7c58cJz5ob/RGZd+Cp6t6ppy5JF59gcHmOpluCSWNrWdmD1FmxK5+gF6sNx3nvEnNSjVQbEhwvPIMU4P3kmOri/Ncf4ftDUELo3xAOeEqxavcna5oRnAW4eqs3tv6PhaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767991367; c=relaxed/simple;
	bh=MWqjsQD/6l2PUJIy+xIykKw/5PSnhX85V3tQX/8iGUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuS4ExYPml9JC1JXGw/onFiAK4r6EWn+tr2TZffwEB5if9dc6F2HFLhj/pBsCq/bx6BTWaJcY8fbXqOzm1V7xEcvuh72mOAJksN9yK8oVRYn8/qPzhw3yXglxUy4xz7YXYG4SV9oBbuPyzV3ZTi7VoyDS9IRze9EoC5H6Zit5Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=joy6bc0w; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 47167 invoked from network); 9 Jan 2026 21:42:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1767991356; bh=7jYyLEeIh9szMdS3sHMNYEnkIu0S3HaRI8wJKR7ryLk=;
          h=From:To:Cc:Subject;
          b=joy6bc0wqjfI0EbAw84InOirr2se3l6PBYa58fda+SLL19p8AQAPECvdEG0R0/nuk
           te0WRZ3Jo1LtMRJ4FtIe39LB36xFaLQH/Z4VWLoNpXZFAP1jZMDq7oAd8ToZClQ0/t
           C8fyVsU/Bx2mEsvD1Dpmn88hh/MGDeSxfHD0+Ffd9vJ0kky7msmE6hxNHb1MT9pH23
           O8lh8PdvtDicfgtztZSjc2000QRxdDP92o+ANrV2zbv31acRibdcOg3nvrMcQ2nZag
           7VqDs2u1psAs3Kb+QFHGR26Vx7kj1+fPW3bTrQIyf6I6BPCtdfOXusy4IFezYhAVWx
           Ld52or04oI9ww==
Received: from 89-64-9-177.dynamic.play.pl (HELO localhost) (stf_xl@wp.pl@[89.64.9.177])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <islituo@gmail.com>; 9 Jan 2026 21:42:35 +0100
Date: Fri, 9 Jan 2026 21:42:35 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Tuo Li <islituo@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] wifi: iwlegacy: 3945-rs: add a defensive WARN_ON_ONCE
 for il_sta in il3945_rs_get_rate()
Message-ID: <20260109204235.GA48564@wp.pl>
References: <20260109034014.187124-1-islituo@gmail.com>
 <20260109090227.GA48150@wp.pl>
 <CADm8Tenw9kpk9suABMEYguURxtWrXRaRAiXogxUfwSash-c0ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADm8Tenw9kpk9suABMEYguURxtWrXRaRAiXogxUfwSash-c0ng@mail.gmail.com>
X-WP-MailID: f4364cf07eb526dc6cadf6dfc56a525e
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [QTKF]                               

Hi

On Fri, Jan 09, 2026 at 11:12:55PM +0800, Tuo Li wrote:
> > Sorry for giving you wrong advice before, but after examining related code
> > I agree with Johannes the il_sta can not be NULL.
> > Now, I think we should just remove il_sta/rs_sta pointer check.
> >
> > Regards
> > Stanislaw
> 
> Thanks for the follow-up and your patience. I appreciate you taking
> another look at the code.
> 
> Just to confirm, would you like me to submit a v4 patch that removes the
> unnecessary il_sta / rs_sta checks, e.g.:
> 
> in il3945_rs_get_rate():
> 
> - if (rs_sta && !rs_sta->il) {
> + if (!rs_sta->il) {
> 
> and in il3945_rs_tx_status():
> 
> - if (!il_sta) {
> -     D_RATE("leave: No STA il data to update!\n");
> -     return;
> - }

Yes, please post those changes as v4.

Thanks
Stanislaw

