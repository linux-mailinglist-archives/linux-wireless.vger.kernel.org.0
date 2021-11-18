Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1874245663E
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Nov 2021 00:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbhKRXOu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 18:14:50 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:35499 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbhKRXOu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 18:14:50 -0500
Received: by mail-oi1-f174.google.com with SMTP id m6so17824160oim.2;
        Thu, 18 Nov 2021 15:11:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6myScuq3nOr20A1Ksiuor/A5GOiLxa2QAT4GCP9Aq+0=;
        b=pXgu9UdrPpe5ind4vJwdMyRaw2uiHurjESbjOJZ8nKPVZ3uUWR1A986lXJ1R23xtlN
         B5c8oieu+fMO9OrcPXxaEOU6FeZfb8M5V4kbCV1ysdzpn4AN+fRmDlJrnuBFZ0z29WEb
         2azLw6FzEBBFJ+4tT0xCLd13T/SY3LTpZ2Fz4Y+gToqwiL2MnLNmS2stezGvboRUEj9i
         uu6vhrbBdaZD63MSK9xDazXsFmVKoECCB237yhL3m1mu81vMZWxnJrfeWjCWqIZVQnr7
         LbziN0HGMPT2Rn0HAhY9DbuaVnGovBq9ko3BGenFxrcYFa6fwu8Fpi7AfS75AYq0H3m5
         PoSw==
X-Gm-Message-State: AOAM5323q6FshUMHVT91gkpDyWuc1NNuYQvtzfq8ZLPDCnPKip/QvZkJ
        y/hxN42gZZdGFnjn9MQKXw==
X-Google-Smtp-Source: ABdhPJwxQ48ocNKAXi7TijyVJEySn66JtgRGmKvzqJt1ZKcDAHTqHqWYMJK5dMvuEoa0aB95rK+6Kw==
X-Received: by 2002:aca:4307:: with SMTP id q7mr686998oia.3.1637277109242;
        Thu, 18 Nov 2021 15:11:49 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o6sm218385oou.41.2021.11.18.15.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 15:11:48 -0800 (PST)
Received: (nullmailer pid 1944164 invoked by uid 1000);
        Thu, 18 Nov 2021 23:11:47 -0000
Date:   Thu, 18 Nov 2021 17:11:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATH v3 1/2] dt: bindings: add new DT entry for ath11k PCI
 device support
Message-ID: <YZbds1DgmwbFPQdM@robh.at.kernel.org>
References: <1637244892-27267-1-git-send-email-akolli@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1637244892-27267-1-git-send-email-akolli@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Nov 18, 2021 at 07:44:51PM +0530, Anilkumar Kolli wrote:
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
> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
> index 85c2f699d602..5a8994f6cb10 100644
> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
> @@ -150,6 +150,12 @@ properties:
>        string to uniquely identify variant of the calibration data in the
>        board-2.bin for designs with colliding bus and device specific ids
>  
> +  memory-region:
> +    maxItems: 1
> +    description:
> +      phandle to a node describing reserved memory (System RAM memory)
> +      used by ath11k firmware (see bindings/reserved-memory/reserved-memory.txt)
> +
>  required:
>    - compatible
>    - reg
> @@ -279,3 +285,45 @@ examples:
>                            "tcl2host-status-ring";
>          qcom,rproc = <&q6v5_wcss>;
>      };
> +

This looks like a separate example. Please split to its own entry.

> +    memory {
> +        device_type = "memory";
> +        reg = <0x0 0x40000000 0x0 0x20000000>;
> +    };

Outside the scope of what's needed in the example.

> +
> +    reserved-memory {
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges;
> +
> +        qcn9074_pcie0: qcn9074_pcie0@51100000 {
> +            no-map;
> +            reg = <0x0 0x51100000 0x0 0x03500000>;
> +        };
> +
> +        qcn9074_pcie1: qcn9074_pcie1@54600000 {
> +            no-map;
> +            reg = <0x0 0x54600000 0x0 0x03500000>;
> +        };
> +    };

As is this really.

> +
> +    pcie0_rp: pcie0_rp {
> +        reg = <0 0 0 0 0>;

This isn't a valid PCI bus binding.

> +
> +        status = "ok";

Don't need status.

> +        ath11k_0: ath11k@0 {

wifi@0

> +            reg = <0 0 0 0 0 >;
> +            memory-region = <&qcn9074_pcie0>;
> +        };
> +    };
> +
> +    pcie1_rp: pcie1_rp {
> +        reg = <0 0 0 0 0>;
> +
> +        status = "ok";
> +        ath11k_1: ath11k@1 {
> +            reg = <0 0 0 0 0 >;

unit-address and reg don't match.

Why do we need 2 nodes in the first place?

> +            memory-region = <&qcn9074_pcie1>;
> +        };
> +    };
> +
> -- 
> 2.7.4
> 
> 
