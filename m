Return-Path: <linux-wireless+bounces-13584-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B06992A34
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 13:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F235281469
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 11:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE781D1F56;
	Mon,  7 Oct 2024 11:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="P9vyEk6X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0C01D1319;
	Mon,  7 Oct 2024 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728300578; cv=none; b=hIKMmqx24ogfA4XmwN1U037JFJdLSCr+qONfjLxen9NbPD0vv96kbyR8sDlAE5zvz1hoTZIy49BlTWWWYYqrvM5kDjMxcNu+cYbn5+VEa3jZdrvIPKE6t1oYfd0hWFiNcgmx1zvRtaNA4mknWk1/6o5lhYxebiVWgMRjYOntV44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728300578; c=relaxed/simple;
	bh=SxQ51OTOzRyiDYMTgAY8ft6J9j6FMH0+aAgvxnpok0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rr1O7VBE+lOX69MrjU3kKvBLFmTCXk25hTzt2RmGyt2nf+n7PPCvmr9vPAxgB1/t/92ZqYTf8P4yNGynDdSVnhFIBQDCyfoC7DV9R/109i+mauzwGzPN/LCYLbPGhfnZaVaRN+dYC6vjtI9U+zS3l4k9ZIJvXAJI8GnQ29LwZ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=P9vyEk6X; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=+fkSsHwtdQgMvduYygfi3dN2uWiuZvcckNGTJy3sukA=; b=P9vyEk6XN/M1SE/F
	B09Q9SbMd9S0Lw04fs4eOy/E77tdgdLmGHAphbCYlrJCg5/QKHYdS+r7Ql6ghZ71+QQqKY1okJid/
	FwEBB7N24X3FVAdaSS2/WnpgWqkATL2bFSLVtqErk1jiMB3o8DrpNJgjqQacF+9MmbmDcIg8APOPy
	apf0h0c4SVtKgFlbEdtBtswQGHp3FQphrGLIJXfyCepVtL6E5MnlDxkEqYouOqNqq37mP8pzPhnMi
	zRdbWHZUXoz6stoJ7Wl0GcFi/HWzjtNK0WKoBJawXBP0sGT9MqbnXCxoFCRT5XKlTiE0zViZqP4dw
	CP2QJ6YjHu4zHlqVqg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sxlvc-009QSb-1A;
	Mon, 07 Oct 2024 11:29:28 +0000
Date: Mon, 7 Oct 2024 11:29:28 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cfg80211: Remove unused cfg80211_vendor_ functions
Message-ID: <ZwPGGBxdTGP3tPtW@gallifrey>
References: <20241006225303.121445-1-linux@treblig.org>
 <20241006225303.121445-3-linux@treblig.org>
 <d402977d8681c86c4a0e09962d396964ccdcb4a8.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <d402977d8681c86c4a0e09962d396964ccdcb4a8.camel@sipsolutions.net>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 11:28:48 up 151 days, 22:42,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Johannes Berg (johannes@sipsolutions.net) wrote:
> On Sun, 2024-10-06 at 23:53 +0100, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > cfg80211_vendor_cmd_get_sender() and cfg80211_vendor_event_alloc_ucast()
> > were added in 2019 by commit
> > 55c1fdf0d6c5 ("cfg80211: allow sending vendor events unicast")
> > 
> > but never used.
> > 
> 
> Yeah ... we have out-of-tree code using this for CSI matrix stuff
> (sensing), but I guess we can keep this API out-of-tree just as well,
> though it'll make it harder to integrate in ChromeOS.

Obviously it's the maintainers call as which way to go.
I guess the best outcome would be for that out-of-tree code to land in
the tree!

Dave

> johannes
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

