Return-Path: <linux-wireless+bounces-18117-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43357A21846
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 08:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DB343A36A9
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 07:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1487319580F;
	Wed, 29 Jan 2025 07:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="RP1r5Fvs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEB319995D
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 07:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738136290; cv=none; b=R4Upvrc2XvbSf73PjvZsZVOndR2qk3x/LXA3rDRwkkj33WqqjNW7Vvi3vzryNS7b9IYbVtqmCKZAT/Fycx6uDLUEUN56vZhQ9A2irw6FGZs08GtqYoDjtNuyYu5T7T1Qtq4ty8FYPVSPe52tL1wOKnczI1ebJ3nW5vtbSdxOhtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738136290; c=relaxed/simple;
	bh=DSWyGgX4F1IDGaiWdBWp8mX0CTcy1ukG2o9LJ9RJzro=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s3df8qG8s8/YIIHbbrsp8ojnF4iOlfnbQVfZYxfUUJ7Wcc0oESQWHR/ej6MuR1CxvkK0FbUm1UEowv7FeBhae82v76cKp3kFMPZxzRlnZLji64kTNCydic0E5c724GQXz8jQqv4prtJ8dppVRnP7ge1z+kzN+Z2U2MH8yXfHYfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=RP1r5Fvs; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=pJmfa1UDdJnEvvRMi3rOAWHFTTL3vgscO20H+MvlXHc=;
	t=1738136288; x=1739345888; b=RP1r5Fvscie5GbW9y0ZwAYW+1VfKr1jvecjyTNLEbCAdZbc
	EfPrW+uzsalp/7TVoIusQrVNThVHwMw3AxOlu5AcvUwS1KIPcpAysonBGsVA3uFgHYMZ8+C/Fvn8C
	UlVW9FpUtgYOcDcshdDHvaqKtoaJIccServDmJ/QfscZ3cLa92YpHUukY3aZBo/Se2TGFD1QMkvGD
	xWtey1Y+tLI6k1yg5jBhbZytVCN/vUOAd9bxmkAuKpznEE9U7yH+/BsrAPVWgxbyyJEc5YYABh9lS
	yXu62yEHSdrvR65ReJ86kQ+HpGHFXAU89jrx/2Ghz4Ig5/ofz5n4BxXLbj/MLm8A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1td2e7-0000000Dq7t-0Qu0;
	Wed, 29 Jan 2025 08:37:59 +0100
Message-ID: <a905321376b8027ae6fe7e31fd03a03c4d47bb84.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 04/13] wifi: mac80211: Always provide the MMPDU TXQ
From: Johannes Berg <johannes@sipsolutions.net>
To: Alexander Wetzel <Alexander@wetzel-home.de>, 
	linux-wireless@vger.kernel.org
Date: Wed, 29 Jan 2025 08:37:58 +0100
In-Reply-To: <20250127162625.20747-5-Alexander@wetzel-home.de>
References: <20250127162625.20747-1-Alexander@wetzel-home.de>
	 <20250127162625.20747-5-Alexander@wetzel-home.de>
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

On Mon, 2025-01-27 at 17:26 +0100, Alexander Wetzel wrote:
>=20
> +++ b/net/mac80211/driver-ops.h
> @@ -1360,6 +1360,18 @@ static inline void drv_wake_tx_queue(struct ieee80=
211_local *local,
>  		return;
> =20
>  	trace_drv_wake_tx_queue(local, sdata, txq);
> +
> +	/* Driver support for MPDU txqi support is optional */

"MMPDU TXQ"?

johannes

