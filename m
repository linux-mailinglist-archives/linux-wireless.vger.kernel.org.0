Return-Path: <linux-wireless+bounces-18072-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B474A20CC7
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 16:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57EE77A056F
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 15:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D93E1AA1D2;
	Tue, 28 Jan 2025 15:18:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.tuxdriver.com (syn-024-142-217-070.biz.spectrum.com [24.142.217.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B391A9B3C;
	Tue, 28 Jan 2025 15:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.142.217.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738077484; cv=none; b=pTh/q6Em7hiAYjFF9GntqpaWwzSrS6OIHsLlTIbkBCbWFrYnjvRM0Z2gPrXwaOgobhQZJmL3gN6PyAI0cn+rQVfdNRq4LbZ1PLtgTpDZUHNsZj2SnnPAIbGGTXWwrxp4UFDlN9YrF410qa77WUu90FMpYFeqbMd2PA/x/OIe9Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738077484; c=relaxed/simple;
	bh=TIBv4NlUcxSz0MrG0z1HzTVcDJNQoUHXG1soaUkyDk0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KzbMVKIbifMO9/IFHf2yrGe3cgzJ5P+x0Ku7+TJhmRN0t85xTM42ObkCj12JWdW3AHltec8qk6wPKyim98kr/GvPlpeJcFaocQ/7eYo+53E7+r62dOdWk9my7U0xq37jCj82mrR63KUfT1Xv3TwoI6MEGADcGOBjDYkVBGQEmjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxdriver.com; spf=pass smtp.mailfrom=tuxdriver.com; arc=none smtp.client-ip=24.142.217.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxdriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxdriver.com
Received: from syn-024-142-217-066.biz.spectrum.com ([24.142.217.66] helo=linville-x1g7.hq.tuxdriver.com)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.63)
	(envelope-from <linville@tuxdriver.com>)
	id 1tcmKx-0003xb-7J; Tue, 28 Jan 2025 09:13:09 -0500
Message-ID: <e64c416a975d8fcc4e245db78f31b0daef358e89.camel@tuxdriver.com>
Subject: Re: Stepping down as maintainer
From: "John W. Linville" <linville@tuxdriver.com>
To: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org
Cc: ath12k@lists.infradead.org, ath11k@lists.infradead.org, 
	ath10k@lists.infradead.org, Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 28 Jan 2025 09:13:01 -0500
In-Reply-To: <87wmefguqt.fsf@kernel.org>
References: <87wmefguqt.fsf@kernel.org>
Organization: TuxDriver, Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -1.0 (-)

On Tue, 2025-01-28 at 11:20 +0200, Kalle Valo wrote:
> Hi everyone,
>=20
> I'm stepping down from all my maintainer roles. My first commit

Well, my friend, I suppose the time has come for you to move on to
something else? I truly hope that something exciting and rewarding
awaits you!

You have done a great job in this maintainer role, and I am very
certain that you will be missed. Few people realize how thankless such
a role can be, but I do. I hope you will now have some some time to
enjoy your sauna as you consider what comes next for you.

Thanks for the job you have done.

Terveisin!

John
--=20
John W. Linville	Someday the world will need a hero, and you
linville@tuxdriver.com		might be all we have.=C2=A0=C2=A0Be ready.


