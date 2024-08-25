Return-Path: <linux-wireless+bounces-11904-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE3395E411
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 17:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D5D4B210D9
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 15:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9131D14EC71;
	Sun, 25 Aug 2024 15:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHN4f1rA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA9F4A2C;
	Sun, 25 Aug 2024 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724598480; cv=none; b=TYuyZWW25V8s9Q+TpEJ/tKeJfDVUknrv7zORtoSi+U2Qz3vXv4vjsjrUVj8tdNUx+ebA+9U1e2Ca4hNUo7fXbLYhg2v9OLEUPwx0yk26NCTBpnCNYp5CiFuqVuvHiVBBV4xLDt8l8GAoqJPYo5YVJ4zV2+bnh0FO3Vfr4KsvlSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724598480; c=relaxed/simple;
	bh=E2KfPsMx9/krn9sQQXLE317a7aD2b/xv9eZtmAKq9qE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=sIF0xSMbtgU/4bMxjP3l/P4bh2YDPr8Zcc1JyjsqZIyr+7FWFQs2QophZrJPVC3ay5wlr6EW68bCt4+ZYx+WYhmTHKOpSvNZqajwvXMosXzQHahaGstAlOR8UP0ygJhlewVPjAVyb89lK6Oi8QXrz/jrldjrNyhnTeYM8M2WqoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHN4f1rA; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f409c87b07so39074701fa.0;
        Sun, 25 Aug 2024 08:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724598477; x=1725203277; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJA3gEepVj2td8pDnx4GWLdE+Es2EQrzZZB6Knm3YPM=;
        b=UHN4f1rAX17BNQRbjbHlqzuKtUXlr38h6ZNgtVyVMIZdAOBVfcBlkNH2S3gRyLop9A
         MC6+59/4Xgqz6db5zYC1rbgDYRWqsoGeQl+hczbs704rAJLc1JCl8xVIhSr0D5ES1nZU
         RfkpIa0MvXEGoAgB2ZE7oXbHNa9QjepPDf6Sbd9Aksi2aWqHRAne4B9GYGkHwRm7bAx0
         d9sA/8+siJYDXJErjfCge3eR2BjoCwgu6k45AReou0g0dPZRZt2zqBaZK6m98HjGM5AV
         mEP1TEuoOGZKeqg3PHFIBDcmICW1b1xcgB/dIIxwEjuIiPiMnh5DWkKyzFYvaImKwOgL
         Bnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724598477; x=1725203277;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KJA3gEepVj2td8pDnx4GWLdE+Es2EQrzZZB6Knm3YPM=;
        b=MeGitWl4um9/av8ffv3562yB0Kn1s8Yh3n/rbzBR9/cn9E2fDtauMcbIjyl7OHh4Go
         yUikzU4APyPCRCiAOmD6MiQK1yz8hBLxIFNIEyg033ipnrtrBRw7lzOJv9nk4vcewcSr
         Z7bIPEHSdA1m8RJq2WUXfpo1/PDQaX4HF2XTSml+adhkO0Zn9d9S5sErPrGQ/G0EWETF
         sXKa7uN8UaP+7MucBWrJLOXAMqr3zrNp1ABWSVIkGz5C0z82Dq2eKH44zNPiEYbso+Br
         IeCtXC3kTk17La1+q9BR2NvKEWO4LVwR3h7fyarQbl1uAhlXuGOYfkH0BIxpBbgac2EW
         lscw==
X-Forwarded-Encrypted: i=1; AJvYcCV2xqkuruaM+l2nMQNq6SDrlRGyMH/YR1F94CuXmuZs7lLMBohmoTAkHjxC/JAGJ+/HPPS1yQlb@vger.kernel.org, AJvYcCVQyEno2To1m/J13rgvXiXD/PYqMGDE3R6ByP5JXlEFieihQWixQDqr6aMTP9Tmpo4+t9cdg5+crwWQ@vger.kernel.org, AJvYcCWESdZ6c388vIUOMT0dPn6Y9uVgJ0yjsb/P4nHwDCM5gnxnaOnQKeRR99Whi1pllQVwAQJaHhc7VnRirxsUC6Q=@vger.kernel.org, AJvYcCXY3/WGI/3wkj6bQHjiqxEi/E6xwq9xa6528MLzP6wUBeuSN/ZsUZelN1yL1tTmxaA5JcjVo36Vkl+hN/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQFYfpiF6iNG4WNFavaYu59CzK9BbwGCuxGymr6o6ticBuVTOf
	8EJfYBkBkH9Hway4PSSaqXVfuYMZO/r/0447TjFbl58C/F22iDbJ2vvpgg==
X-Google-Smtp-Source: AGHT+IHpkC7d8estHfyZBfpIZjGWgmNKTMMXdFj70Eip15DyJVsvfVpqtflUw2cXGih5vH91I5BpWw==
X-Received: by 2002:a05:6512:2391:b0:52c:dbe7:cfd5 with SMTP id 2adb3069b0e04-53438783e02mr4250933e87.32.1724598476369;
        Sun, 25 Aug 2024 08:07:56 -0700 (PDT)
Received: from [192.168.1.105] ([31.173.80.155])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea59279sm1180968e87.147.2024.08.25.08.07.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 08:07:56 -0700 (PDT)
Subject: Re: [PATCH V2] wifi: ath6kl: Replace ath6kl_usb_submit_ctrl_in with
 usb_control_msg_recv
To: Edward Adam Davis <eadavis@qq.com>
Cc: gregkh@linuxfoundation.org, kvalo@kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <tencent_1D9967CEC6D952EC86530991EED86ED70C06@qq.com>
 <tencent_F0CB92D8867509922ED02ED5CCA4E7D2C606@qq.com>
From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <67c25a14-4ce9-e848-05f5-d6955fc8ba71@gmail.com>
Date: Sun, 25 Aug 2024 18:07:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <tencent_F0CB92D8867509922ED02ED5CCA4E7D2C606@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hello!

   Oops, sent a wrong draft... :-/

On 8/25/24 5:21 PM, Edward Adam Davis wrote:

> ath6kl_usb_submit_ctrl_in() did not take into account the situation where
> the length of the data read from the device is not equal to the len, and
> such missing judgments will result in subsequent code using incorrect data.
> 
> usb_control_msg_recv() handles the abnormal length of the returned data,
> so using it directly can fix this warning.
> 
> Reported-by: syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
[...]

> diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
> index 5220809841a6..dc1f89ebb740 100644
> --- a/drivers/net/wireless/ath/ath6kl/usb.c
> +++ b/drivers/net/wireless/ath/ath6kl/usb.c
> @@ -1027,9 +1027,9 @@ static int ath6kl_usb_bmi_read(struct ath6kl *ar, u8 *buf, u32 len)
>  	int ret;
>  
>  	/* get response */
> -	ret = ath6kl_usb_submit_ctrl_in(ar_usb,
> -					ATH6KL_USB_CONTROL_REQ_RECV_BMI_RESP,
> -					0, 0, buf, len);
> +	ret = usb_control_msg_recv(ar_usb->udev, 0, ATH6KL_USB_CONTROL_REQ_RECV_BMI_RESP,
> +				 USB_DIR_IN | USB_TYPE_VENDOR |


   Strange alignment style... If you're not going to reuse the old style,
why this trailing space before USB_DIR_IN?

> +				 USB_RECIP_DEVICE, 0, 0, buf, len, 2000, GFP_KERNEL);

   Same here...

[...]

MBR, Sergey

