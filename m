Return-Path: <linux-wireless+bounces-19232-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F26FAA3E875
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 00:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89FBF19C2888
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 23:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832061F1307;
	Thu, 20 Feb 2025 23:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEtsrRtV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9452641C3
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 23:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740094120; cv=none; b=nDKIA9eCN4H/coOPTQDgXqHcopxQjT1c0n4VLote3d8VB7cnKmUFk3h3XDPOcJ+ev6ZmK+knpdHVkT7qVKIwHYrHhXP0n14rOHrtEDkzrVXP39Mz/a8bkVMqemQZOwvFRkKpIBLZ4+hrB3S0AZX2bLW6q12Qcpco5iXmqYNktKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740094120; c=relaxed/simple;
	bh=3fs1Bx3USdQtTLZsi73pugqJwBZDcquTCbAiuqRUhGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZcSJM7MbWoStM7sl2Q8uXFr6PbflYvFfetaraPGol4QlGz/UpSA+faArcy3ILGlwp92HbwN6ZSDngYANWSM6M8mSoxpS7yH1v8nTSR4pLP3SP6Xs8HhrwsIY+tTUpVfXxMXQIia4+6RyCPQrxxJ9oRnifCX8QNTKPlrVz8lvNTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEtsrRtV; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abb79af88afso293660166b.1
        for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 15:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740094117; x=1740698917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+qijJhDW7LTVmLHV2OlhgyC3s397fbp4DoqpPJ6oYu4=;
        b=PEtsrRtV/3d/AlbJYc+nql/3W7uF/Zf3n6O4eXL8Q95tEYtNLYF4hqnthlu5DaDZgc
         tPk1qI8/xDL3tgCJo85Ve1B5WjxTIZmYJZ2p78B1h9mmKKT1KM19aagH2XwB7d3ueg8Y
         bLR0Xkn3SMe0VeIkkZeJ+q4Y2Z1XuOCU/6LpcPc6k2mdVwlRh+Re3FrC6lRlW9cv9bvp
         vBYJvy3KCqLOF3uGlY9ZqkyK1uARcXDCNx0maucfShymAEgHWsDXXo9vQCZwhWtRZpD+
         F9zTXNGGXGMpBepAPBETEFwALTCNDGhl9nGuaJNQHTEnAlSBCcGfh5IwinORcUwCw0QM
         PHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740094117; x=1740698917;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+qijJhDW7LTVmLHV2OlhgyC3s397fbp4DoqpPJ6oYu4=;
        b=COSkbBfia+7TlivHln8vnWdkJZux4UaCKhE8r+9i6rW1G4HHXcZO0pMAdrmL86xn8Q
         jXTpZ+EMOLajiHdKDwIm7wbHqeAPJVRHclTlLYj+JZz6BS/HpuU9hADdNwT00mcHUUEm
         8wk8iJAsoJDbl0akNaKSgWJ+TPOKbpw7+WPkpwSGQdbU6gy9c0tuNVvU/xg+hQsW/eUQ
         WfMCMIcKAeyYxEb7jaqzPunNvSARHk7SGEu6Q7HOUhmusvfSy/PcDvPH/pPoxHevcF1u
         7Ct7cn+vBN5IuMLpeODmGUJcUlJ22ADibJ+0sttCcBHcBq7XdEz6KIsOm4L4ADtoS5fN
         MyqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtd+mdFMpyGdaRIVpJd1XqEGp+CV4XOuwFfKqm+dqsDWQaVSqTz3guA6nOfO9nUCsHlQadhyRwjFjK3gx9mw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKiwuq5CtsYxxJXoAsH2Le0JZAS8j+vWGfZVPc8vsM0skaknJy
	IYi4/sBpHjJg5LJdfEmFdnd3qAI0hKopOxg17xZ+fR8gu8WO9PxP
X-Gm-Gg: ASbGncu6QU2k2gxwl1RWW3O+yL3Ynh4aPXEeaIeDixkmmw2OlxOxLVjT1IIjHrLcr4J
	9w34c66o4D8kAkmmGfanRILq65MQFCqq/WZiG2uL41LvRsU5tbXSm4CsjUKUCdPhTbvaHCOspDv
	2aiaMgHooahGT1PSMMQB6g05vWADvAAtsNUqK8lPOfafOCBLAGXiUW5v422ky/4je2uXLeJZTU0
	vD2OWM1chl3aahaUzVueU85MXVIG/jxVHxAutFiTfCl3W5ZDepkTFoDDk3f13jxruKG5s4OAc2S
	1E0bW7TzSKmbK18BtrWTc7Nq
X-Google-Smtp-Source: AGHT+IEVQzDCDs/etbbqqfQqAudOfphSs3xQQyuWjMzlCZwTidfT7cyJ4tK0XqM01fBpAp+Uxl45Bg==
X-Received: by 2002:a17:907:7754:b0:ab7:cccb:ae2b with SMTP id a640c23a62f3a-abc099b7f67mr115853966b.4.1740094116759;
        Thu, 20 Feb 2025 15:28:36 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb952c7364sm928073366b.18.2025.02.20.15.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 15:28:36 -0800 (PST)
Message-ID: <183170ec-9a9d-4525-bc00-9cd82ba82cee@gmail.com>
Date: Fri, 21 Feb 2025 01:28:34 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] wifi: rtl8xxxu: AP mode fixes (for gen1 devices)
To: Ezra Buehler <ezra@easyb.ch>, linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Ping-Ke Shih <pkshih@realtek.com>,
 Martin Kaistra <martin.kaistra@linutronix.de>,
 Johannes Berg <johannes.berg@intel.com>,
 Reto Schneider <reto.schneider@husqvarnagroup.com>,
 Ezra Buehler <ezra.buehler@husqvarnagroup.com>
References: <20250219175228.850583-1-ezra@easyb.ch>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20250219175228.850583-1-ezra@easyb.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/02/2025 19:52, Ezra Buehler wrote:
> From: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
> 
> As mentioned in the previous patch [1], especially the transmit rate is
> rather low in AP mode with gen1 devices like the RTL8192CU. The
> following changes seem to fix the issue.
> 
> When looking at the patches introducing the initial AP support [2], I
> noticed that rtl8xxxu_gen2_report_connect() was altered too. So, now I
> am wondering if we need to use `macid` and `role` in
> rtl8xxxu_gen1_report_connect() as well...
> 

I don't think these chips have those fields in the "joinbss" command.

> [1]: https://lore.kernel.org/all/20250122071512.10165-1-ezra@easyb.ch/
> [2]: https://lore.kernel.org/all/20230428150833.218605-1-martin.kaistra@linutronix.de/
> 
> 
> Ezra Buehler (3):
>   wifi: rtl8xxxu: Use macid in rtl8xxxu_update_rate_mask()
>   wifi: rtl8xxxu: Use macid in rtl8xxxu_fill_txdesc_v1()
>   wifi: rtl8xxxu: Make sure TX rate is reported in AP mode
> 
>  drivers/net/wireless/realtek/rtl8xxxu/core.c  | 28 ++++++++++++++++++-
>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  1 +
>  2 files changed, 28 insertions(+), 1 deletion(-)
> 
> --
> 2.43.0


