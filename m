Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4027B456578
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 23:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhKRWM7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 17:12:59 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:37584 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhKRWM6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 17:12:58 -0500
Received: by mail-ot1-f42.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so13514716otg.4;
        Thu, 18 Nov 2021 14:09:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=wyaKU21KsPhRsL8O46dW6nI8PJL6dJM95EyvFAPc4RU=;
        b=6zo4c4AJUEuEbSKZ9gHJR1YxdEl09vxvOSNmAnplChKLPu1htNsgEV+Naqyed714zK
         Uui4LCFqlpEguVnUn2HVRU0rtAiJEE2BHicunJ2EH+LudKJE2gIwQrLbC3/sFunr7T1t
         eXHMipWVZlm8rhuOqv5lLvw/P22QmEOwnZ0Q0PQul0mj2NyqKyh5x2Ux4i1vAVmw/oEt
         VU39rjoAhw8zDjmmKkcbNlZ24bLUsJ0VLuJfgBQaiEkbLrT7cbygmVLOhK344zZSE+Fm
         RvNxU5qzLSRX/TJlYxJq4+omBaOPYFAZFwU0nk0sjCcEffcQ8oolxY3NpNA0vFJd9c3e
         hRfg==
X-Gm-Message-State: AOAM533kz6GVuMF70l+2eEAimzN0iOLM6lWW79iOy7NSrJqF1d2dnY9D
        pCSrYBJ6E7zBKVzV2+m0Uw==
X-Google-Smtp-Source: ABdhPJzhb/Rj2EsCodTBxBTM+tZP3sxLb26m+PQkfobY+xof43b9OGeWF22/ZARCzu17SIqhtH8YZQ==
X-Received: by 2002:a9d:4f0e:: with SMTP id d14mr490282otl.137.1637273397095;
        Thu, 18 Nov 2021 14:09:57 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x28sm220382ote.24.2021.11.18.14.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 14:09:56 -0800 (PST)
Received: (nullmailer pid 1841666 invoked by uid 1000);
        Thu, 18 Nov 2021 22:09:54 -0000
From:   Rob Herring <robh@kernel.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <1637244892-27267-1-git-send-email-akolli@codeaurora.org>
References: <1637244892-27267-1-git-send-email-akolli@codeaurora.org>
Subject: Re: [PATH v3 1/2] dt: bindings: add new DT entry for ath11k PCI device support
Date:   Thu, 18 Nov 2021 16:09:54 -0600
Message-Id: <1637273394.267065.1841665.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 18 Nov 2021 19:44:51 +0530, Anilkumar Kolli wrote:
> Ath11k driver supports PCI devices such as QCN9074/QCA6390.
> Ath11k firmware uses host DDR memory, DT entry is used to reserve
> these host DDR memory regions, send these memory base
> addresses using DT entries.
> 
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
> ---
> V2:
>   - Use reserved-memory (Rob)
> 
>  .../bindings/net/wireless/qcom,ath11k.yaml         | 48 ++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dts:160.13-31: Warning (reg_format): /example-0/pcie0_rp:reg: property has invalid length (20 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dts:164.17-36: Warning (reg_format): /example-0/pcie0_rp/ath11k@0:reg: property has invalid length (20 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dts:170.13-31: Warning (reg_format): /example-0/pcie1_rp:reg: property has invalid length (20 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dts:174.17-36: Warning (reg_format): /example-0/pcie1_rp/ath11k@1:reg: property has invalid length (20 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dts:138.16-141.11: Warning (unit_address_vs_reg): /example-0/memory: node has a reg or ranges property, but no unit name
Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dts:159.28-167.11: Warning (unit_address_vs_reg): /example-0/pcie0_rp: node has a reg or ranges property, but no unit name
Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dts:169.28-177.11: Warning (unit_address_vs_reg): /example-0/pcie1_rp: node has a reg or ranges property, but no unit name
Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dt.yaml: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dt.yaml: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dts:163.32-166.15: Warning (avoid_default_addr_size): /example-0/pcie0_rp/ath11k@0: Relying on default #address-cells value
Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dts:163.32-166.15: Warning (avoid_default_addr_size): /example-0/pcie0_rp/ath11k@0: Relying on default #size-cells value
Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dts:173.32-176.15: Warning (avoid_default_addr_size): /example-0/pcie1_rp/ath11k@1: Relying on default #address-cells value
Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dts:173.32-176.15: Warning (avoid_default_addr_size): /example-0/pcie1_rp/ath11k@1: Relying on default #size-cells value
Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dt.yaml: Warning (unique_unit_address): Failed prerequisite 'avoid_default_addr_size'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dt.yaml: reserved-memory: qcn9074_pcie0@51100000:reg:0: [0, 1360003072, 0, 55574528] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.example.dt.yaml: reserved-memory: qcn9074_pcie1@54600000:reg:0: [0, 1415577600, 0, 55574528] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1556692

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

