Return-Path: <linux-wireless+bounces-11703-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2734995882C
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 15:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A0C61C2163F
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 13:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170E41B7E9;
	Tue, 20 Aug 2024 13:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="A0syOHm/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436FA4C91;
	Tue, 20 Aug 2024 13:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724161543; cv=none; b=vC1D5p822LScJnSBHkp9UlqHF/Y70GDZ2bc6yfv8VYxWpx3TD/NlD/73hQB4RCjZaHC0iltMrgfRo2qiTLWjqh1bt75G0AnKnOR/60JVyp5FPXj+8TUrKwR+CsZl4JW6iS2ieVGexENVVCZ5oSj74/OZV1P6gEabgTheNN5O/dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724161543; c=relaxed/simple;
	bh=SvqOxYQTEu8OqWJcfU+xaitz70aQ1h6/6a+Imkxtk8I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=JuwRv/0LKB1rnvuyTCz72zalTK5KBb5lFNG2PbtsslyRxB/zKQyjRhn+kmLOZmgn8Q4JvCKVhxloNlZB5GePqwbrn6nzJ00STN+osydYcQICQtDz/6Ums9jroMyHdcDIvk663LzTsuarKT++Dg8Odd13nw9orMgJb9DYwkiO0BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=A0syOHm/; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from [127.0.0.1] (unknown [176.200.89.26])
	by mail11.truemail.it (Postfix) with ESMTPA id 8C03321272;
	Tue, 20 Aug 2024 15:37:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1724161046;
	bh=SvqOxYQTEu8OqWJcfU+xaitz70aQ1h6/6a+Imkxtk8I=; h=From:To:Subject;
	b=A0syOHm/0xlkS1Ot1kKRnBpdxDne5SKeLtCv6zkcqYPT8yfMs8MBbJbh7ldKne67+
	 4hN+nTxxaSMepI0WZdDgheiwyxvfrcetBXY3Qyk9GIOrGSAfFAXW8nB+tCQ2hu2cRV
	 LztS1jy1yooEgijfo7ypk8xpO56R7Pm/20H8lmxuzTBFuFmaJqja5iB/aHahqc7jJk
	 CAcg7HgT043JPBC0+XVJFGRU0Ps53sDYYBxMVqEnRG2eRKJjcK+CCWoe7Veqqb4CIV
	 utqQhA0qg+UXjiBGwB85OG9EFQwCqrIGuTvJ7PyNVTug5wmR0SxOIPg4XYVMMoGHbl
	 6NkhtAa70aV5g==
Date: Tue, 20 Aug 2024 15:34:12 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Sascha Hauer <s.hauer@pengutronix.de>,
 Brian Norris <briannorris@chromium.org>, Kalle Valo <kvalo@kernel.org>
CC: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de
Subject: Re: [PATCH 00/31] wifi: mwifiex: cleanup driver
User-Agent: K-9 Mail for Android
In-Reply-To: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
Message-ID: <1B5E3131-0595-47A8-BB8E-14B7B6C3FA7F@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello Sasha,
thanks for the patches=2E

Il 20 agosto 2024 13:55:25 CEST, Sascha Hauer <s=2Ehauer@pengutronix=2Ede>=
 ha scritto:
>This series has a bunch of cleanup and bugfix patches for the mwifiex
>driver

Would it make sense to sort the patch series in such a way that bug fixes =
can be backported to stable/long-term versions? Are those bug you could rep=
roduce or just something you noticed while looking into the driver?

=2E=2E=2E

> 24 files changed, 365 insertions(+), 729 deletions(-)

I had a quick look at the series, and it looks fine to me, I'll try to hav=
e a proper look in the next couple of weeks=2E What I wonder is what's the =
risk of introducing some subtle bugs because of firmware differences, what =
device/firmware combination were you able to test?

Francesco=20

