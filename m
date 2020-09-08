Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF88262136
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 22:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgIHUfR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 16:35:17 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40266 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgIHUfR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 16:35:17 -0400
Received: by mail-io1-f67.google.com with SMTP id j2so782735ioj.7;
        Tue, 08 Sep 2020 13:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N8TMTkjL+HXBkd31RAbWRN3OkDrpVAsSr5h0Vt07iso=;
        b=DqKfxY0IySEkqh6plyyANgifRxNeFE/KFbCRJJCkYDfzv7R/t2zvl8GKdxzMs5+vYc
         etdpIpvlKub4FSPDY3c/k/tN88ai+QLwjfX0UuLxIja2z4rnJ5Ntc8OIdfBDSWRyODXN
         VdyN0eFMqYj9UbYTh8GoZ+ucQABoUSa0+aL6FEH0qrt7uii1qbEHGoQ2tB/gKx/jNsap
         RUog9KE4kTkAw+k1P8ABTTNyyVqydGWQaJ9Z66JYyxe4bpEV0JOQBFtd+CJ8+Aom0X2/
         HtmAe1XpCyZsgp1osEbu53TR305SP+7w76uSlvcz3cyj/ZQDc4BtLntJA//0xoa+Zrxk
         b+1g==
X-Gm-Message-State: AOAM531ZQKDmJmmmLiomlk/1lKXvoowehpcy4cGtnGSI0VBCUV6ixrW2
        BK786iZGlAldTVqLzODllnNbGflX/gzC
X-Google-Smtp-Source: ABdhPJzNszEz/h0w+B+3k77krDbp4ZMOTh6PZpaxVniETcrMG+nXiWDeI6mT5xAMx5erE4/iZbmOUg==
X-Received: by 2002:a05:6638:ec5:: with SMTP id q5mr760716jas.13.1599597315710;
        Tue, 08 Sep 2020 13:35:15 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id x24sm121100ilk.82.2020.09.08.13.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 13:35:15 -0700 (PDT)
Received: (nullmailer pid 870794 invoked by uid 1000);
        Tue, 08 Sep 2020 20:35:14 -0000
Date:   Tue, 8 Sep 2020 14:35:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
Subject: Re: [PATCH v7 1/3] dt: bindings: net: update compatible for ath11k
Message-ID: <20200908203514.GA870402@bogus>
References: <1599551717-3801-1-git-send-email-akolli@codeaurora.org>
 <010101746cb6751a-ca300933-1174-4534-a01b-b1dbf1c1f305-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010101746cb6751a-ca300933-1174-4534-a01b-b1dbf1c1f305-000000@us-west-2.amazonses.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 08 Sep 2020 07:55:31 +0000, Anilkumar Kolli wrote:
> Add IPQ6018 wireless driver support,
> its based on ath11k driver.
> 
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
> ---
> V3:
>  - Use 'enum' rather than oneOf+const.
> V4:
>  - removed oneOf, use just enum (Rob)
> V5:
>  - Fixes errors in 'make dt_binding_check' (Rob)
> 
>  Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

