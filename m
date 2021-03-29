Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1AFE34D1E9
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Mar 2021 15:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhC2NzJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Mar 2021 09:55:09 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:43855 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbhC2NzI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Mar 2021 09:55:08 -0400
Received: by mail-oi1-f177.google.com with SMTP id n8so13114938oie.10;
        Mon, 29 Mar 2021 06:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dFXFmT++lVuT1PxeHwMx/HZ9Q6YXDGLu1pXZZvRDN2Q=;
        b=PJrodMy1fqfIQHCH3WiSu3aOxWj59HizHG37Lmy3GsiE8hsn1ASFm1Uqxw4Llk5RZj
         k1SxNj+btsP84U8da95lxbxNcJP0ywwhTxcUFqsynSHLdS08LYrFa2WZLjdKBx1YXW2k
         CLdosl+6htSD7rg13U8etWCAlML+32xLjRnbj/OSXznw9HTsOsF4FPCGs7HH+SA8QTVo
         F+8OXevaciny9bjeptKHYUUtUy+Rsn9VjY0aMw4x69+33/L5jCbHh9SHYM26/f1v38Rr
         VDCSnfP2e4wEVVxHe5lcIXBny2aZBkA2HeKYU5SRBoZ/kyYe+bWGR4cNrspnOJAM6bp7
         vjdg==
X-Gm-Message-State: AOAM530T9+vd4FdQU6nBq9pmkN9gV7fpyMuF0wWC+KC5iYBaovipjzux
        riKJAFM7xWyn8twvIFBnTw==
X-Google-Smtp-Source: ABdhPJyNNoYB26FLTywS2plWXuFXuTkJCJBcwPQIuHN3M9U4vppl6JwA7rfu/a7qyHyEOaGz4MarcQ==
X-Received: by 2002:aca:3456:: with SMTP id b83mr18856128oia.51.1617026108078;
        Mon, 29 Mar 2021 06:55:08 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 8sm4310027otx.1.2021.03.29.06.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 06:55:07 -0700 (PDT)
Received: (nullmailer pid 2472318 invoked by uid 1000);
        Mon, 29 Mar 2021 13:55:05 -0000
Date:   Mon, 29 Mar 2021 08:55:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, ryder.lee@mediatek.com, devicetree@vger.kernel.org,
        lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com
Subject: Re: [PATCH v4] dt-bindings:net:wireless:mediatek,mt76: txt to yaml
 conversion
Message-ID: <20210329135505.GA2472270@robh.at.kernel.org>
References: <b036c12665c57550cbb68ccb64c7a871ba8c4071.1616951910.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b036c12665c57550cbb68ccb64c7a871ba8c4071.1616951910.git.lorenzo@kernel.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 28 Mar 2021 19:37:48 +0200, Lorenzo Bianconi wrote:
> Convert mt76 dts bindings from .txt to .yaml
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes since v3:
> - do not repost patch 1/2
> - use additionalProperties instead of unevaluatedProperties
> - just use 'ieee80211-freq-limit: true'
> 
> Changes since v2:
> - add myself as ieee80211.yaml maintainer
> - add Ryder as mt76.yaml maintainer
> - fix led node in mt76.yaml
> - fix ieee80211.yaml refernce in mt76.yaml
> - fix ieee80211-freq-limit property in ieee80211.yaml
> 
> Changes since v1:
> - introduce ieee80211.yaml bindings
> - remove unnecessary properties in mt76.yaml
> ---
>  .../bindings/net/wireless/mediatek,mt76.txt   |  78 -----------
>  .../bindings/net/wireless/mediatek,mt76.yaml  | 121 ++++++++++++++++++
>  2 files changed, 121 insertions(+), 78 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
