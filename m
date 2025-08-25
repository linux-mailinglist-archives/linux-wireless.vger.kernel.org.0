Return-Path: <linux-wireless+bounces-26581-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 967F2B33C18
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 12:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6237F170FA5
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 10:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AC72D3EDD;
	Mon, 25 Aug 2025 10:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ATngMvQD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FAE2D29C8
	for <linux-wireless@vger.kernel.org>; Mon, 25 Aug 2025 10:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756116218; cv=none; b=VwPPts9QY9lUEqR8mL564Pnsn2wB1MhqVAKppNDyjF+TX/1W8qxGSAjt6ojX4+6UCIYiFuh/y0OOh++qy2EXW5cJIXrFmVNBSRUf444zfureKCXzwOdekkwNj9brQA5sjGG+vF75OMKJOweWrWaxqJ2XFulP7ui/3DtKDEDPGxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756116218; c=relaxed/simple;
	bh=Mtydi351DaRo+ygr02w39zgqzzwVfUrmg5ZUQizzQ3A=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mpR9g2sT5HaebKmtJQSr2zSc0C19fykkA0BZWCgdewtIeGMdObFqsyv4jEQ61eBuggnoSYzmW5rYhm5JPEumPeBER2iBTfwhEmrvplj1JnayIInyL0ZU3Mf+tsv8lMhh0/RAnznJMrqVdy/FcKhQ+8YFmNMVubkjy746xDqZwac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ATngMvQD; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=dWFc5uhRdhxiVFAu3Bmt0otoXJTB1z/7tsayK3nmoE0=;
	t=1756116216; x=1757325816; b=ATngMvQDe5D89F01tUaxkrGbhSWOjmAFAWCLV0vqpmpE9g5
	i6WZXTZcKZhAKJ97FEWDwkvjxmRbqxPLpXYWpo5R3jsZ8ybpTjcWfCerkATwPGwNnHA3Kky0H+Lii
	wRPOgWqV9s9GKAigV3n88nTSHCxYlV8KdenWcH3k2rzT2cYaEq+sE0POw5LSVIrgul/XWyXZ5rZxg
	aDjStkP8aPykCTZIrIzxVKfyhc6HEXEyri8SDENFXSMtUyfv8Ddbrdhz4KBgFUqiQPxYwbRTT61Bi
	ZIAz3/UZL1OUMdm8zJHfXZJQT2LSf28TSI+zzyKXyqKwOGhT5CTBl7dgtvurHYFA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uqU33-00000001i0f-0hYv;
	Mon, 25 Aug 2025 12:03:33 +0200
Message-ID: <c9c43ed6bda02ead41773cadb41d9bb303db9444.camel@sipsolutions.net>
Subject: Re: Recent versions broke Wireless-N 1030 BGN
From: Johannes Berg <johannes@sipsolutions.net>
To: Ingolf Gehrhardt <gehingo@freenet.de>, linux-wireless@vger.kernel.org
Date: Mon, 25 Aug 2025 12:03:32 +0200
In-Reply-To: <c086f53df499061f069bf4c49ab7232b8e75d9a8.camel@freenet.de>
References: <c086f53df499061f069bf4c49ab7232b8e75d9a8.camel@freenet.de>
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

On Sat, 2025-08-23 at 09:23 +0200, Ingolf Gehrhardt wrote:
>=20
> I think this might be because of:
>=20
> [   31.404357] iwlwifi 0000:05:00.0: Detected Intel(R) Centrino(R)
> Wireless-N 1030 BGN
> [   31.506140] iwlwifi 0000:05:00.0: loaded firmware version 18.168.6.1
> 6000g2b-6.ucode op_mode iwldvm
> [   32.002851] iwlwifi 0000:05:00.0: CONFIG_IWLWIFI_DEBUG enabled
> [   32.002925] iwlwifi 0000:05:00.0: CONFIG_IWLWIFI_DEBUGFS enabled
> [   32.002937] iwlwifi 0000:05:00.0: CONFIG_IWLWIFI_DEVICE_TRACING
> enabled
> [   32.002949] iwlwifi 0000:05:00.0: Detected Intel(R) Centrino(R)
> Wireless-N 1030 BGN, REV=3D0xB0
> [   32.093060] iwlwifi 0000:05:00.0: Failing on timeout while stopping
> DMA channel 8 [0xa5a5a5a2]
> [   32.111342] WARNING: CPU: 1 PID: 467 at
> drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c:212
> iwl_parse_eeprom_data+0x5ba/0xe20 [iwldvm]

Probably, assuming you didn't see that WARN_ON before? Just making sure.

It's almost certainly with the config rework, and the only thing I can
imagine is that the EEPROM size is now wrong, but I don't see why that
would be the case.

Could you change it to print the offset, address and eeprom_size when
this happens? Or maybe even print them both with the older kernel too
when it succeeds.

Or maybe you can even bisect it?

There's a somewhat related bug
https://bugzilla.kernel.org/show_bug.cgi?id=3D220477
but that just misses the entries which was easy to fix. That doesn't
seem to be the case here since the firmware is loaded.

johannes

