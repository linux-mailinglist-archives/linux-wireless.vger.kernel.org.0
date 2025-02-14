Return-Path: <linux-wireless+bounces-18960-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A66A366FE
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2025 21:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A8B3AAAF5
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2025 20:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312831C84B2;
	Fri, 14 Feb 2025 20:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="Y/SKfPqo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A763C19F495
	for <linux-wireless@vger.kernel.org>; Fri, 14 Feb 2025 20:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739565471; cv=none; b=Xhm53PcFDnHvXJFLd0dhsBYyUzIAEGdic5y50RFx8siTUXeZg/JqMx7V1pnAh5hwxOWajOUWg9smih8yG+yuL13bJsagaFgW/3sqy2YJZQ8TPr1HBbFibWE/S+uyWw5U5vBDtbZpkyswOqRRZ/59Pl5Sb4cPZdbtbU86vE2ZLvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739565471; c=relaxed/simple;
	bh=ngfqkQReuiFrsG6yczX+2j6vRmH0mCMi1vIyPvyVKiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFYEWl7Wq4CY+E0YRM3YolXBa+5HgBE2b59ygoqMpaoFRNxXom7JEslxHps7kpcg+YkaFic2nIduZ0fqJgFp34QK3zG2PrVptMdQTh2r29NWk45Ny+E1yAXCEQwBxPHiByL6+xs91xCuEGt981XmZHwiLxT27b2/u39SEcd+Bpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=Y/SKfPqo; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.7])
	by mail.ispras.ru (Postfix) with ESMTPSA id E2BD9413356F;
	Fri, 14 Feb 2025 20:37:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru E2BD9413356F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1739565464;
	bh=+lgE+p7O2TIVNUIcKIbuwubFpfVHGvY+FypqDdlfZb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y/SKfPqop1QsjxVa1QS31hk+hbNmy11zYxyo5lB9xDKpxFT8fwo6Yt26biRsesXCt
	 Yrj++Qq9O7IfNbLgkV9OVjV013IgyLsvRxmXdiW8+bjp5JF0O4FOXXf4FjnNOUHv5I
	 IJ9q9aEUa40rmA5WTX0UGAPgr8T73EgeGgZ//UR0=
Date: Fri, 14 Feb 2025 23:37:44 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Alexander Wetzel <alexander@wetzel-home.de>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
	linux-wireless@vger.kernel.org, Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>
Subject: Re: [PATCH 1/2] wifi: nl80211/cfg80211: Stop supporting cooked
 monitor
Message-ID: <zcbezrvgixk2xzjrnduc7hohjo5cs5vzqfecc66pxt7bm5hsjy@5cm3ozb3henb>
References: <rk6oogifmfbtboifgyzluw7cu2t6i3xdtf7qtrt2suil7t7nay@binkah2qe22o>
 <8484dcdf-d3b1-4d36-8b56-6d4f381bda53@wetzel-home.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8484dcdf-d3b1-4d36-8b56-6d4f381bda53@wetzel-home.de>

On Fri, 07. Feb 13:27, Alexander Wetzel wrote:
> On 07.02.25 11:37, Fedor Pchelkin wrote:
> > Alexander Wetzel wrote:
> > > I first tried to just refuse setting the flag in mac80211, but that
> > > triggered a warning in nl80211 when rdev_add_virtual_intf() got the
> > > error after green-lightening the flags in nl80211_parse_mon_options().
> > > 
> > > So we could add some code in nl80211 suppressing the warning when
> > > MONITOR_FLAG_COOK_FRAMES is set. That would open up drivers to refuse
> > > cooperation when someone tries to use the flag.
> > 
> > Is that the same WARNING which is being fixed at [1] or something new?
> > 
> 
> While the patch here also kind of solves the issue from [1] it's unrelated.
> The warning I mentioned above was a different one. But since it was caused
> by experimental code never published noting I would call "new".
> 
> I tried to explain that mac80211 - or any other driver using nl80211 - can't
> refuse the cooked monitor flag with the current API to explain the brutal
> handling of that in the patch here.
> (The flag check should be handled within nl80211_parse_mon_options(). But
> since the drivers have no way to signal cooked monitor support it can't be
> checked there by any reasonable means.)
> 
> Here the WARN() my patch triggered:
> 
>         wdev = rdev_add_virtual_intf(rdev,
>                              nla_data(info->attrs[NL80211_ATTR_IFNAME]),
>                                 NET_NAME_USER, type, &params);
>         if (WARN_ON(!wdev)) {
>                 nlmsg_free(msg);
>                 return -EPROTO;
> 
> My not published patch refused the flag when rdev_add_virtual_intf() was
> creating the interface with the flag.
> 
> With the feedback from Johannes - that only mac80211 ever used cooked
> monitor mode - the current patch seems to be the preferred way and we don't
> have to find a better - and for sure ugly - way to handle that.
> 
> 
> > FWIW, I think the current series would not go to the stable trees (at
> > least there are no Fixes ot Cc: stable tags), while [1] should go there
> > to suppress the currently observed and triggerable WARNING regarding
> > setting the outdated cooked monitor mode mixed with some other modes.
> > 
> 
> I also would not like to drop cooked monitor support for any stable kernel.
> While that would fix some monitor handling issues I see no real need to even
> fix these in the stable series.
> Messung up virtual monitor interfaces by a special order creating them or
> using suspend/resume is hardly something the users of them will care about.
> Or they would have told us that long ago:-)

Okay, thanks for clarifying!

