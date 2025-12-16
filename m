Return-Path: <linux-wireless+bounces-29791-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AD2CC1B0D
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 10:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B3963020817
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 09:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47412E7F1C;
	Tue, 16 Dec 2025 09:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="UM+OKZqR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F22F2E413
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 09:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765876123; cv=none; b=EflOeqyN6x/CvhwW0UTB3qvtzt6U2Je1+PanWun70YpYDZFtxBYgt/U+6inC14vqO5gNQgWDdoT65wNlH4Y6TGx8UC2hOFjw+XTAn+weV9kBSHzPbeTVFYkhpPBIGB7txE2DTluX7E7vjRjOlQuRiVdgB+c+9R+pPjqMMc3tkb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765876123; c=relaxed/simple;
	bh=lOOfNl5Cqb512Vm8+GaMjBQM6ml1dO06SKErLMdZCB0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cPVViGCYR0dI91OnQ3COdTnodXLy83+/oSlHq6yBPR1/WELMDS+BOk/sqcyKslO0MTPJeZEW2pu9sDtUQ30nroj8WKbTqs9/P11bTcjyRIBkJp3dMbOFTwgs7ewjiK0YkQQvlJ3itU98/ktPaGu/AkzRZ9pqKiQSjsII48ayX/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=UM+OKZqR; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=IR+VBx3RwMx35+jiS0E4hruKsvxFWpjByKLtJkaPLRw=;
	t=1765876122; x=1767085722; b=UM+OKZqR3MtziUv65CZJT2IGVNpkHLAZFpc3DYjpDsrsNY/
	pGZFn6FVijsJ1zfPGdqDGxzpzkbFKK2OYMkyG9jghp8Brx78TTRtlLvOlaOioC3aYKEgAH1v7+2o3
	XIR/hVAWkBetdl5WfrSWFZkQFoNl70eLjd8dsePeWK53RIUXc84iVLNIt/sQnOauEYdd7hy3C69yV
	/7PPc4DcM0qZT/3FKkP3t6EYbRUPH/t/yRtTbmGkEh//ypj7FWtaorvatFg6Xzf7r6K/NbRH+ktyj
	5A0hmsOaJtJru91pI/wqnxIuGGUEnvyEtSEImF8Kel7ebRvwhGF5lYRWB+9doDNg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vVR2s-0000000AEH7-1dNR;
	Tue, 16 Dec 2025 10:08:38 +0100
Message-ID: <94411a1f601b3b4cbc09cb780c37df9013f3b6bb.camel@sipsolutions.net>
Subject: Re: [PATCH RFC wireless-next 02/13] wifi: ieee80211: Add UHR
 (802.11bn) definitions
From: Johannes Berg <johannes@sipsolutions.net>
To: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 16 Dec 2025 10:08:37 +0100
In-Reply-To: <20251216062656.1738022-3-karthikeyan.kathirvel@oss.qualcomm.com>
References: 
	<20251216062656.1738022-1-karthikeyan.kathirvel@oss.qualcomm.com>
	 <20251216062656.1738022-3-karthikeyan.kathirvel@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-12-16 at 11:56 +0530, Karthikeyan Kathirvel wrote:
>=20
> +/**
> + * struct ieee80211_uhr_mcs_nss_supp_20mhz_only - UHR 20 MHz only statio=
n max
> + * supported NSS for per MCS.

I think I'd rename this? Due to

> + * As per spec P802.11bn_D1.0 38.3.11 - "UHR-MCS 0-15 are the same as
> + * EHT-MCS 0-15"

it will only ever be used for basic UHR MCSes.

> +#define IEEE80211_UHR_DBE_CAP_MAX_BW			GENMASK(2, 0)
> +#define IEEE80211_UHR_DBE_CAP_EHT_MCS_BW_160MHZ_PRES	BIT(3)
> +#define IEEE80211_UHR_DBE_CAP_EHT_MCS_BW_320MHZ_PRES	BIT(4)
> +#define IEEE80211_UHR_DBE_CAP_RESERVED			GENMASK(7, 5)
> +#define IEEE80211_UHR_DBE_CAP_EHT_MCS_BW_160MHZ		GENMASK(31, 8)
> +#define IEEE80211_UHR_DBE_CAP_EHT_MCS_BW_320MHZ		GENMASK(55, 32)

For the record, I'm not a huge fan of GENMASK(), I tend to think just
hex is more readable :-)

Here, using GENMASK() is also wrong for the last one of those, and it's
really not obvious.


> +/**
> + * struct ieee80211_uhr_operation_info - uhr operation information

nit: "UHR" (throughout)

johannes

