Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF9337DDF
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2019 22:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbfFFUMC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jun 2019 16:12:02 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41667 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfFFUMC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jun 2019 16:12:02 -0400
Received: by mail-ot1-f66.google.com with SMTP id 107so3173852otj.8;
        Thu, 06 Jun 2019 13:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZplH1ueYIFTxbhcNaq6d9TNtLXhmYa3vn9NLw27k9Lg=;
        b=stIiNeN9hdh/mk6PIsJUOcTV5NamnY+Y+K3zQGA/YUbAsxjwv51CGIsZSrrY1ygC5u
         Ndjv8UvipwdJcvPnTGbXklxessOCWoR2PVsRgn7tauT5lgtngZvoq0M5wzWL7bpi+g9N
         XdwMm8VvjAqoO3mCTAqphKPLlYiLz7IABHFHrfYUGnBPM8P1Wd0eWhQJWHzUz4Z2bgQq
         2DwHS6Z2slz5m7Tq6KXezIEwPtYEhG/fj5ic/eCici/bSdauJ1rFG44EgZ55tfYqAAfr
         Bspd6Y2TT//5MgX+Hb8pqXXVcU7WnLCRyajfW6952doLGSTff8CYoBhTEP+0DjqoAG8E
         bXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZplH1ueYIFTxbhcNaq6d9TNtLXhmYa3vn9NLw27k9Lg=;
        b=Cl3oEWk1xcCSVjdvqwMw/NaC3j9M6bZQUhJuYaPFMdGfs0LR0pQVHXkHgJoDwNT8zK
         KYxVQtptksJCd8bq2WgrHNWUPrvH7iQquPxwmG5sNafz5FvQzx8tddYC+uPM11HjCYyH
         xVINBhSwaHdJxSHG7VFFkVxDOgsSomZPLe8Sj1Um7Bp65rKfVgBtOyMC/G+rUq/PmAgE
         WFnJPj044z+/qzd7EUf1u9B/ILdSNF8TQUO3eP+ugnlSRbsW4IawRXK8RojQjSBQG7/4
         eYSuNN3fITJKBQrMYJWxTsQW8g+8fjU0c+4y2CyRDcV1gcB8O5ZYLgrEH5Xq1W+yPTe9
         jzcQ==
X-Gm-Message-State: APjAAAUXT2CxGlwuMuZuyuwGZFBMjLlW+xmoz2e5u7MjPwQK0ZE/nYJY
        1pF2DR6ptTqkz5yqJfgN9ocypUUm
X-Google-Smtp-Source: APXvYqz5aiOuHakWTOD3QUBMVJRMbspstMuG5nak7/mBIuhot/sBvNQAywuKuD4N3fv4rPTfgxvGyA==
X-Received: by 2002:a9d:2f69:: with SMTP id h96mr15834204otb.366.1559851921100;
        Thu, 06 Jun 2019 13:12:01 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id a15sm2187otl.20.2019.06.06.13.11.56
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 13:11:56 -0700 (PDT)
Subject: Re: [BISECTED REGRESSION] b43legacy broken on G4 PowerBook
To:     Christoph Hellwig <hch@lst.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190605225059.GA9953@darkstar.musicnaut.iki.fi>
 <dfe6451c93574b61d4bdde4a05c5f8ccf86b31a0.camel@kernel.crashing.org>
 <20190606093149.GA11598@darkstar.musicnaut.iki.fi>
 <d87ac9a7faac0d5522cb496d74afc586410fed9c.camel@kernel.crashing.org>
 <f8df19ffe5b75537045119037459ae9ad4a1de39.camel@kernel.crashing.org>
 <20190606114325.GA7497@lst.de>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <1a9e2b2f-b388-bc13-3b90-9d6b4038073b@lwfinger.net>
Date:   Thu, 6 Jun 2019 15:11:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606114325.GA7497@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/6/19 6:43 AM, Christoph Hellwig wrote:
> On Thu, Jun 06, 2019 at 08:57:49PM +1000, Benjamin Herrenschmidt wrote:
>>> Wow... that's an odd amount. One thing we could possibly do is add code
>>> to limit the amount of RAM when we detect that device....
>>
>> Sent too quickly... I mean that *or* force swiotlb at 30-bits on those systems based
>> on detecting the presence of that device in the device-tree.
> 
> swiotlb doesn't really help you, as these days swiotlb on matters for
> the dma_map* case.  What would help is a ZONE_DMA that covers these
> devices.  No need to do the 24-bit x86 does, but 30-bit would do it.
> 
> WIP patch for testing below:
> 
> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
> index b8286a2013b4..7a367ce87c41 100644
> --- a/arch/powerpc/include/asm/page.h
> +++ b/arch/powerpc/include/asm/page.h
> @@ -319,6 +319,10 @@ struct vm_area_struct;
>   #endif /* __ASSEMBLY__ */
>   #include <asm/slice.h>
>   
> +#if 1 /* XXX: pmac?  dynamic discovery? */
> +#define ARCH_ZONE_DMA_BITS 30
> +#else
>   #define ARCH_ZONE_DMA_BITS 31
> +#endif
>   
>   #endif /* _ASM_POWERPC_PAGE_H */
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index cba29131bccc..2540d3b2588c 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -248,7 +248,8 @@ void __init paging_init(void)
>   	       (long int)((top_of_ram - total_ram) >> 20));
>   
>   #ifdef CONFIG_ZONE_DMA
> -	max_zone_pfns[ZONE_DMA]	= min(max_low_pfn, 0x7fffffffUL >> PAGE_SHIFT);
> +	max_zone_pfns[ZONE_DMA]	= min(max_low_pfn,
> +			((1UL << ARCH_ZONE_DMA_BITS) - 1) >> PAGE_SHIFT);
>   #endif
>   	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
>   #ifdef CONFIG_HIGHMEM
> 

This trial patch failed.

Larry

