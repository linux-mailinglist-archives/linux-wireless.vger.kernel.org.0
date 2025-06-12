Return-Path: <linux-wireless+bounces-24080-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF921AD7B5B
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 21:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9047A3A1482
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 19:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B93029B8D0;
	Thu, 12 Jun 2025 19:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="OSrxNYGF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BACA1FECD4;
	Thu, 12 Jun 2025 19:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749757601; cv=none; b=NSilKwkS3amb6wJcAFcwAYhcXsnmLQ00zDpS97ZyEybvUCuyL+8wp18rL/eqF+PbTXmZn93HvmfHSsCyAcxokG0wxEWUmVL25Llxt4Zq8xYVFDTRpix0Dznb3tDEgmskITjfsip/6rqJW/4d/Am4jW0Wq7aD7og6qZNzIsyxGGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749757601; c=relaxed/simple;
	bh=1FtpU2Grhnhto2moIgRqXy/lx63HukdExYfCerXe7Eo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X4QuaCqvwtfnZtyYDQM8aLO8vlSaJGN9NXHha+fN1LTWph2Ms3jSLGhyFH8yolYvL5CZaZx+wR1W6uzpabJBZa3BObDO0Zf612YOAcMzCQMEQgfbgL2gZyXD3DqOoATnzBMOnR96PJXzgiXtGG2RqlRogGq08MTRcrRwlIh+Lu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=OSrxNYGF; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=KfJ2x59PAEG8jFqv9tZY+X4VsuAvd9jUdhKy97ZVsJ8=;
	t=1749757599; x=1750967199; b=OSrxNYGFBiJZYa3AaqTzO7iZqWaxknIUx7NS+Ur+5Rn/bT+
	86J+jz6lVEgoFP8V5NOMtJyd/8p1Lp8q6STQyAMTxSMvKa1sryf0mTeplZrsTewmj8hKmSrZEGxKP
	28Dsd67WY61Z3Y96pNRjCPsbynOHBDgrsIc3Q6LIUm+1c1kgQ0vZTIEQi6RXAz7zw7oR0wAcLoPSp
	rY5Fvot/+S5ArzCYrwGMtPDNJN+wgfHlvke8OSPM0M9D6pfdssIcuqB7hAriuz+E2kt4VeHQhTaVK
	lY+zNOnw04aV6AeJxqZaXZAStDZaqGN1ra/0Oy5RA+zre1WUiUpvT+Ojd7fg9shA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uPnsg-00000004fJz-26jp;
	Thu, 12 Jun 2025 21:46:34 +0200
Message-ID: <5c75d32c9416dc0487f2cbb2b3b6708eec671137.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: iwlwifi: pcie: ensure RX_QUEUE_CB_SIZE fits
 bitfield for gcc-8|9
From: Johannes Berg <johannes@sipsolutions.net>
To: Anders Roxell <anders.roxell@linaro.org>
Cc: miriam.rachel.korenblit@intel.com, dan.carpenter@linaro.org,
 arnd@arndb.de, 	linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linux Kernel Functional Testing	
 <lkft@linaro.org>
Date: Thu, 12 Jun 2025 21:46:33 +0200
In-Reply-To: <aEsrmH7sDVvsmgLs@monster> (sfid-20250612_213349_818508_12002470)
References: <20250612130719.3878754-1-anders.roxell@linaro.org>
	 <d2ea3f77ea2737aafc879f4fc291dee097867b61.camel@sipsolutions.net>
	 <aEsrmH7sDVvsmgLs@monster> (sfid-20250612_213349_818508_12002470)
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
> Would it help if I indent like this?

Yeah, maybe? I actually misread it and thought the & went outside
FIELD_PREP() ...


> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c b/driver=
s/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
> index cb36baac14da..5bb81ed7db79 100644
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
> +				    RX_QUEUE_CB_SIZE(iwl_trans_get_num_rbds(trans)) &
> +				    FIELD_MAX(IWL_CTXT_INFO_RB_CB_SIZE));

Also now that I think more about it, this really just adds the part with
the masking ("& FIELD_MAX()"), is it even necessary to use FIELD_PREP()
rather than u32_encode_bits()?

johannes

