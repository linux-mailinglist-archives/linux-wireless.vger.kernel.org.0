Return-Path: <linux-wireless+bounces-8072-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FF98CF8DA
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 07:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 401E1B210F6
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 05:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6249D266;
	Mon, 27 May 2024 05:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="kAJchzDk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB871A2C28
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 05:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716788496; cv=none; b=heKrwBhjnY0C8kYU0NIeOsjbRaN0B+RJxD4bwcbrsJhS61o6hTPr5ax/Sz4RwUqrlkLIEYh29dMTwXcEn+KiK2bJ/RgskpId/keucQA+ZjOKFknR0obab8ipDdyXxz/FRypFEy2GxwMu5hHQsbaXSQE7B8lxHVOt4csg59Hft4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716788496; c=relaxed/simple;
	bh=7Zgy3yIwyj97/6Z9pGrgGBjg3cjGtk/SS+82VeVmqRU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cj6sVi/pJjt+83lTzqc84SMSKVnB2H/rCtKHGnQLKXmki0+gSLEIP1Ki6tjbMsbgARLvMfHHi17277R0WCZs0VZcahc7mxpw4UEb+ru/ucx2BI5x4D0zBDyEZOOzteV82tR6NRN9S6dzfy6X8A7mhtaQG/j5d2sNc267c6w0GUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=kAJchzDk; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7Zgy3yIwyj97/6Z9pGrgGBjg3cjGtk/SS+82VeVmqRU=;
	t=1716788493; x=1717998093; b=kAJchzDk1QjKmC6SFTFlWKCJHRzBr5Zf1GjyQ9/IQyCLv9U
	2EXxlFu38zs62yBUEBpKh8MTdUW4FIp8ScmmDvFrTZhKGDvxrVs1TBFJcNOJ+8t/0JiVhxzuttJ2r
	Jxg85zxT5R3i6mmcWvCcAR+vVVhGnseTf43eyTRUi8z4TDHl5fpATDZn0HbGkVM7PnGxa1l7QZtny
	oKfbHY4nUYq88s6mnYUnJkViZHPU8NoIKms1ToMUyiMYTu2fYNbkZFN0dC7KnJB75w1K32AyyWyGJ
	6jeax0ujcZIQ8MdLzMPMSnjEA03y1objNom7H0mjf2Ywhc6nQQVEbHnnA/XGsT7w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sBT6o-0000000COk7-3uEo;
	Mon, 27 May 2024 07:41:23 +0200
Message-ID: <f939f9dfb467d7a1daaf1e69b56f8599ef3eceeb.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: add input validation to
 sta_stats_decode_rate()
From: Johannes Berg <johannes@sipsolutions.net>
To: James Dutton <james.dutton@gmail.com>, linux-wireless@vger.kernel.org
Date: Mon, 27 May 2024 07:41:22 +0200
In-Reply-To: <CAAMvbhGyheFdWSrDzM_i10n9s06n3G2wX6O_S68VUZyP-a9p+A@mail.gmail.com>
References: 
	<CAAMvbhGyheFdWSrDzM_i10n9s06n3G2wX6O_S68VUZyP-a9p+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-05-27 at 00:43 +0100, James Dutton wrote:
> Validation is required as a result of parameters derived from
> received wifi packets.

I don't think I fully agree with that. First of all, this data is never
actually directly derived from the wifi packet (certainly not any
pointers or the band enum!), even the PLCP contains different encodings.
Thus there's always already a translation in driver or firmware.

Now of course we shouldn't trust firmware either, but even then there
are a lot of places, I'd think this is better done at the driver level.

johannes

