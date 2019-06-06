Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD6A37D35
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2019 21:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbfFFT0X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jun 2019 15:26:23 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33345 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729335AbfFFT0X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jun 2019 15:26:23 -0400
Received: by mail-ot1-f65.google.com with SMTP id p4so3098512oti.0;
        Thu, 06 Jun 2019 12:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=//bEoSLNLLHE97BPxRCj2Ov+nlOv5NirkYFgfSUW6IE=;
        b=tfehlKGsfTi1m7hhM0Xjrl6wu/1FJz5YNvaZjnKEboFeHFs3iFSgzJkRWdCSVxUQwK
         VwB5xDNIKJGAxswP++nk/enpOXH6PlOVd/C3I9AfnISZHKR6GWlgLskNPRU1h/bNpnqo
         2JnW7XY7REpC1hYxXeiCTaUPNwn92eJoeTNDKX6EQv0oHvsnJL2QZ0+lZ/t3sGaYOI+/
         7w6bJjmTKe2MNEgBbHPFvZRtjdzrZBQRFh/HYvKkjCyoWw075tiXM0Qx1QVkY2amPY+w
         R/vtWSsTe6/xnFN3nup4WWtmib3FF7B5uNi4TEwcEZ6t+gf7OGkesQQYLrz4/vmTG3kT
         /pIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=//bEoSLNLLHE97BPxRCj2Ov+nlOv5NirkYFgfSUW6IE=;
        b=Er0eb3STw30y/Rei8bkTNeQ6KEByFbisgPBhDfl0ZeM0sT52zO0Dm6l3fH0h1afO14
         IVzNFXNXAeAjOLdhBhkYBOWk8F26DqO/ttsGnmLcQ4PcRHkkFwLO3KNmlGsq8ULU9fHa
         JHLeydcnrfMbDsD7knVNSXwQAq3WQzUmLoxxRe0zO4w2faUsU/+nolM10x4XIrasDTdT
         XkNjFMyR2SesjkrcCQ1Ajjh1SLcXSWnrtZNFhtOVnBLVaxab0EI8k2E32xS4MJJvw67R
         XuwvkMj1vTG6klsmoTgZG4SYN6FhDdMtaTm3KDQ6O9lE2LTgjITjFzqk6c2lriJ0PC6z
         kp9Q==
X-Gm-Message-State: APjAAAWkATjzBd8gafFnxz1eODkQNkDgMZrtw8c8h2cLqYD7Ij4lGq0w
        njmBDjMoMAtKxmo5B4eM4rbkzNyv
X-Google-Smtp-Source: APXvYqwL7j7Huo/G41SF8PlkxfC7vQ8YdiJ33WC5yoMAWg0YVvY404CgtKWoG3ue/NITZ97pzuvy4w==
X-Received: by 2002:a05:6830:1303:: with SMTP id p3mr16235060otq.267.1559849182214;
        Thu, 06 Jun 2019 12:26:22 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id b12sm922890otk.59.2019.06.06.12.26.20
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 12:26:21 -0700 (PDT)
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
Message-ID: <59528af0-f250-f5e7-50c0-0a163ccfa59c@lwfinger.net>
Date:   Thu, 6 Jun 2019 14:26:19 -0500
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

I am generating a test kernel with this patch.

FYI, the "free" command on my machine shows 1.5+ G of memory. That likely means 
I have 2G installed.

I have tested a patched kernel in which b43legacy falls back to a 31-bit DMA 
mask when the 32-bit one failed. That worked, but would likely kill the x86 
version. Let me know if think a fix in the driver rather than the kernel would 
be better. I still need to understand why the same setup works in b43 and fails 
in b43legacy. :(

Larry
