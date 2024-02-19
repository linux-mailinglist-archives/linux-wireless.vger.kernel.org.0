Return-Path: <linux-wireless+bounces-3792-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CD885AAEE
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Feb 2024 19:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED8F11F210E8
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Feb 2024 18:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C87A44C88;
	Mon, 19 Feb 2024 18:26:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6762D446A1
	for <linux-wireless@vger.kernel.org>; Mon, 19 Feb 2024 18:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708367176; cv=none; b=KxoCggvw3FCXw78sDO2sLfPrg6yXA5fbvS6q42Qu5Z9Z4ZbZzKsTIK5PduOtGLHwWPRwiu5ui33nhSA5NOoAHkdVdfTA760NyynjqRifFGC+EllZB8wxUEjICo7ujDKLJsbUZGw7lACXaQtVSGIHI6z2uaV6x1IyE5PVf1kpHZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708367176; c=relaxed/simple;
	bh=Iy6zVhsNRhQZjW6knEl5S24urcJnl5tZ43JjPWpUb+0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbHNoI6XKZK/5ZnF9HRYpZLIbTRHc08yRHP9FwXi5WfQCfuuQwhY7QR+y1rs2DIGZINw/EIq/6CVMisVHTfIDeXJkkcVh6tpyYtMuyF11JVL9k+jZcc0IcS7EP+9raQ1Zv8/dWi5KpM/nSs74TxE/5ZKVv6eaYjHMWp2aJ/Kpu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 340bcc1e-cf54-11ee-b3cf-005056bd6ce9;
	Mon, 19 Feb 2024 20:25:05 +0200 (EET)
From: andy.shevchenko@gmail.com
Date: Mon, 19 Feb 2024 20:25:05 +0200
To: Alexey Berezhok <a@bayrepo.ru>
Cc: Arend van Spriel <aspriel@gmail.com>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] wifi: brcmfmac: do not cast hidden SSID attribute value
 to boolean
Message-ID: <ZdOdARuxnN5B0zdS@surfacebook.localdomain>
References: <20240208085121.2430-1-a@bayrepo.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208085121.2430-1-a@bayrepo.ru>

Thu, Feb 08, 2024 at 11:51:21AM +0300, Alexey Berezhok kirjoitti:

...

> -				 settings->hidden_ssid ?
> +				 (settings->hidden_ssid != NL80211_HIDDEN_SSID_NOT_IN_USE) ?
>  				 "enabled" : "disabled",

Can somebody switch this to use str_enabled_disabled() from string_choices.h?
Ideally, add str_disabled_enabled() in that header (as macro with negation on
its argument) and use here as

	str_disabled_enabled(settings->hidden_ssid == NL80211_HIDDEN_SSID_NOT_IN_USE)

-- 
With Best Regards,
Andy Shevchenko



