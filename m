Return-Path: <linux-wireless+bounces-36039-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAKhBfWf+2kZegMAu9opvQ
	(envelope-from <linux-wireless+bounces-36039-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 22:09:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9634E0119
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 22:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB784301CFD3
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 20:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001D23112AB;
	Wed,  6 May 2026 20:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="daqSAmkr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="URK7ISgF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDA52E9757;
	Wed,  6 May 2026 20:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778098161; cv=none; b=ImlP9Rtb0ON2a75CBY3imPiQD4frxQrPgRHT53azGwwBa8UxngMwoVPDVaMAo9moCdNxNtfBZLm2NOg2Lqv/7KpmLlx8nGKaVtGnSkl25QJXuyQzamYjKyh4CV+NxkRM1cZqAKWnlt67ApIHGfvdfEHc3d4xoPTjpgHDA/pwMzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778098161; c=relaxed/simple;
	bh=x4OPdXSil4/3tqs8a1SjyLj4aGFinVsgsTUC8WLuF5Y=;
	h=Content-Type:MIME-Version:From:To:Date:Subject:Cc:In-Reply-To:
	 References:Message-Id; b=KVF55PfJWpTBqLhazPtggEnGbuek3dYVzyR28r89/GcuE6i37eOKPIN5xobD/DYTKes88Lbx1rSccQxIhOMHxjq6rxIdclN3OVEG+qu9absXAomJovMGxHjwzZLr6u/q88c5+VDCeB9k1Zkq41b+CJwbvkTsrcfg8AnX3C1V6t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=daqSAmkr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=URK7ISgF; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6D8131400070;
	Wed,  6 May 2026 16:09:19 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Wed, 06 May 2026 16:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778098159;
	 x=1778184559; bh=45fzbr5u0590fQqlzP1nzbj90VoHWyrUuJIXnMHC0JA=; b=
	daqSAmkr/rCqg7/cylMR5qWxeLSyXoINIWrU7l0ljmWrD2afiY35gKZM46EzVLE2
	1s2GYrmP0FClj0kI1AkhM4EQCtG8cZYg+Wm7Wvd8QNp7/VKJtJhDsGhCePufKm22
	BCU4Qi68JBZ7wSrixpgq0Zg8AYmGVsn+7KSF5YbxGgc5eQq1ZZsCK7jk21PgwLT8
	gL5l6XtidazcsICs0vYGNFdgsJBtM4+Koq2UD46esYx51JfntWrFnTchjOxCvPnQ
	8j1hr25Yh1RAaRAemRW6/EUrKPml1kMoDW2YbAHhCKZUBtikif1KEnpCnKyySbKA
	oCRu4yr5qtG5AjEBq63+lA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778098159; x=
	1778184559; bh=45fzbr5u0590fQqlzP1nzbj90VoHWyrUuJIXnMHC0JA=; b=U
	RK7ISgFBN31jC0gTaq7VjwC5YeE9NSAuL+JyMU4HfLBC2Eb5lH7tv95EEgqXZ20/
	2ZV5DpMA4VSIayx/zGxMf5w4fruPSpRhbBya0pi3oNwYJEkq8257LuPkJj+HFhzK
	gmOy2+fFeUWoJ6przJCAf81pAVIUdxli9kJrh3eg8N/uSR/fEFHPKE/MEOIMeBPq
	xD++l62CHRivC7RlQ9Qn8OzBXHEDeXPxoiFINr5Gz1FCtxMNIbNukoofrOvSXSqP
	k3dVfnjmaWsa87+p0vkOu9uF09uHGzMWt+LAcaLx4gnfRpWH2XctJr1vrWhlxcm7
	u0R6Z6y9ihLGvUjWOzooQ==
X-ME-Sender: <xms:7p_7aeaqhonRvp1gf_cncceRwXgMXKLnbVswBPgy0zYKmnSXDFm_Cg>
    <xme:7p_7acM7eGdwD29XzFVxhSMVVmYsn6EUgUHyqvtDjvUDIx1Km5JqPZC9Lmwfpb1oH
    zVZ5CYfeuowwIsxUXnDiwmXOqawpljVwWSoYx2gCSBsffy2Xt_OOUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdehhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegopf
    hokfffucdluddtmdenucfjughrpefotggggffhvfffufevjghfsehtkedttdertdejnecu
    hfhrohhmpeflrghvihgvrhcuvfhirgcuoehflhhoshhssehjvghtmhdrmhgvqeenucggtf
    frrghtthgvrhhnpeegfeduffefgeejvdehgedtffdutedvveehvdekvdetleekjedvheev
    vdelgffgteenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjhgvthhmrdhmvgdp
    nhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghrrg
    gurdhpihiiiihimhgvnhhtihesghhmrghilhdrtghomhdprhgtphhtthhopehlohhrvghn
    iihosehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrhiguvghrrdhlvggvsehmvgguih
    grthgvkhdrtghomhdprhgtphhtthhopehsvggrnhdrfigrnhhgsehmvgguihgrthgvkhdr
    tghomhdprhgtphhtthhopehshhgrhihnvgdrtghhvghnsehmvgguihgrthgvkhdrtghomh
    dprhgtphhtthhopehnsggusehnsggurdhnrghmvgdprhgtphhtthhopehlihhnuhigqdhk
    vghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    ifihhrvghlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:75_7aXYEqKiGN5LgVIiWnXkqjgddRREM8eLBcba29tUTgaBx0TOT_A>
    <xmx:75_7adI6F7fIB2e-dDpNrFRqwJYZaRsFWN7tfyelENmklloYf-uTPA>
    <xmx:75_7abuXCFyuNunssISECyj29DqV4mZL-LzVTdqruuWtnEpYcHoTCg>
    <xmx:75_7aZVxfHkQG017sKaP7OGlajFLdKsWIkggauLbjcdk57RBKnx77g>
    <xmx:75_7adIkhkEcvSHxDrZz7VR0Aj2_PmmV-VrUHxneLFSlTwYD5t4bL2MU>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D68321EA006C; Wed,  6 May 2026 16:09:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Javier Tia <floss@jetm.me>
To: Bradley Pizzimenti <brad.pizzimenti@gmail.com>
Date: Wed, 06 May 2026 14:02:32 -0600
Subject: Re: [bug report] wifi: mt76: mt7925: iw set txpower fixed accepted but ignored
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com, shayne.chen@mediatek.com, sean.wang@mediatek.com
In-Reply-To: <CACjnFagN9zeSkwEv3-CSPJDUENPcEcOLjKyQoLQ91Yjn=rq5ww@mail.gmail.com>
References: <CACjnFagN9zeSkwEv3-CSPJDUENPcEcOLjKyQoLQ91Yjn=rq5ww@mail.gmail.com>
Message-Id: <20260506200918.D68321EA006C@mailuser.phl.internal>
X-Rspamd-Queue-Id: 6B9634E0119
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jetm.me,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[jetm.me:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-36039-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[floss@jetm.me,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[jetm.me:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mailuser.phl.internal:mid]

On Sun May  4 22:04:48 2026 Bradley Pizzimenti wrote:
> `iw dev <iface> set txpower fixed N` returns success on mt7925 for
> any N tested, but the reported txpower never changes from a stuck
> value of 3.00 dBm.

Hi Bradley,

The 3 dBm display bug is a known issue we have seen when using mt7927
and a tested fix has been working well so far. The root cause is that
mt7925_mcu_set_rate_txpower() programs the per-band SKU tables into
firmware but never assigns phy->txpower_cur. mt76_get_txpower() then
computes:

  DIV_ROUND_UP(0 + 6, 2) = 3

regardless of the actual power level. The RF output is unaffected;
it is a display-only bug.

The fix reads the effective TX power back from the rate power limits
after programming the SKU tables and writes it to phy->txpower_cur,
following the same pattern used by mt7996:

  https://github.com/jetm/mediatek-mt7927-dkms/blob/master/mt7927-wifi-14-fix-reported-txpower-always-showing-3-db.patch

This is part of a series we are targeting for wireless-next; not
yet upstream.

> What seems potentially distinct here is that the user-issued
> `iw set txpower fixed N` itself is silently no-op'd, separate
> from the reported-value question.

Agreed those are two separate issues. Our patch addresses the
display-only side: after applying it, iw will report the value the
firmware is actually using based on the SKU tables, rather than
always 3 dBm. Whether `set txpower fixed N` propagates to firmware
to change actual output power is orthogonal and not addressed here.

If you can test the patch on your MT7925 and confirm the displayed
value reflects the correct power after association, a Tested-by
would be appreciated.

Best,
Javier

