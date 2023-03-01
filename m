Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB68D6A67FA
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 08:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjCAHJ2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 02:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCAHJ1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 02:09:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17257297
        for <linux-wireless@vger.kernel.org>; Tue, 28 Feb 2023 23:09:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71276B80E05
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 07:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05FAC4339B;
        Wed,  1 Mar 2023 07:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677654563;
        bh=Y/N9AKtnk6BK6xdkJJee477O59Ew2mkY+9GhQPYu7lM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=KdAxVfqZQi75TRCgVTSG+JGWVlRsZvmxFcHimVZZwWFFihUUiPOj/tmCVls8EKKV5
         GilcvbsHto0/fDcSYDD4MT2MVxUchS807Nm+rj4G/fPZZaUNvqLQSq4TY5e5nZj3Fg
         mDc3FaDr/8Zwa7MMTNMpzShgvI0Rdq6wQxkqMf6L2xcVfDnxz1mbohS67gNh4URdl7
         836T0ESbcxSjyA6H7KKUDDPaFrDfKrgUNiY1Wht+/yX2zPU92F9t35vIglaCd2YL5E
         pQgYAnsMd0BzS3AITcwk79MpWxjs/rMDJOR9MHvUHfcmqaVyPaJ/8wj5rFZFF9Ad6M
         QV8A5wFvNWhcw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Dan Williams <dcbw@redhat.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 2/2] wifi: move raycs, wl3501 and rndis_wlan to legacy directory
In-Reply-To: <acc996e0b5ef1813e1073200ed50ca57b0b12934.camel@redhat.com> (Dan
        Williams's message of "Tue, 28 Feb 2023 11:37:22 -0600")
References: <20230227121732.8967-1-kvalo@kernel.org>
        <20230227121732.8967-3-kvalo@kernel.org>
        <cc905b745580b0300d10f1f88d714305c7544f67.camel@redhat.com>
        <87ilfmrkil.fsf@kernel.org>
        <c3f831e111e056c32f1822dde602e48eb764ea4f.camel@redhat.com>
        <87cz5u1ewt.fsf@kernel.org>
        <acc996e0b5ef1813e1073200ed50ca57b0b12934.camel@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Wed, 01 Mar 2023 09:09:17 +0200
Message-ID: <877cw1q76q.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Williams <dcbw@redhat.com> writes:

>> > Is the goal just to get all the .c individual drivers out of
>> > net/wireless? 
>> 
>> Yes, exactly. The extra files in drivers/net/wireless annoy me
>> everytime
>> when I'm checking something in the tree.
>
> ray_cs and wl3501_cs are also PCMCIA drivers (not CardBus) and isn't
> Arnd trying to get rid of PCMCIA via "[RFC 0/6] pcmcia: separate 16-bit
> support from cardbus"?
>
> Maybe those two drivers get solved for you :)

That would be great :)

>> > Also isn't Greg KH out to kill RNDIS too? I don't recall that being
>> > a
>> > settled question yet, but I lost track.
>> 
>> I haven't heard anything about that recently, I hope we don't have to
>> remove rndis_wlan from the tree. But wext drivers are another thing,
>> we
>> really should get rid of them (or convert to cfg80211).
>
> I have vague, morbid interest in converting atmel and prism54 to
> cfg80211 but timeline on that would be "this year".

As you already noticed, prism54 is already gone. But I'm keeping fingers
crossed that who you would have time to convert atmel :)

We really should get rid of wext, at least from drivers/net/wireless.
Staging drivers are of course of another thing. Just for fun I decided
to grep how many wext drivers and the first match was an ethernet
driver, weird:

drivers/net/ethernet/toshiba/ps3_gelic_wireless.c:2570: netdev->wireless_handlers = &gelic_wl_wext_handler_def;

These are the mainline drivers using wext:

drivers/net/wireless/atmel/atmel.c:1574:	dev->wireless_handlers = &atmel_handler_def;
drivers/net/wireless/cisco/airo.c:2674:	dev->wireless_handlers = &airo_handler_def;
drivers/net/wireless/cisco/airo.c:2828:	dev->wireless_handlers = &airo_handler_def;
drivers/net/wireless/intel/ipw2x00/ipw2100.c:6032:	dev->wireless_handlers = &ipw2100_wx_handler_def;
drivers/net/wireless/intel/ipw2x00/ipw2200.c:11675:	net_dev->wireless_handlers = &ipw_wx_handler_def;
drivers/net/wireless/intersil/hostap/hostap_main.c:851:	dev->wireless_handlers = &hostap_iw_handler_def;
drivers/net/wireless/intersil/orinoco/main.c:2251:	dev->wireless_handlers = &orinoco_handler_def;
drivers/net/wireless/ray_cs.c:303:	dev->wireless_handlers = &ray_handler_def;
drivers/net/wireless/wl3501_cs.c:1886:	dev->wireless_handlers	= &wl3501_handler_def;
drivers/net/wireless/zydas/zd1201.c:1782:	dev->wireless_handlers = &zd1201_iw_handlers;

And these are the staging drivers:

drivers/staging/ks7010/ks_wlan_net.c:2636:	dev->wireless_handlers = &ks_wlan_handler_def;
drivers/staging/r8188eu/os_dep/os_intfs.c:358:	pnetdev->wireless_handlers = (struct iw_handler_def *)&rtw_handlers_def;
drivers/staging/rtl8192e/rtl8192e/rtl_core.c:2334:	dev->wireless_handlers = &r8192_wx_handlers_def;
drivers/staging/rtl8192u/r8192U_core.c:4532:	dev->wireless_handlers = &r8192_wx_handlers_def;
drivers/staging/rtl8712/os_intfs.c:214:	pnetdev->wireless_handlers = (struct iw_handler_def *)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
