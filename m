Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9721D44A600
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Nov 2021 06:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbhKIFHB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Nov 2021 00:07:01 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:45438 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230238AbhKIFHA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Nov 2021 00:07:00 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636434255; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=EktT4GpDSMg7u7QNcUdJTd4WqshYz7T+uzhoJXta5LM=;
 b=ZHCzHSPitDtDzKh7v/cIv/a9KxlHkdPrz2v/gjIQK7Rq5BaRf80jLkAKrbQP153mIAkeVJuH
 Fqc3SZgLcAXawhjV+veeTlF+WnQeglqAie5e0fxbS9PzMTi4008+3/kJlIJWvIvuFwzS+Fkf
 CEUTTBB6sYiZ0fTQKWvd7lIYUx0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 618a013f6b778b5a19ff7d7c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Nov 2021 05:03:59
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7F040C43617; Tue,  9 Nov 2021 05:03:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A80D4C4338F;
        Tue,  9 Nov 2021 05:03:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 09 Nov 2021 10:33:58 +0530
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     Rob Herring <robh@kernel.org>, manivannan.sadhasivam@linaro.org
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, mhi@lists.linux.dev
Subject: Re: [PATCH 1/2] dt: bindings: add new DT entry for ath11k PCI device
 support
In-Reply-To: <YYBPd+Z/dA/pTReo@robh.at.kernel.org>
References: <1635175648-23491-1-git-send-email-akolli@codeaurora.org>
 <YYBPd+Z/dA/pTReo@robh.at.kernel.org>
Message-ID: <b142a4850d9cbc3bb451a78b488688cc@codeaurora.org>
X-Sender: akolli@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-11-02 02:05, Rob Herring wrote:
> On Mon, Oct 25, 2021 at 08:57:27PM +0530, Anilkumar Kolli wrote:
>> Ath11k driver supports PCI devices such as QCN9074/QCA6390.
>> Ath11k firmware uses host DDR memory, DT entry is used to reserve
>> these host DDR memory regions, send these memory base
>> addresses using DT entries.
>> 
>> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
>> ---
>>  .../bindings/net/wireless/qcom,ath11k.yaml         | 38 
>> ++++++++++++++++++++++
>>  1 file changed, 38 insertions(+)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml 
>> b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
>> index 5ac9616c9239..c7e6612e949c 100644
>> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
>> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
>> @@ -19,6 +19,10 @@ description: |
>>    These devices use HOST DDR memory, HOST DDR memory can be reserved
>>    and send to ath11k driver from DT.
>> 
>> +  ATH11K supports PCI devices like QCA6390,QCN9074.
>> +  These devices use host DDR memory, host DDR memory can be reserved
>> +  and send to ath11k driver from DT.
>> +
>>  properties:
>>    compatible:
>>      enum:
>> @@ -177,6 +181,29 @@ properties:
>>      description:
>>        HOST DDR end address.
>> 
>> +  qcom,base-addr:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      Host DDR base address for firmware. QCN9074 firmware uses 45 MB 
>> of host
>> +      DDR memory in mode-0 and 15 MB of host DDR memory in mode-2.
>> +
>> +  qcom,caldb-addr:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      Host DDR address to store CALDB. CALDB is calibration data base
>> +      for WLAN channel and tx power.
>> +
> 
> Use /reserved-memory entries for these.
> 

Sure.

>> +  qcom,start-addr:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      Host DDR start address. For example on x86 it is 0x0,
>> +      on IPQ8074 it is 0x41000000.
>> +
>> +  qcom,end-addr:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      Host DDR end address.
> 
> Nak. I don't know what you are doing with these 2, but it's wrong.
> 

The DDR start address and end address are sent to MHI control bus,
For x86 platform code snip in ath11k/mhi.c

         mhi_ctrl->iova_start = 0;
         mhi_ctrl->iova_stop = 0xffffffff;

Similarly for ARM platfroms, send DDR addresses from DT entry.

Thanks
Anil
