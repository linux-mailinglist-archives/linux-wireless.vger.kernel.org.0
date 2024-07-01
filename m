Return-Path: <linux-wireless+bounces-9759-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F6F91DBF3
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 12:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 822DF2828D7
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 10:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B932384D13;
	Mon,  1 Jul 2024 10:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="TQx4EvB/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F187A46436
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 10:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719828102; cv=none; b=uYEZTzT9sgDVcMZjkf5o7+rhzp+m++mh8YmglMOq91jFUYs8341UgWvXjWpaD4Pnwh+cYevqLtex2AyxuiVVTnlIFmz0G7HPR97qHQyTgSVJ/++tbLwdk8wfaGx0meDupLjX8W6Bns85UW/W/MWYxEBSmFrK8uKZxQVtAHc00PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719828102; c=relaxed/simple;
	bh=tRonO4zHIqSR2rGE3c+22to6niEEbhen9cxGGuaMU1Y=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i2uTEGyQdE5l0bElEuGet+XQhbV4rRpeTV6noZvBpm8b5Z2l2+ruK8Df5AylTdgUKs+7dNwHlb50Q1tC8QYDX0v1fiaHF8AnoDXtxmJ9pnKAOdgrPrWBj3mJBTP7/3x+z496VZDp/+3Aje+2Y3yVkjZEHjlkIwR0vnRJ4nrk1i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=TQx4EvB/; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=tRonO4zHIqSR2rGE3c+22to6niEEbhen9cxGGuaMU1Y=;
	t=1719828085; x=1721037685; b=TQx4EvB/Z63kqUK03qCQzRGbkRMpx60HP0LC78mTLHzCVEb
	OyKutA4yKpSnzrk9dzY0pA0Kweq9wMj3ZqaJb54tudqDaxQIi0+SUQhzNPZE6Hr30gSm2Cpn9o5cQ
	c/BYelmcrhnLmNxFMB9tWaGuzXRzKuiM0hfWUHx87eUX6iUjtxSl292sAbn8BMpls1ESbf2JhnG8c
	5hAJodEHFROjMX7y27XsJYepdsVIToLvj+m1JDSRtt6xM0NLMkWp697CUqZFQXQ4ecybnn+fcMsH+
	mkedEQaw0vwIPH6Utrzs0BplDcYUArVgQtvpopGBuWrGO1ttOl5XPvDpuqV73bhA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sODqY-00000001xU0-18Fg;
	Mon, 01 Jul 2024 12:01:18 +0200
Message-ID: <8f826bf3e6c2a676c4db37fdfd5b10e364abbb51.camel@sipsolutions.net>
Subject: Re: [PATCH] iw: fix formats under MIPS64/PPC
From: Johannes Berg <johannes@sipsolutions.net>
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Date: Mon, 01 Jul 2024 12:01:17 +0200
In-Reply-To: <20240628223237.16222-1-rosenp@gmail.com>
References: <20240628223237.16222-1-rosenp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-06-28 at 15:32 -0700, Rosen Penev wrote:
> __SANE_USERSPACE_TYPES__ needs to be defined to get consistent 64-bit
> type defines and to fix -Wformat warnings.
>=20

How does this even work? Pretty much every file I checked in iw includes
iw.h _last_ (or close to it), after netlink, nl80211.h etc., so ...?
Doesn't really seem like it would have any effect?

johannes

