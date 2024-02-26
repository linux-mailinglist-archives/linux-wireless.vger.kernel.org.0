Return-Path: <linux-wireless+bounces-4009-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EA88677FB
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 15:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9296A1F2D5F3
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 14:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FED1292E0;
	Mon, 26 Feb 2024 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="AWLiT9VD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F1F1C6B9
	for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 14:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708956887; cv=none; b=FRzleqBoXnHSCJmacKmHz/eUyS6t57MI6iCwjVvt4kbRrjmpfB1Vib5NMiGxyR742WwQXX12nCh7wqcT84K4vmueJC7yNHZLEkGqCKkpeD3A3vLIN4XXwsaqdU+xxYzem2YEx4qRXE5fwzCuA7i9vptb84wF0FtdJ9WcuUHGMPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708956887; c=relaxed/simple;
	bh=dbjmA3CiLRroXlURNen2Q9heOG0oE8s68Au04uxxO0s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ABw1DPGEyXl9uNXOdRAsP6l8ouh8Jy0UqpKPCDTPDXvUPC2Qsrd+BmrUAYpGFk2bC5v4cpTpgFkMEZsw405MxIWXRot30kcSpsGMKQSGi52fOaz7jMkdB+OxCsG2seDQ0qVl7fGwDoz7K5ehcHCw5ZAUC9ZP9KwLp0CNmVlDDCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=AWLiT9VD; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=dbjmA3CiLRroXlURNen2Q9heOG0oE8s68Au04uxxO0s=;
	t=1708956884; x=1710166484; b=AWLiT9VDskC1NY5dKnXsbASRI2zCziUM6IBy9JQCw8GxmHM
	H2ZsLp23rVC0iKs94kk/4GxHwxE8gmFC0HTn2am4Oc3Wwc2zGiZcHnud+fwN51IAYvAf/Cjl1xqzb
	VehEhb2hp7aNGPzs5bxp7rEPAtXFbEsv2761dwAZGGQ48z8MZbtbsft6wwFdKSvLWdRmptviGPb1k
	6hmgOwLPaW/wdWRW1uoTUQ2JWLKktjtbyVfmBFcNG0MrBaI+8vx2t130Ar/YpjAZe+KthHg+orKve
	34mQEOqL0tVNsZJtZU4AIDlpXUKGi0QTB7IccnPclEPiIQDS0+th9sYuZVUIIydA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rebke-00000009Hch-0bZB;
	Mon, 26 Feb 2024 15:14:40 +0100
Message-ID: <51cad25c273b27885f5387f995db48ef97df2996.camel@sipsolutions.net>
Subject: Re: [v4,2/2] wifi: mac80211: refactor STA CSA parsing flows
From: Johannes Berg <johannes@sipsolutions.net>
To: Michael-cy Lee =?UTF-8?Q?=28=E6=9D=8E=E5=B3=BB=E5=AE=87=29?=
	 <Michael-cy.Lee@mediatek.com>, "linux-wireless@vger.kernel.org"
	 <linux-wireless@vger.kernel.org>
Cc: "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>,  "nbd@nbd.name" <nbd@nbd.name>,
 Evelyn Tsai =?UTF-8?Q?=28=E8=94=A1=E7=8F=8A=E9=88=BA=29?=
 <Evelyn.Tsai@mediatek.com>, "lorenzo@kernel.org" <lorenzo@kernel.org>,
 Money Wang =?UTF-8?Q?=28=E7=8E=8B=E4=BF=A1=E5=AE=89=29?=
 <Money.Wang@mediatek.com>
Date: Mon, 26 Feb 2024 15:14:39 +0100
In-Reply-To: <765fb43a372825f6063894809f204150d87d4d18.camel@mediatek.com>
References: <20231222010914.6521-1-michael-cy.lee@mediatek.com>
	 <20231222010914.6521-3-michael-cy.lee@mediatek.com>
	 <b74f21d22a41b2ca635e64f04c06d5db6d38d920.camel@sipsolutions.net>
	 <765fb43a372825f6063894809f204150d87d4d18.camel@mediatek.com>
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

Hi again,

>=20
> In fact, we have plans to study and implement puncturing on our MT76
> driver. We're currently working on the AP side, and we expect to start
> the STA side maybe three months later.

Unrelated to puncturing, but if you're working on the AP side now - also
perhaps on the AP side wrt. partner/other link on MLD, i.e. one link
doing CSA another advertising it in the MLE per-STA profile?

I'd really love to have your input on that in this thread:

https://lore.kernel.org/linux-wireless/3c550ae335a9762a9cbd0c8109b6dd99faeb=
8f6f.camel@sipsolutions.net/

But also - if you're working on AP side for this, I have some changes
I'm working on for mac80211 to parse the per-STA profile for CSA on the
other links, to e.g. track CSA on currently disabled links, or if one
link just didn't have beacons received for a few beacons, or so...

Would you be willing/interested in testing any of this code? I'm
currently not really able to test it, so not sure if I should push it
out.

johannes

