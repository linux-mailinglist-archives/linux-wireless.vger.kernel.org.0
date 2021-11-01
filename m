Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B1C4421BB
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Nov 2021 21:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhKAUh4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Nov 2021 16:37:56 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:44697 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhKAUhj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Nov 2021 16:37:39 -0400
Received: by mail-oi1-f174.google.com with SMTP id w1so286492oiw.11;
        Mon, 01 Nov 2021 13:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7jMCRGui2/Gum4mb5UjGuBVKQlP/7omX+39AlRJjhUM=;
        b=ugWAqEAnFZ0rn/NsfstT2GleOz394lQTHdUtSB1EpO9SfSHcLnN34jD80Z954opKCc
         bpthxVV2TYf8gjI8hBfTNSQBVdvAUzQVKlfLJfEnRYxQACZxXg+Y17bFkYhNwtR5hlKD
         cHvUd1cy7Mq8cTGWgDlhijlrsXDIc/ZyGX9yrjhIXT4q/k/X5np29Mnp7sGXobI35vBm
         8Nm4x/wEiwFdDY0UxqvxmYbd+rsIxTI4BgaRH6VabCMVqRzp0ebJblzX/xeeN1brvrzZ
         7C5z9gF52op2uUBDiUaNvbFhDfc4VENiAqhXFHYRASq2g7Xn0NPvfU83fuF/qOisFJ2a
         tg8A==
X-Gm-Message-State: AOAM530KfEV5Qm5XgiByinnCs6d0J38LFX03l/LkPnxXiag3bPFsUAG3
        JhVwOBpUl9BQ/ivBs2ryCQ==
X-Google-Smtp-Source: ABdhPJyzobvdnowFNE2K2Dz5NpV+H/uhhJTM9QM+KIyZSoj/dye1t89/4YPEZgz3psioLjsPPZJeHg==
X-Received: by 2002:aca:502:: with SMTP id 2mr1142915oif.121.1635798905160;
        Mon, 01 Nov 2021 13:35:05 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id ay6sm1242483oob.17.2021.11.01.13.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 13:35:04 -0700 (PDT)
Received: (nullmailer pid 1000398 invoked by uid 1000);
        Mon, 01 Nov 2021 20:35:03 -0000
Date:   Mon, 1 Nov 2021 15:35:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt: bindings: add new DT entry for ath11k PCI device
 support
Message-ID: <YYBPd+Z/dA/pTReo@robh.at.kernel.org>
References: <1635175648-23491-1-git-send-email-akolli@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635175648-23491-1-git-send-email-akolli@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Oct 25, 2021 at 08:57:27PM +0530, Anilkumar Kolli wrote:
> Ath11k driver supports PCI devices such as QCN9074/QCA6390.
> Ath11k firmware uses host DDR memory, DT entry is used to reserve
> these host DDR memory regions, send these memory base
> addresses using DT entries.
> 
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
> ---
>  .../bindings/net/wireless/qcom,ath11k.yaml         | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
> index 5ac9616c9239..c7e6612e949c 100644
> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
> @@ -19,6 +19,10 @@ description: |
>    These devices use HOST DDR memory, HOST DDR memory can be reserved
>    and send to ath11k driver from DT.
>  
> +  ATH11K supports PCI devices like QCA6390,QCN9074.
> +  These devices use host DDR memory, host DDR memory can be reserved
> +  and send to ath11k driver from DT.
> +
>  properties:
>    compatible:
>      enum:
> @@ -177,6 +181,29 @@ properties:
>      description:
>        HOST DDR end address.
>  
> +  qcom,base-addr:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Host DDR base address for firmware. QCN9074 firmware uses 45 MB of host
> +      DDR memory in mode-0 and 15 MB of host DDR memory in mode-2.
> +
> +  qcom,caldb-addr:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Host DDR address to store CALDB. CALDB is calibration data base
> +      for WLAN channel and tx power.
> +

Use /reserved-memory entries for these.

> +  qcom,start-addr:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Host DDR start address. For example on x86 it is 0x0,
> +      on IPQ8074 it is 0x41000000.
> +
> +  qcom,end-addr:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Host DDR end address.

Nak. I don't know what you are doing with these 2, but it's wrong.

Rob
