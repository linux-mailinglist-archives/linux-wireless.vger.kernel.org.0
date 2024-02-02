Return-Path: <linux-wireless+bounces-3038-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 911E9847193
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 15:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4613F1F21EF7
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 14:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38325A4C2;
	Fri,  2 Feb 2024 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="evnFKao2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC534779F;
	Fri,  2 Feb 2024 14:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706882474; cv=none; b=eNlZoVnd25O3Q8EMMw/Iv3XM55MoVntRmLkdFShWy8NRB4k0c9O6d+LZxT/iJPrL4x8pY33T5lDLQVlU9jcCpn9wFzVGTF+CeOkP2317HxFfqz3yGSrsGS8klPxj/dE3U4DGOGTIp8H7G7jO5I0Mza2wr6xO22+i++KNtzsz0X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706882474; c=relaxed/simple;
	bh=bvDyNvz2s0h+nDqlbIStn6rc2ShdMKOoooqucNitdbU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=Ui8K/PDoNPgnfsMKqhGpX9T9WnJTlcl6bRQj1buffHbmbcuFjkK+VBtGxXMvPUGik76tNER42L+ca9g6UhDr6ROY33/V3ps8KL8SB/49NZ/U2ueIf7tZDW7DkikDh14QheUXgAztbHzvCY+t7/42XkIaNGpj7jyisx1T6wznOYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=evnFKao2; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-81.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-81.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:3999:0:640:6a33:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTPS id 3CF9C612F7;
	Fri,  2 Feb 2024 16:54:55 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id rscZfT1oEGk0-FrtjmypN;
	Fri, 02 Feb 2024 16:54:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1706882094; bh=QFGBZH/4o4H53aADR1pw50OUEL41cVuygGabeLFQQ8A=;
	h=In-Reply-To:Subject:To:From:Cc:Date:References:Message-ID;
	b=evnFKao2ByB7VV9CUmG3TXlgSzUzuS6a6cJJmpN10Gw1AtOrMzuEtx4ZIV5BwKLQg
	 FZfBWO6qnfqDLw9BNrvjl6kTjwheEM904Fz+QnitVdTc+HwIV5CCVVUgQcPjXR6Ibq
	 F0zreWDz+qr07l+Df9FgK7D6zdSWdG9HpoYNPL0k=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <75c29fb8-587e-4b8d-98cc-80c8bdea99a0@yandex.ru>
Date: Fri, 2 Feb 2024 16:54:53 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Fiona Klute <fiona.klute@gmx.de>
Cc: Kalle Valo <kvalo@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-mmc@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
 =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>,
 linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>
References: <20240202121050.977223-1-fiona.klute@gmx.de>
 <0a5c896a-6dab-4979-a6a3-344dc71bca98@yandex.ru>
 <b8c1a26e-13d9-405a-bbd5-70a7daf75323@gmx.de>
Content-Language: en-US
From: Dmitry Antipov <dmantipov@yandex.ru>
Autocrypt: addr=dmantipov@yandex.ru; keydata=
 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
 tx98MCutXbJWn55RtnVKbpIiMfBrcB8=
Subject: Re: [PATCH 0/9] rtw88: Add support for RTL8723CS/RTL8703B
In-Reply-To: <b8c1a26e-13d9-405a-bbd5-70a7daf75323@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/2/24 16:27, Fiona Klute wrote:

> That definition should have been added to main.h by patch 3 ("wifi:
> rtw88: Add definitions for 8703b chip"). Was there some issue with
> applying that one?

Ugh, indeed :-(. Should say sorry for this.

The only minor issue actually is:

drivers/net/wireless/realtek/rtw88/rtw8723x.c:314:6: warning: no previous
prototype for function '__rtw8723x_cfg_ldo25' [-Wmissing-prototypes]
   314 | void __rtw8723x_cfg_ldo25(struct rtw_dev *rtwdev, bool enable)
       |      ^
drivers/net/wireless/realtek/rtw88/rtw8723x.c:314:1: note: declare 'static'
if the function is not intended to be used outside of this translation unit
   314 | void __rtw8723x_cfg_ldo25(struct rtw_dev *rtwdev, bool enable)
       | ^
       | static

Dmitry

