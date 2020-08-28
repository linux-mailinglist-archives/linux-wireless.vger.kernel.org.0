Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C07D256266
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Aug 2020 23:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgH1VTT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 17:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgH1VTS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 17:19:18 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E61AC061264
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 14:19:18 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id u1so347720edi.4
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 14:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3Y8bOudtUrTDSSDWKH7J9YA/62v+G5TLDE0YfKsOnUQ=;
        b=p8bQOpoHlERQ4nkNH6ybr4BQ+EXMpV17dq7dlXnSsSIYCy8WQmWt3XDpKeRNEdqUxM
         zChcdjHKmvc1hSRyNzGmoQ93O4eTgsjfBddltlR8JM/a6NoYHowg0V2ZW3JVdBRAc+Ph
         GwBbEFasW8VEhLqZMw31DB7px35QodLqIUFTgOrPBhwtZKIZi5g86QDlhnOYYXlywuir
         viau3tLOEZyRpqtvMFCDkOWIVqz/cKxRMJThlJr7aPIKnn92SeE1sMzevS+i8dR5XqPe
         xZUHjCa3sjYfvOP52/WkuVmZwou/4kcPlK2oPXpZzhmj09woZSUv2HaCZNs/S/t1LA+W
         ArQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3Y8bOudtUrTDSSDWKH7J9YA/62v+G5TLDE0YfKsOnUQ=;
        b=gHbukh+g18GiS5ibOaGOawFZucpQCKi/dD9NU3scTqAxOgSyLrqeUQjPjamw5uMjXA
         FpdEraEbElu6sJOUl4XnvPLhMv7DevC7bHdRZI4pyKoPcBllw0nIVgj4yv251R4BX2g0
         2uLWzhqjShk6lyzrPFm5sTwF69rsUC4Y/gOVWC75TJwQ9yd+Tgv2/y1PgmkUariqol8Z
         ROmHldOB2BloVp3j2/GmnzZv+BProm7/gxC131EePJbZFPepw4/RPIBj+yFqxSANWHGP
         0IHg/E/NeWHv9p2ZH3SM/BHJPjejSBS1haC0gRSyCSDffsxaKzMeyQUk/mReS0jbLbW3
         GCFA==
X-Gm-Message-State: AOAM530p7wlx2I/DgLNp7Rq0jkfw6l8IUm2GbkShTO7XhZQPmUnA2mCk
        TDLYv8lgZKehbBQDKmKu83StL7hWpYA=
X-Google-Smtp-Source: ABdhPJyZV2CbX251XRyJrBITtsqY7qEJ361EL9ob5j4n8KQC5uHSy1Rv19/rwIPJT4C87FW/GKpRAA==
X-Received: by 2002:aa7:cd52:: with SMTP id v18mr682700edw.165.1598649556544;
        Fri, 28 Aug 2020 14:19:16 -0700 (PDT)
Received: from debian64.daheim (p5b0d7429.dip0.t-ipconnect.de. [91.13.116.41])
        by smtp.gmail.com with ESMTPSA id z23sm336318eja.29.2020.08.28.14.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 14:19:15 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1])
        by debian64.daheim with esmtp (Exim 4.94)
        (envelope-from <chunkeey@gmail.com>)
        id 1kBlmE-000gk7-3Q; Fri, 28 Aug 2020 23:19:14 +0200
Subject: Re: [PATCH] p54: avoid accessing the data mapped to streaming DMA
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Jia-Ju Bai <baijiaju@tsinghua.edu.cn>, kuba@kernel.org,
        linux-wireless@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
References: <20200802132949.26788-1-baijiaju@tsinghua.edu.cn>
 <0b432282-8d52-3004-6648-d97c03cdae28@gmail.com>
 <873649cs4c.fsf@codeaurora.org>
From:   Christian Lamparter <chunkeey@gmail.com>
Message-ID: <a7878a0d-fe97-0c88-3c99-a08dab7be6bc@gmail.com>
Date:   Fri, 28 Aug 2020 23:19:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <873649cs4c.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-08-26 18:02, Kalle Valo wrote:
> Christian Lamparter <chunkeey@gmail.com> writes:
> 
>> On 2020-08-02 15:29, Jia-Ju Bai wrote:
>>> In p54p_tx(), skb->data is mapped to streaming DMA on line 337:
>>>     mapping = pci_map_single(..., skb->data, ...);
>>>
>>> Then skb->data is accessed on line 349:
>>>     desc->device_addr = ((struct p54_hdr *)skb->data)->req_id;
>>>
>>> This access may cause data inconsistency between CPU cache and hardware.
>>>
>>> To fix this problem, ((struct p54_hdr *)skb->data)->req_id is stored in
>>> a local variable before DMA mapping, and then the driver accesses this
>>> local variable instead of skb->data.
>>
>> Interesting. Please bear with me here. From my understanding, the
>> streaming direction is set to PCI_DMA_TODEVICE. So is it really
>> possible for the hardware to interfere with the data without the IOMMU
>> catching this?
> 
> Also is there any documentation about this scenario? I would like to
> understand this better.

I usually rely on the information present in Documentation:
<https://www.kernel.org/doc/Documentation/DMA-API-HOWTO.txt>

The relevant extract for p54's DMA_TO_DEVICE decision likely comes from:

"For Networking drivers, it's a rather simple affair.  For transmit
packets, map/unmap them with the DMA_TO_DEVICE direction
specifier.  For receive packets, just the opposite, map/unmap them
with the DMA_FROM_DEVICE direction specifier."

"Only streaming mappings specify a direction, consistent mappings
implicitly have a direction attribute setting of DMA_BIDIRECTIONAL."

But looking around on the Internet, I came across this in "Chapter 15. 
Memory Mapping and DMA" of the Linux Device Drivers, 3rd Edition:

<https://www.oreilly.com/library/view/linux-device-drivers/0596005903/ch15.html>

|Setting up streaming DMA mappings
|[...]
|
|Some important rules apply to streaming DMA mappings:
| * [...]
|
| * Once a buffer has been mapped, it belongs to the device, not the
|   processor. Until the buffer has been unmapped, the driver should not 
|   touch its contents in any way. Only after dma_unmap_single has been 
|   called is it safe for the driver to access the contents of the
|   buffer (with one exception that we see shortly). Among other things,
|   this rule implies that a buffer being written to a device cannot be
|   mapped until it contains all the data to write."
|
| [...] (More informative text, but only)

 From the sentence "Once a buffer has been mapped, it belongs to the 
device, not the processor". I think that Jia-Ju Bai's patch is doing
exactly this "by the book". Therefore, it should be applied and
backported:

Cc: <stable@vger.kernel.org>
Acked-by: Christian Lamparter <chunkeey@gmail.com>

Cheers,
Christian
