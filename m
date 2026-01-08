Return-Path: <linux-wireless+bounces-30581-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFFED062EF
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 21:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2AD73016DC3
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 20:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AB1330D58;
	Thu,  8 Jan 2026 20:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="I4r0E2+G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8E7329C74;
	Thu,  8 Jan 2026 20:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767905932; cv=none; b=ZfyC4jvjJpox6/Oz5l1Ik64Bb/by4houxLSRgOKzRSuQFEfAdjYA5W9F9quPM6h84vFroB6Qqi8n7+/CvNNG8YrDrhzGoLMmSY1V7RQ1BqA56uDUs2CCJAWjH67DtDS4V1sULE9E+aOK1nNCYzDOl5C0+VJgjEfqum7aljDpggg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767905932; c=relaxed/simple;
	bh=zcGiuP33Bpj6hPovJFVhoda5b+gUu/odCKG4zB3G6Ok=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hFMZEEuUmoyIh6JGf9jXmgDomu5/8X0PKiD9RM/IsZQ5uiMb2h6SFMeuc5EZI3P2dOD85StRTon5Jmx6P4sMmjUQ3jPlTvj5586hjvmKlshcQVjgdFk9NLZundZyFtFK3CLzK40SgnbQzEFqWEvHejUBoxA4LZ4BfeMb4WtY9J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=I4r0E2+G; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zcGiuP33Bpj6hPovJFVhoda5b+gUu/odCKG4zB3G6Ok=;
	t=1767905931; x=1769115531; b=I4r0E2+Gz4P5Kk4c1bX8eIQDzb2UkC/J1yMAqAGcNQ6EtMx
	QJEIyR0uIxD+3ZDzFW67BBiNClKXhvk00Ca+jX/g+R4558mTN/jtIE4LNsd29cwFdrWirduBo6RdK
	pvm1E6784AMEaO60j6jLmyDsX7f2BW++JROPFEz/PFYJH+1NChG10utsYcriTqIIq9S/JnOqRRLdq
	9ZDy5NCHTLaO70cRa36ZHxLIHha1pEBUE3kF8ezfGfmpUjbM5TI6Mq/SCcXnF/sqB1nilUpMBsPoh
	+AJuigFff9cbS5Sd6Y8iHtWgbZINdUefsHEGkgVNV0vhUGy4PpsR523fUNCxJ40w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdx5j-00000006iwq-15A8;
	Thu, 08 Jan 2026 21:58:47 +0100
Message-ID: <9085a572f5fee0a14059c023c3240aa4d96afc08.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mwifiex: Fix a loop in
 mwifiex_update_ampdu_rxwinsize()
From: Johannes Berg <johannes@sipsolutions.net>
To: Dan Carpenter <dan.carpenter@linaro.org>, Chunfan Chen
 <jeffc@marvell.com>
Cc: Brian Norris <briannorris@chromium.org>, Francesco Dolcini
	 <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>, Amitkumar Karwar
	 <akarwar@marvell.com>, Cathy Luo <cluo@marvell.com>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Date: Thu, 08 Jan 2026 21:58:46 +0100
In-Reply-To: <aWAM2MGUWRP0zWUd@stanley.mountain> (sfid-20260108_210112_409464_E43D6B91)
References: <aWAM2MGUWRP0zWUd@stanley.mountain>
	 (sfid-20260108_210112_409464_E43D6B91)
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

On Thu, 2026-01-08 at 23:00 +0300, Dan Carpenter wrote:
> The "i" iterator variable is used to count two different things but

nice catch

> unfortunately we can't store two different numbers in the same variable.

:-)

> This was found via static analysis so I'm not positive on the impact
> of this bug.

I think it basically means anything other than the first interface
(using adapter->priv[i] with i>0) will not be updated correctly for A-
MPDU buffer usage (?) if you use more than two interfaces. Given that
most people probably only use a single interface, I suppose the impact
would be rather low.

johannes

