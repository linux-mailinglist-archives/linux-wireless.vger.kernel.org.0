Return-Path: <linux-wireless+bounces-2291-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190A1833621
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jan 2024 22:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFAD4282038
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jan 2024 21:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7810C12E5B;
	Sat, 20 Jan 2024 21:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+qYk9KW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A39394;
	Sat, 20 Jan 2024 21:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705784768; cv=none; b=qN4mdHPEJyX5dqblBKQK8bxaH1sA5uQoXJ5shKgtLQa+VK/jfcFuImAK4atiYvtCxIJSsMVRk5cdNSLYEoUslLr8Uut97wVLJbVUwBwlG6wUrEWyDcTiOY9wU3IMr270X9IM6irA6fdLaOaq2D2DMXHJ2UtTTOOfW/4q9k6TPgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705784768; c=relaxed/simple;
	bh=3qE6x3nL0LxScB30Ky4Ariiuqa3uxdDhY8YBcbxvizU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IG8cNJuWVooIGf8T5dm66d8RFGIN6I4Ipw3GpEPqBZZp4mSVNhqYEf+/Km7karF1mxypHL8iwzdBdsU3DRk9P7NqbwBt0hK0mVDgRPIYV41EhETnRko+w2r0KTYgBr0wu0yTieD/9ZWqXD5/iysXqR05Pscokxvw1MLVd95qChU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+qYk9KW; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7ba903342c2so111252739f.3;
        Sat, 20 Jan 2024 13:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705784766; x=1706389566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2xXegOS7ClGg2BEbcZwkFVV5ySUvJXxkGDHtYE2nX3U=;
        b=D+qYk9KWYo9VVTujvnGcpGAtqLPc5d4tKmqjaMDw/kQTXsbF2dEH2lSfTc15Mg7eQf
         TiWqTBuwzYNVSmfiSOJ0NHgVJhYigSslTAx2SRvbWaK5qQutpgrE5NV/TRTGl4USbD8i
         fWD57jJxuA6rR97AWvdwXRQRkdkhK/HUY8CXfGYsLUvxj8srjn7+CBWB7cvVjgrQ9J7V
         ZimAREKWUzPpv274e/0v97/MIWO63w8sRrgCt3CtGpwAiDC3FILFe4LuAS2Cs4DVBvxW
         RaQ+vs5WW2HS3u3reWrxMgdH5Ev6MYRidqOoO/P19VhrGgrTZ44HZS6qs5dddusAdTOu
         iNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705784766; x=1706389566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xXegOS7ClGg2BEbcZwkFVV5ySUvJXxkGDHtYE2nX3U=;
        b=nJEHGeIG9t/fLJB+qrjiRDndKqA3qFgEPKXo6sPBlqPgnqZVWQeU2ehw/yyAJgypcb
         5ycuksYuFL1YV9duTjqXghq+shPoxrWB4PhDraJgvj5Gdn0KeqGY6U86pAFsWA8+Yo+f
         8gBQIOU7nKAxgw4di1Crve0Sj1VdmiieppQ0GLe59U1L3WwydaupS0SLT77hQ6Ca3dRt
         9skEGwBLA8F1To+TgPyMpTXn4NRFdGK5EizHTAfWElfMtvMdhAguHtMn+L1upGOVJqZJ
         8kp1eWLK0FYTLb9Ywwdw1pFA+5eAALsgW5r1f7B7OXomX8lAgvaQ+5D+a4FmxRABljvO
         5Kwg==
X-Gm-Message-State: AOJu0YxHcwePyvPRJNw+QWCtslkk5xuIz8FUP8f/J1rpn0eTdZRHfqul
	vJBIThKWh2ikekRp+iJuJXa5iy2LwJN5hZhkrobakpn6f2CC+Uao
X-Google-Smtp-Source: AGHT+IG9YypzKX0DrYGko3rZc9qI/PlJUhYyCJPEBPVIz/eHw92MupYDlU0dEfNi8amZRtX/qVy31A==
X-Received: by 2002:a92:c0c5:0:b0:361:af7c:de16 with SMTP id t5-20020a92c0c5000000b00361af7cde16mr2613975ilf.24.1705784766023;
        Sat, 20 Jan 2024 13:06:06 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:b227:ab83:6b35:c967])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902704a00b001d4816958c2sm4889712plt.166.2024.01.20.13.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jan 2024 13:06:05 -0800 (PST)
Date: Sat, 20 Jan 2024 13:06:03 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: bartosz.golaszewski@linaro.org, linux-wireless@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: Re: [bug report] gpiolib: use a mutex to protect the list of GPIO
 devices
Message-ID: <Zaw1ux7eTogP-DQi@google.com>
References: <f7b5ff1e-8f34-4d98-a7be-b826cb897dc8@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7b5ff1e-8f34-4d98-a7be-b826cb897dc8@moroto.mountain>

On Mon, Jan 15, 2024 at 11:50:52AM +0300, Dan Carpenter wrote:
> Hello Bartosz Golaszewski,
> 
> The patch 65a828bab158: "gpiolib: use a mutex to protect the list of
> GPIO devices" from Dec 15, 2023 (linux-next), leads to the following
> Smatch static checker warning:
> 
> 	drivers/net/wireless/ath/ath9k/hw.c:2836 ath9k_hw_gpio_get()
> 	warn: sleeping in atomic context
> 
> drivers/net/wireless/ath/ath9k/hw.c
>     2826                         val = MS_REG_READ(AR9285, gpio);
>     2827                 else if (AR_SREV_9280(ah))
>     2828                         val = MS_REG_READ(AR928X, gpio);
>     2829                 else if (AR_DEVID_7010(ah))
>     2830                         val = REG_READ(ah, AR7010_GPIO_IN) & BIT(gpio);
>     2831                 else if (AR_SREV_9300_20_OR_LATER(ah))
>     2832                         val = REG_READ(ah, AR_GPIO_IN(ah)) & BIT(gpio);
>     2833                 else
>     2834                         val = MS_REG_READ(AR, gpio);
>     2835         } else if (BIT(gpio) & ah->caps.gpio_requested) {
> --> 2836                 val = gpio_get_value(gpio) & BIT(gpio);
>                                ^^^^^^^^^^^^^^
> 
>     2837         } else {
>     2838                 WARN_ON(1);
>     2839         }
>     2840 
>     2841         return !!val;
>     2842 }
> 
> Before gpio_get_value() took a spinlock but now it takes a mutex
> (actually a rw semaphor now).  The call tree where we are in atomic
> context is:
> 
> ath_btcoex_period_timer() <- disables preempt
> -> ath_detect_bt_priority()
>    -> ath9k_hw_gpio_get()
> 
> Another warning this change causes is:
> 
> drivers/input/keyboard/matrix_keypad.c:95 enable_row_irqs() warn: sleeping in atomic context
> matrix_keypad_scan() <- disables preempt
> -> enable_row_irqs()
> 
> drivers/input/keyboard/matrix_keypad.c:108 disable_row_irqs() warn: sleeping in atomic context
> matrix_keypad_interrupt() <- disables preempt
> -> disable_row_irqs()

Now that that operation becomes heavier we should convert row GPIOs into
interrupt numbers in probe() and then this issue will go away.

Thanks.

-- 
Dmitry

