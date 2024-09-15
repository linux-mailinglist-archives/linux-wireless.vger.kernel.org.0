Return-Path: <linux-wireless+bounces-12865-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8489794DD
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Sep 2024 08:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97C421F22152
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Sep 2024 06:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E230722F19;
	Sun, 15 Sep 2024 06:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Om/r6H0p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E111B1B977
	for <linux-wireless@vger.kernel.org>; Sun, 15 Sep 2024 06:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726382961; cv=none; b=sBNichHliJ/3oNJKPpn2SngfXrIrO29JeIQvd7+LS3/Og/0tIIe6Dw9BHmeJwW9JsOoUgVqp8T3Zihb1qW71GFL7HXa2l41hLlQm6WMn34CIbb/JdS2K9UnIS2hxbvsbIyP+wRtvAY5zllZA4AsdpQsbhNrW8PMKM9EDw1IVwDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726382961; c=relaxed/simple;
	bh=UJ5k25ZV3lJdTTaM8tIb7kjVAGzanB8T92WEAesbG6o=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Yfrj4sl0d4bbDRzH7b3///1s73KoCN7OdaNSHvkmBCxAzGauvvZPoazY0XByzKwxq/9Bk6yTMUzmTsnIIkHcXqdnsKAZNqdky5/kx6Xy/5nqxe/XhEcyELbMVQloz+pU7jTX1eYTZY1i097/ciwnGEQawBPyYW7e1ZRv0eoC1ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Om/r6H0p; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7d4f8a1626cso1758491a12.3
        for <linux-wireless@vger.kernel.org>; Sat, 14 Sep 2024 23:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726382958; x=1726987758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWfnMMz7l99gAM3XlLaOGRiADmU0oeZX94hUcKz22ns=;
        b=Om/r6H0pEKLa5GFt2wbh6MvTrDhjT0jZILEHwKwtBvcodSea3ikjAcKpso0nGeJEUN
         ABy1c6Ivjfy12JF4GhmhXbF4/00bftyOn1pdqW4MOOkEeDeWnXE5jqIdwBHF7V0Agl7I
         Vt7UAwYKh6h7sS911lkWzxmShiABxPX17F6bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726382958; x=1726987758;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kWfnMMz7l99gAM3XlLaOGRiADmU0oeZX94hUcKz22ns=;
        b=gPkGvyYtuU8IETnpTTeGVjIQMKsPUvJdC1ChOJpUwNNT3KBul/Hxqzcf9Tl9dUOF8B
         cgwhveASACAy6I1r7Re7RUKOJ9C9CnDAYg7C6WFVdEssxvnBvtuMCVN04+lzVu/Pu7dw
         B6arKy2ExoXHfQHuhERqPwgntJZnaS1QTiJwPG1EPWIOugRQCZYfxYnwAZMhXV3tsEqx
         Q4f1dOtFcmB1ZdMXZOdddR9riLvIRd1/AzPtafeucfOGyheR+h429S5fzo50tzBjqVyr
         2+b2RcvdiT2wPFdJuznOVXdjYm3yZqQ8LKdC+0NigbfCETbFZEG6VO8xdBTlm8sEFNew
         TN5Q==
X-Gm-Message-State: AOJu0YwRba5eCnVR9CE/NuW2kH8F17mDXdQUCIlZTZomt/1NWMySBeIJ
	+5VhISJGj5ZUbP5LhP2n3wPWcJ+AY3/3JBG9OpKPn2pX7PxCRFpPxoc/y+CyAg==
X-Google-Smtp-Source: AGHT+IFE3Rw0RCxoDKs6dsS7IG+u5rzl9WSQMtzPPbskf+XeDvZ7pl7wwvVVMCZwzpDSVtxvmCYueA==
X-Received: by 2002:a17:90b:4f91:b0:2d3:cd27:c480 with SMTP id 98e67ed59e1d1-2dbb9f7d558mr11323825a91.33.1726382957920;
        Sat, 14 Sep 2024 23:49:17 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbcfcbb42fsm2576910a91.4.2024.09.14.23.49.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Sep 2024 23:49:17 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Jacobe Zang <jacobe.zang@wesion.com>, Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, van Spriel <arend@broadcom.com>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <nick@khadas.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 15 Sep 2024 08:49:09 +0200
Message-ID: <191f4714288.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20240910-wireless-mainline-v14-2-9d80fea5326d@wesion.com>
References: <20240910-wireless-mainline-v14-0-9d80fea5326d@wesion.com>
 <20240910-wireless-mainline-v14-2-9d80fea5326d@wesion.com>
User-Agent: AquaMail/1.52.0 (build: 105200518)
Subject: Re: [PATCH v14 2/4] dt-bindings: net: wireless: brcm4329-fmac: add clock description for AP6275P
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On September 10, 2024 5:05:46 AM Jacobe Zang <jacobe.zang@wesion.com> wrote:

> Not only AP6275P Wi-Fi device but also all Broadcom wireless devices allow
> external low power clock input. In DTS the clock as an optional choice in
> the absence of an internal clock.
>
> Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> ---
> .../devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml       | 8 ++++++++
> 1 file changed, 8 insertions(+)



