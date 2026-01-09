Return-Path: <linux-wireless+bounces-30598-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 43390D0801B
	for <lists+linux-wireless@lfdr.de>; Fri, 09 Jan 2026 09:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4D474300E613
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jan 2026 08:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E606C35580E;
	Fri,  9 Jan 2026 08:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nXTpbZbr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61AE355807
	for <linux-wireless@vger.kernel.org>; Fri,  9 Jan 2026 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767948973; cv=none; b=ZpRNXsWoVEsVT5DLnpxb0GRqJsL/4K/bBkorceAU1Honl/3S0rDDJkCPgIgm1mIWojNPCMkXtNZeOtOSoyxQPn2j7FCTMQ1M6/qj/cKmMqyXsZ31cS2e0CD9irQF+8RNO4vZZfxkXJfUeIsp+/ogHNYfIure3Ycqrjp5HJBohvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767948973; c=relaxed/simple;
	bh=PVm8dp3hcUYrzfg0J6c0O0j8Gdla1mPiLmtrfg5Skcw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Aj78UQpgiByNMIafPXu9dIpayXL63jaV1frNmcA7JhY0CFVYLRvE72tkMiOJTwtfJ0yTTvGvQoGwbgVn0oxBgrCtvm69+F/7eWReZCNZ5HUy6GdkJYWNH2uNiZaFyZB2gZ0vjktoUJzRGNEskFusTqmeNZ4XhjzwFfV4/ZmPza8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nXTpbZbr; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=PVm8dp3hcUYrzfg0J6c0O0j8Gdla1mPiLmtrfg5Skcw=;
	t=1767948970; x=1769158570; b=nXTpbZbrBjVjzSPjAtkafcHbfQ409vyfNDofAuRjjDqUGgY
	Ww6R944hd17+C+Oyrs80s38hTidojAyZl7ZvzqVm86pJC1OkKMB9BogzuaA59fiCGKApLFBAlGj+c
	m9KFZTurGLZSdUk1Tb0EOR9Jv9TFMPBWf656nnmHuNWBLSEwE5KB/0gdVcZbd64ZCN+/k8SxR8xKq
	ucISf14PdffeZQZbqIEQQ3Azvo/TcjckOanw9L8OaTpIMI+AE5MfNJ3HL9rrSZY07IKKIWUNJgWjV
	W2oJZDCZmKo7kHpFrGAfyK556RP6hE+VLnVuXOqTYY74kbI8nS7zRAbogTsumqDQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ve8Hq-00000007LhS-1pZm;
	Fri, 09 Jan 2026 09:56:02 +0100
Message-ID: <0a076df80ffd036a38803662b25e558d9d1c4297.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: mac80211: check BSSID before
 dereference
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <sarika.sharma@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 09 Jan 2026 09:56:01 +0100
In-Reply-To: <20260109034829.1489135-1-sarika.sharma@oss.qualcomm.com> (sfid-20260109_044923_922083_CE78FB63)
References: <20260109034829.1489135-1-sarika.sharma@oss.qualcomm.com>
	 (sfid-20260109_044923_922083_CE78FB63)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2026-01-09 at 09:18 +0530, Sarika Sharma wrote:
> Currently, when retrieving the BSSID value using the function
> ieee80211_get_bssid(), it may return NULL under error conditions.
> Later, in ieee80211_rx_h_sta_process(), this value is used to
> compare Ethernet addresses with the function ether_addr_equal().
> Since ether_addr_equal() expects two valid addresses, this could
> lead to a NULL pointer dereference or other undefined behavior.

That's a very local argument, did it come right out of a static checker
or some kind of LLM/AI tool?

If this _were_ necessary (i.e. could crash today), then surely the
change should target wireless.

If it isn't actually necessary (today), and exists perhaps only to shut
up a static checker tool, you should say so - and ideally also explain
why it's not necessary but why it's better to have the check for future
maintenance or whatever.

As such I don't think this submission makes a lot of sense.


(Hint: fairly obviously, it isn't actually necessary.)

johannes

