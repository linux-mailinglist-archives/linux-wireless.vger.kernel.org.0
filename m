Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B534EB6DF
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Mar 2022 01:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240719AbiC2Xjg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Mar 2022 19:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbiC2Xjg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Mar 2022 19:39:36 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7E918A3EC;
        Tue, 29 Mar 2022 16:37:52 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id k10so20591600oia.0;
        Tue, 29 Mar 2022 16:37:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZnlJJv2mTkW/GkybuP2Nvc5uQuWnGuRflKAeN/D9Jzo=;
        b=QJp7WA61+X8OIzMn82yNwnOiAM1TJO7OAKXKYoU5/Rocu3qrjfoDlzf7XGmiCn0FRH
         Whjzs0OAjXZme3+TYz8x+uDQpfUoM//+6OTBiiyIMnFn9vacCx4pr2Cdpz6dY3MsHdzm
         dwHcskZIj4mWxy7FltZhZVrpoHqqGk5bRwPqf+47OVKbDqNN4VQkgek0kZPlJ0ir9IjJ
         A5p4BU3UUEUukDBii5fsIaxXj3WEtjqsMAi3QkkceSLLKxlIublg+fgpmOgqn8XNcexu
         +L7gND1IGMZC7Z8Jx3fPkFBWdKDljl2ShE0cIe0d3H5BUNzGn/YiTfOea1mumV28pN8p
         6RJQ==
X-Gm-Message-State: AOAM531i3BsfD+/1UnQC78SK7OLbi1BH6iGsvbN91iX4ohjrCT0H4bUK
        XvXLEWWCEXMeWvnsxnn+FQ==
X-Google-Smtp-Source: ABdhPJx2l0ZTgCmk04heyRtS3320sByNAy4I0VQIQZ3u3VZYVNJBCe43kHlXeU8pdRft7J9JBcMajA==
X-Received: by 2002:a05:6808:302a:b0:2f7:6aa3:63b8 with SMTP id ay42-20020a056808302a00b002f76aa363b8mr714253oib.31.1648597071989;
        Tue, 29 Mar 2022 16:37:51 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c12-20020a9d75cc000000b005b24b061940sm9533498otl.33.2022.03.29.16.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 16:37:51 -0700 (PDT)
Received: (nullmailer pid 1572238 invoked by uid 1000);
        Tue, 29 Mar 2022 23:37:50 -0000
Date:   Tue, 29 Mar 2022 18:37:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 01/12] dt: bindings: net: add bindings of WCN6750 for
 ath11k
Message-ID: <YkOYTpTMXTEx5mAU@robh.at.kernel.org>
References: <20220328094838.14093-1-quic_mpubbise@quicinc.com>
 <20220328094838.14093-2-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328094838.14093-2-quic_mpubbise@quicinc.com>
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

On Mon, 28 Mar 2022 15:18:27 +0530, Manikanta Pubbisetty wrote:
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

Reviewed-by: Rob Herring <robh@kernel.org>
