Return-Path: <linux-wireless+bounces-23002-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F47AB84F3
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 13:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C14B74A6DD6
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 11:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AE4298CAE;
	Thu, 15 May 2025 11:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KHx2KoSV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFB0298CAD
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 11:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747308524; cv=none; b=EYacpTiTYEXirvISUDmKWgY5ZbULGAk4EzyieC1UIdD1gKHB130lsoPL5om7LDKAFpqyFp+V98a2uLVWG6PfMnjQwDUe2eK3RRCABx1keQ2GX6fuca6QIig+Lgv3xwHP13FXVl5Zr2bjIQE5fBcbC53GnAgcuk5rNaf0mmatOtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747308524; c=relaxed/simple;
	bh=Xn9UcJQipZEvIxdotVpby1lkydoTIp+K904s/sFw85o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e1Z4MmxR8ildnGGj1JJEQDLdgtbRB+uRXzX3QvjUlCQfvezu6lDGIQJtAgwYaSbMjARZKnrvXgk/8cntVm9nhox3fJHZuG6L9iiJ5mriko2LWHQdizjeQEFemJSUNoVDaFjFgAXW9GnyBs5n7b791V2DKS71t8kr4r57DEyMezQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=KHx2KoSV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=S35+OQB/7/0yBUTzekdWTjmw7Cl1rpxiaD1ozWEwZ6A=;
	t=1747308523; x=1748518123; b=KHx2KoSVq7dLwFDYfayXRSaq5TrfRWb3QMuPoD7AvRpMBQ8
	Ndz8VkD5G9u7AhEYcQoirOiLgHWOMTI7sw+JF89Nir6rgoJgM29Buf6l4ZZt+vtMYBiunMQDcMUaD
	LFLqC2Z6f/aG0w0OF12qxsX6crVqXQ6Xq/2PKxjye82Bv5q7PPlAF3M2nFn3NJ50iN3d0dsY1Jl8k
	5JMw2gkIGH1ARvdYX4ElNiv4/gwBwtOuus1dhXtXSAWTfjIEAiUmRgXtdiiMmiEYy+3YDjMsEr1dd
	F1BDt60e2UFSkkrOMAw/DgCdlz4janL1PSDU0XY2FDCOu5eR3kuqT2SAxNzaG0jw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uFWlT-0000000B6Yo-3SkP;
	Thu, 15 May 2025 13:28:39 +0200
Message-ID: <51755b44ccf1f2e282bda7bacae41aa6677b146c.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v8 05/10] wifi: cfg80211: allocate memory
 for link_station info structure
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 15 May 2025 13:28:39 +0200
In-Reply-To: <20250515054904.1214096-6-quic_sarishar@quicinc.com>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
	 <20250515054904.1214096-6-quic_sarishar@quicinc.com>
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

On Thu, 2025-05-15 at 11:18 +0530, Sarika Sharma wrote:
>=20
> +++ b/include/net/cfg80211.h
> @@ -8579,7 +8579,16 @@ int cfg80211_sinfo_alloc_tid_stats(struct station_=
info *sinfo, gfp_t gfp);
>   */
>  static inline void cfg80211_sinfo_release_content(struct station_info *s=
info)
>  {
> +	int link_id;
> +
>  	kfree(sinfo->pertid);
> +
> +	for_each_valid_link(sinfo, link_id) {
> +		if (sinfo->links[link_id]) {

Took me some time, but obviously this leaks memory all the time. The
hwsim tests blew up for me _immediately_ on this, FWIW, so maybe
consider changing your config to have more kernel debug stuff when you
run those. You do, right? :)


Ultimately, also I know I said to do it this way, but now that I really
look and see how the tidstats are allocated on demand, we could do the
same here?

And then you don't even (later) need
cfg80211_link_sinfo_alloc_tid_stats(), allocating tid stats for the link
or not could be an argument to allocating the link?

Anyway maybe we don't need to change that right now, but I think longer
term that'd be the better internal API.

johannes


