Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29BA77C91D
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Aug 2023 10:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbjHOIHB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Aug 2023 04:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235558AbjHOIG7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Aug 2023 04:06:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269A31733;
        Tue, 15 Aug 2023 01:06:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA053614E4;
        Tue, 15 Aug 2023 08:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF7DC433C7;
        Tue, 15 Aug 2023 08:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692086816;
        bh=mUQxZ4Mtp+QHlrdWnVpjORf3UPAKZsHLRbyV936Phd8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LTFe6erunt94BbhL15CBe7Yr2Xi1feLcdqRsFNRhPim7l1mhyZq5y9SMUlCki53Aq
         yFRfVGKhJlpzxICd0rspXzxCHd6E4/RELRKmkgt8h656GFmf8ncCb3fugKaQCu7Jka
         M7D6x6ojxJ+pj2YW8hCzRkilKcxleq0HMuOpTVDde1djCLCbKUziplQjjto8d47dbe
         5o6UbyN6D+7tB21fGmhb8cKLmZkvpY+qw3QQ2Y/hzdG9XDl+1RrvFcX/cAkFqjcMnu
         AvV0OyYrP0+RxP9a9NU/m2dhm7gEe+vl0kuvXw3JAX99i/O/+JUTgMWT8/SiVia8E5
         aHwCYulNMSLgg==
Date:   Tue, 15 Aug 2023 10:06:50 +0200
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
Subject: Re: [PATCH net-next v3 5/5] wlcore: spi: Remove redundant
 of_match_ptr()
Message-ID: <ZNsyGjC9zrg4DAvQ@vergenet.net>
References: <20230814025520.2708714-2-ruanjinjie@huawei.com>
 <20230814025520.2708714-6-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814025520.2708714-6-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Aug 14, 2023 at 10:55:19AM +0800, Ruan Jinjie wrote:
> The driver depends on CONFIG_OF, it is not necessary to use
> of_match_ptr() here.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

