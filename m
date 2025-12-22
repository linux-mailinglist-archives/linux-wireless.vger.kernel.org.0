Return-Path: <linux-wireless+bounces-30056-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6644BCD724F
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Dec 2025 21:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F9113013ECB
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Dec 2025 20:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439312EA177;
	Mon, 22 Dec 2025 20:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="MLK8f6kF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307002820A0;
	Mon, 22 Dec 2025 20:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766436484; cv=none; b=tzc53wXWmub/L/yjM/Jk4JUks7kclqEm3Dlf5/0dm5nkzSyBa91GQYfK1LCF7ICU2PJiRiEqIHdx02RI+PFJuezW5VNatrRq5nvj5xMgGHpxycyAa1LJPVRqwK/rMj4/xatY4Y5nTVjMcrTRZCfocdYWbWLj/LgwXerl0rRckkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766436484; c=relaxed/simple;
	bh=rbxaNpLxFAH3dqMAl+p1IRk5i2JFW/cXOJCZG2bLHVQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NBd47toK8rUbxYMp2kylgjcMzx5sQMFVo2Hkt7Yv4jpor1QwCwEjfaYF81lUqVdbn5VAks7Hi+epa+KXHuNOsRB/gc8aBWqfDfIsJmyPiTK7j3NnUws9dNRs4eMWNc0OzJcuWd2S0GnSd1AHGw4IzCiviKOTatvtrcdM8RwVG7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=MLK8f6kF; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1766436472; x=1766695672;
	bh=rbxaNpLxFAH3dqMAl+p1IRk5i2JFW/cXOJCZG2bLHVQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=MLK8f6kFrt4HaO27kUwVilQF/dtxIh+J/vyaqkpzIGDx9Zt6VU5EGUiBVJTkuGxmm
	 WKAl9fPWKpZOn7aVb9GHPp8SqCHsuSI5BfevxaoHXGlJ1s1Z5hlB2kzCArnQ9Ao4PI
	 ilYuyrKXH2s2YvfSMrVUeOtwd+MD6B0qbwrVJ/bmUcBkIjrGtytFZX1c90H3HkQCho
	 nwu+5Hq1d8xVLnzv1jElb9z5ji2bMdRFLmZ64vzapurn4aEmNG/UvSMv0tCObMsiys
	 y2QibfvqWHdubaTGSIYHFYZ8lXSGh9vBYHyIzGk9Mm1Iy1/yUrklUkPxWLgYT08vZr
	 BnRkP9YawosbA==
Date: Mon, 22 Dec 2025 20:47:44 +0000
To: Harry Austen <hpausten@protonmail.com>, Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>
From: Harry Austen <hpausten@protonmail.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] wifi: mt76: fix buffer overflow bug
Message-ID: <DF51GPM5N848.3L90OHP3XRWTV@protonmail.com>
In-Reply-To: <20251222180437.1938-1-hpausten@protonmail.com>
References: <20251222180437.1938-1-hpausten@protonmail.com>
Feedback-ID: 53116287:user:proton
X-Pm-Message-ID: 7cbfe6dc198c2829d8087c095262b79223caa22b
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Dec 22, 2025 at 6:05 PM GMT, Harry Austen wrote:
> Prevents attempting to read an extra byte from the origin string.
...

Ah, my apologies. There appear to be a bunch of emails about this bug alrea=
dy.
And an existing patch [1], which has already been reviewed. Please ignore m=
y
patch.

Apologies for the noise,
Harry

[1]: https://lore.kernel.org/all/20251205161202.48409-1-mikhail.v.gavrilov@=
gmail.com/


