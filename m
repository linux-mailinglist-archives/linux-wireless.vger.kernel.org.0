Return-Path: <linux-wireless+bounces-26996-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA9BB43663
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 10:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D03705E7D72
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 08:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3EC24167F;
	Thu,  4 Sep 2025 08:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Pt231lEf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAAD29DB6A
	for <linux-wireless@vger.kernel.org>; Thu,  4 Sep 2025 08:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756976344; cv=none; b=Fetk5v/EpCEsrRCcOUpe5Y0p4X8uPjAh97gwi3qWiNPbyGorBWge9woqyXbgW0CvbQ++YLL8Iix5c+1+MbVEaNQevv0NelpWu//LRWBAcp9Gg7a2l142hKBATSwAM/CbWM6loiu0Y8Ial7FVX052h7lHMiBlT8kjHINiQM6Z4Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756976344; c=relaxed/simple;
	bh=Y95PtDJFrRYeRZ4xKUY1T8W1CTtBEx+hqwx9wMQESqc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R0GddvswIqiDLEH5jPlDbWDUKnBpc7CilXE7ibOP683sswsv43ZsvMJI8FA/LTc8ZuXmpCpqEMyOawa/N3t5/XW0TnvXlVBvDgqP0txx+1Ep1Gf5lCFhZFNaY3ujW+OZRcXI8kNh46jShqrDgVH7t6YYc72MLtW9ywJsld+4TV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Pt231lEf; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Y95PtDJFrRYeRZ4xKUY1T8W1CTtBEx+hqwx9wMQESqc=;
	t=1756976343; x=1758185943; b=Pt231lEftn4+bfWt/vJRdjcqQmCJMHOSY0M0AMfz9w7v0nl
	8IIlM4ILx8EDNW930xesCtYWm0W/4Kr6QLcqZDStVMXSiKa5McV/7JGpWUwb+zulO4c1+5rE8K1CC
	YKPGHHJ1DRpMckpAVZ07kpXrASqH1eQ4H8MSjTsDYTzBrszmS644MdnthjDOGMapfzkKvZwzNUx9l
	+1cAPp0aXCzaLsX1ymig+lUWziFjV3akQb7iuQ6Z/ig8qK//pVASJfPBGab5gHT24FXkodFNQ2hwL
	ns94wcsPjpp3c+PtprS4aj0y/L5lOfTeEcyT07HXO900QcHdnsUJLZSTYQkuNLIw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uu5o3-0000000DsXC-39DM;
	Thu, 04 Sep 2025 10:58:59 +0200
Message-ID: <89df15828ef732a32b0681a3a7a2308170d80386.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2 1/2] wifi: nl80211/cfg80211: Add
 last_beacon_seen in station info
From: Johannes Berg <johannes@sipsolutions.net>
To: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 04 Sep 2025 10:58:59 +0200
In-Reply-To: <20250812114029.23538-2-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20250812114029.23538-1-maharaja.kennadyrajan@oss.qualcomm.com>
	 <20250812114029.23538-2-maharaja.kennadyrajan@oss.qualcomm.com>
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

On Tue, 2025-08-12 at 17:10 +0530, Maharaja Kennadyrajan wrote:
> Report the time since last beacon was received for each beaconing peer to
> userspace. In MLO, this information is reported per link and additionally=
,
> it is reported at the MLD level, the timestamp of the most recently
> received beacon across all affiliated links to give a unified view of
> beacon reception status.

Is this really appropriate? We already have NL80211_BSS_SEEN_MS_AGO,
which is updated per BSS/link and could be used. Perhaps it needs to be
split over multiple values for probe response/beacon, but I'm not sure
that's critical?

Also, I'd say really that "seen X ms ago" is not a good value to give,
and even in the BSS we later added NL80211_BSS_LAST_SEEN_BOOTTIME which
is far better to use since it isn't subject to drifting between "when
the value was taken" vs. "when the value was used" and such issues. For
this reason alone I'm going to reject this proposal, but I'm also not
convinced that something like "LAST_SEEN_BEACON" should be part of STA
info, when the stated purpose could be achieved with the BSS info?

> This allows applications to detect potential beacon misses and make
> informed decisions.

Also, this really calls for extending CQM instead and having signals on
beacon loss, rather than userspace _polling_ for this information.

johannes

