Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB00935E3F2
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Apr 2021 18:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345569AbhDMQ3o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Apr 2021 12:29:44 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:36409 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346107AbhDMQ3c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Apr 2021 12:29:32 -0400
Received: by mail-oi1-f178.google.com with SMTP id c16so17589532oib.3;
        Tue, 13 Apr 2021 09:29:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oMPu7v4rec+2CSKG3aWSpShM5/eeTZ0BLp0pTjlcyDw=;
        b=jXMpWSHVniB2zaYhms3TFws4ScqxzW0z92pYz3OU00zBP+1nYkfDaia0WOcoWCuXRG
         o1VGuFmuB/Gj++r3H5Hp8Res8XH0mJXblZLVIdRp/Nam890c+OqlRAGFpvR/jPYN92YO
         hy4QjhiAzbT7dhTAx+YVxkMjAW60RoED+6FOOzvBVKn7Cd+RX3bi1k1AjJqk5s3jycvh
         /Ey6KYyuUK+9m7gBvp/1hvIqdzOkvX3Dw7a6++rT2hHdIy6xYgDEdWo+7BU4Ayp1++PZ
         nqz7G4C0oANpVWypip260RRQZn7myEC51E5eZypFyV5aZI1x8CscxUb89HvnHad7km7P
         Bj4w==
X-Gm-Message-State: AOAM530EsRzdWh6ToZg8PnTzFHntqEfLhpuE6inYBz8LE9ZdqnbV2PzQ
        2Ms9IWJ4K82GWqH1RBovXA==
X-Google-Smtp-Source: ABdhPJxf75LhpDLwef2RDl5ttBcRtOHBdnlYOZFH/h/8uPBTRdyEMXIDysX/XSSVBLMp/TYBsfKrBQ==
X-Received: by 2002:aca:1814:: with SMTP id h20mr571391oih.150.1618331352378;
        Tue, 13 Apr 2021 09:29:12 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a21sm1374546oii.25.2021.04.13.09.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 09:29:10 -0700 (PDT)
Received: (nullmailer pid 1787144 invoked by uid 1000);
        Tue, 13 Apr 2021 16:29:09 -0000
Date:   Tue, 13 Apr 2021 11:29:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     devicetree@vger.kernel.org, shayne.chen@mediatek.com,
        linux-wireless@vger.kernel.org, nbd@nbd.name,
        sean.wang@mediatek.com, ryder.lee@mediatek.com,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH v3 1/7] dt-bindings:net:wireless:mediatek,mt76: introduce
 power-limits node
Message-ID: <20210413162909.GA1787099@robh.at.kernel.org>
References: <cover.1618304559.git.lorenzo@kernel.org>
 <9f3720a402e8741553a3dbb26f81018008442ef1.1618304559.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f3720a402e8741553a3dbb26f81018008442ef1.1618304559.git.lorenzo@kernel.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 13 Apr 2021 11:08:35 +0200, Lorenzo Bianconi wrote:
> Introduce power-limits node in mt76 binding in order to specify
> per-rate power limit values for each 802.11n/802.11ac rate
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../bindings/net/wireless/mediatek,mt76.yaml  | 107 ++++++++++++++++++
>  1 file changed, 107 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
