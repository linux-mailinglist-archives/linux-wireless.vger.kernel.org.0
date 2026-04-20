Return-Path: <linux-wireless+bounces-35084-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGpZE5FC5mlutgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35084-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 17:13:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 200A542DEA6
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 17:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E681327C689
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 14:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251C93D88E7;
	Mon, 20 Apr 2026 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="XR6tMkiJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D906F3BA251
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 13:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776692699; cv=none; b=KPzMbsfykR89z+J5Ame1nA/xuMBggOkHdmSPdoULIxwX5ESAVMvd0R1FP84Xh/u5RtbyHBWagk07mauCBf0/cjJbaPWwXkWlhaa0wzPjqweuVuWgup4U4sY7Cy9JBAcYS9tK76+LHap9Inz9cRnUxdeY6UqO9HJu+dpdiB6YxpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776692699; c=relaxed/simple;
	bh=5ZjR+6lcTDHiKhLcMNEbWRMNi28erY+PfgJ6rrfXUsU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bquJgA87CDXd6hln3ezRnp5kecw2boU8lclR5eB1fVF2mPVErlsjSbG2lcidcjMn/N0STAIZjw236XobWrTT86DMf7OFlkmPvCaeblcD1wWVKxuN9KxXlT+4nJ1wqQcWbTcsLEdT7POtT8RgEzzjsSBr9Z/LAhcENyGu+Gfvve0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=XR6tMkiJ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=V+M8r9jO1Yomt4Qf6T9XFblBgMLPfL17VCWbm5EGHqw=;
	t=1776692697; x=1777902297; b=XR6tMkiJqcITelG/kNOrBfniVEdMjLz552re06vmEMb82WV
	1wAYwS1eMGnx5nLIu9xn8DFX0opIL93SEpfYxScj4jZbvhAGrWTP6eMptJX/mB2F8A3OHzgMI739j
	GwPyY8bPuuC+WW6m0M5zPUMEHdbvsuMbqmoWPFxDTnmCNL5j62CE3M7ZJIRu2zX6ux6vjTAqqGBNm
	DfK2xx2r1MKJF6+U5+0A4SBq7IaNmID1n2w77RJ0jrcnykFAjBpPcDw6GHxAdXEFG5TWLKyzLKpnp
	fgmiUaz92E5Jf7aatxNhQ6I8EHBISZsG9+F3FRyl73Pk/klAJOmnV8iFG4ubu10w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wEovn-00000002h6q-20qQ
	for linux-wireless@vger.kernel.org;
	Mon, 20 Apr 2026 15:44:55 +0200
Message-ID: <75d3a75ec542273920eafeef42829c2fafdf987b.camel@sipsolutions.net>
Subject: Re: [PATCH 14/20] wifi: nl80211: reject beacons with bad HE
 operation
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Date: Mon, 20 Apr 2026 15:44:54 +0200
In-Reply-To: <20260415144514.6217f5974fb5.Iff7ff6bcb159584e756d0f825c65860cdd53c6ea@changeid>
References: <20260415124514.284345-22-johannes@sipsolutions.net>
	 <20260415144514.6217f5974fb5.Iff7ff6bcb159584e756d0f825c65860cdd53c6ea@changeid>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35084-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 200A542DEA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-04-15 at 14:42 +0200, Johannes Berg wrote:
>=20
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -6641,10 +6641,6 @@ static void nl80211_check_ap_rate_selectors(struct=
 cfg80211_ap_settings *params,
>  			params->ht_required =3D true;
>  		if (rates->data[i] =3D=3D BSS_MEMBERSHIP_SELECTOR_VHT_PHY)
>  			params->vht_required =3D true;
> -		if (rates->data[i] =3D=3D BSS_MEMBERSHIP_SELECTOR_HE_PHY)
> -			params->he_required =3D true;
> -		if (rates->data[i] =3D=3D BSS_MEMBERSHIP_SELECTOR_SAE_H2E)
> -			params->sae_h2e_required =3D true;
>  	}
>  }

Not sure how that happened now when I was re-doing the patches on
wireless-next, but clearly this should be part of the previous patch,
not this one.

johannes

