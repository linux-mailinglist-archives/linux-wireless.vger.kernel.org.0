Return-Path: <linux-wireless+bounces-4379-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95810872028
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 14:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 238D02845D2
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 13:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F5E85C5E;
	Tue,  5 Mar 2024 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="IpdsbcIa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0B485920
	for <linux-wireless@vger.kernel.org>; Tue,  5 Mar 2024 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709645400; cv=none; b=TBVHADE3bp2ZYGLeJyxqheDz5RfdR6uhzDfPmeNp0h4ZMW3yZotjEnAxVksTaX2C7uMDy7LpzGg/X0EvfOng0eQO4opKyUFFQo3rmMjkHfKIrm7kBm+gES/orT+t70vZsaEY1g/DY8/Tg7eAy+bw6bXugPHV+eeyFSvMNsheVuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709645400; c=relaxed/simple;
	bh=RQq3gw9l2rvTVH2sYD6OTuNsWh+GiAYjPHJiMfUqsMU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PEh/uMSScRGa5uM0Tu4kQIgNFwHbFx0W7oeYIV9lDnQR1IGtWr2ILMmsPF8Wsi0ZbGLlZRNZktlTtg7iJJVozzzv/onnF3kdfdjFJDZbD/Y0MU4300GU1sOl89HpQIYehUDKDYVoT4a0Q4rq3jkBW8kAewJpB+Jln3OSC1FarzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=IpdsbcIa; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=oM/6F5z2fYXlwIh94EnOG8p4ZsVBItKx2EQBTXjGYvw=;
	t=1709645398; x=1710854998; b=IpdsbcIaA6aGUz6/QLjEnoCpdwTB2O+VcHB3MHitEQyn0Th
	GKRHge24ZEqhsSxcs8gRjsnSSeK0xEGlsk/9ADeWwqxNZKAeFv266w2GCjrh0/wiwOdPQboIYCPor
	glVHY0YXhK+fFWS/vB+w9O7uhMGfYeEm0ill29tFclPOpl849FOUcr/f+mQf2GuWrQ9JxQ8jfH89I
	rDAebb3krAEED3UOgO6ayAxnqSi6X6F4VVrCVihXUE1bJ2tlvazRiy6TNgz+TrG3phUaakKkD6LRW
	QEznOd8JxTRV7eHUgWWauDnRvAO611Wyp3RU2KQvDovnR8LXU2/k7/ZUGNNbJG+w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rhUrk-00000002ohe-0LoQ;
	Tue, 05 Mar 2024 14:29:56 +0100
Message-ID: <172b85b1166c2f026df396ee4dabc3cbb2c300f9.camel@sipsolutions.net>
Subject: Re: [PATCH v5] Add JSON output options to 'iw' for scan results
From: Johannes Berg <johannes@sipsolutions.net>
To: Isaev Ruslan <legale.legale@gmail.com>
Cc: Nicolas Escande <nico.escande@gmail.com>, linux-wireless@vger.kernel.org
Date: Tue, 05 Mar 2024 14:29:55 +0100
In-Reply-To: <CACDmYycV9qP2TUMMz5ij75A18NEaVpke6t70r7ELNgV=8+sCRw@mail.gmail.com>
References: <5c5be485dcfceb44fc731e47758d6be3.legale.legale@gmail.com>
	 <12f91b008d6f2b4e6241794d2852c1c84fe6c12c.camel@sipsolutions.net>
	 <CZLQMMSSUWBF.1NPJJYDRIXGIR@gmail.com>
	 <37398c88130c487be656eed4e378d6b047a3d612.camel@sipsolutions.net>
	 <CACDmYycV9qP2TUMMz5ij75A18NEaVpke6t70r7ELNgV=8+sCRw@mail.gmail.com>
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

On Tue, 2024-03-05 at 14:32 +0300, Isaev Ruslan wrote:
>=20
> I think i could make a universal printf() like function with
> additional args for json representation.
>=20
> Something like this:
> before:
> printf("\t * Manufacturer: %.*s\n", sublen, data + 4);
>=20
> after:
> printf_json("\t * Manufacturer", "%.*s", sublen, data + 4);

I think you meant

printf_json("Manufacturer", "%.*s", sublen, data + 4);

but yeah, that seems better? Not sure I'd call it print_json() over just
print() or output() or so at that point.

> void printf_json(const char* key, const char* fmt, ...) {
>     char buf[1024];
>     va_list args;
>     va_start(args, format);
>=20
>     if (iw_json) {
>         vsnprintf(buf, sizeof(buf), format, args);
>         print_string(PRINT_JSON, key, "%s", buf);
>     } else {
>         printf("\t * %s: ", key);

Guess we'd have to be careful about the indentation. Track the (JSON)
object nesting level and apply it that way?

johannes


