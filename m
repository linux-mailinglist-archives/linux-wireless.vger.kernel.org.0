Return-Path: <linux-wireless+bounces-12156-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 574B8962545
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 12:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 028C41F232C7
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 10:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9FE158210;
	Wed, 28 Aug 2024 10:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="V8Z6FaAC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F145A79B
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 10:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724842282; cv=none; b=HEa/vpNMY2N2GTaDgGok49UB0n3TBcZOPvg8kFisivRinKvj0qJZGnR4xtf1XLwRaATgYoq5Sxk6hHTDw55geyY48ChZxYkm+9rqQ0gMaRmSjihsPDy5CWDTpwVuZOJSwehepBrqoqPIrAZhbuP/n+h7SlDE5EgznZi2SVJ7vd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724842282; c=relaxed/simple;
	bh=bA4YP4+gZTChiZrFujTIhKUQJJDGc/o3TJrCgak5gyk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QXzUfujCN4g0uJj/rOUTv03bwMz2eRCasUstkhC3IrTgWCMuNh4DqoDT2LRMLbTLLFjfXXOq+Zz/920Uc2xAbEfztan+ro8hxF9Lra3DaLSKRvrgKL4RDIsmlCgRuCB8hVcUJPF0r6Z8QDrPT30ioJjLHFXV2sNZgvqakH0aON0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=V8Z6FaAC; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bA4YP4+gZTChiZrFujTIhKUQJJDGc/o3TJrCgak5gyk=;
	t=1724842280; x=1726051880; b=V8Z6FaACMo0SCVBH7DGfyfATO+MwfoyTO7JV+ma7WpTJIM3
	HwQ7DlEUmDy0MDzWiiKvcbO9yWij3F76o8+L1XiSe58L8h7jq0Jd/IPn+EDa40wCdLNUzDHgWCRP1
	cESb9TwUZqMX3gy+c+8Ww5a43sqrgBSRuZT7p/+6ec2DABoU8/g/zLar+JGFtPCnOpVTxi7Eg1dqN
	A1/0doI7INKt1SBEmsEPoS+zkU/uG9JNy39FxA7QckAggu6K78ySeP110BBo3pmWk3c/JsLsad4CI
	5RZDWPG9sZCM9Ft9nmq14uTjSLw8wADu2P9EX6swX1M1g2ZGUuzcKxXxcSvupdpQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sjGGj-00000006zAR-2Qji;
	Wed, 28 Aug 2024 12:51:17 +0200
Message-ID: <b06bd094c16da98e7bb490bf8f9a658ffa2403c0.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: cfg80211: check radio iface combination for
 multi radio per wiphy
From: Johannes Berg <johannes@sipsolutions.net>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
Date: Wed, 28 Aug 2024 12:51:16 +0200
In-Reply-To: <d2ca7bdd57bb4d90e4b76846afb75dbc3bb9bd59.camel@sipsolutions.net>
References: <20240813055917.2320582-1-quic_periyasa@quicinc.com>
	 <d2ca7bdd57bb4d90e4b76846afb75dbc3bb9bd59.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Oh and with all that said - we still need a patch like this, but it
should check all radios *and* the global combinations.

johannes

