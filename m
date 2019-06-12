Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B628743057
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 21:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbfFLTlJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 15:41:09 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42957 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbfFLTlJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 15:41:09 -0400
Received: by mail-oi1-f193.google.com with SMTP id s184so12589071oie.9;
        Wed, 12 Jun 2019 12:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=35Xbx5eIJiLu1334ETcHUE8k0RsFsLJfyaYcwmmsQOE=;
        b=MqMi8TsAvOKjHHb0Ft14EKeSpcsfan3MLs4PKi8JS09THBUJxlOaSbogg1bJ88b8uI
         CqDdjbyxSJ0OXMG0UZC1eCnrX/Mem8MH/5DGQDxMHWzfdXJXcG8iBLKiCrW3+utkSkDp
         6jsLNE3D2FabHudbp5cdiomfkj6kP44JU12FRp3NrBUb+1If9YC+nwMrJuozemfwXoj3
         IcjBbrExeDy6bLjoeAwu6d5hDZr0i+6w8JPwRE1xcQqlCUH/5M59qhTxHBIJAWTYKbdt
         jOrXzHWO1eoeArRYVOKnfmm5AXsX3/4idpsnDSeEUjRWV/VuBjarAHc1J+MpTVX4gjj1
         FRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=35Xbx5eIJiLu1334ETcHUE8k0RsFsLJfyaYcwmmsQOE=;
        b=qzkA2lMBrQFeCX1tevLV7DPMXCG3G6QA6u0Sszl0ph6yAksMRxC3fbjtl8oSBpLn8I
         1QfmQbVZj+oP//Crip+xH7WJjXG7gRAXJT4PGYCCSt4nx/gqmBezsE/kj2OshMcIckKu
         CsPlKCxF77qyEQtsAz0b+92Ew6QdZ5yUYdlG+nQH0AuyobLkaHbKxbAEy4t/CAiimbYl
         kU6tSdv89wr7WOZxXYygrgdQapE0GhHuDOhEWHun2SWdsJGkuSE1YB7UpW9igAM9XpPY
         yTSwdv7W0eywN1Ht/T6LbVpPvX29rKSxE6gRmsixlfLgYylOpN3L6ziw0h7aJRl+zezz
         WzjQ==
X-Gm-Message-State: APjAAAUAnVA/cXc3y9mEBZyGTFCN+TWzKyrsAWhe4qHUGJeikaj9cWR0
        KvYdnXhqsfQMHw8J54PbQrs=
X-Google-Smtp-Source: APXvYqzScBUvO+WRNrO81ncq/61WpdaFUXNBomX2dTD+pIr8DFqrKn74TljYq1F+GoqnCLiT8iep6w==
X-Received: by 2002:aca:5346:: with SMTP id h67mr548323oib.55.1560368468775;
        Wed, 12 Jun 2019 12:41:08 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id f4sm242934oih.39.2019.06.12.12.41.07
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 12:41:07 -0700 (PDT)
Subject: Re: [BISECTED REGRESSION] b43legacy broken on G4 PowerBook
To:     Christoph Hellwig <hch@lst.de>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20190605225059.GA9953@darkstar.musicnaut.iki.fi>
 <73da300c-871c-77ac-8a3a-deac226743ef@lwfinger.net>
 <20190607172902.GA8183@lst.de>
 <30000803-3772-3edf-f4a9-55122d504f3f@lwfinger.net>
 <20190610081825.GA16534@lst.de>
 <153c13f5-a829-1eab-a3c5-fecfb84127ff@lwfinger.net>
 <20190611060521.GA19512@lst.de>
 <5aaa600b-5b59-1f68-454f-20403c318f1a@lwfinger.net>
 <20190612065558.GA19585@lst.de>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <d6d82c0d-4a40-a191-0414-6b9a64547f65@lwfinger.net>
Date:   Wed, 12 Jun 2019 14:41:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612065558.GA19585@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/12/19 1:55 AM, Christoph Hellwig wrote:
> 
> Ooops, yes.  But I think we could just enable ZONE_DMA on 32-bit
> powerpc.  Crude enablement hack below:
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 8c1c636308c8..1dd71a98b70c 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -372,7 +372,7 @@ config PPC_ADV_DEBUG_DAC_RANGE
>   
>   config ZONE_DMA
>   	bool
> -	default y if PPC_BOOK3E_64
> +	default y
>   
>   config PGTABLE_LEVELS
>   	int
> 

With the patch for Kconfig above, and the original patch setting 
ARCH_ZONE_DMA_BITS to 30, everything works.

Do you have any ideas on what should trigger the change in ARCH_ZONE_BITS? 
Should it be CONFIG_PPC32 defined, or perhaps CONFIG_G4_CPU defined?

Larry

