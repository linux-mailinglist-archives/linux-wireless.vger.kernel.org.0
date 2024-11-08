Return-Path: <linux-wireless+bounces-15147-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C499C2207
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 17:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297361F235EE
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 16:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8EB1917F4;
	Fri,  8 Nov 2024 16:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="CP8IuocG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794AA18B09;
	Fri,  8 Nov 2024 16:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731083190; cv=none; b=prsL2q/EzxHG2ptznzPrypnMSBF1N24wP0XIkm7dfXc40eBm5sOg+NzU9XQ7wuXX63fLPdUeVeCH3J17W2gX6xzo3Rru+QTjxGEBiweaDHMaqUiV9CXDjGxxuhDUZs+uM4rq5bLH/n0Uk5J+FM9ySPXxwtIuUUt4pL3donk/m+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731083190; c=relaxed/simple;
	bh=3mqsLDsEJoqwjI9HvUfDwlPxiJr4yDQLDVMDWRt1DVI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=LvrRUvfpG6mOZxrLjI23tcHaOrv4sDvum52BbhLeqrgFG+FXTe1c6+yjXGeO0a0uWufbFDY112vtYWcCNRwc4aJtNeDwvreUSE0/W5b3sevsc4jPU3SE9CWtUXyBFFsJqUQNhl2dYluF+Ipn4mzIjItzKQhTt+LZRHDqOdz93FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=CP8IuocG; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1731083160; x=1731687960; i=markus.elfring@web.de;
	bh=VUWzv8LrvIWA8ImsvyiR/6cd2EOKf5wJRkCX4vH4NoA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CP8IuocGGHD5URq/63LeC/3fmDzoljQJO5d0AqkwBfNyM7jiu8PaqBeCZ2SdMJSy
	 xZGjvMLCkdLO+M+fDP2mR21WMp1yQ8+NX4NO/N1ymAd2HfQLZmAthUMtrstcSQscE
	 rVTu2i/ZinZOVHp8rNuuUvkVbJfn2bYLh3Sucl5+C3oQpOQtAJdoAWYqvNV+vxkFh
	 Rgsa682UbDS9ykrjGSbSt5yiTcdLssDMLQzLitqgcWcMuopJLH95RoMXD6objVGNu
	 0PGHmy0yrN2TIAen0hwkEbOnOBH+uKYvGQstSN+Z+abVDr/hBtYUPdUc3JGQyYAx5
	 T2RKBN+bGWkhRhJnMg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MVaYi-1tHBbI0wMe-00Nvtn; Fri, 08
 Nov 2024 17:26:00 +0100
Message-ID: <5a707eb5-8695-4f0d-bb08-6de95017d2b1@web.de>
Date: Fri, 8 Nov 2024 17:25:56 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Michael Nemanov <michael.nemanov@ti.com>, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Kalle Valo <kvalo@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Sabeeh Khan <sabeeh-khan@ti.com>,
 Simon Horman <horms@kernel.org>
References: <20241107125209.1736277-6-michael.nemanov@ti.com>
Subject: Re: [PATCH v5 05/17] wifi: cc33xx: Add cmd.c, cmd.h
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241107125209.1736277-6-michael.nemanov@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kCejPMohxqmb4402vvVYhccZ9wh2wv6TVh1jzzZXVxjdncvL2ET
 53vZwdWPFjuyS0q8f0oDfTe+LtQUk00Mv+sqUdvH+EjtzuSiAAidCgVhZQ5tqnvBITkjtsP
 +aJcmAzFYk8n312MiU/eAxRfJaagHa23iqjTjt+zunmJCVgCyOuEf8p4l0yvBxSYNJz2VIx
 CZMCPWzsfQoLQ0ZUUoeHA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:S6CwSfd+LOc=;P9Wg40faTP/Ttw0CrWOuNvN+G3O
 rhLHdGT5u7OzXQelvdwgcrI1PUA/Huuyei/Nz4oNptn/AE8UpDeG8qc1D5klR+U+uU1SmuG0j
 0kB7lFau2y18CbZ+NAzYvGuYURA0ky1BTqwHsPBaogO38Hh2llhbLXblIjI8DXzYQHsHVWz1+
 X6xbZVam9+2BYZ+EXv3VWXHFhH7BaMJm/I+XY+5ostG8fyZneehcZIB+I3tQbv7Mg4h1ymrWf
 6aU11MSBDUKs+5KFsq7UjjxJeCfeE0fJokUdnBhb7VDJBYkmD9y1h32Y/GvnVL8xQkU8ncHBN
 zFFEzO+z2OsNiO3dhvCVCaaikVnlh/Yj8NG7rT1myAmOPB3fwvv12XsHKDZyfeP1LGP+T/XYK
 iQjMaKrKx77JwsC27eAqvp146wIOntJl/SXNnBym3DcOHI+OcTO0VDuN0vj1pH8crglboiJ4Q
 ktVissq+ZITbeVUKOlOXVf6tKLr4pC2BQnr3Vb59jJA7Rb0oBomZh1w15xzJ3w4OVIub+mFua
 f5i31UDV9e+Bsd3qduNJQ4urgFZIFKqkLK0BQTPbMaVDnbLpcwPlZIpW5pjLEGQu1KPUOhUpH
 mIEzozOM+SRGAG0gjatyi5a7JHz45jf9HRX2r2lLvvog2ixR7NcRqFchIMBqWE1WJbmBae9C7
 nVWKrf5ZiSt3Du7M4fRXzwYcQFgFxx3lJk0JQGMFaY7uZ+T0AqIXfV2r8fopmO8n4T+Wnw3qs
 xaz9/UARNiLOH8+5nPwej9l982t/lhQo7bTFWEi4rALqqvpcG8BVtCg8V8S9/ELpfdTgcOpmw
 QAYKupqVKXr3F01tC2Arh7ZatclUivECKKMqNQvui2P7zyJQ0ffTC2ly1XlLqCCL2CX90u+CT
 jjwKAyZNGisp3DWu5qXN3JxNHr8QxT51Mjgz1fPUcdkJrAvTFQKUKsNAQ

=E2=80=A6
> Similar to wlcore, all commands eventually reach
> __cc33xx_cmd_send which fills a generic command
> header and send the buffer via the IO abstraction layer.
=E2=80=A6

You may occasionally put more than 56 characters into text lines
for an improved change description.


=E2=80=A6
> +++ b/drivers/net/wireless/ti/cc33xx/cmd.c
> @@ -0,0 +1,1920 @@
=E2=80=A6
> +int cc33xx_set_link(struct cc33xx *cc, struct cc33xx_vif *wlvif, u8 lin=
k)
> +{
> +	unsigned long flags;
> +
> +	/* these bits are used by op_tx */
> +	spin_lock_irqsave(&cc->cc_lock, flags);
> +	__set_bit(link, cc->links_map);
> +	__set_bit(link, wlvif->links_map);
> +	spin_unlock_irqrestore(&cc->cc_lock, flags);
=E2=80=A6

Under which circumstances would you become interested to apply a macro cal=
l
like =E2=80=9Cscoped_guard(spinlock_irqsave, &cc->cc_lock)=E2=80=9D?
https://elixir.bootlin.com/linux/v6.12-rc6/source/include/linux/spinlock.h=
#L572

Regards,
Markus

