Return-Path: <linux-wireless+bounces-830-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 374948146F2
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Dec 2023 12:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67C6F1C22C14
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Dec 2023 11:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413EB24B3F;
	Fri, 15 Dec 2023 11:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="Fk5V3eB4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E212510D
	for <linux-wireless@vger.kernel.org>; Fri, 15 Dec 2023 11:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1702639447; bh=f+bNiLJMwMo6AviIXbDSyDjyccy0dWXy8LsYbdkBFZs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Fk5V3eB4fgGAtjLetxFHIMhAtl/sWtRbw39UH0+Nn9YvO+wcilQSx/WHMkS9zLrIE
	 dqKUDfbxlNgB0zQL2MSOFvcjduRLcLSgKfUIk/NTOjvgU0WGKtPO8nKsigN+B9x/Vk
	 W5YtmU80hUxSF6bZsG44w7I6/BRPaoSaCRo/IdtjQIdPIu+wKRlpT2ASKnnYChv7CO
	 xoZODNAJ/gVMtNUAADAgITRUEHeHk6B3I9x/7H7V2Wx1BpE5RipapZrDycsIvQrQay
	 yxXqzjknafqzDRbBVPGwu+LQEjQJmD5d8JjkFRBWAw6fu51RtyGaVRE9NHLjtntMdi
	 4tT1klOGZ8GDw==
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Kalle Valo
 <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH wifi-next 3/6] wifi: ath9k: Convert to platform remove
 callback returning void
In-Reply-To: <20231117093056.873834-11-u.kleine-koenig@pengutronix.de>
References: <20231117093056.873834-8-u.kleine-koenig@pengutronix.de>
 <20231117093056.873834-11-u.kleine-koenig@pengutronix.de>
Date: Fri, 15 Dec 2023 12:24:07 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87cyv7zp2g.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:

> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

