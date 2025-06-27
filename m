Return-Path: <linux-wireless+bounces-24612-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B215AEB187
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 10:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDBF64A5E66
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 08:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CBD238140;
	Fri, 27 Jun 2025 08:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="DUAI5z3G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1491D17741
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 08:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751013886; cv=none; b=VWsWAtYUAkfDjID3+cjnfGzAcWVY2N47fSeghQzG7CvqPzzrXZmPJM145h/NtQVh0sDX+/iVmaU0d3NskQk4h8R8duaO3drujjifEDmMGiVTkyifS70QeTBJy/lU/ZJuJH+DWjLt2SYsLDTOiB/psKF9bKA9IuNxmMBW4rLFWRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751013886; c=relaxed/simple;
	bh=hgQgqlItzroAO+D12nS1YTy7S3D+IWMz2iywABo3Ti4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KH9i4khlDaX2sN7MFXvPRF1v/uNHvwpJp6boCG7raV3lnL7GWOrczxwEpdk+035ZS37htz6t3jozouy+aCLHXl+a9ltXgeh4n+nC5jHPYNPzyo8frKyR7e9lMTmhF1N8qUnOrz3V9cUd4g2ZxvRgoZMiTnuwwQ3wcCfMZ2fbbj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=DUAI5z3G; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vpVGkJbMgvHfMABFz/3DI9h5fKp669KqKfmGkcC9ZRI=;
	t=1751013885; x=1752223485; b=DUAI5z3GV5SG3zbv4E+y5rJuqlXGbz5wWg1udh5CUNIIZ0n
	WEvANwp8k2cF1gUJNk8E0U/BDyotTK11YCJtbgP9Sxk9La/+wYf96sDeuU2EuC472xlEm3MRAZhAK
	R6J0m5Ddgyw5PKzkGJ/CEeZgdNdUXVGel0tm07ao7aosyH3lffKQzDoO1Ukzfe1y0kue95Jd1rzz5
	bhMdiujH09b0viu3s+dWjh1e2joFPCQUlxf5WQ0cQmuT/V+B8iM58tNmUwOFrjJDNs3l2t5a18I/E
	UDoJfcdY0GJRSp1p+xmOBluIpRVo3h0a7x1nOInxX+TuoNHddFJUpLTUQrk7n5Jg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uV4hI-0000000DOKK-04o0;
	Fri, 27 Jun 2025 10:44:38 +0200
Message-ID: <d7c932775750d9f9be6eee470a52ec3b34a7baf7.camel@sipsolutions.net>
Subject: Re: [RFC 4/5] wifi: cfg80211: Add cfg80211_next_nan_dw_notif() API
From: Johannes Berg <johannes@sipsolutions.net>
To: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 27 Jun 2025 10:44:30 +0200
In-Reply-To: <20250622222444.356435-5-andrei.otcheretianski@intel.com> (sfid-20250623_002844_715376_FEB65046)
References: <20250622222444.356435-1-andrei.otcheretianski@intel.com>
	 <20250622222444.356435-5-andrei.otcheretianski@intel.com>
	 (sfid-20250623_002844_715376_FEB65046)
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

On Mon, 2025-06-23 at 01:24 +0300, Andrei Otcheretianski wrote:
> Implement and export a new API that will be used by drivers to notify
> user space about upcoming NAN Discovery Window (DW).

Seems there's not that much point in splitting a 67 line patch and a 7
line patch (#3) that really belong together?

> +	if (!wdev->owner_nlportid)
> +		genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy),
> +					msg, 0, NL80211_MCGRP_NAN, gfp);
> +	else
> +		genlmsg_unicast(wiphy_net(&rdev->wiphy), msg,
> +				wdev->owner_nlportid);

I feel like perhaps the new design should just enforce the owner?
Otherwise how would all of this possibly work ... any application starts
listening and sending frames? Seems like a recipe for confusion.

johannes

