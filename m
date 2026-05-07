Return-Path: <linux-wireless+bounces-36048-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HFFmGlra+2lJFgAAu9opvQ
	(envelope-from <linux-wireless+bounces-36048-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 02:18:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEE34E1AC9
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 02:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 974BF300A117
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2026 00:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB3D8BE9;
	Thu,  7 May 2026 00:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kh1M4CP3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AC2800
	for <linux-wireless@vger.kernel.org>; Thu,  7 May 2026 00:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778112727; cv=none; b=N7M2SjMQhdTon2pdKUZofA6CKOY59x4IJCPnMFBoQ4XUG5J0YVn8vXYrV3+Cp96joC3fbXB+ZmMPowg8SzGCd5vl289Fcj5QBUuIyy/TSgav9Wod5S4ANtTwANDsGy1mgM0GNtFyPKYXKwOkRkO3niyUkouPA3sbwtmnVuM+wJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778112727; c=relaxed/simple;
	bh=FOpyYKheWwJmIOIbHMKquUusBebEhfl7BHn/laWcsTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qxyyksoP43mDw8oDqzoeWU6kgw6mqeIfv7Wk++npuC26zWtNX2NMhZRVeyL+BWUPqXZZS87ED3Ax6onsfyxbPkjAZOjm1Pq/iVhjpAKzY9WcYwqpGF4B+rQWYIh8QpG5tSmikiIc9iBPWIeUjId3Jv6OdrL8veueKc+px0PfqS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kh1M4CP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA740C2BCB0
	for <linux-wireless@vger.kernel.org>; Thu,  7 May 2026 00:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778112727;
	bh=FOpyYKheWwJmIOIbHMKquUusBebEhfl7BHn/laWcsTs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Kh1M4CP314OLm21kfDLx1OlAe0qdQDNBCp8Zq8694h/rgHmh6/WlvkA174Q3f/AtL
	 pRu/VKlT8ukxd7u9SNPMS5xyyNXop0ef34dgDeS4MFgeur7Ip2vuOOQSkuSur1dcPp
	 eFx030zFN02TPkZFQFM3aW93Z+xji4E+mcUx3s5O+g3lbpyIzN850MPGHircwhz7oY
	 7LpRcAn21kRPKTq1NaKPza2zIDUSCZAqmsh1Fu0EBLwCvRWJm/djRxCkCCDV5gwe0c
	 nNBKs5sZXzJeuZUuxhQgR2tqZyrXqsTAuI8rz3KEJzaVc7Dhsbn1Pe3BeoTEFpWsAB
	 xkf6M5KEUhyIg==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39397d63804so2437551fa.2
        for <linux-wireless@vger.kernel.org>; Wed, 06 May 2026 17:12:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+wgzWw4aCVPlzWaD45oTbfVx9xOR4Pte2JNKCwySaU1XChqCPzCbNzZnBvVsZ/tosuOi4YNhV9kbOm7fYY8w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6jLV+I3ABm6GjK3lcq41EfAZW4pLKTdc6dRXbvk5fQ+gZUwae
	hI0vB2YFHMYTkNpr4DqwL9emgA86vyv/QrODtAdIc1ww0lDzDLz9UTNokRK6N8NIZj8a1ccQWYN
	8t2YDxbz5abvOC3Jc+N3MYfocsRqDcy0=
X-Received: by 2002:a05:651c:1111:b0:38e:9667:f21a with SMTP id
 38308e7fff4ca-393c41edd4dmr17403801fa.20.1778112725343; Wed, 06 May 2026
 17:12:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACjnFagN9zeSkwEv3-CSPJDUENPcEcOLjKyQoLQ91Yjn=rq5ww@mail.gmail.com>
 <20260506200918.D68321EA006C@mailuser.phl.internal>
In-Reply-To: <20260506200918.D68321EA006C@mailuser.phl.internal>
From: Sean Wang <sean.wang@kernel.org>
Date: Wed, 6 May 2026 19:11:53 -0500
X-Gmail-Original-Message-ID: <CAGp9LzqkJ8QoOnBAiGu=uum3-LmCB3yHr91sw1HoLw+7ewNx6A@mail.gmail.com>
X-Gm-Features: AVHnY4KXPcpTEpQ4tty-oGElcVOTUbGBRAHXJs0Kth9qJxvAzGjOVsum6tHQbTo
Message-ID: <CAGp9LzqkJ8QoOnBAiGu=uum3-LmCB3yHr91sw1HoLw+7ewNx6A@mail.gmail.com>
Subject: Re: [bug report] wifi: mt76: mt7925: iw set txpower fixed accepted
 but ignored
To: Javier Tia <floss@jetm.me>
Cc: Bradley Pizzimenti <brad.pizzimenti@gmail.com>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org, 
	ryder.lee@mediatek.com, shayne.chen@mediatek.com, sean.wang@mediatek.com, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: ABEE34E1AC9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [8.84 / 15.00];
	URIBL_BLACK(7.50)[jetm.me:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,nbd.name,kernel.org,mediatek.com,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-36048-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	GREYLIST(0.00)[pass,body];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_SPAM(0.00)[0.137];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: add header
X-Spam: Yes

Hi,

The TX power reporting issue has already been investigated by Lucid
from the Linux WiFi USB community, and there is a proposed solution.
I think we can continue checking whether there are any remaining
issues on top of that work. Please refer to the patches here:
https://lists.infradead.org/pipermail/linux-mediatek/2026-April/105726.html
Thanks everyone for reporting and raising these concerns.

On Wed, May 6, 2026 at 3:09=E2=80=AFPM Javier Tia <floss@jetm.me> wrote:
>
> On Sun May  4 22:04:48 2026 Bradley Pizzimenti wrote:
> > `iw dev <iface> set txpower fixed N` returns success on mt7925 for
> > any N tested, but the reported txpower never changes from a stuck
> > value of 3.00 dBm.
>
> Hi Bradley,
>
> The 3 dBm display bug is a known issue we have seen when using mt7927
> and a tested fix has been working well so far. The root cause is that
> mt7925_mcu_set_rate_txpower() programs the per-band SKU tables into
> firmware but never assigns phy->txpower_cur. mt76_get_txpower() then
> computes:
>
>   DIV_ROUND_UP(0 + 6, 2) =3D 3
>
> regardless of the actual power level. The RF output is unaffected;
> it is a display-only bug.
>
> The fix reads the effective TX power back from the rate power limits
> after programming the SKU tables and writes it to phy->txpower_cur,
> following the same pattern used by mt7996:
>
>   https://github.com/jetm/mediatek-mt7927-dkms/blob/master/mt7927-wifi-14=
-fix-reported-txpower-always-showing-3-db.patch
>
> This is part of a series we are targeting for wireless-next; not
> yet upstream.
>
> > What seems potentially distinct here is that the user-issued
> > `iw set txpower fixed N` itself is silently no-op'd, separate
> > from the reported-value question.
>
> Agreed those are two separate issues. Our patch addresses the
> display-only side: after applying it, iw will report the value the
> firmware is actually using based on the SKU tables, rather than
> always 3 dBm. Whether `set txpower fixed N` propagates to firmware
> to change actual output power is orthogonal and not addressed here.
>
> If you can test the patch on your MT7925 and confirm the displayed
> value reflects the correct power after association, a Tested-by
> would be appreciated.
>
> Best,
> Javier
>

