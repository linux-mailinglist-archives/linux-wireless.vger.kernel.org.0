Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E75046C438
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Dec 2021 21:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241111AbhLGUNq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Dec 2021 15:13:46 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:34582 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241107AbhLGUNq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Dec 2021 15:13:46 -0500
Received: by mail-oi1-f174.google.com with SMTP id t19so781568oij.1;
        Tue, 07 Dec 2021 12:10:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pyusDTTtm6Ksb63O7f9wrqjHxWGrxsnuuMVh3JVl9ps=;
        b=g6+gKGjcEFB4LIiUSV6/+/9DGFH/WTQh5AYefq/DcAI56ZBF4FxhFXX5E4GCNXaXa8
         6ATFB3yBEBNy6NszA39E1cd9yF+WUO92SKG0EzfHjFdXk5kzIRAcHq3ue6ykrgy6sW+S
         mCjVyy5O6mw9PqTcP/YEOdX70Ybap+UELI/nvupMEWuYNaz85oVAI4q98ymS6cueUQ0Y
         X0ONl7KSzRjEu6Li4C5fHSP0QUcT340eA2fNg36ScWqLNxlBb0vl40hC2ceAbR+2Q1th
         LjBgM5OgRJPf/ev0pp9dQSrTJ1hyI0ht+ZGZWZY7DvfwPW2MJ/4J8/+IM+rMSCx8tYyS
         JGLQ==
X-Gm-Message-State: AOAM532Ysk5+S1mlxy0kMKHwG1J4VDUBNTwMkBpTVpuEpUFOH5eQDdvt
        hIqDuBm+XhC/ikp8ynNUYg==
X-Google-Smtp-Source: ABdhPJyy7ZP1i5bojmZinwovGShr1pBvwiUG+CXLD8f+MXjXQXmK97Y1qz1uVKQ+yTCQv51Phl1Pmw==
X-Received: by 2002:a05:6808:68f:: with SMTP id k15mr7064464oig.5.1638907815107;
        Tue, 07 Dec 2021 12:10:15 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t14sm106454oth.81.2021.12.07.12.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 12:10:14 -0800 (PST)
Received: (nullmailer pid 746966 invoked by uid 1000);
        Tue, 07 Dec 2021 20:10:13 -0000
Date:   Tue, 7 Dec 2021 14:10:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 1/2] dt: bindings: add new DT entry for ath11k PCI
 device support
Message-ID: <Ya+/pawARpqHwTES@robh.at.kernel.org>
References: <1638789319-2950-1-git-send-email-akolli@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638789319-2950-1-git-send-email-akolli@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 06 Dec 2021 16:45:18 +0530, Anilkumar Kolli wrote:
> Ath11k driver supports PCI devices such as QCN9074/QCA6390.
> Ath11k firmware uses host DDR memory, DT entry is used to
> reserve host DDR memory regions, send these memory base
> addresses using DT entries.
> 
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
> ---
> V4:
>   - Fix dt_binding_check warnings (Rob)
> V2:
>   - Use reserved-memory (Rob)
> 
>  .../bindings/net/wireless/qcom,ath11k.yaml         | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

