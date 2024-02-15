Return-Path: <linux-wireless+bounces-3642-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B36E1856AD7
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 18:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 390B1287A1C
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 17:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C7F136659;
	Thu, 15 Feb 2024 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoeA+b7R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5447F136672
	for <linux-wireless@vger.kernel.org>; Thu, 15 Feb 2024 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708017697; cv=none; b=pqoQnLsqggWh/v/W6xRHkG0bj5f+vs91BdmEXnXkBs0VAwKbTT0AB/As7r40AWzubyvUNTxY9FZHVz4YmucGlzJSiBeYK+bUbziZwi8HB/B5+FQsgjMDLnLHoAA0z/uFS8NPjaCf9XZejz2d4FvOK272ZBCS2KLYd/ATHaAyLkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708017697; c=relaxed/simple;
	bh=iPWzrKxTUVIBQ69gPTULbIaR34/o8Ohq/KvafguQmx4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=AK7XjPCa4/ucQ6/0REGLFm4Q6IRwd+rqzz0fTKD1AH4EfuK0IHFG4NsA2W4Ot4KuYp4spdrvMvptFItSRrnYpDzpRz1LVmUmUIgHd3ffhL/p/CrN8hgJlstzMn8CCX3lnNLvrHkABTny+Jp4NoNEwsTSXdrTBWXyg7S+0aH+hQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoeA+b7R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016B9C433F1;
	Thu, 15 Feb 2024 17:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708017696;
	bh=iPWzrKxTUVIBQ69gPTULbIaR34/o8Ohq/KvafguQmx4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=CoeA+b7Ryb9uL6vVVfXWaVdpJXIZebWBSUAalfqBC7MRbosvbnylt+hRwWiU8Unq7
	 EtEBUUMQfl8nvTRQJMxa7NU3LBoAolp/qces4F53HZ3gPrDuMfScB+RORh6BZpYPMO
	 wPqBawVDUtk1PkcJbz1rHfM44c+O0afmc05G6TsU50fIynDqi9UmcbJC4P2+rescb9
	 4PMbLfpTzPzgsaDnDFr2KuJTNsh7y3UldEduch6RFIi0p83g8Jkky9iOtYEtKgL79W
	 gJ/GjHJMXiF+Z1266H8Yv4frhsvsEJuaTYCs1Y9eYRmO3qCi8k2steEZHwgCDMfS7m
	 RxgH4Hr1SaK7A==
From: Kalle Valo <kvalo@kernel.org>
To: Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,  Ajay Singh
 <ajay.kathat@microchip.com>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  linux-wireless@vger.kernel.org,  Igor
 Mitsyanko <imitsyanko@quantenna.com>,  Sergey Matyukevich
 <geomatsi@gmail.com>,  kernel test robot <lkp@intel.com>,  Claudiu Beznea
 <claudiu.beznea@tuxon.dev>,  srini.raju@purelifi.com
Subject: Re: wireless: orphan qfnfmac and plfxlc drivers?
References: <20240215-nl80211_fix_akm_suites_endianness-v1-0-57e902632f9d@bootlin.com>
	<02c155ff-f880-4e88-b600-9d632019729f@bootlin.com>
	<875xypejwt.fsf_-_@kernel.org>
Date: Thu, 15 Feb 2024 19:21:32 +0200
In-Reply-To: <875xypejwt.fsf_-_@kernel.org> (Kalle Valo's message of "Thu, 15
	Feb 2024 19:06:58 +0200")
Message-ID: <871q9dej8j.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kalle Valo <kvalo@kernel.org> writes:

> (changing subject)
>
> Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com> writes:
>
>> Also, my mail provider returns error 550 (No Such User Here) for quanten=
na
>> driver maintainer (<imitsyanko@quantenna.com>, taken from MAINTAINERS). =
I've
>> seen no recent activity from him on the ML, is he still around ?
>
> I found a bounce for imitsyanko@quantenna.com from 2022 so I guess it's
> time to orphan qtnfmac?
>
> Also the purelife maintainer Srini Raju (CCed) is bouncing, that's
> another candidate to orphan.

And confirmed, I just got bounces for both of these maintainers. Patches
welcome to orphan these drivers.

<srini.raju@purelifi.com>: host
    purelifi-com.mail.protection.outlook.com[52.101.68.16] said: 550 5.4.1
    Recipient address rejected: Access denied.
    [DB5PEPF00014B8D.eurprd02.prod.outlook.com 2024-02-15T17:07:03.735Z
    08DC2C530F4F7910] (in reply to RCPT TO command)

<imitsyanko@quantenna.com>: host mail.quantenna.com[50.87.249.29] said: 550=
 No
    Such User Here (in reply to RCPT TO command)

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

