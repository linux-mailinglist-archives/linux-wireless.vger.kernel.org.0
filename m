Return-Path: <linux-wireless+bounces-67-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8217F84BE
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 20:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7788E28BB5A
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 19:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0868A39FEA;
	Fri, 24 Nov 2023 19:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mIyqAVRX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F7126AD
	for <linux-wireless@vger.kernel.org>; Fri, 24 Nov 2023 11:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=LdYW0UnSptvVu1ecZsLZqmt09nJo2Af7g+iQo4CJVDI=;
	t=1700854314; x=1702063914; b=mIyqAVRXuz0dlsn8Ck/kNxyokOXw0mYKDRAfM+Q7kabKACj
	cXo+dQbe28X4WS6NAYhJjAVyn9HBx6KT4SIlSUuNDfGQXF6QCYTGbr4Dq8cchqKjcHSkXVHo83Thn
	i0iLqy8Wf2PFI+A3em+cjtqSBf03bT7CMhHn0alvtwKEs+Uhg+psPb2oCcJ3aiDMqXImlQCDVT5b4
	AVtmAl7NEzCkEm2IrpvcS0cdxo6zqVqCkt94kdYQoqOMhRF1NBB7H4+MixpwbX0A5WSCycrsKy1r3
	PaF/5wZVAaQHZm4ck/CDlsZ7VLquCqESoENdKpxhGI4W4+rK9C9exYP3X/yxKH+A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r6bu3-00000002kEE-2FfI;
	Fri, 24 Nov 2023 20:31:51 +0100
Message-ID: <9dd37c008572bb0938bd0d0a0fa207dd70aa8b98.camel@sipsolutions.net>
Subject: Re: [PATCH v2,2/2] wifi: mac80211: Refactor STA CSA parsing flow
From: Johannes Berg <johannes@sipsolutions.net>
To: Michael-CY Lee <michael-cy.lee@mediatek.com>, linux-wireless
	 <linux-wireless@vger.kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Evelyn Tsai <evelyn.tsai@mediatek.com>, Money Wang
 <money.wang@mediatek.com>, linux-mediatek
 <linux-mediatek@lists.infradead.org>
Date: Fri, 24 Nov 2023 20:31:50 +0100
In-Reply-To: <20231113021107.13110-2-michael-cy.lee@mediatek.com>
References: <20231113021107.13110-1-michael-cy.lee@mediatek.com>
	 <20231113021107.13110-2-michael-cy.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2023-11-13 at 10:11 +0800, Michael-CY Lee wrote:
>=20
> +	new_chan_width =3D ieee80211_operating_class_to_chan_width(op_class);
> +	if (!ieee80211_operating_class_to_center_freq(op_class, chan,
> +						      &center_freq1,
> +						      &center_freq2)) {

Unless I missed it, I see two places here calling it together, so seems
reasonable to fill in a chandef here instead?

> +	new_chan_width =3D ieee80211_operating_class_to_chan_width(op_class);
> +	if (!ieee80211_operating_class_to_center_freq(op_class, chan,
> +						      &center_freq1,
> +						      &center_freq2)) {


Here you have it too.


> +		new_chan_width =3D NL80211_CHAN_WIDTH_20;
> +		center_freq1 =3D chan->center_freq;

And actually you could just have a chandef created with

    cfg80211_chandef_create(&chandef, chan, NL80211_CHAN_WIDTH_20)

which mirrors the failure case here, and just not update it when
something like

    ieee80211_update_chandef_from_op_class(op_class, &chandef)

returned false (not that I necessarily think that name should be used.)

Or just pass the channel, and make it create one with WIDTH_20 in the
failure case?

    ieee80211_create_chandef_from_opclass(chan, op_class, &chandef);

which is is maybe even nicer?

I'm also not quite sure why you're converting to operation elements
first?

johannes


