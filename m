Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080AF25344A
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Aug 2020 18:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgHZQDZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Aug 2020 12:03:25 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:37228 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727824AbgHZQDG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Aug 2020 12:03:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598457785; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=yRSvGyXIeEa56Gl4obmhZetlSLOyWU3H8bV2PRS/SEE=; b=YxRK/tLcQf/RokDo/okV9lL1qoc2jinGPHu/hDTBSV/ukiZPi0C/luMK2KX+KZIEA9Xdoz7g
 O6BEDSThB5MLIQEuI8sw3XCEivUNVlk0G+iEsI/PjFQZ9MREm4nJD6e1Jv3D6dg7bSUxKfkE
 ynRabiXoo47VjtU36OfPFtqsjQ0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f4687a79744e5e2834e0149 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 26 Aug 2020 16:02:47
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 75753C43387; Wed, 26 Aug 2020 16:02:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E0EC8C433CA;
        Wed, 26 Aug 2020 16:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E0EC8C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     Jia-Ju Bai <baijiaju@tsinghua.edu.cn>, kuba@kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] p54: avoid accessing the data mapped to streaming DMA
References: <20200802132949.26788-1-baijiaju@tsinghua.edu.cn>
        <0b432282-8d52-3004-6648-d97c03cdae28@gmail.com>
Date:   Wed, 26 Aug 2020 19:02:43 +0300
In-Reply-To: <0b432282-8d52-3004-6648-d97c03cdae28@gmail.com> (Christian
        Lamparter's message of "Tue, 18 Aug 2020 19:27:10 +0200")
Message-ID: <873649cs4c.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christian Lamparter <chunkeey@gmail.com> writes:

> On 2020-08-02 15:29, Jia-Ju Bai wrote:
>> In p54p_tx(), skb->data is mapped to streaming DMA on line 337:
>>    mapping = pci_map_single(..., skb->data, ...);
>>
>> Then skb->data is accessed on line 349:
>>    desc->device_addr = ((struct p54_hdr *)skb->data)->req_id;
>>
>> This access may cause data inconsistency between CPU cache and hardware.
>>
>> To fix this problem, ((struct p54_hdr *)skb->data)->req_id is stored in
>> a local variable before DMA mapping, and then the driver accesses this
>> local variable instead of skb->data.
>
> Interesting. Please bear with me here. From my understanding, the
> streaming direction is set to PCI_DMA_TODEVICE. So is it really
> possible for the hardware to interfere with the data without the IOMMU
> catching this?

Also is there any documentation about this scenario? I would like to
understand this better.

> (That said, patch looks be fine. I'll need to dust off a old PCI PC to
> check this with real hardware, if requested.)

No need to test with real hardware for my sake, but a careful review is
very much appreciated.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
