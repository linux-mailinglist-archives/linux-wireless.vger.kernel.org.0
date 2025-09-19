Return-Path: <linux-wireless+bounces-27520-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7475B894AF
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 13:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B2D3BEA04
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 11:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B722FC00E;
	Fri, 19 Sep 2025 11:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ovEQF6vn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904A819755B
	for <linux-wireless@vger.kernel.org>; Fri, 19 Sep 2025 11:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758281879; cv=none; b=LaZGmMh740vcpQ0w2bQPZxB7By9A7qc63oYTgaRadgtdd01PEn1VCzWI6ei+drSwNOOAeUf9P3fFFhkad66RGk2por0s4kIiL0ZTm6RKiPeXFRppVVdKrbxW3MM5uqU8UJaxMogA6+GOoJ8jHn2NdUXa8uCuM2rVb5zUx7Wr1zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758281879; c=relaxed/simple;
	bh=FqfQa2eGRtxM31saOGe26vJE16mpBPv/4M2jUwK17r8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DkBeVoO1tdpb7l5bKwPB6kn0wUmAlsaeCEcCsQXFboa6iUHk5JbP/5hsNdxrXx3Q9K9N5FilAimGUHAygpSOkK+eLT2nVOzXtEKky4+XFHnmx3F9BiSwiBBhcm62kn8yflUrRbvtaCST2grpkBNs2O0KqEV3rRRy3KBNX7cvjp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ovEQF6vn; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1HIOiMWgZ9vID+upv6AtIVsg6MdkfdnH0ZQjx//GkRo=;
	t=1758281877; x=1759491477; b=ovEQF6vnrWQhfMB3IR4uAMul59757DqoRN4ZBgUZPqQxo10
	Cq1sCDa5egy8RlveMGCdv/g1sAoKQ5p0hlwaGNkp9KgE2y22V/MoiFPwy6XaVDcI/n/jxRjAVsDRV
	A34QohbjITW120nk4vYf5W4tFSJsnnYxqI8KGJMdePoZHeNWEaH9q6EZDIgGjvovdAWNvz9l9A2F9
	c8ygM5lGW7uPlRrvGPuSCzTCb1o0xIEF+tyypix3/8A9rYcxXc8wqBafsSFCm2tJet+bDgG0VgaXe
	k4O8ooqPpv/NY0hmiBc3i6C/uBalfoWUoTwNj7DLxaGd5Di1N49kRGOJD6P+d47Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uzZR5-0000000Fn7f-0yUN;
	Fri, 19 Sep 2025 13:37:55 +0200
Message-ID: <e2f503df04693ca4066d7489b2ecc27fcf167885.camel@sipsolutions.net>
Subject: Re: [RFC wireless-next 1/3] wifi: cfg80211: fix background CAC
 cancellation
From: Johannes Berg <johannes@sipsolutions.net>
To: Janusz Dziedzic <janusz.dziedzic@gmail.com>, 
	linux-wireless@vger.kernel.org
Date: Fri, 19 Sep 2025 13:37:54 +0200
In-Reply-To: <20250914174622.479249-1-janusz.dziedzic@gmail.com> (sfid-20250914_194652_524147_94AE010C)
References: <20250914174622.479249-1-janusz.dziedzic@gmail.com>
	 (sfid-20250914_194652_524147_94AE010C)
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

On Sun, 2025-09-14 at 19:46 +0200, Janusz Dziedzic wrote:
> Release background radar ownership after cancel
> delayed background CAC work and sending the
> CAC_ABORTED event to user mode.
>=20
> Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
> ---
>  net/wireless/mlme.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
> index 46394eb2086f..9afda72aea38 100644
> --- a/net/wireless/mlme.c
> +++ b/net/wireless/mlme.c
> @@ -1306,11 +1306,12 @@ void cfg80211_stop_background_radar_detection(str=
uct wireless_dev *wdev)
>  		return;
> =20
>  	rdev_set_radar_background(rdev, NULL);
> -	rdev->background_radar_wdev =3D NULL; /* Release offchain ownership */
> =20
>  	__cfg80211_background_cac_event(rdev, wdev,
>  					&rdev->background_radar_chandef,
>  					NL80211_RADAR_CAC_ABORTED);
> +
> +	rdev->background_radar_wdev =3D NULL; /* Release offchain ownership */
>  }

I don't like this change at all, it's a minimal fix but the
__cfg80211_background_cac_event() taking a wdev and then never really
using it makes it all confusing ... I'd rather fix _that_ function to
use the passed wdev rather than make fix this sequence to make it work.

johannes

