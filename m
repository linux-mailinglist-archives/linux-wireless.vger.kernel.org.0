Return-Path: <linux-wireless+bounces-18092-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F0CA212C3
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 20:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4365B1889FF9
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 19:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134201DFD89;
	Tue, 28 Jan 2025 19:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Q8towS5d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA14199230;
	Tue, 28 Jan 2025 19:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738094017; cv=none; b=BaZMeGyq8hK80wNuoPrO45K83lPo16K4tu0ByGdFRLn33aobMJruEiAUxwntX6+yqjOTlRnXqvLo5rybdWXAE50uiq7VbMrcSJDTuEQ5/SqzJoiOVIWm1t2UD0ijsWS+kGt7iz+nBTudkk17Fx3cagVFKzk5Z0A7bjHH70BBfaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738094017; c=relaxed/simple;
	bh=FJ3GCpXjySOf3YS2uTbxI905OyBIY4EfhHlH+Y833dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCtPhuzU7TI0vimC3jTVNpn+Q2deamdMyu2kvQpr2YFYS+kqShaKJSPaqemLNp+Evf5g0B4OOJk7YB7j6MjT8E+YD9DbIf3phg1gXuEziK/Pun2CEqI6wJDVZ+FmZRcuY1TXupqLm3yzjvXFZG57HxTlogF7+Zolell2Mm9GOJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Q8towS5d; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=5VSBKYidE/C+XNVL5mX4/yQwBaJIOPZw4rgKcyHqhiA=; b=Q8towS5dz0P/FkQR
	beNwi5LTqJn/OG/HZwXtfsiQN4DHfQ1A6vz7+stELx2LEpFiy2REh5U+wpkgJrsDq5wLW+99KkgzX
	VhrjxbXgZJczToYwTAcpcgQHAd2YQINRRfIHQFXW3QqvBNT14duga9A1nEqYmuR543v8dyH9Z2ubS
	2kaAnPSfBYZo+mcf7LfRc4esdYubl/gU1UKYNsBTASCTZ2s7SXfpu8aPlWxZlE7TauZABIjkmnESE
	RBM+erlEn9gwV+M8AF4Z32xXYMOvx5Pch/smZyA3lVAC/6SJJDea7XXJcOCcAE2zKnh4DRZ9OYVT4
	AyJ6XFjPlFxshEJszA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tcreQ-00CXU5-0L;
	Tue, 28 Jan 2025 19:53:34 +0000
Date: Tue, 28 Jan 2025 19:53:34 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] wifi: mac80211: Deadcode cleanup
Message-ID: <Z5k1vnajAeLtsevs@gallifrey>
References: <20241224013257.185742-1-linux@treblig.org>
 <Z5kkVa0pi9_TRsCl@gallifrey>
 <d5ca1cf4593edb1c8ee32f3c2e6fde47dc97cc32.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <d5ca1cf4593edb1c8ee32f3c2e6fde47dc97cc32.camel@sipsolutions.net>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 19:53:23 up 265 days,  7:07,  1 user,  load average: 0.05, 0.02,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Johannes Berg (johannes@sipsolutions.net) wrote:
> On Tue, 2025-01-28 at 18:39 +0000, Dr. David Alan Gilbert wrote:
> > 
> > >   wifi: mac80211: Remove unused ieee80211_nan_func_match
> > 
> > Hi,
> >   I noticed one of these patches (debugfs_key) has landed in 6.14
> > but the other one I don't think has - any particular reason?
> 
> We were still using NAN internally, and there's a chance that it might
> make a comeback, so I was holding off on it for now.

Ah OK.

Thanks!

Dave

> johannes
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

