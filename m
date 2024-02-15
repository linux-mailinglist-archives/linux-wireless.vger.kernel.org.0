Return-Path: <linux-wireless+bounces-3649-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14113856E0D
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 20:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5ED01F2530C
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 19:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8171C13A26F;
	Thu, 15 Feb 2024 19:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KFoOLrvN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3551386A2
	for <linux-wireless@vger.kernel.org>; Thu, 15 Feb 2024 19:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708026651; cv=none; b=RPx7oWzzFYZKsNCUQN3HPGS48zcPeOJOx2RSLZfsNhefODSRUEu7LZqYCjoCR0BmiK+8TYq56OcZteGxPAfhMYbT9Fxf7zIMGtLWWnoUZta0V5/PFLbaFgWd7os8knyupcbc3pxduds2cHbMs3bsPWwHOBOKop7QUy651wjPwk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708026651; c=relaxed/simple;
	bh=hHdu7OlzyKH4Tc9mHiGs3/d9CxRfgSpyLGJcWfOv208=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dIy9Db9KMrk277I/SuSbKUM5Rqc2SsmiWJAKqnt7uh+Utzgafit2yOQKZ+fXspor5uUyw3zY/UgblClPSlahEGen+lZMzKdNd9ebZ47sq1u4eLQsqBLdIDYInfPONcbrHg2qtTxXHBW5hJSMl+BS/vHWj9JPjITapk4pb3asisQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=KFoOLrvN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=omfmFf5N/fVeMMzsUtMKrFOC0lxLIobeuZMgLIOamh4=;
	t=1708026649; x=1709236249; b=KFoOLrvNjFAubCyuJ8c9Yzx8/moGKJ7Dg/oi5wz1CAkRwGp
	5PGdg1gwzRX0h7I7D+ZiGZPfBIcyR9fi59F/BwUtIG3ZzO/wGJvxa/yMY2+JXwuhpnHOUmFMJVu0x
	utlk4wzdGe0o3J/+8ujXEWHi/XeAxtgZUDTOHiJlXN9cVcdsXnFdOb+mZ2Z0928IJaH1sPXOdLNIh
	6ZiHk5Wvrh7KFfLz13XitDnghIWMBmZhJlfyKZdF2l1b7wEyB2EgkkRimaIEx6zqUtlTbTZeR6jFA
	lEIXSnuewFJgUngZ4mecl/4uZzg1hAiqgWtdM1km8TJJt2Q2bBoDQ2T9+L2I7zfg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rahks-0000000BCic-07YW;
	Thu, 15 Feb 2024 20:50:46 +0100
Message-ID: <de92380b3ec6d4e6bf854479fb3eca5ae88cf1fc.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] wifi: mac80211_hwsim: add support for
 switch_vif_chanctx callback
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 15 Feb 2024 20:50:45 +0100
In-Reply-To: <20240215162811.506065-3-quic_adisi@quicinc.com>
References: <20240215162811.506065-1-quic_adisi@quicinc.com>
	 <20240215162811.506065-3-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-02-15 at 21:58 +0530, Aditya Kumar Singh wrote:=20
> +static int mac80211_hwsim_switch_vif_chanctx(struct ieee80211_hw *hw,
> +					     struct ieee80211_vif_chanctx_switch *vifs,
> +					     int n_vifs,
> +					     enum ieee80211_chanctx_switch_mode mode)
> +{
> +	int i;
> +
> +	if (n_vifs <=3D 0)
> +		return -EINVAL;
> +
> +	wiphy_dbg(hw->wiphy,
> +		  "switch vif channel context mode: %u\n", mode);
> +
> +	for (i =3D 0; i < n_vifs; i++) {
> +		hwsim_check_chanctx_magic(vifs[i].old_ctx);
> +		wiphy_dbg(hw->wiphy,
> +			  "switch vif channel context: %d MHz/width: %d/cfreqs:%d/%d MHz -> %=
d MHz/width: %d/cfreqs:%d/%d MHz\n",
> +			  vifs[i].old_ctx->def.chan->center_freq,
> +			  vifs[i].old_ctx->def.width,
> +			  vifs[i].old_ctx->def.center_freq1,
> +			  vifs[i].old_ctx->def.center_freq2,
> +			  vifs[i].new_ctx->def.chan->center_freq,
> +			  vifs[i].new_ctx->def.width,
> +			  vifs[i].new_ctx->def.center_freq1,
> +			  vifs[i].new_ctx->def.center_freq2);
> +		hwsim_set_chanctx_magic(vifs[i].new_ctx);


hwsim_set_chanctx_magic() is only partially correct, I think, this
depends on the mode? For CHANCTX_SWMODE_REASSIGN_VIF the chanctx should
already exist as well, so should also be hwsim_check_chanctx_magic() in
that case?

johannes


