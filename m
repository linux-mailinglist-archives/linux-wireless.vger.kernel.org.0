Return-Path: <linux-wireless+bounces-26928-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99705B3F7DD
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 10:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A34E7B1ABE
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 08:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A2B2E8B78;
	Tue,  2 Sep 2025 08:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="N5tqS5yW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7EE32F757
	for <linux-wireless@vger.kernel.org>; Tue,  2 Sep 2025 08:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800599; cv=none; b=C5avwYfo4+WgZh7crBOtKSB5sGROfnkciBnreqTqSpQz0rJzThjcmYaoIyDAnLs7Lxh46ViEy+xr0utKKhz528MhwLgB5al+FO34h0LH2ZH01sc2UX+FV6VD4QuPHeCUUfZSVdJtV6ls4OIfCWvxaUYqRaTyOWxSFHE0LBDOCBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800599; c=relaxed/simple;
	bh=S9fvQ31pKfzwJRRXfDXSZPHMBWz1+izeV6boJUKSY1Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c6FqGu/fE3qSKv9zBkgdPfJuw9EofrZowSHyl+pO/NEqMT6PiE/OBjLdvUdQdL6RZnEyqfZbBlrH52wIkk0fr3d9bJ44gdEwucfweU+uUNqWroW0+vq9Sn5KNNgbM+K7MzuyC9rUzYoMJV7dL8V9hXwMCnacqZD943ElixqUoYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=N5tqS5yW; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=S9fvQ31pKfzwJRRXfDXSZPHMBWz1+izeV6boJUKSY1Q=;
	t=1756800597; x=1758010197; b=N5tqS5yWhkFUzXxec4IjoqEfWMn+VYeK//PaHjNErzO6Aa3
	PgD/Kl6nMX+Kg+XonioLk6G1Fevx9qf/ArEB268Q90uE0B7I6KHPyZeisijgPXnnWfjN5A6O+lRZK
	Sbv6AurgGvx+UZ28FQAOAzfjmik6SuKKeX3hPC54eREUDABVeccdX31vpg3njssjzJ3va+x+qPfdv
	59i6wQFAZh0wJ+uVb4RogVJulvfztDwY2vV1xE3OsxWtJdk2LysXtzRkiRduSW3XgqBq+ifWgKzmU
	dpoPanuEeTmjnqxDVQrpseXu38du7cpaa9nYSpSbMNvhNlrH77LrhONdoDTw5Sug==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1utM5M-00000008Anl-2o8h;
	Tue, 02 Sep 2025 10:09:48 +0200
Message-ID: <87b92cbeb6c672600ab3530513d8aba5f4b0eb63.camel@sipsolutions.net>
Subject: Re: [PATCH ath-current] wifi: ath10k: Fix connection after GTK
 rekeying
From: Johannes Berg <johannes@sipsolutions.net>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
	alexey.klimov@linaro.org
Date: Tue, 02 Sep 2025 10:09:47 +0200
In-Reply-To: <20250902080400.635818-1-loic.poulain@oss.qualcomm.com>
References: <20250902080400.635818-1-loic.poulain@oss.qualcomm.com>
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

On Tue, 2025-09-02 at 10:04 +0200, Loic Poulain wrote:
> It appears that not all hardware/firmware implementations support
> group key deletion correctly, which can lead to connection hangs
> and deauthentication following GTK rekeying (delete and install).
>=20
> To avoid this issue, instead of attempting to delete the key using
> the special WMI_CIPHER_NONE value, we now replace the key with an
> invalid (zeroed) value.

Maybe better use a random value, and even try to delete it anyway
afterwards? If it's all zeroes then an attacker can predict it and might
be able to inject frames into the system that way?

johannes

