Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFC36F8623
	for <lists+linux-wireless@lfdr.de>; Fri,  5 May 2023 17:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjEEPrO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 May 2023 11:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjEEPrM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 May 2023 11:47:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2638DA5C6
        for <linux-wireless@vger.kernel.org>; Fri,  5 May 2023 08:47:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 831DE63F03
        for <linux-wireless@vger.kernel.org>; Fri,  5 May 2023 15:47:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1038C433D2;
        Fri,  5 May 2023 15:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683301630;
        bh=hcJLn7o1pEOxi+BEG+HZhDZG/SR2g3s1ihiZu0m/v3o=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=DZelFOJ7W7PlzOlh6sXUYujdwFc5mPvBwl4lBPv8FzM5Gj3lVYS+pcHdQ/1+ILgBi
         Fy76cFCE9bSvQR67xOKs5FqNzTCwCGZwiNemg58tebk7JHpUnWjsWbxSPfEt2+WCta
         OCe06RQ7Ukk7svCDs/mgx2FZBlLQAE7icuw3Dwc4va4Fag4QbgJAJliQ70PhfzPWKj
         WDdg2e7B1Cl2VRw0P2V+ddwqx68e7hItcrBt6wk03XBOjGMZsEAWXD7BZaprvh2Sis
         7IT8LUmWML/xnGG96L/4Lruq/rFW+6FwzKD6K03b0XVSMbos6cy9x6VJsIBPRsyAG9
         o8iSsVBBtPOHg==
From:   Kalle Valo <kvalo@kernel.org>
To:     <Ajay.Kathat@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>,
        <Sripad.Balwadgi@microchip.com>, <mwalle@kernel.org>
Subject: Re: [PATCH] wifi: wilc1000: fix kernel oops during interface down during background scan
References: <20230404012010.15261-1-ajay.kathat@microchip.com>
Date:   Fri, 05 May 2023 18:47:07 +0300
In-Reply-To: <20230404012010.15261-1-ajay.kathat@microchip.com> (Ajay Kathat's
        message of "Tue, 4 Apr 2023 01:20:50 +0000")
Message-ID: <87wn1mok5g.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Ajay.Kathat@microchip.com> writes:

> Fix for kernel crash observed with following test procedure [1]:
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
> 1. https://lore.kernel.org/linux-wireless/20221024135407.7udo3dwl3mqyv2yj@0002.3ffe.de/
>
> Reported-by: Michael Walle <mwalle@kernel.org>
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>

[...]

> @@ -781,13 +776,15 @@ static int wilc_mac_close(struct net_device *ndev)
>  	if (vif->ndev) {
>  		netif_stop_queue(vif->ndev);
>
> +		if (wl->open_ifcs == 0)
> +			wl->close = 1;
> +

wl-close is an int, I wonder if it's racy to int as a flag like this? In
cases like this I usually use set_bit() & co because those guarantee
atomicity, though don't know if that's overkill.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
