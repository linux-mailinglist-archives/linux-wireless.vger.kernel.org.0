Return-Path: <linux-wireless+bounces-21750-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BDBA941FB
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Apr 2025 08:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 399277A9862
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Apr 2025 06:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E85192D96;
	Sat, 19 Apr 2025 06:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QLEo5SIX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42B4145B16
	for <linux-wireless@vger.kernel.org>; Sat, 19 Apr 2025 06:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745045191; cv=none; b=QtePn5puv/UGeQyGnXrYTdIDemlolRCQMYfBchs6I9OjpoP3eDkzqu5N4H9Z4Z1xLc/xwEKVf/vzgm8kG9F+UeUg4MABiD4OfceM9rw7ggNJWIuCzBUxsfNYLAF90+pzlIx0VZA8WX+LmszXpQNaFpxVCqO5AkUY3wDVsqF5/Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745045191; c=relaxed/simple;
	bh=iDl5B1v5FJYHXZlOgXY0HpWkdqy9oyaPAFwJEp09aoY=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=lXyOGdN2c2490uHXtBL2i8tPGGoXijQfqbX5MnsWC1sHPZfJ23kZ7N3jqBYl9bk6v3UFeBMTw8PiKkLGAVHHCosrY43tOveraVCdTk82Oq9DLsM39wsV4Iy6keHpNnyegGezCRpsyrU1q7OV2p+Esw6mKU74EW1jBtCs1aJhCyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QLEo5SIX; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-72ecc30903cso1391348a34.0
        for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 23:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745045188; x=1745649988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AgGfe7pfQEKHXwAsiL/+C2u2L63eEHqUtK4c7n9+Ets=;
        b=QLEo5SIXilCoCEovGqSowkRjVYFT17/zNnr+HXZx+YsaTcXUqxWg7ZiAc3hICTJ6dJ
         3XHSf1+kK9YJUjUpuF7gy7BDQ+SGyZKcDoogpJODgQqUFuFskjsW0SyW8p6tfylrKJc1
         0oRPGacydthekoRnAmnzZ017bk6Z7nv7uQ0j4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745045188; x=1745649988;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AgGfe7pfQEKHXwAsiL/+C2u2L63eEHqUtK4c7n9+Ets=;
        b=frPhCyFJ4gtcBqeyxlQMBKb7nW/0ua6CDwjeB9OLo/HCH0YigDE6/sHW1Mob1d74iV
         SmqYVCUzGn9v7fQfeonBB/J9IPgyWRP8XchxfshszXIOyji+D7J5+K7QLEbHsom4XuqB
         4b3i93LQQd7wOn6eKK+Ap5nCeLL4cfRqocXYBv7yr4VAuhbelFPh+IZXB7PzohnN/J0g
         rvc4UHPZOACFAzq8l43PPCypC1a0+6THrWNtktTyPf1fEOOk5j1Ovp6nyMJo0a7m4IXT
         LfiGnLy6GQDml56WqVLc3h87o9P229H5wE5jPwOKh2vVSjH8ta76wrJ1ekjxij/V1Nst
         aWnQ==
X-Gm-Message-State: AOJu0YzREk6VFlLo2ZMtPGkeBcSkanhNV8eGkdwK5kSQPbTm2OJCG5BQ
	VdEcZtr1dHXuH3WH71jXJV9w03abpTHdkVdX0RBq6bPiBi+BqRSD72x9wUWa9w==
X-Gm-Gg: ASbGncucov+4Z+bGmRM91aV5uUyjvCjbSEWmF0oXVj2QSA+ipjgAl37YBtyEkaHrdgR
	Rkgc0P55cvdayARXUHbqMsweBXr0KoC5ZMNW9HJthtevskr6Y2okvF2fw3meiWkn0ynUaEaOdZ2
	tH2CfqlLIY4AE9QNpaJMaodFwaSYq+qplurz1/+WESKLLXaK6hgqwVVTnjoHh1ah29KOIKcCqhS
	g1YbT8Wpv9SOO5ji240pro/DdJT3ZPHq3sOhiXUP3xHg4UMWla3siDYz3bRHVELQpsx1f+fMsey
	lwzQliONsxfb0In84q6qRCIEai+GAYe5rUXiBWB2HGVjG7QTiE0pS0x9RsBfMV2kQdTLsjO0lPe
	OSfg=
X-Google-Smtp-Source: AGHT+IEGUlFLW66ijvjDAdwIEjVLrDZHsPSRPo1a//tFPGyZK0o6IG8RL1FLXXN9Ju9SX94gEV6kLg==
X-Received: by 2002:a05:6830:6687:b0:72a:1d2a:4acf with SMTP id 46e09a7af769-730062fbcc4mr2693431a34.17.1745045187657;
        Fri, 18 Apr 2025 23:46:27 -0700 (PDT)
Received: from [192.168.178.39] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7300478ed86sm621952a34.11.2025.04.18.23.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 23:46:26 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Wentao Liang <vulab@iscas.ac.cn>, <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <linux-kernel@vger.kernel.org>
Date: Sat, 19 Apr 2025 08:46:20 +0200
Message-ID: <1964ccc4e60.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20250415122001.3325-1-vulab@iscas.ac.cn>
References: <20250415122001.3325-1-vulab@iscas.ac.cn>
User-Agent: AquaMail/1.54.1 (build: 105401536)
Subject: Re: [PATCH v4] brcm80211: fmac: Add error log in brcmf_usb_dl_cmd()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On April 15, 2025 2:21:37 PM Wentao Liang <vulab@iscas.ac.cn> wrote:

> In brcmf_usb_dl_cmd(), the error logging is not enough to describe
> the error state. And some caller of the brcmf_usb_dl_cmd() does not
> handle its error. An error log in brcmf_usb_dl_cmd() is needed to
> prevent silent failure.
>
> Add error handling in brcmf_usb_dl_cmd() to log the command id and
> error code in the brcmf_usb_dl_cmd() fails. In this way, every
> invocation of the function logs a message upon failure.
>
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
> v4: Fix spelling problem.
> v3: Change patch name and comment. Move error log into brcmf_usb_dl_cmd().
> v2: Remove redundant bailing out code.
>
> .../wireless/broadcom/brcm80211/brcmfmac/usb.c   | 16 ++++++++++++----
> 1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c 
> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
> index d06c724f63d9..a11a6d9f3c2b 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
> @@ -744,12 +744,16 @@ static int brcmf_usb_dl_cmd(struct brcmf_usbdev_info 
> *devinfo, u8 cmd,
> char *tmpbuf;
> u16 size;
>
> - if ((!devinfo) || (devinfo->ctl_urb == NULL))
> - return -EINVAL;
> + if (!devinfo || !devinfo->ctl_urb) {
> + ret = -EINVAL;
> + goto err;
> + }
>
> tmpbuf = kmalloc(buflen, GFP_ATOMIC);
> - if (!tmpbuf)
> - return -ENOMEM;
> + if (!tmpbuf) {
> + ret = -ENOMEM;
> + goto err;
> + }
>
> size = buflen;
> devinfo->ctl_urb->transfer_buffer_length = size;
> @@ -783,6 +787,10 @@ static int brcmf_usb_dl_cmd(struct brcmf_usbdev_info 
> *devinfo, u8 cmd,
> finalize:

The finalize label is used for failure path as well. So I suggest to get 
rid of it requiring modified patch like:

- finalize:
        kfree(tmpbuf);
-       return ret;
+.     return 0;
+
+ err:

+      brcmf_err("dl cmd %u failed: err=%d\n", cmd, ret);
+      kfree(tmpbuf);
+      return ret;
}

Obviously this means tmpbuf should be NULL initialized.

Regards,
Arend



