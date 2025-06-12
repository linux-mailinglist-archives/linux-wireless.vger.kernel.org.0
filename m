Return-Path: <linux-wireless+bounces-24075-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 253AAAD7615
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 17:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AD983A1D45
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 15:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5C62BD025;
	Thu, 12 Jun 2025 15:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="usjvXQDT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5B62BD013;
	Thu, 12 Jun 2025 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749741693; cv=none; b=OwwxqBr6p04AYp2o3+a4NWQPEOP1OMMtGmHdea6bOiz/5YNC7266P+cGOztUXBuEIsrrNmtyxMg2K9rLqpl/aLO4uhwdW1bZUP5P+wbTGTFTOx3/UlsvIPpamrMJoKECGJGEv7uCaM5mvG9y4CNbZeTL+Jzc6RV/2i8voZb4QAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749741693; c=relaxed/simple;
	bh=AtjIXzmU/hPSXFudbcJBMbJhelEPvlWDR6RKOypa5aU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YjHpWYRnFUGhNGYFgnL6LH4qWuzH6V0uENXYTs6r1d6MJz4J89FE35E0FzATKjiJmw/xXTgxoiN05y2rAeZg0EJhuHd9wU1CO4ufG8sBlJXRhmLvOxBcMM3oDqcPwk8QoZbjzwxEkesgPhDEpT4VEWoSWXR+mo8ea1FXMD6K/QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=usjvXQDT; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7qZn9AIcCZO7vLYhxnQsMtcerHAI9s47qwBN+G1jFsY=;
	t=1749741691; x=1750951291; b=usjvXQDTfoIHHopRLnafUVBixXD259Wky/jOgOgNPxCpyyw
	K/EIBiL4vjWK3DPs0ys8tX38iPkVDYNHle7udOROU6xnQnT/6gaFwmyNZZSzZOIvpbvKGbUOoiJmq
	Gwj08pZnbuwm0N+UhtURbRzmt3hCfcLYDCqh9rTwgngH9nHR8CftSH3C95JLoON1aww6XdMAgUmdK
	SPSZbQ7GcyMehJ2rPd+GdSlsJdezxko18EDMDsYtIwQkof82LIGVGeO1KQPl0JHFjyOnNzTVct08f
	3FMioLvJHbvp9xGgKfaab+kAmRpxCfi7hY0097LEadfn5bLODED/LPEbsT6XsbTg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uPjk3-00000004LTC-2232;
	Thu, 12 Jun 2025 17:21:23 +0200
Message-ID: <d2ea3f77ea2737aafc879f4fc291dee097867b61.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: iwlwifi: pcie: ensure RX_QUEUE_CB_SIZE fits
 bitfield for gcc-8|9
From: Johannes Berg <johannes@sipsolutions.net>
To: Anders Roxell <anders.roxell@linaro.org>, 
	miriam.rachel.korenblit@intel.com
Cc: dan.carpenter@linaro.org, arnd@arndb.de, linux-wireless@vger.kernel.org,
 	linux-kernel@vger.kernel.org, Linux Kernel Functional Testing
 <lkft@linaro.org>
Date: Thu, 12 Jun 2025 17:21:22 +0200
In-Reply-To: <20250612130719.3878754-1-anders.roxell@linaro.org>
References: <20250612130719.3878754-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

>=20
> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c b/driver=
s/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
> index cb36baac14da..1854d071aff2 100644
> --- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
> @@ -204,9 +204,10 @@ int iwl_pcie_ctxt_info_init(struct iwl_trans *trans,
> =20
>  	WARN_ON(RX_QUEUE_CB_SIZE(iwl_trans_get_num_rbds(trans)) > 12);
>  	control_flags =3D IWL_CTXT_INFO_TFD_FORMAT_LONG;
> -	control_flags |=3D
> -		u32_encode_bits(RX_QUEUE_CB_SIZE(iwl_trans_get_num_rbds(trans)),
> -				IWL_CTXT_INFO_RB_CB_SIZE);
> +	/* This should just be u32_encode_bits() but gcc-8 and gcc-9 fail to bu=
ild */
> +	control_flags |=3D FIELD_PREP(IWL_CTXT_INFO_RB_CB_SIZE,
> +		RX_QUEUE_CB_SIZE(iwl_trans_get_num_rbds(trans)) &
> +		FIELD_MAX(IWL_CTXT_INFO_RB_CB_SIZE));
>=20

The coding style is really confusing now though - what are arguments to
the macro and all that.

johannes

