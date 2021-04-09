Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0A135A1CB
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Apr 2021 17:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbhDIPNl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Apr 2021 11:13:41 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:38736 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbhDIPNk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Apr 2021 11:13:40 -0400
Received: by mail-ot1-f46.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so5990496otk.5;
        Fri, 09 Apr 2021 08:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mqW1a5d7rFu6UosMT0283wsYzx5UvTYigPBJh3XYCyc=;
        b=QEdMWu7we174+Fz5MrLJbhrQTog6ztG6nmGrxSSTEgu2H73N0wr4rIibUg0ZfXJgnA
         ELOV6FKIVbTsqjE9ArukIaatmqTyjngAwPsAObi1ntF9gVfilViVqjuSH+Ge2nWqEIpo
         O5lFvMCNwk53BqcOztD1jMyTkyIppxivOx5yjoNZ5fW9qZ5nOk7rJxxIRWQXU1gGCY+3
         MvoPj2vDQ+r0SEe8STsN48UFCRVsBu7BH6VJlJev/4vhdPgDfWzgdtwj7F/fFxsHNfvI
         4WYSF7rYjjoM2vG9rISJV6i5ZnLSuS07tGjxJWqTYOpToFaqk4K2S0Jjfsaj4+1td/ve
         7pMQ==
X-Gm-Message-State: AOAM530Plc1A850vlgQHzfBzZ5Wyj17z6V3fERFKZB9jUxtVajJg6An/
        LZ1YwtibgmnWe8XM99AEOw==
X-Google-Smtp-Source: ABdhPJzK/s2s6omuVhlWR+swr/+lGq8vgQ3CRIdBD9rkXjpyR9G/oz56dzNtu+RIiUSgsBEGGqvBcA==
X-Received: by 2002:a05:6830:18db:: with SMTP id v27mr12640961ote.253.1617981206188;
        Fri, 09 Apr 2021 08:13:26 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j11sm574756ooo.45.2021.04.09.08.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 08:13:25 -0700 (PDT)
Received: (nullmailer pid 3664310 invoked by uid 1000);
        Fri, 09 Apr 2021 15:13:24 -0000
Date:   Fri, 9 Apr 2021 10:13:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, shayne.chen@mediatek.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/8] dt-bindings:net:wireless:ieee80211: introduce
 regdomain property
Message-ID: <20210409151324.GA3662358@robh.at.kernel.org>
References: <cover.1617625912.git.lorenzo@kernel.org>
 <1ff764d84e1fb83768c2e9d233c27b0ed1ef4294.1617625912.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ff764d84e1fb83768c2e9d233c27b0ed1ef4294.1617625912.git.lorenzo@kernel.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Apr 05, 2021 at 02:40:25PM +0200, Lorenzo Bianconi wrote:
> Add regdomain property to ieee80211 binding
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../devicetree/bindings/net/wireless/ieee80211.yaml      | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml b/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
> index d58e1571df9b..6557c6348cac 100644
> --- a/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
> @@ -30,6 +30,15 @@ properties:
>        different 5 GHz subbands. Using them incorrectly could not work or
>        decrease performance noticeably
>  
> +  regdomain:
> +    minItems: 1
> +    maxItems: 1
> +    contains:

If only 1 entry, then 'contains' is pointless. Just 'enum' is enough. 
You also need a 'description'.

> +      enum:
> +        - FCC
> +        - ETSI
> +        - JP
> +
>  additionalProperties: true
>  
>  examples:
> -- 
> 2.30.2
> 
