Return-Path: <linux-wireless+bounces-11730-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 987BC95984E
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 12:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 469EA282262
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 10:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD631A7AE4;
	Wed, 21 Aug 2024 08:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="v9g5nAn6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638FA1E1314
	for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2024 08:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724230704; cv=none; b=I8Vp8YGoJX4UrK7/a3nLmXsTkH0vOO49qsjzRm7ax1R2Hfk3ZSYUIG7BEWeJsA1zikEXXHVAzUS0Hgd6kQxyr1Ot4EXoVidBedaFN0sspR3N3rF1X2Q2c7vuqG+CklpfaiKdVbH9AypQhs7fhX0+qomxMmOcA6yjDj8gICTlOWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724230704; c=relaxed/simple;
	bh=f7Ol38vjMlKNq7UlhD71vRMfhrr+bCxF3fhuWZgMVxs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rRvnKBkrUIG+IWmcnKNQSWcrCqUOPG8rFOYtFr6SmUEUh4qj6E5hIPU91+mtoOXM9dibYY7nXi+b/Ay/RNkulBUFWfeqBpfpOC43iHjU5BAPtfLtEiAIxVU/WWAFwswq5wyCuPKF70jP6EZfymsHn+pQiCuIf91GnPijW6Fc8zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=v9g5nAn6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=sN+ijEpyXUpHam5UdCNgHzpGa9+506qMyIl73cXv3eE=;
	t=1724230701; x=1725440301; b=v9g5nAn6Qz/WJt2d4licBN+WjjTEVs9Ep8vl+Jpug9lb1oc
	dnQL76ebsa7VJEswiA3Bozy2iavurpQ/j5hMX5Vf9tIV2SrWFZ9Mflz/dz6ydTkWugMMNk4a1jfbG
	ZddLl9awOGhNMbvWx9R+RbaUBE9SelF+l3mlg+Mz8kb1nxNWeofj9RHlAS9UpPOQBKaDRNyEQtBvI
	Q3sBrgUenZ4ptnF5idC+8B8FizzU950qOojEhb1VIwaYtXzs5YZFSoRRxmmMZ5EKXAC4iEzuCadzX
	+9iCnW/atTf17zWozHqavYbdV5E9Edb10DDB+EMsQbutnybIgEkVaqc72P0L1O/g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sghAM-0000000Acq9-1Ke5;
	Wed, 21 Aug 2024 10:58:06 +0200
Message-ID: <b188dadd82f72a2a8ef98b4d944d2b7fa87eebd6.camel@sipsolutions.net>
Subject: Re: [PATCH RFC v4 2/2] wifi: mac80211: Add support for link
 reconfigure removal
From: Johannes Berg <johannes@sipsolutions.net>
To: Manish Dharanenthiran <quic_mdharane@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 21 Aug 2024 10:58:05 +0200
In-Reply-To: <20240807034521.2091751-3-quic_mdharane@quicinc.com>
References: <20240807034521.2091751-1-quic_mdharane@quicinc.com>
	 <20240807034521.2091751-3-quic_mdharane@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-08-07 at 09:15 +0530, Manish Dharanenthiran wrote:
>=20
> +/* Defines for ML Reconfigure removal offload */

Not really "defines", but whatever? Is there value in this comment
anyway though? Don't see how it adds much.

> +/**
> + * ieee80211_update_link_reconfig_remove_update - Inform userspace about
> + * the removal status of link which is scheduled for removal
> + * @vif: interface in which reconfig removal status is received.
> + * @link_id: Link which is undergoing removal
> + * @tbtt_count: Current tbtt_count to be updated.
> + * @tsf: Beacon's timestamp value
> + * @cmd: Inform started or completed action to userspace
> + *
> + * For description, check cfg80211_link_reconfig_remove_update
> + */
> +int ieee80211_update_link_reconfig_remove_update(struct ieee80211_vif *v=
if,
> +						 unsigned int link_id,
> +						 u32 tbtt_count, u64 tsf,
> +						 enum nl80211_commands cmd);

And anyway this is a trivial wrapper, why not make it so the cfg80211
API takes the wdev, and then just call it directly in the driver with
ieee80211_vif_to_wdev(), or have a trivial inline? No reason to have the
iftype check in mac80211 either, that can be in cfg80211 and/or drivers?

Other than that it looks OK I guess, but I do wonder if you've actually
tested further than that?

It seems to me that ieee80211_del_link_station() is somewhat broken when
you remove the deflink from the STA, since we'll continue using data
from there?

johannes

