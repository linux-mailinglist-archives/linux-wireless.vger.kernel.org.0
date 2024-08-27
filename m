Return-Path: <linux-wireless+bounces-12029-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE25960412
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 10:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 711292838C8
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 08:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3228118756A;
	Tue, 27 Aug 2024 08:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fv6mrZYy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906721547C5;
	Tue, 27 Aug 2024 08:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724746352; cv=none; b=XxOp1n833OLseORc8dc2kbtGbSQHmmbHr+/fwA9nxsKh3Mg23c8PCCOrSymlgOcmobOe3PJ23rN9dCm8lfW8Xq0HPSqM3kRBH0Op6y5viOmNZI3F8edJ+kOeetd09oseLqUfTcGTQOhxnkPSNHsg56Y0J/3wDd4cd9Sr/zbfhj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724746352; c=relaxed/simple;
	bh=9BqyGH8iAhe32SVuitbdCgtpdlnjGAHT4QTJcbWTgCc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OW6ouWHsUtkt3IpyriGyeuyhB+/G9OH+mV0bucyGqDy2ONkSGMSgwAhLWjHg73Hl9I3dtJennu9exlQREcguXXxE8ndg5xJoAVzuF76Jp6iSZr9uvS8eLG8+rdIz270kCGrs7V3uPBw1BhgfWlC6ews0cURN2QpYWb3IbfQ+gy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=fv6mrZYy; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bL+QrbENSMemW12aF0eJeo0zf2iwnZiHHlBbEDCmT6I=;
	t=1724746350; x=1725955950; b=fv6mrZYye3jaEjhM/Spyd1TG2Bhur/IbLZYELiXZ61EiPMt
	P9MCVnQIKElbW2DyeMlll/PyiNfaFsuJ9cNVmq1QO6HL5uKkD/0USgeKARpp7IdzCcxO/y19XUyAc
	nYZ40PJOi3QInvZmfvNtmPmBVKB36K8FAeB+S66/kmw/8SXDwcRU68tFSnIv3uW22jSOU6gmitnLF
	92G7eAUFTsy1q8A+o6BxGckYpLcpgkxSLxzlCXUo4NBaF4ajDecKrImZLc3P+xPegBU3efkik2sm/
	DCV5oWUqEfau34SPYKwuofcMpmfjxjRC3S80aTaaR08mW3mD4fd0PTF/w78OWVvw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sirJT-00000004SPU-39aB;
	Tue, 27 Aug 2024 10:12:27 +0200
Message-ID: <3ddcf25ba09bf99c973c46ef1944c079be2753eb.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: wireless: fix more UBSAN noise in
 cfg80211_conn_scan()
From: Johannes Berg <johannes@sipsolutions.net>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Kees Cook <kees@kernel.org>, linux-wireless@vger.kernel.org, 
	linux-hardening@vger.kernel.org, lvc-project@linuxtesting.org
Date: Tue, 27 Aug 2024 10:12:26 +0200
In-Reply-To: <20240716174011.236849-1-dmantipov@yandex.ru>
References: <20240716174011.236849-1-dmantipov@yandex.ru>
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

Hmm.

On Tue, 2024-07-16 at 20:40 +0300, Dmitry Antipov wrote:
> diff --git a/net/wireless/sme.c b/net/wireless/sme.c
> index a8ad55f11133..f5da45331847 100644
> --- a/net/wireless/sme.c
> +++ b/net/wireless/sme.c
> @@ -77,12 +77,16 @@ static int cfg80211_conn_scan(struct wireless_dev *wd=
ev)
>  	else
>  		n_channels =3D ieee80211_get_num_supported_channels(wdev->wiphy);
> =20
> -	request =3D kzalloc(sizeof(*request) + sizeof(request->ssids[0]) +
> -			  sizeof(request->channels[0]) * n_channels,
> -			  GFP_KERNEL);
> +	request =3D kzalloc(struct_size(request, channels, n_channels) +
> +			  sizeof(request->ssids[0]), GFP_KERNEL);

That makes sense, sure.

>  	if (!request)
>  		return -ENOMEM;
> =20
> +	/* None of the channels are actually set
> +	 * up but let UBSAN know the boundaries.
> +	 */
> +	request->n_channels =3D n_channels;

Also makes sense, so we tell it how many we allocated early.

Note netdev we dropped the special comment style requirement, so
wouldn't mind

 /*
  * None of ...
  * ...
  */

here either.

> +
>  	if (wdev->conn->params.channel) {
>  		enum nl80211_band band =3D wdev->conn->params.channel->band;
>  		struct ieee80211_supported_band *sband =3D
> @@ -112,9 +116,9 @@ static int cfg80211_conn_scan(struct wireless_dev *wd=
ev)
>  			}
>  			request->rates[band] =3D (1 << bands->n_bitrates) - 1;
>  		}
> -		n_channels =3D i;
> +		request->n_channels =3D i;

So this tells it how many were actually used, in this branch, makes
sense.

Functionally, all of this seems OK.

However,

>  	request->ssids =3D (void *)&request->channels[n_channels];

is this not checked? I mean, if you have n_channels=3D5 and then take
&channels[5] I can see how that makes sense, but arguably the compiler
might complain if you have &channels[10] for an array you told it has 5
entries?

johannes

