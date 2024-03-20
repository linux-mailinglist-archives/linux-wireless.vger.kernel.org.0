Return-Path: <linux-wireless+bounces-4980-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A47F28811ED
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 13:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A201F2145C
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 12:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BFD405C1;
	Wed, 20 Mar 2024 12:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="d2FsssJ6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608433FE4F
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 12:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710939455; cv=none; b=ksSjrh9dxpXnU0e8YaMpd+zMzqh4GulGCR51OdssANGaFgcyXVboir/woxr/ef+QTesxDP6cMVgAgbD0oC+xrfGsgii7SLyukuP3/Iu5c84p7+PaSo58jWLD5aZEFbn26I6qwSCxG6P1D9EpoPVej7j6J+3nCaX7xuaXf/gnB+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710939455; c=relaxed/simple;
	bh=QXh8LUHdH1qLm3pNAml5rsSmXBV6vEE3TgtqnhTA2XU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tKQgKOhzvhoTH8RfCQEid1Y1bSchN7CXK7U/IksWD37usbmsh5dzTbFQ7xqEN4Py5DqVu1xS7Cj4jWJLCu51bMSGm1jO0A79hp+Z/XV29SoeWTUT4OluzJrbNm7C/p0u99b/gue8mnmp7LussSx8FwknkCwFMUbqwscum4hEy3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=d2FsssJ6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QXh8LUHdH1qLm3pNAml5rsSmXBV6vEE3TgtqnhTA2XU=;
	t=1710939453; x=1712149053; b=d2FsssJ6cbt1BUC34Z3toafrZEdDNHWrsPhznKTD9vb4/qm
	inkUcIWdSb2QmQg1IG8DAz0ie4JDuxqVf6BMD2ssbl/PPwIrdEmKwvNmESHTsIRlYqBNrOjWUZSqD
	9I7LpVdTIJrrfihjlEDscO0cS7OQKV8LenrkEWNuycRK9yTUKFqZU/IcFiSa+jimmXyK9OxfRFjfx
	3g+QT5NT31lBI/J43minFVo7QbneoWraQaxr7TFdHHfUT0U2S/cD9rf2DZ2/c5XnRo482W6Je1Ram
	SvuxuGVkwa0+tRAx99bekA3FDoVVAtfXRQe1c9IAWRal072y49jnV5PAp4cV4iJg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rmvVT-0000000724V-1x5l;
	Wed, 20 Mar 2024 13:57:23 +0100
Message-ID: <bd8fea1d27703374ca4bc9cd68ee8a492049cf98.camel@sipsolutions.net>
Subject: Re: [PATCH 1/8] wifi: mac80211: do not call
 ieee80211_key_switch_links during reconfig
From: Johannes Berg <johannes@sipsolutions.net>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, Benjamin Berg <benjamin.berg@intel.com>
Date: Wed, 20 Mar 2024 13:57:22 +0100
In-Reply-To: <20240320091155.6ab8520bd4a1.Iea3e7e5d8b2bb5db1dd93f6ca589e8ea1bacaf60@changeid>
References: <20240320071405.815427-1-miriam.rachel.korenblit@intel.com>
	 <20240320091155.6ab8520bd4a1.Iea3e7e5d8b2bb5db1dd93f6ca589e8ea1bacaf60@changeid>
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

On Wed, 2024-03-20 at 09:13 +0200, Miri Korenblit wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
>=20
> The keys will be configured later by a call to ieee80211_reenable_keys.
>=20

After patch 8 in this series this is actually wrong and I'm reverting it
internally, so I'll just drop this one.

johannes

