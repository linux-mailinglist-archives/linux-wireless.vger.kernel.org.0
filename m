Return-Path: <linux-wireless+bounces-12731-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB14972ADA
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 09:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7941C23F4D
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 07:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F3B17DFE3;
	Tue, 10 Sep 2024 07:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f8eRsMDi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CAF17D36A;
	Tue, 10 Sep 2024 07:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725953586; cv=none; b=Ui78YaEQhVmNHftazQbjDxhAmiH7abnDF/AVCNAlvYq8G4fheUJgL5U+P4FG/SvB3soSqLj59L189cEQb0SEg4bC3gWRrSkLdUfM1GZrwd6INzZ+w67pgUxCR4hF0kyeyIXoyNwv/q6NDrWoAiRva3pGZcJdQXVnL6geXt2PrZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725953586; c=relaxed/simple;
	bh=nxWRbMPcPT8DxZ6rLJCDCedHg5P5qBOshhja50/iaqM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TdfOGXuWkzrMlF/bv2X78+7mfEeK13BwCYCHOWRn17gt9jmPwjBoM46/wWzUMA8UL4g6AK0KCTS9Y0LPKsPnEsTnP3Q3R2hSG2w9DYJuhd8f7b5GnFKg2w99fzFRp8r2c4SolfRxy6N5s+ul+7fCVfNCt/YZGVKDQWPq/+kJVYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f8eRsMDi; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 24A621C0003;
	Tue, 10 Sep 2024 07:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725953581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nxWRbMPcPT8DxZ6rLJCDCedHg5P5qBOshhja50/iaqM=;
	b=f8eRsMDi3Xe49ZZwYx8gG1NtFsh6+O/22ApWQbL8NWdeX3tLXgwETdKiXt2rysY4RQi4lD
	C13r7LSjg+9dQNQWFHWcdGsF8sSw4p0K52qyIp0e0M0sQ5WP2QPeoc+FigcYAM48u3ILdF
	tYaF3zIoxOUOKXjo9sJ5arT5d8mdhW0ENBmmbDugA7eYYVCSivO4tL8X8R3cNxN7GNc9fF
	AZ44I2znp1F9tcmYCnmKWfHFvRsK9ru5/ufu0SKC4HJZzLGauRcOU4/tnW0b7pXODzxEBo
	z68W6zJvIbYwO9wU9EQ4B+EUN6kGL3fyt7SB5/LEk0JOh1F2u+GJKloNxriDvQ==
Date: Tue, 10 Sep 2024 09:32:58 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <claudiu.manoil@nxp.com>, <vladimir.oltean@nxp.com>,
 <louis.peens@corigine.com>, <stefan@datenfreihafen.org>,
 <alex.aring@gmail.com>, <chunkeey@googlemail.com>, <kvalo@kernel.org>,
 <briannorris@chromium.org>, <francesco@dolcini.it>,
 <set_pte_at@outlook.com>, <damien.lemoal@opensource.wdc.com>,
 <mpe@ellerman.id.au>, <horms@kernel.org>, <yinjun.zhang@corigine.com>,
 <fei.qin@corigine.com>, <johannes.berg@intel.com>,
 <ryno.swart@corigine.com>, <krzysztof.kozlowski@linaro.org>,
 <leitao@debian.org>, <liuxuenetmail@gmail.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <oss-drivers@corigine.com>,
 <linux-wpan@vger.kernel.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 4/7] net: ieee802154: mcr20a: Use IRQF_NO_AUTOEN flag in
 request_irq()
Message-ID: <20240910093258.358a6d85@xps-13>
In-Reply-To: <20240909133034.1296930-5-ruanjinjie@huawei.com>
References: <20240909133034.1296930-1-ruanjinjie@huawei.com>
	<20240909133034.1296930-5-ruanjinjie@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Jinjie,

ruanjinjie@huawei.com wrote on Mon, 9 Sep 2024 21:30:31 +0800:

> disable_irq() after request_irq() still has a time gap in which
> interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
> disable IRQ auto-enable when request IRQ.
>=20
> Fixes: 8c6ad9cc5157 ("ieee802154: Add NXP MCR20A IEEE 802.15.4 transceive=
r driver")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

This one could go through wpan(-next), but otherwise:

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

