Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F25456BC7
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Nov 2021 09:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbhKSIoa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Nov 2021 03:44:30 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:29440 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229830AbhKSIoa (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Nov 2021 03:44:30 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637311288; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=TJDfJQzNs0P8ZTjwfGv8Cr99h3avRBPf0A8lWovZM4o=;
 b=uFK0SbXcQb43WDTrNsF5NWolOSWdHCMOvyhQFVRra481Aqu62yJPW4L/0bWKLcbfNEtiBmWF
 PQAoBD9RHABQCyBM1xv/PtMZX30O+y4EWngCOuWdbpQH/FtFExK8sZpOv8GgiQDHo6/SLRpa
 QObY2upj3HABXi/bWpHF366vEkc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 61976338665450d43aefceed (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 19 Nov 2021 08:41:28
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 99EF1C4360C; Fri, 19 Nov 2021 08:41:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D2BEAC4338F;
        Fri, 19 Nov 2021 08:41:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 19 Nov 2021 14:11:26 +0530
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     Rob Herring <robh@kernel.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATH v3 1/2] dt: bindings: add new DT entry for ath11k PCI
 device support
In-Reply-To: <YZbds1DgmwbFPQdM@robh.at.kernel.org>
References: <1637244892-27267-1-git-send-email-akolli@codeaurora.org>
 <YZbds1DgmwbFPQdM@robh.at.kernel.org>
Message-ID: <f71ed4a924adcc026c6b0f29809f3b7d@codeaurora.org>
X-Sender: akolli@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-11-19 04:41, Rob Herring wrote:
> On Thu, Nov 18, 2021 at 07:44:51PM +0530, Anilkumar Kolli wrote:
>> Ath11k driver supports PCI devices such as QCN9074/QCA6390.
>> Ath11k firmware uses host DDR memory, DT entry is used to reserve
>> these host DDR memory regions, send these memory base
>> addresses using DT entries.
>> 
>> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
>> ---
>> V2:
>>   - Use reserved-memory (Rob)
>> 
>>  .../bindings/net/wireless/qcom,ath11k.yaml         | 48 
>> ++++++++++++++++++++++
>>  1 file changed, 48 insertions(+)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml 
>> b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
>> index 85c2f699d602..5a8994f6cb10 100644
>> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
>> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
>> @@ -150,6 +150,12 @@ properties:
>>        string to uniquely identify variant of the calibration data in 
>> the
>>        board-2.bin for designs with colliding bus and device specific 
>> ids
>> 
>> +  memory-region:
>> +    maxItems: 1
>> +    description:
>> +      phandle to a node describing reserved memory (System RAM 
>> memory)
>> +      used by ath11k firmware (see 
>> bindings/reserved-memory/reserved-memory.txt)
>> +
>>  required:
>>    - compatible
>>    - reg
>> @@ -279,3 +285,45 @@ examples:
>>                            "tcl2host-status-ring";
>>          qcom,rproc = <&q6v5_wcss>;
>>      };
>> +
> 
> This looks like a separate example. Please split to its own entry.
> 
>> +    memory {
>> +        device_type = "memory";
>> +        reg = <0x0 0x40000000 0x0 0x20000000>;
>> +    };
> 
> Outside the scope of what's needed in the example.
> 
Yes, memory entry is available in 
"arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi"
Since its used in ath11k patch, added example.
I will remove in next version.

>> +
>> +    reserved-memory {
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +        ranges;
>> +
>> +        qcn9074_pcie0: qcn9074_pcie0@51100000 {
>> +            no-map;
>> +            reg = <0x0 0x51100000 0x0 0x03500000>;
>> +        };
>> +
>> +        qcn9074_pcie1: qcn9074_pcie1@54600000 {
>> +            no-map;
>> +            reg = <0x0 0x54600000 0x0 0x03500000>;
>> +        };
>> +    };
> 
> As is this really.
> 
ipq8074-hk10.dtsi board supports two PCI bus and QCN9074 on each PCI.
So added two separate entries to reserves memory for each QCN9074.

>> +
>> +    pcie0_rp: pcie0_rp {
>> +        reg = <0 0 0 0 0>;
> 
> This isn't a valid PCI bus binding.
> 
Got it, let me rework in next patch.

>> +
>> +        status = "ok";
> 
> Don't need status.

Sure, will remove in next patch.

> 
>> +        ath11k_0: ath11k@0 {
> 
> wifi@0
> 
>> +            reg = <0 0 0 0 0 >;
>> +            memory-region = <&qcn9074_pcie0>;
>> +        };
>> +    };
>> +
>> +    pcie1_rp: pcie1_rp {
>> +        reg = <0 0 0 0 0>;
>> +
>> +        status = "ok";
>> +        ath11k_1: ath11k@1 {
>> +            reg = <0 0 0 0 0 >;
> 
> unit-address and reg don't match.
> 
will update in next patch.

> Why do we need 2 nodes in the first place?
> 
ipq8074-hk10.dtsi board supports two PCI bus and QCN9074 on each PCI.
So added two separate entries to reserves memory for each QCN9074.

Since its example, Shall I remove one ?

>> +            memory-region = <&qcn9074_pcie1>;
>> +        };
>> +    };
>> +
>> --
>> 2.7.4
>> 

- Anil.
