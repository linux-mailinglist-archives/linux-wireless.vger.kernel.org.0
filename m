Return-Path: <linux-wireless+bounces-32465-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LHGIu8dqGnyoAAAu9opvQ
	(envelope-from <linux-wireless+bounces-32465-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 12:56:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB461FF652
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 12:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77FC93022079
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 11:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562353A8732;
	Wed,  4 Mar 2026 11:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="l+k+GB0t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082873AE191
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 11:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772625178; cv=none; b=lMroJ0fHD88JlGXRD/h/BDeeYeeVj4V9rYOdanOTo5m+e1e0hJApiIU+4H9Piacbc1VSGJ/mVFh7p8VAIMq2FXlQxVZQ9n9h4tDR3o534wOKA36uoeHNCTv3xnONXJqUc6VkDA7XJt2xyODOeMelEzIf4iRqdMv8pruDNyEZZes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772625178; c=relaxed/simple;
	bh=K8m7V7aF5nkqHRLQwffjdVHkIQYpGJz19v8LDL74qqU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rfdkSvbFiXe0xzMbx7XYU+n41HtfwOOjkd3boNN9BqsqrRtkDoNXQBGVKwXei2DSmQ3thwcJTODp1GR0KVI+wHC7GZfiJIf5rXTl8htTSy8BWACepKECLGApU1hHJgRJQ97W3gAehZhUSOUIy33boNxf8+HYAbgbxObz9Lbikok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=l+k+GB0t; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=W/pF2JKsYgMUiRVrwRq/YgRPAR2oYw2E7CQOYv5q//g=;
	t=1772625176; x=1773834776; b=l+k+GB0tCcalQDGfEpW8WqiXrwTp5p/w9bLbKqtM0+37h50
	b+NPAdlWF7y/pU/o7LDT2NJoGzAye97pOcNJ/0TF2KvCSNJmWGUEZmTgYGkeoCe592YsoLLvIvCsb
	mrc1/aFx2C3lVjvUiuWlUHC6t2Df0gGkl1hbswjua4ampDLjkpN3KOOsnP8nVNecbknzwqrObi7H5
	OrXGnrj2Mfk04q/jKuwwolmu0AF6MbLJm5dkPhikBXpcjKfsNg1UV0APF3LqzowDzrGJBDgnkSNeD
	ko0urxx3fQAAljfSYh/yimdNpnxcBs1/9/d0qYg92ZvjxxvKdvZrRdVaaCXMw8xA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vxkma-000000083Xv-3cPh;
	Wed, 04 Mar 2026 12:52:53 +0100
Message-ID: <e01d16bd2f890355a1edb545b4b5ab2fee265bfc.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2 07/16] wifi: cfg80211: add continuous
 ranging and PD request support
From: Johannes Berg <johannes@sipsolutions.net>
To: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Date: Wed, 04 Mar 2026 12:52:52 +0100
In-Reply-To: <20260304071538.3833062-8-peddolla.reddy@oss.qualcomm.com>
References: <20260304071538.3833062-1-peddolla.reddy@oss.qualcomm.com>
	 <20260304071538.3833062-8-peddolla.reddy@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Queue-Id: EAB461FF652
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32465-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Action: no action

On Wed, 2026-03-04 at 12:45 +0530, Peddolla Harshavardhan Reddy wrote:
>=20
> +++ b/net/wireless/pmsr.c
> @@ -91,11 +91,10 @@ static int pmsr_parse_ftm(struct cfg80211_registered_=
device *rdev,
>  			nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST]);
> =20
>  	if (capa->ftm.max_ftms_per_burst &&
> -	    (out->ftm.ftms_per_burst > capa->ftm.max_ftms_per_burst ||
> -	     out->ftm.ftms_per_burst =3D=3D 0)) {
> +	    (out->ftm.ftms_per_burst > capa->ftm.max_ftms_per_burst)) {
>  		NL_SET_ERR_MSG_ATTR(info->extack,
>  				    tb[NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST],
> -				    "FTM: FTMs per burst must be set lower than the device limit but=
 non-zero");
> +				    "FTM: FTMs per burst must be set lower than the device limit");
>  		return -EINVAL;
>  	}

I really don't know anything about this protocol, but this also isn't
described in the commit message, and zero seems odd?

Maybe it should be allowed only under some additional conditions,
otherwise you're potentially changing some check that existing
drivers/devices rely on?

johannes

