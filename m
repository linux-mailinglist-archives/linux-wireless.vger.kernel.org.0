Return-Path: <linux-wireless+bounces-14250-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2C49A5F86
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 10:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39D911C20A15
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 08:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824791E0E14;
	Mon, 21 Oct 2024 08:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgaWm0K6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD18200CD
	for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2024 08:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500923; cv=none; b=LR4yXdY/adxvA1DlIGdQUXmmvzASQWIVCI5/0K87ULVzVO/TpWGqrvRJfuraaf6nQQPeuhNCO5Lw1MFg3TL0sXaMVapDljG75tGnuqlxzLW2nMFK9jUSh8eMidPwHSwzh18FxB5XmOYBAh54EPxWawb7PkBlupRWcPlg0rSfr4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500923; c=relaxed/simple;
	bh=Hk5LV8UMqoIAyL3Ym7ewLlj6P2L1fKvGEabMZ/MREKA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=QrkRZ/QR/KHf5GW2zU9170Q76C8CDTAB+TeyJeczFpcef/YHQKZRCytlUiZPnTABD2oKeGDpf7/muHrOLtCN+xYj+3D8FAbcREwaCoXNZMcg/H/419ApT87a1Jq63u/YBjERXc82HtLJlEGteJLBjt/AUbvdCs6i/ylnFvXc4UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgaWm0K6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD0AC4CEC3;
	Mon, 21 Oct 2024 08:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729500922;
	bh=Hk5LV8UMqoIAyL3Ym7ewLlj6P2L1fKvGEabMZ/MREKA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=VgaWm0K6uPUATVBCCTC8W3GBjh9YgIrhJjpE9tWXnSMClI3LhAc5X2ztnO8zVQ6Ge
	 sBYaJDL1TOmlWol2/VPjWudmVaVyAjPLy/58yFChbMGFiutk9FJpoEuVJZoMsuYtrm
	 QIeY+SemQ5RGf7/+/L90eVB/B4WGbiRPsCSTkdn0sFoJbBTuGBf7tN+RUcuJx2Zq0G
	 0LNCkpe5k2PgTMntPr5mvnAljSC6Jsjiogl1cEYEl10t9LGt9BMy5KPoRS7cqkbWOx
	 fUnvJvikhWwWkma4eMH1daFtX191sbPG5hBbRkNB+TTA0ovyTBY1rCOd3kgK7oQWiA
	 5K1lh8YJYcOxA==
From: Kalle Valo <kvalo@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
  linux-wireless@vger.kernel.org,
  lvc-project@linuxtesting.org,
  syzbot+93cbd5fbb85814306ba1@syzkaller.appspotmail.com
Subject: Re: [PATCH] wifi: ath9k: fix out-of-bounds endpoint index in
 htc_issue_send()
References: <20241021084717.480413-1-dmantipov@yandex.ru>
Date: Mon, 21 Oct 2024 11:55:20 +0300
In-Reply-To: <20241021084717.480413-1-dmantipov@yandex.ru> (Dmitry Antipov's
	message of "Mon, 21 Oct 2024 11:47:17 +0300")
Message-ID: <87fropq1hj.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
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

A proper if statement would be more readable. There's no need to try to
minimise lines of code.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

