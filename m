Return-Path: <linux-wireless+bounces-23004-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D3AAB8507
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 13:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 728C5188494D
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 11:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D1E222586;
	Thu, 15 May 2025 11:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VlenypQi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69762199FAB
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 11:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747308895; cv=none; b=CNMNrBzFuUOfsMrhRxL8yYxiANweoUiU50RIuAqGzVzfwTkrpqMdAHuBtFNfyp3lGcmbJKOaFnTQ77wDn+Uuh+cv9+qzd0VPtObkWM0xq1yh+wK3fMyQOW357OwhPzNR0t/EX5z8sAaPAEL/X6eJM7ENcBIf9NNlkiZOHEsGEjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747308895; c=relaxed/simple;
	bh=RvweexU8NwCuI68lISSQ34pN7K1Z1yWGFjtNZCTsdM4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NVfEN/3L/edXVxnAqqs5M1IlbYKjKUb7G9q+tLq9zMyDZLmB+tQnx4gwG1Zy04hyPZwHqMu58wRBY9C7kqKwNa0PjCKlV6j/g3fvvFjiSqzU0Lye4EA53eVqFXS2k2ot7DKksAW0tQLG9XHU3iDMY7vsLud0qRX9kbuBySjGtBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VlenypQi; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+sxWZmAAPgzwtBC//Z0ez+W2sYQd4WhX5JMBg8qd/9o=;
	t=1747308894; x=1748518494; b=VlenypQifZOIMqh/SjuUwrAQ/5fhdmiLAEhtUwIOVhN7m51
	tIFPJg5Mhb6IIhs3nztOxbLfq1zUMWKHN++wMgNqkAgSfzRcxsbxbQiTiW5gzMPjuftWyo+nsSpRR
	EUZHxIrHnSZd4MSl9VrEZX3vlmN75u9oE68+7EpWl0NJt0u+d5tHCPujkXuxNZTldp4saydxyNuzm
	9xqJBPcBZvFBYn+ee2CpRzpzju6mGstxohTSHZbEEGHhfGm+elRQOjb83m+hgNyTAJxkKNAajaw4Y
	Hkt5nAme3hk1KCnPechxKmn8Xs7wzteVPQF5qkIDBlcJdH3OyMmjJcDNzr47L6/g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uFWrT-0000000B7Og-2Bah;
	Thu, 15 May 2025 13:34:51 +0200
Message-ID: <16406ee04378160b2f9cc8f4ff5a233c45be2e94.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v8 03/10] wifi: cfg80211: extend to embed
 link level statistics in NL message
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 15 May 2025 13:34:50 +0200
In-Reply-To: <20250515054904.1214096-4-quic_sarishar@quicinc.com>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
	 <20250515054904.1214096-4-quic_sarishar@quicinc.com>
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

Oh ... missed this one when I sent the other mail. And really this is
the one that I saw and decided not to continue fixing things up myself.

On Thu, 2025-05-15 at 11:18 +0530, Sarika Sharma wrote:
>=20
> @@ -6880,7 +7062,8 @@ static int nl80211_send_station(struct sk_buff *msg=
, u32 cmd, u32 portid,
>  #undef PUT_SINFO
>  #undef PUT_SINFO_U64
> =20
> -	if (sinfo->pertid) {
> +	if ((sinfo->filled & BIT_ULL(NL80211_STA_INFO_TID_STATS)) &&
> +	    sinfo->pertid) {

This breaks mac80211 at this point. You also never even mention it in
the commit log.

Ultimately, I see why you did it, but that's really not how we do
things. If we cannot get away without this, then it really needs to be
split out into separate patch that doesn't break mac80211. The change to
fix mac80211 is also randomly interleaved into a commit that doesn't
even mention it.

I would prefer to not do this, but if we really need it then you need to
split out this API change and do that properly while fixing all the
users.

johannes

