Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D94B496912
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Jan 2022 02:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiAVBHU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Jan 2022 20:07:20 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:39448 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiAVBHT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Jan 2022 20:07:19 -0500
Received: by mail-oi1-f170.google.com with SMTP id e81so16018980oia.6;
        Fri, 21 Jan 2022 17:07:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zBHJqq2dHe91PB93kBcZXjJywNJHEwtEYMMg7X/3fJo=;
        b=PL4zBc/FirWvdo3QDMnITX3MG2kqk2s8c4483nE0DB37nZLaVCicmdU4/bUZ/HwPsM
         mzHA2YtAp4aIQwNlEaGAWTdRIk5XMVRHQy+oRrqCOhRHbiFw3qn3xSxPzP/FDy8d95XA
         gFWEO/HJyN6aESBvMuh4gpLLWqLXneDjfAFLMNJrooy8DqZ8QOn6FJZqH4KmvrcEyJIL
         bkvlKZN+I2yJkQfwmo2adhwI/t3hDINc9e2mpZwOyQrnHnMPrr/9ddmAFviPMh9Pqz9D
         XRhaFn9c4bc/oTWzd+yF1LFKuJUb9EV25pzNgI0aF6BBAfjR0oDlSCJE2ecgPAvnSKWq
         BB9w==
X-Gm-Message-State: AOAM5322aG4ygQU+EPdKCVEy4iigUHd6QD5eSXOFuKth0WfZv2laCBht
        08b8w2wN2ssJGf2gN3+21A==
X-Google-Smtp-Source: ABdhPJyTASUuBuD59UAobuH2zHCWICXuisKrzObLm5W0/ChBazfSZq5lsRZDfBy9MdI18P97xxiOfQ==
X-Received: by 2002:a05:6808:201e:: with SMTP id q30mr2718000oiw.125.1642813639227;
        Fri, 21 Jan 2022 17:07:19 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x184sm2053217oig.53.2022.01.21.17.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 17:07:18 -0800 (PST)
Received: (nullmailer pid 1972987 invoked by uid 1000);
        Sat, 22 Jan 2022 01:07:17 -0000
Date:   Fri, 21 Jan 2022 19:07:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, owen.peng@mediatek.com,
        evelyn.tsai@mediatek.com, nbd@nbd.name, ryder.lee@mediatek.com,
        devicetree@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 6/6] dt-bindings:net:wireless:mediatek,mt76: add
 disable-radar-offchan
Message-ID: <YetYxYMDOGfbcYhU@robh.at.kernel.org>
References: <cover.1642009736.git.lorenzo@kernel.org>
 <221dab8bcc95160652e608def16d822da78717bd.1642009736.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <221dab8bcc95160652e608def16d822da78717bd.1642009736.git.lorenzo@kernel.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 12 Jan 2022 18:53:55 +0100, Lorenzo Bianconi wrote:
> Add the capability to disable/enable radar/CAC detection running on
> a dedicated offchannel chain available on some hw.
> Offchannel radar/CAC detection allows to avoid CAC downtime switching
> on a different channel during CAC detection on the selected radar
> channel.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../devicetree/bindings/net/wireless/mediatek,mt76.yaml  | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
