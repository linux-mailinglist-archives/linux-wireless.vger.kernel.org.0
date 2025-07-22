Return-Path: <linux-wireless+bounces-25856-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0773EB0D99E
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 14:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 034CA1C23C9F
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 12:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE612E11AD;
	Tue, 22 Jul 2025 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="m94Yv7iL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A39A95C;
	Tue, 22 Jul 2025 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753187137; cv=none; b=lIiPPh1BviPhQYs/Abk8P/u9/5O/kyqdSA4KbgGdXFd9gum+Ztyw0ifLY1Gz0hj8QMn5MPQKiCV4GD41ugE03qK00QeA0s+gLd4YBWzbmBFXdXkWg4URsd7n9s/pJeu/hxRmLWkpWA20zH5qczJqugb42u0Z/fL2xwHqY/DVHcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753187137; c=relaxed/simple;
	bh=VYf8X9RrIO7X2ADw/VMrhxs0dZCdmkHTN5UKXV2BgGo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J5YI2OANe/N6YmOTPI4sYRw7c7ubRJ5rZHFG9eGUR25sfxsckN0JjeZBrxfNnt5zDKeSQOe++IpDfZQvQpu7H3UjbF+/YzLCDCHLLaTmaV1qOfFw8E+F5P0IIiGrSerwS+Dk8Mj78pzYqH08D/Q650Htd+EM6+prUgPjHrjII+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=m94Yv7iL; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=VYf8X9RrIO7X2ADw/VMrhxs0dZCdmkHTN5UKXV2BgGo=;
	t=1753187136; x=1754396736; b=m94Yv7iLEBCDMNatYjNd6PfFh22fTyKXlRLXstVgGhtPBS+
	Dtd42xF81B0XvrIOA5b+OcuA92n9tz4zjiOg8iElfQ3mi2AS0zZzkGT1pDEd3F+cTThphaX+4v7J9
	WolSWH9sOgz++qtdEnLW4TMnKa7Hvof1HPcjX7so7t3Xhy6LKndTob8Sx20Ru6MGLqDPhWJY8BEnv
	xlQxwPqX+jkNGLf0sB/coQ7mH2z64KrInqCh1ppJ8XioBFeB3O+TmrehRm9PPEUFnTtnH+cErw8Ow
	ZaWJFXCBZFa+4cgM7egABruphMMM/eX13SP4tAoDCZn2zwBtu4LoH25pDwMir7IA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ueC3p-000000026bL-2zZq;
	Tue, 22 Jul 2025 14:25:33 +0200
Message-ID: <cdc17da890c87dc2dd6e521197594f1be1eb0a03.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v2 wireless-next 2/3] wifi: mac80211: Correctly init
 MLO link in ieee80211_8023_xmit()
From: Johannes Berg <johannes@sipsolutions.net>
To: Remi Pommarel <repk@triplefau.lt>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 22 Jul 2025 14:25:33 +0200
In-Reply-To: <a62f4c066c967c954648a409e5e1fa185d6edeb6.1752225123.git.repk@triplefau.lt>
References: <cover.1752225123.git.repk@triplefau.lt>
	 <a62f4c066c967c954648a409e5e1fa185d6edeb6.1752225123.git.repk@triplefau.lt>
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

On Fri, 2025-07-11 at 12:03 +0200, Remi Pommarel wrote:
> The IEEE80211_TX_CTRL_MLO_LINK info is the only part of
> ieee80211_tx_control where a 0 value has a specific meaning. Thus this
> should always be initialized with IEEE80211_LINK_UNSPECIFIED if there is
> no MLO link information associated with the skb, even using when 802.11
> hw encap offloading.

I'm not against this and the patch looks fine, but I guess I'm surprised
it even matters to anyone. The encap offloading fundamentally requires
that the driver do more work to identify the destination STA, and then
anyway the link is picked by driver/FW? Or is there a case of encap
offload with _multicast_?

Anyway, looks OK and just sets a few bits that I feel like it's weird
that they're even used, so doesn't matter :)

johannes

