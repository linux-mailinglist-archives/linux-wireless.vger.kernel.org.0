Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D667766024
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jul 2023 01:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjG0XKJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jul 2023 19:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjG0XKI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jul 2023 19:10:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF26B13D
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 16:10:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 627C261F74
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 23:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16CAC433C7;
        Thu, 27 Jul 2023 23:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690499405;
        bh=9zQTmGt2IDwZsq6/T+aSYHUVDIWATYA1sOOsrcSJvQQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fl89lgjlYZ6LtchwWmtnCF+5SAJoTBJnN3bWaXpwFmJQHEqghkryihjNjVIDHoRpx
         MhsvPVylzrROyc7EggDbnRqwzJ+0araq6AfaIbdlicgbsMRWTfiVjFHvxnWnC5pbEO
         PK9g8nACSitOX+OffuVEeyqCmf+gAkEsja8XlpvB7Eaq3RZhLOhJBOTiI/nfobd2Jt
         M6cXgVYjTSr1c+pXyP6ZikBMEfLvkUvxewmDrHAF1DET07pBSkJ8qFMsMVGjOcScqK
         l4einwSXHh9BzvJsS0RrbadVQO23co453TWI9h5SUSVDnY0yes41yJXxRnGc9KU/31
         sc3lLMzQxifWA==
Date:   Thu, 27 Jul 2023 16:10:04 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Adam Elzinga <adamelzinga@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: MT7601U Kernel Driver Issue
Message-ID: <20230727161004.1ec06124@kernel.org>
In-Reply-To: <CACXZ32oQ4GzDLPqu6MWr7rn38OOdw7metSFPHdbj1NTXeicaxA@mail.gmail.com>
References: <CACXZ32oQ4GzDLPqu6MWr7rn38OOdw7metSFPHdbj1NTXeicaxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 27 Jul 2023 16:00:45 -0400 Adam Elzinga wrote:
> Hi Jakub,
> 
> I've been experimenting with your mt7601u kernel driver (both building from
> source and built-in to kernel 4.14.98 and 5.19.0) and think there may be a
> bug when reading EEPROM values from a couple different mt7601u-based
> devices. Full issue report is posted here:
> https://github.com/kuba-moo/mt7601u/issues/94
> 
> In short, are these EEPROM values unexpected, they seem to be the cause of
> repeated kernel warnings?
> 
> RF freq offset: 5d
> RSSI offset: 0 0
> Reference temp: f9
> LNA gain: 0
> Reg channels: 1-14
> Per rate power:
>          raw:00 bw20:00 bw40:02
>          raw:00 bw20:00 bw40:02
>          raw:34 bw20:f4 bw40:f6
>          raw:34 bw20:f4 bw40:f6
>          raw:34 bw20:f4 bw40:f6
>          raw:34 bw20:f4 bw40:f6
>          raw:34 bw20:f4 bw40:f6
>          raw:34 bw20:f4 bw40:f6
>          raw:34 bw20:f4 bw40:f6
>          raw:34 bw20:f4 bw40:f6
> Per channel power:
>          tx_power  ch1:04 ch2:04
>          tx_power  ch3:04 ch4:04
>          tx_power  ch5:04 ch6:04
>          tx_power  ch7:04 ch8:04
>          tx_power  ch9:05 ch10:05
>          tx_power  ch11:05 ch12:05
>          tx_power  ch13:05 ch14:05
> 
> Emailing you directly as I realize your GitHub repo is no longer maintained
> now that the driver is included in the Linux kernel. Apologies if this is
> not the proper way to report an issue.

I saw the GH issue, just didn't get to it yet :) I'm adding
the linux-wireless@ mailing list to the CC as is customary
(if you reply please make sure not to top post and not to send 
HTML emails, only plain text).

I think that as you mentioned on GH the warning is harmless.
The vendor driver just caps the value to 6 bits (it's in 
the MT7601_ReadTxPwrPerRate() function AFAICT in the driver 
from here:
https://www.mediatek.com/products/broadband-wifi/mt7601u )

If you are able to compile the vendor driver it may be a good idea
to check that my calculation gives the same result. At which point
we can confidently remove the warning. Would you be willing to send
a patch yourself?
