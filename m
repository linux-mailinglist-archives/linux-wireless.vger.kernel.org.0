Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7E152AF29
	for <lists+linux-wireless@lfdr.de>; Wed, 18 May 2022 02:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbiERA3W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 May 2022 20:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbiERA3U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 May 2022 20:29:20 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845B435865;
        Tue, 17 May 2022 17:29:19 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-f16a3e0529so752859fac.2;
        Tue, 17 May 2022 17:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9TKojzwNIl5X+kje0PBkzlv5STasDpTP+imoZvsmhsU=;
        b=7hIAQNOD6MwDH54Ir6+1esbmQCATwWU8S/rQeH09JCyZGOi0fiCke6uxG3YMdC2SAZ
         +fsNPdq3s/+B7vxNDRaazks9DR9DqT5tNo3VM2TzuWsTR54HpZnkNFeww7wkJ7zVumoD
         VZJKVKE7XVEfxiTmD3shQvNsxitqK27gL0mNx1YqpQKbLzjb+0V9hywjYfdoGhgMg614
         DP7io5Qop7P2nuBM5PVa6ffBL73YUtgeJdeiFobUlMDpekS/hL6zUfxMCgjKc5lCZjd0
         Szxbwr5dTf12pMlrtTr9aMb/Y3OXn3XJ7pehgSBnHGzdugWG3DXBa70jVHZEWL4+vItx
         QTkA==
X-Gm-Message-State: AOAM533ktr3mrj4CrLOukl2rzuKa8nkGLnwU5VTa7QOSrbQp3LzfL+zp
        kqs9/rSd3v7Id+wWjCoSKA==
X-Google-Smtp-Source: ABdhPJw0Bh/BWJ55dEGhve1trL4okx867sRjI5p9REaX9Ukyz4WwvXnocm5Eu0uHWgDBTYJ5+CGv4Q==
X-Received: by 2002:a05:6870:4201:b0:e6:47c4:e104 with SMTP id u1-20020a056870420100b000e647c4e104mr20277606oac.257.1652833758611;
        Tue, 17 May 2022 17:29:18 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a3-20020a056830008300b006060322126esm306653oto.62.2022.05.17.17.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 17:29:17 -0700 (PDT)
Received: (nullmailer pid 1939467 invoked by uid 1000);
        Wed, 18 May 2022 00:29:16 -0000
Date:   Tue, 17 May 2022 19:29:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Peter Chiu <chui-hao.chiu@mediatek.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        linux-wireless@vger.kernel.org,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.Lee@mediatek.com>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Sam Shih <sam.shih@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: net: wireless: mt76: add clock description
 for MT7986.
Message-ID: <20220518002916.GA1939404-robh@kernel.org>
References: <20220512043859.406-1-chui-hao.chiu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512043859.406-1-chui-hao.chiu@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 12 May 2022 12:38:59 +0800, Peter Chiu wrote:
> Add clocks and clock-names for MT7986.
> 
> Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> ---
>  .../bindings/net/wireless/mediatek,mt76.yaml        | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
