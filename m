Return-Path: <linux-wireless+bounces-21824-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA28A95D23
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 06:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C53B3B7A89
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 04:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B192914830C;
	Tue, 22 Apr 2025 04:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="V+9bxjNY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98603190472
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 04:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745297765; cv=none; b=kIMYL+qKEpmSjzcEPoFzX2t87A4WjGTAZH3PGtxgqLbt/3WZYW+frUOVZqBzibzJzeMeeAcPHZIjq3FLtL26gf7xTzY1F/nl+pNjXrhPbiUQrkxqTPStK2eYlA85wxjrb0ezHh96Va5BHBSvDGLV4H8p4oI59O/oLXhg5v3O3p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745297765; c=relaxed/simple;
	bh=1n6VFvcqcUzVl1/IbVIv/Pa/793Z9OAZn+Q6I6OUYBk=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=VzGWVw/zZmG7qAXt8Sr6jLnvDmKLfQRTqHgqfpC5+9cc6KFJOqot2OsCnvuGAEVU1A3JnlagsOKM7aZ9vet5zQ7NESWD7uoZ8K+Y5p1AJhCO/EN46Mapav+RcQDgA7Oy2s1TALJiqghSXhe0MHHxg69SmyHeq9JnDAZZTuDHneU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=V+9bxjNY; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5f5bef591d6so8002113a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 21:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745297762; x=1745902562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wrp+glrqMEFQIOcbV8OH0y2t9hGyNvM/0gI9W80il2Q=;
        b=V+9bxjNYLaI+t9XZNnmBD5QZcHBo+JB9RlsajG5N+hvGKM+6zvULXg/VfhKPIlkcnx
         jIrm/sBnN4HU46kQfm5RPrqI3o8K7FkF/jigrI6UiaT+DG02zbBpQxBeVGm3+FnjGkPx
         L1go9+9Tj6gLPuU6SianNac05Jx11dbcnq7Qk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745297762; x=1745902562;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wrp+glrqMEFQIOcbV8OH0y2t9hGyNvM/0gI9W80il2Q=;
        b=Q+oiCVN1JS1FZmp80F08xqq++vsV0eTW81PoQ3mkh9VEwmm+VasxDQxnszjQZfsPya
         nABTuWqgDANDaTljQ/B2b+Bvl2eAhGaXO33v9iH/fHyoDyoIcsM8f/AHfLW+mvW6suiW
         WJEeW7K97twC161yGCFNup58Su0/3MGJfJJM8e7maQktPVJFohutooZbc4nqZgzpvQdj
         AoFL5TnNITcs/xPg6fS5ihvdhmHvx0lWq+jvWtq3XQmM7XlJmXBGWT7PG+Njdun1lgTX
         qu36E0mw70/7/vKiHseHucmZOxoVKpof3xGn8KHxl6S6w6fFTwVWmz5sz1jP7eJvRJlR
         bRAw==
X-Forwarded-Encrypted: i=1; AJvYcCVedaxedR7ABNSRK14Hp8hH3l77D/2E8VxdHubR0GEZvN5yRk1rfqDi8tbgBiI3Rb83KhkacmTBToFJQQ3uLg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtx1CitGl+VAlveErqpVIU7chhA+OdnQAAYuL1NuRoGudc0olG
	0z66TdvKeeDyxDN9YuDX+aNdkK7ac9mbE8pu4McdsLRLyop+4ZXJkYFoqLLdyQ==
X-Gm-Gg: ASbGncu9/sGvni220MvnmQmF0tPZ645bsitCgtI/HDTSA7cjPag7U3zoMksrh63cuwA
	O0kaH0SzRsuzALGlv+iktWIqX7qUjZ+91T8ZX2irqZ7UCVt7uNjzxvOaEmkPk5qZbdkzC5+yEGD
	u0DUfGkmXM2qxdTOYCeBiNi5jhfZT1XoBKMEc5h0zJp6AKWMtEmFUo+2wOEgYWAkv8CLCa1GWBP
	1xkaTlfJE8CHB7QkIJk1JTGSgPwDC7s48zgaLUvmgKAOX6pkApzRegMVI/e4sBwFDjVSkTXs+5a
	j6gBcKsz2g8Ju0Ycxc5oTAZ0vVca9D1cbIgDj2MZn0b6AdkfLzR3n3tKmbCjWbpYWpRzhnF7Jr3
	oUhM=
X-Google-Smtp-Source: AGHT+IHSU6S5KXFU9LqzhGRG+vKu9XggFzpPIOcZPwBxuMXIbI8vYSXr2SAHZ4O5/Fg7JR4/K6GtBQ==
X-Received: by 2002:a05:6402:13cd:b0:5e7:2871:c137 with SMTP id 4fb4d7f45d1cf-5f628548a18mr12182351a12.14.1745297761855;
        Mon, 21 Apr 2025 21:56:01 -0700 (PDT)
Received: from [192.168.178.39] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f6258340c8sm5392034a12.58.2025.04.21.21.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Apr 2025 21:56:01 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Wentao Liang <vulab@iscas.ac.cn>, <kvalo@kernel.org>
CC: <jacobe.zang@wesion.com>, <sebastian.reichel@collabora.com>, <christophe.jaillet@wanadoo.fr>, <erick.archer@outlook.com>, <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Date: Tue, 22 Apr 2025 06:55:59 +0200
Message-ID: <1965bda5b18.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20250422042203.2259-1-vulab@iscas.ac.cn>
References: <20250422042203.2259-1-vulab@iscas.ac.cn>
User-Agent: AquaMail/1.54.1 (build: 105401536)
Subject: Re: [PATCH v2 RESEND] brcm80211: fmac: Add error handling for brcmf_usb_dl_writeimage()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On April 22, 2025 6:22:48 AM Wentao Liang <vulab@iscas.ac.cn> wrote:

> The function brcmf_usb_dl_writeimage() calls the function
> brcmf_usb_dl_cmd() but dose not check its return value. The
> 'state.state' and the 'state.bytes' are uninitialized if the
> function brcmf_usb_dl_cmd() fails. It is dangerous to use
> uninitialized variables in the conditions.
>
> Add error handling for brcmf_usb_dl_cmd() to jump to error
> handling path if the brcmf_usb_dl_cmd() fails and the
> 'state.state' and the 'state.bytes' are uninitialized.
>
> Improve the error message to report more detailed error
> information.
>
> Fixes: 71bb244ba2fd ("brcm80211: fmac: add USB support for bcm43235/6/8 
> chipsets")
> Cc: stable@vger.kernel.org # v3.4+

Thanks for this patch.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c 
> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
> index 2821c27f317e..d06c724f63d9 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
> @@ -896,14 +896,16 @@ brcmf_usb_dl_writeimage(struct brcmf_usbdev_info 
> *devinfo, u8 *fw, int fwlen)
>  }
>
>  /* 1) Prepare USB boot loader for runtime image */
> - brcmf_usb_dl_cmd(devinfo, DL_START, &state, sizeof(state));
> + err = brcmf_usb_dl_cmd(devinfo, DL_START, &state, sizeof(state));
> + if (err)
> + goto fail;
>
>  rdlstate = le32_to_cpu(state.state);
>  rdlbytes = le32_to_cpu(state.bytes);
>
>  /* 2) Check we are in the Waiting state */
>  if (rdlstate != DL_WAITING) {
> - brcmf_err("Failed to DL_START\n");
> + brcmf_err("Invalid DL state: %u\n", rdlstate);
>  err = -EINVAL;
>  goto fail;
>  }
> --
> 2.42.0.windows.2




