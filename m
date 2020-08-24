Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EC7250AD7
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Aug 2020 23:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgHXV1g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Aug 2020 17:27:36 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44359 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgHXV1f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Aug 2020 17:27:35 -0400
Received: by mail-io1-f66.google.com with SMTP id v6so10283717iow.11;
        Mon, 24 Aug 2020 14:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oC1bCYtbH785PwJcnJAiG6IM7n4aDDrx+MXFC9Xswok=;
        b=Wkus/w4Zw94lXu2jZM8IqVTwwnUC/Xo0Hz5JA7jFF/qoltYRb8dUBnCoymY8qu3IDp
         vZU8wVxnIqWDFHtayRjDz8nHlUZA3CwyeC+2Mu19eWRGk+6wScYgYFZAO1r7y9LAM6G3
         AOnT+s9z/UzaJ8qfaJjnj8kV6eQrPVz4dSxEFX2CbR98Zyc3IXP9f5LwInhVulD8tqea
         /J6rS7v2PYizr75lxlrM0EUxcNrTY+WStQMODyqtHV0gjVGPuOO00TXF9Ou/ORqCUvrR
         /pqoyVQPNYbkVyLes5LQQ76FVHeaGADO5H56y7oszU8p2RjcQT9N8B7ciGqkJdD3UZi3
         Wj6w==
X-Gm-Message-State: AOAM532bw3YvKy/pHgsrDfy7vWkUX9NoVQ+TJuahwCQLsOv7nSRy/rVv
        fyBqVDarJtv2a6HOFAt2a3ZF+6jMdw==
X-Google-Smtp-Source: ABdhPJwW4GGVZk4Kul9nCfbrZTW+ONHKhy6SSgc0n/ONVpRQjcMn/3Ip3QeWumq0JpgMeN5NirEGZg==
X-Received: by 2002:a02:454:: with SMTP id 81mr7764300jab.142.1598304454301;
        Mon, 24 Aug 2020 14:27:34 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id l5sm7903381ilj.88.2020.08.24.14.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 14:27:33 -0700 (PDT)
Received: (nullmailer pid 3331741 invoked by uid 1000);
        Mon, 24 Aug 2020 21:27:32 -0000
Date:   Mon, 24 Aug 2020 15:27:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
Subject: Re: [PATCH v6 1/3] dt: bindings: net: update compatible for ath11k
Message-ID: <20200824212732.GA3331346@bogus>
References: <1598287470-1871-1-git-send-email-akolli@codeaurora.org>
 <1598287470-1871-2-git-send-email-akolli@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598287470-1871-2-git-send-email-akolli@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 24 Aug 2020 22:14:28 +0530, Anilkumar Kolli wrote:
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

Reviewed-by: Rob Herring <robh@kernel.org>
