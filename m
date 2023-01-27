Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA3F67E015
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jan 2023 10:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbjA0J1Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Jan 2023 04:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjA0J1P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Jan 2023 04:27:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E17E8E;
        Fri, 27 Jan 2023 01:27:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEFE2B82003;
        Fri, 27 Jan 2023 09:27:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725C0C433D2;
        Fri, 27 Jan 2023 09:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674811631;
        bh=IP8XQVekAM9mHuY06ZWqOuoTQwvtHPkkz3YM+kuwnDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XmHpi6saycX0TD7QFyrQvbWBBTZvGSrIKTqLU+PphCv4rAmWQBpoUAuGRbjOwvC1B
         Tz1Mk6gutw/NJgv7RoUle8L4bngrf7EaKLKeym3oE5RwUfEOHRSvhp+lW1qIwlgvwM
         2GFNlpIZgrOjXmaqYyEypGiVBsAPKqYmD5p0PisIoTT6erSqDaB0J3NNnnfx9b7uS1
         ejxywKxpejXwwNaZM2rVAnhmrDGUPZxxoPS05AZOPwik93Saml7WkC2c2vGq4w3tRg
         IeWv21FbymR9FVDnD0V0Z1X7++3wPJAyRYM5ftiO2Z9XzNK25Iuo1QQnWJ3XJEwd1u
         9OohtF2l+m45w==
Date:   Fri, 27 Jan 2023 09:27:04 +0000
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
Message-ID: <Y9OY6GBAePQ/Y6R2@google.com>
References: <0d0de1bc949d24e08174205c13c0b59bd73c1ea8.1674384302.git.geert+renesas@glider.be>
 <167460363944.4058.4676712965831302643.git-patchwork-notify@kernel.org>
 <Y9FG5Wg0PmP4zfV6@google.com>
 <CABBYNZJEU-GD5J6K8_Ur4PWLvP10VNJGP7e_43H0=W3DOS=PNw@mail.gmail.com>
 <Y9IzMWnOq+r2/4V2@google.com>
 <CABBYNZ+Na7os7D_C_iV22UhyhobxiETjKkngPWVr14QAph6DfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZ+Na7os7D_C_iV22UhyhobxiETjKkngPWVr14QAph6DfQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 26 Jan 2023, Luiz Augusto von Dentz wrote:

> Hi Lee,
> 
> On Thu, Jan 26, 2023 at 12:00 AM Lee Jones <lee@kernel.org> wrote:
> >
> > On Wed, 25 Jan 2023, Luiz Augusto von Dentz wrote:
> >
> > > Hi Lee,
> > >
> > > On Wed, Jan 25, 2023 at 7:16 AM Lee Jones <lee@kernel.org> wrote:
> > > >
> > > > On Tue, 24 Jan 2023, patchwork-bot+bluetooth@kernel.org wrote:
> > > >
> > > > > Hello:
> > > > >
> > > > > This patch was applied to bluetooth/bluetooth-next.git (master)
> > > > > by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
> > > > >
> > > > > On Sun, 22 Jan 2023 11:47:27 +0100 you wrote:
> > > > > > Add the missing trigger patterns for Bluetooth and WLAN activity, which
> > > > > > are already in active use.
> > > > > >
> > > > > > While at it, move the mmc pattern comment where it belongs, and restore
> > > > > > alphabetical sort order.
> > > > > >
> > > > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > > >
> > > > > > [...]
> > > > >
> > > > > Here is the summary with links:
> > > > >   - [v2] dt-bindings: leds: Document Bluetooth and WLAN triggers
> > > > >     https://git.kernel.org/bluetooth/bluetooth-next/c/ef017002b93b
> > > >
> > > > Why are you taking LED patches through the Bluetooth tree?
> > >
> > > I assume there isn't a tree dedicated to dt-bindings/leds
> >
> > % ./scripts/get_maintainer.pl -f Documentation/devicetree/bindings/leds/common.yaml
> >  Pavel Machek <pavel@ucw.cz> (maintainer:LED SUBSYSTEM,in file)
> >  Lee Jones <lee@kernel.org> (maintainer:LED SUBSYSTEM)
> >  Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> >  Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> >  Jacek Anaszewski <jacek.anaszewski@gmail.com> (in file)
> >  linux-leds@vger.kernel.org (open list:LED SUBSYSTEM)
> >  devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> >  linux-kernel@vger.kernel.org (open list)
> 
> Well this doesn't tell us what parts of the dt_bindings have a
> dedicated tree and which doesn't, anyway this doesn't show
> linux-bluetooth so I wonder why people are CCing it.

It is not possible to infer responsibilities from how contributors craft
their submissions.  The only reliable way to do that is to check the
MAINTAINERS file.

According to the MAINTAINERS excerpt below [0] if a commit only touches
files contained in; drivers/bluetooth/, include/net/bluetooth/ and/or
net/bluetooth/ AND there are no build-time dependencies or dependents,
they are yours to process how you see fit.  However, if commits ALSO touch
files outside of those directories OR do have dependencies or
dependents, you will need to consult with the other affected maintainers
to agree on a strategy for merging them.  If the aforementioned
directories are not touched (as in this case), you can safely ignore
them - regardless of which mailing list(s) or individual's inboxes they
end up in.

Does that help at all?

[0]

BLUETOOTH DRIVERS
M:      Marcel Holtmann <marcel@holtmann.org>
M:      Johan Hedberg <johan.hedberg@gmail.com>
M:      Luiz Augusto von Dentz <luiz.dentz@gmail.com>
L:      linux-bluetooth@vger.kernel.org
S:      Supported
W:      http://www.bluez.org/
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.g
F:      drivers/bluetooth/

BLUETOOTH SUBSYSTEM
M:      Marcel Holtmann <marcel@holtmann.org>
M:      Johan Hedberg <johan.hedberg@gmail.com>
M:      Luiz Augusto von Dentz <luiz.dentz@gmail.com>
L:      linux-bluetooth@vger.kernel.org
S:      Supported
W:      http://www.bluez.org/
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.g
F:      include/net/bluetooth/
F:      net/bluetooth/

-- 
Lee Jones [李琼斯]
