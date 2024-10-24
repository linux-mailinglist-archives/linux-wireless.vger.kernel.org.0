Return-Path: <linux-wireless+bounces-14469-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4AD9AE70E
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 15:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554271F2346E
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 13:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9AF18A957;
	Thu, 24 Oct 2024 13:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="ano/lZ05"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7C81714B0
	for <linux-wireless@vger.kernel.org>; Thu, 24 Oct 2024 13:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729778281; cv=none; b=jbCU8xnUx6Ehnk2+L/jVIRcFVz78WvYlp/4q2eghsjmN2+voYRp8v2qa45Yaacr3jQD2fsxaLpMQ190U9sKx3U07T3v9oe72+vZOcaEmfN5w7v2WQA8in2hfRxanaX7jhmzWirWeHXNmc8DhYvAC6XvktAvTccBXLeEj03oovSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729778281; c=relaxed/simple;
	bh=smAf6KfKzcU/NiXsXCBmYnbFS0qImzo1H4wxunnDzxY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R5m5CNitjaK9r00PddTMDyb9VcEytXAL3u+5jGyc+HJVDeQ3lEEKROSCnzDMqZgl93NXBxexmf0mrBl/4DtXYBaCe5yfPfRkX3UVNxCVTIoPKpcJu2ESqObpE9QOoRMMPApX1ETOIPBIlX8/8ldfCGHdyQ3ujplAztptGbw3My0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=ano/lZ05; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1729777730; bh=smAf6KfKzcU/NiXsXCBmYnbFS0qImzo1H4wxunnDzxY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ano/lZ05ZWPSOa/eDydk+nZnQvVL3ngr2/ioqoVYg2m46M5G554fvbb/kQOzr8IVB
	 jWxsUPBgbGxOJTeGGVBG+pEiJBR8ORnuHUswe0wBSnquNZfAzDaUkeWD/B3upiZF+R
	 z5f8aOkWeU/B/4mTwFG8rNPw3TkvQbzgl+uDFrfQFPuVX+vxJC9mBVEMqYJvdvSE8P
	 DTpoYLv0pSl8Oeb7Rh+ODj1sTQG00u26HT6OFmwD6wzKBPZ7uhJuDYE+60ImmPUKF1
	 Akl/WTDIV8Az7BIy/H25bU2HgtQQ2+/PiWdRLFfumb4V1pjBqbSS9ZmdjzXwcTOXKd
	 yCNcDw62EtYrw==
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
 lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>,
 syzbot+93cbd5fbb85814306ba1@syzkaller.appspotmail.com
Subject: Re: [PATCH] wifi: ath9k: fix out-of-bounds endpoint index in
 htc_issue_send()
In-Reply-To: <20241021084717.480413-1-dmantipov@yandex.ru>
References: <20241021084717.480413-1-dmantipov@yandex.ru>
Date: Thu, 24 Oct 2024 15:48:49 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87h691fw72.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dmitry Antipov <dmantipov@yandex.ru> writes:

> Syzbot has reported the following UBSAN splat:
>
> UBSAN: array-index-out-of-bounds in drivers/net/wireless/ath/ath9k/htc_hst.c:26:35
> index 255 is out of range for type 'struct htc_endpoint[22]'
> ...
> Call Trace:
>  ...
>  __ubsan_handle_out_of_bounds+0x115/0x140
>  htc_send_epid+0x1e0/0x2d0
>  ath9k_wmi_cmd+0x31f/0x590
>  ath9k_regread+0xdc/0x140
>  ? __pfx_ath9k_regread+0x10/0x10
>  ? _raw_spin_unlock_irqrestore+0xae/0x110
>  ? __pfx__raw_spin_unlock_irqrestore+0x10/0x10
>  ? __pfx_ath9k_regread+0x10/0x10
>  ath9k_hw_init+0x4b0/0x2230
>  ? init_timer_key+0x171/0x2d0
>  ath9k_htc_probe_device+0xa66/0x1fe0
>  ? __pfx_ath9k_htc_probe_device+0x10/0x10
>  ? usb_hcd_submit_urb+0x345/0x1ae0
>  ? usb_free_urb+0x9d/0x120
>  ? ath9k_hif_usb_alloc_urbs+0x1077/0x1150
>  ath9k_htc_hw_init+0x32/0x70
>  ath9k_hif_usb_firmware_cb+0x240/0x4c0
>  ? __pfx_ath9k_hif_usb_firmware_cb+0x10/0x10
>  request_firmware_work_func+0x106/0x1c0
>  ...
>
> IIUC https://syzkaller.appspot.com/text?tag=ReproC&x=1734b9f1180000 makes
> an attempt to emulate ath9k USB device in somewhat weird and obscure way
> so I'm not sure whether this may happen on a real hardware. OTOH whether
> ending with ENDPOINT_UNUSED in 'htc_connect_service()' may indicate the
> malfunctioned real device, it may be better to reject such a device with
> -ENODEV.
>
> Reported-by: syzbot+93cbd5fbb85814306ba1@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=93cbd5fbb85814306ba1
> Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  drivers/net/wireless/ath/ath9k/htc_hst.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/ath9k/htc_hst.c b/drivers/net/wireless/ath/ath9k/htc_hst.c
> index eb631fd3336d..4288ef5b8df5 100644
> --- a/drivers/net/wireless/ath/ath9k/htc_hst.c
> +++ b/drivers/net/wireless/ath/ath9k/htc_hst.c
> @@ -295,7 +295,7 @@ int htc_connect_service(struct htc_target *target,
>  	}
>  
>  	*conn_rsp_epid = target->conn_rsp_epid;
> -	return 0;
> +	return target->conn_rsp_epid == ENDPOINT_UNUSED ? -ENODEV : 0;

I'll echo Kalle's preference for a proper if statement. But it should
really be an early return above the line that sets *conn_rsp_epid (we
shouldn't touch that on error).

-Toke

