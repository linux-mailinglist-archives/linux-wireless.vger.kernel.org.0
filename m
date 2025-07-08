Return-Path: <linux-wireless+bounces-24934-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B81AFC9CD
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 13:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C197D3B72DD
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 11:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2895D266B65;
	Tue,  8 Jul 2025 11:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="LE+38SLD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A728779DA;
	Tue,  8 Jul 2025 11:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751975108; cv=none; b=JywU/1WoKHZrjRxzdjsv1LO8fKpHdMehZkSjwXQiLRq5/TyHm1D8NRViMLozjzlMGH5z27gkTInB8hr1eMd06TW6rUBaK/PrJyeR7Yjul84k7/cFPv8xsC1KHX2IbIgNAZEQgml5JoHadefvBxRRFH6nVnBEfEJm97Io6T81U/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751975108; c=relaxed/simple;
	bh=OUWXUObAAT6qENhLF7SHRJS/utQKQSNP4cfbJShIvow=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WOlvCl43k9SJ65qQGWPvoY7Fju0EOvhGlXRd11O/jFw4cwaiOtXMKD1+xNpRTVDrNkXN4fwz+0zhBDsb/YWzsjGkOm+c9Y4hCeleYWTBqOM2766P+M/r8P7iBl2aN4M9MpdxX8XL64tN9oYLsjlYAPZLdmRVSRU7lT3lCnht0w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=LE+38SLD; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=OUWXUObAAT6qENhLF7SHRJS/utQKQSNP4cfbJShIvow=;
	t=1751975106; x=1753184706; b=LE+38SLDThNgoSMq+G4aUaStvlaHHJzOMAmfmqcdlY9Og3+
	zYPH4nV2YklKyv730kdWWgmwsWWO63jIBnxoEkimnebv7t3RrMc4MgunzXy6fRCtE3gGvITy2FILY
	hzpo02ZyHZIDaYAL9TQarTa7Tb4OCwkE+k1qmWArsZAQatCQT4zHz/FK9UsH6TSiUJcHp1r3Yyu5a
	7maai0gAamxsC1wEwkrYqmhrMAGSvztVw1EoUw2nGTBRA15HSt7AvGjw8gZ+2FY2qFboy2DYwvW4E
	8KNgDlfIJPRFLcHIVSRLjAFknejtrDNUaBXTj26NdMgcRMLuJRB6BmJtB+T3AkGg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uZ6kx-0000000Br7X-0iK0;
	Tue, 08 Jul 2025 13:45:03 +0200
Message-ID: <b71db1e03da50e161b898a763bd01f6a1c8ce3e2.camel@sipsolutions.net>
Subject: Re: [PATCH v3] wifi: wilc1000: Add error handling for
 wilc_sdio_cmd52()
From: Johannes Berg <johannes@sipsolutions.net>
To: Wentao Liang <vulab@iscas.ac.cn>, ajay.kathat@microchip.com, 
	claudiu.beznea@tuxon.dev, kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Tue, 08 Jul 2025 13:45:02 +0200
In-Reply-To: <20250519084211.1752-1-vulab@iscas.ac.cn>
References: <20250519084211.1752-1-vulab@iscas.ac.cn>
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

On Mon, 2025-05-19 at 16:42 +0800, Wentao Liang wrote:
> The wilc_sdio_read_size() calls wilc_sdio_cmd52() but does not check the
> return value. This could lead to execution with potentially invalid data
> if wilc_sdio_cmd52() fails. A proper implementation can be found in
> wilc_sdio_read_reg().
>=20
> Add error handling for wilc_sdio_cmd52(). If wilc_sdio_cmd52() fails,
> log an error message via dev_err().

That's clearly hno longer true, please submit consistent patches.

Also, this change (at best!) addresses half the problem, please fix it
fully if you want to bother us with it at all.

johannes

