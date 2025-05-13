Return-Path: <linux-wireless+bounces-22902-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C32F6AB4CD6
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 09:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59D451B41A4D
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 07:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC0E1E5B85;
	Tue, 13 May 2025 07:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tzs0w4dk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD831DE8AE;
	Tue, 13 May 2025 07:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747121720; cv=none; b=QYOkOY3jHs3M0Qs7yhtutCdeNFL8iu3z/9sWQWLBfJD/06VT5N77BC+lnTWWq9AVLhkubvYM5BqEoFGFXn/mT8pAkkawwPNaOAuB9cQObWshXTRnoO0EEExMw0Xb/N/BjqqvH0CCaSNGipzqRZFEGALDiotQ4M2t5LyWOwN4pV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747121720; c=relaxed/simple;
	bh=/i/2YuBynnWh2jEtAcgyF7DqlckBrwhyl7m8O7cgdog=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EvVjKBIBIVVfW3QywZBP6iU5TC0pjNMLOdfAx9UHtDykOI1oy0uUVNYT8gHNZ09iCjw7w05p9C8Pqel3VYLM9hdbKU+DSUHEfz36o9roH6orvmy2Znty6H9fDgHTb1LO0ce2Dae52A/AwtqUUO4ugWcaVGnMQf0ePE9swnJLDZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tzs0w4dk; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/i/2YuBynnWh2jEtAcgyF7DqlckBrwhyl7m8O7cgdog=;
	t=1747121718; x=1748331318; b=tzs0w4dkFqnzo3rbeg6TXYwF1PrlEytJofXvergykJ5j2dU
	XiNC+m+v65aiypqfw3Bz0Vug9S8f96RneHluO55ejLy3EDrF90Rkgc1Akz4+0sE4iSkt/iUEpc9sc
	rJIaFRa7niYV3XmOJc1OM3ZUrIzZ0t7UWXTzYdmiJI7Y0tR8H+KUhvomxIUn48Die9hmaXSt8ZLt8
	lmpV5MHTsDbfeivfaSKsxGvs7b693d68St9i0FgouFt88pXVDwPAHMeXhgq4KnkNJ//TpHH2u2lsy
	8FSUc3UgwCJwKC57gZ59ARaHHnxtq5EsXrB+beFcFe/NDCFKB6p5eFZJRDczuYeQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uEkAU-00000005LBD-1FXa;
	Tue, 13 May 2025 09:35:14 +0200
Message-ID: <8a1c5172bc0fd9d2a33522294d1a2a4c4ceb313a.camel@sipsolutions.net>
Subject: Re: wifi: iwlwifi: SAE fails when AP sends confirm before STA
From: Johannes Berg <johannes@sipsolutions.net>
To: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: James Prestwood <prestwoj@gmail.com>, linux-wireless@vger.kernel.org, 
 Miri Korenblit <miriam.rachel.korenblit@intel.com>, iwd@lists.linux.dev
Date: Tue, 13 May 2025 09:35:13 +0200
In-Reply-To: <aB5onavenLymR-QJ@archlinux>
References: <aB30Ea2kRG24LINR@archlinux>
	 <4ffbeb94-ac19-4437-9d98-24981fe6c240@gmail.com>
	 <aB4HC8Iaa6wR5dj7@archlinux>
	 <15943a1f-0e5d-4705-b8ef-3f22fa3fe672@gmail.com>
	 <aB4hMsBfyawYatoj@archlinux>
	 <902daf8802c723d72fff0155cd0638848ce1bc7f.camel@sipsolutions.net>
	 <aB5onavenLymR-QJ@archlinux>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-05-09 at 22:42 +0200, Jan Hendrik Farr wrote:
> > Could you do trace and sniffer at the same time? According to the trace
> > there was no authentication frame from the AP. In the sniffer capture i=
t
> > _is_ there, of course, but I'd like to look at the timing.
>=20
>=20
> Ok, I did another capture.
>=20
> 1. iwd only knows credentials for a single SSID: kepler_test
> 2. kepler_test is the only SSID broadcasting on 6GHz channel 37 (or any
> 6GHz channel)
> 3. I captured 802.11 frames using a second device
> 4. I did a trace on the client in question
> 5. I captured dmesg and iwd logs
> 6. All captures were done simultaneously
>=20

I'm confused now, this all looks fine from a driver perspective.

We send SAE commit, receive SAE commit, send SAE confirm, never receive
a response. There's no response in sniffer nor tracing data, so that
matches up. There are a couple of retries of the confirm response, but
that seems OK.

Seems like maybe iwd builds an SAE confirm that the AP doesn't like, try
wpa_supplicant I guess.

johannes

