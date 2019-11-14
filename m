Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89188FCE93
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2019 20:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfKNTQn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Nov 2019 14:16:43 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46022 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfKNTQn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Nov 2019 14:16:43 -0500
Received: by mail-oi1-f193.google.com with SMTP id 14so6299059oir.12;
        Thu, 14 Nov 2019 11:16:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JupwLIMCy0kD1DylEYdUBcHFa8QvARGaEvLmmurxdDo=;
        b=FLXWvS0B1iwLJsPpf6vD5tUIJ06B+YGhlGqkgzsgtCACVa8amI16rG4aaaNyKKlGic
         V/aYOKvsW6NmngqTxZCX9LpjdPpe5ct5CWBlnIPv5OTuZoYwvAEB3VoRO1fk4Kr3uoqd
         tRaQBCrZ0wZFI9C87s1rsdNmzDJr5EO4DLw0DYOQeFegWX5hm5qe11FKceoW7lTC2ZPv
         a0zPmYcFZcD6nNsD6t245UDRABaNzImxmu8ddGbQ6fwg51HS6s3QErFRPQdxcd7B+n2w
         L0FV4ucvGGaUZKp0z7nMrcBal74LWWTu/p2pQBpuI/l9yhStkc4VfzhjOS0gtQiXH6vZ
         5RBA==
X-Gm-Message-State: APjAAAXXuXQT97iuQbkOMXkwLOnrSvTPcn2j0ekM7ALS07lTBVhUtmDw
        c3udKRFCxHJpv3jZd+mE8g==
X-Google-Smtp-Source: APXvYqx216qmRtLD8fvRbb7HfVk7gUkrflyOyJZGhawNK0RcsBGErmtzyzCcTrZdLV6OxprI+8YFKQ==
X-Received: by 2002:aca:cdd6:: with SMTP id d205mr4981354oig.9.1573759001815;
        Thu, 14 Nov 2019 11:16:41 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u1sm2044899oie.37.2019.11.14.11.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 11:16:41 -0800 (PST)
Date:   Thu, 14 Nov 2019 13:16:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Govind Singh <govinds@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt: bindings: add dt entry flag to skip SCM call
 for msa region
Message-ID: <20191114191640.GA8426@bogus>
References: <20191111042508.12628-1-govinds@codeaurora.org>
 <20191111042508.12628-2-govinds@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111042508.12628-2-govinds@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Nov 11, 2019 at 09:55:07AM +0530, Govind Singh wrote:
> Add boolean context flag to disable SCM call for statically
> mapped msa region.

Can't this be implied by the compatible string?

> 
> Signed-off-by: Govind Singh <govinds@codeaurora.org>
> ---
>  .../devicetree/bindings/net/wireless/qcom,ath10k.txt          | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
> index 017128394a3e..7ba22918bab7 100644
> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
> @@ -88,6 +88,9 @@ Optional properties:
>  		    of the host capability QMI request
>  - qcom,xo-cal-data: xo cal offset to be configured in xo trim register.
>  
> +- qcom,msa_fixed_perm: Boolean context flag to disable SCM call for statically
> +		       mapped msa region.
> +

s/_/-/

>  Example (to supply PCI based wifi block details):
>  
>  In this example, the node is defined as child node of the PCI controller.
> @@ -185,4 +188,5 @@ wifi@18000000 {
>  		vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
>  		memory-region = <&wifi_msa_mem>;
>  		iommus = <&apps_smmu 0x0040 0x1>;
> +		qcom,msa_fixed_perm;
>  };
> -- 
> 2.22.0
> 
