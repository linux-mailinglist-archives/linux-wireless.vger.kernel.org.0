Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307364AFC9E
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Feb 2022 20:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbiBIS7r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Feb 2022 13:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241636AbiBIS7f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Feb 2022 13:59:35 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C70C050CD1;
        Wed,  9 Feb 2022 10:57:42 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id y23so3421253oia.13;
        Wed, 09 Feb 2022 10:57:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H7xdyU3dNzn1aGQxkPyHJk9OkHfZ1q05CNcab6XbAM8=;
        b=cSzMsB3vL6h/GLa2+fZ/68pfN/+igNnPSBtjwKM47FzVqO5u0sJKzCnOTPnW3kFj+p
         CckpmKFhx2/yIS99aOdJh9mvfKydjI8OkZ8u0kqy9uqLatyeN7uPNTOoxYXCkHZ33pwh
         RyKm4GoDBGQzlFWjQx5ZmVvivw1HeyQj/2oZTbVSBN+ryEdXPNC08BhxONvTVKBTuCaZ
         c5+uCrHIPOf67GBbm8365CdOySERbzKx8EOou+lxPkcmdYd7yrRiSopvvIWvQjfnk1it
         TCLjhOhMzVk3asH7b9dHByBhLz94B2Oe1FzBQp89poBBrzwXfKYtBZo66r0g9CIZwwzN
         wpQg==
X-Gm-Message-State: AOAM533XhNUl7CVvLhVEh02TMDrdDZjHJr3XL/y6xnWDuzk+Lw5XONQz
        RuPJONR8NMNDbfg8ZSm91g==
X-Google-Smtp-Source: ABdhPJxP//1aGuFFY9vxv6CdY8xqk4XXBhD/YeyBeYu20dO0Ofj+I1tSvsI8ELVBjnh9kya5nvPUDA==
X-Received: by 2002:a05:6808:1989:: with SMTP id bj9mr2018511oib.28.1644433062105;
        Wed, 09 Feb 2022 10:57:42 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 21sm6898916otj.71.2022.02.09.10.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 10:57:41 -0800 (PST)
Received: (nullmailer pid 691757 invoked by uid 1000);
        Wed, 09 Feb 2022 18:57:40 -0000
Date:   Wed, 9 Feb 2022 12:57:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bo Jiao <bo.jiao@mediatek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        devicetree@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: net: wireless: mt76: document
 bindings for MT7986
Message-ID: <YgQOpOnYJyHaQtV8@robh.at.kernel.org>
References: <cover.1644386694.git.Bo.Jiao@mediatek.com>
 <08ef978845036560bb08b72e948e42f858e087d3.1644386694.git.Bo.Jiao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08ef978845036560bb08b72e948e42f858e087d3.1644386694.git.Bo.Jiao@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 09 Feb 2022 14:11:55 +0800, Bo Jiao wrote:
> From: Peter Chiu <chui-hao.chiu@mediatek.com>
> 
> Add an entry for MT7986 SoC.
> 
> Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> Cc: devicetree@vger.kernel.org
> ---
> v3:
>  - fix yamllint warnings and errors
>  - add 'minItems: 1' to keep 1 reg entry being valid
> v4:
>  - add description for property reg items
> ---
>  .../bindings/net/wireless/mediatek,mt76.yaml  | 33 +++++++++++++++++--
>  1 file changed, 30 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
