Return-Path: <linux-wireless+bounces-13423-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BF698D3D1
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 14:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 748241C20BD5
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 12:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26871CFED1;
	Wed,  2 Oct 2024 12:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vb6tDb12"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC8C1D0155
	for <linux-wireless@vger.kernel.org>; Wed,  2 Oct 2024 12:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727873855; cv=none; b=nm/fd5wxdvOyCv9Cb678L68Llbep/r35sS4FUiwd65ALtkVaxdUfAk17QtRN39wc+KnJETuafCDy11/rnNQGQltpWV2E1AMI446FAAhiLUSnY4Sy7gdu4ajeeIC8gknZc/ByFIZwrRvQF3d9re+I7Veic/Fa/0/mmm8sP14ukoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727873855; c=relaxed/simple;
	bh=oxFVdBoecQvu0mGTliDAzHXmCc4gIbnE9NqlclG5AJo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oUtOxMSichNQcorbkkI8S81U7cZwdoYhp1oWgC6lquXH+EG5ZRufkWOhW1rQYYvWZKyPbxT5GoSpg9niAsMkZKxb3rHF/XMeUmx/WEAFv+tUnSyrPvKtH6tCLWYFtjU1X0GnUE4WrYXEL8H+Y9NO0YFbY4aTLC/zahUIAa8eMYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vb6tDb12; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=6ZPED0F7Vmc3Tx1MkfSwJYntTfgqb/um5sI5q2Dan20=;
	t=1727873854; x=1729083454; b=vb6tDb12OQHqnBslvzYq5V6IYRt6XwdQ/1ZIZpwxIWRPr7E
	BiHlhtV+VIdIJIUHpVdvT6ecyeNaeKnGLArbqCHI79lEVUz2yVicO5a5AsUaZTWk0p260RZac//lj
	1zgl6aX/rEvczqRdWDXdYjxB4zf4i2KG9MAwrVPS6l65GFEUmI58+600NCV5rhNixm/f6ooThsLnq
	O7uF66AFD3ETDd0Xb9taTWqvYr/7FbarCdt9AQLxjJDnl9/MCclFdbDabbVVy436aUEqJheJAjlRz
	Sel+bQvd/Gih84N+npwlKtAfiX2QBPhq/3sQYE2fdNIEp3YktqjAKw7cUXNbQejw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1svyv5-0000000FdgP-2ooK;
	Wed, 02 Oct 2024 14:57:31 +0200
Message-ID: <a9fae8abdc94c094d831f8b39b7f9c6fde61815a.camel@sipsolutions.net>
Subject: Re: [PATCH 02/11] wifi: mac80211: use vif radio mask to limit ibss
 scan frequencies
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date: Wed, 02 Oct 2024 14:57:31 +0200
In-Reply-To: <fa77d4843c4e986db81960c7f859d0750e2b9e8d.1727869380.git-series.nbd@nbd.name>
References: 
	<cover.cb088351ab8df44310eee259bf2dbec858702463.1727869380.git-series.nbd@nbd.name>
	 <fa77d4843c4e986db81960c7f859d0750e2b9e8d.1727869380.git-series.nbd@nbd.name>
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

On Wed, 2024-10-02 at 13:45 +0200, Felix Fietkau wrote:
>=20
> @@ -1215,14 +1217,16 @@ int ieee80211_request_ibss_scan(struct ieee80211_=
sub_if_data *sdata,
>  	} else {
>  		for (i =3D 0; i < n_channels; i++) {
>  			if (channels[i]->flags & (IEEE80211_CHAN_NO_IR |
> -						  IEEE80211_CHAN_DISABLED))
> +						  IEEE80211_CHAN_DISABLED) ||
> +			    !cfg80211_wdev_channel_allowed(&sdata->wdev,
> +							   channels[i]))
>  				continue;
> =20
>  			local->int_scan_req->channels[n_ch] =3D channels[i];
>  			n_ch++;
>  		}
> =20
> -		if (WARN_ON_ONCE(n_ch =3D=3D 0))
> +		if (n_ch =3D=3D 0)
>  			goto unlock;

-EBUSY seems somewhat confusing in this case?

johannes

