Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A6F516337
	for <lists+linux-wireless@lfdr.de>; Sun,  1 May 2022 10:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbiEAI50 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 May 2022 04:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiEAI5Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 May 2022 04:57:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4A45AECD
        for <linux-wireless@vger.kernel.org>; Sun,  1 May 2022 01:54:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED61F60C75
        for <linux-wireless@vger.kernel.org>; Sun,  1 May 2022 08:54:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D76C385A9;
        Sun,  1 May 2022 08:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651395240;
        bh=+kU6kOUuw94usu/k6LsB4IoClg4CaG7URNSjEPAuMWs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=NvaaAo3VBRSN9frk4QkkbpRP1dEyouYa6qXxi1SX54alAyU5djRHX6VDGtZ7SA+nI
         R9ju1ios3CIPHDxc+e/rjwO9xe8p0+3VziX8IdI0C7RZTI/edu/FgJaQlKZ9jJMeIg
         kVIlbHSoyITK7kOyX9vfP+dZj5SwOKQHQzAHiafXF+OiLxPGi/NjEpPH0DN/cKXO6x
         F0aU9/LeimUmlJ/ufNkjP5Ue576fDRT0UehKfAno7TX3xMoeDmXKrlyvvnZLSDzyPk
         CJLROl7Zr+0LG8N4B6AXBHDvdWJnN3+bsmuDdwhGe94XDDwHbDY5ddf07707rMtfZM
         9u0SEA1AKK/Og==
From:   Kalle Valo <kvalo@kernel.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     =?utf-8?B?SsOpcsO0bWU=?= Pouiller <jerome.pouiller@silabs.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wfx: avoid flush_workqueue(system_highpri_wq) usage
References: <20220225112405.355599-1-Jerome.Pouiller@silabs.com>
        <20220225112405.355599-10-Jerome.Pouiller@silabs.com>
        <033f49bc-cc31-7384-7a7c-5d3c45ce9594@I-love.SAKURA.ne.jp>
        <4557835.LvFx2qVVIh@pc-42>
        <e25078f4-96f4-482c-b5da-a4a22d88b072@I-love.SAKURA.ne.jp>
Date:   Sun, 01 May 2022 11:53:57 +0300
In-Reply-To: <e25078f4-96f4-482c-b5da-a4a22d88b072@I-love.SAKURA.ne.jp>
        (Tetsuo Handa's message of "Sun, 1 May 2022 15:01:40 +0900")
Message-ID: <87fsltd462.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> writes:

> Flushing system-wide workqueues is dangerous and will be forbidden.
> Replace system_highpri_wq with local wfx_wq.
>
> While we are at it, add missing spi_unregister_driver() call when
> sdio_register_driver() failed.
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[...]

> @@ -473,10 +475,18 @@ static int __init wfx_core_init(void)
>  {
>  	int ret = 0;
>  
> +	wfx_wq = alloc_workqueue("wfx_wq", WQ_HIGHPRI, 0);
> +	if (!wfx_wq)
> +		return -ENOMEM;
>  	if (IS_ENABLED(CONFIG_SPI))
>  		ret = spi_register_driver(&wfx_spi_driver);
>  	if (IS_ENABLED(CONFIG_MMC) && !ret)
>  		ret = sdio_register_driver(&wfx_sdio_driver);
> +	if (ret) {
> +		if (IS_ENABLED(CONFIG_SPI))
> +			spi_unregister_driver(&wfx_spi_driver);
> +		destroy_workqueue(wfx_wq);
> +	}
>  	return ret;
>  }
>  module_init(wfx_core_init);

So now the thread is created every time the module loaded, even if
there's no device available. Also I'm not really a fan of global
variables (wfx_wq). I would rather create a workqueue per device in
wfx_probe() or use the workqueue provided by mac80211.

/**
 * ieee80211_queue_work - add work onto the mac80211 workqueue
 *
 * Drivers and mac80211 use this to add work onto the mac80211 workqueue.
 * This helper ensures drivers are not queueing work when they should not be.
 *
 * @hw: the hardware struct for the interface we are adding work for
 * @work: the work we want to add onto the mac80211 workqueue
 */
void ieee80211_queue_work(struct ieee80211_hw *hw, struct work_struct *work);

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
