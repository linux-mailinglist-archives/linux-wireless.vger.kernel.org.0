Return-Path: <linux-wireless+bounces-29714-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E58F1CB8CE1
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 13:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9A2030690F2
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 12:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D730B3128B7;
	Fri, 12 Dec 2025 12:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="CWfpcogn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2FC2C11F3
	for <linux-wireless@vger.kernel.org>; Fri, 12 Dec 2025 12:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765542564; cv=none; b=tGRVxWcXP6a6a6dlk44OIRDBGcOReXp+THor8cpUCL5Me62YVWOcH4K+DBYUIqZlOPr98ZUkA82yRH2Xnwa3TBv2efmLvl3hmCEzjQIvCg2pnekDdYYAj4hHgg4hP/ahPqUC8PzLtWtNcnkxwlLVrCr5wSlriPrrTC/F0Fj3Ljk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765542564; c=relaxed/simple;
	bh=bkD71XAA5BvIxObKq34f/8e+3dRaD1QdE6zeLhPzDrA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EVG2RsGQqYbYdz2WKiHCVDfYCvvo5RMNYswQ++AfYsiq8jtQCuorjDSFLh58muQpzAIb9SC8wt3sCmVz+UPYqPFMEqGQcZvNZ6Lif4BLfMYjKIe/WbuWSbNNxL5/DQ4r++VpXZIVk0+28zbDbvDm6PR6ETs7mzQ4xUjEYoqxVyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=CWfpcogn; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=0lhibDPQ6UCfZ2wmyfmIor6r6FWkM8DwVuSYCoe4dUc=;
	t=1765542563; x=1766752163; b=CWfpcognHPQ1ppnAm4Zy3reQjGu9HCOYRquHuQU7bUrs+wG
	3OeRDffpk/IdVG1I7sIL3iptUt/r5sNbfDiRAWuAbusKlpr25QRrk+NXAFr4BDlBSqPpy7R2Q5jzy
	FGRLP9J/DzCWZYhAq1Fpff/D+Bngp3iYY2X9lbn3hYuGLiWkHikWNyZz+Fil27EcbGC2MUgQWspRp
	ZJ7CqknCccIx2zxIZ6R1/OAU5cYTgTJicONYdYyFyOu+dg6oEC6MBA2ifDNajis0gR+HO9s/zfmeh
	srxkDsMiztFprRswNGJDlnea24rRZAPrLWbZzRuiqeSGUWab/ntAZcRu6wEEOxEQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vU2Gt-00000003SwG-1Z3G;
	Fri, 12 Dec 2025 13:29:19 +0100
Message-ID: <1da46c84d32dfa1458dc3c60e18f16d3a6defaf7.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 05/14] wifi: mac80211: allow key
 installation before association in =?UTF-8?Q?non=E2=80=91AP?= STA mode
From: Johannes Berg <johannes@sipsolutions.net>
To: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ainy.kumari@oss.qualcomm.com, 
	sai.magam@oss.qualcomm.com, quic_drohan@quicinc.com
Date: Fri, 12 Dec 2025 13:29:18 +0100
In-Reply-To: <20251211124051.3094878-6-kavita.kavita@oss.qualcomm.com>
References: <20251211124051.3094878-1-kavita.kavita@oss.qualcomm.com>
	 <20251211124051.3094878-6-kavita.kavita@oss.qualcomm.com>
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

On Thu, 2025-12-11 at 18:10 +0530, Kavita Kavita wrote:
>=20
> +++ b/net/mac80211/cfg.c
> @@ -680,12 +680,29 @@ static int ieee80211_add_key(struct wiphy *wiphy, s=
truct net_device *dev,
>  		 * association has completed, this rejects that attempt
>  		 * so it will set the key again after association.
>  		 *
> +		 * With (re)association frame encryption enabled, cfg80211
> +		 * may deliver keys to mac80211 before the station has
> +		 * associated. In that case, accept the key if the station
> +		 * is in Authenticated state in non=E2=80=91AP STA mode.
> +		 * If (re)association frame encryption support is not present,
> +		 * cfg80211 will not allow key installation in non=E2=80=91AP STA mode=
.
> +		 *
>  		 * TODO: accept the key if we have a station entry and
> -		 *       add it to the device after the station.
> +		 *	 add it to the device after the station associates.
>  		 */
> -		if (!sta || !test_sta_flag(sta, WLAN_STA_ASSOC)) {
> -			ieee80211_key_free_unused(key);
> -			return -ENOENT;
> +		if (!sta)
> +			goto fail;
> +
> +		switch (sdata->vif.type) {
> +		case NL80211_IFTYPE_STATION:
> +			if (!test_sta_flag(sta, WLAN_STA_AUTH) &&
> +			    !test_sta_flag(sta, WLAN_STA_ASSOC))
> +				goto fail;
> +			break;
> +		default:
> +			if (!test_sta_flag(sta, WLAN_STA_ASSOC))
> +				goto fail;
> +			break;

I don't understand why you (later) introduce this asymmetry between AP
and client modes? Couldn't mlme.c just set the (introduced later)=20

johannes

