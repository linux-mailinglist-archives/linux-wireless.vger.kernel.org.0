Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159E367B5A5
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jan 2023 16:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbjAYPNT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Jan 2023 10:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235562AbjAYPNR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Jan 2023 10:13:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA895867F;
        Wed, 25 Jan 2023 07:12:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4EF760AC5;
        Wed, 25 Jan 2023 15:12:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEA6C433D2;
        Wed, 25 Jan 2023 15:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674659563;
        bh=jDddyi1PUAaGX1ZpDwTpMyuoepvDXtvrLNrPQvKb12k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r9yOqiteNFl+qIe6GMQpaT3rZgr9v0MZAr4DOztZxnANUk/Ml4OLyrF87xrPNHhXj
         FxE23xkUHeXbSxfFXfcWBexYfGphFRhd0MYH0074mfOQDzrnuOV/z7YwVQXeEAbtv5
         joXSkIjqnyrAkKG/K62kb3uhmb/ggpM65L2bjkonK20Z0QIdDx6kmfnRqQ3X1W0hja
         umzp6/nXxHDfG0xPeAyeDsh//a4RPunyaqMv26oQSH4J+jbmBlH6qVnZkEybk/cLhk
         frc6DhJR/REis67oE2AXVkq4QaNId8kx8DCMIags0QnoQRCKgg4VBmZA3L+zpTnxdb
         YaZYYdAcTGx9Q==
Date:   Wed, 25 Jan 2023 15:12:37 +0000
From:   Lee Jones <lee@kernel.org>
To:     patchwork-bot+bluetooth@kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        robh@kernel.org
Subject: Re: [PATCH v2] dt-bindings: leds: Document Bluetooth and WLAN
 triggers
Message-ID: <Y9FG5Wg0PmP4zfV6@google.com>
References: <0d0de1bc949d24e08174205c13c0b59bd73c1ea8.1674384302.git.geert+renesas@glider.be>
 <167460363944.4058.4676712965831302643.git-patchwork-notify@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <167460363944.4058.4676712965831302643.git-patchwork-notify@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 24 Jan 2023, patchwork-bot+bluetooth@kernel.org wrote:

> Hello:
> 
> This patch was applied to bluetooth/bluetooth-next.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
> 
> On Sun, 22 Jan 2023 11:47:27 +0100 you wrote:
> > Add the missing trigger patterns for Bluetooth and WLAN activity, which
> > are already in active use.
> > 
> > While at it, move the mmc pattern comment where it belongs, and restore
> > alphabetical sort order.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > 
> > [...]
> 
> Here is the summary with links:
>   - [v2] dt-bindings: leds: Document Bluetooth and WLAN triggers
>     https://git.kernel.org/bluetooth/bluetooth-next/c/ef017002b93b

Why are you taking LED patches through the Bluetooth tree?

-- 
Lee Jones [李琼斯]
