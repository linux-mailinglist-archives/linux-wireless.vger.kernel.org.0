Return-Path: <linux-wireless+bounces-9796-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C50A91EAB8
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 00:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AA511C21327
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 22:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6C78120F;
	Mon,  1 Jul 2024 22:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="sQGmfEIG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33A74F602
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 22:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719871849; cv=none; b=ES+Gix272SNe/OzKK592LuRO6/025ZNzmRqftMtPn4q/0gfYGMbWu0o52hOYZm6dfS/Mk88aZAO0Esh7gL8mbhcpXN7WKD+3GilntJFadIrr0tpN18VODQJBYsC3t7lQY1O7g6p7xeIBK46aXDI/uiTipmryVUGra5wt/nD9ruI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719871849; c=relaxed/simple;
	bh=ss+AaO6IVNmgGR0bOacCjSN1lvUB/QugnVLrVOXNX2A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H142qFRD5ozoSELboxut+h9bvMIaddMfDZmZUyFAHANcBcDaIy5rIG18hLQBf69aXXgjYU/ErC+XRw/VTKxMmuW/Aqb9xYRbwG3xzu77QUNPNq66/jvBtnZmlpxsCSTmb/rqyQcUA2eRupWRu8zV8rYGUmUA2wqiJp/hbVZr4L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=sQGmfEIG; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ss+AaO6IVNmgGR0bOacCjSN1lvUB/QugnVLrVOXNX2A=;
	t=1719871848; x=1721081448; b=sQGmfEIGrMCHNuOOaFkXzXFOthrYnOckul/vb8r5iANqwVP
	xdSN4fFPJDEbjO4YkDhXhYVj3OhNg5moPifKL5U9xgnWMERkVfx29e5bsylAvhIYWY8sb0ug4OHCk
	JjAdGGaH0c0pe3gvCHiyqVLcJnFn7ENtzGGuHTzN4X3rHzl/P2KOCRJ+Iyk3bp0vNZPi2vbeXuhO4
	Euwf/F1sbt3/I85gEYCH5tNMpFbTydydCjCygGAWtOl9KGx9iuW4NSFQRNR91/1pzWmIQg0+SiX/8
	VbSYrVp+wR+WJXp7BFMPQxR/AIXu+HBy314z5Y/ZeNCyTA4UqTgzEW3gesEQ4Kpw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sOPET-00000003TOO-0cTv;
	Tue, 02 Jul 2024 00:10:45 +0200
Message-ID: <1dd82a549053f7c2d841a966704664ca785b14c9.camel@sipsolutions.net>
Subject: Re: [PATCH] iw: fix formats under MIPS64/PPC
From: Johannes Berg <johannes@sipsolutions.net>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 02 Jul 2024 00:10:44 +0200
In-Reply-To: <CAKxU2N91jXA9hjdbPkfdQnHa1iehdBE+_K4QdsRGGfKu9V_sJw@mail.gmail.com>
References: <20240628223237.16222-1-rosenp@gmail.com>
	 <8f826bf3e6c2a676c4db37fdfd5b10e364abbb51.camel@sipsolutions.net>
	 <CAKxU2N-L+B_DSTA9nsseDgnzCtgOvtSgd6pShEF-MmA=DQCR7A@mail.gmail.com>
	 <a95d943d72123ddf4079262003516f29f52b06ad.camel@sipsolutions.net>
	 <CAKxU2N91jXA9hjdbPkfdQnHa1iehdBE+_K4QdsRGGfKu9V_sJw@mail.gmail.com>
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

On Mon, 2024-07-01 at 15:07 -0700, Rosen Penev wrote:
>=20
> They go away because if the define is found before any header
> inclusion, __u64 gets defined to unsigned long long.

It *isn't* found before any header inclusion though.

For pretty much all of the C files, "iw.h" comes _last_ in the list of
included headers.

johannes

