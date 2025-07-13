Return-Path: <linux-wireless+bounces-25335-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07364B03051
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Jul 2025 10:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A2B84A026B
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Jul 2025 08:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F362233149;
	Sun, 13 Jul 2025 08:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Nh7PjBqC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD896FC3;
	Sun, 13 Jul 2025 08:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752396624; cv=none; b=RmEuPzAlctKrcuV3pifdaKZKl5XyRSttk+0l6cc6XeQs+mMyJvwuCfESJ68eWK6CkOOUpcJXlUlQOw1L7D4LwDLrIK2+7xSLY2yhFKk1SdEmeNHKswopDamFnPbt5XXDW8I4t08NaCW+xd7rKr/SItpHgbn0EqKAY5GUJVyIvTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752396624; c=relaxed/simple;
	bh=z8l1uZ17d5krCHtbYqm9PDoWYLxWOwX4gFpsp2HGkHo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tNzfyuRL4vJ7Bxv9TIHTXiM5rgirTo+vIET4li09zRaY6toS8SSTlko+WpiRlwpK7N2KMrTRqHy5j/dEDdH4UORRffJwn+ZraZGByUHJ7ZTye1eIjnZ41SsxYDcixndzzQ5sW7qGki4VNIz4D8qZInecW25QmXhJznsBJXJIdAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Nh7PjBqC; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=z8l1uZ17d5krCHtbYqm9PDoWYLxWOwX4gFpsp2HGkHo=;
	t=1752396622; x=1753606222; b=Nh7PjBqCqmVUTS4WgUSrnFmAminThXX0JPnn+ak6A3JhsWe
	0sFoQ2Bc4twCcKScMdZej9JN+5TWapqJo+6j52zlpn6ULWyKymI8EII8mQZkMB3AQYnY1ZFyM/eq5
	ZtdUo3WwAegRpEBePp89JL4c4xUKChUkadFFl1LvZhn949CGZX4OE9FRQYyztxldHosmoIH7Oyc/w
	yI/r24zGXCYx0FhGK/ODnZyoSdKJv1QFSvmC772mjQgW/gz7BX1hHzGUEmh6O1QELLcCDoZMhDzr+
	0EMg7CTewqRqjStK3BXoEMQPbdU4rG1urk4rdMrnIOjNGGQ7xd34+wf4rfucQu5g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uasPF-00000001ria-18EG;
	Sun, 13 Jul 2025 10:49:58 +0200
Message-ID: <36c4cd5f263e4bae22a1779a9befd24dacd5d3bf.camel@sipsolutions.net>
Subject: Re: [PATCHv3 wireless-next 3/7] wifi: rt2800soc: allow loading from
 OF
From: Johannes Berg <johannes@sipsolutions.net>
To: Stanislaw Gruszka <stf_xl@wp.pl>, Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Thomas
 Bogendoerfer	 <tsbogend@alpha.franken.de>, Matthias Brugger
 <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, "open list:OPEN FIRMWARE AND
 FLATTENED DEVICE TREE BINDINGS"	 <devicetree@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>,  "open list:MIPS"
 <linux-mips@vger.kernel.org>, "moderated list:ARM/Mediatek SoC support"	
 <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/Mediatek SoC
 support" <linux-mediatek@lists.infradead.org>
Date: Sun, 13 Jul 2025 10:49:54 +0200
In-Reply-To: <20250713071532.GA18469@wp.pl>
References: <20250710200820.262295-1-rosenp@gmail.com>
	 <20250710200820.262295-4-rosenp@gmail.com> <20250712101418.GD9845@wp.pl>
	 <CAKxU2N-RXgFKYPAqEu3iZDMAisj_K-b+ZZTGFsabWz7pMK+02A@mail.gmail.com>
	 <20250713071532.GA18469@wp.pl>
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

On Sun, 2025-07-13 at 09:15 +0200, Stanislaw Gruszka wrote:
>=20
> Can be done as separate patch since you already
> posed v4.

Maybe I should point out that I've simply been dropping the patches
unseen because they don't even apply.

johannes

