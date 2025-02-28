Return-Path: <linux-wireless+bounces-19587-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A849FA49A7A
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 14:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A3A31896F19
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 13:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459EE1D555;
	Fri, 28 Feb 2025 13:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="SyIbqXtV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C326926D5D0
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 13:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740749063; cv=none; b=TkOyOyhmr3CI3yw8M7tWX6cQQDX0Z/s4otfga+aTh0VTvJGzCCSMGIln86cRRTDbOHARUSXy9O+/WEUzo1MzHVeEnLQFl+hB558hTv/7eYIDC4y9/WHXQwVVdJDJkP7mNCawj8bSHP9dYjhdeqAyGlfp07FkjbYTuN6W8mcrPaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740749063; c=relaxed/simple;
	bh=miZTomS2gc1hKgtLgZqpu6CQOTwtXBC6mtHSU9DlaVs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GXdfwu+qp3ipPo1NJlUFsjJXdGLbqEQ/qL2rRpckc93XApi2etUaFSxr5l6sXQ2zpM222I4llyCOA+uNdotqzp386VtQolePVxrAaGv5IOlLwwpJGTuypqXzd29tOur9cnDFAVVqQkQjIy5UYKncNEZQZ5qu1bmVuYic2iNF+Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=SyIbqXtV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Txaf6UFAAgzNahSjZ8ZZZcIjQ/6sEdp68hB67xgGneM=;
	t=1740749061; x=1741958661; b=SyIbqXtVNy62HdcjbyA8w+cX7S6LF8pazbBHanFtu8M4lQq
	Wouzfh+rZQNekKhMXmdcl0AAN+mQEG0JVy4+MM7CcMThrI58eqfb4LXrSa8Y3n760+6rlm3FrgkNY
	76Bb80b8fBmWVndr/nfycWyhUmP/Y9XVMI53rRhOIWvlka+HxHj2Avpy+neilhPAyAF3ziiI3TbeS
	aEiDtViokkem1MP9Wp7aBzrHo5cmQCSAisdyqGM3VCpOjmjIa204RAMxt99cbjDeQy71HcRq+tElC
	D1PNdx9RghLXzURtnQtKj/NFHm5iuXzvo2rQKIDQfpNlp0AiDI/RJRIg72vwGaKw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1to0Li-0000000DlEZ-2WMi;
	Fri, 28 Feb 2025 14:24:18 +0100
Message-ID: <a43e6d8c29765d063e05d5c31bd0ee305a9d2a45.camel@sipsolutions.net>
Subject: Re: [PATCH v3 08/12] wifi: cfg80211: add flag to indicate driver
 supports ML station statistics
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 28 Feb 2025 14:24:18 +0100
In-Reply-To: <20250213171632.1646538-9-quic_sarishar@quicinc.com>
References: <20250213171632.1646538-1-quic_sarishar@quicinc.com>
	 <20250213171632.1646538-9-quic_sarishar@quicinc.com>
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


> +++ b/include/net/cfg80211.h
> @@ -2158,6 +2158,9 @@ struct link_station_info {
>   * @local_pm: local mesh STA power save mode
>   * @peer_pm: peer mesh STA power save mode
>   * @nonpeer_pm: non-peer mesh STA power save mode
> + * @is_per_link_stats_support: 0- for non-ML STA and for ML STA,if drive=
r
> + *	offload link decisions and do not provide per-link statistics.
> + *	1- if driver provides per-link statistics.

Seems like that should be false/true since it's bool, but I also don't
really see why you need to list the values at all.

Or even need this extra value at all since you have
WIPHY_FLAG_SUPPORTS_MLO_STA_PER_LINK_STATS?? And perhaps that should
rather be an nl80211 flag so userspace knows what to expect? Not sure it
would care though.

> +++ b/net/mac80211/sta_info.c

Don't mix that in where not needed for API changes.

johannes

