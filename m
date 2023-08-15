Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB45877C91B
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Aug 2023 10:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbjHOIG3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Aug 2023 04:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235546AbjHOIF4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Aug 2023 04:05:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CDF10D8;
        Tue, 15 Aug 2023 01:05:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 472006157D;
        Tue, 15 Aug 2023 08:05:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35205C433C8;
        Tue, 15 Aug 2023 08:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692086754;
        bh=5Ljew4cQNTDpEZhaF0GRxtadOljJgR6ImBglPGo+hRY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LwctDhYJMNwfFCmT/7P/5zOpYP4li2pzW9OY5NqOurX9zbTuFQGfniKFmmP0XedmN
         KpKVFkonyZeoSLVAnurdEvgPN3dbQ0qwwXWrp25m03ih1dGKcSe3ndPM1c0IgW6iFh
         uM3N7YQFE6hvQWuLbWm8wPbo41zIOBLLsa5FEamAZqVilfz6FM7spWh3qddHVxaqXe
         jxxpipYEsEbfB0Jh57aahiqFB6fr1F6qRPlFIp8l2sKj/ZkLL0cb0S7iy+pRmkqxW9
         97KdvJ1wha4/jfF/5esm2rG7rYUctvx5GEE+h6UFlkkf9qw+dC2xE87TfppZ2NUHo/
         ThCm9r9ze8znA==
Date:   Tue, 15 Aug 2023 10:05:48 +0200
From:   Simon Horman <horms@kernel.org>
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
        f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        clement.leger@bootlin.com, ulli.kroll@googlemail.com,
        kvalo@kernel.org, bhupesh.sharma@linaro.org, robh@kernel.org,
        elder@linaro.org, wei.fang@nxp.com, nicolas.ferre@microchip.com,
        simon.horman@corigine.com, romieu@fr.zoreil.com,
        dmitry.torokhov@gmail.com, netdev@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/5] net: qualcomm: Remove redundant
 of_match_ptr()
Message-ID: <ZNsx3AfhC0XAe+RB@vergenet.net>
References: <20230814025520.2708714-2-ruanjinjie@huawei.com>
 <20230814025520.2708714-5-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814025520.2708714-5-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Aug 14, 2023 at 10:55:18AM +0800, Ruan Jinjie wrote:
> The driver depends on CONFIG_OF, it is not necessary to use
> of_match_ptr() here.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>
