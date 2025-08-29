Return-Path: <linux-wireless+bounces-26871-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 195FFB3C338
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 21:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494E61C81498
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 19:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8251B242D63;
	Fri, 29 Aug 2025 19:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w4/Ht3rs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B52242D6A
	for <linux-wireless@vger.kernel.org>; Fri, 29 Aug 2025 19:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756496412; cv=none; b=KjDbsBOHqYDeBu73NsY+0PwnRyXMkPO/uLOA7VNGaOYk6iBsFzteSw+G5QxUyAtUsnUJ+vWZ9SU3PO590OH0IFI2HHw3GA4RDpF2f7doiUi0R7b8idK8e1hKgmbPpkkX7bXMBr8omvKkTMbczzJJQswA+ZZjoROc4jUKKfhLEbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756496412; c=relaxed/simple;
	bh=ciPI4Xq2NM39tbgjQejg2mPzVCVXgCwQKQdBW9bwO1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4lMyuTQ5IDJEm5y1MjZVlGBBMNvJBOxy6DyoUPyfWD6Mh1cS+J5xSsDjHReudXfuaaOD+q/OWehrqIFvGZ4obmGJCYQsgs5QzWjSqzRqZtofN0UiLeFmBsZjV6ULBTzWWm3+NNUiG5/gWBZr1qeNYkv3z4MhO2BI5hw8JOCHec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w4/Ht3rs; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ceb9c3d98cso1028434f8f.0
        for <linux-wireless@vger.kernel.org>; Fri, 29 Aug 2025 12:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756496408; x=1757101208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bI4cdjbqUB9owljH6EP9LE5/l7cblwmGjSeJXJAhNWc=;
        b=w4/Ht3rsya6vvBe1zjTq6W70Y9b4gwQ6s63QfDfZJzew39/fxiiEDfxcHpbn8JiMxe
         vkTCsmkbROhmYDt83HKI5CXOyMV+haY+0rQ5MB7geYkHBtS6U0D0GKoUWr+f1oY2uUx/
         MUFb/KQ44ElnvPhWVFmxetG2Fx0sdOuNBFS8Nnwx4bM29bgTkrgvkyOSTlYOhxPq3HtW
         LlKsBPLL45tn4ZWgKkrdj8xb1jJGwA5DaHi5vgVqKhMvluMvH1xxesbQFj8MzhB/dMrt
         JRHCBh4uGM144QYytZuOcm+bO7cmtn0ekQ/aGBP9PXn7Gz0jOoKHpNG8zY6nskl+oR04
         Q50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756496408; x=1757101208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bI4cdjbqUB9owljH6EP9LE5/l7cblwmGjSeJXJAhNWc=;
        b=Ix1bAAXfhIjIZe1xHFyv1oAjdjdu8V8lg7kMlonY/qKAwTrklrsgTX39Q3IMEBxxzq
         dt/xW8O7fBnU9Mhuz0Plm7xU4XIcCHME5rQtB3v8367yblLLXZFJmUeinniFrGDkH7lH
         jNgRkj0ByVL4zrdlwMlcS81SMhUqwFNPBEaCi0WT+m7bbmGvSISo89cVBydSDEH51Llf
         uDric3YIbPj0cRfWRCWnAdzVtMKwXcfG5OBAGj0ydql58FQvlYu0uEd5wX2WZgxSNUph
         cLUCiAFtBB8p670pbhRdzD61/hTa48h7AEVwH1Vh1UigWeKkDa3Ui/nhPYf+8sqHr3sw
         sshA==
X-Gm-Message-State: AOJu0YwbRPlsEpW11L30wJw3WH/htNkjbu52BLqdE1s24cQM/kTG7F4I
	ZU7w4u0dGR6idECF3SYHAPakyb44KDOOfwOBv3wgJoQj6AO8k6vsGYntmC0BgIKvCFE0yT4ChKS
	S0zZ7
X-Gm-Gg: ASbGnctAo8pONTGAs5bBvbdzOKJvrv55bMbwZooDHhCAnE3qQcrud0qX8JKw1op7XPW
	7yLADxrD3Caz5wuaSwFE19XxnKuYAJ35t0VGIvN9Jqo5eBsQWHUrxDTz64df9u4LD7ooo1wyqkf
	LN4UOsUppj8GiVafhAJcKJ1aA1GsNpGiubz3R7XJlAIF4p8ezpko8LTv+AFgv7tqjnWwAJPnqCs
	lwvmIpwCFnOfU/8VmE/zEjdzyy4hYhpjs3wH0VN5HU7I2b4vx/5nsEdNB2JnHApoffLruwfvucR
	b849+H3nBHkeptMZNO/5nc12r50jz8t+b/p+FSBX8o3WOAGEfDjsIO41tyYQranzWXkJy2jyVFe
	gaCf8Faopxa4BDjGJnv+PxnEczqG+D7WHICfrzg==
X-Google-Smtp-Source: AGHT+IF1j3VqMExTi0nHRpO4a1bTpjOhkuQODL74IgkV2OOEPrj/3kzp/SS3AjNSsm6y7giDOx4IEA==
X-Received: by 2002:a05:6000:25c1:b0:3ce:f0a5:d59b with SMTP id ffacd0b85a97d-3cef0a5dbaemr3696988f8f.12.1756496408566;
        Fri, 29 Aug 2025 12:40:08 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3cf274dde69sm4454918f8f.14.2025.08.29.12.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 12:40:08 -0700 (PDT)
Date: Fri, 29 Aug 2025 22:40:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ajay.Kathat@microchip.com
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: wilc1000: avoid buffer overflow in WID string
 configuration
Message-ID: <aLICFFa8EG7EGXcG@stanley.mountain>
References: <20250829182241.45150-1-ajay.kathat@microchip.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829182241.45150-1-ajay.kathat@microchip.com>

On Fri, Aug 29, 2025 at 06:22:44PM +0000, Ajay.Kathat@microchip.com wrote:
> Fix the following copy overflow warning identified by Smatch static checker.
> 
>  drivers/net/wireless/microchip/wilc1000/wlan_cfg.c:184 wilc_wlan_parse_response_frame()
>         error: '__memcpy()' 'cfg->s[i]->str' copy overflow (512 vs 65537)
> 
> This patch introduces size check before accessing the memory buffer.
> The checks are base on the WID type of received data from the firmware.
> For WID string configuration, the size limit is determined by the maximum
> element size in 'struct wilc_cfg_str_vals'. Therefore, WILC_MAX_CFG_STR_SIZE
> macro is added to configure this size.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-wireless/aLFbr9Yu9j_TQTey@stanley.mountain
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
> ---

Thanks so much!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


