Return-Path: <linux-wireless+bounces-1267-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0008381D4ED
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Dec 2023 17:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CFC51C21109
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Dec 2023 16:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF1F10958;
	Sat, 23 Dec 2023 16:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w1.fi header.i=@w1.fi header.b="Z9ybt5KK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.w1.fi (mail.w1.fi [212.71.239.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7051094E
	for <linux-wireless@vger.kernel.org>; Sat, 23 Dec 2023 16:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=w1.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w1.fi
Received: from localhost (localhost [127.0.0.1])
	by mail.w1.fi (Postfix) with ESMTP id 1C8A711664;
	Sat, 23 Dec 2023 16:02:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from mail.w1.fi ([127.0.0.1])
	by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Akm_sSP3l6ob; Sat, 23 Dec 2023 16:01:38 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Sat, 23 Dec 2023 18:01:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=w1.fi; s=default;
	t=1703347298; bh=4aSWUjx06gmC5HXE41ceYZVLlZYn/WDmPgA8VfwzTe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z9ybt5KKBQCIMSRaCyriJ4P3Dlf3NbWrVyngnKWDxWNb769dMynHEO/OffHyRpClQ
	 aSyLw8At2vVIYiW5UzU+lIaudFZwvG2en17GVhpo4VjwroLtuvhe1b/nspvZzUjsFh
	 5w9NqxwBT1DNUNuoYJe+QSWJ+AL6j4PN1ujMUtWh5g365Ia0grGsxuvBF9TFSMVvNC
	 3juXjNi68Ud01evCPxTD5sL0UCsTBMkOLv3XigMlgdg+EeG016LFNVWKzgsXXDbVpt
	 POP/hXJx45SfaHiqx8O8ZhxMVIE+JaFdX6nF8hGQeAMxcybU0gpS5vtdFmV9n0WpYL
	 2Qi5jf2+uEjjQ==
Date: Sat, 23 Dec 2023 18:01:36 +0200
From: Jouni Malinen <j@w1.fi>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH 15/15] wifi: mac80211_hwsim: support HE 40MHz in 2.4Ghz
 band
Message-ID: <ZYcEYIauIJAz0q2q@w1.fi>
References: <20231220023803.2901117-1-miriam.rachel.korenblit@intel.com>
 <20231220043149.56bf8f5cd373.I1ba6905c806be6e0548ed15130c0bbb2ee04c9fd@changeid>
 <19b41966397952fc18cb90346550eb3f2f03711c.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19b41966397952fc18cb90346550eb3f2f03711c.camel@sipsolutions.net>

On Tue, Dec 19, 2023 at 09:57:52AM +0100, Johannes Berg wrote:
> On Wed, 2023-12-20 at 04:38 +0200, Miri Korenblit wrote:
> > We are missing the flag that indicates that capability
> > of 40MHz bandwidth support in HE on the LB.
> > Add it.

> Jouni, I had basically the same patch and I'm going to apply it...
> 
> However, it breaks two tests in hostap - according to my earlier
> analysis, this is because throughput estimation for HE/EHT doesn't take
> the AP *operation* into account, only the *capabilities*.

That's now fixed in hostap.git.

-- 
Jouni Malinen                                            PGP id EFC895FA

