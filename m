Return-Path: <linux-wireless+bounces-10678-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1641940EB3
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 12:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BC73281312
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 10:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8E319B584;
	Tue, 30 Jul 2024 10:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="RC8FX0yb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F42199389
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jul 2024 10:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722334282; cv=none; b=Gk0+/PPrWGINpD3NPx1MQDqB8uCIx8oldS5yoOuoFRNzvAJvwmJKC4is84RLWdnQrN4nxHWbbYsLYnsFaRjWYxq4bpHjy+Sw6dU8dz4+M11MpuGaBgbW3UL6QuJ/8qvmdoqAl1MPIFf8/p/oOyUs1A6YOZ+IMGX9QvdDepzErig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722334282; c=relaxed/simple;
	bh=UJHvFoZuV7yb//V06Tzf5mOyi1JkCSVmC4SgbG1vlXI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ifzuTQQEJR9PS//sbc91tKI4H2hcwOhwjobXCj2KSQRkwgESFC3DHDSzBX2uHV1dGV0t+Auq4YbblbTgNE4Td/HsKxubtwE3NLD3w7CnXA/InL6YoaeejFx0gTgG7NiLaQ44l8YXB1MY+s1Kka6lVXN3aMCDJtB2GVbnK7Qv89Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=RC8FX0yb; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1722334278; bh=UJHvFoZuV7yb//V06Tzf5mOyi1JkCSVmC4SgbG1vlXI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RC8FX0ybnXzz4prGCIMxiY0xqr2y/jfMY+EwFBAH2VHGClR9x0oqR9H8jWBTtK038
	 xo6M6VZjNpNu161W4CU8PkQEQawjN7DvZhvYDtQW72Y5J6uH9LaC62aYnYT0kkEiee
	 mjzbV26RQp/hZuX4RMUID+/HiGoRYc83SJ6cCAMNzkPLy0uvc0ix+gnD4+hqTkiYPQ
	 m6zU9bYegorhHUa5A6r7/O5TX/vvphd/jhp7LCZNduSBkzJ04CAJweyyv3TjB8rNcv
	 e2e2U76JPJpMQze0lvSGvRgKGzXWh0MkodBaow8Tv3bRaDkoCPpBUwC+YSLy1sBYQo
	 xiE/bjOcFz3Mw==
To: Chien Wong <m@xv97.com>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: ath9k_htc: limit MTU
In-Reply-To: <20240405145211.15185-1-m@xv97.com>
References: <20240405145211.15185-1-m@xv97.com>
Date: Tue, 30 Jul 2024 12:10:45 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <8734nrp4uy.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chien Wong <m@xv97.com> writes:

> Currently, the length of USB messages sent from host to Wi-Fi dongle is
> not checked. Without the check, we could crash the firmware.
>
> The length limits are determined by _HIFusb_get_max_msg_len_patch()
> in the firmware code, located in k2_HIF_usb_patch.c and HIF_usb_patch.c
> of the open-ath9k-htc-firmware project. The limits are 512 and 1600
> bytes for regout and Wi-Fi TX messages respectively.
> I'm not sure if the firmware crash is due to buffer overflow if RXing
> too long USB messages but the length limit is clear and verified.
> Somebody knowing hardware internals could help.
>
> We should try our best not to crash the firmware. Setting the MTU limit
> will help prevent some too long packets from being generated. However,
> doing this alone is not enough: monitor interfaces will ignore the
> limit so other measure should also be taken.
>
> It's not easy to choose an optimal limit. The numbers that come to mind
> include (1)1500, (2)1600 - sizeof overhead of shortest possible frame
> and so on. For (1), it's too limiting: the device supports longer
> frames. For (2), it won't filter frames with longer overhead.
> Why bother considering higher layer protocols? We could just consider
> the driver layer overhead.
>
> How to reproduce a crash:
> 1. Insert a supported Wi-Fi card
> 2. Associate to an AP
> 3. Increase MTU of interface: # ip link set wlan0 mtu 2000
> 4. Generate some big packets: $ ping <gateway> -s 1600
> 5. The firmware should crash. If not, repeat step 4.
>
> Tested-on: TP-LINK TL-WN722N v1(AR9271)
> Tested-on: TP-LINK TL-WN821N v3(AR7010+AR9287).
>
> Signed-off-by: Chien Wong <m@xv97.com>

(Sorry for not getting around to looking at this earlier)

> ---
>  drivers/net/wireless/ath/ath9k/hif_usb.h      | 3 +++
>  drivers/net/wireless/ath/ath9k/htc_drv_init.c | 3 +++
>  2 files changed, 6 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.h b/drivers/net/wireless/ath/ath9k/hif_usb.h
> index b3e66b0485a5..f8fd78309829 100644
> --- a/drivers/net/wireless/ath/ath9k/hif_usb.h
> +++ b/drivers/net/wireless/ath/ath9k/hif_usb.h
> @@ -50,6 +50,9 @@ extern int htc_use_dev_fw;
>  #define ATH_USB_RX_STREAM_MODE_TAG 0x4e00
>  #define ATH_USB_TX_STREAM_MODE_TAG 0x697e
>  
> +#define MAX_USB_REG_OUT_PIPE_MSG_SIZE 512
> +#define MAX_USB_WLAN_TX_PIPE_MSG_SIZE 1600

Maybe add a comment above, like:

/* Values larger than these can crash the firmware */

>  /* FIXME: Verify these numbers (with Windows) */
>  #define MAX_TX_URB_NUM  8
>  #define MAX_TX_BUF_NUM  256
> diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_init.c b/drivers/net/wireless/ath/ath9k/htc_drv_init.c
> index 3633f9eb2c55..3fad9cd4b1e6 100644
> --- a/drivers/net/wireless/ath/ath9k/htc_drv_init.c
> +++ b/drivers/net/wireless/ath/ath9k/htc_drv_init.c
> @@ -760,6 +760,9 @@ static void ath9k_set_hw_capab(struct ath9k_htc_priv *priv,
>  	hw->extra_tx_headroom = sizeof(struct tx_frame_hdr) +
>  		sizeof(struct htc_frame_hdr) + 4;
>  
> +	hw->max_mtu = MAX_USB_WLAN_TX_PIPE_MSG_SIZE - sizeof(struct tx_frame_hdr)
> +		- sizeof(struct htc_frame_hdr);

Shouldn't this be the same as the extra_tx_headroom set above? Not sure
what the +4 is for in that assignment, but it seems a bit odd to not be
consistent. Did you verify that an MTU of 1580 works without crashing?

Maybe this should just be:

	hw->max_mtu = MAX_USB_WLAN_TX_PIPE_MSG_SIZE - hw->extra_tx_headroom;

just to be sure?

-Toke

