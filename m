Return-Path: <linux-wireless+bounces-20762-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EB4A6DDFA
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 16:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD81C3AF3CA
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 15:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9498F261366;
	Mon, 24 Mar 2025 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="ePmjkGUz";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="KiDFgfYW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e3i165.smtp2go.com (e3i165.smtp2go.com [158.120.84.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D959825FA3C
	for <linux-wireless@vger.kernel.org>; Mon, 24 Mar 2025 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742829269; cv=none; b=q3BoS148yJa6QeMWKYnBN9QEhVVyy18m/5W9aALFJquG25m5vqXn7zfeT29Peiu9K5ys6ur7jLaOGzo6N/vy/qyE6IioFmRsqnP9BYPGzFl9UNldMkbm3Wzn+HL0yAQJtBci3JFP3IXJ2UtSH5Sk11vE5ritbgKRsLf7L4SkXVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742829269; c=relaxed/simple;
	bh=69WISYTUeyK+qmVhLhIjtcyQ13uXlKzO4on/H7X2VoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLg9lxt+mVJFcHNr29XCwCJzgYYAM+zZHBOikk5/zTm9Qxb5e7qyBjU7GBHER3GviHOnoaQ8cephcGGyCnIKmsJgxk/3T+gq1F30OGB58BRKkf17593JItH1rKNtAiauAtC3TJ0j4Mjpd6mWZRbbdeOFVkHBh+02wodM+z0+V/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=ePmjkGUz; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=KiDFgfYW; arc=none smtp.client-ip=158.120.84.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1742829262; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=Gyw2dOnwil2HjkxljpAsWuv+tbZspN2iCriGXDWGmYU=;
 b=ePmjkGUzhdOXWvExpcqPpBvRZ7XNhrNx4fLqyIDDA4Xokz8bVv27rjk/xTt8ig9S0cnzw
 oKbWKGhxc5uERABJj/2M5XQ3eS54w6tHOBR6dzBdPq01zyZRS1ihvfy4RAfSCD85SvOYKuR
 MfP5BTUs1yLukvAZqkkYB0yduu6EC6QFeRTLlGx0leaEsSJ1oKsRFq0PWV7lPtMPief2Ohy
 5Isa6gNJMq3SZrDowDS/1/t3KH/Sp5SLnBFJzdyRMJHQc9i9Hcg5LrjJcWK40zecl63+Xmd
 MkriCTHhBZoLLQkye+wHZtoCDlRQ3TQ/ExObh/A4hj1rTuLr1bYmftMNWU9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1742829262; h=from : subject
 : to : message-id : date;
 bh=Gyw2dOnwil2HjkxljpAsWuv+tbZspN2iCriGXDWGmYU=;
 b=KiDFgfYWLtE3p1ubpJ8QuFDntbV71h3Bs0O70WUoWORmHprsBnJRW1UH+PICYUMxZfKaj
 CWl4iyBOw+hlxwQ8dDHpPoLPzke8ZQ/8nz5lIBHL6qLnFFghNYZA6TU4dwNnCl2WFPiTBMd
 PzuB9Gy6nEt/nPlAg36cXdmyJbC5p9V+aBn1cBl1Fk8cl/RYNdgm9PptAUPAKfvK3QYfBKE
 u7wNhpbnsGI4/tpzIu0pId/P+GMhH9CP8dWOk7wBrOGjzS/+3Aong80i6fT3FK2KRR48Lve
 N6uPIXiws6Ca+dQYsiQyLd0pknO39+ZgXRMrXIU4Jyxb8GdJlzJm1A0XAGwQ==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1twjVK-4o5NDgrl40B-qkzt;
	Mon, 24 Mar 2025 15:14:18 +0000
Date: Mon, 24 Mar 2025 16:08:29 +0100
From: Remi Pommarel <repk@triplefau.lt>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] wifi: mac80211: Update skb's NULL key in
 ieee80211_tx_h_select_key()
Message-ID: <Z-F1bfP7u6uKMK2g@pilgrim>
References: <cover.1741950009.git.repk@triplefau.lt>
 <95269f93724a94ee0b22f8107fe5b5e8f2fbea76.1741950009.git.repk@triplefau.lt>
 <754c24f1b1f7d37cb616478c57a85af18d119c21.camel@sipsolutions.net>
 <Z-Fl9OUQ1EAEWW7h@pilgrim>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-Fl9OUQ1EAEWW7h@pilgrim>
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sK0fTxuVRN
X-smtpcorp-track: 68bbdyTtyxxR.LPU0DPgkUT_k._DK8jAlVqkF

On Mon, Mar 24, 2025 at 03:02:48PM +0100, Remi Pommarel wrote:
> On Mon, Mar 24, 2025 at 01:17:08PM +0100, Johannes Berg wrote:
> > On Fri, 2025-03-14 at 12:04 +0100, Remi Pommarel wrote:
> > > The ieee80211 skb control block key (set when skb was queued) could have
> > > been removed before ieee80211_tx_dequeue() call. ieee80211_tx_dequeue()
> > > already called ieee80211_tx_h_select_key() to get the current key, but
> > > the latter do not update the key in skb control block in case it is
> > > NULL. Because some drivers actually use this key in their TX callbacks
> > > (e.g. ath1{1,2}k_mac_op_tx()) this could lead to the use after free
> > > below:
> > > 
> > >   BUG: KASAN: slab-use-after-free in ath11k_mac_op_tx+0x590/0x61c
> > >   Read of size 4 at addr ffffff803083c248 by task kworker/u16:4/1440
> > 
> > 
> > Maybe should have a Fixes: tag?
> 
> Finding a fix tag is not easy for this case because I am not sure which
> commit exactly introduced the issue. Is it the introduction of
> ieee80211_handle_wake_tx_queue() (i.e. c850e31f79f0) that allows packets
> queued on another dev to be processed or the one that introduced
> ieee80211_tx_dequeue() (i.e.  bb42f2d13ffc) ?
> 
> I would have said the latter, what do you think ?
> 
> > 
> > And please also tag the subject "[PATCH wireless NN/MM]".
> 
> Sure I have seen the new subject tag discussion too late unfortunately.
> 
> > 
> > > +++ b/net/mac80211/tx.c
> > > @@ -668,6 +668,12 @@ ieee80211_tx_h_select_key(struct ieee80211_tx_data *tx)
> > >  	} else if (ieee80211_is_data_present(hdr->frame_control) && tx->sta &&
> > >  		   test_sta_flag(tx->sta, WLAN_STA_USES_ENCRYPTION)) {
> > >  		return TX_DROP;
> > > +	} else {
> > > +		/* Clear SKB CB key reference, ieee80211_tx_h_select_key()
> > > +		 * could have been called to update key info after its removal
> > > +		 * (e.g. by ieee80211_tx_dequeue()).
> > > +		 */
> > > +		info->control.hw_key = NULL;
> > >  	}
> > 
> > I'm not sure this looks like the right place - should probably be done
> > around line 3897 before the call:
> > 
> >         /*
> >          * The key can be removed while the packet was queued, so need to call
> >          * this here to get the current key.
> >          */
> >         r = ieee80211_tx_h_select_key(&tx);
> > 
> > 
> > I'd think?
> 
> I initially did that, but because I ended up with the following:
> 
> +	info.control.hw_key = (tx->key) ? &tx->key.conf: NULL;
> 
> I found it more readable to do that directly in
> ieee80211_tx_h_select_key(). But I don't have strong feeling about that.
> So both ways are fine with me, let me know which one like the most ?

Oh sorry, you meant to initialize to NULL *before* the call to
ieee80211_tx_h_select_key(), sure will do that instead.

-- 
Remi

