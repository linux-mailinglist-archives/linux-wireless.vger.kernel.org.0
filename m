Return-Path: <linux-wireless+bounces-14514-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC919AFE86
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 11:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F2CC1C21185
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 09:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE66C1D5ADD;
	Fri, 25 Oct 2024 09:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="PPXLnBzl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6511C0DF0
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729849305; cv=none; b=qOXyxJ5bKhDKlVKFY3/uMuvot4eXDFn/pxle22DbyGXph0soiUT3gEq3aCPX4bpsCvuzf33Ec5eosjSdjUKpiB7HazR2YaXux3Uf9Ug4+Ig4s5CPmMfh58KFdJpCLDGg72Lti6CE+bi/fs0R6WcuZPqD9IvXeUTBhiIufpZMX8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729849305; c=relaxed/simple;
	bh=Iegcn8jFGSz7lOXTFQma/f/bbLJgNnfYOGd5eBEyTSo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uhaqS+fliwiGkrS7DNamWhCLrtudXpkTEwq7sbilwsFM9/GNdV55KeO/qWq2tTcI4NyYy5bkbyxMTQjZpIe1z7moN9UlmOXHuHrCUpRIsW+Tnt587tFY+ROtpqLnFBUbgvHgaAZYykG6ILSiHAY7F2D9y75tW31QoMeq42Y0Pfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=PPXLnBzl; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1729849298; bh=Iegcn8jFGSz7lOXTFQma/f/bbLJgNnfYOGd5eBEyTSo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PPXLnBzlTgwpsbS9tSvhurw+94V6fSSTRxRqaA4XvcObEDOGhYH5R0+i2yftBKVoW
	 GNmlcLdElFfujcOQ+Y1biZymQBfQTf/8yPNmHa99m2DH/qMWcH89XflEJwhkaJ/kEX
	 arA/+s1M2atGOg5dvRw2dGCw0uKiOo3xwg2CfHpc7NhD5X1cqH+Df+vpve8JxeEBso
	 Y0UReSPGrjwvLuRR202ASMFc1uuRcebhGaCWCRJA5l+7pjR7/CeasM3bXnsGips+H+
	 RNXtWgZdnLcljpkv7Azh62pmnrNZX9wabnpiT95Bjodo1/UUG8QC0NfWkIzjX3NzOz
	 BFddXNFcKKUGw==
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
 lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>,
 syzbot+93cbd5fbb85814306ba1@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] wifi: ath9k: fix out-of-bounds endpoint index in
 htc_issue_send()
In-Reply-To: <20241025054020.207044-1-dmantipov@yandex.ru>
References: <20241025054020.207044-1-dmantipov@yandex.ru>
Date: Fri, 25 Oct 2024 11:41:37 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <8734kkfrji.fsf@toke.dk>
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

Heh, so pwcli was complaining that the patch doesn't apply, which turns
out to be because of this fix for the same thing:

8619593634cb ("wifi: ath9k: add range check for conn_rsp_epid in htc_connect_service()")

So dropping this...

-Toke

