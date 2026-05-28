Return-Path: <linux-wireless+bounces-37057-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFY3LIcBGGrUYwgAu9opvQ
	(envelope-from <linux-wireless+bounces-37057-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 10:49:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FC35EEEDB
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 10:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B41823148EFF
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 08:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A64E381B12;
	Thu, 28 May 2026 08:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ijfH8pyI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232743815C2;
	Thu, 28 May 2026 08:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957767; cv=none; b=stBVp2n0g4FTmkneGD23TQGl0O5EHy5G2TMOsxjUBLfzhhLXj7Nmn+G4OF+gYLMpag/7C7VXB+OJ/aypzJlIQUJJyDwOTSVdDK1tE06U47Uc8mZNp3NcA1KZVWTqLc2Jm1AGKf5ZypYJie/aG7AjJvFoOAIC8AlF17wNbbVLGY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957767; c=relaxed/simple;
	bh=XYedm6d/iAsAv2WIkpiTxlub/+GIcZhATqKIc+iwbVg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VEnkOkMgdyEHduucbmV1hBYGpRedJtJ+9AcbO90xha8I117MRhKWbYP5JbxfZ02QiQQvlccQEOjwT1Vc6drUc4SNhFMtr7k324sXjhlske63MbQBiaEpFvsI3FP5MI6BI+gogYdetnogVNAyYWB5awxxWMNoWoJvX1kulFXDhG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ijfH8pyI; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=FrXDOknvclDEJvn58J+D/bJnfXou2A4vXpZ+pv3eJPE=;
	t=1779957765; x=1781167365; b=ijfH8pyIn+f3DwPzVfHGuoFX6/6MIYKuGdNAFAIHBBJuR/y
	SSjLJZoE1r4Plz9R2ECoXkATElrCOz6+I6GUtWSwTfanVSCk/qIGbQkPtuo81KZaqgotFXHNbPTLG
	mR9uXptNDpmtDtKCgeig/LKQss4GGupr217lqMK3T1BoCrQymXA/zyvTr4LKUFJNXmCN2DuhkiPXa
	7+jjI6KrH9DWAzSeWb2t9MQG1Y+3aJbToAtO6eS+5/zuUc1YkK2iqv7BuHp8uYPWBPQt8LZrJFPY/
	CboCZqxBOVOWnPuM7JstFYFtu1ptkfEVj+1S78QV3ayuDJnoZHGjrLfnP8vBSYZQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wSWK8-00000007Djn-3qfW;
	Thu, 28 May 2026 10:42:41 +0200
Message-ID: <21b5dc35ef16217adce0ef726a603a11951da4d2.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: fix leak if split 6 GHz scanning fails
From: Johannes Berg <johannes@sipsolutions.net>
To: Fedor Pchelkin <pchelkin@ispras.ru>, linux-wireless@vger.kernel.org
Cc: Tova Mussai <tova.mussai@intel.com>, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Date: Thu, 28 May 2026 10:42:40 +0200
In-Reply-To: <20260524165320.62089-1-pchelkin@ispras.ru>
References: <20260524165320.62089-1-pchelkin@ispras.ru>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37057-lists,linux-wireless=lfdr.de];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 14FC35EEEDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 2026-05-24 at 19:53 +0300, Fedor Pchelkin wrote:
>=20
> @@ -1101,7 +1102,12 @@ int cfg80211_scan(struct cfg80211_registered_devic=
e *rdev)
>  	rdev_req->req.scan_6ghz =3D false;
>  	rdev_req->req.first_part =3D true;
>  	rdev->int_scan_req =3D request;
> -	return rdev_scan(rdev, request);
> +	err =3D rdev_scan(rdev, request);
> +	if (err) {
> +		kfree(rdev->int_scan_req);
> +		rdev->int_scan_req =3D NULL;
> +	}
> +	return err;

Given that rdev isn't accessible to the driver call in rdev_scan(), I
think it'd be nicer to do kfree(request) and defer the int_scan_req
assignment to after the rdev_scan() call?

johannes

