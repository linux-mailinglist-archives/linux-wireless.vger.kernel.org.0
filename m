Return-Path: <linux-wireless+bounces-7939-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 243698CBD54
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 10:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B489EB20FA5
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 08:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA9C78C9C;
	Wed, 22 May 2024 08:54:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A86546522;
	Wed, 22 May 2024 08:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716368070; cv=none; b=TQmXw7OsniywA/Kg5PTjDdv2KK0VAeVJ+pkgtV21sW1XAq9HwgY9QbFMiQk+ocK7LUVPf/KQaC7pqg0FC4JEG9K4mWmRryQ/87UNKFFLJN+bJM2z9zQgC6J3olD1UNIIr9OG2DM6CHyY9QYz8AtUOCaYOHAr1P4TgyRy0PaXFnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716368070; c=relaxed/simple;
	bh=AAGNDmc0GUmss1gbsWKmPZoTiSwI0BqgwhKNiMvxu+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbiNSQiMoEF3yjnjrpxkZjKyJMWNZCQVdLG60MSSpJjMXDYJh66nKaOkZSF+JKfkCHTGqdGZAU0yMWCP/paV4bOQpTH8eA1qYuYkW142uL0iOOMx7wfNzvgJhXU9CCEO5oT/5UFKJ4u2QkwfOyqvsTSCMYxc/3RNHN7xXtcsG+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59b81d087aso914551566b.3;
        Wed, 22 May 2024 01:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716368067; x=1716972867;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HspjnCEvXmbgUttk3s3iC7M1d8a32lNVOBCNd0rIXxc=;
        b=JYH72epPSzjZrFpi/+a2C/SPLK0hjbHpC2ZCdnfiShVQLWOrPTZxqQ3xrWoRXTS6Cn
         DEl6eJvgAxiMsn3DAb/5skdrG8xlwhnEELD4mhNiH3BMG1MFDmfN7Kc1I+h8JQfYll9u
         mB1VkbqKcxat1MKreVerPeK3dgLOIYH53IhFJnTEg1L6wCwYV3JDIS1zAsjG4Va9K8Wy
         FfAg/UOHHFNxp+ED6xf74aTVpUnXU4oZmjYlCdx4D4vijGViyW1PWz8afqbaAD7eAsID
         3TaLvFBDD1PkmqEmJ+3oCAzr0RNQo+VMNlTTPq6pr0wXIVM70mAaUZlaTV4GN9LxOsNm
         XQJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXM1ctreQhJLXdg2g3XxKVVWIRqvt+YMtZmcTPv5bFK0h1oBBQDTRP0QGN8qRIVF7ca33HbQ3x7VsYC8TRYrKzWAq2aQKb0QjLXkwW0FwhYBlGzfa3SEmoZw4mZvAmlhHxAV1B8prB13FldfG0=
X-Gm-Message-State: AOJu0Yyvv2gK93oAsZ97f1/2TsmbsU0FV481uuciBzxOzLqTSG8XNM8n
	BPG1FdEkwacQ2YFRCQLUMcNjcAxjpEtc8k7+OKzRvEDbacsLrlvI
X-Google-Smtp-Source: AGHT+IFplUWmfFdL3ZU6R8Iae8/XVRL2QQOV5RYX6Q6tjJQ7D3jyOPtzwR21CtBgmOfQw/4qz27MXQ==
X-Received: by 2002:a17:906:ad7:b0:a59:c3a5:4df0 with SMTP id a640c23a62f3a-a62280b040dmr119223166b.4.1716368067362;
        Wed, 22 May 2024 01:54:27 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17814sm1732868066b.206.2024.05.22.01.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 01:54:27 -0700 (PDT)
Date: Wed, 22 May 2024 01:54:24 -0700
From: Breno Leitao <leitao@debian.org>
To: michael.nemanov@ti.com
Cc: Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes.berg@intel.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sabeeh Khan <sabeeh-khan@ti.com>
Subject: Re: [PATCH 07/17] Add boot.c, boot.h
Message-ID: <Zk2ywFQQ2SuXvPiE@gmail.com>
References: <20240521171841.884576-1-michael.nemanov@ti.com>
 <20240521171841.884576-8-michael.nemanov@ti.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240521171841.884576-8-michael.nemanov@ti.com>

Hello Michael,

On Tue, May 21, 2024 at 08:18:31PM +0300, michael.nemanov@ti.com wrote:
> From: Michael Nemanov <Michael.Nemanov@ti.com>

> +static u8 *fetch_container(struct cc33xx *cc, const char *container_name,
> +			   size_t *container_len)
> +{
> +	u8 *container_data = NULL;
> +	const struct firmware *container;
> +	int ret;
> +
> +	ret = request_firmware(&container, container_name, cc->dev);
> +
> +	if (ret < 0) {
> +		cc33xx_error("could not get container %s: (%d)",
> +			     container_name, ret);
> +		return NULL;
> +	}
> +
> +	if (container->size % 4) {
> +		cc33xx_error("container size is not word-aligned: %zu",
> +			     container->size);
> +		goto out;
> +	}
> +
> +	*container_len = container->size;
> +	container_data = vmalloc(container->size);


I got the following error when compiling it:


	drivers/net/wireless/ti/cc33xx/boot.c: In function ‘fetch_container’:
	drivers/net/wireless/ti/cc33xx/boot.c:76:26: error: implicit declaration of function ‘vmalloc’; did you mean ‘kmalloc’? [-Werror=implicit-function-declaration]
	   76 |         container_data = vmalloc(container->size);
	      |                          ^~~~~~~
	      |                          kmalloc
	drivers/net/wireless/ti/cc33xx/boot.c:76:24: warning: assignment to ‘u8 *’ {aka ‘unsigned char *’} from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
	   76 |         container_data = vmalloc(container->size);


