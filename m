Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694F94F1A87
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Apr 2022 23:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379021AbiDDVSe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Apr 2022 17:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380201AbiDDTNi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Apr 2022 15:13:38 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0706377DF
        for <linux-wireless@vger.kernel.org>; Mon,  4 Apr 2022 12:11:40 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id s72so9127534pgc.5
        for <linux-wireless@vger.kernel.org>; Mon, 04 Apr 2022 12:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wCGVNtLEWmCyfI5a4PfymuQKffpyxq9IQOWJuZ5sL7c=;
        b=gS4xawpZl+3efXNTzmi3SvQ+CzRbUnrQSV++0eM+9Tanlz1zo7SpOeFxxXSgoLd2Ax
         uCmPjIl+wb0WYXD0m7A/j1bMckUlxPX8NL6MuJvsGKmnnfNjHe6OY7fFGvf1hyT3ZrCE
         6qLE7C9iSB8xdjA4OoTtnPq3htya4sgvex8Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wCGVNtLEWmCyfI5a4PfymuQKffpyxq9IQOWJuZ5sL7c=;
        b=IDCNA27p4ACv0nE3tJKkS5SionFx2KQBKeTBLvV5OTU0iWNi1p0raZ1QFOdPkuHlHj
         dngUCLrnF17yobOf0DRuAy4bVDoAeirZYwVEDwMtyypUiDAA0oQoUQJRoDLM9tgJNyDs
         Y0xA62JHrTFExi0+HJjk0WIjcjf/1zUpjCWloNLo3/XQKnaGvNEqF3szs8uU9TDlIcE1
         Q6M/+vGIIbhOcUonpZBSCPPLQfQPD+BD1RyhqQNvNKBV4lmdBnajIjgM1wLzFwC6mpJN
         d4UNKlvgov5YeEnm5wPAq3wbCqOcgk/OxboVIjal7jkLAltS16WUvSaEWHqH5mQTgo25
         nCUw==
X-Gm-Message-State: AOAM530NfCe6LeYzhJQIJaRW1SYAlzYyed0Bm4EUjoD9YOEmINI5qla+
        GvxSZCDWR5cOgMtubop5svQCZA==
X-Google-Smtp-Source: ABdhPJyrYKBdDbbkbzm8KgBFKQFfdxu1s6wp+KFO3lp6DYXpDto0mIfEWZegh6OA+itAggofNmkUSQ==
X-Received: by 2002:a05:6a00:4198:b0:4fa:8591:5456 with SMTP id ca24-20020a056a00419800b004fa85915456mr1159753pfb.81.1649099500282;
        Mon, 04 Apr 2022 12:11:40 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:1ebc:cb71:2a38:38db])
        by smtp.gmail.com with UTF8SMTPSA id p10-20020a056a000b4a00b004fd9a6a2a39sm13475785pfo.184.2022.04.04.12.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 12:11:39 -0700 (PDT)
Date:   Mon, 4 Apr 2022 12:11:38 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH v3 01/12] dt: bindings: net: add bindings of WCN6750 for
 ath11k
Message-ID: <YktC6ksYZIEVNsIF@google.com>
References: <20220328094838.14093-1-quic_mpubbise@quicinc.com>
 <20220328094838.14093-2-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220328094838.14093-2-quic_mpubbise@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Mar 28, 2022 at 03:18:27PM +0530, Manikanta Pubbisetty wrote:
> WCN6750 is the WLAN chip on Qualcomm Snapdragon SoC SC7280;
> Though being a PCIe based solution, it is not attached to
> the APSS processor (Application Processor SubSystem), it is
> instead attached to another tiny processor called WPSS Q6
> processor (Wireless Processor SubSystem) on the SC7280 MSM,
> where the WLAN firmware runs, and it is the WLAN firmware
> running on the Q6 processor which enumerates WCN6750, as a
> result APPS processor would never know such a device being
> present in the system and would not detect the WCN6750
> hardware unless and otherwise WCN6750 is registered as a
> platform device. This is the reason behind adding WCN6750
> WLAN node in the device tree.
> 
> Add WCN6750 wireless driver support, its based on ath11k driver.
> 
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/net/wireless/qcom,ath11k.yaml    | 361 ++++++++++++------
>  1 file changed, 252 insertions(+), 109 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
> index cdf7b873b419..67104d69fd72 100644
> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
> @@ -20,120 +20,17 @@ properties:
>      enum:
>        - qcom,ipq8074-wifi
>        - qcom,ipq6018-wifi
> +      - qcom,wcn6750-wifi
>  
>    reg:
>      maxItems: 1
>  
>    interrupts:
> -    items:
> -      - description: misc-pulse1 interrupt events
> -      - description: misc-latch interrupt events
> -      - description: sw exception interrupt events
> -      - description: watchdog interrupt events
> -      - description: interrupt event for ring CE0
> -      - description: interrupt event for ring CE1
> -      - description: interrupt event for ring CE2
> -      - description: interrupt event for ring CE3
> -      - description: interrupt event for ring CE4
> -      - description: interrupt event for ring CE5
> -      - description: interrupt event for ring CE6
> -      - description: interrupt event for ring CE7
> -      - description: interrupt event for ring CE8
> -      - description: interrupt event for ring CE9
> -      - description: interrupt event for ring CE10
> -      - description: interrupt event for ring CE11
> -      - description: interrupt event for ring host2wbm-desc-feed
> -      - description: interrupt event for ring host2reo-re-injection
> -      - description: interrupt event for ring host2reo-command
> -      - description: interrupt event for ring host2rxdma-monitor-ring3
> -      - description: interrupt event for ring host2rxdma-monitor-ring2
> -      - description: interrupt event for ring host2rxdma-monitor-ring1
> -      - description: interrupt event for ring reo2ost-exception
> -      - description: interrupt event for ring wbm2host-rx-release
> -      - description: interrupt event for ring reo2host-status
> -      - description: interrupt event for ring reo2host-destination-ring4
> -      - description: interrupt event for ring reo2host-destination-ring3
> -      - description: interrupt event for ring reo2host-destination-ring2
> -      - description: interrupt event for ring reo2host-destination-ring1
> -      - description: interrupt event for ring rxdma2host-monitor-destination-mac3
> -      - description: interrupt event for ring rxdma2host-monitor-destination-mac2
> -      - description: interrupt event for ring rxdma2host-monitor-destination-mac1
> -      - description: interrupt event for ring ppdu-end-interrupts-mac3
> -      - description: interrupt event for ring ppdu-end-interrupts-mac2
> -      - description: interrupt event for ring ppdu-end-interrupts-mac1
> -      - description: interrupt event for ring rxdma2host-monitor-status-ring-mac3
> -      - description: interrupt event for ring rxdma2host-monitor-status-ring-mac2
> -      - description: interrupt event for ring rxdma2host-monitor-status-ring-mac1
> -      - description: interrupt event for ring host2rxdma-host-buf-ring-mac3
> -      - description: interrupt event for ring host2rxdma-host-buf-ring-mac2
> -      - description: interrupt event for ring host2rxdma-host-buf-ring-mac1
> -      - description: interrupt event for ring rxdma2host-destination-ring-mac3
> -      - description: interrupt event for ring rxdma2host-destination-ring-mac2
> -      - description: interrupt event for ring rxdma2host-destination-ring-mac1
> -      - description: interrupt event for ring host2tcl-input-ring4
> -      - description: interrupt event for ring host2tcl-input-ring3
> -      - description: interrupt event for ring host2tcl-input-ring2
> -      - description: interrupt event for ring host2tcl-input-ring1
> -      - description: interrupt event for ring wbm2host-tx-completions-ring3
> -      - description: interrupt event for ring wbm2host-tx-completions-ring2
> -      - description: interrupt event for ring wbm2host-tx-completions-ring1
> -      - description: interrupt event for ring tcl2host-status-ring
> -
> +    minItems: 32
> +    maxItems: 52
>  
>    interrupt-names:
> -    items:
> -      - const: misc-pulse1
> -      - const: misc-latch
> -      - const: sw-exception
> -      - const: watchdog
> -      - const: ce0
> -      - const: ce1
> -      - const: ce2
> -      - const: ce3
> -      - const: ce4
> -      - const: ce5
> -      - const: ce6
> -      - const: ce7
> -      - const: ce8
> -      - const: ce9
> -      - const: ce10
> -      - const: ce11
> -      - const: host2wbm-desc-feed
> -      - const: host2reo-re-injection
> -      - const: host2reo-command
> -      - const: host2rxdma-monitor-ring3
> -      - const: host2rxdma-monitor-ring2
> -      - const: host2rxdma-monitor-ring1
> -      - const: reo2ost-exception
> -      - const: wbm2host-rx-release
> -      - const: reo2host-status
> -      - const: reo2host-destination-ring4
> -      - const: reo2host-destination-ring3
> -      - const: reo2host-destination-ring2
> -      - const: reo2host-destination-ring1
> -      - const: rxdma2host-monitor-destination-mac3
> -      - const: rxdma2host-monitor-destination-mac2
> -      - const: rxdma2host-monitor-destination-mac1
> -      - const: ppdu-end-interrupts-mac3
> -      - const: ppdu-end-interrupts-mac2
> -      - const: ppdu-end-interrupts-mac1
> -      - const: rxdma2host-monitor-status-ring-mac3
> -      - const: rxdma2host-monitor-status-ring-mac2
> -      - const: rxdma2host-monitor-status-ring-mac1
> -      - const: host2rxdma-host-buf-ring-mac3
> -      - const: host2rxdma-host-buf-ring-mac2
> -      - const: host2rxdma-host-buf-ring-mac1
> -      - const: rxdma2host-destination-ring-mac3
> -      - const: rxdma2host-destination-ring-mac2
> -      - const: rxdma2host-destination-ring-mac1
> -      - const: host2tcl-input-ring4
> -      - const: host2tcl-input-ring3
> -      - const: host2tcl-input-ring2
> -      - const: host2tcl-input-ring1
> -      - const: wbm2host-tx-completions-ring3
> -      - const: wbm2host-tx-completions-ring2
> -      - const: wbm2host-tx-completions-ring1
> -      - const: tcl2host-status-ring
> +    maxItems: 52
>  
>    qcom,rproc:
>      $ref: /schemas/types.yaml#/definitions/phandle
> @@ -151,20 +48,205 @@ properties:
>        board-2.bin for designs with colliding bus and device specific ids
>  
>    memory-region:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
>      description:
>        phandle to a node describing reserved memory (System RAM memory)
>        used by ath11k firmware (see bindings/reserved-memory/reserved-memory.txt)
>  
> +  iommus:
> +    minItems: 1
> +    maxItems: 2
> +
> +  wifi-firmware:
> +    type: object
> +    description: |
> +      WCN6750 wifi node can contain one optional firmware subnode.
> +      Firmware subnode is needed when the platform does not have Tustzone.

s/Tustzone/Trustzone/

> +    required:
> +      - iommus
> +
>  required:
>    - compatible
>    - reg
>    - interrupts
> -  - interrupt-names
>    - qcom,rproc
>  
>  additionalProperties: false
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,ipq8074-wifi
> +              - qcom,ipq6018-wifi
> +    then:
> +      properties:
> +        interrupts:
> +          items:
> +            - description: misc-pulse1 interrupt events
> +            - description: misc-latch interrupt events
> +            - description: sw exception interrupt events
> +            - description: watchdog interrupt events
> +            - description: interrupt event for ring CE0
> +            - description: interrupt event for ring CE1
> +            - description: interrupt event for ring CE2
> +            - description: interrupt event for ring CE3
> +            - description: interrupt event for ring CE4
> +            - description: interrupt event for ring CE5
> +            - description: interrupt event for ring CE6
> +            - description: interrupt event for ring CE7
> +            - description: interrupt event for ring CE8
> +            - description: interrupt event for ring CE9
> +            - description: interrupt event for ring CE10
> +            - description: interrupt event for ring CE11
> +            - description: interrupt event for ring host2wbm-desc-feed
> +            - description: interrupt event for ring host2reo-re-injection
> +            - description: interrupt event for ring host2reo-command
> +            - description: interrupt event for ring host2rxdma-monitor-ring3
> +            - description: interrupt event for ring host2rxdma-monitor-ring2
> +            - description: interrupt event for ring host2rxdma-monitor-ring1
> +            - description: interrupt event for ring reo2ost-exception
> +            - description: interrupt event for ring wbm2host-rx-release
> +            - description: interrupt event for ring reo2host-status
> +            - description: interrupt event for ring reo2host-destination-ring4
> +            - description: interrupt event for ring reo2host-destination-ring3
> +            - description: interrupt event for ring reo2host-destination-ring2
> +            - description: interrupt event for ring reo2host-destination-ring1
> +            - description: interrupt event for ring rxdma2host-monitor-destination-mac3
> +            - description: interrupt event for ring rxdma2host-monitor-destination-mac2
> +            - description: interrupt event for ring rxdma2host-monitor-destination-mac1
> +            - description: interrupt event for ring ppdu-end-interrupts-mac3
> +            - description: interrupt event for ring ppdu-end-interrupts-mac2
> +            - description: interrupt event for ring ppdu-end-interrupts-mac1
> +            - description: interrupt event for ring rxdma2host-monitor-status-ring-mac3
> +            - description: interrupt event for ring rxdma2host-monitor-status-ring-mac2
> +            - description: interrupt event for ring rxdma2host-monitor-status-ring-mac1
> +            - description: interrupt event for ring host2rxdma-host-buf-ring-mac3
> +            - description: interrupt event for ring host2rxdma-host-buf-ring-mac2
> +            - description: interrupt event for ring host2rxdma-host-buf-ring-mac1
> +            - description: interrupt event for ring rxdma2host-destination-ring-mac3
> +            - description: interrupt event for ring rxdma2host-destination-ring-mac2
> +            - description: interrupt event for ring rxdma2host-destination-ring-mac1
> +            - description: interrupt event for ring host2tcl-input-ring4
> +            - description: interrupt event for ring host2tcl-input-ring3
> +            - description: interrupt event for ring host2tcl-input-ring2
> +            - description: interrupt event for ring host2tcl-input-ring1
> +            - description: interrupt event for ring wbm2host-tx-completions-ring3
> +            - description: interrupt event for ring wbm2host-tx-completions-ring2
> +            - description: interrupt event for ring wbm2host-tx-completions-ring1
> +            - description: interrupt event for ring tcl2host-status-ring
> +        interrupt-names:
> +          items:
> +            - const: misc-pulse1
> +            - const: misc-latch
> +            - const: sw-exception
> +            - const: watchdog
> +            - const: ce0
> +            - const: ce1
> +            - const: ce2
> +            - const: ce3
> +            - const: ce4
> +            - const: ce5
> +            - const: ce6
> +            - const: ce7
> +            - const: ce8
> +            - const: ce9
> +            - const: ce10
> +            - const: ce11
> +            - const: host2wbm-desc-feed
> +            - const: host2reo-re-injection
> +            - const: host2reo-command
> +            - const: host2rxdma-monitor-ring3
> +            - const: host2rxdma-monitor-ring2
> +            - const: host2rxdma-monitor-ring1
> +            - const: reo2ost-exception
> +            - const: wbm2host-rx-release
> +            - const: reo2host-status
> +            - const: reo2host-destination-ring4
> +            - const: reo2host-destination-ring3
> +            - const: reo2host-destination-ring2
> +            - const: reo2host-destination-ring1
> +            - const: rxdma2host-monitor-destination-mac3
> +            - const: rxdma2host-monitor-destination-mac2
> +            - const: rxdma2host-monitor-destination-mac1
> +            - const: ppdu-end-interrupts-mac3
> +            - const: ppdu-end-interrupts-mac2
> +            - const: ppdu-end-interrupts-mac1
> +            - const: rxdma2host-monitor-status-ring-mac3
> +            - const: rxdma2host-monitor-status-ring-mac2
> +            - const: rxdma2host-monitor-status-ring-mac1
> +            - const: host2rxdma-host-buf-ring-mac3
> +            - const: host2rxdma-host-buf-ring-mac2
> +            - const: host2rxdma-host-buf-ring-mac1
> +            - const: rxdma2host-destination-ring-mac3
> +            - const: rxdma2host-destination-ring-mac2
> +            - const: rxdma2host-destination-ring-mac1
> +            - const: host2tcl-input-ring4
> +            - const: host2tcl-input-ring3
> +            - const: host2tcl-input-ring2
> +            - const: host2tcl-input-ring1
> +            - const: wbm2host-tx-completions-ring3
> +            - const: wbm2host-tx-completions-ring2
> +            - const: wbm2host-tx-completions-ring1
> +            - const: tcl2host-status-ring
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,ipq8074-wifi
> +              - qcom,ipq6018-wifi
> +    then:
> +      required:
> +        - interrupt-names
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,wcn6750-wifi
> +    then:
> +      properties:
> +        interrupts:
> +          items:
> +            - description: interrupt event for ring CE1
> +            - description: interrupt event for ring CE2
> +            - description: interrupt event for ring CE3
> +            - description: interrupt event for ring CE4
> +            - description: interrupt event for ring CE5
> +            - description: interrupt event for ring CE6
> +            - description: interrupt event for ring CE7
> +            - description: interrupt event for ring CE8
> +            - description: interrupt event for ring CE9
> +            - description: interrupt event for ring CE10
> +            - description: interrupt event for ring DP1
> +            - description: interrupt event for ring DP2
> +            - description: interrupt event for ring DP3
> +            - description: interrupt event for ring DP4
> +            - description: interrupt event for ring DP5
> +            - description: interrupt event for ring DP6
> +            - description: interrupt event for ring DP7
> +            - description: interrupt event for ring DP8
> +            - description: interrupt event for ring DP9
> +            - description: interrupt event for ring DP10
> +            - description: interrupt event for ring DP11
> +            - description: interrupt event for ring DP12
> +            - description: interrupt event for ring DP13
> +            - description: interrupt event for ring DP14
> +            - description: interrupt event for ring DP15
> +            - description: interrupt event for ring DP16
> +            - description: interrupt event for ring DP17
> +            - description: interrupt event for ring DP18
> +            - description: interrupt event for ring DP19
> +            - description: interrupt event for ring DP20
> +            - description: interrupt event for ring DP21
> +            - description: interrupt event for ring DP22
> +
>  examples:
>    - |
>  
> @@ -309,3 +391,64 @@ examples:
>              };
>          };
>      };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    reserved-memory {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        wlan_ce_mem: wlan_ce_mem@4cd000 {

Node names should use dashes ('-') as separators, so the node name should
be 'wlan-ce-mem'.

Actually reserved memory nodes for sc7280 are all named memory@addr, the
binding should follow this convention, so 'memory@4cd000'.

> +            no-map;
> +            reg = <0x0 0x4cd000 0x0 0x1000>;

Pad the address here to 8 digits

> +        };
> +
> +        wlan_fw_mem: wlan_fw_mem@80c00000 {

Same as above: memory@80c00000

> +            no-map;
> +            reg = <0x0 0x80c00000 0x0 0xc00000>;
> +        };
> +    };
> +
> +    wifi: wifi@17a10040 {
> +        compatible = "qcom,wcn6750-wifi";
> +        reg = <0x17A10040 0x0>;

Use lowercase for hex digits

> +        iommus = <&apps_smmu 0x1C00 0x1>;

Ditto

> +        interrupts = <GIC_SPI 768 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 769 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 770 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 771 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 772 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 773 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 774 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 775 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 776 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 777 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 778 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 779 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 780 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 781 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 782 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 783 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 784 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 785 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 786 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 787 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 788 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 789 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 790 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 791 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 792 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 793 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 794 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 795 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 796 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 797 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 798 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 799 IRQ_TYPE_EDGE_RISING>;
> +        qcom,rproc = <&remoteproc_wpss>;
> +        memory-region = <&wlan_fw_mem>, <&wlan_ce_mem>;
> +        wifi-firmware {
> +                iommus = <&apps_smmu 0x1C02 0x1>;

Use lowercase for hex digits

> +        };
> +    };
