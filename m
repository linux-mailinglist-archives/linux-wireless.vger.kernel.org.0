Return-Path: <linux-wireless+bounces-12374-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E8F9696F4
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 10:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C2BB1C23339
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 08:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645F4201246;
	Tue,  3 Sep 2024 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXnycKJE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6621A3AB6
	for <linux-wireless@vger.kernel.org>; Tue,  3 Sep 2024 08:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725351962; cv=none; b=J/a6OKOCdnEjnj7k7Sfw0jIYsIAO+xp+VtIvqn83BFbgkgXQHr3wUOuRfrSlHzKPxGKpIJXTyiroTO8OcoBwqmw+rts4v3+qh/tloAiPTl8vXSrq3WxoSJ7JC8a2BOor/eVQ+5zJ/1F9BfHiGV24hBu8IfAfQkF6oafuRVvRu6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725351962; c=relaxed/simple;
	bh=vYhs8/OhOST+Ytk+PH5Ou11+qXdhvbZsTmHgou6PRrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nt0pQhFJ77kDs0cO7M/h3Qx1KZL8GeiPmpw0/LHtSW1PoNq/z4taB8Wjw/Wrk0CfVI/2+aWh1QKuloHHeFjaPSnItlpggtUQTMm8yQwVcT/WfJk3Oou0TnbHzLUjkswk9IlfW/mq0RfWEB3COJD0NsQGqQo2npHPn7MTfyo8v0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXnycKJE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1715FC4CEC4;
	Tue,  3 Sep 2024 08:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725351961;
	bh=vYhs8/OhOST+Ytk+PH5Ou11+qXdhvbZsTmHgou6PRrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qXnycKJE3BOxa230PbKNP6TiCssUFn5Wje/hbbrdhpAnfKNlMQGCYHrm6ev83nTh8
	 FffEIL4d/aIUNayPCUxFXtjER70ZGkcdBxLwBRR5ftAA771fZUMxa/F6wH4CtDM6MF
	 6RQhyTSKWzqgAOFFsW9xXu+GmUe8PV7IyxZyv899NWWJc8ljs9NtNqm5pyBRguJt7/
	 BCbKeMIMOYOOKiYBtzBETZaDZ1sIiWgcu9OkCjmC1jaPhdFAd24tfFApcRV41VFPwg
	 NTYEfat19SuRlXju87PIyDWUsji46ZPeHeLXybeWpq3G/Di3z2nFkN/z2LdIwuR21K
	 oE2J1Uk0QW2NQ==
Date: Tue, 3 Sep 2024 09:25:58 +0100
From: Simon Horman <horms@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: cfg80211: wext: Correct spelling in iw_handler.h
Message-ID: <20240903082558.GQ23170@kernel.org>
References: <20240829-wifi-spell-v1-1-e0a8855482a9@kernel.org>
 <dd8cac71a80e70352f4ce4c4da426721e02ff31d.camel@sipsolutions.net>
 <20240902090104.GA77312@kernel.org>
 <edb3a22af9246ad6b6d71d53844bf76249c77e13.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edb3a22af9246ad6b6d71d53844bf76249c77e13.camel@sipsolutions.net>

On Mon, Sep 02, 2024 at 11:11:11AM +0200, Johannes Berg wrote:
> On Mon, 2024-09-02 at 10:01 +0100, Simon Horman wrote:
> > > But is it worth it at all? This stuff is totally on the way out, so all
> > > the thing about "proven a reasonably good design", well, didn't really
> > > pan out in practice...
> > 
> > I think if the text is there it may as well be correct.
> > But if you prefer to leave it as is, then we can drop this topic.
> 
> Sure, that's fair, I'm happy to apply patches updating the
> grammar/spelling by itself. No need to go into full rewrite and/or
> historic debates about the design :)

Thanks, I agree.

I have sent a v2, which addresses the grammar issue that you flagged.

https://lore.kernel.org/linux-wireless/20240903-wifi-spell-v2-1-bfcf7062face@kernel.org/

I did look for other grammar issues on other lines that are already
updated by that patch: you can get a laugh when you find something obvious.

I didn't check any further, because this seems to be enough for now.
But I can if you like.

