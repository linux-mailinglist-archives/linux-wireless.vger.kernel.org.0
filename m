Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97AC267C558
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jan 2023 09:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236251AbjAZIBG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Jan 2023 03:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236249AbjAZIBD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Jan 2023 03:01:03 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5317669B23;
        Thu, 26 Jan 2023 00:00:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BBB69CE0FE6;
        Thu, 26 Jan 2023 08:00:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37ED4C4339B;
        Thu, 26 Jan 2023 08:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674720056;
        bh=w0GyxWtuZcSCJLuH4x+Imjzwl60UHza1uCdMsCstLZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=In7j/G3aHj0zUfdQn9EUP96LDFSx8DSrzm8RD3NDnpy15PMsiUtL0U7JIiRMPSUag
         +9DAns2GS9mFk0oKN9/ixWhHGTYa4t86Ow4n9LOORddrI52CtVC/smabFlaGjfSUWU
         j5jl7qZ/fFpHEruQI5KrLy0JYrUZBSJE6PAC7UiYo5mOpGkIbLw5PJW2wDvjWt6TxE
         85Hd3wcczhWI4GYDrbWoOeX83mk7jKmkGdIhHXTdCmtVML8ZxBw1t7sSz/bsfLS2T8
         FqfPyQkCfzj6mjaJ8Ko5iGeyttiKTIFIysh98qTRp5dUYw4lxK5AjRVQBzYUQXWiup
         XOYhf9wX0SBqw==
Date:   Thu, 26 Jan 2023 08:00:49 +0000
From:   Lee Jones <lee@kernel.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     patchwork-bot+bluetooth@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        robh@kernel.org
Subject: Re: [PATCH v2] dt-bindings: leds: Document Bluetooth and WLAN
 triggers
Message-ID: <Y9IzMWnOq+r2/4V2@google.com>
References: <0d0de1bc949d24e08174205c13c0b59bd73c1ea8.1674384302.git.geert+renesas@glider.be>
 <167460363944.4058.4676712965831302643.git-patchwork-notify@kernel.org>
 <Y9FG5Wg0PmP4zfV6@google.com>
 <CABBYNZJEU-GD5J6K8_Ur4PWLvP10VNJGP7e_43H0=W3DOS=PNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZJEU-GD5J6K8_Ur4PWLvP10VNJGP7e_43H0=W3DOS=PNw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 25 Jan 2023, Luiz Augusto von Dentz wrote:

> Hi Lee,
> 
> On Wed, Jan 25, 2023 at 7:16 AM Lee Jones <lee@kernel.org> wrote:
> >
> > On Tue, 24 Jan 2023, patchwork-bot+bluetooth@kernel.org wrote:
> >
> > > Hello:
> > >
> > > This patch was applied to bluetooth/bluetooth-next.git (master)
> > > by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
> > >
> > > On Sun, 22 Jan 2023 11:47:27 +0100 you wrote:
> > > > Add the missing trigger patterns for Bluetooth and WLAN activity, which
> > > > are already in active use.
> > > >
> > > > While at it, move the mmc pattern comment where it belongs, and restore
> > > > alphabetical sort order.
> > > >
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > >
> > > > [...]
> > >
> > > Here is the summary with links:
> > >   - [v2] dt-bindings: leds: Document Bluetooth and WLAN triggers
> > >     https://git.kernel.org/bluetooth/bluetooth-next/c/ef017002b93b
> >
> > Why are you taking LED patches through the Bluetooth tree?
> 
> I assume there isn't a tree dedicated to dt-bindings/leds

% ./scripts/get_maintainer.pl -f Documentation/devicetree/bindings/leds/common.yaml
 Pavel Machek <pavel@ucw.cz> (maintainer:LED SUBSYSTEM,in file)
 Lee Jones <lee@kernel.org> (maintainer:LED SUBSYSTEM)
 Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
 Jacek Anaszewski <jacek.anaszewski@gmail.com> (in file)
 linux-leds@vger.kernel.org (open list:LED SUBSYSTEM)
 devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
 linux-kernel@vger.kernel.org (open list)

> not to mention this was submitted to linux-bluetooth and nobody else
> other than Rob reviewed it,

To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
    Rob Herring <robh+dt@kernel.org>,
    Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
    Jacek Anaszewski <jacek.anaszewski@gmail.com>                                      
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
    linux-wireless@vger.kernel.org, linux-bluetooth@vger.kernel.org,
    linux-renesas-soc@vger.kernel.org,
    Geert Uytterhoeven <geert+renesas@glider.be>,
    Rob Herring <robh@kernel.org>

> anyway I'd be happy if the dt-bindings patches
> would be handled elsewhere.

Yep, we got this. :)

-- 
Lee Jones [李琼斯]
