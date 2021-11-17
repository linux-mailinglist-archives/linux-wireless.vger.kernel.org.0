Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF8B453E75
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Nov 2021 03:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhKQCaN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Nov 2021 21:30:13 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:36631 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhKQCaL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Nov 2021 21:30:11 -0500
Received: by mail-oi1-f179.google.com with SMTP id t23so2966730oiw.3;
        Tue, 16 Nov 2021 18:27:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Gi1zkQUusKr2oOET/+vmdyiUMkS7tjWRTDsmrGSi95U=;
        b=Kfdr5XaByoxO5wofHAhvmaSw5JgJ60yW8+dAWs18OIKstOfisEA+a8iEaRhaXBBkrF
         ZRlPvzI3RL2ddKJI/m2CS0+RtV+Bf830pd9+r1p3itbT7QuiFPUA5OXdJlFxfG0tO5KX
         0oTDUr4rSdaq+g3OX5xSU0K0prKehZ7519QqYKZX1DhLRDWSRm3Gm6u+GZLm0/t9TZk2
         rt16vOJMgtc7IddH8tY8MzXYky9/GrLmHbGXr02xSCJ06tXTSl85xGtmjAtjWuF63wig
         u/YX+wCP9AG8j4eNpjLcPJz31Osy9BOf1He/jIcdHQExo30WZq7DCQlhoqUAxQ+aMoX7
         4qZg==
X-Gm-Message-State: AOAM531iKALeWlGgwcklquLihB4Mx722qiC/hwdPKvbewXvFVuz4zTXq
        8gNttPrPlkUQtuI5tMggmNfbDsv6qg==
X-Google-Smtp-Source: ABdhPJxRWYhsA6sYXwAKKgt94oXi44oGPgwsIh7XEiwG0npDL4m9qIjfjiPVBZop174yqTn2JS8TzQ==
X-Received: by 2002:aca:3b89:: with SMTP id i131mr10965582oia.102.1637116033279;
        Tue, 16 Nov 2021 18:27:13 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o6sm1669635oou.41.2021.11.16.18.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 18:27:12 -0800 (PST)
Received: (nullmailer pid 1207284 invoked by uid 1000);
        Wed, 17 Nov 2021 02:27:10 -0000
From:   Rob Herring <robh@kernel.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <1637082058-6398-1-git-send-email-akolli@codeaurora.org>
References: <1637082058-6398-1-git-send-email-akolli@codeaurora.org>
Subject: Re: [PATCH v2 1/2] dt: bindings: add new DT entry for ath11k PCI device support
Date:   Tue, 16 Nov 2021 20:27:10 -0600
Message-Id: <1637116030.353961.1207283.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 16 Nov 2021 22:30:57 +0530, Anilkumar Kolli wrote:
> Ath11k driver supports PCI devices such as QCN9074/QCA6390.
> Ath11k firmware uses host DDR memory. DT entry is used to reserve
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

See https://patchwork.ozlabs.org/patch/1555958

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

