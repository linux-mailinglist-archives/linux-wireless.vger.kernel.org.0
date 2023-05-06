Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A7B6F8EF1
	for <lists+linux-wireless@lfdr.de>; Sat,  6 May 2023 07:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjEFF5q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 6 May 2023 01:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjEFF5p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 6 May 2023 01:57:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9625A59F1;
        Fri,  5 May 2023 22:57:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31AC261652;
        Sat,  6 May 2023 05:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA2FC433EF;
        Sat,  6 May 2023 05:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683352663;
        bh=IyMNY80K4e6krSfMaZebNc3EY/ZKbcRWGLo/NNEnBu0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=SLnYw0KiolBm/PQAEoggPlMBTSJkMwNSqB7zi0A3Ec6FbTGekAPFie8zRy5+6kvFz
         C4Dt+U6K9F1Pg1kjlspvsgmIlRf+W3QKRJMkYQb5jgZvEbX59VJyUnRo8bnKtgL6lN
         WAcxNX9vCdHaSj8vb3CMLb+yNGbJYZrA4WkZ2TGgghoNHvCm2PCxeYh/wPKK2ai3ZQ
         B4sES8KWkzn/D5rnUTAhOpZXakWU32HsvaGZtB18RxfzxMHNN/fCUy+nr5O97Kau2O
         586nwrxXKds+BJv2ix1V4P5FN6U+OG+YgeflBM7qw8MrbdyFlXsnQShvxwaFMc1gim
         fMi8Bf0u7tTtg==
From:   Kalle Valo <kvalo@kernel.org>
To:     <Ajay.Kathat@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>,
        <Sripad.Balwadgi@microchip.com>, <stable@vger.kernel.org>,
        <mwalle@kernel.org>
Subject: Re: [PATCH v2] wifi: wilc1000: fix kernel oops during interface down during background scan
References: <20230505232902.22651-1-ajay.kathat@microchip.com>
Date:   Sat, 06 May 2023 08:57:40 +0300
In-Reply-To: <20230505232902.22651-1-ajay.kathat@microchip.com> (Ajay Kathat's
        message of "Fri, 5 May 2023 23:42:51 +0000")
Message-ID: <87jzxmngrv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Ajay.Kathat@microchip.com> writes:

> Fix for kernel crash observed with following test procedure:
>   while true;
>     do ifconfig wlan0 up;
>     iw dev wlan0 scan &
>     ifconfig wlan0 down;
>   done
>
> During the above test procedure, the scan results are received from firmware
> for 'iw scan' command gets queued even when the interface is going down. It
> was causing the kernel oops when dereferencing the freed pointers.
>
> For synchronization, 'mac_close()' calls flush_workqueue() to block its
> execution till all pending work is completed. Afterwards 'wilc->close' flag
> which is set before the flush_workqueue() should avoid adding new work.
> Added 'wilc->close' check in wilc_handle_isr() which is common for
> SPI/SDIO bus to ignore the interrupts from firmware that inturns adds the
> work since the interface is getting closed.
>
> Also, removed isr_uh_routine() as it's not necessary after 'wl->close' check
> is added in wilc_handle_isr(). So now the default primary handler would be
> used for threaded IRQ.
>
> Cc: stable@vger.kernel.org
> Reported-by: Michael Walle <mwalle@kernel.org>
> Link: https://lore.kernel.org/linux-wireless/20221024135407.7udo3dwl3mqyv2yj@0002.3ffe.de/
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
> ---
>  changes since v1:
>   - updated commit description and included 'Link:' tag
>   - use atomic_t type for 'close' variable
>   - set close state after clearing ongoing scan operation
>   - make use of default primary handler for threaded_irq
>   - avoid false failure debug message during mac_close

Like I said in v1, atomic_t with only values 0 and 1 does not really
make sense.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
