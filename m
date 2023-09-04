Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5804E791C0D
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Sep 2023 19:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbjIDRcD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Sep 2023 13:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjIDRcD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Sep 2023 13:32:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA28DF
        for <linux-wireless@vger.kernel.org>; Mon,  4 Sep 2023 10:32:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F4A4B80EAD
        for <linux-wireless@vger.kernel.org>; Mon,  4 Sep 2023 17:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CEABC433C8;
        Mon,  4 Sep 2023 17:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693848717;
        bh=G3ycAJsKLDAmBKckajVJll6ZX67OmcF1Kd+3JsGOjtk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=B8hNZdRwEhC1rQTPdHIQkBpC3F+3YZMTsCwwH/9aGPvrRV6NadIOtyorJCNm12VNS
         ciNEfkkgfK5f5TOhSuxUEy/xfNTVQ9+p29kea09HVPyob6YjLAjtH+2mBzwLQsbs9h
         WokPYH1I5Um+tl6jM/R0/Y8j30tMMztO74NEeT+Qo3Rq39Hjplq3NfkjH8/BS/kl/R
         hBF/OWhJVoBTArHgo+1mEz8h+HUltRpk7r2FzryiwuRquTM1Y95QjblDiBMqwagnsf
         xsdX8rfArfyDgg/AwIDYyALWIBaqf1dbAFmg/HYcxGHkMhdfMKAl5P8vezE90Iq8mU
         Nfn5SgCrhcRFw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [2/2] wifi: plfxlc: use module_usb_driver()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230826200929.9756-2-rosenp@gmail.com>
References: <20230826200929.9756-2-rosenp@gmail.com>
To:     Rosen Penev <rosenp@gmail.com>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169384871438.3484948.6622493748928580929.kvalo@kernel.org>
Date:   Mon,  4 Sep 2023 17:31:56 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rosen Penev <rosenp@gmail.com> wrote:

> This follows the pattern with other USB Wifi drivers. There is nothing
> special being done in the _init and _exit functions here. Simplifies and
> saves some lines of code.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Fails to compile:

In file included from ./include/linux/device.h:32,
                 from drivers/net/wireless/purelifi/plfxlc/usb.c:8:
drivers/net/wireless/purelifi/plfxlc/usb.c:871:19: error: conflicting types for 'driver_init'; have 'int(void)'
  871 | module_usb_driver(driver);
      |                   ^~~~~~
./include/linux/device/driver.h:258:19: note: in definition of macro 'module_driver'
  258 | static int __init __driver##_init(void) \
      |                   ^~~~~~~~
drivers/net/wireless/purelifi/plfxlc/usb.c:871:1: note: in expansion of macro 'module_usb_driver'
  871 | module_usb_driver(driver);
      | ^~~~~~~~~~~~~~~~~
./include/linux/device/driver.h:241:6: note: previous declaration of 'driver_init' with type 'void(void)'
  241 | void driver_init(void);
      |      ^~~~~~~~~~~
make[7]: *** [scripts/Makefile.build:243: drivers/net/wireless/purelifi/plfxlc/usb.o] Error 1
make[6]: *** [scripts/Makefile.build:480: drivers/net/wireless/purelifi/plfxlc] Error 2
make[5]: *** [scripts/Makefile.build:480: drivers/net/wireless/purelifi] Error 2
make[4]: *** [scripts/Makefile.build:480: drivers/net/wireless] Error 2
make[3]: *** [scripts/Makefile.build:480: drivers/net] Error 2
make[2]: *** [scripts/Makefile.build:480: drivers] Error 2
make[1]: *** [/home/kvalo/projects/personal/wireless-drivers/src/wireless-next/Makefile:2032: .] Error 2
make: *** [Makefile:234: __sub-make] Error 2

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230826200929.9756-2-rosenp@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

