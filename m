Return-Path: <linux-wireless+bounces-15422-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 890169D032C
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Nov 2024 12:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40CED1F21BFD
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Nov 2024 11:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B044E13A26F;
	Sun, 17 Nov 2024 11:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svn0JYOJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FB211CAF;
	Sun, 17 Nov 2024 11:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731841482; cv=none; b=LCW7X2JtfRXQRFarCeWGcWjMCXAbJJHvMNOc7ey8i2yNskmyq+Xc0vH1X7i66r4huF2tSDHvmDqbxajcIjlCOY5JzNrhsFjgDzfKXgpsl03SR6lj7IwlQZYifxyUsjSXreNXsbLoTro7N9xeGBaDjI1WgT7uJT/viYGkSaEPnp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731841482; c=relaxed/simple;
	bh=5y3Xonm8SonDzHhYw0NA0WJvKXEkcXPSTpV6FxYalyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJ1vFxKnoOe4NZhlqMuSlwOzJDkIgv6mL6ek9BfT02xY5cRVJSi7oGQTOY5t1HQg+dR+ir949vXyd3bzejgcsFLSyTrk9kt9OCG1aeYCn4kUm+Ucg7rfGxtI0THRP5bksrQs2yIb3Cvn7gFkyFEYTlSRVwIPfTHdG5w//LJhbck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svn0JYOJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0EF9C4CECD;
	Sun, 17 Nov 2024 11:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731841482;
	bh=5y3Xonm8SonDzHhYw0NA0WJvKXEkcXPSTpV6FxYalyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=svn0JYOJYF6uwle/RO/O3yzAb0y9lp2dIlpdKIyPe8KHv0lMCilSDsvcbDKtINBvO
	 IJygecQLiO8LcCq5dqPgQme2xATpZo/cHV05WTxhFEAzRFGGBsO61aHNzz110tFYRN
	 /Pay2nWaRYQEGXA0KgRFhrbWdU3X5HPMyJwhXElbMddTPfdPRawPN+SPon1UDyM52X
	 2zd+UhpBhuOtrZbNbaILX4q0Tw2IGDvPH0jDqMg81PO/0HIobvOOuw4m5lySWPrytH
	 N9aO7OeJGIdTZZJUGrb6lsOytI5Hgsm/9rFu8xtyS/Az0h8KpcDavbXWu/itpOMHp6
	 K2iMCOR5oCFSw==
Date: Sun, 17 Nov 2024 03:04:37 -0800
From: Kees Cook <kees@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, benjamin.berg@intel.com,
	dmantipov@yandex.ru, gregory.greenman@intel.com,
	gustavoars@kernel.org, haim.dreyfuss@intel.com,
	johannes.berg@intel.com, kvalo@kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org, luciano.coelho@intel.com,
	miriam.rachel.korenblit@intel.com, shaul.triebitz@intel.com,
	yedidya.ben.shimol@intel.com
Subject: Re: [PATCH] wifi: iwlwifi: mvm: Fix __counted_by usage in
 cfg80211_wowlan_nd_*
Message-ID: <202411170303.1F0B0E2@keescook>
References: <20240619211233.work.355-kees@kernel.org>
 <d9bdb9c1-689e-4b3f-8325-8ee813257d8f@wanadoo.fr>
 <c8404725-e4c4-453b-b72d-19ab0761da70@embeddedor.com>
 <47a71c03-0306-4239-b77c-cb63a1760d19@embeddedor.com>
 <0f7d2d25-5c7c-4a19-8af7-ce38ee630d4d@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f7d2d25-5c7c-4a19-8af7-ce38ee630d4d@wanadoo.fr>

On Thu, Jun 20, 2024 at 08:53:45PM +0200, Christophe JAILLET wrote:
> Le 20/06/2024 à 20:08, Gustavo A. R. Silva a écrit :
> > 
> > 
> > On 6/20/24 12:02, Gustavo A. R. Silva wrote:
> > > 
> > > > My understanding is that 'match', is allocated by :
> > > >      match = kzalloc(struct_size(match, channels, n_channels),
> > > > GFP_KERNEL);
> > > > 
> > > > So match->n_channels is *0* when iwl_mvm_query_set_freqs() is called.
> > > 
> > > n_channels is updated in the line before calling kzalloc():
> > > 
> > > n_channels = iwl_mvm_query_num_match_chans(mvm, d3_data->nd_results, i);
> > > 
> > > match = kzalloc(struct_size(match, channels, n_channels), GFP_KERNEL);
> > 
> > then match->n_channels updated here:
> > 
> >           if (!match)
> >               goto out_report_nd;
> > +        match->n_channels = n_channels;
> 
> Thanks for the explanation.
> This is what I was looking for, and I missed this line.
> 
> Sorry for the noise.

Hi,

This patch is still needed and doesn't appear in -next (nor Linus's
tree). Should I resend it?

Thanks!

-Kees

-- 
Kees Cook

