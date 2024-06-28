Return-Path: <linux-wireless+bounces-9685-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E4991B9CA
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2024 10:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A731F22D17
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2024 08:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD26146D49;
	Fri, 28 Jun 2024 08:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="GqkpJTBU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DA41465A1
	for <linux-wireless@vger.kernel.org>; Fri, 28 Jun 2024 08:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719563075; cv=none; b=Oy+KTzl0hLbdgsLz4bRP2ulQTKLCrkzUsagknBoKhzTn9zzrI2eDY/7/iEIfpGe4Gyb5Fv8a8Lx36hsO3mvqLND0ncHnDkq0bTOdEk/3yz5el2idefTptmTzZYSrS57eGJgyugDTxG/YxVrVp4FkpM39tyHKEW7rVvcjCVXRac8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719563075; c=relaxed/simple;
	bh=kel1tbTt9VZr9itYM1WHalYitrZY/+9P7DAWHU0tcEg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Co/tbAdRqXY3tQVQObC+zuz24JECiYKVgN4Yr6OUPmWEusNW0N83o4Rqz5LOXtrWjjywfSJO9yHQ0Mn9XIoaQGux8/axN4VeUbI/6pf68sDt7iBltFufcAKIjWvHNjAdaXOc5d7nKKuNtxm7C3KWMC21/Z9r5rJciRB64opZMgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=GqkpJTBU; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=3Y6J2zFonVb2ahpnlDNbtHbab3n2SI+dOEprUvkblMk=;
	t=1719563073; x=1720772673; b=GqkpJTBUykxaXKMKaq9u9r1PNiPfuQdupT5eudwyM/Pq0Nd
	BXXk8bqKnPU00mqIJTNP6toZWVzBsyA7SYEPn5eS9b/WbRL1Ul6ZDmTnagqnQR3m8JUs/bkKHsJj4
	o7JPb0hStjoUaFJ/9R9TBGn1SX2qrxkMtwRDR7MgZ90CmtPz/OJi55F3XqR+pc2/KezXHVTqtUuuO
	ZzltZow4z4/Qy2kw7aoU8ezan9JTMbqXXvFha649HCOvLCxJn1avDpywm7/zTkh0/KtuRkju/aQeJ
	Foqdcksbc8LRb+2oDbsfj9W09nPhNrFnCWnN53UJECAIm1pb7KnUOFo0nUAbZYFw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sN6uE-00000009W5N-1Qb2;
	Fri, 28 Jun 2024 10:24:30 +0200
Message-ID: <2c456cc91911cf1def96aa4378b70b001eda1c78.camel@sipsolutions.net>
Subject: Re: [PATCH 10/10] wifi: mac80211_hwsim: add support for multi-radio
 wiphy
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc: quic_adisi@quicinc.com, quic_periyasa@quicinc.com, 
	ath12k@lists.infradead.org
Date: Fri, 28 Jun 2024 10:24:29 +0200
In-Reply-To: <b2f7aea3341e8610880e46d91e984a6e2c14b3f3.1718881762.git-series.nbd@nbd.name>
References: 
	<cover.a7730420cfba0f204a60e4c30e6b0e07b441ff6b.1718881762.git-series.nbd@nbd.name>
	 <b2f7aea3341e8610880e46d91e984a6e2c14b3f3.1718881762.git-series.nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-06-20 at 13:11 +0200, Felix Fietkau wrote:
>=20
> + * @HWSIM_ATTR_MULTI_RADIO: register multiple wiphy radios (one per band=
).
> + *	Number of supported channels for the phy will be per radio.
>=20

This should document that it's a flag.

Also, you didn't add a policy entry in hwsim_genl_policy[]. It may have
worked anyway because that policy doesn't have a .strict_start_type in
[0], so please add that as well and set it to this new attribute.

johannes

