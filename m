Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F7C545E28
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jun 2022 10:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346667AbiFJIHb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jun 2022 04:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343985AbiFJIH3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jun 2022 04:07:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BC91C91B
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jun 2022 01:07:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7319B832A1
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jun 2022 08:07:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF670C34114;
        Fri, 10 Jun 2022 08:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654848446;
        bh=Hri9bZopbOZRC4W9Rc7msEMhZmR2vjwJGOVHGcWWb1o=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ZTIsa3qLD8MIZGBRBu22wQBaV6leOPzxCRS0b9z3YsgS1dBZ0uZQu+R4y6i1nRknb
         5M+uoEdz3C2bM93JrFSWzjENRdVP2OgjqemrAZUTlsB7SAFgsfZF6/sReDNMSB/GwK
         f92ekvHoP/JyLObjLURNw+5ZDi9hA8v04gS4FOBmJddLrETsGzx4m7fh09LjcA+RFS
         cEeBMNjWiFUCXeKEYHRTYaDqzVfU/jw3sJh/VAlcCNd2tNgLGkm55gZ+krqRFR+65u
         34ENKZyPWfdnpW8RovYDR0IGnDFvDNr7D2lSR9LDoUeNqiMsdUNrrGaOVz+COre8SB
         IX5pxrR/PyPKw==
From:   Kalle Valo <kvalo@kernel.org>
To:     =?utf-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH wireless] dt-bindings: net: wireless: change Kalle's email
References: <20220610075944.23787-1-kvalo@kernel.org>
Date:   Fri, 10 Jun 2022 11:07:23 +0300
In-Reply-To: <20220610075944.23787-1-kvalo@kernel.org> (Kalle Valo's message
        of "Fri, 10 Jun 2022 10:59:44 +0300")
Message-ID: <87y1y5q6v8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> writes:

> From: Kalle Valo <quic_kvalo@quicinc.com>
>
> My codeaurora.org email doesn't work anymore, so switch to my preferred
> kernel.org address.
>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

[...]

> --- a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Qualcomm Atheros ath9k wireless devices Generic Binding
>  
>  maintainers:
> -  - Kalle Valo <kvalo@codeaurora.org>
> +  - Kalle Valo <kvalo@kernel.org>

Oh, I didn't notice this is ath9k. Toke, can I change it to your address?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
