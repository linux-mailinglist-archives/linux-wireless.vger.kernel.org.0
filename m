Return-Path: <linux-wireless+bounces-9554-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21152917023
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 20:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC3F51F25E08
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 18:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E980B17C7A4;
	Tue, 25 Jun 2024 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irU8o8Wc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BBF17A906;
	Tue, 25 Jun 2024 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719339794; cv=none; b=qCWLSQrkyQZfO+Brrnz1bBIIsL10bHmPTSZUMighZDqB1Fh5Etq7AfAbZ6oHxVOo0J1T+G0IoZDEWbqCEtt5hTDedieZkQU0bqEuBYGeEJZMNxucp6xIHMmREVka8bCbpfx9aWSGYlfYwXNADcIeGAcXF8xJdx9iWxgcbrqBR0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719339794; c=relaxed/simple;
	bh=bPUh9nSGFtO2ZH250fsPH8AciQy/a+YeiaPMAijEL0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FZq0NfHsOJC5lQVJFJsIYprxBtwwlAVLU7qwWz8edW+zgpJlIeHN+PoQkarerq5eMTUG4kwrdLa9L8M6wWiICROUc24aDrAgxI/RXFpwE4K7W7cOzEfK6qLITSMYVBawr09JTADZZK/FiS7oyO2zzOCAyM3mYNbx4aun46CACR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irU8o8Wc; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a72477a60fbso353686366b.2;
        Tue, 25 Jun 2024 11:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719339792; x=1719944592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YI+bpBZALTybzUwLfkVghT7njEcIxrhFjEkXZ3RLHB8=;
        b=irU8o8Wco43HdK0E89fPiKjJpKdvjjlgQJz689Fom0yRTNX4l4hFmi3uemrN3ugsRQ
         hUPTgsGrrYiqSl6JbgGlPaRXp39C1DTa7rTCPA4hDejHJBbl7VViyiywcT/QDfS1bEAd
         qU9QLqrrxUMRPmJdd4V3gAnG/jD3ENCa9sNl/8KnggWC1f6nfnzNNAHm89ITkZ5zuSA+
         kLzmEZcyAxbxJ2MEDnMlrK/PLYXkJ28fOalM7FEdE2oDf6N0W/KW1PgSvd/3DRxzdJNP
         jMVSlTlEOX7WEmHd9ujWALB9g1iCLkPXU1MFzN/45fda5v6hJ/ZXUaWyYggkMrD4KXa2
         WVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719339792; x=1719944592;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YI+bpBZALTybzUwLfkVghT7njEcIxrhFjEkXZ3RLHB8=;
        b=CXycUX4mUUxSZ+XeWdPNcsa38DaVs+tcyVTAiXOEVNp1YtyikcfLTwDJ/EZxnAGl/X
         /zOIxLy1ijgQdVRbZHS6P048NPt4870abpvR8UhO0XBFal4BzbkA8g2mAiOJoj47OIqY
         lpf2Xyvm4GiRiw/Liqhgmaqum/TOKxXrDQoqE10kIc1tLY6KgNcTGYTWH6rCUbvl7jTT
         +9ao7paS/IAhRh/RzN6FqZb7yKoPLn6YmkWQ3jOgyY4h6yJsL2vw9VkCowBwHH4x7pzK
         7es9UoP9xhGIVS0ISidWSm2QHesV7UyTY7rqTQkpPhWaWBuZGFJrl1c+r2zzTrquVnEe
         WFIA==
X-Forwarded-Encrypted: i=1; AJvYcCVEMA/3m3LFph7LaUPYcnbwH3MGpLC9hrjFmeZnlWAkl2gMsv/dgCCg/C1XGJWJbgsH3FCulS3euzXEQA7zHpjFRz6gLY/LPNnf5zRmX2rUK9fPOH52ja2aNptxG37ndvvSi+Hd9k5klaY+aUzZtWwM+Hk1i5QMrDeLL3Yiq6GagmuWbGBT5fHq
X-Gm-Message-State: AOJu0YxPCX0WqrEdOLSFJuzcDRfM0AUifuDOhU7k2R6Y83DBobIbAD8u
	fzMlp4R0J0gnGdXB8Fu/z0jJ6jYtb3/HzFS446RnIc/8SaKTQEvQ
X-Google-Smtp-Source: AGHT+IEVE9h75pyP6xYrOYIztjemaOBJkjZ5/GNfxxLHHYCikvn/gKAFsaiCv9uiZ89ZZ/jp3mE6Bw==
X-Received: by 2002:a17:906:f1c5:b0:a6f:73df:15d1 with SMTP id a640c23a62f3a-a7245b6deccmr512949766b.7.1719339791398;
        Tue, 25 Jun 2024 11:23:11 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72557eea48sm227432366b.52.2024.06.25.11.23.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 11:23:10 -0700 (PDT)
Message-ID: <89f2564f-788e-495d-97ce-f1fa8a921d50@gmail.com>
Date: Tue, 25 Jun 2024 20:23:09 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] dt-bindings: net: wireless: brcm4329-fmac: add
 pci14e4,449d
To: Jacobe Zang <jacobe.zang@wesion.com>, arend.vanspriel@broadcom.com
Cc: kvalo@kernel.org, duoming@zju.edu.cn, bhelgaas@google.com,
 minipli@grsecurity.net, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, megi@xff.cz,
 robh@kernel.org, efectn@protonmail.com, krzk+dt@kernel.org,
 conor+dt@kernel.org, heiko@sntech.de, nick@khadas.com, jagan@edgeble.ai,
 dsimic@manjaro.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240624081906.1399447-1-jacobe.zang@wesion.com>
 <20240624081906.1399447-6-jacobe.zang@wesion.com>
Content-Language: en-US
From: Arend Van Spriel <aspriel@gmail.com>
In-Reply-To: <20240624081906.1399447-6-jacobe.zang@wesion.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/24/2024 10:19 AM, Jacobe Zang wrote:
> AP6275P Wi-Fi module connected via the PCIe interface.

Repeating my remark from v1 series although I gained some knowledge what 
chip it should be now ;-)

> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> ---
>   .../devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml      | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
> index b9e39a62c3b32..fd22ade92210c 100644
> --- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
> @@ -53,6 +53,7 @@ properties:
>             - pci14e4,4488  # BCM4377
>             - pci14e4,4425  # BCM4378
>             - pci14e4,4433  # BCM4387
> +          - pci14e4,449d  # BCM4329

This should BCM43752 iso BCM4329.

>   
>     reg:
>       description: SDIO function number for the device (for most case

