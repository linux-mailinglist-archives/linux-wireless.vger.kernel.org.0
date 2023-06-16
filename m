Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B227335D9
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 18:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244763AbjFPQUK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 12:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345661AbjFPQTz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 12:19:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D94423E;
        Fri, 16 Jun 2023 09:18:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D85BF618BB;
        Fri, 16 Jun 2023 16:17:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2B5C433C0;
        Fri, 16 Jun 2023 16:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686932236;
        bh=S8SFMN20YyS2xfNsshsCq2Vavr7dBJyysliO/cqZNrU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=R2lEKsTaJ7pU9XW5bEXWrWcENH87NMvBZQ6kh6ZDyw4EWNSx5YkNe09F346U4CpQy
         YUiz6c1JoMVGLU8w6h7hF9Z3NlkqFKKcMffZ+bh0oUzSeyL2JcusKqCCL120KltSm1
         xgxyH8411xSdvqkBA0YByAZyac3v8faQsrjwrmM03BZIL/YXKVgHDcumvjuiT08+lQ
         H1Q56N9Scx9mfF9Qjy1X/k/s6Q+sefQSXwbQy1WxKvuYcZEubSYC0BpGlToGE/YBFA
         yyVDNpCZN/KPE4EUrScVNJOzutoc27C+i1pzuRKp+4DSLuqvWywoxgHUoExszJQdFM
         X7LFkyWwHuZQw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] dt-bindings: net: wireless: ath10k: add
 ieee80211-freq-limit property
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <c33c928b7c6c9bb4e7abe84eb8df9f440add275b.1686486464.git.chunkeey@gmail.com>
References: <c33c928b7c6c9bb4e7abe84eb8df9f440add275b.1686486464.git.chunkeey@gmail.com>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168693223258.12400.17129558152991659679.kvalo@kernel.org>
Date:   Fri, 16 Jun 2023 16:17:14 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christian Lamparter <chunkeey@gmail.com> wrote:

> This is an existing optional property that ieee80211.yaml/cfg80211
> provides. It's useful to further restrict supported frequencies
> for a specified device through device-tree.
> 
> For testing the addition, I added the ieee80211-freq-limit
> property with values from an OpenMesh A62 device. This is
> because the OpenMesh A62 has "special filters in front of
> the RX+TX paths to the 5GHz PHYs. These filtered channel
> can in theory still be used by the hardware but the signal
> strength is reduced so much that it makes no sense."
> 
> The driver supported this since ~2018 by
> commit 34d5629d2ca8 ("ath10k: limit available channels via DT ieee80211-freq-limit")
> 
> Link: https://git.openwrt.org/?p=openwrt/openwrt.git;a=commit;h=e3b8ae2b09e137ce2eae33551923daf302293a0c
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

7f6ee56ca0df dt-bindings: net: wireless: ath10k: add ieee80211-freq-limit property

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/c33c928b7c6c9bb4e7abe84eb8df9f440add275b.1686486464.git.chunkeey@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

