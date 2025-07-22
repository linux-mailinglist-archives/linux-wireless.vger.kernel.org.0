Return-Path: <linux-wireless+bounces-25837-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D38B0D503
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 10:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0227E189D622
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 08:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CD72882D9;
	Tue, 22 Jul 2025 08:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="MYGNOhiq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25E32D3EDD
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 08:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753174453; cv=none; b=ptnjsZIGk7XbQUZqsgFB8iEKa2grcmZv31ojIGz79RDaQDwQNwhG9swXvK+phZbmLFFYuSvvdItUunER611x8+VwFLjTeB/hD8dhHJOSdT4MCWFvxoS2cVpID2vFniXtk92CywraL3ywrbegk9mzpoC1SZf6QCxOs85yxMVj4Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753174453; c=relaxed/simple;
	bh=yNAmYcBAIlQbXRUUSryI+m6ZQTVuU3MAFLZm9YeRA64=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sCXl+WaU1NDUABFrhbLuJULHuMA9PT4OtHqIDwOoXuxMBzLGGhfbBTsPJT2PI//5aFXsT3sl4/Y3jn7DwychgZoBd09d8LsejO39wHUPsGTTOQldHUA//GjoBjyerPXnSVlhDJp+gsoG5lmnrN+Cchy+04aJQc3YzllL0B8WEuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=MYGNOhiq; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=4joROtDeJohv2PbOD5gc05LofvOCNxjGKsXkFtXtHHM=;
	t=1753174451; x=1754384051; b=MYGNOhiq11CEBka5oXllA3u9A64Sck987yTZUfTq8feRjfZ
	KmFfIQ0vy4zj+UmPR3vLmpl1HiTferh2dVuZWluCy77tOZBQ+TNAnVLJCYZDef6wgyVGvByfoOAII
	aUNTzjC8VbV2zsZ74m/D3Y4bjNCa4khMOW0wyQkr+K4LdUBaqnZs3o/pQ5wosnZBt3pNN9xV3bEQX
	isi/SBMiNP90xSs/p21Z8mw7C/vX5uTPHuPGujwcMF3Q4Tq9rrTrKdKUNoTmMJHOv+TASA5YsievW
	l+Wnx1A5545NDqb4M8KRIIescdvRApXfRdM6+aIK1u9abE6/fWC8KcFK209ik0eg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ue8lD-00000001q68-1maq;
	Tue, 22 Jul 2025 10:54:07 +0200
Message-ID: <cdfcd722e1f8527809d89e13484bcb25d3e74947.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: fix unassigned variable access
From: Johannes Berg <johannes@sipsolutions.net>
To: Antonio Quartulli <antonio@mandelbit.com>, linux-wireless@vger.kernel.org
Cc: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 10:54:06 +0200
In-Reply-To: <20250721211736.29269-1-antonio@mandelbit.com>
References: <20250721211736.29269-1-antonio@mandelbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2025-07-21 at 23:17 +0200, Antonio Quartulli wrote:
> In ieee80211_latest_active_link_conn_timeout() we loop over all
> sta->links in order to compute the timeout expiring last across
> all links.
>=20
> Such timeout is stored in `latest_timeout` which is used in the
> time_after() comparison before having been initialized.
>=20
> Should the for-loop terminate without ever setting `latest_timeout`
> we would even return it in its uninitialized state.

It's really not plausible to have no links at all though.

So I think if anything we should worry about the=20

                if (time_is_after_jiffies(timeout) &&
                    time_after(timeout, latest_timeout))
                        latest_timeout =3D timeout;

comparison, but for that just unconditionally setting it to 0 is really
the wrong thing to do, since it means you compare to an arbitrary time
zero here?

johannes

