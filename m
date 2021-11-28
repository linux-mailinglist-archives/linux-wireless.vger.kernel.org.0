Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F14460770
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Nov 2021 17:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344025AbhK1Q0T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 28 Nov 2021 11:26:19 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:44932 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346408AbhK1QYT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 28 Nov 2021 11:24:19 -0500
Received: by mail-oi1-f170.google.com with SMTP id be32so29631947oib.11;
        Sun, 28 Nov 2021 08:21:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rows3bbzx3uDnffPtYtrJqcIHaHB1wqydgZBkfJyu+g=;
        b=0D08EkMk66KSVngLlPpvf4B1xNeUGdf9XzZ7h5Wq31WSQJOCT+q1eGa+UG4Pt2SzEx
         mfkXbsm2H6JqS3+jpNzYe/HbC/mtBCDIDxJ4HuNcXIF26UypK1N06u7DUxH1ZIr6IVHl
         W1TtlgqKHAam/Bdm9INt22loMPjS56x2FJabN0dHBHqkUItVvTikBJB4ttatFjcF6d+M
         JLH2i+kGOwGWhVyJtbXaD3Jh6L28YuCdu1pSDx/PYWodkqY2+mhyYxPUFk8TI/3NIkoo
         ST+J4m1pTq6x07vLgK1w4PBbTNslhFPVA0PfDSOaZuFi5IlETNfa6hLv4vYa4FeROkhI
         17Jg==
X-Gm-Message-State: AOAM533hme3MiJ7RVdCrYwQslqF3tGFtJMAd4VrTOS8NOpgKvXqoU2xP
        7d1SYAibtDpjWJ9HdbBpYrKzxsKejA==
X-Google-Smtp-Source: ABdhPJyOjwch8/laQZLnAM4PHiyEzn14IdNUcQCwKF6bifCPIkJdQgCoTLoC7k76111sLmANHibt1Q==
X-Received: by 2002:a05:6808:148d:: with SMTP id e13mr35765874oiw.140.1638116462727;
        Sun, 28 Nov 2021 08:21:02 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:20d6:afc8:f6e9:d57a:3e26:ee41])
        by smtp.gmail.com with ESMTPSA id p14sm1948298oou.31.2021.11.28.08.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 08:21:02 -0800 (PST)
Received: (nullmailer pid 2655105 invoked by uid 1000);
        Sun, 28 Nov 2021 16:20:59 -0000
Date:   Sun, 28 Nov 2021 10:20:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 19/19] dt: bindings: net: add bindings of WCN6750 for
 ath11k
Message-ID: <YaOsaxfXLmOtznYg@robh.at.kernel.org>
References: <1637693434-15462-1-git-send-email-quic_mpubbise@quicinc.com>
 <1637693434-15462-20-git-send-email-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1637693434-15462-20-git-send-email-quic_mpubbise@quicinc.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Nov 24, 2021 at 12:20:34AM +0530, Manikanta Pubbisetty wrote:
> Add WCN6750 wireless driver support, its based on ath11k driver.
> 
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> ---
>  .../bindings/net/wireless/qcom,ath11k.yaml         | 333 ++++++++++++++-------
>  1 file changed, 225 insertions(+), 108 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
> index 85c2f69..60bda6d 100644
> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
> @@ -20,120 +20,21 @@ properties:
>      enum:
>        - qcom,ipq8074-wifi
>        - qcom,ipq6018-wifi
> +      - qcom,wcn6750-wifi
>  
>    reg:
>      maxItems: 1
>  
> -  interrupts:
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
> +  reg-names:
> +    maxItems: 1
>  
> +  interrupts:
> +    minItems: 32
> +    maxItems: 52

You have to define what each interrupt is which you are not doing for 
6750.
