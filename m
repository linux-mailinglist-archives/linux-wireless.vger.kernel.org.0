Return-Path: <linux-wireless+bounces-10272-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F4293326E
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 21:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22EFF284504
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 19:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3159028DBC;
	Tue, 16 Jul 2024 19:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="kNAdxhKk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7974687;
	Tue, 16 Jul 2024 19:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721159324; cv=none; b=Lwcu8j5eg26sRdEVi5UjdvUfAi5NogcnqzXcz7S0N9lFe23cLGiCy3Km5R5sN40CZzT6cxMfsh87EgkHapIaLbxalpvtyKiMmL0/6e6L3aiEDkJ/2rO0mDn9lBtc36Ujkir0VYwb7jRFnUayE76CHnqEKDbVRJnSIP/Uxx3sHEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721159324; c=relaxed/simple;
	bh=t3i7yfUr2w9A5d5JntbrVsSz//wQTaiJNLdd/BFSQ8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ld0dTuLk3MO6oUrPL9kI9CgTGxEH5kE5nAEkmM2lLDq8WvOF+u+/WBOk3jG2ouDQ/LEeaUeakm8IclIwOffXKPpvISSGhj9j5ioMcfmhUSLdotlQRFD83f8z0piKvJD1pZV1TRqOdw5kdrfWZTL+m8/HqJRZoeUS6s90CDUYAr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=kNAdxhKk; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id ABD5A1F928;
	Tue, 16 Jul 2024 21:48:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1721159310;
	bh=iHYlz9NHx4kfSmQ9PINkG/GsErrITvDylGCTitXZnnk=; h=From:To:Subject;
	b=kNAdxhKkDPIhh15IyeNbijP/OubamWCTmdTPau3bAxQBoJWQMQR5gtyl4MYuEEfL8
	 WjIqvNCBaRMehJ+q1eKRU5CoCBdWe+4MYmlNARN9in5gv68YWl5D4wz7PGzplbNeOs
	 /rf8cpbFEvQqKPAx2+q51dRtvaiddodp/q9KWgBA+hAVkRTTQC0AW8UekNqEwmLUnI
	 3zt/LGXgAxkGU5nx0iHbEUCRrkZ/r3qoZdBKu9TX5IYxwc58Dfo8tpoZt7dnkNzAsW
	 yu1NcRAIw4FCrAo3GUGVk9BrG6LJ5sMNlDIHWvnTZUHrcBp9tjBLgR05o0vcuFjDeQ
	 qkF2rIAvJ8BHg==
Date: Tue, 16 Jul 2024 21:48:26 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] wifi: mwifiex: simplify WPA flags setting
Message-ID: <20240716194826.GA85916@francesco-nb>
References: <20240716-mwifiex-wpa-psk-sha256-v1-0-05ae70f37bb3@pengutronix.de>
 <20240716-mwifiex-wpa-psk-sha256-v1-1-05ae70f37bb3@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716-mwifiex-wpa-psk-sha256-v1-1-05ae70f37bb3@pengutronix.de>

Hello Sasha,
thanks for your patch.

On Tue, Jul 16, 2024 at 01:33:27PM +0200, Sascha Hauer wrote:
> The WPA flags setting only depends on the wpa_versions bitfield and not
> on the AKM suite, so move it out of the switch/case to simplify the code
> a bit. No functional change intended.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

> ---
>  drivers/net/wireless/marvell/mwifiex/uap_cmd.c | 27 +++++++-------------------
>  1 file changed, 7 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> index 491e366119096..8d0cd84d27698 100644
> --- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> +++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> @@ -46,31 +46,18 @@ int mwifiex_set_secure_params(struct mwifiex_private *priv,
>  
>  	bss_config->key_mgmt_operation |= KEY_MGMT_ON_HOST;
>  
> +	if (params->crypto.wpa_versions & NL80211_WPA_VERSION_1)
> +		bss_config->protocol = PROTOCOL_WPA;
> +	if (params->crypto.wpa_versions & NL80211_WPA_VERSION_2)
> +		bss_config->protocol |= PROTOCOL_WPA2;
> +

I am wondering what happens if NL80211_WPA_VERSION_1 is not set, no idea
what's the content of bss_config->protocol ...

in any case this is not something that you introduced, but maybe worth
having a look?

Francesco


