Return-Path: <linux-wireless+bounces-23006-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E664EAB850E
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 13:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F377162E20
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 11:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7A1222586;
	Thu, 15 May 2025 11:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="yQuZD8qO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA74D199FAB
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 11:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747309013; cv=none; b=LH061rknIz0DzBw78BxuhXJuFwu5aENAZzmSQ7nakRwBh/Qd6oGXw/z2yBQOwGjRm5xq67UZnFRKgCoVJBsdPR8Prcx2zanSat0li7IbOC8tgqpDM3zRND4ZQ9OYORhbWW1TCGokLnsnwUDYM5QokDK1DKJJeG6IOLlUv8nHc8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747309013; c=relaxed/simple;
	bh=XBbEDElvFYQ33q2GzIrcz7ikcPW3BWvufllQH0NidWU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ul63czN1Do44/2WL+fmVVoEaC0YylRzXNJh7HWYIgBu7dUuelP3IOMA79QmRZHvtwgXHCR3qWMLBNy+M1IKwZ+ogTmcxx1AfuSU6V1JRoaNKxhnSDptcXlT/GEGEDxaGglN25lJ+l20doHkaVNKpeCiXIM3Q8c7JByAtEujDaPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=yQuZD8qO; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=FqAxVVAthSXgf0ERQGG95J3DAi5UkGpwyC/ZmRgbElY=;
	t=1747309011; x=1748518611; b=yQuZD8qOEEgV5kXhxw7hQR0PuhaWP0Fs+9l8ZaMlnYVgX39
	yf85JeSYZDOq4Pu63kvUQP9zJoFStOJuyhY+o28MEAjyxV6vdYVhRq/Vwm90qoVI778e+OPw/zqOz
	q7MaKKI2QUaRA6XtV3Xn08QJ9UjtZWPgzMuHN4LTphyU4H6HERVxyt5CBo4bY3wT+ifBNzraZP8f3
	gVOF8GUciGsUoak8ryxb5wI6hKN+YEC747bp6bQc84LR7A6VM7wdpgCCA+Q2G2Hq3yilIke2bMpHN
	nP/yRZM0Pt/tUOHMZjnwY6ZaJNa4zpdPg4El0gwGEaMxoMtp36CZcaZ0V9j6/kWQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uFWtM-0000000B7gq-1eWr;
	Thu, 15 May 2025 13:36:48 +0200
Message-ID: <b6aa1823646f6911c6dab8db973398bda8526a9a.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v8 07/10] wifi: cfg80211: reset
 sinfo->filled for MLO station statistics
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 15 May 2025 13:36:47 +0200
In-Reply-To: <20250515054904.1214096-8-quic_sarishar@quicinc.com>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
	 <20250515054904.1214096-8-quic_sarishar@quicinc.com>
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

On Thu, 2025-05-15 at 11:19 +0530, Sarika Sharma wrote:
> Currently, sinfo->filled is for set in sta_set_sinfo() after filling
> the corresponding fields in station_info structure for station statistics=
.
>=20
> For non-ML stations, the fields are correctly filled from sta->deflink
> and corresponding sinfo->filled bit are set, but for MLO any one of
> link's data is filled and corresponding sinfo->filled bit is set.
>=20
> For MLO before embed NL message, fields of sinfo structure like
> bytes, packets, signal are updated with accumulated, best, least of all
> links data. But some of fields like rssi, pertid don't make much sense
> at MLO level.
>=20
> Hence, to prevent misinterpretation, reset sinfo->filled for fields

                                       ^^^^^ clear?

> which don't make much sense at MLO level. This will prevent filling the
> unnecessary values in NL message.

Not sure I'd say "unnecessary" but perhaps misleading? I'm also not sure
this shouldn't be WARN_ON, we're throwing away data that was provided.
In mac80211 it even allocates tidstats memory for nothing, in this case,
that's super weird?

johannes

