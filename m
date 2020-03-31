Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2A9E19A0F6
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2020 23:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731270AbgCaVky (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Mar 2020 17:40:54 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:44183 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgCaVky (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Mar 2020 17:40:54 -0400
Received: by mail-il1-f194.google.com with SMTP id j69so20965285ila.11;
        Tue, 31 Mar 2020 14:40:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eq+6A9+LczeU2VzQyTNk/9n1oBeKvi0NgSFZ/oc66oQ=;
        b=Ap8zUEtOi2EYLmUH4H4Nt4O8w6NqZn/LYPBucU2DpkKOaKclNEc70BRDiTMEkwbxec
         VG6GJ2gcwJ5P8IiQrFkieN56NHVYXv4mY1t0y9mZ0O3JiclLz6QsDW+mHVboW0IcsMWI
         7YGA60KSbhmxVzj6FEAFQplr6pJfv+zBDfay2u7g7PRGYum6I79sD4f/0U1Qr6Vy/FFG
         SojqkWyfOWCMdRkOTT+jHJuCaMWc2iUu5tSr4kTsDPyTLNtfpf9qnLHqMoMoyY4CvZ8j
         7X2iIAiMGeMEnZywaI0AARTlRXtmhK4nb48Tztsn5T/P5fcszvUDWivgJo8wXkGy/X59
         sYbQ==
X-Gm-Message-State: ANhLgQ1Ax+pPpH9XvfiIcYc0QcCfHYsfjLYO+Sfunz/8YVRNQ+DOdxGk
        6/hsiKBdKLYZqEtfp6xh0oBNAWJUzA==
X-Google-Smtp-Source: ADFU+vssb/q/y3wnHMbcu1KcLFBTw9EarimFzfJH01AQcRsX3nDONN9ZkpJiUj9gw96009vEgGk6Xw==
X-Received: by 2002:a92:844f:: with SMTP id l76mr19385844ild.13.1585690853355;
        Tue, 31 Mar 2020 14:40:53 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id h9sm21895iow.37.2020.03.31.14.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 14:40:52 -0700 (PDT)
Received: (nullmailer pid 20298 invoked by uid 1000);
        Tue, 31 Mar 2020 21:40:51 -0000
Date:   Tue, 31 Mar 2020 15:40:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: ath10k: Add wifi-firmware subnode
 for wifi node
Message-ID: <20200331214051.GA2053@bogus>
References: <1585134100-5944-1-git-send-email-pillair@codeaurora.org>
 <1585134100-5944-2-git-send-email-pillair@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585134100-5944-2-git-send-email-pillair@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Mar 25, 2020 at 04:31:38PM +0530, Rakesh Pillai wrote:
> Add a wifi-firmware subnode for the wifi node.
> This wifi-firmware subnode is needed for the
> targets which do not support TrustZone.
> 
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> ---
>  .../devicetree/bindings/net/wireless/qcom,ath10k.txt       | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
> index 71bf91f..65ee68e 100644
> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
> @@ -96,6 +96,17 @@ Optional properties:
>  - qcom,coexist-gpio-pin : gpio pin number  information to support coex
>  			  which will be used by wifi firmware.
>  
> +* Subnodes
> +The ath10k wifi node can contain one optional firmware subnode.
> +Firmware subnode is needed when the platform does not have TustZone.
> +The firmware subnode must have:
> +
> +- iommus:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: A list of phandle and IOMMU specifier pairs.
> +
> +
>  Example (to supply PCI based wifi block details):
>  
>  In this example, the node is defined as child node of the PCI controller.
> @@ -196,4 +207,7 @@ wifi@18000000 {
>  		memory-region = <&wifi_msa_mem>;
>  		iommus = <&apps_smmu 0x0040 0x1>;
>  		qcom,msa-fixed-perm;
> +		wifi-firmware {
> +			iommus = <&apps_iommu 0xc22 0x1>;

Why can't you just add a 2nd entry to the existing 'iommus' property? 

A driver doing of_dma_configure() is generally not the right thing to 
do.

Rob
