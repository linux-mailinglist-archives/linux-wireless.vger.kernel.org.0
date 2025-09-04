Return-Path: <linux-wireless+bounces-27001-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E626B43710
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 11:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 372661C2631A
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 09:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D1713D2B2;
	Thu,  4 Sep 2025 09:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="u5LrCuE1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6E02F39C8
	for <linux-wireless@vger.kernel.org>; Thu,  4 Sep 2025 09:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756978024; cv=none; b=uJ/qg49PPiwMIeBVWNicFVozlesPekzzQryr5DiwBrdzcNUkU+9w9kF1mYhEFi1FM7asV3MCOKwTcy4SJjl1L1/tRZwU0j0tXQWzea2InFsJEgNT3tmgsTY3HkPZdd1a3fZqaBqeStPwGmzRNCNCEGeXY+wK+XO6zHdwkF8ctKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756978024; c=relaxed/simple;
	bh=7WoVLXe/6QPeuGjWCSIeIoy4AsAfSO2x6JGqKyYuHUI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mVE9iDpcQ/6e6TjXyetLtK7zOzLHdWbn1OYztOZgKhPqa1S3n60Z2dUvbVdTNrYs5l6kfBQtM2el6iZNdtRhaqYubpWzNDR4CEe0rY97R6sJcfmoPULdAyUnv+RY3HzaUGVij0E4oiEwU9yYyg1Suz986hpn9etdaX2+FlQyMyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=u5LrCuE1; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7WoVLXe/6QPeuGjWCSIeIoy4AsAfSO2x6JGqKyYuHUI=;
	t=1756978023; x=1758187623; b=u5LrCuE1A8LgqF/EczPy7KkYrpQBner6WTlWRKH1pE1rqDu
	RshE6tzz9mN/LDwJ3W3S8YYLTvLD+8CL5aFJaDBMwc3YhZLDqeZT3eg7NGM5N3jD1vjrrvjYUhNat
	rnb4V9+EEds4GlH4f4BRSO3da44lJFFrwfoQ1O7oR4fYqGqUjpsTZVk8dtCb2w5goGgtFRA6VIfQa
	DE/Om7Ka40znN+TRrEHwI+HRfGep08yuiVp9U1M9U02OKQFQ3zSczECBoT5/p+++kEuse66EDa91z
	K1DymmWAOj51sDAhVCtgTHqjAq17Eu+WPjvOQjLV4s/1kDGYlXjLJkWVxoXeoqhg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uu6F9-0000000Dv97-3RmT;
	Thu, 04 Sep 2025 11:27:00 +0200
Message-ID: <ce5f2bd899caa2de32f36ce554d9cada073979c0.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: mac80211: add tx_handlers_drop
 statistics to ethtool
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Hari Chandrakanthan
 <quic_haric@quicinc.com>
Date: Thu, 04 Sep 2025 11:26:58 +0200
In-Reply-To: <20250822052110.513804-1-quic_sarishar@quicinc.com>
References: <20250822052110.513804-1-quic_sarishar@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-08-22 at 10:51 +0530, Sarika Sharma wrote:
> Currently tx_handlers_drop statistics are handled only for slow TX
> path and only at radio level. This also requires
> CONFIG_MAC80211_DEBUG_COUNTERS to be enabled to account the dropped
> packets. There is no way to check these stats for fast TX,
> at interface level and monitor without enabling the debug configuration.
>=20
> Hence, add a new counter at the sdata level to track packets dropped
> with reason as TX_DROP during transmission for fast path, slow path
> and other tx management packets. Expose this via ethtool statistics,
> to improve visibility into transmission failures at interface level
> and aid debugging and performance monitoring.
>=20
> Place the counter in ethtool with other available tx_* stats for
> better readability and accurate tracking.

As much as I don't like ethtool for wifi, I guess you found a use where
it's actually the right thing to use even in wifi ;-)

But why not remove the old debug statistic, you have a superset now?

johannes

