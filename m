Return-Path: <linux-wireless+bounces-28137-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F82BF6698
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 14:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C27C4ED777
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 12:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C479878F4F;
	Tue, 21 Oct 2025 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BFr4pH75"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5B11C84A2
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 12:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049250; cv=none; b=tPRzf67aUSZk6sYOGtWZteQseSiOnGvUQG5QljZ0Tv6epCP63U70GUhhnXPDuDQuFlqiS/rXYmH8H0dEKn9x0/r1Sx7RdUgIYLEh68Ad8KnuoHe6SSex1kzijuqwKLuhlyYCzHOijQQwym2WJ/Nxwk9CkPNMDpP130qFzQGN5zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049250; c=relaxed/simple;
	bh=OUok9F+7I/MOJK2bKmuNFEKdKp8GkOXjiOnNGrohorc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LUueLNalp8d/Us20CnB+9c5PHE1ikVBPcUqb9iniTuW+8Lu0P8cvTDyZvlk7/68cTFoZePPMufeP4Kr7znJHj9Y1AmT6xOvrCbWAOjUlF61HV6wm2U4aoG5C7jbexGobJCpY2T4BPS0hYJS7J292dC5MCEYRtJrao8wpfJ2nEsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BFr4pH75; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vu8ELA9eyiIlxycsl/gOa41vPYVFGJMZ3Xq1AN2OSNE=;
	t=1761049249; x=1762258849; b=BFr4pH756aphnoUirIGDNCvDX6jNAxyyyqEoRosv+xqO34m
	cOpczmr6lvMhB7b14GTByO2BiVBn5ONxDu8iIp9nWUkA6MlNmVzGzrTuG7vLBgCGA59kGNW54M+QT
	q6S+L6w954JhNrm4uPL3vRNSQvYq236bCXcWc1kvmplaPDZkLmWGLO30z1QiiaWnfuOLsS6vNK+i4
	gYk3iS4ELx7VNYQ4I1tXXqA8LTsrq+Y4OvqX3iBLOIr10h/iQDUFZ3W0PsmGhwazjDTQpM266RdSC
	vvKOE938sNfmcDHWViGbqQ+16BckKXuG+qYcWUj1jnV40NjKVM7DZywEEq4jaGnA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vBBM5-0000000BkHv-3mvu;
	Tue, 21 Oct 2025 14:20:46 +0200
Message-ID: <ffc008eee90574ce4e1579a1222e55234818fdd3.camel@sipsolutions.net>
Subject: Re: [PATCH wireless] wifi: cfg80211: return center freq for 1Mhz
 S1G chan start/end
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Tue, 21 Oct 2025 14:20:45 +0200
In-Reply-To: <20251021110725.397982-1-lachlan.hodges@morsemicro.com> (sfid-20251021_130745_094426_F5BD626F)
References: <20251021110725.397982-1-lachlan.hodges@morsemicro.com>
	 (sfid-20251021_130745_094426_F5BD626F)
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

^^ should be MHz in the subject

On Tue, 2025-10-21 at 22:07 +1100, Lachlan Hodges wrote:
> The frequencies returned by cfg80211_s1g_get_{start/end}_freq_khz()
> for 1MHz chandefs are off by +-1000KHz.=C2=A0

Hmm. I'm confused.

> +++ b/include/net/cfg80211.h
> @@ -10194,7 +10194,8 @@ cfg80211_s1g_get_start_freq_khz(const struct cfg8=
0211_chan_def *chandef)
>  	u32 bw_mhz =3D cfg80211_chandef_get_width(chandef);
>  	u32 center_khz =3D
>  		MHZ_TO_KHZ(chandef->center_freq1) + chandef->freq1_offset;
> -	return center_khz - bw_mhz * 500 + 500;
> +
> +	return (bw_mhz =3D=3D 1) ? center_khz : center_khz - bw_mhz * 500 + 500=
;
>  }

I don't see how this changes anything - if "bw_mhz =3D=3D 1" then

   center_freq - bw_mhz * 500 + 500
=3D=3D center_freq -      1 * 500 + 500
=3D=3D center_freq -          500 + 500
=3D=3D center_freq

so this makes no difference?

> =20
>  /**
> @@ -10209,7 +10210,8 @@ cfg80211_s1g_get_end_freq_khz(const struct cfg802=
11_chan_def *chandef)
>  	u32 bw_mhz =3D cfg80211_chandef_get_width(chandef);
>  	u32 center_khz =3D
>  		MHZ_TO_KHZ(chandef->center_freq1) + chandef->freq1_offset;
> -	return center_khz + bw_mhz * 500 - 500;
> +
> +	return (bw_mhz =3D=3D 1) ? center_khz : center_khz + bw_mhz * 500 - 500=
;

Same here with the sign inverted?

What am I missing?

johannes

