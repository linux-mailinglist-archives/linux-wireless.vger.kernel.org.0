Return-Path: <linux-wireless+bounces-19685-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E34BA4B900
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 09:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9435B3A50B2
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 08:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660BD188583;
	Mon,  3 Mar 2025 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Ap5cW4nU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BA523F36D;
	Mon,  3 Mar 2025 08:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990023; cv=none; b=h8vQm/G6dgrzMmiW109wewBcOMzHV265aoK39u+ekn25tsnio6BxSIIgq/kd6hcMZXoUZXCBufo/bd6orROly037PJuRmAAJM3FWn8x3oNyC83aY6a51LKPjsVdhi3uEKDv07YccepkNKkfk4rHgF3pN2WVZSnnqyRJcIXlGZTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990023; c=relaxed/simple;
	bh=49AxiX0Eh/BuPuC2O5m+aEnH6BFIvD0QUlDC789siPM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qrQfO7DjbvGxzPKIPKCPa4buezliqxrIyCOYREEbUQ8EtacQ104yJOuPEna8kSP8VpWC6wiYeFQg/RO00sqTrOK+Tn4YOSOGP5XGuYou1Vuav1d6ezy05SQeTRatPtEQ/juumSLUJ7kkI5eqMlfarUEM6TjWJ75tlaV4v0L6P+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Ap5cW4nU; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1msAMH9fRVwyJn77+ikkrddk2GWerXIwokCf+V4Eurc=;
	t=1740990021; x=1742199621; b=Ap5cW4nUT0LDomDHa8lcTAecdbRLWbvYvV2dZCmTLi3uLvM
	ldwd9ldclYbOzBa24HgT9Uq7B73OIJ0yg/Vld6/2elD8U33jdSBrrQDNB5sy6It7UJrE/36KXfQLA
	td+jM+/YlzOK5ZLL69QDq2DrJXu/scNlVmbiZIfHSR4/Up5ByPYxtFCtoLsOMudThhKnI0mR6xqhT
	46r/BIjmDmt7uCoaf3KsFWu+jKwNgF39uUJ3OcWfHayWorqSRsdruGeYiAcumnj/XXjxgE2JvOvek
	l6FWoBhxC/dVDs0Uf2J68i3NPiyCb78v8Dh9DjxJh6rOV576SDBmC2r7Jo4lQsfA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tp124-0000000H1oC-0A74;
	Mon, 03 Mar 2025 09:20:12 +0100
Message-ID: <f808c48596ae1929c62704c226fb109cc03bbd2a.camel@sipsolutions.net>
Subject: Re: [PATCH v2 0/5] wfx: add support for WoWLAN on Silabs WF200
From: Johannes Berg <johannes@sipsolutions.net>
To: =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>, 
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>, 
	linux-devel@silabs.com
Date: Mon, 03 Mar 2025 09:20:11 +0100
In-Reply-To: <20250302144731.117409-1-jerome.pouiller@silabs.com>
References: <20250302144731.117409-1-jerome.pouiller@silabs.com>
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

On Sun, 2025-03-02 at 15:47 +0100, J=C3=A9r=C3=B4me Pouiller wrote:
> This is the initial support for Wake-on-WLAN of Silicon WF200 chipset. Th=
is
> version focus on the power management control. For now, the filtering
> capabilities of the chip are not exposed. So any multicast frame (=3D any=
 ARP
> request) will wake up the host.
>=20
> I have this series of patches in my git tree for a while. I hesitated to
> send it because the code is based on a proof of concept and I don't have
> access to the hardware anymore.
>=20
> Therefore, this feature is experimental. However, the only way to reach
> this code is to run "iw phy phy0 wowlan enable" or explicitly enable it i=
n
> /sys. So, I believe it makes sense to merged it in the stable tree. Thus,=
 I
> hope some users will be able to report their success (or their failure).
>=20
> v2:
>   - Fix compilation issue reported by "kernel test robot"[1]. Member
>     'wowlan' only exist if CONFIG_PM.

You should probably check patchwork too - now that we're running some
checks, a missing 'static' jumped out:

https://patchwork.kernel.org/project/linux-wireless/list/?series=3D939353

johannes

