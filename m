Return-Path: <linux-wireless+bounces-3457-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3071851684
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 15:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E517AB26A8E
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 13:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292F73FE2E;
	Mon, 12 Feb 2024 13:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="GPqc1R5s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9448C3FB2A
	for <linux-wireless@vger.kernel.org>; Mon, 12 Feb 2024 13:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745531; cv=none; b=DrTbR0KZWpG65S3ULPFGa0O9E8/8xjnGP2buvsEkifREIL1gZo+r5wrDGqjTkPpQt+LMC7RqY6qHhMBfrVO87FeEtgF+T9hqSpQWTR5hhjQ2pnwVY1TXjvOTntsOwBqfBFyRYO6g8hGxLQjOyFZfbJIjKszbcZitAeI/4KjsxzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745531; c=relaxed/simple;
	bh=qzgKZ4ORxZPsF8tez1/2hCRYo8Z5AhlKpenHGCnY0Ag=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=suaFaNN7xsbuke1DG/iC3EobXfZ/27YMQkgaSePRnpLfdsoieB4LhFwfL0dcCbgCv8lmaGP0gE0lqCthl9vx8+3hZnLA6xeq0fNmUIb5EqfcfAmFQeq7Nsb9caGgCStjIidzNPXwfGtwDl/mJiEojGhWUqJrcnMRiH40L0mjdx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=GPqc1R5s; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=WQik/vQQ5fYkSAlPnsE7CTzqAybl/Up/d/dGFWV+6bQ=;
	t=1707745528; x=1708955128; b=GPqc1R5sI7Bhe/YRpkDlCOi2QBJ+dZQtt0JLsPrTB6BaEtP
	30JCxWIldYefoUWOUIjEm6bDlUbbGpVD5ZTkdbvWQeDs0RvdyDGcFhwlc1BDGDpNMo1DCYYOBF1ZX
	oEbxN41f7c3lZ1hViuTjZBwdJ2arhtEdQuljao0Mj2k93iaHI4eiBtnURczAkd/gzWNOTdrz8LsMk
	ryHKO3+8kW1XiQuti4NGXiIzj4OIu1E47AE2whvTOwaeaZht09SH5vcEjYRO5xAwjg9BLorB5H4WW
	vua9dsgAHxwQNaBXqLVTDJhiNEHZDFF1SsIp8uGkOnEx5cCawxhRztiQa3dACbkQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rZWcf-0000000699d-1RpF;
	Mon, 12 Feb 2024 14:45:25 +0100
Message-ID: <25c51905aac00bde0591d169d00b301c608234c5.camel@sipsolutions.net>
Subject: Re: [PATCH 3/8] wifi: mac80211:  make associated BSS pointer
 visible to the driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org
Date: Mon, 12 Feb 2024 14:45:24 +0100
In-Reply-To: <20240206164849.6fe9782b87b4.Ifbffef638f07ca7f5c2b27f40d2cf2942d21de0b@changeid>
References: <20240206145411.3217588-1-miriam.rachel.korenblit@intel.com>
	 <20240206164849.6fe9782b87b4.Ifbffef638f07ca7f5c2b27f40d2cf2942d21de0b@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-02-06 at 16:54 +0200, Miri Korenblit wrote:
> Some drivers need the data in it, so move it to the link conf,
> which is exposed to the driver.

> + * @bss: the cfg80211 bss descriptor. Valid only for a station, and only
> + *	when associated.
>=20

For the record, I'm dropping this patch.

Yes, the data is there in the stack, but the cfg80211 BSS contains data
that is not authenticated (from probe responses etc.) whereas mac80211
is (hopefully always) operating on data that is authenticated with
beacon protection.

So exposing this to the driver feels fragile - if it actually gets used
for pretty much anything, it won't necessarily be authenticated data.

We were planning to use it for just the RSSI, which is probably fine,
but we can do that differently.

johannes

