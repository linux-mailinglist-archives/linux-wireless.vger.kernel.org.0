Return-Path: <linux-wireless+bounces-22222-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E16AA39FC
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 23:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A43B9C10E4
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 21:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFCB26988C;
	Tue, 29 Apr 2025 21:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="nr7tAiVI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BA822A7ED
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 21:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745962829; cv=none; b=RnAI1yQx8jWhnzAtnjKHv75kxERhX9f8rJF2wnjKV3qrfEMdEvUnqPwE3YiKQJpQqOihxhUkI2sYrcAaKgzyDdjCo5L5aXsICAbyPUB/Z8EJMQt3DboPghceOK6FNjmlbnrsFi2GL2sX5K3PwCEDATrIeRZPYgYLm2mqh4XxIkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745962829; c=relaxed/simple;
	bh=yRb7/lDslTlRdulv8UKLXCO4mzF4SCMJ6ui9a8zVlH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2vaSdJUt7iv6zoCjErANFiUBGbtWxyhHaWiDBTdJANgKkJLpgtcEAXJlcEFoKR4PYp936hHBNtz+r/H16SfuORd0ZFp5RQtwNrlAMcKSZmSkwyOQPlPxAAS93LG4Bt1MnLBz4Ff1VRNoP+582IBPfCd5sclSbU4WUnwdBcUrbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=nr7tAiVI; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 2564 invoked from network); 29 Apr 2025 23:40:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1745962818; bh=QsS+vghrLazG/Lj5WT2xQ0ZHOLkr/aVzxaRWd06fOsA=;
          h=From:To:Cc:Subject;
          b=nr7tAiVI4OeziEkW4tnzoYHtRw3WgBLf7x/+AmdORv/YMiHNXGmJNBX5SqAbwmmxz
           7Ufdptb8CC+hZoxrigvP45Ua3wvyiEizWf1rsJGJIQxkabz9zF17z70vd/b7MHlVkh
           0tlikjWn1/7sDejMWbORXWs65XMWpChrY4zxPOdwDw4XanzAyDgae8v5C3OKdspQOH
           2xPo7Y3H4DqPwDLzwyKAyX/IbphAppmpTgC/ZfZek5C5aTeedjbqHWjCYGTyV1uhKZ
           A1AaWD5OT26mNO1j32PuH0jS6tvZT+Y7zMQvIVMwu+XmVlyJqjkhCTmQlimlRQMSQJ
           qgxlx4ZPz4nuQ==
Received: from 89-64-9-175.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.9.175])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <pchelkin@ispras.ru>; 29 Apr 2025 23:40:18 +0200
Date: Tue, 29 Apr 2025 23:40:18 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Alexei Safin <a.safin@rosa.ru>, lvc-project@linuxtesting.org,
	netdev@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2] iwlegacy: 4965: fix possible out-of-bounds access in
 il4965_tx_cmd_build_rate()
Message-ID: <20250429214018.GA55582@wp.pl>
References: <20250424185244.3562-1-a.safin@rosa.ru>
 <20250427063900.GA48509@wp.pl>
 <d57qkj2tj4bgfobgzbhcb4bceh327o35mgamy2yyfuvolg4ymo@7p7hbpyg5bxi>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d57qkj2tj4bgfobgzbhcb4bceh327o35mgamy2yyfuvolg4ymo@7p7hbpyg5bxi>
X-WP-MailID: 29ac691aa7d10a18ddcfef0a5cf7185a
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [QXKh]                               

Hi

On Tue, Apr 29, 2025 at 08:15:59PM +0300, Fedor Pchelkin wrote:
> Hello,
> 
> On Sun, 27. Apr 08:39, Stanislaw Gruszka wrote:
> > > diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> > > index 78dee8ccfebf..f60d9b9798c1 100644
> > > --- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> > > +++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> > > @@ -1572,7 +1572,7 @@ il4965_tx_cmd_build_rate(struct il_priv *il,
> > >  	 */
> > >  	rate_idx = info->control.rates[0].idx;
> > >  	if ((info->control.rates[0].flags & IEEE80211_TX_RC_MCS) || rate_idx < 0
> > > -	    || rate_idx > RATE_COUNT_LEGACY)
> > > +	    || rate_idx >= RATE_COUNT_LEGACY)
> > >  		rate_idx = rate_lowest_index(&il->bands[info->band], sta);
> > 
> > .. so looks the check is fine already and changing it will induce a bug
> > for RATE_54M_INDEX.
> > 
> > Regards
> > Stanislaw
> > 
> > >  	/* For 5 GHZ band, remap mac80211 rate indices into driver indices */
> > >  	if (info->band == NL80211_BAND_5GHZ)
> 
> Here goes the fragment:
> 
> 		rate_idx += IL_FIRST_OFDM_RATE;
> 	/* Get PLCP rate for tx_cmd->rate_n_flags */
> 	rate_plcp = il_rates[rate_idx].plcp;
> 
> > > -- 
> > > 2.39.5 (Apple Git-154)
> > > 
> 
> Looks like the proper checks should be added to address the 5GHZ case and
> validate that the index won't exceed the array boundaries after being shifted
> by IL_FIRST_OFDM_RATE.

Good point. It make sense to move rate_idx range check after possible
IL_FIRST_OFDM_RATE addition for 5GHz.

Regards
Stanislaw

