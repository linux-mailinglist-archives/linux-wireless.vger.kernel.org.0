Return-Path: <linux-wireless+bounces-10609-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8289D93F029
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 10:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED568283461
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 08:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762B013C80F;
	Mon, 29 Jul 2024 08:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="155WS3aF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBA113210D;
	Mon, 29 Jul 2024 08:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722243099; cv=none; b=Pq9X6cq+QIfjBdcV/6edYGshU13rFYEeZjlFxmmOSvj1fGW+Q8Q5CkMRjV/33Im5+SPTvd4FwNV4i+6gCAKBog8r5tlVwiRqlWt7AhwGJZS0E3HMOiLWWwH394w+iz6nXFWZ3h+RlZsC0zScWUsG5tvPbOV5aLnrdc2G5VqXtQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722243099; c=relaxed/simple;
	bh=J0bsix4Qoxdi1CXAtomePnZehGLX5EbMnGJ5fiPl1WI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/DIpl1cFh5LawT9WevmLvLigac0F2eOMQmlxGaUFL+ohPo/UKsD0qxdgttSIjbcQT+0S/ByizwZcLCnngg+ggG5Hzb+4/qU9uuFyp3PTN/Zjr33mDwabss32kQto+1XES5AjbXu+AvX4EDHSKRQltstBxYkuw+lyTwXugljgO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=155WS3aF; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1722242658; bh=J0bsix4Qoxdi1CXAtomePnZehGLX5EbMnGJ5fiPl1WI=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=155WS3aFv6TUpvsEiUAz/lHlTuEuHSFjqqhRPD6fF6uxXUb/HYszg3gCQXwOIwZuY
	 ZRnNNfxRBQnRJN0EZg+A1Q9sZX+u/H234clES5Cq9XjLmR0YozbADzv9ASGUenWBbt
	 QUwbXDDv52YuxsLnFoJV5DqEp/+9mOaW/im7UskI=
Date: Mon, 29 Jul 2024 10:44:12 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Jacobe Zang <jacobe.zang@wesion.com>, robh@kernel.org, 
	krzk+dt@kernel.org, heiko@sntech.de, kvalo@kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, conor+dt@kernel.org, 
	arend.vanspriel@broadcom.com, efectn@protonmail.com, jagan@edgeble.ai, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, arend@broadcom.com, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, duoming@zju.edu.cn, bhelgaas@google.com, 
	minipli@grsecurity.net, brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	nick@khadas.com
Subject: Re: [PATCH v4 4/5] wifi: brcmfmac: Add optional lpo clock enable
 support
Message-ID: <qetrwlvqekobedpwexeltaxqpnemenlfhky2t2razmcdtwlcv3@qdlesuiac2mr>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Dragan Simic <dsimic@manjaro.org>, Jacobe Zang <jacobe.zang@wesion.com>, robh@kernel.org, 
	krzk+dt@kernel.org, heiko@sntech.de, kvalo@kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, conor+dt@kernel.org, 
	arend.vanspriel@broadcom.com, efectn@protonmail.com, jagan@edgeble.ai, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, arend@broadcom.com, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, duoming@zju.edu.cn, bhelgaas@google.com, 
	minipli@grsecurity.net, brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	nick@khadas.com
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240729070102.3770318-1-jacobe.zang@wesion.com>
 <20240729070102.3770318-5-jacobe.zang@wesion.com>
 <d7068c96e102eaf6c35a77eb76cd067d@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7068c96e102eaf6c35a77eb76cd067d@manjaro.org>

On Mon, Jul 29, 2024 at 09:12:20AM GMT, Dragan Simic wrote:
> Hello Jacobe,
> 
> [...]
>
> > 
> > +	clk = devm_clk_get_optional_enabled(dev, "lpo");
> > +	if (IS_ERR(clk))
> > +	if (clk) {
> 
> These two lines looks really confusing.  Shouldn't it be just a single
> "if (!IS_ERR(clk)) {" line instead?

It should be `!IS_ERR(clk) && clk` otherwise the debug message will be
incorrect.

Kind regards,
	o.

> > +		brcmf_dbg(INFO, "enabling 32kHz clock\n");
> > +		clk_set_rate(clk, 32768);
> > +	}
> > +
> >  	if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
> >  		return;

