Return-Path: <linux-wireless+bounces-30211-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 126D1CEB830
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 09:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F583300F311
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 08:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD451E8826;
	Wed, 31 Dec 2025 08:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="XoZ9pg9z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6C93A1E82
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 08:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767168919; cv=none; b=gIcQ/D5r89Lt/iJZGzdcbs9rek8gn266jsP3+6wMKHMUUo1VXCnatlHUC5MHdRFG3AxV8XGXP3u8OtTaeNy4MIp5Cu0rSYS8axFeuxeiP4wnU+f4tv57DnbnpIYIEAePjKbPH52ih+GNtRfhm9yc4YcgjL0vYyzSeL/beGe5lBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767168919; c=relaxed/simple;
	bh=t0hi9D+HRBvqh8DV7JHRdpg6ok+UYNCnISzM+BKnIy8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ima5uzG8e7y6qtX0+1NHm+z/lYhkSJapmkBxn3k8fW/rAmfFC3d1tgNw2hSuGnZwYnZJ/dUu7+cWAJ6AyJ3l6J5EyqfmV4WtY+X0hZC1DWhjzlMGahKhOz7mdM6n7pqLPvO3DAaS7q20Ed1HE+J4srLsUc0Tout3kwpyo5OGgP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=XoZ9pg9z; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=t0hi9D+HRBvqh8DV7JHRdpg6ok+UYNCnISzM+BKnIy8=;
	t=1767168918; x=1768378518; b=XoZ9pg9zjZ00UToBCDF5jeXM/H7+QBQuF7tmb3pTxShmyt6
	MQswDysiTZ5n0tCmkiFNxcM6+wt/XwjLSaDdhqscemTVBZPcq0GH6gL8Ug0m9o5EGaGxtXQdf91v8
	or3X7+1ciWOiZ10AcePK/ll6zxsd4ZP3rA6Ily71xjSqDsmX9xE8tKXvVmXTVGSoWaYXkd/r9SKgv
	W4iD8YEEMX21wI69k5KpU57IS0B85/KWSPpxK9c8i/pUQIm4Xc6GVpuJxbmNZHGDbCzmyBon1z6/Z
	aCNAPsJRnJEOEy533f4iO14su5a0tWQQYuz5kUuZSEgXmX2sFUOt1iPHzvGeb1Zg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1varML-0000000HGa4-1Bcx;
	Wed, 31 Dec 2025 09:15:09 +0100
Message-ID: <0b3219c015de2623ebd5e18d927a995e97095bfa.camel@sipsolutions.net>
Subject: Re: 6.18.2 iwlwifi broken, API version 4294967294
From: Johannes Berg <johannes@sipsolutions.net>
To: Thomas Meyer <thomas@m3y3r.de>, linux-wireless@vger.kernel.org
Date: Wed, 31 Dec 2025 09:15:08 +0100
In-Reply-To: <72464EF2-D744-4151-AB30-96C1EA41B482@m3y3r.de> (sfid-20251230_233158_225745_362CA8B5)
References: <72464EF2-D744-4151-AB30-96C1EA41B482@m3y3r.de>
	 (sfid-20251230_233158_225745_362CA8B5)
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

On Tue, 2025-12-30 at 23:31 +0100, Thomas Meyer wrote:
> Hi,
>=20
> This patch broke my laptop's wifi:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/drivers/net/wireless/intel/iwlwifi/iwl-drv.c?h=3Dv6.18&id=3D5f708cccde9d1e=
a61bb50574d361d1c80fc1a248
>=20
> The API min Version is shown as:
> Driver supports FW core 4294967294..2, firmware is 2.
>=20
> Looks like some integer overflow for my old hardware.
>=20
> Reverting the patch makes the driver work again.

There should be fix on the way:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dca5898222914f399797cea1aeb0ce77109ca2e62

johannes

