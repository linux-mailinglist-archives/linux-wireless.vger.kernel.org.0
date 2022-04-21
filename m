Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE36509691
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Apr 2022 07:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377199AbiDUFWB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Apr 2022 01:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbiDUFWA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Apr 2022 01:22:00 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55B4DC7C;
        Wed, 20 Apr 2022 22:19:10 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 92A19811B;
        Thu, 21 Apr 2022 05:16:18 +0000 (UTC)
Date:   Thu, 21 Apr 2022 08:19:08 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Yegor Yefremov <yegorslists@googlemail.com>
Cc:     Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-wireless@vger.kernel.org, sebastian.reichel@collabora.co.uk,
        Eyal Reizer <eyalr@ti.com>
Subject: Re: wl18xx: NVS file handling
Message-ID: <YmDpTAu9wmlLijDA@atomide.com>
References: <CAGm1_ktEim1vGOf5i=H_sqrPvg=dT50790YYwXgYKgAut-a=ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGm1_ktEim1vGOf5i=H_sqrPvg=dT50790YYwXgYKgAut-a=ng@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

* Yegor Yefremov <yegorslists@googlemail.com> [220420 13:58]:
> Hi all,
> 
> using the 5.18.x kernel, I get the following warning:
> 
> wlcore: WARNING Detected unconfigured mac address in nvs, derive from
> fuse instead.
> wlcore: WARNING This default nvs file can be removed from the file system
> 
> removing the /lib/firmware/ti-connectivity/wl127x-nvs.bin file, I get
> this warning:
> 
> wl18xx_driver wl18xx.0.auto: Direct firmware load for
> ti-connectivity/wl1271-nvs.bin failed with error -2
> 
> What's the best way to get rid of these warnings when I don't want to
> handle WLAN's MAC address via the wl127x-nvs.bin?

See commit d382b9c00782 ("wlcore: add missing nvs file name info for
wilink8"), to me looks like the the second warning should be just removed
for wl18xx.

> According to this discussion [1], NVS file is the last resort for
> handling the MAC address.
> 
> [1] https://patchwork.kernel.org/project/linux-wireless/patch/8665E2433BC68541A24DFFCA87B70F5B363E1A3D@DFRE01.ent.ti.com/

Yes the NVS file does not work at all for NFSroot for multiple devices.

To me it seems we should have the option for the MAC address to be
populated by the bootloader for the devicetree property like Ethernet
adapters typically do. Not sure what that might take, maybe it
already works. I guess the first step would be to make the nvs file
completely optional for wlcore.

Regards,

Tony


