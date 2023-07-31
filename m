Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA02769241
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Jul 2023 11:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjGaJtH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Jul 2023 05:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjGaJsN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Jul 2023 05:48:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A67171B
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jul 2023 02:47:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD7DC60FE8
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jul 2023 09:47:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D7FC433C9;
        Mon, 31 Jul 2023 09:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690796852;
        bh=hkkLDr8fpHT6F4F+trLj8HXkwnAA/LsySrwB8tUPCKc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=kOOQW/TmVv7tdWBYUkVfO6FxnkiWdYktBbmYFSnOBovU7u+3m+udG6lWFDHxwx7jw
         PVsBV2mCqd/uKihYxTsQUpc/Ds6Iwt4zxKNhjgTtse8z4QfT77iTekM7tMqCecU+rM
         M7FEz7m6dKJ1pDvy6mPLwBZ2b+qBncRaMp3qNn3wz480F0yFHAHvSnDWDBnd9EP0Ml
         68ufVZjBEFzEJiKVW2vSw4lXtEKBIdqYmF1QYSzeD+0ElO1mwOh7tc1pnU41MUBawC
         SmsF80SYQOO0zKvUXn+/fctQ3cNDFfEdL05UyhK416ue1JVtj8CSR+cGGvdfTohfg2
         4m/bE/dCRpvHg==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Antipov, Dmitriy" <Dmitriy.Antipov@softline.com>
Cc:     "dmantipov@yandex.ru" <dmantipov@yandex.ru>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [lvc-project] [PATCH 1/5] wifi: mwifiex: fix memory leak in
 mwifiex_histogram_read()
References: <20230726072114.51964-1-dmantipov@yandex.ru>
        <ZMFzBStAKemf+dLL@google.com>
        <72372d59ccbc70ea322962158d066597c2c9fbe7.camel@softline.com>
Date:   Mon, 31 Jul 2023 12:47:28 +0300
In-Reply-To: <72372d59ccbc70ea322962158d066597c2c9fbe7.camel@softline.com>
        (Dmitriy Antipov's message of "Fri, 28 Jul 2023 09:29:34 +0000")
Message-ID: <878rawza33.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Antipov, Dmitriy" <Dmitriy.Antipov@softline.com> writes:

> On Wed, 2023-07-26 at 12:24 -0700, Brian Norris wrote:
>
>
>> I had comments for patch 2. Patch 1, 3, 4, 5 look good:
>> 
>> Acked-by: Brian Norris <briannorris@chromium.org>
>
> Should I add Acked-by: <you> to all of the above in case
> of resend without changes, or leave it to the maintainer?

Adding Brian's Acked-by to patches 1, 3, 4, 5 is a good idea as long as
you don't change those patches. But no need to resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
