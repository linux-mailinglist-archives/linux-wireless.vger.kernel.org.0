Return-Path: <linux-wireless+bounces-2449-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1FC83ACD2
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 16:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31FF1F2578E
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 15:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1216B18624;
	Wed, 24 Jan 2024 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="A2b7W/L4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C905C17562
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jan 2024 15:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706109085; cv=none; b=Gy42n3xOjvqIj8KGn6+wYaz5IHMS7q3XwYJhB0C800VmVsuhQXeZCN8zcOFI2KmIkUUw5X7gTkBB6Mb/LL9SI8PSu9Gwi0urPasMmxAU1iVRQD/CJzdfuNr2uiZT4OHpQN/LkkZg0pg520pkNkyeU/P47KFkwH49p4KTiZXapzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706109085; c=relaxed/simple;
	bh=XP6xQw4+tePna0EBHak2OWe/T9cZUUVZYp2GXY+LuHE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=qUvzAdbF3XPEkNiZ3OECKXHvmy5G4PhWilYSj2iLqcbFo4x3VFFTudu+WQ2cbGXbUq2281H+e0yAYkSLjqlfNeS3zxlwuFiFaKnUihRWvupFWSKbz4nlGHVf0JeMee+PPLgDfPLBhv/cZ4Y4VZxfhXThNBfuzY6wq7TOvNEv5Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=A2b7W/L4; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-37.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-37.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:2c09:0:640:19b6:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTP id 91A6461463;
	Wed, 24 Jan 2024 18:11:18 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-37.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id GBVgF1DXqiE0-NQvX1yT6;
	Wed, 24 Jan 2024 18:11:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1706109077; bh=GkUFGPpI0LfVAKqKCmj+3qzto/Qsd4NBU/+i4Nzpi54=;
	h=In-Reply-To:To:Cc:References:From:Subject:Date:Message-ID;
	b=A2b7W/L4N5yXfA8xUPkGZKOiuuBrkpHA5HoCFo7blq9avIUzlWf2yTmMXafeM0L/m
	 BSDD9LcPcHsdNPhtEo1NmuRvwelcJTOrRfyV8Zc0iubecLTu7UV2FebcvPWh3MKde8
	 NLGrhG93IVI6qvIhTFm7Que4m3MVko3vu4bTzr6g=
Authentication-Results: mail-nwsmtp-smtp-production-main-37.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <6499241c-8508-45de-816b-f36c1a202801@yandex.ru>
Date: Wed, 24 Jan 2024 18:11:16 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Felix Fietkau <nbd@nbd.name>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org,
 syzbot+fdc5123366fb9c3fdc6d@syzkaller.appspotmail.com
References: <20240117124848.120438-1-dmantipov@yandex.ru>
 <9433d29b643e4cce3a9354282405288c75c45e02.camel@sipsolutions.net>
 <b938cafa-0cb0-4832-9883-c6c47e93fa2b@yandex.ru>
 <58970b94a314414402a932576ec54188c0675016.camel@sipsolutions.net>
From: Dmitry Antipov <dmantipov@yandex.ru>
Autocrypt: addr=dmantipov@yandex.ru; keydata=
 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
 tx98MCutXbJWn55RtnVKbpIiMfBrcB8=
Subject: Re: [PATCH] wifi: mac80211: don't ask rate control with zero rate
 mask if scanning
In-Reply-To: <58970b94a314414402a932576ec54188c0675016.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/19/24 20:19, Johannes Berg wrote:

> I was trying to let you come up with a patch for learning, but I think
> at this point just making one illustrates better what I'm thinking ...
> Here's one, but I haven't even compiled this:

Hmm... this:

> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -701,7 +701,9 @@ ieee80211_tx_h_rate_ctrl(struct ieee80211_tx_data *tx)
>   	txrc.bss_conf = &tx->sdata->vif.bss_conf;
>   	txrc.skb = tx->skb;
>   	txrc.reported_rate.idx = -1;
> -	txrc.rate_idx_mask = tx->sdata->rc_rateidx_mask[info->band];
> +
> +	if (!(info->control.flags & IEEE80211_TX_CTRL_SCAN_TX))
> +		txrc.rate_idx_mask = tx->sdata->rc_rateidx_mask[info->band];
>   
>   	if (tx->sdata->rc_has_mcs_mask[info->band])
>   		txrc.rate_idx_mcs_mask =

leaves 'rate_idx_mask' unset (i.e. zero) even for band 0 and then
causes the same WARN_ONCE() even earlier (before switching to band 1).

Dmitry

