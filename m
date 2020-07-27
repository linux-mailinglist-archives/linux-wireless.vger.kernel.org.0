Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F19122F9A1
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jul 2020 21:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbgG0T6E (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Jul 2020 15:58:04 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:36388 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728990AbgG0T6E (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Jul 2020 15:58:04 -0400
Received: by mail-il1-f194.google.com with SMTP id z3so3945908ilh.3;
        Mon, 27 Jul 2020 12:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C53pK+uBuv5c41N3BAiH4FGy7QKCgLscuGdWI3yWxgQ=;
        b=OqLNEi4dJ1Vz4cq+HQpVpiXNaIpNMKKjiDvCxHzaRQPHSIzRJJ6dhv+dqm+1iJD4Xg
         G7m6JsuZREcgqVgidXzNcm65TkdidRhQfCNEkbrDrhtSCfbMyWnkshAwS42S1aJ3HvN6
         UnhZHrqkhl/xDDw+u/qe/1Zj++46h9FaGrP0zOhOOy4grQVBUTa9ntlUc4Pb+2kVg8A4
         92jHFm5Q8+DJKfysphiLl1RSg8vWUEQGGjjK67+h+/NqPaw56aGAiSFXYKiKtb4RI0sJ
         07eqL0B29245hrDVJGV/dQlySkyQR1lEZ7GjcFn27LwyRWUH8kpv0Sq1uUc8ixeCrbV7
         KSBg==
X-Gm-Message-State: AOAM531wa7Y4ArnHRVeXYqIAeWjj7Dvq9T2zJ1x0gIwWofBZMJJXQV5K
        7St0J+H7jTbGzep+1YxZ1w==
X-Google-Smtp-Source: ABdhPJycV/6qZ0N9E62Br/vCZLPoRJ/kvtwDVGD6Lcyq3aJKfbKk128+z295qC2C3fmRZYIwtYXu0w==
X-Received: by 2002:a92:c689:: with SMTP id o9mr25791979ilg.302.1595879883096;
        Mon, 27 Jul 2020 12:58:03 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id g1sm9289694iov.38.2020.07.27.12.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 12:58:02 -0700 (PDT)
Received: (nullmailer pid 780780 invoked by uid 1000);
        Mon, 27 Jul 2020 19:58:01 -0000
Date:   Mon, 27 Jul 2020 13:58:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt: bindings: net: update compatible for ath11k
Message-ID: <20200727195801.GA780731@bogus>
References: <1595574325-16300-1-git-send-email-akolli@codeaurora.org>
 <1595574325-16300-2-git-send-email-akolli@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595574325-16300-2-git-send-email-akolli@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 24 Jul 2020 12:35:23 +0530, Anilkumar Kolli wrote:
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
