Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E80C456B8B
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Nov 2021 09:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbhKSIYP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Nov 2021 03:24:15 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:58784 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234073AbhKSIYP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Nov 2021 03:24:15 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637310074; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=qPRQ8GT1EoqJcWnMwOwKF9zdY1ZKDhNu/XlFvKEQsVU=;
 b=bVszgf6zjEERem4mL6kCgJI7LSkt3ExnIw8ZkV39X64G8GMmqABIZG8wQ9JgzqZfWEM2BheA
 r8hwGplMJebejlvYLE6hvW3s4kz4LwbQyfo6jBlTODBlwarDAzFV2i8wLmhMrOYNrq2zI1aO
 9OdaJgIcjMt+Vp8g+XMnGDApDQ0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 61975e791e1d2f5233a2ab52 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 19 Nov 2021 08:21:13
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BBE35C4360C; Fri, 19 Nov 2021 08:21:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5DEADC4338F;
        Fri, 19 Nov 2021 08:21:12 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 19 Nov 2021 13:51:12 +0530
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     Rob Herring <robh@kernel.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATH v3 1/2] dt: bindings: add new DT entry for ath11k PCI
 device support
In-Reply-To: <1637273394.267065.1841665.nullmailer@robh.at.kernel.org>
References: <1637244892-27267-1-git-send-email-akolli@codeaurora.org>
 <1637273394.267065.1841665.nullmailer@robh.at.kernel.org>
Message-ID: <c53e9299093a315f997c17048872aeff@codeaurora.org>
X-Sender: akolli@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-11-19 03:39, Rob Herring wrote:
> On Thu, 18 Nov 2021 19:44:51 +0530, Anilkumar Kolli wrote:
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
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dts:160.13-31:
> Warning (reg_format): /example-0/pcie0_rp:reg: property has invalid
> length (20 bytes) (#address-cells == 1, #size-cells == 1)
> Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dts:164.17-36:
> Warning (reg_format): /example-0/pcie0_rp/ath11k@0:reg: property has
> invalid length (20 bytes) (#address-cells == 2, #size-cells == 1)
> Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dts:170.13-31:
> Warning (reg_format): /example-0/pcie1_rp:reg: property has invalid
> length (20 bytes) (#address-cells == 1, #size-cells == 1)
> Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dts:174.17-36:
> Warning (reg_format): /example-0/pcie1_rp/ath11k@1:reg: property has
> invalid length (20 bytes) (#address-cells == 2, #size-cells == 1)
> Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dts:138.16-141.11:
> Warning (unit_address_vs_reg): /example-0/memory: node has a reg or
> ranges property, but no unit name
> Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dts:159.28-167.11:
> Warning (unit_address_vs_reg): /example-0/pcie0_rp: node has a reg or
> ranges property, but no unit name
> Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dts:169.28-177.11:
> Warning (unit_address_vs_reg): /example-0/pcie1_rp: node has a reg or
> ranges property, but no unit name
> Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dt.yaml:
> Warning (pci_device_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dt.yaml:
> Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dt.yaml:
> Warning (simple_bus_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dt.yaml:
> Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dt.yaml:
> Warning (spi_bus_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dts:163.32-166.15:
> Warning (avoid_default_addr_size): /example-0/pcie0_rp/ath11k@0:
> Relying on default #address-cells value
> Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dts:163.32-166.15:
> Warning (avoid_default_addr_size): /example-0/pcie0_rp/ath11k@0:
> Relying on default #size-cells value
> Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dts:173.32-176.15:
> Warning (avoid_default_addr_size): /example-0/pcie1_rp/ath11k@1:
> Relying on default #address-cells value
> Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dts:173.32-176.15:
> Warning (avoid_default_addr_size): /example-0/pcie1_rp/ath11k@1:
> Relying on default #size-cells value
> Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dt.yaml:
> Warning (unique_unit_address): Failed prerequisite
> 'avoid_default_addr_size'
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dt.yaml:
> reserved-memory: qcn9074_pcie0@51100000:reg:0: [0, 1360003072, 0,
> 55574528] is too long
> 	From schema: 
> /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dt.yaml:
> reserved-memory: qcn9074_pcie1@54600000:reg:0: [0, 1415577600, 0,
> 55574528] is too long
> 	From schema: 
> /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/1556692
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.

Sure, I will post v2 with fixes.

- Anil.
