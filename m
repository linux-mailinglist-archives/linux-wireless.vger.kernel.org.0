Return-Path: <linux-wireless+bounces-4456-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2452A875312
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Mar 2024 16:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB5A1F226F3
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Mar 2024 15:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF5D12EBF1;
	Thu,  7 Mar 2024 15:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="oL1dSynQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DCA12F365
	for <linux-wireless@vger.kernel.org>; Thu,  7 Mar 2024 15:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709825033; cv=none; b=r3CFEbwYWP7HDJY4DIubej96pGIpMz4Jris1QTtHg+lt+ZsTECHDXJVUX984qShHHachH0+3jVTkc/hsn9suDECO7BCGkG8znZYR2wK2HRjAG2p9W3tqF3LCn8VDPlWJ8n2LFjLMlxI6+l0YDJb5RS5YO8pVIT8dRrp1QsfZT04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709825033; c=relaxed/simple;
	bh=AS5H+X39rT4FtGFjCh14aIHpfAbyKW5h/PUqC1kzI2g=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fFgIy8NclsYl4ZiDykBxbv9r6HXnpuqh7io7JMs7nWgNFWtZX4mG5QCKt4YqApZP2bi6cJdsLTEsqwOqdt4Wi6W89OP0I5rRIbmNJjgJKb0lnTVmxQk4IOOtpaZX9/pCr1YZ/dKE02PRU9rpp8H2yqcXBXnhtmOZ4hz1Os9+/RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=oL1dSynQ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=AS5H+X39rT4FtGFjCh14aIHpfAbyKW5h/PUqC1kzI2g=;
	t=1709825031; x=1711034631; b=oL1dSynQFH4hRN1Bvd1cMiJ/M0kgVCyl+I5Lbum+wZvTajY
	3L6x4KLFiTXoWh6VvaGVAUsg5F+MwHunNcUWVanQdkGYVvdmrFnBrpJ+s+e5OkZxpVAHHXyg632hX
	dGExrUPqd+KakRBmR4nciCsB4rxPZ00S2fQpunCmc5YvE9QH1wAcaRW/Z8FiRarQLzqgGgcxQy0Ys
	OtoGnk6ljX2un8xjxOMqOtQM/UW9K6bN0g2N5TsW1cf14KtxshLBGL4kezxIB7hxAjD/p8ANraEOn
	npk2AIQ24wL5LCrc6wsLUnzalnbX7BofA9dM4x4Mshx/YyIeO/Tckq04Q1I9btqw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1riFb2-00000005m1E-2Lks;
	Thu, 07 Mar 2024 16:23:48 +0100
Message-ID: <a1ac8dae34081e0ccde0fddf445f2ef13dbd06e5.camel@sipsolutions.net>
Subject: Re: [PATCH v7] Add JSON output options to 'iw' for scan results
From: Johannes Berg <johannes@sipsolutions.net>
To: Isaev Ruslan <legale.legale@gmail.com>, linux-wireless@vger.kernel.org
Date: Thu, 07 Mar 2024 16:23:47 +0100
In-Reply-To: <d1988e179abb5911a8ddedfe95018bf4.legale.legale@gmail.com>
References: <d1988e179abb5911a8ddedfe95018bf4.legale.legale@gmail.com>
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

On Mon, 2024-03-04 at 23:01 +0300, Isaev Ruslan wrote:
> v7 changes:
> - binaries json/a json/a.out removed
>=20
> v6 changes:
> - add iw_printf(const char *key, const char *fmt, ...)
> - rewrite print_ssid_escaped() as a demo with new concept
>=20

I guess it'd kind of be useless to test that way, but it'd be nicer to
review a patch that only has new concepts?

Maybe split it anyway - one patch to add all the external code, one to
do the 'right' things and one with all the other stuff for testing?

johannes

