Return-Path: <linux-wireless+bounces-5279-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1FF88C2D3
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 14:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE69B1C37830
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 13:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF571EB56;
	Tue, 26 Mar 2024 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="n6+LIudR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5EF5C8FF
	for <linux-wireless@vger.kernel.org>; Tue, 26 Mar 2024 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458015; cv=none; b=JwHx8asBww0d4srJDZEgJQ3aKl3F7/697Zj8FYnwoRwc79qlEZVtoOXIE6/DT7BwmUF4A5yNcPYXsGEzoVNrYtQebSZ8E/54FgmOUv5KWt7uk6hf3+ErMBCgie+I/A68fLfBBJp1l6o16phXNvxdI0u9LsdE0Nag4QSaVKvUEwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458015; c=relaxed/simple;
	bh=XquPexlBeCnUmNJuwf4QZdgQ1z92DGFKafdA+mtAJfg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OasMFmFK9Gftg3b6z5j2DexHuvqHDQhLu3GlLNqw2Hxn15p3iS9uW5SSNPet0sCZn64LHzcXOcyUhgGtqPgmcm+jUZMMv0UApM7Q7DncreGi7Pa1DtnE1sDlGlEqFd4lINnP57IxEDgUcq380921r7lC1TzRmaSoj/xf+vi0EQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=n6+LIudR; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=XbtUGTxTvdJ+nSK0YCv7H45g7hymlRPfVV935Zo+Jys=;
	t=1711458013; x=1712667613; b=n6+LIudRPm7nKwEoKXG5HReIh01fzjW9aCjiHcItEYaYUF3
	nNGN09PN8NTl4i9B4h+SmbHlHWneFWybMW00QW1O/OnVdOmXXez+N8pkTHaZ98ZbqMNNlKFzZmrgV
	Ja2ncW1ZioKpX+8FMoKLGa8vmdZ5PfTdy+WiKBqo3oZSE3QDHISEJ3mekyNFz/7IZsAqsF88MsnX6
	jjFn13pZHOB1RFaoFkgy0J+Ou0oWr9gXbIi2PTgBJyxtt4lEVGNfl6z8Xb3TspXtMHqwmB+DSJRsy
	WFHivcKVseK/rLRHepC4Z7SAK5J07dOC7qJ5KRjl9ynB3Cag7TpWzr0bFbmpE3hw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rp6PR-0000000Fj8w-2tR7;
	Tue, 26 Mar 2024 14:00:09 +0100
Message-ID: <8efc258b698acd504c1fc699d026b906bf383894.camel@sipsolutions.net>
Subject: Re: [PATCH 01/10] wifi: mac80211: Add EHT UL MU-MIMO flag in
 ieee80211_bss_conf
From: Johannes Berg <johannes@sipsolutions.net>
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>, 
	ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Tue, 26 Mar 2024 14:00:08 +0100
In-Reply-To: <20240325201031.10837-2-quic_pradeepc@quicinc.com>
References: <20240325201031.10837-1-quic_pradeepc@quicinc.com>
	 <20240325201031.10837-2-quic_pradeepc@quicinc.com>
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

On Mon, 2024-03-25 at 13:10 -0700, Pradeep Kumar Chitrapu wrote:
> Add flag for Full Bandwidth UL MU-MIMO for EHT. This is utilized
> to pass EHT MU-MIMO configurations from user space to driver in
> AP mode.

This ^^ doesn't match this:

> + * @eht_80mhz_full_bw_ul_mumimo: does this BSS support the reception (AP=
) or transmission
> + *	(non-AP STA) of an EHT TB PPDU on an RU that spans the entire PPDU
> + *	bandwidth
>=20

which doesn't match the implementation ... Wouldn't be a bad idea to
actually do what it documents though, I guess?

johannes

