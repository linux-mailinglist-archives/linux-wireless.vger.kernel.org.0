Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09844257AFD
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Aug 2020 16:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgHaOAu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Aug 2020 10:00:50 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:54833 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726326AbgHaOAt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Aug 2020 10:00:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598882448; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=FQatIFgZn0c3T9XvzAKsHP5aMuy6FG+3pLIdZknI+pI=; b=s+rjS3WoYF47kZ/sDuR7Eax0jV5fsKn8A2SD3DfvWgM3cTboZsIe/mZ9gdxbTpisyd+xwKkx
 md5fpY3wDttWw9V1ZBkUI9lbGrp2qKdcbq6TnG/rV9u0O2dECDsg9HTsWOCH40aKvvpFAJnX
 f2SZiu5RGaWzOwvCxANl92XfbXs=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f4d026e380a624e4d84bc26 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 31 Aug 2020 14:00:14
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 143A9C433CA; Mon, 31 Aug 2020 14:00:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3BC48C433C6;
        Mon, 31 Aug 2020 14:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3BC48C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     Jia-Ju Bai <baijiaju@tsinghua.edu.cn>, kuba@kernel.org,
        linux-wireless@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH] p54: avoid accessing the data mapped to streaming DMA
References: <20200802132949.26788-1-baijiaju@tsinghua.edu.cn>
        <0b432282-8d52-3004-6648-d97c03cdae28@gmail.com>
        <873649cs4c.fsf@codeaurora.org>
        <a7878a0d-fe97-0c88-3c99-a08dab7be6bc@gmail.com>
Date:   Mon, 31 Aug 2020 17:00:10 +0300
In-Reply-To: <a7878a0d-fe97-0c88-3c99-a08dab7be6bc@gmail.com> (Christian
        Lamparter's message of "Fri, 28 Aug 2020 23:19:09 +0200")
Message-ID: <8736427w5x.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christian Lamparter <chunkeey@gmail.com> writes:

> On 2020-08-26 18:02, Kalle Valo wrote:
>> Christian Lamparter <chunkeey@gmail.com> writes:
>>
>>> On 2020-08-02 15:29, Jia-Ju Bai wrote:
>>>> In p54p_tx(), skb->data is mapped to streaming DMA on line 337:
>>>>     mapping = pci_map_single(..., skb->data, ...);
>>>>
>>>> Then skb->data is accessed on line 349:
>>>>     desc->device_addr = ((struct p54_hdr *)skb->data)->req_id;
>>>>
>>>> This access may cause data inconsistency between CPU cache and hardware.
>>>>
>>>> To fix this problem, ((struct p54_hdr *)skb->data)->req_id is stored in
>>>> a local variable before DMA mapping, and then the driver accesses this
>>>> local variable instead of skb->data.
>>>
>>> Interesting. Please bear with me here. From my understanding, the
>>> streaming direction is set to PCI_DMA_TODEVICE. So is it really
>>> possible for the hardware to interfere with the data without the IOMMU
>>> catching this?
>>
>> Also is there any documentation about this scenario? I would like to
>> understand this better.
>
> I usually rely on the information present in Documentation:
> <https://www.kernel.org/doc/Documentation/DMA-API-HOWTO.txt>
>
> The relevant extract for p54's DMA_TO_DEVICE decision likely comes from:
>
> "For Networking drivers, it's a rather simple affair.  For transmit
> packets, map/unmap them with the DMA_TO_DEVICE direction
> specifier.  For receive packets, just the opposite, map/unmap them
> with the DMA_FROM_DEVICE direction specifier."
>
> "Only streaming mappings specify a direction, consistent mappings
> implicitly have a direction attribute setting of DMA_BIDIRECTIONAL."

This is not very clearly written, I guess it's assumed everyone know
this stuff :)

> But looking around on the Internet, I came across this in "Chapter 15.
> Memory Mapping and DMA" of the Linux Device Drivers, 3rd Edition:
>
> <https://www.oreilly.com/library/view/linux-device-drivers/0596005903/ch15.html>
>
> |Setting up streaming DMA mappings
> |[...]
> |
> |Some important rules apply to streaming DMA mappings:
> | * [...]
> |
> | * Once a buffer has been mapped, it belongs to the device, not the
> |   processor. Until the buffer has been unmapped, the driver should
> not |   touch its contents in any way. Only after dma_unmap_single has
> been |   called is it safe for the driver to access the contents of
> the
> |   buffer (with one exception that we see shortly). Among other things,
> |   this rule implies that a buffer being written to a device cannot be
> |   mapped until it contains all the data to write."
> |
> | [...] (More informative text, but only)
>
> From the sentence "Once a buffer has been mapped, it belongs to the
> device, not the processor". I think that Jia-Ju Bai's patch is doing
> exactly this "by the book".

Yeah, this is much better and understandable. Thanks for checking.

> Therefore, it should be applied and backported:
>
> Cc: <stable@vger.kernel.org>

Ok, I'll add that.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
