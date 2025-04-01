Return-Path: <linux-wireless+bounces-21020-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62045A774D2
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 08:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F0957A315E
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 06:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54401E5B6A;
	Tue,  1 Apr 2025 06:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="SPrcqjaO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB171E6DC5;
	Tue,  1 Apr 2025 06:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743490625; cv=none; b=Xn18crUQjyzl5EUH6NyExUcfSZB14nUbLEV5LM6VwLDkUDUbvjS1AQMQPjo9NQIRCfSiUD81taAGcI5voXly2nSlskQrCgkdxWYIBrJuXRvjQyNYjaEk+S57lMuM3IEJDDcyLEjcxNbpATo+G4JFcs6d9U+FJdb/MjX/UuKAVj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743490625; c=relaxed/simple;
	bh=wJe3WZS/uGSGahYihWwJtsVLST3azpD13G7BDSRIehk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VUHcKiNMNgdyvAsGfKkmXH0FIeYennmOlzgLECpwAWVsPDFHror8yWHcx+6A9Q1bvR2U9VpJEWj1as0/gvfe9yTpVcM/Tvf2grOtdxvfaoUfKTdZp6PsgVywQal4kfsRXg1lZLbh3QC0xRVpwQdC22e+ng1AGal6euZrdN0Eu6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=SPrcqjaO; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nXNaZTUxaRwvpA9JfeBgD5Q5H5ioeByhSjBTYXbn5aw=;
	t=1743490624; x=1744700224; b=SPrcqjaOM6A2uDc+ILRwaMQuyEbJGNNGUs+uP8xO4IdOLNI
	cTElXv1jc7VkP+BQEK5VqZRKmBQTisN80KNPE15HpV6B9NbzliY8HPUC+jCLm6pIUuV3vPm2msniR
	BiYxyowP4/JeWe8neYKT3L6s8uT4sS5SeIDlp4tNq/ftHENShT/YR1cIg6Qt72cF+z5mqfhoNHDpI
	c/78/lKbS9SMkKkHYkbLv25816aiWCCaDCigyxvQxYNzfYpmuZEYpVL1vHp+OQ0zK/obBMzmJnKcR
	Vt3OCNpSPx86YQeJttcWs4DeKuZWYxaWGN3rAcsjgvCrccATPKuoKrNe/veACIuQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tzVYD-0000000C6vB-3O8q;
	Tue, 01 Apr 2025 08:56:46 +0200
Message-ID: <5a5147038b771980b87761a75be38e1d9d43d1fa.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: iwlwifi: mld: Fix build with CONFIG_PM disabled
From: Johannes Berg <johannes@sipsolutions.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Miri
 Korenblit <miriam.rachel.korenblit@intel.com>, Arnd Bergmann <arnd@arndb.de>
Date: Tue, 01 Apr 2025 08:56:40 +0200
In-Reply-To: <20250401032153.2896424-1-linux@roeck-us.net>
References: <20250401032153.2896424-1-linux@roeck-us.net>
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

On Mon, 2025-03-31 at 20:21 -0700, Guenter Roeck wrote:
> If CONFIG_PM is disabled, the CONFIG_PM symbol is not defined.
> This results in
>=20
> drivers/net/wireless/intel/iwlwifi/mld/iface.h:169:5: error:
> 	"CONFIG_PM_SLEEP" is not defined, evaluates to 0
>=20
> because the conditional uses #if instead of #ifdef. Using #ifdef
> fixes the problem.
>=20
> Fixes: d1e879ec600f9 ("wifi: iwlwifi: add iwlmld sub-driver")
> Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Maybe this has already been addressed. If so, sorry, I did not find it.
> I did not see thos fixed in Arnd's patch addressing the other PM_SLEEP
> related issues in the driver.
>=20

Hadn't, except internally I'd fixed it a while ago, and now Miri sent my
patch (same as yours) 20 minutes later ;-)

Thanks, I'll start getting things into the wireless tree soon.

johannes

