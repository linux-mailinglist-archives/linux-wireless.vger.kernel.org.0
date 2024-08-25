Return-Path: <linux-wireless+bounces-11903-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5086195E3FD
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 16:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67A592819BC
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 14:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F45154430;
	Sun, 25 Aug 2024 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRJDv/4L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50941DFCB;
	Sun, 25 Aug 2024 14:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724597438; cv=none; b=JHTuHkgrwGHnGxl5S2Diylr5L1Nq04kpqrIQKul4oeUT/HnVqn3ChzPKDENfWfy+AoBQ8hiXqviZZc7h8sEIfCz/3OP1v35Okm+4Jwl7D/+Vy2DBHNAmyRhpJVgve8my+WHoVY9o0Bm4sUra298745UR9KdVw+dKc1acMzkYJRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724597438; c=relaxed/simple;
	bh=ofQC/npSaoeKCg1WWe+IXgcVsQuPhBagALgMIZywEA8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=AUaLlyLRiBPqPxBjGrPPMT8kS6eCj9Di3WYsYnvgUPJ2FIlpt0CK7PvPaZFp76sIQ0P7pAvvpwPISq9eY4kN/p9Qg4FVaLAtTpMaZcAg3Taf7612HNoo9l30rOLtmMKmBDg2QOoj9rqprRKNoF2FwVrzZ/ItfqePugum7C2mI6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRJDv/4L; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52fcc56c882so3337548e87.0;
        Sun, 25 Aug 2024 07:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724597435; x=1725202235; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pc8FY73VtyRg3FAE2t6D99RHE0efb9mn6142+5HwO4c=;
        b=fRJDv/4Lpt1SZREuJ7rKvEToQmyIZ2ta31UZVEA13jsWq2ve+bQBu7qtysA8RhNFvf
         TD36rV2YaTmj4bjeETPz3pAENy48UYGgMtdR9lODdhLSht1Ae38HbS/ugXE7UVzhacci
         1GAoVSXaMOmB+cDF+xzYB9oER7uWkBvAKSLiWwa0BR9kqS0wWOVEtZEEgX+S5VdZ5V1K
         K9m06fflkY3T6CyDqiDqna6kcl1uVDsDZEkmfwCazncwfBLsu1qBfinKncOsf393mvpO
         Nc5n1EDsWMVOu9s+ZOkUdpHmSu/aKYmVhmobw2THgdjQEl+KVdxD3b5gDHHUtIWsZnzg
         T5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724597435; x=1725202235;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pc8FY73VtyRg3FAE2t6D99RHE0efb9mn6142+5HwO4c=;
        b=svIm2e79QZpZOK/cNMmGaHkLF5my0ewj/fQqyhGx4kamjox84p4EpMxufMHIqkW6MT
         4Uvofua2okSHoCk51XATY7l/TyTC+Azbjv24ffXxqnDzAqWcbUpJwa6Ud4oJhB4DmSvS
         aYtXdctWiqrepG8Bq3ejal/lhIqybtGydDxtGgnXrGhtJ8r8l0PAkLiSPQbxW5O6Uex0
         zYdk6TFhnA8PU207oIMwkhTwB7lTIWeSE7hkmMFibz+b83aTgQOOTef1nFCRi6iz5/kt
         PO8hMtv7XhAMg8u2KiReR5R+9axnfGD4QG+YUMXPcfgBTLlQ3wpJ3mspQD6lOCenOvT4
         /Zmw==
X-Forwarded-Encrypted: i=1; AJvYcCU3ZFKpyalD6Gf+tcWJNxycoyFDjBTCQW8GrhiKuKraveJBaOjesMNoHrYDG/bfv2s6EL/sXmaG@vger.kernel.org, AJvYcCWBZxOeu9eoJJlRoM2HhBPv/DuhAGIqv1ostbRHRAvcGuCJpJ0uO+EY/HBQxvIs1TKFp+nYIUIT/IxMXgg=@vger.kernel.org, AJvYcCXCHZLbO1TexdAxzaphzVdTSO93XgN4ipZdm38e7enjVNyoI5O5P9H5sSK3sV4yoBLmA/HWjtyz9/1qw278jow=@vger.kernel.org, AJvYcCXuM76WWvjS+zXGNpmQaEyaJ/zdrjxKP7K+V8zsvXeYTGUK+IkexgLH9OkqO8IQmtnr5gdkKZRWwKmp@vger.kernel.org
X-Gm-Message-State: AOJu0YwYZoXD4fJ6C3dqKRdJCgUpR7QI+BVU+WYGKEEviiq5m9R8hL/S
	n7U7NFuA43t0TChgmpCRVfj3vyhGm9EpAJ5pkKDjc9J56lhP6A3H
X-Google-Smtp-Source: AGHT+IH0/xfVzdRZjblK8KE69idqy4lw8tIafTxYwXC+VouljoNyroV0VA7MSy/dmO5QfZ/a6ulqbg==
X-Received: by 2002:a05:6512:3e1a:b0:533:4322:d03e with SMTP id 2adb3069b0e04-5334cbaf0c2mr4162339e87.25.1724597434273;
        Sun, 25 Aug 2024 07:50:34 -0700 (PDT)
Received: from [192.168.1.105] ([31.173.80.155])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea2937bsm1214687e87.42.2024.08.25.07.50.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 07:50:33 -0700 (PDT)
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
Message-ID: <580b93ac-58a0-6489-ad84-be6bdf98f7e6@gmail.com>
Date: Sun, 25 Aug 2024 17:50:30 +0300
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
	ret = usb_control_msg_recv(ar_usb->udev, 0, ATH6KL_USB_CONTROL_REQ_RECV_BMI_RESP,
				 USB_DIR_IN | USB_TYPE_VENDOR |

   Strange alignment style... If you're not going to reuse the old style,
why this trailing space before USB_DIR_IN?

> +				 USB_RECIP_DEVICE, 0, 0, buf, len, 2000, GFP_KERNEL);

   Same here...

[...]

MBR, Sergey

