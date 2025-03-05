Return-Path: <linux-wireless+bounces-19793-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BE4A4F812
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 08:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9348F188B30C
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 07:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6081EE7B3;
	Wed,  5 Mar 2025 07:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="gktz8Uhk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6208B1DE4EC;
	Wed,  5 Mar 2025 07:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741160472; cv=none; b=OBnIlFP72oJz/0zURh5NNAXSSW9P8OUNypYN2EWJoY1qH4dk9Sz6hB8i+rPqrSPr+OYUcdwvOh88RFAIDDgOjjApI19S2lsTFz6I82BJa83e7DYwYQBv6NkqwRNXkBIPyUD9eDT9P1S5FZ4bUW9umS9ixp+HlEYLIpin1cBokYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741160472; c=relaxed/simple;
	bh=LtWIFnniiqHthw+orxCSjnxOicCCXctZRD9e2kWFt+E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VqW6hzpGUTwbUcDvwq5KO9vcc9Kc0B1tSisJDfRwx8gDITkk4X/xqwmc3a4WBN1bd7CYDl7dkFzxlId9pQJ3m/oz3WQ2AJPX18BUhqVLfieb0SJFAtMWfRn3ntXlydHvJjhuktJGzalJ9bOgK95bAA+S0oFLSZCzHN6ZLhXEvOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=gktz8Uhk; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=pL0ILPUfiLo8D7078PGmpAnb8Y1iCaIIVKVFNqbbuys=;
	t=1741160466; x=1742370066; b=gktz8UhkOKZ+gaeM6Vc+P6pysmrdHQIjpuBomsTO/IZKqvy
	FbHB8J/SQ40UcdLVDfF0x1hV8DD+3QlMfSeeYppZe3UdeaJPxh3pUHxZ5fOLaN8kntYtI3ozqqtiW
	RP0lrjYALKAT6U1vHrSKFxqXUQHEhY5brdqMzghiy2enjWPytlHkBc5dqdYRylx0bDUQw8IA7QbdM
	8g2wglkE2CoGzsEJFnkgDVynE6QWcW5934DoQvKJmwz6jLs88Lc/x2yzCvx2xqn6TTsxvyf1lTK6p
	NcSaKEQuTWhOcxh45AEkUsq9Y9g+8vofMEMA0+je0EPCyWq6t7ZflnZ5GpH5a8KQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tpjN5-00000001bf5-3dpq;
	Wed, 05 Mar 2025 08:40:52 +0100
Message-ID: <98e39be3351190ec71ffb067c062c82883ebef24.camel@sipsolutions.net>
Subject: Re: [PATCH v2 0/5] wfx: add support for WoWLAN on Silabs WF200
From: Johannes Berg <johannes@sipsolutions.net>
To: =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>, 
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>, 
	linux-devel@silabs.com
Date: Wed, 05 Mar 2025 08:40:51 +0100
In-Reply-To: <2018315.usQuhbGJ8B@nb0018864>
References: <20250302144731.117409-1-jerome.pouiller@silabs.com>
	 <f808c48596ae1929c62704c226fb109cc03bbd2a.camel@sipsolutions.net>
	 <2018315.usQuhbGJ8B@nb0018864>
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

On Tue, 2025-03-04 at 16:22 +0100, J=C3=A9r=C3=B4me Pouiller wrote:
>=20
> Patchwork also reports two warnings that I am going to ignore:
>=20
>   - "Target tree name not specified in the subject", I assume it
>     is "wireless-next", but in the doubt I prefer to refrain.

It should be wireless-next for anything that isn't fixes for the current
cycle, and please do add it - without it the checker won't always be
able to pick up the patches to test them:

https://lore.kernel.org/linux-wireless/ec3a3d891acfe5ed8763271a1df4151d75da=
f25f.camel@sipsolutions.net/

>   - Lines are larger then 80 columns. Checkpatch.pl now accepts up
>     to 100 columns. I am not aware any local exception in net/, right?

It looks like that's not documented
(https://docs.kernel.org/process/maintainer-netdev.html), but I had a
conversation with Jakub about this in the past and he prefers to have
the checks still at 80 because people were, in his telling, abusing it
in a way and making really long lines for no good reason.

I'm not going to be super strict about it, but I'd encourage everyone
who sees that warning to see if they can do better.

In this particular case, it's just a comment, so could trivially be
wrapped, but I'm not going to complain about 85 columns. If someone's
going to 100 columns with (text) comments though then I think that'd
raise some eyebrows. Narrower text is easier to read anyway.

johannes

