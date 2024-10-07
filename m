Return-Path: <linux-wireless+bounces-13581-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 085259929D9
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 13:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 822B31F22BC8
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 11:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4971BB69E;
	Mon,  7 Oct 2024 11:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="jmMUycRd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800013FBA5;
	Mon,  7 Oct 2024 11:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298966; cv=none; b=OJYDtsHHmqKfisTcsg3xHS7aloIsETDVhUmPDGrOGl+5ZnA2TErEQ8n9JRjS6hRzt13ptjGfTyHFaBh+WZCd2M6LXeg1OY6qysUtstXZlVBHUKiHYY0qF5xVkzGtM80nwOa78BIiSY9fmYvJYNT8g8JB2QlbpHu/si0Ey0N48+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298966; c=relaxed/simple;
	bh=FRySkjQzO6lfk1QnDsoJoJYyGOnf6qBzb2WynHvIQlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9EkTu5yw9Ne8uKSkgc84wL+UjlAZ5ONLh7sN0JYr1lQG7fPZurxOB/4Zk5rPqM7iFK+0QoAVM7A7Xf/L4ihYIGcFk7eXjQqILKOgDqEWL4S86Reg8r43qSH4Epjt8KKwQC/GpVHJB1IEbKaugGK/1JXVdKd7D83Fy+WNR9UKuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=jmMUycRd; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=4UdrlcSM0R9sIwpXI9mXRLqDoDJqEckyOHQSRBFfszo=; b=jmMUycRdrju7lfyC
	6cziNsZ8IoScMbK/7hxxP/20Fzbwuo/vZ7CYIkwcDsDfI17PRbue7THHymb20Mc0sGGaQHwVjKiNQ
	ZdXabwZ9CDftFO2V3jXzj6XhVq5p73BSqlRZEYSni7c9Hpz+Mc6KtO0qVWHO4oS3T5IMMHLL2Evtz
	i7+6P/nBNCrBNIaTmU7PWfoHH48/lEjZ+iHA/3nmQVdvu0Sdz87+UGvE2Tth0OIShgUpJaByoLKIJ
	YCMltCKMtZ7jlGUrG9kso09d1kAvkyVNJQmfTtZ66QJ0xlaw2Q7TYqC0cqiAEiJXPx1j4A/QsMT8l
	iJtzmcdkNHfEx610aA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sxlVY-009QFo-0K;
	Mon, 07 Oct 2024 11:02:32 +0000
Date: Mon, 7 Oct 2024 11:02:32 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Cc: johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cfg80211: Remove unused cfg80211_background_cac_abort
Message-ID: <ZwO_yAmGLB5aqgXR@gallifrey>
References: <20241006225303.121445-1-linux@treblig.org>
 <20241006225303.121445-2-linux@treblig.org>
 <831a7a48-2fed-c84c-dee5-8e74735309fb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <831a7a48-2fed-c84c-dee5-8e74735309fb@quicinc.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 11:02:02 up 151 days, 22:16,  1 user,  load average: 0.17, 0.08,
 0.02
User-Agent: Mutt/2.2.12 (2023-09-09)

* Vasanthakumar Thiagarajan (quic_vthiagar@quicinc.com) wrote:
> 
> 
> On 10/7/2024 4:23 AM, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > cfg80211_background_cac_abort() is unused.
> > It got renamed from cfg80211_offchan_cac_abort by commit
> > a95bfb876fa8 ("cfg80211: rename offchannel_chain structs to background_chain to avoid confusion with ETSI standard")
> > 
> > and that was originally added in commit
> > 1507b1531981 ("cfg80211: move offchan_cac_event to a dedicated work")
> > but never used.
> > 
> > To me it looks like the queue is still used (I see a queue_work
> > in __cfg80211_radar_event), so I think it's just the wrapper that's
> > unused.
> > 
> > Remove cfg80211_background_cac_abort.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > ---
> >   include/net/cfg80211.h | 9 ---------
> >   net/wireless/mlme.c    | 8 --------
> >   2 files changed, 17 deletions(-)
> > 
> > diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> > index 69ec1eb41a09..fd843a519329 100644
> > --- a/include/net/cfg80211.h
> > +++ b/include/net/cfg80211.h
> > @@ -8752,15 +8752,6 @@ void cfg80211_cac_event(struct net_device *netdev,
> >   			enum nl80211_radar_event event, gfp_t gfp,
> >   			unsigned int link_id);
> > -/**
> > - * cfg80211_background_cac_abort - Channel Availability Check offchan abort event
> > - * @wiphy: the wiphy
> > - *
> > - * This function is called by the driver when a Channel Availability Check
> > - * (CAC) is aborted by a offchannel dedicated chain.
> > - */
> > -void cfg80211_background_cac_abort(struct wiphy *wiphy);
> > -
> >   /**
> >    * cfg80211_gtk_rekey_notify - notify userspace about driver rekeying
> >    * @dev: network device
> > diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
> > index 4dac81854721..8ec236bbbc7c 100644
> > --- a/net/wireless/mlme.c
> > +++ b/net/wireless/mlme.c
> > @@ -1226,14 +1226,6 @@ void cfg80211_background_cac_abort_wk(struct work_struct *work)
> >   				      NL80211_RADAR_CAC_ABORTED);
> >   }
> > -void cfg80211_background_cac_abort(struct wiphy *wiphy)
> > -{
> > -	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
> > -
> > -	queue_work(cfg80211_wq, &rdev->background_cac_abort_wk);
> > -}
> > -EXPORT_SYMBOL(cfg80211_background_cac_abort);
> > -
> 
> We have an internal WIP ath driver implementation for background radar feature
> calling this function to notify the background CAC abort state. There is definitely
> real use case for this function.

OK, fair enough.

What about the other patch?

Dave

> Vasanth
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

