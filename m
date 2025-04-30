Return-Path: <linux-wireless+bounces-22240-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4A8AA4837
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 12:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AC0F4C6C74
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 10:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39DF21D3D0;
	Wed, 30 Apr 2025 10:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="p+0iUh7N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E21E1B5EB5
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 10:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746008613; cv=none; b=fQxIeLJ2dFhT5iBPzCVnCh3GvOeQQH/neuWvfQLnj9h8yPjjEvLvJrVKBOPIFne3gUj1E3oBezq5nrCXhQ2D5nRHQ8ITTcmHmgu+35f1HIzi1kkTWLhcxsJ9VMXyZk/XR+R+i8WCnxyT4LzswDk4WksR5IWwZ4a5419w4gp6fGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746008613; c=relaxed/simple;
	bh=de9nqzQoNMx1euw3/O4uoOkBbPoJtExFTprLLtuo1vU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RXt7HMD/95pBHYxvznR46fYDYeGfjPXsTbPU8/1iCeKckBI7DXQbY8/qIDOKHsKA03ySjCrq5SjdyBrY55IdNn5zcvC79+mh2uqqvfzIODP8rRbfO0ZQMUQ5GidhlNXS0dYNuU5H7BYHkeDCtOTcw3aLswH38kOggSrYdSFZ0E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=p+0iUh7N; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=eOclCU6MepjUfzuIPuyjhWjkmr9jBAGzyUYrLyxPJk8=;
	t=1746008612; x=1747218212; b=p+0iUh7Nmkks2ujana+whsMc6y7gZBFDd23aKjrowawKVF5
	p5OCII/ALagBe5mL2VqGSu5FfUnWuFMeinHymWMGcWjCPCpLmOAMkVYAiKbcBmOMZLQ7Bxk4wsqN3
	RwBxVRcej2tI1n+c8/kw0wC10W0sQ8xcUI7/b2+Up+qDZk0y886L/8WDZwTntZ6HNizX2iBS1EEUX
	Pl93miWJH6ldu3gelw5oOn9NHlOaEE/xw838sO/W64CvVbLa6XOmOQYsk41HAQralLN7jZ8XxBvPg
	7rviQTkyKW06fx4blVVX41TKCnAHcyWZFxipWjBrPE6MSuVwnbkA3KDbbmYMXZuA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uA4bA-0000000Ddev-3CyP;
	Wed, 30 Apr 2025 12:23:28 +0200
Message-ID: <940db15452d6dc9c7f4dd074360bacd2c6f315f8.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next RFC 2/2] wifi: mac80211: process group
 addressed Rx data and mgmt packets on intended interface
From: Johannes Berg <johannes@sipsolutions.net>
To: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 30 Apr 2025 12:23:28 +0200
In-Reply-To: <20250430071435.2201777-3-maharaja.kennadyrajan@oss.qualcomm.com>
References: 
	<20250430071435.2201777-1-maharaja.kennadyrajan@oss.qualcomm.com>
	 <20250430071435.2201777-3-maharaja.kennadyrajan@oss.qualcomm.com>
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

Hi,

I suppose you're mostly looking for feedback from Mediatek etc. for
their multi-radio architecture. Couple of comments on the code anyway:


> +	if (valid_links) {
> +		for_each_set_bit(link_id, &valid_links, IEEE80211_MLD_MAX_NUM_LINKS) {

We just added some for_each_sdata_link() macro or so, so you don't need
the distinction between MLO and non-MLO. I really don't like seeing
that, if we do that all the time we have far too many places that would
do it.

> +			bss_conf =3D rcu_dereference(sdata->vif.link_conf[link_id]);
> +			if (!bss_conf)
> +				continue;
> +			conf =3D rcu_dereference(bss_conf->chanctx_conf);
> +			if (conf && conf->def.chan &&
> +			    conf->def.chan->center_freq =3D=3D freq) {
> +				is_freq_match =3D true;

You could much easier just "return true" here, and "return false" later
after all of it, without the variable.

(Curious: do you have some coding style guidelines that this breaks?
Like "single return from function" style? Because I see it often from
Qualcomm for no real reason. Maybe I'm also just misremembering, but I
don't see a good reason in cases like this to even want to write it with
a variable. Seems more natural to just say "ok got it, return true".)

>  	if (prev) {
> -		rx.sdata =3D prev;
> +		if (!status->freq ||
> +		    ieee80211_rx_is_sdata_match(prev, status->freq)) {
> +			rx.sdata =3D prev;

nit: you can combine it all into one condition now:

 if (prev && (!status->freq || ...)) {
 }

not sure that's really all that much better, but saves the reindent?


Actually, it might be better overall to move the !freq into
ieee80211_rx_is_sdata_match()? So just have

ieee80211_rx_is_sdata_match(...)
{
	if (!freq)
		return true;
...
}

and then you don't need the || in the caller, which simplifies that? And
also gives you a more natural place to put the comment.

johannes

