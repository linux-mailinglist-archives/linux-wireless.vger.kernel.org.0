Return-Path: <linux-wireless+bounces-20702-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56892A6CB59
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Mar 2025 16:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 990107A4AE4
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Mar 2025 15:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBD1231A24;
	Sat, 22 Mar 2025 15:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="rDj4oFVn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737D670809;
	Sat, 22 Mar 2025 15:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742658889; cv=none; b=uhtiM4OHdt1pVFh8Jn0uHooOrhCDa/se1nnuGNWLbqI2XuF4JNkHuM1F5j2QwQJTXygZu7NZxuXoYQD8lO63B0V+cXI14OKGl2DSP1KjRm291lE03C2V0f8GCnL/o6x6va1sNEvIJDJRO11PjHo0LTl/V6UtCyrz+YCwj8eZajo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742658889; c=relaxed/simple;
	bh=mSMXTmA7NHlO+etZYtz5b3FTs1rltNj6XepKrdcM7Vw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KEf9hCLc8ySVhToS3aEP215e998IP2mJzgXcLH1TYrmyN98VB3CjII+8/c8ognWzotXA3GbiRUQevyihwmtNCm8ytFF+N8H/m67IiWGTQAZErXDTGgsROLGqEPlKrOKEboYNEuXYrfq5w0tPG9PP+X/R0dLlcJPi/ZM90AR+Fhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=rDj4oFVn; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=mSMXTmA7NHlO+etZYtz5b3FTs1rltNj6XepKrdcM7Vw=;
	t=1742658887; x=1743868487; b=rDj4oFVn07DeHE08GBuPct148wcy5mctlWvW/sshNq5eWRn
	pjyXseKXAQUrgne8nFKT7xWsCs5xVGIEJneigwy1kycoF8lYlhFCCUXfhUcFqoQLhWnCyZTn95lfJ
	zxkteTtrcIQ7PeKFmG0zgaFXiF4pw2U5yXXyhbU37GJ5qby0/L3tiFszjyxAgsdfXlgcCqhVL3Kwa
	aqGV84YUmY3ThCFkrIOfscZMoTBTsJ/Zoed2kY7bYOXefGKDY+NISByotU9iB4Qs1cN2NukhbUuIw
	5sQ08frQlDn5YJWgc3U4ew8vppPciUtd+Y7OELM3/MZtmQbM5X1khpCYUFAAuEdA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tw1BK-000000024Ph-3HW4;
	Sat, 22 Mar 2025 16:54:43 +0100
Message-ID: <92d1a410788c54facedec033474046dda6a1a2cc.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mt76: mt7996: avoid potential null deref in
 mt7996_get_et_stats()
From: Johannes Berg <johannes@sipsolutions.net>
To: Markus Elfring <Markus.Elfring@web.de>, Qasim Ijaz <qasdev00@gmail.com>,
 	linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, Angelo Gioacchino Del Regno	
 <angelogioacchino.delregno@collabora.com>, Bo Jiao <bo.jiao@mediatek.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, Felix Fietkau <nbd@nbd.name>,
 Lorenzo Bianconi <lorenzo@kernel.org>,  Matthias Brugger
 <matthias.bgg@gmail.com>, Peter Chiu <chui-hao.chiu@mediatek.com>, Ryder
 Lee <ryder.lee@mediatek.com>,  Sean Wang <sean.wang@mediatek.com>, Shayne
 Chen <shayne.chen@mediatek.com>
Date: Sat, 22 Mar 2025 16:54:41 +0100
In-Reply-To: <d1df5d97-4691-40d4-a6cc-416505f35164@web.de>
References: <20250322141910.4461-1-qasdev00@gmail.com>
	 <d1df5d97-4691-40d4-a6cc-416505f35164@web.de>
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

On Sat, 2025-03-22 at 15:55 +0100, Markus Elfring wrote:
> > Ensure phy->mib is only accessed after the null sanity check for phy
> > otherwise the code may trigger a potential null deref.
>=20
> * Would you like to use the term =E2=80=9Cnull pointer dereference=E2=80=
=9D consistently?
>=20
> * Were any known source code analysis tools involved also for
> =C2=A0=C2=A0this software improvement?
>=20

Do you really have to double down? STOP. You're just wasting everyone's
time.

johannes

