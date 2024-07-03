Return-Path: <linux-wireless+bounces-9899-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF6792559F
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 10:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F09FE1C239A3
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 08:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDB413B2AC;
	Wed,  3 Jul 2024 08:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="SYuMdEW6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8342913B280;
	Wed,  3 Jul 2024 08:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719996185; cv=none; b=P82ERttiv6gqREzgMLd6qCu6llVS5bqjKYtDRQNdTjVIEEqDzXYPzd/RT85N1mvY7UqU+wmKvO2aNUdShgkFztnaU+sWgDreKq326LMXxmbuD/h0ul26406ipmfNGCsFtF+Y7Obkn9/clsCdCIh7HJ6/BM3Y+1tenmOw9FceDMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719996185; c=relaxed/simple;
	bh=YDMov1GnF1t6MVMA2t1akYEDknyRtdfuqMsB0VF+dqc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K0dl/w8J1UkI7qy7q/4l15ixLotJCM34OBTE7jvCyTunOYQQjIOu/pSAiqBDRXZGmL3pbeUb1RvJHYTvtOZShJ8vKckKThRScpkxWH44nc6yuKso2nBmXBQ5ECstknSy/ruCLGpQEfq7NQ3Bs3hUO1Eh81PQLH0m/8NxxjyGWuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=SYuMdEW6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zxuM9QanmDhNSPOocoYoBHYoz3XPBwKZOslRBIQK/2U=;
	t=1719996181; x=1721205781; b=SYuMdEW6H9mqYcrj0lLcJl8u5a8+Tnso/90iJAg1t4xVh6n
	SWjQ7Y5FVl9h7azlvZEdQtG2n9tMQqtFw02gJyl3p/K4Jq/p4/4lnX7snbee/LT8LU05S8DWbMRHt
	FPzKLqIxgi5iZ7buFFDvDOd5AO8LY3RfdnkqWRmLfJXPtPTBPrqXfTkRX60C1lVsSUQ3eTVfn/8lp
	ZmGb/rBI7SPi16/lrcwFB605IRyEtSGtvWYpslG1uxOW4R+QcfF1AhOGPB5TmTZ/aBpMT3NDR+42e
	i7ZsKr33lPVEHAP9ZC6zh1NqQw2THsleb3mh4964js2Sm6/t6Nv6S+u6h3y7RBfQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sOvZb-00000008NSb-1kAb;
	Wed, 03 Jul 2024 10:42:43 +0200
Message-ID: <c5fdac6f90b7b2191914f632dc89bac8b4701bdc.camel@sipsolutions.net>
Subject: Re: [RESEND][PATCH v1 3/5] thermal: trip: Pass trip pointer to
 .set_trip_temp() thermal zone callback
From: Johannes Berg <johannes@sipsolutions.net>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
 <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>,  Lukasz Luba <lukasz.luba@arm.com>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
 Shawn Guo <shawnguo@kernel.org>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Thara Gopinath <thara.gopinath@gmail.com>, Thierry
 Reding <thierry.reding@gmail.com>,  Jonathan Hunter <jonathanh@nvidia.com>,
 linux-wireless@vger.kernel.org, linux-tegra@vger.kernel.org
Date: Wed, 03 Jul 2024 10:42:41 +0200
In-Reply-To: <8392906.T7Z3S40VBb@rjwysocki.net>
References: <1890956.tdWV9SEqCh@rjwysocki.net>
	 <8392906.T7Z3S40VBb@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

You said in the cover letter this hasn't received much attention ... as
far as I can tell, the only wireless thing is this:

> --- linux-pm.orig/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> +++ linux-pm/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> @@ -638,7 +638,7 @@ out:
>  }
> =20
>  static int iwl_mvm_tzone_set_trip_temp(struct thermal_zone_device *devic=
e,
> -				       int trip, int temp)
> +				       const struct thermal_trip *trip, int temp)
>  {
>  	struct iwl_mvm *mvm =3D thermal_zone_device_priv(device);
>  	int ret;

which I guess looks totally fine :)

johannes


