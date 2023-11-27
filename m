Return-Path: <linux-wireless+bounces-101-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E207FA35E
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 15:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82AEB1C20B9D
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 14:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D2919455;
	Mon, 27 Nov 2023 14:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="mHotoFtd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C6BA3
	for <linux-wireless@vger.kernel.org>; Mon, 27 Nov 2023 06:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1701096506; x=1701355706;
	bh=D/QuZySFquClyUZrQJgv8cSRnLgGNnUBKw6R0N8ml+U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=mHotoFtdZMlM86rf05GjVS1hIQHVGY+QJJ+vZsRtNxlQMSVF6bRHUQs78ePz/GSpj
	 MYvHi9oLhJY/cpGRXenwuB8oFtKcgId3R94o7KuiShWIZSoWa3soKNwyWMu0GEpx7o
	 V8KRmAFJTBk6ZmRYIAfEtRFgnCh7VvB9IKBC6P9cSSpk/QR75H+snlm7ZzDmjHDzfy
	 RoJwaOBBFIyB8J2ukHKpKQRo9OANqZpgHm3Fipl9/HKbYVyI9cuKjPCv2z5OdP8Ffy
	 fq7qu4peIO7trxACKzIOROwltpmnM7X8kGGa/RZY2Yq0VGh2Jpxom0XxnVScrDFFIC
	 k1UxmCaEo7dig==
Date: Mon, 27 Nov 2023 14:48:08 +0000
To: Jakub Kicinski <kuba@kernel.org>
From: cristian_ci <cristian_ci@protonmail.com>
Cc: "kvalo@kernel.org" <kvalo@kernel.org>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>
Subject: Re: [BUG] wireless: mt7601u: probe failed with error -110
Message-ID: <TW5Bad4rqn0eV1xH7glJEAQsf333rfPxAYZJ9hMIkaGJrAbMihh-AefdxZx0LtYiK5UUavBSBgOt9x75YgCyPR0cflycw5mNjGqsb7qPebk=@protonmail.com>
In-Reply-To: <20231126142634.3a100e2c@kernel.org>
References: <Bnwq2et4CBU1_MS8X3rFeejMDmKf2dr_BNq60IzBcGKbjTxHG1CjJ0zB_wZjn8_iLJsi7fCx6_Eh01ozYBqPA-cEZXMZE_X98E0b7yotXCg=@protonmail.com> <20231126142634.3a100e2c@kernel.org>
Feedback-ID: 27475468:user:proton
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Sunday, November 26th, 2023 at 23:26, Jakub Kicinski <kuba@kernel.org> w=
rote:

> Does it work with the vendor driver? The upstream driver is just
> a rewrite of the vendor driver, I don't know much about the device
> internals.
>=20

I remember I tried the device with the vendor driver [1] (which is not comp=
atible with mainline) and it should work in that case. I noticed there is a=
 datasheet somewhere out around, BTW I've also found information here [2] a=
nd here [3] about the driver and devices shipping this chip under several b=
rands.

> Maybe Lorenzo or Felix have some ideas.
Indeed, I dared to fw and cc them in order to join this discussion.

Regards,

Cristian.

[1] https://www.mediatek.com/products/broadband-wifi/mt7601u
[2] http://en.techinfodepot.shoutwiki.com/wiki/Mt7601u
[3] http://en.techinfodepot.shoutwiki.com/wiki/MediaTek_MT7601U

