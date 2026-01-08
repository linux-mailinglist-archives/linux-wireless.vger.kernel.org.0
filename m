Return-Path: <linux-wireless+bounces-30560-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D5ED029C8
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 13:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E39C30C59E8
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 12:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142E24D90A9;
	Thu,  8 Jan 2026 12:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xOZ+p88C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098214C1413
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 12:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767874859; cv=none; b=qxvo8zCu6HBUik6RbTfDukt6sxrpBf2vVaM8lM6cNo3qEzLdKENSytUYjveEeB+T+SJ8eZyYzSS2+YA+xDzpfS13w5BVM79kB1/jNX+NTPRVfggrRbjR/1o57cmSz5SylOH1Lj+JW7pwEXbrh4aJyxfYDPCMuzQlyjZrCE4effs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767874859; c=relaxed/simple;
	bh=I412IdixaVP2E77fH9yWrzRkdKbMMfjEsNJOH900MwY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YyKbj0n3JzWf745QviCRC0RsvffVEK7FF9vkUuM0kv/u/c/EiyzU5XdOBOLRynWXiSUbtz8Uejd5MCT1sy1YexAGg6Kl73ZEH2/tJygjl/GNqW48RgFazzzrKYqY38m4eLJMilsdrncHEvQjSxL3XDeQtUP0TAU3shPpMFa/TBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xOZ+p88C; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=3TQX96JDCGje+pG6tkJ+gBc8yZDfcoC/5P4UZg8SsgM=;
	t=1767874857; x=1769084457; b=xOZ+p88C3vhf+GPg5xNRAHbacLhELQAbnYo1pjTJGgbqKaE
	LovEiut+ihI5Aqc32pSyua0sfXzRwDZ31X1reOYmpCYIae2Qvm+iz4Lr78AxqNarxjrhUm5jqDqOF
	ER6o5zfynsS0r00zKS/9npOs509kZCKoElkHshwwEzqIrUWDJCu/1G3md6uzkEQQo5yBd2UEZjEeQ
	Zfbjx+qn9/T0hdEPArsO0NSOtvKjaQln6joieh6MFe36JXezav+p0k6sOGpId1bSvdLHfAo9X4q6D
	UAHOpdiu1c9E19dGaGvuR6FT3WD78YsTZSziW1m9F7pYDbLNDCnl50eVzld2NcyQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdp0X-00000006UcD-1qD0;
	Thu, 08 Jan 2026 13:20:53 +0100
Message-ID: <557aea3a06c79c2d2e04649e43b48e0733d26347.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 2/2] wifi: mac80211: set addr2/addr3 to
 link address for NULL packets to non-MLO stations
From: Johannes Berg <johannes@sipsolutions.net>
To: Suraj P Kizhakkethil <suraj.kizhakkethil@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, Sriram R <quic_srirrama@quicinc.com>, 
 Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Date: Thu, 08 Jan 2026 13:20:52 +0100
In-Reply-To: <20251127140555.472327-3-suraj.kizhakkethil@oss.qualcomm.com>
References: <20251127140555.472327-1-suraj.kizhakkethil@oss.qualcomm.com>
	 <20251127140555.472327-3-suraj.kizhakkethil@oss.qualcomm.com>
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

On Thu, 2025-11-27 at 19:35 +0530, Suraj P Kizhakkethil wrote:
>=20
> -	if (ieee80211_vif_is_mld(&sdata->vif))
> -		info->control.flags |=3D IEEE80211_TX_CTRL_MLO_LINK_UNSPEC;
> +	if (ieee80211_vif_is_mld(&sdata->vif)) {
> +		if (sta->sta.mlo)
> +			info->control.flags |=3D
> +					IEEE80211_TX_CTRL_MLO_LINK_UNSPEC;
> +		else
> +			info->control.flags |=3D
> +				u32_encode_bits(link_id,
> +						IEEE80211_TX_CTRL_MLO_LINK);
> +	}

This whole conditional logic is now pretty messy, and we (and the
compiler, for warnings) have to track that link_id is actually
initialized on all paths, which seems unlikely to always go right ...

I think you should set link_id =3D IEEE80211_LINK_UNSPECIFIED or the link
according to the logic earlier, and then just always u32_encode_bits()
unconditionally.

