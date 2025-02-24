Return-Path: <linux-wireless+bounces-19387-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8057EA430F8
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 00:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15DC13B825B
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Feb 2025 23:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76BF1C8602;
	Mon, 24 Feb 2025 23:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BO40mm6h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D241C6FEF
	for <linux-wireless@vger.kernel.org>; Mon, 24 Feb 2025 23:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740440013; cv=none; b=NczcnT5KEYMyakrztJPEL/JKtZ2gS2o9RhQNRPsYNYFJeKk6f4VPQf6c7J9vgFFiM/k5/CfTnJpEXJh6mpGcp9GaymbndqMqmcQlirCTcCmFla5U90FDrdrH4trbAfm6mULWDbdiJPz8dhIyQD2W/K8rpFtvNjng8Om0NkGnR3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740440013; c=relaxed/simple;
	bh=5gBDUIiPerj/CTuymWq1dGI8/fsGAwlVJk7z6NoTtdo=;
	h=Message-ID:Subject:From:To:In-Reply-To:References:Content-Type:
	 MIME-Version:Date; b=QOPz/IalJhjGwe/NY9nOyjTz2CQj3zlz46oqmI44MX5vS7SgZdiupUlo8EeaAk6H58ZAgoaDI0wbaovFKXJ7L/q+T9kMcCsk4RZtcLbyxM9cdgVQRbE4GJh+iMu7aM/e5/WaUTr9a8e41QGqcB+94u2/Z240ViHkS3WJ/5iqwmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BO40mm6h; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Date:MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=5gBDUIiPerj/CTuymWq1dGI8/fsGAwlVJk7z6NoTtdo=;
	t=1740440012; x=1741649612; b=BO40mm6hwPNTIGAWT1clBj8Hs0dTaQZKx9L0f/WEnXbtFx0
	/1i+3LrEngAeuQjzRADN0HPLTeF3li2QKoe+k20UUMKkCrCXoCWeTkQgnw4b+W9tcxRiS4mhSyvjz
	F4razM0P85w+/JvOpRzxHr8AiC2nk6tWSt12HAKu1m2BP2dRL36zG6uKuUl+uudd+kCZU9SrFd6OS
	PifIYEifZJu6mZPptqzLbHD3E89j7Xb2OYumL7uEr6tQ/7OG0o841SCyiizsmiS9Px3i5BMoeNmuK
	sgH1LZTbJAKFt3UYEm/7m2lY8r/vhj3QDk9eXvOaeA4tQ5MgrjvnQ0oZylJaqVLA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tmhx2-0000000955s-30TM;
	Tue, 25 Feb 2025 00:33:29 +0100
Message-ID: <d361db20975c8f2c88df6c0c11db963f6aaaaf02.camel@sipsolutions.net>
Subject: Re: please use tree tags in patches
From: Johannes Berg <johannes@sipsolutions.net>
To: Ping-Ke Shih <pkshih@realtek.com>, "linux-wireless@vger.kernel.org"
	 <linux-wireless@vger.kernel.org>
In-Reply-To: <eab28c11ea4cc4249c01557121b4741e19cf6a83.camel@sipsolutions.net>
References: 
	<ec3a3d891acfe5ed8763271a1df4151d75daf25f.camel@sipsolutions.net>
		 <a5451ef8e9534ed4b2223f50c3ddda14@realtek.com>
	 <eab28c11ea4cc4249c01557121b4741e19cf6a83.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 24 Feb 2025 12:15:35 +0100
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-malware-bazaar: not-scanned

On Mon, 2025-02-24 at 10:33 +0100, Johannes Berg wrote:
> On Mon, 2025-02-24 at 01:18 +0000, Ping-Ke Shih wrote:
> >=20
> >=20
> > Thanks for the automation. I think it will be very useful for me to det=
ect
> > patch errors earlier, so submitters can fix problems earlier before I'm
> > trying to merge.=20
>=20
> Hopefully. Right now we still need to get the [PATCH rtw] tags into the
> patches before. Perhaps we can auto-detect somehow later.
>=20

FWIW I'm running this now:
https://github.com/jmberg/nipa/tree/configurable-list-wifi

In case anyone wants to take a look and/or help out with the tree
detection.

johannes

