Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61E34F65C9
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Apr 2022 18:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237525AbiDFQgd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Apr 2022 12:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237821AbiDFQgM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Apr 2022 12:36:12 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66ECC2C9923;
        Wed,  6 Apr 2022 08:08:44 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-de48295467so3220917fac.2;
        Wed, 06 Apr 2022 08:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RBUbX74ObfqzzSNCHOoh02AEXuH/Bv5AB2YAxYPhz64=;
        b=pCXcRlFeRqL1CBjktd9etRPJbEh/UUKTawuNove875XSKExyTpolm+mN1ynmiTUiao
         ugkE9DWysb58whjlrOlcvE6cjHhwQM6wfTDAHnotq7pxALmnEUcJ9HPkHSCGl0iH8l59
         lvSXmqLNqjlu4ugFJOusaNqahFblUxnlh/Pzcz/mq/beudvL3lO9q3HReekjszbdlbEP
         0RDuEEOa7x3sK+KAZF+sULI6YMilroslncTIweE1SVeux1NB48aZCTk/sqTRwcK5Ks4M
         +nYtTeaw9sILFTf8xmZTzFtVKcW5Sf6F611wabur1z+04k+0SgIfEA4F7cc4cnxoREvw
         1PhQ==
X-Gm-Message-State: AOAM532R01CnOdwFP6jFg79KkOubV7SAx+OC93q7arzUZeTAaB9Wwc9h
        SRqDyMua5ngaHzcGRtW4NwH789HWxg==
X-Google-Smtp-Source: ABdhPJx1qtYaiwuI0WnLa7ET2uBlBwt+jJZcV45wjauHWImhM3vIaQgljQ4NKCifrB4FrBLJqNNfRA==
X-Received: by 2002:a05:6870:c1cb:b0:dd:b81f:3ea1 with SMTP id i11-20020a056870c1cb00b000ddb81f3ea1mr4004298oad.131.1649257723709;
        Wed, 06 Apr 2022 08:08:43 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id fw15-20020a056870080f00b000ddc3ec2533sm6547545oab.9.2022.04.06.08.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 08:08:43 -0700 (PDT)
Received: (nullmailer pid 2253710 invoked by uid 1000);
        Wed, 06 Apr 2022 15:08:42 -0000
Date:   Wed, 6 Apr 2022 10:08:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     linux-wireless@vger.kernel.org, mka@chromium.org,
        ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 01/12] dt: bindings: net: add bindings of WCN6750 for
 ath11k
Message-ID: <Yk2s+srO9DKP7xW1@robh.at.kernel.org>
References: <20220406094107.17878-1-quic_mpubbise@quicinc.com>
 <20220406094107.17878-2-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406094107.17878-2-quic_mpubbise@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 06 Apr 2022 15:10:55 +0530, Manikanta Pubbisetty wrote:
> WCN6750 is the WLAN chip on Qualcomm Snapdragon SoC SC7280;
> Though being a PCIe based solution, it is not attached to
> the APSS processor (Application Processor SubSystem), it is
> instead attached to another tiny processor called WPSS Q6
> processor (Wireless Processor SubSystem) on the SC7280 MSM,
> where the WLAN firmware runs, and it is the WLAN firmware
> running on the Q6 processor which enumerates WCN6750, as a
> result APPS processor would never know such a device being
> present in the system and would not detect the WCN6750
> hardware unless and otherwise WCN6750 is registered as a
> platform device. This is the reason behind adding WCN6750
> WLAN node in the device tree.
> 
> Add WCN6750 wireless driver support, its based on ath11k driver.
> 
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> ---
>  .../bindings/net/wireless/qcom,ath11k.yaml    | 361 ++++++++++++------
>  1 file changed, 252 insertions(+), 109 deletions(-)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

