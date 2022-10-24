Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3987609E51
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Oct 2022 11:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiJXJuC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Oct 2022 05:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJXJuA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Oct 2022 05:50:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70122495B
        for <linux-wireless@vger.kernel.org>; Mon, 24 Oct 2022 02:49:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66BC861128
        for <linux-wireless@vger.kernel.org>; Mon, 24 Oct 2022 09:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD785C433D6;
        Mon, 24 Oct 2022 09:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666604997;
        bh=fXposAJhPgxOUojoYHaqgEPPCjMMbUFD/bBUECimKMQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=acsZYmBtohqETJ94FXuV07V/GEUDhc29Yu36Dmk9PcmLV3+UeftXxr4rONA36oo7y
         IT9Gh145VMkyRTyYKKoCvhSyax/NTHmNO0UlAJpyIMc/4RHMB8Cz5ASPiai0Iaj92v
         TX4BjlN29Kx42s04kQoKWWBTHeg/Hu9GftuXZBZ+seb6FT8V48MwUcqAbBMHY5hMDU
         0W8LqKd9mIITCB+wR//xYn+iphC6iv1CJB3vH5vShCDCTCrHfQ2WJLW3B+0/Q7cs2m
         H1U2X+TrlUK8/EUKFBj4I36jA0YBmRkA6BlQmyWjXUKS6uw3LDR4N3CQQAIyTY6Tw0
         4LlS+AfA2k/bw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Arend van Spriel <aspriel@gmail.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        arend.vanspriel@broadcom.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: cfg80211: fix memory leak in query_regdb_file()
References: <CAJ65rDzroYUFnPuzH54dFB1fAYPynDrTZYy-fF72E=Y_bFER-g@mail.gmail.com>
Date:   Mon, 24 Oct 2022 12:49:50 +0300
In-Reply-To: <CAJ65rDzroYUFnPuzH54dFB1fAYPynDrTZYy-fF72E=Y_bFER-g@mail.gmail.com>
        (Arend van Spriel's message of "Wed, 19 Oct 2022 04:44:18 -0700")
Message-ID: <87v8o9zh35.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arend van Spriel <aspriel@gmail.com> writes:

> In the function query_regdb_file() the alpha2 parameter is duplicated
> using kmemdup() and subsequently freed in regdb_fw_cb(). However,
> request_firmware_nowait() can fail without calling regdb_fw_cb() and
> thus leak memory.
>
> Fixes: 007f6c5e6eb4 ("cfg80211: support loading regulatory database as
> firmware file")

The fixes tag should be in one line.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
