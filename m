Return-Path: <linux-wireless+bounces-18085-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A7AA211BC
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 19:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 728301884C0C
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 18:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976AA1A725A;
	Tue, 28 Jan 2025 18:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="ntt4ENeo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA65BE40;
	Tue, 28 Jan 2025 18:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738089567; cv=none; b=ej7iochOsk+pfrmmdTWLE8y54Ua6hLTI3OGP3qPg6RJccCnd/2IBBVMMtxPpTh7hez+dnor3VsmzS/sFRe9tCWe1PGqcTK8rLAEkyDB3xlGbs4Lv4TS4ifXVnh3cI+BVXo468hw59nl70Cset91/vzfydCZvkICPmEOdJ3EAJ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738089567; c=relaxed/simple;
	bh=f3IEGRCmk/5zVEWSpjgyqRQK6y7H9X3IlRtPc78B55w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1MKdNoKPlNHMUkyB7dJJzi1YujTikUWpn0FqPzf7mOqh6yR6xywivC5mbiXjQl07izG7tYdarQo07971z55zXKl9EA5X+6+763av4CQ36s/ZpBgf33PCqdJ7K/JxO3T7PKk8ryvJmXxnzXsCNqFAXw4qzwAZiYdI6PuPq2hieM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=ntt4ENeo; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=z/zHYTl1Q665YDulmLZXjaBwvitYIconswfbKBQ4sZ0=; b=ntt4ENeofoWWGeeY
	gYD65PWzbdUrWe2TMzh2uWVuD/U0P58Yoc7GdX+FQAKj+Hnv9a9ZXWGz5dgVwp6l5vgDkV0TZ9ukZ
	O2Ld4nOEPou0mTE6a8jGFjH1vJn6M7JGrRTosTH/WjlRB0D2t1lh3WkyzotuUki3F+na1oK8PcGoC
	rTSdVzxa3lS5sqsXGVTmpz0d9/BV4s3J9dZDKSwOGr4ID8B3iff+ZcLCS0HEUVcQNYmkkMvesoG1A
	Mmp7nVl9OC3XKV0J1g9gMpTif82x5UO8+1FydjG6Dh5rL9zmtUI744osZcDHh6bQ5C7Qop4oQMlWh
	t5y4dSdMSzfq4rG0kQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tcqUX-00CWoz-23;
	Tue, 28 Jan 2025 18:39:17 +0000
Date: Tue, 28 Jan 2025 18:39:17 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] wifi: mac80211: Deadcode cleanup
Message-ID: <Z5kkVa0pi9_TRsCl@gallifrey>
References: <20241224013257.185742-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241224013257.185742-1-linux@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 18:38:20 up 265 days,  5:52,  1 user,  load average: 0.01, 0.04,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* linux@treblig.org (linux@treblig.org) wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> Hi,
>   This pair of patches removes a bunch of functions that haven't
> been called for more than a few years.
> 
> I suspect I could go further; in particular I wonder
> if
>   ieee80211_debugfs_key_remove_beacon_default()
> and
>   ieee80211_debugfs_key_remove_mgmt_default()
> 
> could go together with a data structure somewhere?
> 
> Also, ieee80211_nan_func_match() was the last use of
> cfg80211_nan_match(); but that would be in a separate area.
> 
> Dave
> 
> Dr. David Alan Gilbert (2):
>   wifi: mac80211: Clean up debugfs_key deadcode
>   wifi: mac80211: Remove unused ieee80211_nan_func_match

Hi,
  I noticed one of these patches (debugfs_key) has landed in 6.14
but the other one I don't think has - any particular reason?

Dave

> 
>  include/net/mac80211.h     | 15 ------------
>  net/mac80211/cfg.c         | 25 --------------------
>  net/mac80211/debugfs_key.c | 47 --------------------------------------
>  net/mac80211/debugfs_key.h | 15 ------------
>  4 files changed, 102 deletions(-)
> 
> -- 
> 2.47.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

