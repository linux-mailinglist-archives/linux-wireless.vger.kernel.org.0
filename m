Return-Path: <linux-wireless+bounces-29789-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D20BDCC1AF6
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 10:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67D48300A358
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 09:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE2432F76D;
	Tue, 16 Dec 2025 09:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="oqJ+rJie"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA112E413
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 09:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765875875; cv=none; b=slQ3ONMWF0oz1oBFEFX7m9B7eqeCKaReEGiLnAoucIzzMDgRcTABoXp01y1+gm56yfHaxotsOxkqoEvrqfA3e8AhRTKFGcimYCArADS5z2su/6Zbvb/SdlBA9c9fmGSiYUMik9+VppSE1GND0r0pa7xjIwgKfRzl4attsmkSra4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765875875; c=relaxed/simple;
	bh=V1I0j2bW63nGuyNzAAxgrH+jHkbPA11yfs9LeCxkBl0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ui1rpt5BxTtymjgehCC2DZDZ4P8zjatpYzFVqWfhxCSSWtjkLWgV9cwbsgfz+UcRu0ifsLhvHytzpRlc6Ejapr1Er+gNRoPXNuyekf8pzcsMeeLWk7G6cvzQfY3R/nZKpLl2ZUbDrm6vUEOom2jzKJNyP9FPeJdZrbUeAUFTZqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=oqJ+rJie; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=V1I0j2bW63nGuyNzAAxgrH+jHkbPA11yfs9LeCxkBl0=;
	t=1765875873; x=1767085473; b=oqJ+rJieczVMouQlumo6RvZRD4FQuEA8ZWiCKkomi0OwEBE
	hoptOEApQT55ernPWiH8j/sLX8BLqiskvRXXgj57JQWMbY3YpNBJi8CATufPDQlqAJkaZN3qzFbYe
	RL/rZEdr9V6IWR3hwz8+GabWS1n0OLgdddAsM2jzyySmYcQkA8qw733WEbb3y/kpd5vDJJxxEvm6G
	mBNgHH3uiR040te6DOz4ZErQRLPaL7MP5Fjex5ZKsSWzZkHveAuDyP4SfcZvwsogdzFTLS/e7J5U8
	aFChoKZMy9xARSTM9EgFwcr2TDXRRbCtxpJ61kEhojvoDWzotXHd88b3lGciCyNw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vVQym-0000000AE1G-3Gyw;
	Tue, 16 Dec 2025 10:04:24 +0100
Message-ID: <07cab823d7695b20aa7ddb1b3698e5eb88ff2c9c.camel@sipsolutions.net>
Subject: Re: [PATCH RFC wireless-next 00/13] wifi: ieee80211/cfg80211: Add
 UHR (802.11bn) Capability and Operation support
From: Johannes Berg <johannes@sipsolutions.net>
To: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 16 Dec 2025 10:04:24 +0100
In-Reply-To: <20251216062656.1738022-1-karthikeyan.kathirvel@oss.qualcomm.com>
References: 
	<20251216062656.1738022-1-karthikeyan.kathirvel@oss.qualcomm.com>
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

On Tue, 2025-12-16 at 11:56 +0530, Karthikeyan Kathirvel wrote:
> This series covers support for UHR capability and operation (11bn)
> advertisement in AP and STA mode. The objective here is to give an
> idea of basic changes needed for UHR in cfg80211/nl80211/mac80211.

Huh. I never posted my version, sorry about that! I'll see if I can do
that soon so we can compare notes, but I'll also go over yours quickly.

johannes

