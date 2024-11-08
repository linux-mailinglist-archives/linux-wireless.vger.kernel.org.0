Return-Path: <linux-wireless+bounces-15129-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CE09C173F
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 08:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ADCA28234A
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 07:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A4F198E77;
	Fri,  8 Nov 2024 07:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wFgFpC+3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2941D0B95;
	Fri,  8 Nov 2024 07:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731052053; cv=none; b=MVb05yL4omC4/NxmgB7pr3xHFk8fFXosTh2+gPD584Dq8ltLe/cHtpRNCEPSQqroFuqCh0nUw3Oj/teC8kPwkOtkt6CE4h3Wr2Capx3OelWGFMXO0xNw1LnRa8Y3hbOFqSx+eCXG9rp333S5OPpJPhcq+xMSMaI4d2vg056eyzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731052053; c=relaxed/simple;
	bh=63fu+464D88RugFCsPoJIgQ+Ab6ec6R0Bl1wvlAagpI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bC5sUTMiJtQdWs02/vAGBYWbA1Sc6cbNOizKuoR2lNJ0m5l4HwyY5EiOkqK2uiiCD/PHJjBJ5PiqVglfRjLXQOzQsdbu+z2qcsPfgKpZaYYGrtfnsDUHZS3lLcYt/CWnzaJbowqPvUX+6JbUGibIVINhbVDaCjfnq36JV1eK/GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=wFgFpC+3; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=WiFklo506WlqFe1ItUiK5ljV3z6Butg5HtIPyT60Boo=;
	t=1731052052; x=1732261652; b=wFgFpC+3wtyjm/cTjFdq7shz8lzfdwiR9WPDafVYyH1/y+i
	puSByVLBBc/wwWpy2DtCuizzy1U/UkNUk903NoUW4Z9ed6mJ5ugTyQfs9ut64gxjAEfI/4Oay+HCY
	qJ6GMnCI79m7sWMskoury1Yow52fIu5nKfO1WE5MjXxSfOEVWROis3b5WBDZJ8hN9rIbcCYYh1MfM
	wetHx9mwqtEMJiKYmu+wsjy2mCXBcq2lRrmZMO5P+gGt4db8J36OHjAVFCUy9acB/JmqAue6Vp8jC
	YbgVLxcxSgYlDuhIpaKvs2PQ0W03pYE2cO7weW0JJtch5Cg/EyTZr5flfzKPlDWQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t9JiL-0000000HA4d-24rN;
	Fri, 08 Nov 2024 08:47:29 +0100
Message-ID: <f1a0801e4ce55cdccfa809a6e49d839aabf1a0ae.camel@sipsolutions.net>
Subject: Re: [PATCH v2] net: rfkill: gpio: Add check for clk_enable()
From: Johannes Berg <johannes@sipsolutions.net>
To: Mingwei Zheng <zmw12306@gmail.com>
Cc: linville@tuxdriver.com, rklein@nvidia.com,
 linux-wireless@vger.kernel.org,  linux-kernel@vger.kernel.org, Jiasheng
 Jiang <jiashengjiangcool@gmail.com>
Date: Fri, 08 Nov 2024 08:47:28 +0100
In-Reply-To: <20241107222043.1414437-1-zmw12306@gmail.com>
References: <20241107222043.1414437-1-zmw12306@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-11-07 at 17:20 -0500, Mingwei Zheng wrote:
> Add check for the return value of clk_enable() to catch the potential
> error.

Wait ... is someone running an experiment again? ;-)
>=20
> diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
> index c268c2b011f4..a87bb99231a6 100644
> --- a/net/rfkill/rfkill-gpio.c
> +++ b/net/rfkill/rfkill-gpio.c
> @@ -31,9 +31,13 @@ struct rfkill_gpio_data {
>  static int rfkill_gpio_set_power(void *data, bool blocked)
>  {
>  	struct rfkill_gpio_data *rfkill =3D data;
> +	int ret;

You could move that into the if.

> -	if (!blocked && !IS_ERR(rfkill->clk) && !rfkill->clk_enabled)
> -		clk_enable(rfkill->clk);
> +	if (!blocked && !IS_ERR(rfkill->clk) && !rfkill->clk_enabled) {
> +		ret =3D clk_enable(rfkill->clk);
> +		if (!ret)
> +			return ret;
> +	}
>=20

but this is obviously wrong anyway.

johannes

