Return-Path: <linux-wireless+bounces-20761-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3E4A6DCE5
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 15:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A9E27A1844
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 14:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95437261386;
	Mon, 24 Mar 2025 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="lYFvzUFu";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="EymrTWYd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e3i165.smtp2go.com (e3i165.smtp2go.com [158.120.84.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76732261382
	for <linux-wireless@vger.kernel.org>; Mon, 24 Mar 2025 14:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826231; cv=none; b=OAnJMQWfmAVhLMeyw8LfWNcgN9nfbpSBSSf66hObP+1UGId6TbO0ONDpv18CH+20jzb0jDtnGn0BfqBMxLjyT4qLmv7KwW997eIULt01TK3Q9yooVXZ3IQh3wVECB2Dqi/w2P0jm5z4hSPhfoVdmSFM1UzJeV4s2ENnhn7NUgsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826231; c=relaxed/simple;
	bh=ToFyzl6GSpIn6zHTY33rxgKFVEyEWn3ZHzthUGrGIec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+28h82Q3dYfEk+uwYUhlkHUgzHYTYLH0/yWfzxZi7Drjx+ab2Kvwf2FPk2ve3WBKpnNJFlBFBLd9ZoJzp/J+sv3iEvkFytuAVOgBOJ8JrLdf98/KaGsx0r3gbCJVU2UmUtnmh5DWKh8aiG9h9nIIkhwrc+OlSWm6z+u0wAL76E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=lYFvzUFu; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=EymrTWYd; arc=none smtp.client-ip=158.120.84.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1742825319; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=zaXxgjvCin+rYsk8n7kZ8AobdkmIqB6g2RtdWZJsd+g=;
 b=lYFvzUFuF0siSwZAZl4LbMyYyyH1ag4tfZoCmawCii4k0FyHHXgLiFy3RC/V8ym8Wtgy/
 Qd4me5n6vYjeOvP1un3U2DW0d2KIrzbDhGaWXlszgCk7TumCmL0BdsKGXBf+QkBFrnjoddn
 zkkfbmzDfipGt/AARUuh2sOj/FX2UJOrMRLx3dCkmNqu0hYp+kFpdmoJG+RusqtAoMLXgfe
 oaw6pzfVnRBE2RBBdFGb9Zs0ANdJRgdMY9gNDrpXMUeY4UQsIQcxeHoOsl97ZvvTmcLiOq0
 egNxfn0BTrtzEUX31cwT6YN1v+Y0ykdRcAAsOhsha4SmH3RloUxjvQQ/GJ8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1742825319; h=from : subject
 : to : message-id : date;
 bh=zaXxgjvCin+rYsk8n7kZ8AobdkmIqB6g2RtdWZJsd+g=;
 b=EymrTWYdAMs4P/eXfFJRiEkvWP9Qekhbez2G6D5ivWDJzWQ3eFnrrv6BX2HBAsJ9UN8SI
 mC776Ea8OGfyIM7jY1G4ioI00+wAIW/DDLQxA+9DVrJ3NCYYWhXGLHyp5iLfpdYGsb0zKEO
 vrrlWpSTeMMQnKSZk7a1gIiHfXwWfh7rpYZXxv6Ya8SjUC18fsrxCwxK1MeJcT1mGtVDUN1
 GZ9V69h45BpCKdaE7m47wyxU6Xrp0qbZyFbVmPodyVKxK7O7mcCwnTNOMwi1vzcqk8JZoQo
 6zYhubUz0WeDzwsC3x22N2RxGZf7+r3fz/4B5xX9J0ZPXsiNfzMabJRJskvQ==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1twiTj-AIkwcC8jqrf-Hs44;
	Mon, 24 Mar 2025 14:08:35 +0000
Date: Mon, 24 Mar 2025 15:02:28 +0100
From: Remi Pommarel <repk@triplefau.lt>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] wifi: mac80211: Update skb's NULL key in
 ieee80211_tx_h_select_key()
Message-ID: <Z-Fl9OUQ1EAEWW7h@pilgrim>
References: <cover.1741950009.git.repk@triplefau.lt>
 <95269f93724a94ee0b22f8107fe5b5e8f2fbea76.1741950009.git.repk@triplefau.lt>
 <754c24f1b1f7d37cb616478c57a85af18d119c21.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <754c24f1b1f7d37cb616478c57a85af18d119c21.camel@sipsolutions.net>
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sK0fTxuVRN
X-smtpcorp-track: FZcL2kbk6ABv.q_MtygxwLyg4.xS337gN13ce

On Mon, Mar 24, 2025 at 01:17:08PM +0100, Johannes Berg wrote:
> On Fri, 2025-03-14 at 12:04 +0100, Remi Pommarel wrote:
> > The ieee80211 skb control block key (set when skb was queued) could have
> > been removed before ieee80211_tx_dequeue() call. ieee80211_tx_dequeue()
> > already called ieee80211_tx_h_select_key() to get the current key, but
> > the latter do not update the key in skb control block in case it is
> > NULL. Because some drivers actually use this key in their TX callbacks
> > (e.g. ath1{1,2}k_mac_op_tx()) this could lead to the use after free
> > below:
> > 
> >   BUG: KASAN: slab-use-after-free in ath11k_mac_op_tx+0x590/0x61c
> >   Read of size 4 at addr ffffff803083c248 by task kworker/u16:4/1440
> 
> 
> Maybe should have a Fixes: tag?

Finding a fix tag is not easy for this case because I am not sure which
commit exactly introduced the issue. Is it the introduction of
ieee80211_handle_wake_tx_queue() (i.e. c850e31f79f0) that allows packets
queued on another dev to be processed or the one that introduced
ieee80211_tx_dequeue() (i.e.  bb42f2d13ffc) ?

I would have said the latter, what do you think ?

> 
> And please also tag the subject "[PATCH wireless NN/MM]".

Sure I have seen the new subject tag discussion too late unfortunately.

> 
> > +++ b/net/mac80211/tx.c
> > @@ -668,6 +668,12 @@ ieee80211_tx_h_select_key(struct ieee80211_tx_data *tx)
> >  	} else if (ieee80211_is_data_present(hdr->frame_control) && tx->sta &&
> >  		   test_sta_flag(tx->sta, WLAN_STA_USES_ENCRYPTION)) {
> >  		return TX_DROP;
> > +	} else {
> > +		/* Clear SKB CB key reference, ieee80211_tx_h_select_key()
> > +		 * could have been called to update key info after its removal
> > +		 * (e.g. by ieee80211_tx_dequeue()).
> > +		 */
> > +		info->control.hw_key = NULL;
> >  	}
> 
> I'm not sure this looks like the right place - should probably be done
> around line 3897 before the call:
> 
>         /*
>          * The key can be removed while the packet was queued, so need to call
>          * this here to get the current key.
>          */
>         r = ieee80211_tx_h_select_key(&tx);
> 
> 
> I'd think?

I initially did that, but because I ended up with the following:

+	info.control.hw_key = (tx->key) ? &tx->key.conf: NULL;

I found it more readable to do that directly in
ieee80211_tx_h_select_key(). But I don't have strong feeling about that.
So both ways are fine with me, let me know which one like the most ?

-- 
Remi

