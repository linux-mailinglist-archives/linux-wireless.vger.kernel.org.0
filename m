Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4209F141
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2019 19:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbfH0RNK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Aug 2019 13:13:10 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37561 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfH0RNK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Aug 2019 13:13:10 -0400
Received: by mail-ot1-f65.google.com with SMTP id f17so19429792otq.4;
        Tue, 27 Aug 2019 10:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wUYcGOihIFBtqyF78I1wqZoT2CD9kDfXER8AguN6CgA=;
        b=WjrOkidefgyDmdfNYjalL+8L5ln+VOeZufnP5ItMWaql2v/RkAM4BZI8znE+e2YfIf
         oyuxYU+JqynpbrD9JeZM0ZeESj8c4rXu+X62PXLfB3YfPJthZbRbiLXeE3+8E47aQww3
         TffFJSm+iJkdSHiHBxfAwrd1Q3RuEAmQnxDYzz2TsQCt2kCSYuia9xJ/uAbnKh8iieZl
         KR8en5CoN1p7KwzEhyMIrQmi+c4ocedulQjqEFK4TCP7E/T8uiSLuWmcg3TWl7Zwgq/p
         6FUu1pbzLf0PWKAyCJ84Ia2qgFP8d11O4UXZb4N4rJrW89GZZyCbTsYWpV6EFKbH156i
         t6Cg==
X-Gm-Message-State: APjAAAWPMV9ZLmC3X7wp/Z5JTLhCwiCyRPQjPLDkgwp8k6FsDInle7Fp
        KFryuxUKlX3DzNfpbQja8ZcMHY4=
X-Google-Smtp-Source: APXvYqy98TpLrSxlV1ojf0lXeSfSeyebsq72mnJuH64qfVIj1LcSukYQ45O5BvjuNn/IAChpfJqO7g==
X-Received: by 2002:a9d:4685:: with SMTP id z5mr14158650ote.359.1566925988988;
        Tue, 27 Aug 2019 10:13:08 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v5sm5282620otk.64.2019.08.27.10.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 10:13:08 -0700 (PDT)
Date:   Tue, 27 Aug 2019 12:13:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 01/49] dt: bindings: net: add qcom,ath11k.txt
Message-ID: <20190827171307.GA23128@bogus>
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
 <1566316095-27507-2-git-send-email-kvalo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566316095-27507-2-git-send-email-kvalo@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Aug 20, 2019 at 06:47:27PM +0300, Kalle Valo wrote:

Missing commit message and Sob (and on the other patches).

> ---
>  .../bindings/net/wireless/qcom,ath11k.txt          | 127 +++++++++++++++++++++
>  1 file changed, 127 insertions(+)

Please use the DT schema format (YAML). See writing-schema.md.

> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.txt b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.txt
> new file mode 100644
> index 000000000000..1824238b4b50
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.txt
> @@ -0,0 +1,127 @@
> +* Qualcomm Technologies ath11k wireless devices
> +
> +Required properties:
> +- compatible: Should be "qcom,ipq8074-wifi"
> +
> +AHB based ipq8074 uses most of the properties defined in this doc.
> +
> +Optional properties:
> +- reg: Address and length of the register set for the device.
> +- interrupts: List of interrupt lines. Must contain an entry
> +	      for each entry in the interrupt-names property.

Need to be explicit as to how many interrupts and what they are.

> +- interrupt-names: Must include the entries for CE interrupt
> +		   names ("ce0" to "ce11") and hw srng interrupt
> +		   names.
> +- qcom,rproc: DT entry of q6v5-wcss
> +
> +Example:
> +
> +wifi0: wifi@c000000 {
> +	compatible = "qcom,ipq8074-wifi";
> +	reg = <0xc000000 0x2000000>;
> +	interrupts = <0 320 1>,
> +		     <0 319 1>,
> +		     <0 318 1>,
> +		     <0 317 1>,
> +		     <0 316 1>,
> +		     <0 315 1>,
> +		     <0 314 1>,
> +		     <0 311 1>,
> +		     <0 310 1>,
> +		     <0 411 1>,
> +		     <0 410 1>,
> +		     <0 40 1>,
> +		     <0 39 1>,
> +		     <0 302 1>,
> +		     <0 301 1>,
> +		     <0 37 1>,
> +		     <0 36 1>,
> +		     <0 296 1>,
> +		     <0 295 1>,
> +		     <0 294 1>,
> +		     <0 293 1>,
> +		     <0 292 1>,
> +		     <0 291 1>,
> +		     <0 290 1>,
> +		     <0 289 1>,
> +		     <0 288 1>,
> +		     <0 239 1>,
> +		     <0 236 1>,
> +		     <0 235 1>,
> +		     <0 234 1>,
> +		     <0 233 1>,
> +		     <0 232 1>,
> +		     <0 231 1>,
> +		     <0 230 1>,
> +		     <0 229 1>,
> +		     <0 228 1>,
> +		     <0 224 1>,
> +		     <0 223 1>,
> +		     <0 203 1>,
> +		     <0 183 1>,
> +		     <0 180 1>,
> +		     <0 179 1>,
> +		     <0 178 1>,
> +		     <0 177 1>,
> +		     <0 176 1>,
> +		     <0 163 1>,
> +		     <0 162 1>,
> +		     <0 160 1>,
> +		     <0 159 1>,
> +		     <0 158 1>,
> +		     <0 157 1>,
> +		     <0 156 1>;
> +	interrupt-names = "misc-pulse1",
> +			  "misc-latch",
> +			  "sw-exception",
> +			  "watchdog",
> +			  "ce0",
> +			  "ce1",
> +			  "ce2",
> +			  "ce3",
> +			  "ce4",
> +			  "ce5",
> +			  "ce6",
> +			  "ce7",
> +			  "ce8",
> +			  "ce9",
> +			  "ce10",
> +			  "ce11",
> +			  "host2wbm-desc-feed",
> +			  "host2reo-re-injection",
> +			  "host2reo-command",
> +			  "host2rxdma-monitor-ring3",
> +			  "host2rxdma-monitor-ring2",
> +			  "host2rxdma-monitor-ring1",
> +			  "reo2ost-exception",
> +			  "wbm2host-rx-release",
> +			  "reo2host-status",
> +			  "reo2host-destination-ring4",
> +			  "reo2host-destination-ring3",
> +			  "reo2host-destination-ring2",
> +			  "reo2host-destination-ring1",
> +			  "rxdma2host-monitor-destination-mac3",
> +			  "rxdma2host-monitor-destination-mac2",
> +			  "rxdma2host-monitor-destination-mac1",
> +			  "ppdu-end-interrupts-mac3",
> +			  "ppdu-end-interrupts-mac2",
> +			  "ppdu-end-interrupts-mac1",
> +			  "rxdma2host-monitor-status-ring-mac3",
> +			  "rxdma2host-monitor-status-ring-mac2",
> +			  "rxdma2host-monitor-status-ring-mac1",
> +			  "host2rxdma-host-buf-ring-mac3",
> +			  "host2rxdma-host-buf-ring-mac2",
> +			  "host2rxdma-host-buf-ring-mac1",
> +			  "rxdma2host-destination-ring-mac3",
> +			  "rxdma2host-destination-ring-mac2",
> +			  "rxdma2host-destination-ring-mac1",
> +			  "host2tcl-input-ring4",
> +			  "host2tcl-input-ring3",
> +			  "host2tcl-input-ring2",
> +			  "host2tcl-input-ring1",
> +			  "wbm2host-tx-completions-ring3",
> +			  "wbm2host-tx-completions-ring2",
> +			  "wbm2host-tx-completions-ring1",
> +			  "tcl2host-status-ring";
> +	qcom,rproc = <&qcom_q6v5_wcss>;
> +};
> 
