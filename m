Return-Path: <linux-wireless+bounces-4754-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1DB87C0FE
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 17:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A36961C20E39
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 16:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC3A73519;
	Thu, 14 Mar 2024 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="f/kfEov/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3466F08A
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710432597; cv=none; b=VfL55cgxNiwleh5olwF2fW8apkKex9nydJXTewBhIK3Fy01PzASMw9DUJACz3RJiQfEFAZHLcZ4W9LWyPfdewfsbSBbXukstIaJfAoCiLz+lH109dkP8/uJZR/VEm5GWYND3f3vLNnU929qo00KtyxD6EK2qpJHzZbORiIldsfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710432597; c=relaxed/simple;
	bh=zUhPnLGlLQi8OdnDxM8fqhhnarnKvJKptexpwBzEikc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QbYvpx41ucsRslde8BHflDBnTgB8BWbxm6RhXnpEZZymIpXyQ0Pezubni1Ewc6RWWYarNdB/650F7UCO+UbrQhO1JJM8jlYozURx+fX6gNmeUQkOE7ySnJW2VPXguW3gGmb9Q9BaS+JYUYcncL1IS3fj1Amlkk72ge9dJKUA78I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=f/kfEov/; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=gWxK1Vzs86qnKkeML5I8G6bTPpScPlroQ1LbCo3NbEQ=;
	t=1710432594; x=1711642194; b=f/kfEov/+iYCcepQqgncdvhBHo/bkdxbFwmxUyjJ1YJnnO2
	nUuTUPMjYjqdNkbAUKYIGWgzK5eEvorVWsvZ8+rlllICnNmjRSb0BBT16tG5HIu+ovN9wxQIODSVG
	c7yg7h1WuKk/99Twwb2DFPggc/RbVwZ8SEDlS66kVty9hXKtpMvTFUGzHUEZYxdhliQjx+V/cRX4t
	cBy2I71yIqXEe5ngwoeAxg3WtTc7y5P0g/FFgyxDRZPSiasQYexbB3hdj1cfjPDfsQgT6K8Ed9HWR
	MJ+qMiB3o3pW96dFuxxCuLuheuqQz7kWpQp5wpE9VTj6wFVRI1Lg+/J78QBa2pfg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rkneO-0000000GfOL-3vhE;
	Thu, 14 Mar 2024 17:09:49 +0100
Message-ID: <09ca997159333980a168051a2a49c675a8ad5eeb.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] wifi: iwlwifi: mvm: disable MLO for the time being
From: Johannes Berg <johannes@sipsolutions.net>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, Miri Korenblit
	 <miriam.rachel.korenblit@intel.com>, ath12k@lists.infradead.org
Date: Thu, 14 Mar 2024 17:09:47 +0100
In-Reply-To: <87bk7g4x08.fsf@kernel.org>
References: 
	<20240314110951.b50f1dc4ec21.I656ddd8178eedb49dc5c6c0e70f8ce5807afb54f@changeid>
	 <20240314110951.d6ad146df98d.I47127e4fdbdef89e4ccf7483641570ee7871d4e6@changeid>
	 <87bk7g4x08.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-03-14 at 18:08 +0200, Kalle Valo wrote:
>=20
> > -		hw->wiphy->flags |=3D WIPHY_FLAG_SUPPORTS_MLO;
> > +		hw->wiphy->flags |=3D WIPHY_FLAG_DISABLE_WEXT;
>=20
> I think we should add the same for ath12k, right?
>=20

It's really up to you, I think. I'm hoping to even get this into stable,
FWIW.

The biggest issue here was our firmware, but the stack is also missing
some things, e.g. we see CQM problems (warnings?) if you actually use
multi-link "in the real world".

johannes

