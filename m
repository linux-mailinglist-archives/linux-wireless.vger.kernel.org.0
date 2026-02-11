Return-Path: <linux-wireless+bounces-31740-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJ2kKR2QjGlQrAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31740-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 15:20:13 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4585C125253
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 15:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC259300559E
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 14:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B0C1DF748;
	Wed, 11 Feb 2026 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Fy5SArjQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948E6C8EB
	for <linux-wireless@vger.kernel.org>; Wed, 11 Feb 2026 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770819609; cv=none; b=sxL2AydnSjaWdMDuUhvdV3KNso2+gg8OH3ggfVbTPry97HX+oAPluCulO7oQI98V7LjhC+C2MKUj0xfjdbtiBvLOM270j7oZWZSA7gAv2A5SQDTW3eCr3nixD/Dbwg0fmA3Vv4zsD2wo6vLNrtJyvQKPrzkHiE5DIcZdHs+tiCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770819609; c=relaxed/simple;
	bh=tDgFt7mEOZDdarELqmBi929LLIvtxZOzJlD3BQJKu/M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q56rrUSKIN04yki6vB1FM5SulirRt2K2BQfQlL1d4QJ2NUDvrX8zOd9xhSXj7w0v3KNyLfGkJz9wlZjqjaNivo5hC9SSXAJsVEwzBFKHMez2N3dASZ5g7NT2AXZQUJitJmoQ9GcV36R9Novn+mhtTeyK5TXjU28sk2083f524kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Fy5SArjQ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ZF35Wf69L0tGlh5c85F3QoEwDlCFLMWVX4TQw5+1jqg=;
	t=1770819608; x=1772029208; b=Fy5SArjQJE4WPSA7T+nQggSWlSlGXLvYQZSW3z9v35r0Beg
	Ki0VPwt8mciPRHhex1DytsA5GN2ZZmSsC320pmYUKWpBQDXHKuqZhUfjEMhk9wRcp8ZZig4sPsTnS
	s1e2ZjjZtgnS51+QimKArjjw/9GaAHGE3kmNq+mU3QUciWk0uuiKXfaDdXdk8ZOGklsmAfvinHihG
	euzBFAjr6n0fqqXcQ3MZyhtJK+ptrFNiG3tLrMc/4C/XK4OV9uoV988koJjsfWIkuMphX2yKISImy
	fB7+PXDT76ElOhiM7CX/2NBDYHy/kYxTSpWboWDaqWnlYFsmRl/YstQWMuAHHGDA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vqB4R-00000005Gay-2tZA;
	Wed, 11 Feb 2026 15:20:00 +0100
Message-ID: <f96125eeda23451c19067359eb9d10b4047bcdd3.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v8 2/3] wifi: cfg80211: add initial UHR
 support
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Date: Wed, 11 Feb 2026 15:19:58 +0100
In-Reply-To: <20260130164259.54cc12fbb307.I26126bebd83c7ab17e99827489f946ceabb3521f@changeid>
References: <20260130154259.265130-5-johannes@sipsolutions.net>
	 <20260130164259.54cc12fbb307.I26126bebd83c7ab17e99827489f946ceabb3521f@changeid>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-31740-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 4585C125253
X-Rspamd-Action: no action

On Fri, 2026-01-30 at 16:21 +0100, Johannes Berg wrote:
>=20
> @@ -6462,6 +6486,17 @@ static int nl80211_calculate_ap_params(struct cfg8=
0211_ap_settings *params)
>  						cap->datalen - 1))
>  			return -EINVAL;
>  	}
> +
> +	cap =3D cfg80211_find_ext_elem(WLAN_EID_EXT_UHR_OPER, ies, ies_len);
> +	if (cap) {
> +		if (!cap->datalen)
> +			return -EINVAL;
> +		params->uhr_oper =3D (void *)(cap->data + 1);
> +		if (!ieee80211_uhr_oper_size_ok((const u8 *)params->uhr_oper,
> +						cap->datalen - 1, true))
> +			return -EINVAL;
> +	}
> +

OK, I just basically copied this from EHT, but it's useless. Due to the
reduced information in the beacon, we don't really have anything here
(such as NPCA timings.)

Should we add a separate netlink attribute for the UHR operation, which
hostapd would fill with the _full_ data like it appears in association
response etc.?

That way, hostapd doesn't need to build a separate data/attribute
structure but can just use hostapd_eid_uhr_operation(..., false) for it.

An alternative would be to add more attributes for everything, but it's
probably more complicated on both sides?

johannes

