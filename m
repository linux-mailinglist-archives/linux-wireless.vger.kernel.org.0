Return-Path: <linux-wireless+bounces-24411-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 826E3AE5E62
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 09:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5E533A60EC
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 07:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4746F2561A8;
	Tue, 24 Jun 2025 07:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="OZmA5TbC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F25221FC3
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 07:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750751388; cv=none; b=is5OQikDTNeE4u0DvvyC0CZM6LijlSCQJHKGZtT1B0GXufNggLUzatQkAqSeGAbeqMKxsaSyk0zi+HHdFnY7pKmX05a1uIA2QgpnoVEgcL/yh2GD9NnrUcqkYxClaJZJIsu5Q5g6Tpwkg0XmNbpCR92dizvZZXXiD9b+wddHrJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750751388; c=relaxed/simple;
	bh=WyN3aSF/6dJxy/0oFQdMOCZjX15s7WS9+IZNncQvtRE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ahKOonofsIpNklkd4JWYwg/JqJpf27VbLhbznsElilpxDGoQ3xxCVNx/AS5EfH+R4bOxlOO77wEH0I+3MUv3ALhg4dgFZ3+vkMVJmr/st/akDUJFZ95k7Mn6rCEWS1zwwLFb2h9p5Cgm2L3DyTVveUJ90u0yiGXuXqF6f5YfeVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=OZmA5TbC; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=WyN3aSF/6dJxy/0oFQdMOCZjX15s7WS9+IZNncQvtRE=;
	t=1750751386; x=1751960986; b=OZmA5TbC8bz9lp7sMRqDCK4DNeMfgSDRdkw+CC/qF9cQ4Hh
	Kh8dfauPQvYVJSs17ksb2S/RDSK0tCjLA28nE2Kk1LErmbY4Upd/yPejXgYQheCAsL7kMsWscA11Z
	rESWf0sk4QG61TS9kbR0Hk0V1VSFwxHM2MZT/lSEEv1vg7GLatWfheiIEgwpJh45UmQDEkqmnUzvX
	2dFbc+GBfGsqXT3fIKZit2GN5C2aUApdRT6+4dtY7LxFjKZq4BTWt2bHQ5Gxc5gQXVSiilhcZJwO5
	WRw8unW0B/SAp2U0dOkun707dMoEsF6wEwMIEFOgf4L3rKbnAF6gJkIT+4yW4Kmw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uTyPM-00000008fgQ-1p95;
	Tue, 24 Jun 2025 09:49:33 +0200
Message-ID: <220639a5bbf43c125ef114c6ca8e71d050125cd6.camel@sipsolutions.net>
Subject: Re: [PATCH] iw: add support to parse 6 GHz channel
From: Johannes Berg <johannes@sipsolutions.net>
To: Suraj P Kizhakkethil <quic_surapk@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Pradeep Kumar Chitrapu
	 <quic_pradeepc@quicinc.com>
Date: Tue, 24 Jun 2025 09:49:29 +0200
In-Reply-To: <20250620073240.2770468-1-quic_surapk@quicinc.com>
References: <20250620073240.2770468-1-quic_surapk@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-06-20 at 13:02 +0530, Suraj P Kizhakkethil wrote:
> From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
>=20
> Currently, 6 GHz band channel parsing is not supported for
> set/switch channel commands. Channel numbers of 6 GHz band
> overlaps with those of 2 GHz or 5 GHz bands and therefore needs
> additional argument to indicate 6 GHz band. Add support to
> parse 6 GHz channels for set/switch channel commands by an
> optional argument "6GHz" in the set/switch channel commands.
>=20
> Examples:
>=20
> For 6 GHz band,
> iw dev wlan0 set channel 49 6GHz 80MHz

Or just say

iw dev wlan0 set freq 6195 80 6225


I'm not sure we need this at all.

johannes

